Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265734AbUA0XjH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 18:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265422AbUA0Xh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 18:37:26 -0500
Received: from mail.kroah.org ([65.200.24.183]:35263 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264925AbUA0XeO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 18:34:14 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.2-rc2
In-Reply-To: <10752464532280@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 27 Jan 2004 15:34:13 -0800
Message-Id: <1075246453781@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.148.5, 2004/01/27 14:38:29-08:00, khali@linux-fr.org

[PATCH] I2C: Bring lm75 and lm78 in compliance with sysfs naming conventions

Here is a patch that brings the lm75 and lm78 drivers in compliance with
sysfs naming conventions. The drivers as found in existing 2.6 kernels
do not have a digit appended to the temperature-related files names as
the sysfs naming conversion recommends (obviously because they each have
a single temperature channel). As a result, libsensors won't find the
files.

It was discussed on the list wether a '1' should be appended in this
case, and our conclusion was that it would be better to do so because it
helps automatic processing of the sysfs exported files. Please apply if
you agree with this.


 drivers/i2c/chips/lm75.c |   12 ++++++------
 drivers/i2c/chips/lm78.c |   12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)


diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Tue Jan 27 15:26:46 2004
+++ b/drivers/i2c/chips/lm75.c	Tue Jan 27 15:26:46 2004
@@ -104,9 +104,9 @@
 set(temp_max, LM75_REG_TEMP_OS);
 set(temp_hyst, LM75_REG_TEMP_HYST);
 
-static DEVICE_ATTR(temp_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
-static DEVICE_ATTR(temp_hyst, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
-static DEVICE_ATTR(temp_input, S_IRUGO, show_temp_input, NULL);
+static DEVICE_ATTR(temp_max1, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
+static DEVICE_ATTR(temp_hyst1, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
+static DEVICE_ATTR(temp_input1, S_IRUGO, show_temp_input, NULL);
 
 static int lm75_attach_adapter(struct i2c_adapter *adapter)
 {
@@ -197,9 +197,9 @@
 	lm75_init_client(new_client);
 	
 	/* Register sysfs hooks */
-	device_create_file(&new_client->dev, &dev_attr_temp_max);
-	device_create_file(&new_client->dev, &dev_attr_temp_hyst);
-	device_create_file(&new_client->dev, &dev_attr_temp_input);
+	device_create_file(&new_client->dev, &dev_attr_temp_max1);
+	device_create_file(&new_client->dev, &dev_attr_temp_hyst1);
+	device_create_file(&new_client->dev, &dev_attr_temp_input1);
 
 	return 0;
 
diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	Tue Jan 27 15:26:46 2004
+++ b/drivers/i2c/chips/lm78.c	Tue Jan 27 15:26:46 2004
@@ -369,10 +369,10 @@
 	return count;
 }
 
-static DEVICE_ATTR(temp_input, S_IRUGO, show_temp, NULL)
-static DEVICE_ATTR(temp_max, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(temp_input1, S_IRUGO, show_temp, NULL)
+static DEVICE_ATTR(temp_max1, S_IRUGO | S_IWUSR,
 		show_temp_over, set_temp_over)
-static DEVICE_ATTR(temp_hyst, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(temp_hyst1, S_IRUGO | S_IWUSR,
 		show_temp_hyst, set_temp_hyst)
 
 /* 3 Fans */
@@ -678,9 +678,9 @@
 	device_create_file(&new_client->dev, &dev_attr_in_input6);
 	device_create_file(&new_client->dev, &dev_attr_in_min6);
 	device_create_file(&new_client->dev, &dev_attr_in_max6);
-	device_create_file(&new_client->dev, &dev_attr_temp_input);
-	device_create_file(&new_client->dev, &dev_attr_temp_max);
-	device_create_file(&new_client->dev, &dev_attr_temp_hyst);
+	device_create_file(&new_client->dev, &dev_attr_temp_input1);
+	device_create_file(&new_client->dev, &dev_attr_temp_max1);
+	device_create_file(&new_client->dev, &dev_attr_temp_hyst1);
 	device_create_file(&new_client->dev, &dev_attr_fan_input1);
 	device_create_file(&new_client->dev, &dev_attr_fan_min1);
 	device_create_file(&new_client->dev, &dev_attr_fan_div1);

