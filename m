Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWAEOnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWAEOnU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWAEOnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:43:19 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24588 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750942AbWAEOnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:43:17 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>
Subject: [CFT 26/29] Add usb_serial_bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:43:11 +0000
Message-ID: <20060105142951.13.26@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 drivers/usb/serial/bus.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/drivers/usb/serial/bus.c linux/drivers/usb/serial/bus.c
--- linus/drivers/usb/serial/bus.c	Sun Nov  6 22:17:51 2005
+++ linux/drivers/usb/serial/bus.c	Sun Nov 13 16:40:36 2005
@@ -37,11 +37,6 @@ static int usb_serial_device_match (stru
 	return 0;
 }
 
-struct bus_type usb_serial_bus_type = {
-	.name =		"usb-serial",
-	.match =	usb_serial_device_match,
-};
-
 static int usb_serial_device_probe (struct device *dev)
 {
 	struct usb_serial_driver *driver;
@@ -109,14 +104,18 @@ exit:
 	return retval;
 }
 
+struct bus_type usb_serial_bus_type = {
+	.name =		"usb-serial",
+	.match =	usb_serial_device_match,
+	.probe =	usb_serial_device_probe,
+	.remove =	usb_serial_device_remove,
+};
+
 int usb_serial_bus_register(struct usb_serial_driver *driver)
 {
 	int retval;
 
 	driver->driver.bus = &usb_serial_bus_type;
-	driver->driver.probe = usb_serial_device_probe;
-	driver->driver.remove = usb_serial_device_remove;
-
 	retval = driver_register(&driver->driver);
 
 	return retval;
