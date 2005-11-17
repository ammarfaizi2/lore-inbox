Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbVKQTKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbVKQTKb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbVKQTKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:10:31 -0500
Received: from [63.240.77.84] ([63.240.77.84]:52164 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S932501AbVKQTKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:10:31 -0500
Date: Thu, 17 Nov 2005 11:09:53 -0800
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix IXP4xx I2C driver build breakage
Message-ID: <20051117190952.GA24121@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Platform device conversion missed a couple of spots.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

diff --git a/drivers/i2c/busses/i2c-ixp4xx.c b/drivers/i2c/busses/i2c-ixp4xx.c
index aa36855..f87220b 100644
--- a/drivers/i2c/busses/i2c-ixp4xx.c
+++ b/drivers/i2c/busses/i2c-ixp4xx.c
@@ -35,7 +35,7 @@
 
 #include <asm/hardware.h>	/* Pick up IXP4xx-specific bits */
 
-static struct device_driver ixp4xx_i2c_driver;
+static struct platform_driver ixp4xx_i2c_driver;
 
 static inline int ixp4xx_scl_pin(void *data)
 {
@@ -128,7 +128,7 @@ static int ixp4xx_i2c_probe(struct platf
 	drv_data->algo_data.timeout = 100;
 
 	drv_data->adapter.id = I2C_HW_B_IXP4XX;
-	strlcpy(drv_data->adapter.name, ixp4xx_i2c_driver.name,
+	strlcpy(drv_data->adapter.name, ixp4xx_i2c_driver.driver.name,
 		I2C_NAME_SIZE);
 	drv_data->adapter.algo_data = &drv_data->algo_data;
 
@@ -140,7 +140,8 @@ static int ixp4xx_i2c_probe(struct platf
 	gpio_line_set(gpio->sda_pin, 0);
 
 	if ((err = i2c_bit_add_bus(&drv_data->adapter) != 0)) {
-		printk(KERN_ERR "ERROR: Could not install %s\n", dev->bus_id);
+		printk(KERN_ERR "ERROR: Could not install %s\n", 
+				plat_dev->dev.bus_id);
 
 		kfree(drv_data);
 		return err;


-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

"To question your government is not unpatriotic - to not question your
 government is unpatriotic." -  Senator Chuck Hagel (R-NE) - Nov 15, 2005
