Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965196AbVI0Xey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbVI0Xey (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 19:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965209AbVI0Xey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 19:34:54 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:50323 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S965200AbVI0Xex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 19:34:53 -0400
Date: Wed, 28 Sep 2005 01:33:31 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: Dave Jones <davej@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Subject: [patch] fix even more missing includes
In-Reply-To: <Pine.LNX.4.53.0509241258460.2235@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.53.0509280129450.4224@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.53.0509241258460.2235@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix more missing includes as a preparatory step for not including sched.h
from module.h. Together with the two previous patches this now covers
all architectures.
I'll let the patches settle before I push the patch to actually remove
sched.h inclusion from module.h.

Signed-off-by: Tim Schmielau <tim@physik3.uni-rostock.de>


--- linux-2.6.14-rc2-mm1-sr-dj8/arch/cris/arch-v10/drivers/axisflashmap.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj9/arch/cris/arch-v10/drivers/axisflashmap.c	2005-09-27 17:50:32.000000000 +0200
@@ -140,6 +140,7 @@
 #include <linux/kernel.h>
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/slab.h>

 #include <linux/mtd/concat.h>
 #include <linux/mtd/map.h>

--- linux-2.6.14-rc2-mm1-sr-dj8/arch/cris/arch-v32/drivers/axisflashmap.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj9/arch/cris/arch-v32/drivers/axisflashmap.c	2005-09-27 17:50:32.000000000 +0200
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/slab.h>

 #include <linux/mtd/concat.h>
 #include <linux/mtd/map.h>

--- linux-2.6.14-rc2-mm1-sr-dj8/arch/cris/kernel/time.c	2005-09-27 17:23:30.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj9/arch/cris/kernel/time.c	2005-09-27 17:50:32.000000000 +0200
@@ -31,6 +31,7 @@
 #include <linux/timex.h>
 #include <linux/init.h>
 #include <linux/profile.h>
+#include <linux/sched.h>	/* just for sched_clock() - funny that */

 u64 jiffies_64 = INITIAL_JIFFIES;


--- linux-2.6.14-rc2-mm1-sr-dj8/arch/m32r/lib/csum_partial_copy.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj9/arch/m32r/lib/csum_partial_copy.c	2005-09-27 17:50:32.000000000 +0200
@@ -18,10 +18,10 @@

 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/string.h>

 #include <net/checksum.h>
 #include <asm/byteorder.h>
-#include <asm/string.h>
 #include <asm/uaccess.h>

 /*

--- linux-2.6.14-rc2-mm1-sr-dj8/arch/mips/sgi-ip27/ip27-berr.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj9/arch/mips/sgi-ip27/ip27-berr.c	2005-09-27 17:50:32.000000000 +0200
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/signal.h>	/* for SIGBUS */

 #include <asm/module.h>
 #include <asm/sn/addrs.h>

--- linux-2.6.14-rc2-mm1-sr-dj8/arch/ppc/syslib/of_device.c	2005-09-27 17:23:46.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj9/arch/ppc/syslib/of_device.c	2005-09-27 17:50:32.000000000 +0200
@@ -4,6 +4,8 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/slab.h>
+
 #include <asm/errno.h>
 #include <asm/of_device.h>


--- linux-2.6.14-rc2-mm1-sr-dj8/arch/sh/drivers/dma/dma-sysfs.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj9/arch/sh/drivers/dma/dma-sysfs.c	2005-09-27 17:50:32.000000000 +0200
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/sysdev.h>
 #include <linux/module.h>
+#include <linux/string.h>
 #include <asm/dma.h>

 static struct sysdev_class dma_sysclass = {

--- linux-2.6.14-rc2-mm1-sr-dj8/arch/sh/kernel/cpufreq.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj9/arch/sh/kernel/cpufreq.c	2005-09-27 17:50:32.000000000 +0200
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/cpumask.h>
 #include <linux/smp.h>
+#include <linux/sched.h>	/* set_cpus_allowed() */

 #include <asm/processor.h>
 #include <asm/watchdog.h>

--- linux-2.6.14-rc2-mm1-sr-dj8/arch/xtensa/kernel/platform.c	2005-09-27 17:23:46.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj9/arch/xtensa/kernel/platform.c	2005-09-27 17:50:32.000000000 +0200
@@ -18,6 +18,7 @@
 #include <linux/time.h>
 #include <asm/platform.h>
 #include <asm/timex.h>
+#include <asm/param.h>		/* HZ */

 #define _F(r,f,a,b)							\
 	r __platform_##f a b;                                   	\

--- linux-2.6.14-rc2-mm1-sr-dj8/drivers/char/agp/ali-agp.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj9/drivers/char/agp/ali-agp.c	2005-09-27 17:50:32.000000000 +0200
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/agp_backend.h>
+#include <asm/page.h>		/* PAGE_SIZE */
 #include "agp.h"

 #define ALI_AGPCTRL	0xb8

--- linux-2.6.14-rc2-mm1-sr-dj8/drivers/char/agp/amd64-agp.c	2005-09-27 17:23:31.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj9/drivers/char/agp/amd64-agp.c	2005-09-27 17:50:32.000000000 +0200
@@ -13,6 +13,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/agp_backend.h>
+#include <asm/page.h>		/* PAGE_SIZE */
 #include "agp.h"

 /* Will need to be increased if AMD64 ever goes >8-way. */

--- linux-2.6.14-rc2-mm1-sr-dj8/drivers/char/mwave/3780i.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj9/drivers/char/mwave/3780i.c	2005-09-27 17:50:32.000000000 +0200
@@ -53,6 +53,8 @@
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/bitops.h>
+#include <linux/sched.h>	/* cond_resched() */
+
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>

--- linux-2.6.14-rc2-mm1-sr-dj8/drivers/infiniband/hw/mthca/mthca_uar.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj9/drivers/infiniband/hw/mthca/mthca_uar.c	2005-09-27 17:50:32.000000000 +0200
@@ -32,6 +32,8 @@
  * $Id$
  */

+#include <asm/page.h>		/* PAGE_SHIFT */
+
 #include "mthca_dev.h"
 #include "mthca_memfree.h"


--- linux-2.6.14-rc2-mm1-sr-dj8/drivers/pci/hotplug/pciehprm_nonacpi.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj9/drivers/pci/hotplug/pciehprm_nonacpi.c	2005-09-27 17:50:32.000000000 +0200
@@ -33,10 +33,13 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/slab.h>
+
 #include <asm/uaccess.h>
 #ifdef CONFIG_IA64
 #include <asm/iosapic.h>
 #endif
+
 #include "pciehp.h"
 #include "pciehprm.h"
 #include "pciehprm_nonacpi.h"

--- linux-2.6.14-rc2-mm1-sr-dj8/drivers/pci/hotplug/shpchp.h	2005-09-27 17:23:32.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj9/drivers/pci/hotplug/shpchp.h	2005-09-27 17:50:32.000000000 +0200
@@ -32,8 +32,11 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
+#include <linux/sched.h>	/* signal_pending(), struct timer_list */
+
 #include <asm/semaphore.h>
 #include <asm/io.h>
+
 #include "pci_hotplug.h"

 #if !defined(MODULE)

--- linux-2.6.14-rc2-mm1-sr-dj8/drivers/pci/hotplug/shpchprm_nonacpi.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj9/drivers/pci/hotplug/shpchprm_nonacpi.c	2005-09-27 17:50:32.000000000 +0200
@@ -33,10 +33,13 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/slab.h>
+
 #include <asm/uaccess.h>
 #ifdef CONFIG_IA64
 #include <asm/iosapic.h>
 #endif
+
 #include "shpchp.h"
 #include "shpchprm.h"
 #include "shpchprm_nonacpi.h"

--- linux-2.6.14-rc2-mm1-sr-dj8/drivers/usb/host/ohci-pci.c	2005-09-27 17:23:48.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj9/drivers/usb/host/ohci-pci.c	2005-09-27 17:50:32.000000000 +0200
@@ -14,6 +14,8 @@
  * This file is licenced under the GPL.
  */

+#include <linux/jiffies.h>
+
 #ifdef CONFIG_PPC_PMAC
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>

--- linux-2.6.14-rc2-mm1-sr-dj8/include/linux/serial.h	2005-09-27 17:23:34.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj9/include/linux/serial.h	2005-09-27 17:50:32.000000000 +0200
@@ -11,6 +11,7 @@
 #define _LINUX_SERIAL_H

 #ifdef __KERNEL__
+#include <linux/types.h>
 #include <asm/page.h>

 /*

--- linux-2.6.14-rc2-mm1-sr-dj8/kernel/kprobes.c	2005-09-27 17:23:34.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj9/kernel/kprobes.c	2005-09-27 17:51:45.000000000 +0200
@@ -35,6 +35,7 @@
 #include <linux/spinlock.h>
 #include <linux/hash.h>
 #include <linux/init.h>
+#include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/moduleloader.h>
 #include <asm-generic/sections.h>

--- linux-2.6.14-rc2-mm1-sr-dj8/lib/vsprintf.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj9/lib/vsprintf.c	2005-09-27 17:50:32.000000000 +0200
@@ -23,6 +23,7 @@
 #include <linux/ctype.h>
 #include <linux/kernel.h>

+#include <asm/page.h>		/* for PAGE_SIZE */
 #include <asm/div64.h>

 /**
