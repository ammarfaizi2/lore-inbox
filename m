Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262889AbUCPAJM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbUCPAJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:09:08 -0500
Received: from mail.kroah.org ([65.200.24.183]:13999 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262889AbUCPACL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:11 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913932181@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:33 -0800
Message-Id: <10793913932514@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.74.4, 2004/03/09 14:59:03-08:00, mhoffman@lightlink.com

[PATCH] I2C: sysfs interface update for w83627hf

This patch updates the sysfs names of the w83627hf driver
to match the new standard.  The patch applies on top of
one recently applied to your tree [1].  I have tested it
using a w83627thf & the latest lm_sensors CVS.  Please apply.

[1] http://archives.andrew.net.au/lm-sensors/msg06746.html


 drivers/i2c/chips/w83627hf.c |   60 +++++++++++++++++++++----------------------
 1 files changed, 30 insertions(+), 30 deletions(-)


diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	Mon Mar 15 14:35:00 2004
+++ b/drivers/i2c/chips/w83627hf.c	Mon Mar 15 14:35:00 2004
@@ -294,10 +294,10 @@
 	u8 fan_min[3];		/* Register value */
 	u8 temp;
 	u8 temp_max;		/* Register value */
-	u8 temp_hyst;		/* Register value */
+	u8 temp_max_hyst;	/* Register value */
 	u16 temp_add[2];	/* Register value */
 	u16 temp_max_add[2];	/* Register value */
-	u16 temp_hyst_add[2];	/* Register value */
+	u16 temp_max_hyst_add[2]; /* Register value */
 	u8 fan_div[3];		/* Register encoding, shifted right */
 	u8 vid;			/* Register encoding, combined */
 	u32 alarms;		/* Register encoding, combined */
@@ -373,7 +373,7 @@
 { \
         return show_in(dev, buf, 0x##offset); \
 } \
-static DEVICE_ATTR(in_input##offset, S_IRUGO, show_regs_in_##offset, NULL)
+static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL)
 
 #define sysfs_in_reg_offset(reg, offset) \
 static ssize_t show_regs_in_##reg##offset (struct device *dev, char *buf) \
@@ -386,7 +386,7 @@
 { \
 	return store_in_##reg (dev, buf, count, 0x##offset); \
 } \
-static DEVICE_ATTR(in_##reg##offset, S_IRUGO| S_IWUSR, \
+static DEVICE_ATTR(in##offset##_##reg, S_IRUGO| S_IWUSR, \
 		  show_regs_in_##reg##offset, store_regs_in_##reg##offset)
 
 #define sysfs_in_offsets(offset) \
@@ -406,9 +406,9 @@
 
 #define device_create_file_in(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_in_input##offset); \
-device_create_file(&client->dev, &dev_attr_in_min##offset); \
-device_create_file(&client->dev, &dev_attr_in_max##offset); \
+device_create_file(&client->dev, &dev_attr_in##offset##_input); \
+device_create_file(&client->dev, &dev_attr_in##offset##_min); \
+device_create_file(&client->dev, &dev_attr_in##offset##_max); \
 } while (0)
 
 #define show_fan_reg(reg) \
@@ -447,7 +447,7 @@
 { \
 	return show_fan(dev, buf, 0x##offset); \
 } \
-static DEVICE_ATTR(fan_input##offset, S_IRUGO, show_regs_fan_##offset, NULL)
+static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_regs_fan_##offset, NULL)
 
 #define sysfs_fan_min_offset(offset) \
 static ssize_t show_regs_fan_min##offset (struct device *dev, char *buf) \
@@ -459,7 +459,7 @@
 { \
 	return store_fan_min(dev, buf, count, 0x##offset); \
 } \
-static DEVICE_ATTR(fan_min##offset, S_IRUGO | S_IWUSR, \
+static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, \
 		  show_regs_fan_min##offset, store_regs_fan_min##offset)
 
 sysfs_fan_offset(1)
@@ -471,8 +471,8 @@
 
 #define device_create_file_fan(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_fan_input##offset); \
-device_create_file(&client->dev, &dev_attr_fan_min##offset); \
+device_create_file(&client->dev, &dev_attr_fan##offset##_input); \
+device_create_file(&client->dev, &dev_attr_fan##offset##_min); \
 } while (0)
 
 #define show_temp_reg(reg) \
@@ -492,7 +492,7 @@
 }
 show_temp_reg(temp)
 show_temp_reg(temp_max)
-show_temp_reg(temp_hyst)
+show_temp_reg(temp_max_hyst)
 
 #define store_temp_reg(REG, reg) \
 static ssize_t \
@@ -517,7 +517,7 @@
 	return count; \
 }
 store_temp_reg(OVER, max)
-store_temp_reg(HYST, hyst)
+store_temp_reg(HYST, max_hyst)
 
 #define sysfs_temp_offset(offset) \
 static ssize_t \
@@ -525,7 +525,7 @@
 { \
 	return show_temp(dev, buf, 0x##offset); \
 } \
-static DEVICE_ATTR(temp_input##offset, S_IRUGO, show_regs_temp_##offset, NULL)
+static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_regs_temp_##offset, NULL)
 
 #define sysfs_temp_reg_offset(reg, offset) \
 static ssize_t show_regs_temp_##reg##offset (struct device *dev, char *buf) \
@@ -538,13 +538,13 @@
 { \
 	return store_temp_##reg (dev, buf, count, 0x##offset); \
 } \
-static DEVICE_ATTR(temp_##reg##offset, S_IRUGO| S_IWUSR, \
+static DEVICE_ATTR(temp##offset##_##reg, S_IRUGO| S_IWUSR, \
 		  show_regs_temp_##reg##offset, store_regs_temp_##reg##offset)
 
 #define sysfs_temp_offsets(offset) \
 sysfs_temp_offset(offset) \
 sysfs_temp_reg_offset(max, offset) \
-sysfs_temp_reg_offset(hyst, offset)
+sysfs_temp_reg_offset(max_hyst, offset)
 
 sysfs_temp_offsets(1)
 sysfs_temp_offsets(2)
@@ -552,9 +552,9 @@
 
 #define device_create_file_temp(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_temp_input##offset); \
-device_create_file(&client->dev, &dev_attr_temp_max##offset); \
-device_create_file(&client->dev, &dev_attr_temp_hyst##offset); \
+device_create_file(&client->dev, &dev_attr_temp##offset##_input); \
+device_create_file(&client->dev, &dev_attr_temp##offset##_max); \
+device_create_file(&client->dev, &dev_attr_temp##offset##_max_hyst); \
 } while (0)
 
 static ssize_t
@@ -567,9 +567,9 @@
 
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
 }
-static DEVICE_ATTR(vid, S_IRUGO, show_vid_reg, NULL)
+static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid_reg, NULL)
 #define device_create_file_vid(client) \
-device_create_file(&client->dev, &dev_attr_vid)
+device_create_file(&client->dev, &dev_attr_in0_ref)
 
 static ssize_t
 show_vrm_reg(struct device *dev, char *buf)
@@ -734,7 +734,7 @@
 { \
 	return store_fan_div_reg(dev, buf, count, offset); \
 } \
-static DEVICE_ATTR(fan_div##offset, S_IRUGO | S_IWUSR, \
+static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, \
 		  show_regs_fan_div_##offset, store_regs_fan_div_##offset)
 
 sysfs_fan_div(1)
@@ -743,7 +743,7 @@
 
 #define device_create_file_fan_div(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_fan_div##offset); \
+device_create_file(&client->dev, &dev_attr_fan##offset##_div); \
 } while (0)
 
 static ssize_t
@@ -794,7 +794,7 @@
 { \
 	return store_pwm_reg(dev, buf, count, offset); \
 } \
-static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR, \
+static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR, \
 		  show_regs_pwm_##offset, store_regs_pwm_##offset)
 
 sysfs_pwm(1)
@@ -803,7 +803,7 @@
 
 #define device_create_file_pwm(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_pwm##offset); \
+device_create_file(&client->dev, &dev_attr_fan##offset##_pwm); \
 } while (0)
 
 static ssize_t
@@ -871,7 +871,7 @@
 { \
     return store_sensor_reg(dev, buf, count, offset); \
 } \
-static DEVICE_ATTR(sensor##offset, S_IRUGO | S_IWUSR, \
+static DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR, \
 		  show_regs_sensor_##offset, store_regs_sensor_##offset)
 
 sysfs_sensor(1)
@@ -880,7 +880,7 @@
 
 #define device_create_file_sensor(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_sensor##offset); \
+device_create_file(&client->dev, &dev_attr_temp##offset##_type); \
 } while (0)
 
 
@@ -1319,20 +1319,20 @@
 		data->temp = w83627hf_read_value(client, W83781D_REG_TEMP(1));
 		data->temp_max =
 		    w83627hf_read_value(client, W83781D_REG_TEMP_OVER(1));
-		data->temp_hyst =
+		data->temp_max_hyst =
 		    w83627hf_read_value(client, W83781D_REG_TEMP_HYST(1));
 		data->temp_add[0] =
 		    w83627hf_read_value(client, W83781D_REG_TEMP(2));
 		data->temp_max_add[0] =
 		    w83627hf_read_value(client, W83781D_REG_TEMP_OVER(2));
-		data->temp_hyst_add[0] =
+		data->temp_max_hyst_add[0] =
 		    w83627hf_read_value(client, W83781D_REG_TEMP_HYST(2));
 		if (data->type != w83697hf) {
 			data->temp_add[1] =
 			  w83627hf_read_value(client, W83781D_REG_TEMP(3));
 			data->temp_max_add[1] =
 			  w83627hf_read_value(client, W83781D_REG_TEMP_OVER(3));
-			data->temp_hyst_add[1] =
+			data->temp_max_hyst_add[1] =
 			  w83627hf_read_value(client, W83781D_REG_TEMP_HYST(3));
 		}
 

