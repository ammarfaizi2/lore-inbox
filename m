Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVAWE05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVAWE05 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 23:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVAWE0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 23:26:39 -0500
Received: from soundwarez.org ([217.160.171.123]:18315 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261214AbVAWEZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 23:25:34 -0500
Date: Sun, 23 Jan 2005 05:25:33 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 5/7] i2c: class driver pass dev_t to the class core
Message-ID: <20050123042533.GA9256@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

===== drivers/i2c/i2c-dev.c 1.50 vs edited =====
--- 1.50/drivers/i2c/i2c-dev.c	2005-01-21 06:02:15 +01:00
+++ edited/drivers/i2c/i2c-dev.c	2005-01-22 15:17:50 +01:00
@@ -108,13 +108,6 @@ static void return_i2c_dev(struct i2c_de
 	spin_unlock(&i2c_dev_array_lock);
 }
 
-static ssize_t show_dev(struct class_device *class_dev, char *buf)
-{
-	struct i2c_dev *i2c_dev = to_i2c_dev(class_dev);
-	return print_dev_t(buf, MKDEV(I2C_MAJOR, i2c_dev->minor));
-}
-static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
-
 static ssize_t show_adapter_name(struct class_device *class_dev, char *buf)
 {
 	struct i2c_dev *i2c_dev = to_i2c_dev(class_dev);
@@ -451,11 +444,11 @@ static int i2cdev_attach_adapter(struct 
 	else
 		i2c_dev->class_dev.dev = adap->dev.parent;
 	i2c_dev->class_dev.class = &i2c_dev_class;
+	i2c_dev->class_dev.devt = MKDEV(I2C_MAJOR, i2c_dev->minor);
 	snprintf(i2c_dev->class_dev.class_id, BUS_ID_SIZE, "i2c-%d", i2c_dev->minor);
 	retval = class_device_register(&i2c_dev->class_dev);
 	if (retval)
 		goto error;
-	class_device_create_file(&i2c_dev->class_dev, &class_device_attr_dev);
 	class_device_create_file(&i2c_dev->class_dev, &class_device_attr_name);
 	return 0;
 error:

