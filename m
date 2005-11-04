Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVKDQ42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVKDQ42 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVKDQ41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:56:27 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:58483 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1750718AbVKDQ4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:56:14 -0500
Date: Fri, 4 Nov 2005 17:56:12 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] fix remaining missing includes
Message-ID: <Pine.LNX.4.61.0511041746470.4856@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix more include file problems that surfaced since I submitted
the previous fix-missing-includes.patch. This should now allow
not to include sched.h from module.h, which is done by a followup
patch.

Signed-off-by: Tim Schmielau <tim@physik3.uni-rostock.de>
---
diff -urp linux-2.6.14-git3/arch/arm/mach-aaec2000/clock.c linux-2.6.14-git3-sr/arch/arm/mach-aaec2000/clock.c
--- linux-2.6.14-git3/arch/arm/mach-aaec2000/clock.c	2005-11-03 23:14:37.000000000 +0100
+++ linux-2.6.14-git3-sr/arch/arm/mach-aaec2000/clock.c	2005-11-03 23:16:49.000000000 +0100
@@ -14,6 +14,7 @@
 #include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/string.h>
 
 #include <asm/semaphore.h>
 #include <asm/hardware/clock.h>
diff -urp linux-2.6.14-git3/arch/arm/mach-epxa10db/mm.c linux-2.6.14-git3-sr/arch/arm/mach-epxa10db/mm.c
--- linux-2.6.14-git3/arch/arm/mach-epxa10db/mm.c	2005-11-03 23:14:37.000000000 +0100
+++ linux-2.6.14-git3-sr/arch/arm/mach-epxa10db/mm.c	2005-11-03 23:16:49.000000000 +0100
@@ -25,6 +25,7 @@
 #include <asm/hardware.h>
 #include <asm/io.h>
 #include <asm/sizes.h>
+#include <asm/page.h>
  
 #include <asm/mach/map.h>
 
diff -urp linux-2.6.14-git3/arch/arm/mach-pxa/corgi_lcd.c linux-2.6.14-git3-sr/arch/arm/mach-pxa/corgi_lcd.c
--- linux-2.6.14-git3/arch/arm/mach-pxa/corgi_lcd.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3-sr/arch/arm/mach-pxa/corgi_lcd.c	2005-11-03 23:16:49.000000000 +0100
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/string.h>
 #include <asm/arch/akita.h>
 #include <asm/arch/corgi.h>
 #include <asm/arch/hardware.h>
diff -urp linux-2.6.14-git3/arch/ppc/syslib/ppc_sys.c linux-2.6.14-git3-sr/arch/ppc/syslib/ppc_sys.c
--- linux-2.6.14-git3/arch/ppc/syslib/ppc_sys.c	2005-11-03 23:14:38.000000000 +0100
+++ linux-2.6.14-git3-sr/arch/ppc/syslib/ppc_sys.c	2005-11-03 23:16:49.000000000 +0100
@@ -14,6 +14,7 @@
  * option) any later version.
  */
 
+#include <linux/string.h>
 #include <asm/ppc_sys.h>
 
 int (*ppc_sys_device_fixup) (struct platform_device * pdev);
diff -urp linux-2.6.14-git3/drivers/base/power/sysfs.c linux-2.6.14-git3-sr/drivers/base/power/sysfs.c
--- linux-2.6.14-git3/drivers/base/power/sysfs.c	2005-11-03 23:14:38.000000000 +0100
+++ linux-2.6.14-git3-sr/drivers/base/power/sysfs.c	2005-11-03 23:16:49.000000000 +0100
@@ -3,6 +3,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/string.h>
 #include "power.h"
 
 
diff -urp linux-2.6.14-git3/drivers/char/agp/amd64-agp.c linux-2.6.14-git3-sr/drivers/char/agp/amd64-agp.c
--- linux-2.6.14-git3/drivers/char/agp/amd64-agp.c	2005-11-03 23:14:38.000000000 +0100
+++ linux-2.6.14-git3-sr/drivers/char/agp/amd64-agp.c	2005-11-03 23:16:49.000000000 +0100
@@ -13,6 +13,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/agp_backend.h>
+#include <linux/mmzone.h>
 #include <asm/page.h>		/* PAGE_SIZE */
 #include "agp.h"
 
diff -urp linux-2.6.14-git3/drivers/hwmon/hwmon.c linux-2.6.14-git3-sr/drivers/hwmon/hwmon.c
--- linux-2.6.14-git3/drivers/hwmon/hwmon.c	2005-11-03 23:14:38.000000000 +0100
+++ linux-2.6.14-git3-sr/drivers/hwmon/hwmon.c	2005-11-03 23:16:49.000000000 +0100
@@ -16,6 +16,7 @@
 #include <linux/kdev_t.h>
 #include <linux/idr.h>
 #include <linux/hwmon.h>
+#include <linux/gfp.h>
 
 #define HWMON_ID_PREFIX "hwmon"
 #define HWMON_ID_FORMAT HWMON_ID_PREFIX "%d"
diff -urp linux-2.6.14-git3/drivers/infiniband/core/agent.c linux-2.6.14-git3-sr/drivers/infiniband/core/agent.c
--- linux-2.6.14-git3/drivers/infiniband/core/agent.c	2005-11-03 23:14:38.000000000 +0100
+++ linux-2.6.14-git3-sr/drivers/infiniband/core/agent.c	2005-11-03 23:16:49.000000000 +0100
@@ -37,6 +37,9 @@
  * $Id: agent.c 1389 2004-12-27 22:56:47Z roland $
  */
 
+#include <linux/slab.h>
+#include <linux/string.h>
+
 #include "agent.h"
 #include "smi.h"
 
diff -urp linux-2.6.14-git3/drivers/infiniband/core/packer.c linux-2.6.14-git3-sr/drivers/infiniband/core/packer.c
--- linux-2.6.14-git3/drivers/infiniband/core/packer.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3-sr/drivers/infiniband/core/packer.c	2005-11-03 23:16:49.000000000 +0100
@@ -33,6 +33,8 @@
  * $Id: packer.c 1349 2004-12-16 21:09:43Z roland $
  */
 
+#include <linux/string.h>
+
 #include <rdma/ib_pack.h>
 
 static u64 value_read(int offset, int size, void *structure)
diff -urp linux-2.6.14-git3/drivers/infiniband/core/sysfs.c linux-2.6.14-git3-sr/drivers/infiniband/core/sysfs.c
--- linux-2.6.14-git3/drivers/infiniband/core/sysfs.c	2005-11-03 23:14:38.000000000 +0100
+++ linux-2.6.14-git3-sr/drivers/infiniband/core/sysfs.c	2005-11-03 23:16:49.000000000 +0100
@@ -36,6 +36,9 @@
 
 #include "core_priv.h"
 
