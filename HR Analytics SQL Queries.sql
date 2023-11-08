--Employee Count--
SELECT SUM(employee_count)
FROM hrdata;

--Attrition Count--
SELECT COUNT(attrition)
FROM hrdata
WHERE attrition = 'Yes';

--Attrition Rate--
SELECT 
ROUND(((SELECT COUNT(attrition) FROM hrdata WHERE attrition = 'Yes')/ 
SUM(employee_count)) * 100, 2)
FROM hrdata;

--Active Employee--
SELECT SUM(employee_count) - (SELECT COUNT(attrition) FROM hrdata WHERE attrition = 'Yes')
FROM hrdata;

--Average Age--
SELECT ROUND(AVG(age), 0)
FROM hrdata;

--Attrition by Gender--
SELECT gender, COUNT(attrition) AS attrition_count
FROM hrdata
WHERE attrition = 'Yes'
GROUP BY gender
ORDER BY COUNT(attrition) DESC;

--Department wise Attrition--
SELECT department, COUNT(attrition), ROUND((CAST(COUNT(attrition) AS numeric) / 
(SELECT COUNT(attrition) FROM hrdata WHERE attrition= 'Yes')) * 100, 2) AS pct 
FROM hrdata
WHERE attrition='Yes'
GROUP BY department 
ORDER BY COUNT(attrition) DESC;

--No. of Employees by Age Group--
SELECT age, SUM(employee_count) AS employee_count 
FROM hrdata
GROUP BY age
ORDER BY age;

--Education Field wise Attrition--
SELECT education_field, COUNT(attrition) AS attrition_count
FROM hrdata
WHERE attrition = 'Yes'
GROUP BY education_field
ORDER BY count(attrition) DESC;

--Attrition Rate by Gender for Different Age Group--
SELECT age_band, gender, COUNT(attrition) AS attrition, 
ROUND((CAST(COUNT(attrition) AS numeric) / (SELECT COUNT(attrition) FROM hrdata WHERE attrition = 'Yes')) * 100,2) AS pct
FROM hrdata
WHERE attrition = 'Yes'
GROUP BY age_band, gender
ORDER BY age_band, gender DESC;

--Job Satistfaction Rating--
CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT *
FROM crosstab(
  'SELECT job_role, job_satisfaction, sum(employee_count)
   FROM hrdata
   GROUP BY job_role, job_satisfaction
   ORDER BY job_role, job_satisfaction'
	) AS ct(job_role varchar(50), one numeric, two numeric, three numeric, four numeric)
ORDER BY job_role;

