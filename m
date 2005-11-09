Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030468AbVKIAcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbVKIAcq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 19:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbVKIAcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 19:32:46 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:35364 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1030468AbVKIAcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 19:32:45 -0500
Date: Wed, 9 Nov 2005 01:32:43 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix missing includes for 2.6.14-git11
Message-ID: <Pine.LNX.4.61.0511090128450.4435@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Include fixes for 2.6.14-git11. Should allow to remove sched.h from module.h
on i386, x86_64, arm, ia64, ppc, ppc64, and s390.
Probably more to come since I haven't yet checked the other archs.

Signed-off-by: Tim Schmielau <tim@physik3.uni-rostock.de>
---
diff -urp linux-2.6.14-git11-sr/arch/ppc64/kernel/module.c linux-2.6.14-git11-sr2/arch/ppc64/kernel/module.c
--- linux-2.6.14-git11-sr/arch/ppc64/kernel/module.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git11-sr2/arch/ppc64/kernel/module.c	2005-11-09 00:44:15.000000000 +0100
@@ -20,6 +20,7 @@
 #include <linux/moduleloader.h>
 #include <linux/err.h>
 #include <linux/vmalloc.h>
+#include <linux/string.h>
 #include <asm/module.h>
 #include <asm/uaccess.h>
 
diff -urp linux-2.6.14-git11-sr/drivers/macintosh/windfarm_smu_controls.c linux-2.6.14-git11-sr2/drivers/macintosh/windfarm_smu_controls.c
--- linux-2.6.14-git11-sr/drivers/macintosh/windfarm_smu_controls.c	2005-11-09 01:07:57.000000000 +0100
+++ linux-2.6.14-git11-sr2/drivers/macintosh/windfarm_smu_controls.c	2005-11-09 00:31:49.000000000 +0100
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/wait.h>
+#include <linux/completion.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/io.h>
diff -urp linux-2.6.14-git11-sr/drivers/macintosh/windfarm_smu_sensors.c linux-2.6.14-git11-sr2/drivers/macintosh/windfarm_smu_sensors.c
--- linux-2.6.14-git11-sr/drivers/macintosh/windfarm_smu_sensors.c	2005-11-09 01:07:57.000000000 +0100
+++ linux-2.6.14-git11-sr2/drivers/macintosh/windfarm_smu_sensors.c	2005-11-09 00:32:02.000000000 +0100
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/wait.h>
+#include <linux/completion.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/io.h>
diff -urp linux-2.6.14-git11-sr/drivers/mtd/onenand/generic.c linux-2.6.14-git11-sr2/drivers/mtd/onenand/generic.c
--- linux-2.6.14-git11-sr/drivers/mtd/onenand/generic.c	2005-11-09 01:07:57.000000000 +0100
+++ linux-2.6.14-git11-sr2/drivers/mtd/onenand/generic.c	2005-11-09 00:32:41.000000000 +0100
@@ -15,6 +15,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/slab.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/onenand.h>
 #include <linux/mtd/partitions.h>
diff -urp linux-2.6.14-git11-sr/drivers/mtd/onenand/onenand_base.c linux-2.6.14-git11-sr2/drivers/mtd/onenand/onenand_base.c
--- linux-2.6.14-git11-sr/drivers/mtd/onenand/onenand_base.c	2005-11-09 01:07:57.000000000 +0100
+++ linux-2.6.14-git11-sr2/drivers/mtd/onenand/onenand_base.c	2005-11-09 00:32:51.000000000 +0100
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/sched.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/onenand.h>
 #include <linux/mtd/partitions.h>
diff -urp linux-2.6.14-git11-sr/drivers/mtd/rfd_ftl.c linux-2.6.14-git11-sr2/drivers/mtd/rfd_ftl.c
--- linux-2.6.14-git11-sr/drivers/mtd/rfd_ftl.c	2005-11-09 01:07:57.000000000 +0100
+++ linux-2.6.14-git11-sr2/drivers/mtd/rfd_ftl.c	2005-11-09 00:33:18.000000000 +0100
@@ -18,6 +18,8 @@
 #include <linux/mtd/blktrans.h>
 #include <linux/mtd/mtd.h>
 #include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
 
 #include <asm/types.h>
 
diff -urp linux-2.6.14-git11-sr/drivers/rapidio/rio-scan.c linux-2.6.14-git11-sr2/drivers/rapidio/rio-scan.c
--- linux-2.6.14-git11-sr/drivers/rapidio/rio-scan.c	2005-11-09 01:07:57.000000000 +0100
+++ linux-2.6.14-git11-sr2/drivers/rapidio/rio-scan.c	2005-11-09 00:33:51.000000000 +0100
@@ -24,6 +24,8 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/timer.h>
+#include <linux/jiffies.h>
+#include <linux/slab.h>
 
 #include "rio.h"
 
diff -urp linux-2.6.14-git11-sr/drivers/rapidio/rio-sysfs.c linux-2.6.14-git11-sr2/drivers/rapidio/rio-sysfs.c
--- linux-2.6.14-git11-sr/drivers/rapidio/rio-sysfs.c	2005-11-09 01:07:57.000000000 +0100
+++ linux-2.6.14-git11-sr2/drivers/rapidio/rio-sysfs.c	2005-11-09 00:34:06.000000000 +0100
@@ -15,6 +15,7 @@
 #include <linux/rio.h>
 #include <linux/rio_drv.h>
 #include <linux/stat.h>
+#include <linux/sched.h>	/* for capable() */
 
 #include "rio.h"
 
diff -urp linux-2.6.14-git11-sr/drivers/rapidio/rio.c linux-2.6.14-git11-sr2/drivers/rapidio/rio.c
--- linux-2.6.14-git11-sr/drivers/rapidio/rio.c	2005-11-09 01:07:57.000000000 +0100
+++ linux-2.6.14-git11-sr2/drivers/rapidio/rio.c	2005-11-09 00:34:45.000000000 +0100
@@ -23,6 +23,7 @@
 #include <linux/rio_regs.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
+#include <linux/slab.h>
 
 #include "rio.h"
 
diff -urp linux-2.6.14-git11-sr/drivers/usb/host/ohci-au1xxx.c linux-2.6.14-git11-sr2/drivers/usb/host/ohci-au1xxx.c
--- linux-2.6.14-git11-sr/drivers/usb/host/ohci-au1xxx.c	2005-11-09 01:07:59.000000000 +0100
+++ linux-2.6.14-git11-sr2/drivers/usb/host/ohci-au1xxx.c	2005-11-09 00:35:01.000000000 +0100
@@ -19,6 +19,7 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/signal.h>
 
 #include <asm/mach-au1x00/au1000.h>
 
diff -urp linux-2.6.14-git11-sr/drivers/usb/host/ohci-lh7a404.c linux-2.6.14-git11-sr2/drivers/usb/host/ohci-lh7a404.c
--- linux-2.6.14-git11-sr/drivers/usb/host/ohci-lh7a404.c	2005-11-09 01:07:59.000000000 +0100
+++ linux-2.6.14-git11-sr2/drivers/usb/host/ohci-lh7a404.c	2005-11-09 00:06:47.000000000 +0100
@@ -17,6 +17,7 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/signal.h>
 
 #include <asm/hardware.h>
 
diff -urp linux-2.6.14-git11-sr/drivers/usb/host/ohci-ppc-soc.c linux-2.6.14-git11-sr2/drivers/usb/host/ohci-ppc-soc.c
--- linux-2.6.14-git11-sr/drivers/usb/host/ohci-ppc-soc.c	2005-11-09 01:07:59.000000000 +0100
+++ linux-2.6.14-git11-sr2/drivers/usb/host/ohci-ppc-soc.c	2005-11-09 00:06:52.000000000 +0100
@@ -15,6 +15,7 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/signal.h>
 
 /* configure so an HC device and id are always provided */
 /* always called with process context; sleeping is OK */
diff -urp linux-2.6.14-git11-sr/drivers/usb/host/ohci-s3c2410.c linux-2.6.14-git11-sr2/drivers/usb/host/ohci-s3c2410.c
--- linux-2.6.14-git11-sr/drivers/usb/host/ohci-s3c2410.c	2005-11-09 01:07:59.000000000 +0100
+++ linux-2.6.14-git11-sr2/drivers/usb/host/ohci-s3c2410.c	2005-11-09 00:06:59.000000000 +0100
@@ -20,6 +20,7 @@
 */
 
 #include <linux/platform_device.h>
+#include <linux/signal.h>
 
 #include <asm/hardware.h>
 #include <asm/hardware/clock.h>
diff -urp linux-2.6.14-git11-sr/include/linux/rio_drv.h linux-2.6.14-git11-sr2/include/linux/rio_drv.h
--- linux-2.6.14-git11-sr/include/linux/rio_drv.h	2005-11-09 01:08:00.000000000 +0100
+++ linux-2.6.14-git11-sr2/include/linux/rio_drv.h	2005-11-09 00:51:09.000000000 +0100
@@ -21,6 +21,7 @@
 #include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/device.h>
+#include <linux/string.h>
 #include <linux/rio.h>
 
 extern int __rio_local_read_config_32(struct rio_mport *port, u32 offset,
