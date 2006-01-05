Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWAEOeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWAEOeP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWAEOeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:34:14 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55312 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751353AbWAEOeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:34:12 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>, IA64 <linux-ia64@vger.kernel.org>
Subject: [CFT 9/29] Add tiocx bus_type probe/remove methods
Date: Thu, 05 Jan 2006 14:34:06 +0000
Message-ID: <20060105142951.13.09@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 arch/ia64/sn/kernel/tiocx.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/arch/ia64/sn/kernel/tiocx.c linux/arch/ia64/sn/kernel/tiocx.c
--- linus/arch/ia64/sn/kernel/tiocx.c	Sun Nov  6 22:14:30 2005
+++ linux/arch/ia64/sn/kernel/tiocx.c	Sun Nov 13 16:07:12 2005
@@ -76,12 +76,6 @@ static void tiocx_bus_release(struct dev
 	kfree(to_cx_dev(dev));
 }
 
-struct bus_type tiocx_bus_type = {
-	.name = "tiocx",
-	.match = tiocx_match,
-	.hotplug = tiocx_hotplug,
-};
-
 /**
  * cx_device_match - Find cx_device in the id table.
  * @ids: id table from driver
@@ -148,6 +142,14 @@ static int cx_driver_remove(struct devic
 	return 0;
 }
 
+struct bus_type tiocx_bus_type = {
+	.name = "tiocx",
+	.match = tiocx_match,
+	.hotplug = tiocx_hotplug,
+	.probe = cx_device_probe,
+	.remove = cx_device_remove,
+};
+
 /**
  * cx_driver_register - Register the driver.
  * @cx_driver: driver table (cx_drv struct) from driver
@@ -161,8 +163,6 @@ int cx_driver_register(struct cx_drv *cx
 {
 	cx_driver->driver.name = cx_driver->name;
 	cx_driver->driver.bus = &tiocx_bus_type;
-	cx_driver->driver.probe = cx_device_probe;
-	cx_driver->driver.remove = cx_driver_remove;
 
 	return driver_register(&cx_driver->driver);
 }
