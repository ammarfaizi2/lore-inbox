Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262579AbVCJAzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbVCJAzI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbVCJAp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:45:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:54431 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262626AbVCJAma convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:30 -0500
Cc: kay.sievers@vrfy.org
Subject: [PATCH] usb: class driver pass dev_t to the class core
In-Reply-To: <1110414881502@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:34:42 -0800
Message-Id: <11104148822712@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2042, 2005/03/09 09:51:30-08:00, kay.sievers@vrfy.org

[PATCH] usb: class driver pass dev_t to the class core

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/usb/core/file.c |    9 +--------
 1 files changed, 1 insertion(+), 8 deletions(-)


diff -Nru a/drivers/usb/core/file.c b/drivers/usb/core/file.c
--- a/drivers/usb/core/file.c	2005-03-09 16:29:34 -08:00
+++ b/drivers/usb/core/file.c	2005-03-09 16:29:34 -08:00
@@ -107,13 +107,6 @@
 	unregister_chrdev(USB_MAJOR, "usb");
 }
 
-static ssize_t show_dev(struct class_device *class_dev, char *buf)
-{
-	int minor = (int)(long)class_get_devdata(class_dev);
-	return print_dev_t(buf, MKDEV(USB_MAJOR, minor));
-}
-static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
-
 /**
  * usb_register_dev - register a USB device, and ask for a minor number
  * @intf: pointer to the usb_interface that is being registered
@@ -184,6 +177,7 @@
 	class_dev = kmalloc(sizeof(*class_dev), GFP_KERNEL);
 	if (class_dev) {
 		memset(class_dev, 0x00, sizeof(struct class_device));
+		class_dev->devt = MKDEV(USB_MAJOR, minor);
 		class_dev->class = &usb_class;
 		class_dev->dev = &intf->dev;
 
@@ -195,7 +189,6 @@
 		snprintf(class_dev->class_id, BUS_ID_SIZE, "%s", temp);
 		class_set_devdata(class_dev, (void *)(long)intf->minor);
 		class_device_register(class_dev);
-		class_device_create_file(class_dev, &class_device_attr_dev);
 		intf->class_dev = class_dev;
 	}
 exit:

