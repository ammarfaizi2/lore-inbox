Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266129AbUHYWuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266129AbUHYWuF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266128AbUHYWrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:47:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:38299 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266467AbUHYWhF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:37:05 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9-rc1
In-Reply-To: <10934733881970@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Wed, 25 Aug 2004 15:36:28 -0700
Message-Id: <10934733882056@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1874, 2004/08/25 13:21:59-07:00, khali@linux-fr.org

[PATCH] I2C: rename in0_ref to cpu0_vid

This patch changes all the i2c chip drivers and documentation to use the
name "cpu0_vid" instead of "in0_ref". The name "in0_ref" was an error in
the first place as motherboard manufacturers may fail to follow the chip
manufacturer's recommendation about which "in" channel to use for VCore
monitoring.

The new name leaves room for chips able to monitor more than 1 vid
value, such as the LM93 and, to a lesser extent, the PC87360 family (all
by National Semiconductor). These chips are typically designed for
dual-CPU motherboards.

This breaks the interface (obviously) so libsensors has been updated to
support both names.


Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/i2c/sysfs-interface |    2 +-
 drivers/i2c/chips/asb100.c        |    4 ++--
 drivers/i2c/chips/it87.c          |    4 ++--
 drivers/i2c/chips/lm78.c          |    4 ++--
 drivers/i2c/chips/lm85.c          |    4 ++--
 drivers/i2c/chips/w83627hf.c      |    4 ++--
 drivers/i2c/chips/w83781d.c       |    4 ++--
 7 files changed, 13 insertions(+), 13 deletions(-)


diff -Nru a/Documentation/i2c/sysfs-interface b/Documentation/i2c/sysfs-interface
--- a/Documentation/i2c/sysfs-interface	2004-08-25 14:53:11 -07:00
+++ b/Documentation/i2c/sysfs-interface	2004-08-25 14:53:11 -07:00
@@ -104,7 +104,7 @@
 			in7_*	varies
 			in8_*	varies
 
-in0_ref		CPU core reference voltage.
+cpu[0-1]_vid	CPU core reference voltage.
 		Unit: millivolt
 		Read only.
 		Not always correct.
diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	2004-08-25 14:53:11 -07:00
+++ b/drivers/i2c/chips/asb100.c	2004-08-25 14:53:11 -07:00
@@ -520,9 +520,9 @@
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
 }
 
-static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid, NULL);
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 #define device_create_file_vid(client) \
-device_create_file(&client->dev, &dev_attr_in0_ref)
+device_create_file(&client->dev, &dev_attr_cpu0_vid)
 
 /* VRM */
 static ssize_t show_vrm(struct device *dev, char *buf)
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2004-08-25 14:53:11 -07:00
+++ b/drivers/i2c/chips/it87.c	2004-08-25 14:53:11 -07:00
@@ -571,9 +571,9 @@
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
 }
-static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid_reg, NULL);
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 #define device_create_file_vid(client) \
-device_create_file(&client->dev, &dev_attr_in0_ref)
+device_create_file(&client->dev, &dev_attr_cpu0_vid)
 
 /* This function is called when:
      * it87_driver is inserted (when this module is loaded), for each
diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	2004-08-25 14:53:11 -07:00
+++ b/drivers/i2c/chips/lm78.c	2004-08-25 14:53:11 -07:00
@@ -423,7 +423,7 @@
 	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", VID_FROM_REG(data->vid));
 }
-static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid, NULL);
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
 /* Alarms */
 static ssize_t show_alarms(struct device *dev, char *buf)
@@ -615,7 +615,7 @@
 	device_create_file(&new_client->dev, &dev_attr_fan3_min);
 	device_create_file(&new_client->dev, &dev_attr_fan3_div);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
-	device_create_file(&new_client->dev, &dev_attr_in0_ref);
+	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 
 	return 0;
 
diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	2004-08-25 14:53:11 -07:00
+++ b/drivers/i2c/chips/lm85.c	2004-08-25 14:53:11 -07:00
@@ -465,7 +465,7 @@
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
 }
 
-static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid_reg, NULL);
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 
 static ssize_t show_vrm_reg(struct device *dev, char *buf)
 {
@@ -874,7 +874,7 @@
 	device_create_file(&new_client->dev, &dev_attr_temp2_max);
 	device_create_file(&new_client->dev, &dev_attr_temp3_max);
 	device_create_file(&new_client->dev, &dev_attr_vrm);
-	device_create_file(&new_client->dev, &dev_attr_in0_ref);
+	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 
 	return 0;
diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	2004-08-25 14:53:11 -07:00
+++ b/drivers/i2c/chips/w83627hf.c	2004-08-25 14:53:11 -07:00
@@ -635,9 +635,9 @@
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
 }
-static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid_reg, NULL);
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 #define device_create_file_vid(client) \
-device_create_file(&client->dev, &dev_attr_in0_ref)
+device_create_file(&client->dev, &dev_attr_cpu0_vid)
 
 static ssize_t
 show_vrm_reg(struct device *dev, char *buf)
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	2004-08-25 14:53:11 -07:00
+++ b/drivers/i2c/chips/w83781d.c	2004-08-25 14:53:11 -07:00
@@ -503,9 +503,9 @@
 }
 
 static
-DEVICE_ATTR(in0_ref, S_IRUGO, show_vid_reg, NULL);
+DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 #define device_create_file_vid(client) \
-device_create_file(&client->dev, &dev_attr_in0_ref);
+device_create_file(&client->dev, &dev_attr_cpu0_vid);
 static ssize_t
 show_vrm_reg(struct device *dev, char *buf)
 {

