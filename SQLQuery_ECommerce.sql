SELECT *
FROM dbo.ecommerce_data

--Overview of superstore sales dataset
SELECT
COUNT(order_id) AS Total_oreders,
SUM(sales) AS Total_sales,
SUM(quantity) AS Total_quantity,
AVG(profit) AS Avg_profit,
AVG(discount) AS Avg_discount,
COUNT(DISTINCT product_name) AS Total_products,
COUNT(DISTINCT category) AS Total_category,
COUNT(DISTINCT YEAR(order_date)) AS Total_year,
COUNT(DISTINCT country) AS Total_country
FROM dbo.ecommerce_data

-- Sales performance analysis

--Identify the top-selling products and categories
SELECT TOP(10) category, product_name,
SUM(sales) AS Total_sales,
SUM(quantity) AS Total_quantity
FROM dbo.ecommerce_data
GROUP BY category, product_name
ORDER BY SUM(sales) DESC

--Identify the products and categories has the lowest sale.
SELECT TOP(10) category, product_name,
SUM(sales) AS Total_sales,
SUM(quantity) AS Total_quantity
FROM dbo.ecommerce_data
GROUP BY category, product_name
ORDER BY SUM(sales) ASC

--Top 5 most Ordered Products
SELECT TOP(10) category, product_name,
SUM(quantity) AS Total_quantity
FROM dbo.ecommerce_data
GROUP BY category, product_name
ORDER BY SUM(quantity) DESC

--sales over year 

ALTER TABLE ecommerce_data
ADD Year int;

UPDATE ecommerce_data
SET Year = YEAR(order_date)

SELECT 
year,
SUM(sales) AS Total_sales
FROM dbo.ecommerce_data
GROUP BY year
ORDER BY SUM(sales) DESC

-- Customer segmentation
SELECT customer_first_name +' '+ customer_last_name AS customer_name
FROM dbo.ecommerce_data

ALTER TABLE ecommerce_data
ADD customer_name varchar(50);

UPDATE ecommerce_data
SET customer_name = customer_first_name +' '+ customer_last_name 

SELECT segment,
COUNT(DISTINCT customer_name) AS Total_cus,
SUM(sales) AS Total_sales
FROM dbo.ecommerce_data
GROUP BY segment
ORDER BY SUM(sales) DESC

-- Most valuable customers based on their total order value.
SELECT TOP(10)
customer_name,
SUM(sales) AS Total_sales
FROM dbo.ecommerce_data
GROUP BY 
customer_name
ORDER BY SUM(sales) DESC

-- Profibility and cost analysis
SELECT
product_name,
category,
AVG(profit) AS Avg_profit,
AVG(discount) AS Avg_discount
FROM dbo.ecommerce_data
GROUP BY 
product_name,
category
ORDER BY AVG(profit) DESC

-- State sales and quantity product overview 
SELECT
state,
SUM(sales) AS Total_sales,
SUM(quantity)  AS Total_quantity
FROM dbo.ecommerce_data
GROUP BY state
ORDER BY SUM(sales) DESC

-- state level category exploration
SELECT 
state,
category,
SUM(quantity) AS Total_quantity_sold
FROM dbo.ecommerce_data
GROUP BY 
state,
category
ORDER BY SUM(quantity) DESC

-- Regional subcategory analysis
SELECT
region,
category,
SUM(quantity) AS Total_quantity_sold
FROM dbo.ecommerce_data
GROUP BY region,
category
ORDER BY SUM(quantity) DESC

--Total Sales per City
SELECT
city,
category,
SUM(quantity) AS Total_quantity_sold
FROM dbo.ecommerce_data
GROUP BY city,
category
ORDER BY SUM(quantity) DESC