Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267458AbSKQEKg>; Sat, 16 Nov 2002 23:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267456AbSKQEKg>; Sat, 16 Nov 2002 23:10:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53002 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267459AbSKQEKd>;
	Sat, 16 Nov 2002 23:10:33 -0500
Date: Sun, 17 Nov 2002 04:17:31 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>
Subject: [PATCH] Add some missing includes to drivers/base
Message-ID: <20021117041731.G20070@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


drivers/base relies on device.h pulling in sched.h pulling in the rest
of the world.  Add some explicit dependencies in preparation for removing
sched.h from device.h.

diff -urpNX dontdiff linux-2.5.47/drivers/base/bus.c linux-2.5.47-pci/drivers/base/bus.c
--- linux-2.5.47/drivers/base/bus.c	2002-11-05 09:16:03.000000000 -0500
+++ linux-2.5.47-pci/drivers/base/bus.c	2002-11-16 22:42:08.000000000 -0500
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/string.h>
 #include "base.h"
 
 static LIST_HEAD(bus_driver_list);
diff -urpNX dontdiff linux-2.5.47/drivers/base/class.c linux-2.5.47-pci/drivers/base/class.c
--- linux-2.5.47/drivers/base/class.c	2002-11-05 09:16:03.000000000 -0500
+++ linux-2.5.47-pci/drivers/base/class.c	2002-11-16 22:42:27.000000000 -0500
@@ -5,6 +5,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/string.h>
 #include "base.h"
 
 static LIST_HEAD(class_list);
diff -urpNX dontdiff linux-2.5.47/drivers/base/core.c linux-2.5.47-pci/drivers/base/core.c
--- linux-2.5.47/drivers/base/core.c	2002-11-05 09:16:03.000000000 -0500
+++ linux-2.5.47-pci/drivers/base/core.c	2002-11-16 22:39:42.000000000 -0500
@@ -8,10 +8,14 @@
 #define DEBUG 0
 
 #include <linux/device.h>
-#include <linux/module.h>
-#include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include <asm/semaphore.h>
+
 #include "base.h"
 
 LIST_HEAD(global_device_list);
diff -urpNX dontdiff linux-2.5.47/drivers/base/driver.c linux-2.5.47-pci/drivers/base/driver.c
--- linux-2.5.47/drivers/base/driver.c	2002-11-05 09:16:03.000000000 -0500
+++ linux-2.5.47-pci/drivers/base/driver.c	2002-11-16 22:42:58.000000000 -0500
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 #include "base.h"
 
 #define to_dev(node) container_of(node,struct device,driver_list)
diff -urpNX dontdiff linux-2.5.47/drivers/base/interface.c linux-2.5.47-pci/drivers/base/interface.c
--- linux-2.5.47/drivers/base/interface.c	2002-11-05 09:16:03.000000000 -0500
+++ linux-2.5.47-pci/drivers/base/interface.c	2002-11-16 22:41:00.000000000 -0500
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/stat.h>
+#include <linux/string.h>
 
 static ssize_t device_read_name(struct device * dev, char * buf, size_t count, loff_t off)
 {
diff -urpNX dontdiff linux-2.5.47/drivers/base/intf.c linux-2.5.47-pci/drivers/base/intf.c
--- linux-2.5.47/drivers/base/intf.c	2002-11-05 09:16:03.000000000 -0500
+++ linux-2.5.47-pci/drivers/base/intf.c	2002-11-16 22:43:24.000000000 -0500
@@ -6,6 +6,7 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/string.h>
 #include "base.h"
 
 
diff -urpNX dontdiff linux-2.5.47/drivers/base/power.c linux-2.5.47-pci/drivers/base/power.c
--- linux-2.5.47/drivers/base/power.c	2002-10-20 10:16:01.000000000 -0400
+++ linux-2.5.47-pci/drivers/base/power.c	2002-11-16 22:41:43.000000000 -0500
@@ -12,6 +12,7 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
+#include <asm/semaphore.h>
 #include "base.h"
 
 #define to_dev(node) container_of(node,struct device,g_list)
diff -urpNX dontdiff linux-2.5.47/drivers/base/sys.c linux-2.5.47-pci/drivers/base/sys.c
--- linux-2.5.47/drivers/base/sys.c	2002-11-05 09:16:03.000000000 -0500
+++ linux-2.5.47-pci/drivers/base/sys.c	2002-11-16 22:40:26.000000000 -0500
@@ -13,11 +13,12 @@
 #define DEBUG 1
 
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/err.h>
+#include <linux/string.h>
 
 /* The default system device parent. */
 static struct device system_bus = {
 
-- 
Revolutions do not require corporate support.