+#include <linux/slab.h>
+#include <linux/string.h>
+
 #include <rdma/ib_mad.h>
 
 struct ib_port {
diff -urp linux-2.6.14-git3/drivers/infiniband/core/ud_header.c linux-2.6.14-git3-sr/drivers/infiniband/core/ud_header.c
--- linux-2.6.14-git3/drivers/infiniband/core/ud_header.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3-sr/drivers/infiniband/core/ud_header.c	2005-11-03 23:16:49.000000000 +0100
@@ -34,6 +34,7 @@
  */
 
 #include <linux/errno.h>
+#include <linux/string.h>
 
 #include <rdma/ib_pack.h>
 
diff -urp linux-2.6.14-git3/drivers/infiniband/core/verbs.c linux-2.6.14-git3-sr/drivers/infiniband/core/verbs.c
--- linux-2.6.14-git3/drivers/infiniband/core/verbs.c	2005-11-03 23:14:38.000000000 +0100
+++ linux-2.6.14-git3-sr/drivers/infiniband/core/verbs.c	2005-11-03 23:16:49.000000000 +0100
@@ -40,6 +40,7 @@
 
 #include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/string.h>
 
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_cache.h>
diff -urp linux-2.6.14-git3/drivers/infiniband/hw/mthca/mthca_catas.c linux-2.6.14-git3-sr/drivers/infiniband/hw/mthca/mthca_catas.c
--- linux-2.6.14-git3/drivers/infiniband/hw/mthca/mthca_catas.c	2005-11-03 23:14:38.000000000 +0100
+++ linux-2.6.14-git3-sr/drivers/infiniband/hw/mthca/mthca_catas.c	2005-11-03 23:16:49.000000000 +0100
@@ -32,6 +32,9 @@
  * $Id$
  */
 
+#include <linux/jiffies.h>
+#include <linux/timer.h>
+
 #include "mthca_dev.h"
 
 enum {
diff -urp linux-2.6.14-git3/drivers/infiniband/hw/mthca/mthca_srq.c linux-2.6.14-git3-sr/drivers/infiniband/hw/mthca/mthca_srq.c
--- linux-2.6.14-git3/drivers/infiniband/hw/mthca/mthca_srq.c	2005-11-03 23:14:38.000000000 +0100
+++ linux-2.6.14-git3-sr/drivers/infiniband/hw/mthca/mthca_srq.c	2005-11-03 23:16:49.000000000 +0100
@@ -32,6 +32,9 @@
  * $Id: mthca_srq.c 3047 2005-08-10 03:59:35Z roland $
  */
 
+#include <linux/slab.h>
+#include <linux/string.h>
+
 #include "mthca_dev.h"
 #include "mthca_cmd.h"
 #include "mthca_memfree.h"
diff -urp linux-2.6.14-git3/drivers/media/dvb/frontends/cx24110.c linux-2.6.14-git3-sr/drivers/media/dvb/frontends/cx24110.c
--- linux-2.6.14-git3/drivers/media/dvb/frontends/cx24110.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3-sr/drivers/media/dvb/frontends/cx24110.c	2005-11-03 23:16:49.000000000 +0100
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
 
 #include "dvb_frontend.h"
 #include "cx24110.h"
diff -urp linux-2.6.14-git3/drivers/message/i2o/exec-osm.c linux-2.6.14-git3-sr/drivers/message/i2o/exec-osm.c
--- linux-2.6.14-git3/drivers/message/i2o/exec-osm.c	2005-11-03 23:14:38.000000000 +0100
+++ linux-2.6.14-git3-sr/drivers/message/i2o/exec-osm.c	2005-11-04 11:43:26.000000000 +0100
@@ -33,6 +33,7 @@
 #include <linux/workqueue.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/sched.h>   /* wait_event_interruptible_timeout() needs this */
 #include <asm/param.h>		/* HZ */
 #include "core.h"
 
diff -urp linux-2.6.14-git3/drivers/mfd/mcp-core.c linux-2.6.14-git3-sr/drivers/mfd/mcp-core.c
--- linux-2.6.14-git3/drivers/mfd/mcp-core.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3-sr/drivers/mfd/mcp-core.c	2005-11-03 23:16:49.000000000 +0100
@@ -15,6 +15,8 @@
 #include <linux/errno.h>
 #include <linux/smp.h>
 #include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 
 #include <asm/dma.h>
 #include <asm/system.h>
diff -urp linux-2.6.14-git3/drivers/pci/hotplug/pciehprm_nonacpi.c linux-2.6.14-git3-sr/drivers/pci/hotplug/pciehprm_nonacpi.c
--- linux-2.6.14-git3/drivers/pci/hotplug/pciehprm_nonacpi.c	2005-11-03 23:14:39.000000000 +0100
+++ linux-2.6.14-git3-sr/drivers/pci/hotplug/pciehprm_nonacpi.c	2005-11-03 23:16:49.000000000 +0100
@@ -34,6 +34,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/sched.h>
 
 #include <asm/uaccess.h>
 #ifdef CONFIG_IA64
diff -urp linux-2.6.14-git3/drivers/pci/pci-driver.c linux-2.6.14-git3-sr/drivers/pci/pci-driver.c
--- linux-2.6.14-git3/drivers/pci/pci-driver.c	2005-11-03 23:14:39.000000000 +0100
+++ linux-2.6.14-git3-sr/drivers/pci/pci-driver.c	2005-11-03 23:16:49.000000000 +0100
@@ -10,6 +10,7 @@
 #include <linux/mempolicy.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/sched.h>
 #include "pci.h"
 
 /*
diff -urp linux-2.6.14-git3/drivers/scsi/atari_dma_emul.c linux-2.6.14-git3-sr/drivers/scsi/atari_dma_emul.c
--- linux-2.6.14-git3/drivers/scsi/atari_dma_emul.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3-sr/drivers/scsi/atari_dma_emul.c	2005-11-03 23:16:49.000000000 +0100
@@ -19,6 +19,8 @@
  * this code.
  */
 
+#include <linux/compiler.h>
+#include <asm/thread_info.h>
 #include <asm/uaccess.h>
 
 #define hades_dma_ctrl		(*(unsigned char *) 0xffff8717)
diff -urp linux-2.6.14-git3/drivers/scsi/raid_class.c linux-2.6.14-git3-sr/drivers/scsi/raid_class.c
--- linux-2.6.14-git3/drivers/scsi/raid_class.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3-sr/drivers/scsi/raid_class.c	2005-11-03 23:16:49.000000000 +0100
@@ -4,6 +4,8 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/raid_class.h>
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_host.h>
diff -urp linux-2.6.14-git3/drivers/scsi/scsi_transport_sas.c linux-2.6.14-git3-sr/drivers/scsi/scsi_transport_sas.c
--- linux-2.6.14-git3/drivers/scsi/scsi_transport_sas.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3-sr/drivers/scsi/scsi_transport_sas.c	2005-11-03 23:16:49.000000000 +0100
@@ -26,6 +26,8 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_host.h>
diff -urp linux-2.6.14-git3/drivers/scsi/sym53c8xx_2/sym_hipd.c linux-2.6.14-git3-sr/drivers/scsi/sym53c8xx_2/sym_hipd.c
--- linux-2.6.14-git3/drivers/scsi/sym53c8xx_2/sym_hipd.c	2005-11-03 23:14:39.000000000 +0100
+++ linux-2.6.14-git3-sr/drivers/scsi/sym53c8xx_2/sym_hipd.c	2005-11-03 23:16:49.000000000 +0100
@@ -39,6 +39,7 @@
  */
 
 #include <linux/slab.h>
+#include <asm/param.h>		/* for timeouts in units of HZ */
 
 #include "sym_glue.h"
 #include "sym_nvram.h"
diff -urp linux-2.6.14-git3/fs/9p/error.c linux-2.6.14-git3-sr/fs/9p/error.c
--- linux-2.6.14-git3/fs/9p/error.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3-sr/fs/9p/error.c	2005-11-03 23:16:49.000000000 +0100
@@ -33,6 +33,7 @@
 
 #include <linux/list.h>
 #include <linux/jhash.h>
+#include <linux/string.h>
 
 #include "debug.h"
 #include "error.h"
diff -urp linux-2.6.14-git3/include/asm-alpha/pgtable.h linux-2.6.14-git3-sr/include/asm-alpha/pgtable.h
--- linux-2.6.14-git3/include/asm-alpha/pgtable.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3-sr/include/asm-alpha/pgtable.h	2005-11-03 23:18:22.000000000 +0100
@@ -17,6 +17,9 @@
 #include <asm/processor.h>	/* For TASK_SIZE */
 #include <asm/machvec.h>
 
+struct mm_struct;
+struct vm_area_struct;
+
 /* Certain architectures need to do special things when PTEs
  * within a page table are directly modified.  Thus, the following
  * hook is made available.
diff -urp linux-2.6.14-git3/include/asm-cris/processor.h linux-2.6.14-git3-sr/include/asm-cris/processor.h
--- linux-2.6.14-git3/include/asm-cris/processor.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3-sr/include/asm-cris/processor.h	2005-11-03 23:18:59.000000000 +0100
@@ -45,6 +45,8 @@
 
 #define current_regs() user_regs(current->thread_info)
 
+struct task_struct;
+
 extern inline void prepare_to_copy(struct task_struct *tsk)
 {
 }
diff -urp linux-2.6.14-git3/include/asm-frv/pgtable.h linux-2.6.14-git3-sr/include/asm-frv/pgtable.h
--- linux-2.6.14-git3/include/asm-frv/pgtable.h	2005-11-03 23:14:39.000000000 +0100
+++ linux-2.6.14-git3-sr/include/asm-frv/pgtable.h	2005-11-03 23:20:00.000000000 +0100
@@ -26,6 +26,8 @@
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
+struct mm_struct;
+struct vm_area_struct;
 #endif
 
 #ifndef __ASSEMBLY__
diff -urp linux-2.6.14-git3/include/asm-generic/pgtable.h linux-2.6.14-git3-sr/include/asm-generic/pgtable.h
--- linux-2.6.14-git3/include/asm-generic/pgtable.h	2005-11-03 23:14:39.000000000 +0100
+++ linux-2.6.14-git3-sr/include/asm-generic/pgtable.h	2005-11-03 23:21:28.000000000 +0100
@@ -128,6 +128,7 @@ do {									\
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_SET_WRPROTECT
+struct mm_struct;
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long address, pte_t *ptep)
 {
 	pte_t old_pte = *ptep;
diff -urp linux-2.6.14-git3/include/asm-i386/elf.h linux-2.6.14-git3-sr/include/asm-i386/elf.h
--- linux-2.6.14-git3/include/asm-i386/elf.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3-sr/include/asm-i386/elf.h	2005-11-03 23:22:15.000000000 +0100
@@ -119,6 +119,8 @@ typedef struct user_fxsr_struct elf_fpxr
  */
 #define elf_read_implies_exec(ex, executable_stack)	(executable_stack != EXSTACK_DISABLE_X)
 
+struct task_struct;
+
 extern int dump_task_regs (struct task_struct *, elf_gregset_t *);
 extern int dump_task_fpu (struct task_struct *, elf_fpregset_t *);
 extern int dump_task_extended_fpu (struct task_struct *, struct user_fxsr_struct *);
diff -urp linux-2.6.14-git3/include/asm-i386/pgtable.h linux-2.6.14-git3-sr/include/asm-i386/pgtable.h
--- linux-2.6.14-git3/include/asm-i386/pgtable.h	2005-11-03 23:14:39.000000000 +0100
+++ linux-2.6.14-git3-sr/include/asm-i386/pgtable.h	2005-11-03 23:22:36.000000000 +0100
@@ -25,6 +25,9 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 
+struct mm_struct;
+struct vm_area_struct;
+
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
diff -urp linux-2.6.14-git3/include/asm-ia64/pgtable.h linux-2.6.14-git3-sr/include/asm-ia64/pgtable.h
--- linux-2.6.14-git3/include/asm-ia64/pgtable.h	2005-11-03 23:14:39.000000000 +0100
+++ linux-2.6.14-git3-sr/include/asm-ia64/pgtable.h	2005-11-03 23:27:09.000000000 +0100
@@ -127,6 +127,7 @@
 
 # ifndef __ASSEMBLY__
 
+#include <linux/sched.h>	/* for mm_struct */
 #include <asm/bitops.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
diff -urp linux-2.6.14-git3/include/asm-m32r/pgtable.h linux-2.6.14-git3-sr/include/asm-m32r/pgtable.h
--- linux-2.6.14-git3/include/asm-m32r/pgtable.h	2005-11-03 23:14:39.000000000 +0100
+++ linux-2.6.14-git3-sr/include/asm-m32r/pgtable.h	2005-11-03 23:27:19.000000000 +0100
@@ -27,6 +27,9 @@
 #include <asm/bitops.h>
 #include <asm/page.h>
 
+struct mm_struct;
+struct vm_area_struct;
+
 extern pgd_t swapper_pg_dir[1024];
 extern void paging_init(void);
 
diff -urp linux-2.6.14-git3/include/asm-mips/elf.h linux-2.6.14-git3-sr/include/asm-mips/elf.h
--- linux-2.6.14-git3/include/asm-mips/elf.h	2005-11-03 23:14:39.000000000 +0100
+++ linux-2.6.14-git3-sr/include/asm-mips/elf.h	2005-11-03 23:27:48.000000000 +0100
@@ -275,6 +275,8 @@ do {									\
 
 #endif /* CONFIG_64BIT */
 
+struct task_struct;
+
 extern void dump_regs(elf_greg_t *, struct pt_regs *regs);
 extern int dump_task_regs (struct task_struct *, elf_gregset_t *);
 extern int dump_task_fpu(struct task_struct *, elf_fpregset_t *);
diff -urp linux-2.6.14-git3/include/asm-mips/pgtable.h linux-2.6.14-git3-sr/include/asm-mips/pgtable.h
--- linux-2.6.14-git3/include/asm-mips/pgtable.h	2005-11-03 23:14:39.000000000 +0100
+++ linux-2.6.14-git3-sr/include/asm-mips/pgtable.h	2005-11-03 23:28:10.000000000 +0100
@@ -19,6 +19,9 @@
 #include <asm/io.h>
 #include <asm/pgtable-bits.h>
 
+struct mm_struct;
+struct vm_area_struct;
+
 #define PAGE_NONE	__pgprot(_PAGE_PRESENT | _CACHE_CACHABLE_NONCOHERENT)
 #define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
 			PAGE_CACHABLE_DEFAULT)
diff -urp linux-2.6.14-git3/include/asm-parisc/pgtable.h linux-2.6.14-git3-sr/include/asm-parisc/pgtable.h
--- linux-2.6.14-git3/include/asm-parisc/pgtable.h	2005-11-03 23:14:39.000000000 +0100
+++ linux-2.6.14-git3-sr/include/asm-parisc/pgtable.h	2005-11-03 23:52:18.000000000 +0100
@@ -12,6 +12,7 @@
  */
 
 #include <linux/spinlock.h>
+#include <linux/mm.h>		/* for vm_area_struct */
 #include <asm/processor.h>
 #include <asm/cache.h>
 #include <asm/bitops.h>
@@ -418,7 +419,6 @@ extern void paging_init (void);
 
 #define PG_dcache_dirty         PG_arch_1
 
-struct vm_area_struct; /* forward declaration (include/linux/mm.h) */
 extern void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t);
 
 /* Encode and de-code a swap entry */
@@ -464,6 +464,7 @@ static inline int ptep_test_and_clear_di
 
 extern spinlock_t pa_dbit_lock;
 
+struct mm_struct;
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	pte_t old_pte;
diff -urp linux-2.6.14-git3/include/asm-powerpc/elf.h linux-2.6.14-git3-sr/include/asm-powerpc/elf.h
--- linux-2.6.14-git3/include/asm-powerpc/elf.h	2005-11-03 23:14:39.000000000 +0100
+++ linux-2.6.14-git3-sr/include/asm-powerpc/elf.h	2005-11-04 00:21:22.000000000 +0100
@@ -1,11 +1,13 @@
 #ifndef _ASM_POWERPC_ELF_H
 #define _ASM_POWERPC_ELF_H
 
+#include <linux/sched.h>	/* for task_struct */
 #include <asm/types.h>
 #include <asm/ptrace.h>
 #include <asm/cputable.h>
 #include <asm/auxvec.h>
 #include <asm/page.h>
+#include <asm/string.h>
 
 /* PowerPC relocations defined by the ABIs */
 #define R_PPC_NONE		0
diff -urp linux-2.6.14-git3/include/asm-ppc/pgtable.h linux-2.6.14-git3-sr/include/asm-ppc/pgtable.h
--- linux-2.6.14-git3/include/asm-ppc/pgtable.h	2005-11-03 23:14:39.000000000 +0100
+++ linux-2.6.14-git3-sr/include/asm-ppc/pgtable.h	2005-11-04 00:38:45.000000000 +0100
@@ -12,6 +12,7 @@
 #include <asm/processor.h>		/* For TASK_SIZE */
 #include <asm/mmu.h>
 #include <asm/page.h>
+struct mm_struct;
 
 extern unsigned long va_to_phys(unsigned long address);
 extern pte_t *va_to_pte(unsigned long address);
diff -urp linux-2.6.14-git3/include/asm-ppc64/pgtable.h linux-2.6.14-git3-sr/include/asm-ppc64/pgtable.h
--- linux-2.6.14-git3/include/asm-ppc64/pgtable.h	2005-11-03 23:14:39.000000000 +0100
+++ linux-2.6.14-git3-sr/include/asm-ppc64/pgtable.h	2005-11-04 00:37:48.000000000 +0100
@@ -13,6 +13,7 @@
 #include <asm/mmu.h>
 #include <asm/page.h>
 #include <asm/tlbflush.h>
+struct mm_struct;
 #endif /* __ASSEMBLY__ */
 
 /*
diff -urp linux-2.6.14-git3/include/asm-s390/elf.h linux-2.6.14-git3-sr/include/asm-s390/elf.h
--- linux-2.6.14-git3/include/asm-s390/elf.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3-sr/include/asm-s390/elf.h	2005-11-03 23:58:20.000000000 +0100
@@ -96,6 +96,7 @@
  * ELF register definitions..
  */
 
+#include <linux/sched.h>	/* for task_struct */
 #include <asm/ptrace.h>
 #include <asm/user.h>
 #include <asm/system.h>		/* for save_access_regs */
diff -urp linux-2.6.14-git3/include/asm-s390/pgtable.h linux-2.6.14-git3-sr/include/asm-s390/pgtable.h
--- linux-2.6.14-git3/include/asm-s390/pgtable.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3-sr/include/asm-s390/pgtable.h	2005-11-03 23:58:37.000000000 +0100
@@ -36,6 +36,7 @@
 #include <linux/threads.h>
 
 struct vm_area_struct; /* forward declaration (include/linux/mm.h) */
+struct mm_struct;
 
 extern pgd_t swapper_pg_dir[] __attribute__ ((aligned (4096)));
 extern void paging_init(void);
diff -urp linux-2.6.14-git3/include/asm-sh/elf.h linux-2.6.14-git3-sr/include/asm-sh/elf.h
--- linux-2.6.14-git3/include/asm-sh/elf.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3-sr/include/asm-sh/elf.h	2005-11-04 00:04:22.000000000 +0100
@@ -111,6 +111,7 @@ typedef struct user_fpu_struct elf_fpreg
 
 #ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2) set_personality(PER_LINUX_32BIT)
+struct task_struct;
 extern int dump_task_regs (struct task_struct *, elf_gregset_t *);
 extern int dump_task_fpu (struct task_struct *, elf_fpregset_t *);
 
diff -urp linux-2.6.14-git3/include/asm-sh/pgtable.h linux-2.6.14-git3-sr/include/asm-sh/pgtable.h
--- linux-2.6.14-git3/include/asm-sh/pgtable.h	2005-11-03 23:14:39.000000000 +0100
+++ linux-2.6.14-git3-sr/include/asm-sh/pgtable.h	2005-11-04 00:04:37.000000000 +0100
@@ -282,6 +282,8 @@ typedef pte_t *pte_addr_t;
 #define GET_IOSPACE(pfn)		0
 #define GET_PFN(pfn)			(pfn)
 
+struct mm_struct;
+
 /*
  * No page table caches to initialise
  */
diff -urp linux-2.6.14-git3/include/asm-sh64/pgtable.h linux-2.6.14-git3-sr/include/asm-sh64/pgtable.h
--- linux-2.6.14-git3/include/asm-sh64/pgtable.h	2005-11-03 23:14:39.000000000 +0100
+++ linux-2.6.14-git3-sr/include/asm-sh64/pgtable.h	2005-11-04 00:05:26.000000000 +0100
@@ -24,6 +24,8 @@
 #include <linux/threads.h>
 #include <linux/config.h>
 
+struct vm_area_struct;
+
 extern void paging_init(void);
 
 /* We provide our own get_unmapped_area to avoid cache synonym issue */
diff -urp linux-2.6.14-git3/include/asm-x86_64/elf.h linux-2.6.14-git3-sr/include/asm-x86_64/elf.h
--- linux-2.6.14-git3/include/asm-x86_64/elf.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3-sr/include/asm-x86_64/elf.h	2005-11-04 00:05:44.000000000 +0100
@@ -149,6 +149,8 @@ extern void set_personality_64bit(void);
  */
 #define elf_read_implies_exec(ex, executable_stack)	(executable_stack != EXSTACK_DISABLE_X)
 
+struct task_struct;
+
 extern int dump_task_regs (struct task_struct *, elf_gregset_t *);
 extern int dump_task_fpu (struct task_struct *, elf_fpregset_t *);
 
diff -urp linux-2.6.14-git3/include/asm-x86_64/pgtable.h linux-2.6.14-git3-sr/include/asm-x86_64/pgtable.h
--- linux-2.6.14-git3/include/asm-x86_64/pgtable.h	2005-11-03 23:14:39.000000000 +0100
+++ linux-2.6.14-git3-sr/include/asm-x86_64/pgtable.h	2005-11-04 00:06:14.000000000 +0100
@@ -105,6 +105,8 @@ static inline void pgd_clear (pgd_t * pg
 
 #define ptep_get_and_clear(mm,addr,xp)	__pte(xchg(&(xp)->pte, 0))
 
+struct mm_struct;
+
 static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm, unsigned long addr, pte_t *ptep, int full)
 {
 	pte_t pte;
diff -urp linux-2.6.14-git3/include/asm-xtensa/elf.h linux-2.6.14-git3-sr/include/asm-xtensa/elf.h
--- linux-2.6.14-git3/include/asm-xtensa/elf.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3-sr/include/asm-xtensa/elf.h	2005-11-04 00:06:59.000000000 +0100
@@ -209,6 +209,8 @@ extern void xtensa_elf_core_copy_regs (x
 
 #define SET_PERSONALITY(ex, ibcs2) set_personality(PER_LINUX_32BIT)
 
+struct task_struct;
+
 extern void do_copy_regs (xtensa_gregset_t*, struct pt_regs*,
 			  struct task_struct*);
 extern void do_restore_regs (xtensa_gregset_t*, struct pt_regs*,
diff -urp linux-2.6.14-git3/include/asm-xtensa/pgtable.h linux-2.6.14-git3-sr/include/asm-xtensa/pgtable.h
--- linux-2.6.14-git3/include/asm-xtensa/pgtable.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3-sr/include/asm-xtensa/pgtable.h	2005-11-04 00:08:55.000000000 +0100
@@ -278,6 +278,8 @@ static inline void update_pte(pte_t *pte
 #endif
 }
 
+struct mm_struct;
+
 static inline void
 set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pteval)
 {
@@ -294,6 +296,7 @@ set_pmd(pmd_t *pmdp, pmd_t pmdval)
 #endif
 }
 
+struct vm_area_struct;
 
 static inline int
 ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long addr,
diff -urp linux-2.6.14-git3/include/linux/irq.h linux-2.6.14-git3-sr/include/linux/irq.h
--- linux-2.6.14-git3/include/linux/irq.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3-sr/include/linux/irq.h	2005-11-03 23:16:49.000000000 +0100
@@ -10,6 +10,7 @@
  */
 
 #include <linux/config.h>
+#include <asm/smp.h>		/* cpu_online_map */
 
 #if !defined(CONFIG_ARCH_S390)
 
diff -urp linux-2.6.14-git3/include/linux/memory.h linux-2.6.14-git3-sr/include/linux/memory.h
--- linux-2.6.14-git3/include/linux/memory.h	2005-11-03 23:14:39.000000000 +0100
+++ linux-2.6.14-git3-sr/include/linux/memory.h	2005-11-03 23:16:49.000000000 +0100
@@ -54,6 +54,9 @@ struct memory_block {
  */
 #define	MEM_MAPPING_INVALID	(1<<3)
 
+struct notifier_block;
+struct mem_section;
+
 #ifndef CONFIG_MEMORY_HOTPLUG
 static inline int memory_dev_init(void)
 {
diff -urp linux-2.6.14-git3/include/linux/sem.h linux-2.6.14-git3-sr/include/linux/sem.h
--- linux-2.6.14-git3/include/linux/sem.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3-sr/include/linux/sem.h	2005-11-04 00:09:17.000000000 +0100
@@ -79,6 +79,8 @@ struct  seminfo {
 
 #ifdef __KERNEL__
 
+struct task_struct;
+
 /* One semaphore structure for each semaphore in the system. */
 struct sem {
 	int	semval;		/* current value */
diff -urp linux-2.6.14-git3/include/linux/wait.h linux-2.6.14-git3-sr/include/linux/wait.h
--- linux-2.6.14-git3/include/linux/wait.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3-sr/include/linux/wait.h	2005-11-04 00:09:42.000000000 +0100
@@ -54,6 +54,7 @@ struct __wait_queue_head {
 };
 typedef struct __wait_queue_head wait_queue_head_t;
 
+struct task_struct;
 
 /*
  * Macros for declaration and initialisaton of the datatypes
diff -urp linux-2.6.14-git3/kernel/module.c linux-2.6.14-git3-sr/kernel/module.c
--- linux-2.6.14-git3/kernel/module.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14-git3-sr/kernel/module.c	2005-11-03 23:16:49.000000000 +0100
@@ -37,6 +37,7 @@
 #include <linux/stop_machine.h>
 #include <linux/device.h>
 #include <linux/string.h>
+#include <linux/sched.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 #include <asm/cacheflush.h>
