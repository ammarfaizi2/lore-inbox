Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269776AbUJSQzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269776AbUJSQzq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269819AbUJSQxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:53:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:52420 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269784AbUJSQip convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:45 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <10982037811163@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:36:24 -0700
Message-Id: <1098203784644@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1939.1.48, 2004/09/22 16:12:59-07:00, greg@kroah.com

[PATCH] USB: add support for symlink from usb and usb-serial driver to its module in sysfs

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/core/usb.c   |    2 ++
 drivers/usb/serial/bus.c |    1 +
 2 files changed, 3 insertions(+)


diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	2004-10-19 09:22:24 -07:00
+++ b/drivers/usb/core/usb.c	2004-10-19 09:22:24 -07:00
@@ -73,6 +73,7 @@
 }
 
 static struct device_driver usb_generic_driver = {
+	.owner = THIS_MODULE,
 	.name =	"usb",
 	.bus = &usb_bus_type,
 	.probe = generic_probe,
@@ -150,6 +151,7 @@
 	new_driver->driver.bus = &usb_bus_type;
 	new_driver->driver.probe = usb_probe_interface;
 	new_driver->driver.remove = usb_unbind_interface;
+	new_driver->driver.owner = new_driver->owner;
 
 	retval = driver_register(&new_driver->driver);
 
diff -Nru a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
--- a/drivers/usb/serial/bus.c	2004-10-19 09:22:24 -07:00
+++ b/drivers/usb/serial/bus.c	2004-10-19 09:22:24 -07:00
@@ -120,6 +120,7 @@
 	device->driver.bus = &usb_serial_bus_type;
 	device->driver.probe = usb_serial_device_probe;
 	device->driver.remove = usb_serial_device_remove;
+	device->driver.owner = device->owner;
 
 	retval = driver_register(&device->driver);
 

