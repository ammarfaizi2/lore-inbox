Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262789AbUKAXL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbUKAXL0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S381283AbUKAXLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:11:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:6308 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S286261AbUKAV7T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:59:19 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
In-Reply-To: <10993462773570@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Mon, 1 Nov 2004 13:57:57 -0800
Message-Id: <10993462773676@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2448, 2004/11/01 13:05:24-08:00, dtor_core@ameritech.net

[PATCH] Driver core: export device_attach

Driver core: make device_attach() global and export it and
             driver_attach() so subsystems can have finer
             control over binding process.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/bus.c     |    4 +++-
 include/linux/device.h |    1 +
 2 files changed, 4 insertions(+), 1 deletion(-)


diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2004-11-01 13:36:27 -08:00
+++ b/drivers/base/bus.c	2004-11-01 13:36:27 -08:00
@@ -288,7 +288,7 @@
  *	Walk the list of drivers that the bus has and call bus_match()
  *	for each pair. If a compatible pair is found, break out and return.
  */
-static int device_attach(struct device * dev)
+int device_attach(struct device * dev)
 {
  	struct bus_type * bus = dev->bus;
 	struct list_head * entry;
@@ -728,6 +728,8 @@
 
 EXPORT_SYMBOL_GPL(device_bind_driver);
 EXPORT_SYMBOL_GPL(device_release_driver);
+EXPORT_SYMBOL_GPL(device_attach);
+EXPORT_SYMBOL_GPL(driver_attach);
 
 EXPORT_SYMBOL_GPL(bus_add_device);
 EXPORT_SYMBOL_GPL(bus_remove_device);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2004-11-01 13:36:27 -08:00
+++ b/include/linux/device.h	2004-11-01 13:36:27 -08:00
@@ -327,6 +327,7 @@
  */
 extern void device_bind_driver(struct device * dev);
 extern void device_release_driver(struct device * dev);
+extern int  device_attach(struct device * dev);
 extern void driver_attach(struct device_driver * drv);
 
 

