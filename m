Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbVCJBzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbVCJBzK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262604AbVCJBQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:16:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:53407 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262624AbVCJAm3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:29 -0500
Cc: kay.sievers@vrfy.org
Subject: [PATCH] i2c: class driver pass dev_t to the class core
In-Reply-To: <11104148822712@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:34:42 -0800
Message-Id: <11104148823637@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2043, 2005/03/09 09:51:50-08:00, kay.sievers@vrfy.org

[PATCH] i2c: class driver pass dev_t to the class core

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/i2c-dev.c |    9 +--------
 1 files changed, 1 insertion(+), 8 deletions(-)


diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	2005-03-09 16:29:27 -08:00
+++ b/drivers/i2c/i2c-dev.c	2005-03-09 16:29:27 -08:00
@@ -108,13 +108,6 @@
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
@@ -451,11 +444,11 @@
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

