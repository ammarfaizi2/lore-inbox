Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264201AbTFKUXX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTFKUXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:23:23 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:17906 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264455AbTFKUVL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:21:11 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10553638061092@kroah.com>
Subject: Re: [PATCH] More i2c driver changes for 2.5.70
In-Reply-To: <10553638063543@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 11 Jun 2003 13:36:46 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1419.1.8, 2003/06/11 12:29:42-07:00, greg@kroah.com

[PATCH] I2C: fix up sparse warnings in the i2c-dev driver


 drivers/i2c/i2c-dev.c   |   10 +++++-----
 include/linux/i2c-dev.h |    6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)


diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Wed Jun 11 13:24:43 2003
+++ b/drivers/i2c/i2c-dev.c	Wed Jun 11 13:24:43 2003
@@ -122,7 +122,7 @@
 }
 static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
 
-static ssize_t i2cdev_read (struct file *file, char *buf, size_t count,
+static ssize_t i2cdev_read (struct file *file, char __user *buf, size_t count,
                             loff_t *offset)
 {
 	char *tmp;
@@ -147,7 +147,7 @@
 	return ret;
 }
 
-static ssize_t i2cdev_write (struct file *file, const char *buf, size_t count,
+static ssize_t i2cdev_write (struct file *file, const char __user *buf, size_t count,
                              loff_t *offset)
 {
 	int ret;
@@ -211,12 +211,12 @@
 		return 0;
 	case I2C_FUNCS:
 		funcs = i2c_get_functionality(client->adapter);
-		return (copy_to_user((unsigned long *)arg,&funcs,
+		return (copy_to_user((unsigned long __user *)arg, &funcs,
 		                     sizeof(unsigned long)))?-EFAULT:0;
 
         case I2C_RDWR:
 		if (copy_from_user(&rdwr_arg, 
-				   (struct i2c_rdwr_ioctl_data *)arg, 
+				   (struct i2c_rdwr_ioctl_data __user *)arg, 
 				   sizeof(rdwr_arg)))
 			return -EFAULT;
 
@@ -284,7 +284,7 @@
 
 	case I2C_SMBUS:
 		if (copy_from_user(&data_arg,
-		                   (struct i2c_smbus_ioctl_data *) arg,
+		                   (struct i2c_smbus_ioctl_data __user *) arg,
 		                   sizeof(struct i2c_smbus_ioctl_data)))
 			return -EFAULT;
 		if ((data_arg.size != I2C_SMBUS_BYTE) && 
diff -Nru a/include/linux/i2c-dev.h b/include/linux/i2c-dev.h
--- a/include/linux/i2c-dev.h	Wed Jun 11 13:24:43 2003
+++ b/include/linux/i2c-dev.h	Wed Jun 11 13:24:43 2003
@@ -34,13 +34,13 @@
 	__u8 read_write;
 	__u8 command;
 	__u32 size;
-	union i2c_smbus_data *data;
+	union i2c_smbus_data __user *data;
 };
 
 /* This is the structure as used in the I2C_RDWR ioctl call */
 struct i2c_rdwr_ioctl_data {
-	struct i2c_msg *msgs;	/* pointers to i2c_msgs */
-	__u32 nmsgs;		/* number of i2c_msgs */
+	struct i2c_msg __user *msgs;	/* pointers to i2c_msgs */
+	__u32 nmsgs;			/* number of i2c_msgs */
 };
 
 #endif /* _LINUX_I2C_DEV_H */

