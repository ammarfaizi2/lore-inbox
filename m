Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264355AbTEGXGb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264328AbTEGXFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:05:31 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:47598 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264332AbTEGXCC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:02 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10523493883163@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <10523493883143@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1117, 2003/05/07 15:52:51-07:00, greg@kroah.com

TTY: remove usb-serial sysfs dev file as it is now redundant.


 drivers/usb/serial/bus.c |   17 +----------------
 1 files changed, 1 insertion(+), 16 deletions(-)


diff -Nru a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
--- a/drivers/usb/serial/bus.c	Wed May  7 15:59:54 2003
+++ b/drivers/usb/serial/bus.c	Wed May  7 15:59:54 2003
@@ -23,18 +23,6 @@
 
 #include "usb-serial.h"
 
-static ssize_t show_dev (struct device *dev, char *buf)
-{
-	struct usb_serial_port *port= to_usb_serial_port(dev);
-	dev_t base;
-
-	port = to_usb_serial_port(dev);
-
-	base = MKDEV(SERIAL_TTY_MAJOR, port->number);
-	return sprintf(buf, "%04x\n", base);
-}
-static DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
-
 static int usb_serial_device_match (struct device *dev, struct device_driver *drv)
 {
 	struct usb_serial_device_type *driver;
@@ -88,10 +76,7 @@
 	}
 
 	minor = port->number;
-
-	tty_register_device (&usb_serial_tty_driver, minor);
-	device_create_file (dev, &dev_attr_dev);
-
+	tty_register_device (&usb_serial_tty_driver, minor, dev);
 	dev_info(&port->serial->dev->dev, 
 		 "%s converter now attached to ttyUSB%d (or usb/tts/%d for devfs)\n",
 		 driver->name, minor, minor);

