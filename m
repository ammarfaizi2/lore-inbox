Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbUCPARj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbUCPAQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:16:25 -0500
Received: from mail.kroah.org ([65.200.24.183]:18095 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262890AbUCPACR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:17 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913932709@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:33 -0800
Message-Id: <1079391393850@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1597.1.12, 2004/03/03 10:09:09-08:00, greg@kroah.com

[PATCH] I2C: show adapter name in i2c-dev class directory to make it easier for userspace tools.


 drivers/i2c/i2c-dev.c |    8 ++++++++
 1 files changed, 8 insertions(+)


diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Mon Mar 15 14:35:31 2004
+++ b/drivers/i2c/i2c-dev.c	Mon Mar 15 14:35:31 2004
@@ -124,6 +124,13 @@
 }
 static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
 
+static ssize_t show_adapter_name(struct class_device *class_dev, char *buf)
+{
+	struct i2c_dev *i2c_dev = to_i2c_dev(class_dev);
+	return sprintf(buf, "%s\n", i2c_dev->adap->name);
+}
+static CLASS_DEVICE_ATTR(name, S_IRUGO, show_adapter_name, NULL);
+
 static ssize_t i2cdev_read (struct file *file, char __user *buf, size_t count,
                             loff_t *offset)
 {
@@ -459,6 +466,7 @@
 	if (retval)
 		goto error;
 	class_device_create_file(&i2c_dev->class_dev, &class_device_attr_dev);
+	class_device_create_file(&i2c_dev->class_dev, &class_device_attr_name);
 	return 0;
 error:
 	return_i2c_dev(i2c_dev);

