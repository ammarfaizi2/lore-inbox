Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269489AbUJLGdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269489AbUJLGdm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 02:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269494AbUJLGdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 02:33:42 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:40091 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269489AbUJLGdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 02:33:31 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 1/4] Driver core: export device_attach
Date: Tue, 12 Oct 2004 01:31:04 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>
References: <200410062354.18885.dtor_core@ameritech.net> <20041008214820.GA1096@kroah.com> <200410120129.59221.dtor_core@ameritech.net>
In-Reply-To: <200410120129.59221.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410120131.05691.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#### AUTHOR dtor_core@ameritech.net
#### COMMENT START
### Comments for ChangeSet
Driver core: make device_attach() global and export it and
             driver_attach() so subsystems can have finer
             control over binding process.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
### Comments for drivers/base/bus.c
Make device_attach() global and export it and driver_attach()
### Comments for include/linux/device.h
Make device_attach() global.
#### COMMENT END

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/10/11 00:19:18-05:00 dtor_core@ameritech.net 
#   Driver core: make device_attach() global and export it and
#                driver_attach() so subsystems can have finer
#                control over binding process.
#   
#   Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
# 
# include/linux/device.h
#   2004/10/10 23:56:49-05:00 dtor_core@ameritech.net +1 -0
#   Make device_attach() global.
# 
# drivers/base/bus.c
#   2004/10/10 23:56:49-05:00 dtor_core@ameritech.net +3 -1
#   Make device_attach() global and export it and driver_attach()
# 
diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2004-10-12 01:27:27 -05:00
+++ b/drivers/base/bus.c	2004-10-12 01:27:27 -05:00
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
--- a/include/linux/device.h	2004-10-12 01:27:27 -05:00
+++ b/include/linux/device.h	2004-10-12 01:27:27 -05:00
@@ -327,6 +327,7 @@
  */
 extern void device_bind_driver(struct device * dev);
 extern void device_release_driver(struct device * dev);
+extern int  device_attach(struct device * dev);
 extern void driver_attach(struct device_driver * drv);
 
 
