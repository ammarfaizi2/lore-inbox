Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVAWE35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVAWE35 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 23:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVAWE1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 23:27:13 -0500
Received: from soundwarez.org ([217.160.171.123]:17547 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261210AbVAWEY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 23:24:57 -0500
Date: Sun, 23 Jan 2005 05:24:56 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 4/7] usb: class driver pass dev_t to the class core
Message-ID: <20050123042456.GE9209@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

===== drivers/usb/core/file.c 1.17 vs edited =====
--- 1.17/drivers/usb/core/file.c	2005-01-15 01:01:44 +01:00
+++ edited/drivers/usb/core/file.c	2005-01-22 15:15:05 +01:00
@@ -107,13 +107,6 @@ void usb_major_cleanup(void)
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
@@ -184,6 +177,7 @@ int usb_register_dev(struct usb_interfac
 	class_dev = kmalloc(sizeof(*class_dev), GFP_KERNEL);
 	if (class_dev) {
 		memset(class_dev, 0x00, sizeof(struct class_device));
+		class_dev->devt = MKDEV(USB_MAJOR, minor);
 		class_dev->class = &usb_class;
 		class_dev->dev = &intf->dev;
 
@@ -195,7 +189,6 @@ int usb_register_dev(struct usb_interfac
 		snprintf(class_dev->class_id, BUS_ID_SIZE, "%s", temp);
 		class_set_devdata(class_dev, (void *)(long)intf->minor);
 		class_device_register(class_dev);
-		class_device_create_file(class_dev, &class_device_attr_dev);
 		intf->class_dev = class_dev;
 	}
 exit:

