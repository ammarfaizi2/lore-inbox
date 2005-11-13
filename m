Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbVKMMZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbVKMMZQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 07:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVKMMZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 07:25:16 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:38667 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S932489AbVKMMZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 07:25:14 -0500
Date: Sun, 13 Nov 2005 13:25:03 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix missing includes for 2.6.15-rc1
Message-ID: <Pine.LNX.4.63.0511131323250.9037@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Include fixes for 2.6.15-rc1 for removing sched.h from module.h.
Compile tested on alpha, arm, ia64, mips, powerpc, ppc64, and x86_64.

Signed-off-by: Tim Schmielau <tim@physik3.uni-rostock.de>
---
Andrew:
This one is incremental on top of fix-missing-includes-for-2.6.14-git11.patch

diff -urp linux-2.6.15-rc1-sr0/arch/arm/common/scoop.c linux-2.6.15-rc1-sr2/arch/arm/common/scoop.c
--- linux-2.6.15-rc1-sr0/arch/arm/common/scoop.c	2005-11-13 10:19:31.000000000 +0100
+++ linux-2.6.15-rc1-sr2/arch/arm/common/scoop.c	2005-11-13 10:21:36.000000000 +0100
@@ -13,6 +13,7 @@
 
 #include <linux/device.h>
 #include <linux/string.h>
+#include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <asm/io.h>
 #include <asm/hardware/scoop.h>
diff -urp linux-2.6.15-rc1-sr0/arch/arm/mach-realview/localtimer.c linux-2.6.15-rc1-sr2/arch/arm/mach-realview/localtimer.c
--- linux-2.6.15-rc1-sr0/arch/arm/mach-realview/localtimer.c	2005-11-13 10:19:31.000000000 +0100
+++ linux-2.6.15-rc1-sr2/arch/arm/mach-realview/localtimer.c	2005-11-13 10:21:36.000000000 +0100
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/smp.h>
+#include <linux/jiffies.h>
 
 #include <asm/mach/time.h>
 #include <asm/hardware/arm_twd.h>
diff -urp linux-2.6.15-rc1-sr0/arch/mips/sgi-ip27/ip27-berr.c linux-2.6.15-rc1-sr2/arch/mips/sgi-ip27/ip27-berr.c
--- linux-2.6.15-rc1-sr0/arch/mips/sgi-ip27/ip27-berr.c	2005-11-13 10:19:32.000000000 +0100
+++ linux-2.6.15-rc1-sr2/arch/mips/sgi-ip27/ip27-berr.c	2005-11-13 10:21:36.000000000 +0100
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/signal.h>	/* for SIGBUS */
+#include <linux/sched.h>	/* schow_regs(), force_sig() */
 
 #include <asm/module.h>
 #include <asm/sn/addrs.h>
diff -urp linux-2.6.15-rc1-sr0/drivers/char/agp/sworks-agp.c linux-2.6.15-rc1-sr2/drivers/char/agp/sworks-agp.c
--- linux-2.6.15-rc1-sr0/drivers/char/agp/sworks-agp.c	2005-11-13 10:19:34.000000000 +0100
+++ linux-2.6.15-rc1-sr2/drivers/char/agp/sworks-agp.c	2005-11-13 10:21:27.000000000 +0100
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/agp_backend.h>
 #include "agp.h"
 
diff -urp linux-2.6.15-rc1-sr0/drivers/infiniband/hw/mthca/mthca_dev.h linux-2.6.15-rc1-sr2/drivers/infiniband/hw/mthca/mthca_dev.h
--- linux-2.6.15-rc1-sr0/drivers/infiniband/hw/mthca/mthca_dev.h	2005-11-13 10:19:35.000000000 +0100
+++ linux-2.6.15-rc1-sr2/drivers/infiniband/hw/mthca/mthca_dev.h	2005-11-13 10:21:27.000000000 +0100
@@ -43,6 +43,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
+#include <linux/timer.h>
 #include <asm/semaphore.h>
 
 #include "mthca_provider.h"
diff -urp linux-2.6.15-rc1-sr0/drivers/infiniband/ulp/srp/ib_srp.c linux-2.6.15-rc1-sr2/drivers/infiniband/ulp/srp/ib_srp.c
--- linux-2.6.15-rc1-sr0/drivers/infiniband/ulp/srp/ib_srp.c	2005-11-13 10:19:35.000000000 +0100
+++ linux-2.6.15-rc1-sr2/drivers/infiniband/ulp/srp/ib_srp.c	2005-11-13 10:21:27.000000000 +0100
@@ -39,6 +39,7 @@
 #include <linux/string.h>
 #include <linux/parser.h>
 #include <linux/random.h>
+#include <linux/jiffies.h>
 
 #include <asm/atomic.h>
 
diff -urp linux-2.6.15-rc1-sr0/drivers/media/dvb/frontends/nxt200x.c linux-2.6.15-rc1-sr2/drivers/media/dvb/frontends/nxt200x.c
--- linux-2.6.15-rc1-sr0/drivers/media/dvb/frontends/nxt200x.c	2005-11-13 10:19:44.000000000 +0100
+++ linux-2.6.15-rc1-sr2/drivers/media/dvb/frontends/nxt200x.c	2005-11-13 10:21:36.000000000 +0100
@@ -44,6 +44,8 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 
 #include "dvb_frontend.h"
 #include "dvb-pll.h"
diff -urp linux-2.6.15-rc1-sr0/drivers/pci/hotplug/pciehp.h linux-2.6.15-rc1-sr2/drivers/pci/hotplug/pciehp.h
--- linux-2.6.15-rc1-sr0/drivers/pci/hotplug/pciehp.h	2005-11-13 10:19:45.000000000 +0100
+++ linux-2.6.15-rc1-sr2/drivers/pci/hotplug/pciehp.h	2005-11-13 10:21:36.000000000 +0100
@@ -32,6 +32,7 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
+#include <linux/sched.h>		/* signal_pending() */
 #include <linux/pcieport_if.h>
 #include "pci_hotplug.h"
 
diff -urp linux-2.6.15-rc1-sr0/drivers/pci/hotplug/pciehp_hpc.c linux-2.6.15-rc1-sr2/drivers/pci/hotplug/pciehp_hpc.c
--- linux-2.6.15-rc1-sr0/drivers/pci/hotplug/pciehp_hpc.c	2005-11-13 10:19:45.000000000 +0100
+++ linux-2.6.15-rc1-sr2/drivers/pci/hotplug/pciehp_hpc.c	2005-11-13 10:21:36.000000000 +0100
@@ -30,6 +30,9 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/signal.h>
+#include <linux/jiffies.h>
+#include <linux/timer.h>
 #include <linux/pci.h>
 #include "../pci.h"
 #include "pciehp.h"
