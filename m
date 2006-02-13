Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWBMJkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWBMJkF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 04:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWBMJkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 04:40:05 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:6796 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751254AbWBMJkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 04:40:01 -0500
Date: Mon, 13 Feb 2006 10:39:59 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove duplicate #includes 
Message-ID: <20060213093959.GA10496@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew! Folks!

recently I stumbled over a few files which #include the 
same .h file twice -- sometimes even in the immediately
following line. so I thought I'd look into that to reduce 
the amount of duplicate includes in the kernel ...

I first searched for 'potential' duplicates with the
following command sequence ...

  find . -type f -name '*.[hcS]' -exec gawk '/^#include/ { X[$2]++ } END { for (n in X) if (X[n]>1) printf("%s: %s[%d]\n",FILENAME,n,X[n]); }' {} \;

.. then, I inspected each of the results, and if it was
valid, I removed every but the first occurence (of course 
only after detailed inspection)

I will do a bunch of further tests with this patch to
make absolutely 100% sure that there are no bad changes.
the patch contains the obvious cases first, and the not
so obvious ones at the end.

best,
Herbert


Signed-off-by: Herbert Pötzl <herbert@13thfloor.at>
---
diff -NurpP --minimal linux-2.6.16-rc2/arch/alpha/kernel/setup.c linux-2.6.16-rc2-mpf/arch/alpha/kernel/setup.c
--- linux-2.6.16-rc2/arch/alpha/kernel/setup.c	2005-06-22 02:37:51 +0200
+++ linux-2.6.16-rc2-mpf/arch/alpha/kernel/setup.c	2006-02-13 01:23:59 +0100
@@ -55,7 +55,6 @@ static struct notifier_block alpha_panic
 #include <asm/system.h>
 #include <asm/hwrpb.h>
 #include <asm/dma.h>
-#include <asm/io.h>
 #include <asm/mmu_context.h>
 #include <asm/console.h>
 
diff -NurpP --minimal linux-2.6.16-rc2/arch/arm/mach-iop3xx/iop321-setup.c linux-2.6.16-rc2-mpf/arch/arm/mach-iop3xx/iop321-setup.c
--- linux-2.6.16-rc2/arch/arm/mach-iop3xx/iop321-setup.c	2006-02-07 11:52:06 +0100
+++ linux-2.6.16-rc2-mpf/arch/arm/mach-iop3xx/iop321-setup.c	2006-02-13 01:14:57 +0100
@@ -13,7 +13,6 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/config.h>
-#include <linux/init.h>
 #include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/platform_device.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/arm/mach-iop3xx/iop331-setup.c linux-2.6.16-rc2-mpf/arch/arm/mach-iop3xx/iop331-setup.c
--- linux-2.6.16-rc2/arch/arm/mach-iop3xx/iop331-setup.c	2006-02-07 11:52:06 +0100
+++ linux-2.6.16-rc2-mpf/arch/arm/mach-iop3xx/iop331-setup.c	2006-02-13 01:15:09 +0100
@@ -12,7 +12,6 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/config.h>
-#include <linux/init.h>
 #include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/platform_device.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/arm/plat-omap/pm.c linux-2.6.16-rc2-mpf/arch/arm/plat-omap/pm.c
--- linux-2.6.16-rc2/arch/arm/plat-omap/pm.c	2006-01-03 17:29:08 +0100
+++ linux-2.6.16-rc2-mpf/arch/arm/plat-omap/pm.c	2006-02-13 01:15:24 +0100
@@ -38,7 +38,6 @@
 #include <linux/pm.h>
 #include <linux/sched.h>
 #include <linux/proc_fs.h>
-#include <linux/pm.h>
 #include <linux/interrupt.h>
 
 #include <asm/io.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/arm26/kernel/armksyms.c linux-2.6.16-rc2-mpf/arch/arm26/kernel/armksyms.c
--- linux-2.6.16-rc2/arch/arm26/kernel/armksyms.c	2006-02-07 11:52:07 +0100
+++ linux-2.6.16-rc2-mpf/arch/arm26/kernel/armksyms.c	2006-02-13 01:21:41 +0100
@@ -9,7 +9,6 @@
  */
 #include <linux/module.h>
 #include <linux/config.h>
-#include <linux/module.h>
 #include <linux/user.h>
 #include <linux/string.h>
 #include <linux/fs.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/cris/arch-v32/mm/init.c linux-2.6.16-rc2-mpf/arch/cris/arch-v32/mm/init.c
--- linux-2.6.16-rc2/arch/cris/arch-v32/mm/init.c	2005-08-29 22:24:51 +0200
+++ linux-2.6.16-rc2-mpf/arch/cris/arch-v32/mm/init.c	2006-02-13 01:21:29 +0100
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/bootmem.h>
 #include <linux/mm.h>
-#include <linux/config.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <asm/types.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/i386/kernel/cpuid.c linux-2.6.16-rc2-mpf/arch/i386/kernel/cpuid.c
--- linux-2.6.16-rc2/arch/i386/kernel/cpuid.c	2006-02-07 11:52:08 +0100
+++ linux-2.6.16-rc2-mpf/arch/i386/kernel/cpuid.c	2006-02-13 01:14:41 +0100
@@ -35,7 +35,6 @@
 #include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/smp_lock.h>
-#include <linux/fs.h>
 #include <linux/device.h>
 #include <linux/cpu.h>
 #include <linux/notifier.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/ia64/ia32/ia32priv.h linux-2.6.16-rc2-mpf/arch/ia64/ia32/ia32priv.h
--- linux-2.6.16-rc2/arch/ia64/ia32/ia32priv.h	2006-01-03 17:29:09 +0100
+++ linux-2.6.16-rc2-mpf/arch/ia64/ia32/ia32priv.h	2006-02-13 01:23:38 +0100
@@ -291,7 +291,6 @@ struct old_linux32_dirent {
 #define _ASM_IA64_ELF_H		/* Don't include elf.h */
 
 #include <linux/sched.h>
-#include <asm/processor.h>
 
 /*
  * This is used to ensure we don't load something for the wrong architecture.
diff -NurpP --minimal linux-2.6.16-rc2/arch/ia64/ia32/sys_ia32.c linux-2.6.16-rc2-mpf/arch/ia64/ia32/sys_ia32.c
--- linux-2.6.16-rc2/arch/ia64/ia32/sys_ia32.c	2006-02-07 11:52:08 +0100
+++ linux-2.6.16-rc2-mpf/arch/ia64/ia32/sys_ia32.c	2006-02-13 01:22:43 +0100
@@ -36,7 +36,6 @@
 #include <linux/uio.h>
 #include <linux/nfs_fs.h>
 #include <linux/quota.h>
-#include <linux/syscalls.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/nfsd/nfsd.h>
 #include <linux/nfsd/cache.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/ia64/kernel/setup.c linux-2.6.16-rc2-mpf/arch/ia64/kernel/setup.c
--- linux-2.6.16-rc2/arch/ia64/kernel/setup.c	2006-02-07 11:52:08 +0100
+++ linux-2.6.16-rc2-mpf/arch/ia64/kernel/setup.c	2006-02-13 01:21:56 +0100
@@ -60,7 +60,6 @@
 #include <asm/smp.h>
 #include <asm/system.h>
 #include <asm/unistd.h>
-#include <asm/system.h>
 
 #if defined(CONFIG_SMP) && (IA64_CPU_SIZE > PAGE_SIZE)
 # error "struct cpuinfo_ia64 too big!"
diff -NurpP --minimal linux-2.6.16-rc2/arch/ia64/kernel/time.c linux-2.6.16-rc2-mpf/arch/ia64/kernel/time.c
--- linux-2.6.16-rc2/arch/ia64/kernel/time.c	2006-01-03 17:29:09 +0100
+++ linux-2.6.16-rc2-mpf/arch/ia64/kernel/time.c	2006-02-13 01:22:11 +0100
@@ -19,7 +19,6 @@
 #include <linux/time.h>
 #include <linux/interrupt.h>
 #include <linux/efi.h>
-#include <linux/profile.h>
 #include <linux/timex.h>
 
 #include <asm/machvec.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/ia64/sn/kernel/setup.c linux-2.6.16-rc2-mpf/arch/ia64/sn/kernel/setup.c
--- linux-2.6.16-rc2/arch/ia64/sn/kernel/setup.c	2006-01-03 17:29:09 +0100
+++ linux-2.6.16-rc2-mpf/arch/ia64/sn/kernel/setup.c	2006-02-13 01:22:27 +0100
@@ -26,7 +26,6 @@
 #include <linux/interrupt.h>
 #include <linux/acpi.h>
 #include <linux/compiler.h>
-#include <linux/sched.h>
 #include <linux/root_dev.h>
 #include <linux/nodemask.h>
 #include <linux/pm.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/m68knommu/platform/5206e/config.c linux-2.6.16-rc2-mpf/arch/m68knommu/platform/5206e/config.c
--- linux-2.6.16-rc2/arch/m68knommu/platform/5206e/config.c	2004-12-25 01:54:45 +0100
+++ linux-2.6.16-rc2-mpf/arch/m68knommu/platform/5206e/config.c	2006-02-13 01:19:07 +0100
@@ -21,7 +21,6 @@
 #include <asm/mcftimer.h>
 #include <asm/mcfsim.h>
 #include <asm/mcfdma.h>
-#include <asm/irq.h>
 
 /***************************************************************************/
 
diff -NurpP --minimal linux-2.6.16-rc2/arch/mips/kernel/signal_n32.c linux-2.6.16-rc2-mpf/arch/mips/kernel/signal_n32.c
--- linux-2.6.16-rc2/arch/mips/kernel/signal_n32.c	2006-01-03 17:29:11 +0100
+++ linux-2.6.16-rc2-mpf/arch/mips/kernel/signal_n32.c	2006-02-13 01:15:39 +0100
@@ -17,7 +17,6 @@
  */
 #include <linux/cache.h>
 #include <linux/sched.h>
-#include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/mips/mips-boards/generic/time.c linux-2.6.16-rc2-mpf/arch/mips/mips-boards/generic/time.c
--- linux-2.6.16-rc2/arch/mips/mips-boards/generic/time.c	2006-02-07 11:52:10 +0100
+++ linux-2.6.16-rc2-mpf/arch/mips/mips-boards/generic/time.c	2006-02-13 01:17:20 +0100
@@ -42,7 +42,6 @@
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/prom.h>
 #include <asm/mips-boards/maltaint.h>
-#include <asm/mc146818-time.h>
 
 unsigned long cpu_khz;
 
diff -NurpP --minimal linux-2.6.16-rc2/arch/mips/mips-boards/sim/sim_time.c linux-2.6.16-rc2-mpf/arch/mips/mips-boards/sim/sim_time.c
--- linux-2.6.16-rc2/arch/mips/mips-boards/sim/sim_time.c	2006-01-03 17:29:12 +0100
+++ linux-2.6.16-rc2-mpf/arch/mips/mips-boards/sim/sim_time.c	2006-02-13 01:18:08 +0100
@@ -15,20 +15,13 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <linux/timex.h>
-#include <asm/mipsregs.h>
-#include <asm/ptrace.h>
-#include <asm/hardirq.h>
 #include <asm/irq.h>
-#include <asm/div64.h>
-#include <asm/cpu.h>
-#include <asm/time.h>
 #include <asm/mc146818-time.h>
 #include <asm/msc01_ic.h>
 
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/prom.h>
 #include <asm/mips-boards/simint.h>
-#include <asm/mc146818-time.h>
 #include <asm/smp.h>
 
 
diff -NurpP --minimal linux-2.6.16-rc2/arch/mips/sibyte/bcm1480/time.c linux-2.6.16-rc2-mpf/arch/mips/sibyte/bcm1480/time.c
--- linux-2.6.16-rc2/arch/mips/sibyte/bcm1480/time.c	2006-01-03 17:29:12 +0100
+++ linux-2.6.16-rc2-mpf/arch/mips/sibyte/bcm1480/time.c	2006-02-13 01:18:35 +0100
@@ -99,8 +99,6 @@ void bcm1480_time_init(void)
 	 */
 }
 
-#include <asm/sibyte/sb1250.h>
-
 void bcm1480_timer_interrupt(struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
diff -NurpP --minimal linux-2.6.16-rc2/arch/mips/tx4938/common/setup.c linux-2.6.16-rc2-mpf/arch/mips/tx4938/common/setup.c
--- linux-2.6.16-rc2/arch/mips/tx4938/common/setup.c	2006-01-03 17:29:12 +0100
+++ linux-2.6.16-rc2-mpf/arch/mips/tx4938/common/setup.c	2006-02-13 01:18:48 +0100
@@ -31,7 +31,6 @@
 #include <asm/mipsregs.h>
 #include <asm/system.h>
 #include <asm/time.h>
-#include <asm/time.h>
 #include <asm/tx4938/rbtx4938.h>
 
 extern void toshiba_rbtx4938_setup(void);
diff -NurpP --minimal linux-2.6.16-rc2/arch/parisc/kernel/signal.c linux-2.6.16-rc2-mpf/arch/parisc/kernel/signal.c
--- linux-2.6.16-rc2/arch/parisc/kernel/signal.c	2006-01-03 17:29:13 +0100
+++ linux-2.6.16-rc2-mpf/arch/parisc/kernel/signal.c	2006-02-13 01:24:26 +0100
@@ -24,7 +24,6 @@
 #include <linux/ptrace.h>
 #include <linux/unistd.h>
 #include <linux/stddef.h>
-#include <linux/compat.h>
 #include <linux/elf.h>
 #include <linux/personality.h>
 #include <asm/ucontext.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/powerpc/kernel/btext.c linux-2.6.16-rc2-mpf/arch/powerpc/kernel/btext.c
--- linux-2.6.16-rc2/arch/powerpc/kernel/btext.c	2006-02-07 11:52:11 +0100
+++ linux-2.6.16-rc2-mpf/arch/powerpc/kernel/btext.c	2006-02-13 01:30:41 +0100
@@ -12,7 +12,6 @@
 #include <asm/sections.h>
 #include <asm/prom.h>
 #include <asm/btext.h>
-#include <asm/prom.h>
 #include <asm/page.h>
 #include <asm/mmu.h>
 #include <asm/pgtable.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/powerpc/kernel/iommu.c linux-2.6.16-rc2-mpf/arch/powerpc/kernel/iommu.c
--- linux-2.6.16-rc2/arch/powerpc/kernel/iommu.c	2006-01-03 17:29:13 +0100
+++ linux-2.6.16-rc2-mpf/arch/powerpc/kernel/iommu.c	2006-02-13 01:30:57 +0100
@@ -32,7 +32,6 @@
 #include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/dma-mapping.h>
-#include <linux/init.h>
 #include <linux/bitops.h>
 #include <asm/io.h>
 #include <asm/prom.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/powerpc/kernel/time.c linux-2.6.16-rc2-mpf/arch/powerpc/kernel/time.c
--- linux-2.6.16-rc2/arch/powerpc/kernel/time.c	2006-02-07 11:52:11 +0100
+++ linux-2.6.16-rc2-mpf/arch/powerpc/kernel/time.c	2006-02-13 01:31:44 +0100
@@ -70,7 +70,6 @@
 #include <asm/iseries/it_lp_queue.h>
 #include <asm/iseries/hv_call_xm.h>
 #endif
-#include <asm/smp.h>
 
 /* keep track of when we need to update the rtc */
 time_t last_rtc_update;
diff -NurpP --minimal linux-2.6.16-rc2/arch/powerpc/mm/hash_utils_64.c linux-2.6.16-rc2-mpf/arch/powerpc/mm/hash_utils_64.c
--- linux-2.6.16-rc2/arch/powerpc/mm/hash_utils_64.c	2006-02-07 11:52:11 +0100
+++ linux-2.6.16-rc2-mpf/arch/powerpc/mm/hash_utils_64.c	2006-02-13 01:32:00 +0100
@@ -50,7 +50,6 @@
 #include <asm/tlb.h>
 #include <asm/cacheflush.h>
 #include <asm/cputable.h>
-#include <asm/abs_addr.h>
 #include <asm/sections.h>
 
 #ifdef DEBUG
diff -NurpP --minimal linux-2.6.16-rc2/arch/powerpc/mm/hugetlbpage.c linux-2.6.16-rc2-mpf/arch/powerpc/mm/hugetlbpage.c
--- linux-2.6.16-rc2/arch/powerpc/mm/hugetlbpage.c	2006-02-07 11:52:11 +0100
+++ linux-2.6.16-rc2-mpf/arch/powerpc/mm/hugetlbpage.c	2006-02-13 01:32:36 +0100
@@ -23,9 +23,6 @@
 #include <asm/mmu_context.h>
 #include <asm/machdep.h>
 #include <asm/cputable.h>
-#include <asm/tlb.h>
-
-#include <linux/sysctl.h>
 
 #define NUM_LOW_AREAS	(0x100000000UL >> SID_SHIFT)
 #define NUM_HIGH_AREAS	(PGTABLE_RANGE >> HTLB_AREA_SHIFT)
diff -NurpP --minimal linux-2.6.16-rc2/arch/powerpc/mm/init_32.c linux-2.6.16-rc2-mpf/arch/powerpc/mm/init_32.c
--- linux-2.6.16-rc2/arch/powerpc/mm/init_32.c	2006-02-07 11:52:11 +0100
+++ linux-2.6.16-rc2-mpf/arch/powerpc/mm/init_32.c	2006-02-13 01:32:50 +0100
@@ -43,7 +43,6 @@
 #include <asm/machdep.h>
 #include <asm/btext.h>
 #include <asm/tlb.h>
-#include <asm/prom.h>
 #include <asm/lmb.h>
 #include <asm/sections.h>
 
diff -NurpP --minimal linux-2.6.16-rc2/arch/powerpc/mm/mem.c linux-2.6.16-rc2-mpf/arch/powerpc/mm/mem.c
--- linux-2.6.16-rc2/arch/powerpc/mm/mem.c	2006-02-07 11:52:11 +0100
+++ linux-2.6.16-rc2-mpf/arch/powerpc/mm/mem.c	2006-02-13 01:33:04 +0100
@@ -43,7 +43,6 @@
 #include <asm/machdep.h>
 #include <asm/btext.h>
 #include <asm/tlb.h>
-#include <asm/prom.h>
 #include <asm/lmb.h>
 #include <asm/sections.h>
 #include <asm/vdso.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/powerpc/platforms/cell/iommu.c linux-2.6.16-rc2-mpf/arch/powerpc/platforms/cell/iommu.c
--- linux-2.6.16-rc2/arch/powerpc/platforms/cell/iommu.c	2006-02-07 11:52:11 +0100
+++ linux-2.6.16-rc2-mpf/arch/powerpc/platforms/cell/iommu.c	2006-02-13 01:33:19 +0100
@@ -29,7 +29,6 @@
 #include <linux/bootmem.h>
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
-#include <linux/kernel.h>
 #include <linux/compiler.h>
 
 #include <asm/sections.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/powerpc/platforms/chrp/setup.c linux-2.6.16-rc2-mpf/arch/powerpc/platforms/chrp/setup.c
--- linux-2.6.16-rc2/arch/powerpc/platforms/chrp/setup.c	2006-02-07 11:52:11 +0100
+++ linux-2.6.16-rc2-mpf/arch/powerpc/platforms/chrp/setup.c	2006-02-13 01:33:33 +0100
@@ -36,7 +36,6 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/initrd.h>
-#include <linux/module.h>
 
 #include <asm/io.h>
 #include <asm/pgtable.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/powerpc/platforms/chrp/smp.c linux-2.6.16-rc2-mpf/arch/powerpc/platforms/chrp/smp.c
--- linux-2.6.16-rc2/arch/powerpc/platforms/chrp/smp.c	2006-01-03 17:29:13 +0100
+++ linux-2.6.16-rc2-mpf/arch/powerpc/platforms/chrp/smp.c	2006-02-13 01:33:51 +0100
@@ -32,7 +32,6 @@
 #include <asm/time.h>
 #include <asm/open_pic.h>
 #include <asm/machdep.h>
-#include <asm/smp.h>
 #include <asm/mpic.h>
 #include <asm/rtas.h>
 
diff -NurpP --minimal linux-2.6.16-rc2/arch/powerpc/platforms/iseries/setup.c linux-2.6.16-rc2-mpf/arch/powerpc/platforms/iseries/setup.c
--- linux-2.6.16-rc2/arch/powerpc/platforms/iseries/setup.c	2006-02-07 11:52:11 +0100
+++ linux-2.6.16-rc2-mpf/arch/powerpc/platforms/iseries/setup.c	2006-02-13 01:34:07 +0100
@@ -43,7 +43,6 @@
 #include <asm/time.h>
 #include <asm/paca.h>
 #include <asm/cache.h>
-#include <asm/sections.h>
 #include <asm/abs_addr.h>
 #include <asm/iseries/hv_lp_config.h>
 #include <asm/iseries/hv_call_event.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/powerpc/platforms/powermac/low_i2c.c linux-2.6.16-rc2-mpf/arch/powerpc/platforms/powermac/low_i2c.c
--- linux-2.6.16-rc2/arch/powerpc/platforms/powermac/low_i2c.c	2006-02-07 11:52:12 +0100
+++ linux-2.6.16-rc2-mpf/arch/powerpc/platforms/powermac/low_i2c.c	2006-02-13 01:34:26 +0100
@@ -41,7 +41,6 @@
 #include <linux/completion.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
-#include <linux/completion.h>
 #include <linux/timer.h>
 #include <asm/keylargo.h>
 #include <asm/uninorth.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/powerpc/platforms/powermac/setup.c linux-2.6.16-rc2-mpf/arch/powerpc/platforms/powermac/setup.c
--- linux-2.6.16-rc2/arch/powerpc/platforms/powermac/setup.c	2006-02-07 11:52:12 +0100
+++ linux-2.6.16-rc2-mpf/arch/powerpc/platforms/powermac/setup.c	2006-02-13 01:35:28 +0100
@@ -76,7 +76,6 @@
 #include <asm/smu.h>
 #include <asm/pmc.h>
 #include <asm/lmb.h>
-#include <asm/udbg.h>
 
 #include "pmac.h"
 
diff -NurpP --minimal linux-2.6.16-rc2/arch/powerpc/platforms/powermac/udbg_adb.c linux-2.6.16-rc2-mpf/arch/powerpc/platforms/powermac/udbg_adb.c
--- linux-2.6.16-rc2/arch/powerpc/platforms/powermac/udbg_adb.c	2006-02-07 11:52:12 +0100
+++ linux-2.6.16-rc2-mpf/arch/powerpc/platforms/powermac/udbg_adb.c	2006-02-13 01:35:45 +0100
@@ -13,7 +13,6 @@
 #include <asm/xmon.h>
 #include <asm/prom.h>
 #include <asm/bootx.h>
-#include <asm/machdep.h>
 #include <asm/errno.h>
 #include <asm/pmac_feature.h>
 #include <asm/processor.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/powerpc/platforms/pseries/lpar.c linux-2.6.16-rc2-mpf/arch/powerpc/platforms/pseries/lpar.c
--- linux-2.6.16-rc2/arch/powerpc/platforms/pseries/lpar.c	2006-02-07 11:52:12 +0100
+++ linux-2.6.16-rc2-mpf/arch/powerpc/platforms/pseries/lpar.c	2006-02-13 01:36:00 +0100
@@ -36,7 +36,6 @@
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include <asm/prom.h>
-#include <asm/abs_addr.h>
 #include <asm/cputable.h>
 #include <asm/udbg.h>
 #include <asm/smp.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/ppc/platforms/85xx/stx_gp3.c linux-2.6.16-rc2-mpf/arch/ppc/platforms/85xx/stx_gp3.c
--- linux-2.6.16-rc2/arch/ppc/platforms/85xx/stx_gp3.c	2006-02-07 11:52:12 +0100
+++ linux-2.6.16-rc2-mpf/arch/ppc/platforms/85xx/stx_gp3.c	2006-02-13 01:12:30 +0100
@@ -53,7 +53,6 @@
 #include <asm/irq.h>
 #include <asm/immap_85xx.h>
 #include <asm/cpm2.h>
-#include <asm/mpc85xx.h>
 #include <asm/ppc_sys.h>
 
 #include <syslib/cpm2_pic.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/ppc/platforms/chrp_setup.c linux-2.6.16-rc2-mpf/arch/ppc/platforms/chrp_setup.c
--- linux-2.6.16-rc2/arch/ppc/platforms/chrp_setup.c	2006-02-07 11:52:12 +0100
+++ linux-2.6.16-rc2-mpf/arch/ppc/platforms/chrp_setup.c	2006-02-13 01:12:50 +0100
@@ -36,7 +36,6 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/initrd.h>
-#include <linux/module.h>
 
 #include <asm/io.h>
 #include <asm/pgtable.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/ppc/syslib/gt64260_pic.c linux-2.6.16-rc2-mpf/arch/ppc/syslib/gt64260_pic.c
--- linux-2.6.16-rc2/arch/ppc/syslib/gt64260_pic.c	2006-01-03 17:29:14 +0100
+++ linux-2.6.16-rc2-mpf/arch/ppc/syslib/gt64260_pic.c	2006-02-13 01:11:03 +0100
@@ -37,7 +37,6 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
-#include <linux/stddef.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
 
diff -NurpP --minimal linux-2.6.16-rc2/arch/ppc/syslib/mpc52xx_pic.c linux-2.6.16-rc2-mpf/arch/ppc/syslib/mpc52xx_pic.c
--- linux-2.6.16-rc2/arch/ppc/syslib/mpc52xx_pic.c	2005-06-22 02:37:57 +0200
+++ linux-2.6.16-rc2-mpf/arch/ppc/syslib/mpc52xx_pic.c	2006-02-13 01:12:05 +0100
@@ -22,7 +22,6 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
-#include <linux/stddef.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
 
diff -NurpP --minimal linux-2.6.16-rc2/arch/ppc/syslib/mv64360_pic.c linux-2.6.16-rc2-mpf/arch/ppc/syslib/mv64360_pic.c
--- linux-2.6.16-rc2/arch/ppc/syslib/mv64360_pic.c	2006-01-03 17:29:15 +0100
+++ linux-2.6.16-rc2-mpf/arch/ppc/syslib/mv64360_pic.c	2006-02-13 01:11:45 +0100
@@ -38,7 +38,6 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
-#include <linux/stddef.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/ppc/syslib/ppc83xx_setup.c linux-2.6.16-rc2-mpf/arch/ppc/syslib/ppc83xx_setup.c
--- linux-2.6.16-rc2/arch/ppc/syslib/ppc83xx_setup.c	2006-01-03 17:29:15 +0100
+++ linux-2.6.16-rc2-mpf/arch/ppc/syslib/ppc83xx_setup.c	2006-02-13 01:11:29 +0100
@@ -44,7 +44,6 @@
 
 #include <syslib/ppc83xx_setup.h>
 #if defined(CONFIG_PCI)
-#include <asm/delay.h>
 #include <syslib/ppc83xx_pci.h>
 #endif
 
diff -NurpP --minimal linux-2.6.16-rc2/arch/ppc/xmon/start.c linux-2.6.16-rc2-mpf/arch/ppc/xmon/start.c
--- linux-2.6.16-rc2/arch/ppc/xmon/start.c	2006-02-07 11:52:12 +0100
+++ linux-2.6.16-rc2-mpf/arch/ppc/xmon/start.c	2006-02-13 01:13:07 +0100
@@ -16,7 +16,6 @@
 #include <asm/xmon.h>
 #include <asm/prom.h>
 #include <asm/bootx.h>
-#include <asm/machdep.h>
 #include <asm/errno.h>
 #include <asm/processor.h>
 #include <asm/delay.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/sh/kernel/sh_ksyms.c linux-2.6.16-rc2-mpf/arch/sh/kernel/sh_ksyms.c
--- linux-2.6.16-rc2/arch/sh/kernel/sh_ksyms.c	2006-02-07 11:52:13 +0100
+++ linux-2.6.16-rc2-mpf/arch/sh/kernel/sh_ksyms.c	2006-02-13 01:19:42 +0100
@@ -19,7 +19,6 @@
 #include <asm/delay.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
-#include <asm/checksum.h>
 
 extern int dump_fpu(struct pt_regs *, elf_fpregset_t *);
 extern struct hw_interrupt_type no_irq_type;
diff -NurpP --minimal linux-2.6.16-rc2/arch/sh/kernel/smp.c linux-2.6.16-rc2-mpf/arch/sh/kernel/smp.c
--- linux-2.6.16-rc2/arch/sh/kernel/smp.c	2006-02-07 11:52:13 +0100
+++ linux-2.6.16-rc2-mpf/arch/sh/kernel/smp.c	2006-02-13 01:20:08 +0100
@@ -22,7 +22,6 @@
 #include <linux/time.h>
 #include <linux/timex.h>
 #include <linux/sched.h>
-#include <linux/module.h>
 
 #include <asm/atomic.h>
 #include <asm/processor.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/sh64/kernel/setup.c linux-2.6.16-rc2-mpf/arch/sh64/kernel/setup.c
--- linux-2.6.16-rc2/arch/sh64/kernel/setup.c	2005-06-22 02:37:59 +0200
+++ linux-2.6.16-rc2-mpf/arch/sh64/kernel/setup.c	2006-02-13 01:25:19 +0100
@@ -44,7 +44,6 @@
 #include <linux/seq_file.h>
 #include <linux/blkdev.h>
 #include <linux/bootmem.h>
-#include <linux/console.h>
 #include <linux/root_dev.h>
 #include <linux/cpu.h>
 #include <linux/initrd.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/sh64/kernel/signal.c linux-2.6.16-rc2-mpf/arch/sh64/kernel/signal.c
--- linux-2.6.16-rc2/arch/sh64/kernel/signal.c	2005-10-28 20:49:15 +0200
+++ linux-2.6.16-rc2-mpf/arch/sh64/kernel/signal.c	2006-02-13 01:25:03 +0100
@@ -26,7 +26,6 @@
 #include <linux/ptrace.h>
 #include <linux/unistd.h>
 #include <linux/stddef.h>
-#include <linux/personality.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/sh64/kernel/traps.c linux-2.6.16-rc2-mpf/arch/sh64/kernel/traps.c
--- linux-2.6.16-rc2/arch/sh64/kernel/traps.c	2005-06-22 02:37:59 +0200
+++ linux-2.6.16-rc2-mpf/arch/sh64/kernel/traps.c	2006-02-13 01:25:46 +0100
@@ -244,8 +244,6 @@ DO_ERROR(12, SIGILL,  "reserved instruct
 #endif /* CONFIG_SH64_ID2815_WORKAROUND */
 
 
-#include <asm/system.h>
-
 /* Called with interrupts disabled */
 asmlinkage void do_exception_error(unsigned long ex, struct pt_regs *regs)
 {
diff -NurpP --minimal linux-2.6.16-rc2/arch/sparc/kernel/irq.c linux-2.6.16-rc2-mpf/arch/sparc/kernel/irq.c
--- linux-2.6.16-rc2/arch/sparc/kernel/irq.c	2005-03-02 12:38:25 +0100
+++ linux-2.6.16-rc2-mpf/arch/sparc/kernel/irq.c	2006-02-13 01:10:36 +0100
@@ -19,7 +19,6 @@
 #include <linux/linkage.h>
 #include <linux/kernel_stat.h>
 #include <linux/signal.h>
-#include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/random.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/sparc64/kernel/module.c linux-2.6.16-rc2-mpf/arch/sparc64/kernel/module.c
--- linux-2.6.16-rc2/arch/sparc64/kernel/module.c	2005-06-22 02:38:00 +0200
+++ linux-2.6.16-rc2-mpf/arch/sparc64/kernel/module.c	2006-02-13 01:14:27 +0100
@@ -11,7 +11,6 @@
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/mm.h>
 
 #include <asm/processor.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/sparc64/kernel/process.c linux-2.6.16-rc2-mpf/arch/sparc64/kernel/process.c
--- linux-2.6.16-rc2/arch/sparc64/kernel/process.c	2006-02-07 11:52:14 +0100
+++ linux-2.6.16-rc2-mpf/arch/sparc64/kernel/process.c	2006-02-13 01:13:22 +0100
@@ -26,7 +26,6 @@
 #include <linux/slab.h>
 #include <linux/user.h>
 #include <linux/a.out.h>
-#include <linux/config.h>
 #include <linux/reboot.h>
 #include <linux/delay.h>
 #include <linux/compat.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/sparc64/kernel/sys_sparc32.c linux-2.6.16-rc2-mpf/arch/sparc64/kernel/sys_sparc32.c
--- linux-2.6.16-rc2/arch/sparc64/kernel/sys_sparc32.c	2006-02-07 11:52:16 +0100
+++ linux-2.6.16-rc2-mpf/arch/sparc64/kernel/sys_sparc32.c	2006-02-13 01:14:12 +0100
@@ -54,7 +54,6 @@
 #include <linux/vfs.h>
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/ptrace.h>
-#include <linux/highuid.h>
 
 #include <asm/types.h>
 #include <asm/ipc.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/sparc64/kernel/sys_sunos32.c linux-2.6.16-rc2-mpf/arch/sparc64/kernel/sys_sunos32.c
--- linux-2.6.16-rc2/arch/sparc64/kernel/sys_sunos32.c	2006-02-07 11:52:16 +0100
+++ linux-2.6.16-rc2-mpf/arch/sparc64/kernel/sys_sunos32.c	2006-02-13 01:13:58 +0100
@@ -56,7 +56,6 @@
 #include <linux/personality.h>
 
 /* For SOCKET_I */
-#include <linux/socket.h>
 #include <net/sock.h>
 #include <net/compat.h>
 
diff -NurpP --minimal linux-2.6.16-rc2/arch/sparc64/kernel/time.c linux-2.6.16-rc2-mpf/arch/sparc64/kernel/time.c
--- linux-2.6.16-rc2/arch/sparc64/kernel/time.c	2006-02-07 11:52:16 +0100
+++ linux-2.6.16-rc2-mpf/arch/sparc64/kernel/time.c	2006-02-13 01:13:37 +0100
@@ -29,7 +29,6 @@
 #include <linux/jiffies.h>
 #include <linux/cpufreq.h>
 #include <linux/percpu.h>
-#include <linux/profile.h>
 
 #include <asm/oplib.h>
 #include <asm/mostek.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/um/kernel/trap_kern.c linux-2.6.16-rc2-mpf/arch/um/kernel/trap_kern.c
--- linux-2.6.16-rc2/arch/um/kernel/trap_kern.c	2006-02-07 11:52:17 +0100
+++ linux-2.6.16-rc2-mpf/arch/um/kernel/trap_kern.c	2006-02-13 01:20:41 +0100
@@ -26,13 +26,11 @@
 #include "mconsole_kern.h"
 #include "mem.h"
 #include "mem_kern.h"
-#include "sysdep/sigcontext.h"
 #include "sysdep/ptrace.h"
 #include "os.h"
 #ifdef CONFIG_MODE_SKAS
 #include "skas.h"
 #endif
-#include "os.h"
 
 /* Note this is constrained to return 0, -EFAULT, -EACCESS, -ENOMEM by segv(). */
 int handle_page_fault(unsigned long address, unsigned long ip, 
diff -NurpP --minimal linux-2.6.16-rc2/arch/x86_64/kernel/x8664_ksyms.c linux-2.6.16-rc2-mpf/arch/x86_64/kernel/x8664_ksyms.c
--- linux-2.6.16-rc2/arch/x86_64/kernel/x8664_ksyms.c	2006-02-07 11:52:18 +0100
+++ linux-2.6.16-rc2-mpf/arch/x86_64/kernel/x8664_ksyms.c	2006-02-13 01:26:38 +0100
@@ -30,7 +30,6 @@
 #include <asm/kdebug.h>
 #include <asm/unistd.h>
 #include <asm/tlbflush.h>
-#include <asm/kdebug.h>
 
 extern spinlock_t rtc_lock;
 
diff -NurpP --minimal linux-2.6.16-rc2/arch/x86_64/mm/fault.c linux-2.6.16-rc2-mpf/arch/x86_64/mm/fault.c
--- linux-2.6.16-rc2/arch/x86_64/mm/fault.c	2006-02-07 11:52:18 +0100
+++ linux-2.6.16-rc2-mpf/arch/x86_64/mm/fault.c	2006-02-13 01:27:02 +0100
@@ -33,7 +33,6 @@
 #include <asm/proto.h>
 #include <asm/kdebug.h>
 #include <asm-generic/sections.h>
-#include <asm/kdebug.h>
 
 /* Page fault error code bits */
 #define PF_PROT	(1<<0)		/* or no page found */
diff -NurpP --minimal linux-2.6.16-rc2/arch/xtensa/kernel/align.S linux-2.6.16-rc2-mpf/arch/xtensa/kernel/align.S
--- linux-2.6.16-rc2/arch/xtensa/kernel/align.S	2005-10-28 20:49:18 +0200
+++ linux-2.6.16-rc2-mpf/arch/xtensa/kernel/align.S	2006-02-13 02:26:19 +0100
@@ -17,7 +17,6 @@
 
 #include <linux/linkage.h>
 #include <asm/ptrace.h>
-#include <asm/ptrace.h>
 #include <asm/current.h>
 #include <asm/asm-offsets.h>
 #include <asm/pgtable.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/xtensa/kernel/asm-offsets.c linux-2.6.16-rc2-mpf/arch/xtensa/kernel/asm-offsets.c
--- linux-2.6.16-rc2/arch/xtensa/kernel/asm-offsets.c	2005-08-29 22:24:57 +0200
+++ linux-2.6.16-rc2-mpf/arch/xtensa/kernel/asm-offsets.c	2006-02-13 01:28:11 +0100
@@ -19,7 +19,6 @@
 #include <linux/thread_info.h>
 #include <linux/ptrace.h>
 #include <asm/ptrace.h>
-#include <asm/processor.h>
 #include <asm/uaccess.h>
 
 #define DEFINE(sym, val) asm volatile("\n->" #sym " %0 " #val : : "i" (val))
diff -NurpP --minimal linux-2.6.16-rc2/arch/xtensa/kernel/vectors.S linux-2.6.16-rc2-mpf/arch/xtensa/kernel/vectors.S
--- linux-2.6.16-rc2/arch/xtensa/kernel/vectors.S	2005-10-28 20:49:18 +0200
+++ linux-2.6.16-rc2-mpf/arch/xtensa/kernel/vectors.S	2006-02-13 02:26:41 +0100
@@ -44,14 +44,12 @@
 
 #include <linux/linkage.h>
 #include <asm/ptrace.h>
-#include <asm/ptrace.h>
 #include <asm/current.h>
 #include <asm/asm-offsets.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/page.h>
 #include <asm/thread_info.h>
-#include <asm/processor.h>
 
 
 /*
diff -NurpP --minimal linux-2.6.16-rc2/arch/xtensa/mm/init.c linux-2.6.16-rc2-mpf/arch/xtensa/mm/init.c
--- linux-2.6.16-rc2/arch/xtensa/mm/init.c	2005-10-28 20:49:18 +0200
+++ linux-2.6.16-rc2-mpf/arch/xtensa/mm/init.c	2006-02-13 01:29:34 +0100
@@ -34,7 +34,6 @@
 #include <asm/tlbflush.h>
 #include <asm/page.h>
 #include <asm/pgalloc.h>
-#include <asm/pgtable.h>
 
 
 #define DEBUG 0
diff -NurpP --minimal linux-2.6.16-rc2/arch/xtensa/platform-iss/console.c linux-2.6.16-rc2-mpf/arch/xtensa/platform-iss/console.c
--- linux-2.6.16-rc2/arch/xtensa/platform-iss/console.c	2005-08-29 22:24:57 +0200
+++ linux-2.6.16-rc2-mpf/arch/xtensa/platform-iss/console.c	2006-02-13 01:30:07 +0100
@@ -21,7 +21,6 @@
 #include <linux/param.h>
 #include <linux/serial.h>
 #include <linux/serialP.h>
-#include <linux/console.h>
 
 #include <asm/uaccess.h>
 #include <asm/irq.h>
diff -NurpP --minimal linux-2.6.16-rc2/arch/xtensa/platform-iss/network.c linux-2.6.16-rc2-mpf/arch/xtensa/platform-iss/network.c
--- linux-2.6.16-rc2/arch/xtensa/platform-iss/network.c	2006-01-03 17:29:20 +0100
+++ linux-2.6.16-rc2-mpf/arch/xtensa/platform-iss/network.c	2006-02-13 01:30:22 +0100
@@ -32,7 +32,6 @@
 #include <linux/bootmem.h>
 #include <linux/ethtool.h>
 #include <linux/rtnetlink.h>
-#include <linux/timer.h>
 #include <linux/platform_device.h>
 
 #include <xtensa/simcall.h>
diff -NurpP --minimal linux-2.6.16-rc2/drivers/atm/lanai.c linux-2.6.16-rc2-mpf/drivers/atm/lanai.c
--- linux-2.6.16-rc2/drivers/atm/lanai.c	2006-01-03 17:29:21 +0100
+++ linux-2.6.16-rc2-mpf/drivers/atm/lanai.c	2006-02-13 02:07:27 +0100
@@ -65,7 +65,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <linux/dma-mapping.h>
 
 /* -------------------- TUNABLE PARAMATERS: */
 
diff -NurpP --minimal linux-2.6.16-rc2/drivers/block/viodasd.c linux-2.6.16-rc2-mpf/drivers/block/viodasd.c
--- linux-2.6.16-rc2/drivers/block/viodasd.c	2006-02-07 11:52:23 +0100
+++ linux-2.6.16-rc2-mpf/drivers/block/viodasd.c	2006-02-13 02:03:04 +0100
@@ -41,7 +41,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/completion.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
 
 #include <asm/uaccess.h>
 #include <asm/vio.h>
diff -NurpP --minimal linux-2.6.16-rc2/drivers/char/lcd.c linux-2.6.16-rc2-mpf/drivers/char/lcd.c
--- linux-2.6.16-rc2/drivers/char/lcd.c	2006-01-03 17:29:25 +0100
+++ linux-2.6.16-rc2-mpf/drivers/char/lcd.c	2006-02-13 01:49:29 +0100
@@ -29,7 +29,6 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
-#include <linux/delay.h>
 
 #include "lcd.h"
 
diff -NurpP --minimal linux-2.6.16-rc2/drivers/char/ppdev.c linux-2.6.16-rc2-mpf/drivers/char/ppdev.c
--- linux-2.6.16-rc2/drivers/char/ppdev.c	2006-01-03 17:29:26 +0100
+++ linux-2.6.16-rc2-mpf/drivers/char/ppdev.c	2006-02-13 01:49:43 +0100
@@ -68,7 +68,6 @@
 #include <asm/uaccess.h>
 #include <linux/ppdev.h>
 #include <linux/smp_lock.h>
-#include <linux/device.h>
 
 #define PP_VERSION "ppdev: user-space parallel port driver"
 #define CHRDEV "ppdev"
diff -NurpP --minimal linux-2.6.16-rc2/drivers/char/synclink.c linux-2.6.16-rc2-mpf/drivers/char/synclink.c
--- linux-2.6.16-rc2/drivers/char/synclink.c	2006-02-07 11:52:25 +0100
+++ linux-2.6.16-rc2-mpf/drivers/char/synclink.c	2006-02-13 01:49:14 +0100
@@ -89,7 +89,6 @@
 #include <linux/init.h>
 #include <asm/serial.h>
 
-#include <linux/delay.h>
 #include <linux/ioctl.h>
 
 #include <asm/system.h>
diff -NurpP --minimal linux-2.6.16-rc2/drivers/input/gameport/gameport.c linux-2.6.16-rc2-mpf/drivers/input/gameport/gameport.c
--- linux-2.6.16-rc2/drivers/input/gameport/gameport.c	2006-02-07 11:52:30 +0100
+++ linux-2.6.16-rc2-mpf/drivers/input/gameport/gameport.c	2006-02-13 02:07:06 +0100
@@ -21,7 +21,6 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
-#include <linux/sched.h>	/* HZ */
 
 /*#include <asm/io.h>*/
 
diff -NurpP --minimal linux-2.6.16-rc2/drivers/macintosh/therm_pm72.c linux-2.6.16-rc2-mpf/drivers/macintosh/therm_pm72.c
--- linux-2.6.16-rc2/drivers/macintosh/therm_pm72.c	2006-02-07 11:52:31 +0100
+++ linux-2.6.16-rc2-mpf/drivers/macintosh/therm_pm72.c	2006-02-13 02:07:58 +0100
@@ -104,7 +104,6 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/sched.h>
-#include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
diff -NurpP --minimal linux-2.6.16-rc2/drivers/media/video/arv.c linux-2.6.16-rc2-mpf/drivers/media/video/arv.c
--- linux-2.6.16-rc2/drivers/media/video/arv.c	2006-02-07 11:52:32 +0100
+++ linux-2.6.16-rc2-mpf/drivers/media/video/arv.c	2006-02-13 01:38:37 +0100
@@ -25,7 +25,6 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
-#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
diff -NurpP --minimal linux-2.6.16-rc2/drivers/mtd/chips/jedec_probe.c linux-2.6.16-rc2-mpf/drivers/mtd/chips/jedec_probe.c
--- linux-2.6.16-rc2/drivers/mtd/chips/jedec_probe.c	2006-01-03 17:29:35 +0100
+++ linux-2.6.16-rc2-mpf/drivers/mtd/chips/jedec_probe.c	2006-02-13 01:57:22 +0100
@@ -18,7 +18,6 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
-#include <linux/init.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
diff -NurpP --minimal linux-2.6.16-rc2/drivers/mtd/devices/m25p80.c linux-2.6.16-rc2-mpf/drivers/mtd/devices/m25p80.c
--- linux-2.6.16-rc2/drivers/mtd/devices/m25p80.c	2006-02-07 11:52:37 +0100
+++ linux-2.6.16-rc2-mpf/drivers/mtd/devices/m25p80.c	2006-02-13 01:57:05 +0100
@@ -19,7 +19,6 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
-#include <linux/interrupt.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/spi/spi.h>
diff -NurpP --minimal linux-2.6.16-rc2/drivers/net/bonding/bond_sysfs.c linux-2.6.16-rc2-mpf/drivers/net/bonding/bond_sysfs.c
--- linux-2.6.16-rc2/drivers/net/bonding/bond_sysfs.c	2006-02-07 11:52:37 +0100
+++ linux-2.6.16-rc2-mpf/drivers/net/bonding/bond_sysfs.c	2006-02-13 01:39:03 +0100
@@ -33,7 +33,6 @@
 #include <linux/inetdevice.h>
 #include <linux/in.h>
 #include <linux/sysfs.h>
-#include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/inet.h>
 #include <linux/rtnetlink.h>
diff -NurpP --minimal linux-2.6.16-rc2/drivers/net/fs_enet/fs_enet-main.c linux-2.6.16-rc2-mpf/drivers/net/fs_enet/fs_enet-main.c
--- linux-2.6.16-rc2/drivers/net/fs_enet/fs_enet-main.c	2006-01-03 17:29:37 +0100
+++ linux-2.6.16-rc2-mpf/drivers/net/fs_enet/fs_enet-main.c	2006-02-13 01:39:21 +0100
@@ -41,8 +41,6 @@
 
 #include <linux/vmalloc.h>
 #include <asm/pgtable.h>
-
-#include <asm/pgtable.h>
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 
diff -NurpP --minimal linux-2.6.16-rc2/drivers/net/gianfar.h linux-2.6.16-rc2-mpf/drivers/net/gianfar.h
--- linux-2.6.16-rc2/drivers/net/gianfar.h	2006-02-07 11:52:37 +0100
+++ linux-2.6.16-rc2-mpf/drivers/net/gianfar.h	2006-02-13 01:45:29 +0100
@@ -46,7 +46,6 @@
 #include <linux/crc32.h>
 #include <linux/workqueue.h>
 #include <linux/ethtool.h>
-#include <linux/netdevice.h>
 #include <linux/fsl_devices.h>
 #include "gianfar_mii.h"
 
diff -NurpP --minimal linux-2.6.16-rc2/drivers/net/gianfar_ethtool.c linux-2.6.16-rc2-mpf/drivers/net/gianfar_ethtool.c
--- linux-2.6.16-rc2/drivers/net/gianfar_ethtool.c	2006-02-07 11:52:37 +0100
+++ linux-2.6.16-rc2-mpf/drivers/net/gianfar_ethtool.c	2006-02-13 01:45:45 +0100
@@ -36,7 +36,6 @@
 #include <linux/module.h>
 #include <linux/crc32.h>
 #include <asm/types.h>
-#include <asm/uaccess.h>
 #include <linux/ethtool.h>
 #include <linux/mii.h>
 #include <linux/phy.h>
diff -NurpP --minimal linux-2.6.16-rc2/drivers/net/mipsnet.c linux-2.6.16-rc2-mpf/drivers/net/mipsnet.c
--- linux-2.6.16-rc2/drivers/net/mipsnet.c	2006-01-03 17:29:40 +0100
+++ linux-2.6.16-rc2-mpf/drivers/net/mipsnet.c	2006-02-13 01:46:01 +0100
@@ -12,7 +12,6 @@
 #include <linux/netdevice.h>
 #include <linux/sched.h>
 #include <linux/etherdevice.h>
-#include <linux/netdevice.h>
 #include <linux/platform_device.h>
 #include <asm/io.h>
 #include <asm/mips-boards/simint.h>
diff -NurpP --minimal linux-2.6.16-rc2/drivers/net/via-velocity.c linux-2.6.16-rc2-mpf/drivers/net/via-velocity.c
--- linux-2.6.16-rc2/drivers/net/via-velocity.c	2006-02-07 11:52:41 +0100
+++ linux-2.6.16-rc2-mpf/drivers/net/via-velocity.c	2006-02-13 01:43:37 +0100
@@ -65,7 +65,6 @@
 #include <linux/wait.h>
 #include <asm/io.h>
 #include <linux/if.h>
-#include <linux/config.h>
 #include <asm/uaccess.h>
 #include <linux/proc_fs.h>
 #include <linux/inetdevice.h>
diff -NurpP --minimal linux-2.6.16-rc2/drivers/net/wireless/ipw2200.h linux-2.6.16-rc2-mpf/drivers/net/wireless/ipw2200.h
--- linux-2.6.16-rc2/drivers/net/wireless/ipw2200.h	2006-02-07 11:52:41 +0100
+++ linux-2.6.16-rc2-mpf/drivers/net/wireless/ipw2200.h	2006-02-13 01:38:49 +0100
@@ -45,7 +45,6 @@
 
 #include <linux/firmware.h>
 #include <linux/wireless.h>
-#include <linux/dma-mapping.h>
 #include <asm/io.h>
 
 #include <net/ieee80211.h>
diff -NurpP --minimal linux-2.6.16-rc2/drivers/scsi/NCR_D700.c linux-2.6.16-rc2-mpf/drivers/scsi/NCR_D700.c
--- linux-2.6.16-rc2/drivers/scsi/NCR_D700.c	2005-06-22 02:38:23 +0200
+++ linux-2.6.16-rc2-mpf/drivers/scsi/NCR_D700.c	2006-02-13 01:51:56 +0100
@@ -97,7 +97,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mca.h>
-#include <linux/interrupt.h>
 #include <asm/io.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_device.h>
diff -NurpP --minimal linux-2.6.16-rc2/drivers/scsi/seagate.c linux-2.6.16-rc2-mpf/drivers/scsi/seagate.c
--- linux-2.6.16-rc2/drivers/scsi/seagate.c	2006-01-03 17:29:49 +0100
+++ linux-2.6.16-rc2-mpf/drivers/scsi/seagate.c	2006-02-13 01:56:42 +0100
@@ -97,7 +97,6 @@
 #include <linux/delay.h>
 #include <linux/blkdev.h>
 #include <linux/stat.h>
-#include <linux/delay.h>
 
 #include <asm/io.h>
 #include <asm/system.h>
diff -NurpP --minimal linux-2.6.16-rc2/drivers/video/fbmem.c linux-2.6.16-rc2-mpf/drivers/video/fbmem.c
--- linux-2.6.16-rc2/drivers/video/fbmem.c	2006-02-07 11:52:56 +0100
+++ linux-2.6.16-rc2-mpf/drivers/video/fbmem.c	2006-02-13 01:37:16 +0100
@@ -26,7 +26,6 @@
 #include <linux/mman.h>
 #include <linux/tty.h>
 #include <linux/init.h>
-#include <linux/linux_logo.h>
 #include <linux/proc_fs.h>
 #include <linux/console.h>
 #ifdef CONFIG_KMOD
@@ -34,7 +33,6 @@
 #endif
 #include <linux/devfs_fs_kernel.h>
 #include <linux/err.h>
-#include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/efi.h>
 
diff -NurpP --minimal linux-2.6.16-rc2/drivers/video/s3c2410fb.c linux-2.6.16-rc2-mpf/drivers/video/s3c2410fb.c
--- linux-2.6.16-rc2/drivers/video/s3c2410fb.c	2006-02-07 11:52:57 +0100
+++ linux-2.6.16-rc2-mpf/drivers/video/s3c2410fb.c	2006-02-13 01:38:19 +0100
@@ -82,7 +82,6 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/dma-mapping.h>
-#include <linux/string.h>
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
 #include <linux/wait.h>
diff -NurpP --minimal linux-2.6.16-rc2/drivers/video/tgafb.c linux-2.6.16-rc2-mpf/drivers/video/tgafb.c
--- linux-2.6.16-rc2/drivers/video/tgafb.c	2006-01-03 17:29:55 +0100
+++ linux-2.6.16-rc2-mpf/drivers/video/tgafb.c	2006-02-13 01:37:40 +0100
@@ -26,7 +26,6 @@
 #include <linux/selection.h>
 #include <asm/io.h>
 #include <video/tgafb.h>
-#include <linux/selection.h>
 
 /*
  * Local functions.
diff -NurpP --minimal linux-2.6.16-rc2/drivers/w1/matrox_w1.c linux-2.6.16-rc2-mpf/drivers/w1/matrox_w1.c
--- linux-2.6.16-rc2/drivers/w1/matrox_w1.c	2005-08-29 22:25:30 +0200
+++ linux-2.6.16-rc2-mpf/drivers/w1/matrox_w1.c	2006-02-13 02:07:40 +0100
@@ -33,7 +33,6 @@
 #include <linux/slab.h>
 #include <linux/pci_ids.h>
 #include <linux/pci.h>
-#include <linux/timer.h>
 
 #include "w1.h"
 #include "w1_int.h"
diff -NurpP --minimal linux-2.6.16-rc2/fs/compat_ioctl.c linux-2.6.16-rc2-mpf/fs/compat_ioctl.c
--- linux-2.6.16-rc2/fs/compat_ioctl.c	2006-02-07 11:52:58 +0100
+++ linux-2.6.16-rc2-mpf/fs/compat_ioctl.c	2006-02-13 02:18:27 +0100
@@ -122,7 +122,6 @@
 #include <linux/dvb/dmx.h>
 #include <linux/dvb/frontend.h>
 #include <linux/dvb/video.h>
-#include <linux/lp.h>
 
 /* Aiee. Someone does not find a difference between int and long */
 #define EXT2_IOC32_GETFLAGS               _IOR('f', 1, int)
diff -NurpP --minimal linux-2.6.16-rc2/fs/namei.c linux-2.6.16-rc2-mpf/fs/namei.c
--- linux-2.6.16-rc2/fs/namei.c	2006-02-07 11:53:01 +0100
+++ linux-2.6.16-rc2-mpf/fs/namei.c	2006-02-13 02:17:53 +0100
@@ -31,7 +31,6 @@
 #include <linux/capability.h>
 #include <linux/file.h>
 #include <linux/fcntl.h>
-#include <linux/namei.h>
 #include <asm/namei.h>
 #include <asm/uaccess.h>
 
diff -NurpP --minimal linux-2.6.16-rc2/include/asm-ia64/pgtable.h linux-2.6.16-rc2-mpf/include/asm-ia64/pgtable.h
--- linux-2.6.16-rc2/include/asm-ia64/pgtable.h	2006-01-03 17:30:05 +0100
+++ linux-2.6.16-rc2-mpf/include/asm-ia64/pgtable.h	2006-02-13 01:04:17 +0100
@@ -154,7 +154,6 @@
 #include <asm/bitops.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
-#include <asm/processor.h>
 
 /*
  * Next come the mappings that determine how mmap() protection bits
diff -NurpP --minimal linux-2.6.16-rc2/include/linux/memory_hotplug.h linux-2.6.16-rc2-mpf/include/linux/memory_hotplug.h
--- linux-2.6.16-rc2/include/linux/memory_hotplug.h	2006-01-03 17:30:09 +0100
+++ linux-2.6.16-rc2-mpf/include/linux/memory_hotplug.h	2006-02-13 01:06:13 +0100
@@ -3,7 +3,6 @@
 
 #include <linux/mmzone.h>
 #include <linux/spinlock.h>
-#include <linux/mmzone.h>
 #include <linux/notifier.h>
 
 #ifdef CONFIG_MEMORY_HOTPLUG
diff -NurpP --minimal linux-2.6.16-rc2/include/linux/nfs_fs.h linux-2.6.16-rc2-mpf/include/linux/nfs_fs.h
--- linux-2.6.16-rc2/include/linux/nfs_fs.h	2006-02-07 11:53:15 +0100
+++ linux-2.6.16-rc2-mpf/include/linux/nfs_fs.h	2006-02-13 01:05:31 +0100
@@ -27,7 +27,6 @@
 #include <linux/nfs3.h>
 #include <linux/nfs4.h>
 #include <linux/nfs_xdr.h>
-#include <linux/rwsem.h>
 #include <linux/mempool.h>
 
 /*
diff -NurpP --minimal linux-2.6.16-rc2/include/net/ieee80211.h linux-2.6.16-rc2-mpf/include/net/ieee80211.h
--- linux-2.6.16-rc2/include/net/ieee80211.h	2006-02-07 11:53:16 +0100
+++ linux-2.6.16-rc2-mpf/include/net/ieee80211.h	2006-02-13 01:07:20 +0100
@@ -177,7 +177,6 @@ const char *escape_essid(const char *ess
 #define IEEE80211_DEBUG_RX(f, a...)  IEEE80211_DEBUG(IEEE80211_DL_RX, f, ## a)
 #define IEEE80211_DEBUG_QOS(f, a...)  IEEE80211_DEBUG(IEEE80211_DL_QOS, f, ## a)
 #include <linux/netdevice.h>
-#include <linux/wireless.h>
 #include <linux/if_arp.h>	/* ARPHRD_ETHER */
 
 #ifndef WIRELESS_SPY
diff -NurpP --minimal linux-2.6.16-rc2/kernel/kexec.c linux-2.6.16-rc2-mpf/kernel/kexec.c
--- linux-2.6.16-rc2/kernel/kexec.c	2006-02-07 11:53:17 +0100
+++ linux-2.6.16-rc2-mpf/kernel/kexec.c	2006-02-13 02:20:31 +0100
@@ -17,7 +17,6 @@
 #include <linux/highmem.h>
 #include <linux/syscalls.h>
 #include <linux/reboot.h>
-#include <linux/syscalls.h>
 #include <linux/ioport.h>
 #include <linux/hardirq.h>
 
diff -NurpP --minimal linux-2.6.16-rc2/kernel/profile.c linux-2.6.16-rc2-mpf/kernel/profile.c
--- linux-2.6.16-rc2/kernel/profile.c	2005-08-29 22:25:43 +0200
+++ linux-2.6.16-rc2-mpf/kernel/profile.c	2006-02-13 02:20:18 +0100
@@ -21,7 +21,6 @@
 #include <linux/mm.h>
 #include <linux/cpumask.h>
 #include <linux/cpu.h>
-#include <linux/profile.h>
 #include <linux/highmem.h>
 #include <asm/sections.h>
 #include <asm/semaphore.h>
diff -NurpP --minimal linux-2.6.16-rc2/kernel/rcupdate.c linux-2.6.16-rc2-mpf/kernel/rcupdate.c
--- linux-2.6.16-rc2/kernel/rcupdate.c	2006-02-07 11:53:17 +0100
+++ linux-2.6.16-rc2-mpf/kernel/rcupdate.c	2006-02-13 02:19:27 +0100
@@ -45,7 +45,6 @@
 #include <linux/moduleparam.h>
 #include <linux/percpu.h>
 #include <linux/notifier.h>
-#include <linux/rcupdate.h>
 #include <linux/cpu.h>
 
 /* Definition for rcupdate control block. */
diff -NurpP --minimal linux-2.6.16-rc2/kernel/rcutorture.c linux-2.6.16-rc2-mpf/kernel/rcutorture.c
--- linux-2.6.16-rc2/kernel/rcutorture.c	2006-02-07 11:53:17 +0100
+++ linux-2.6.16-rc2-mpf/kernel/rcutorture.c	2006-02-13 02:20:52 +0100
@@ -34,7 +34,6 @@
 #include <linux/sched.h>
 #include <asm/atomic.h>
 #include <linux/bitops.h>
-#include <linux/module.h>
 #include <linux/completion.h>
 #include <linux/moduleparam.h>
 #include <linux/percpu.h>
diff -NurpP --minimal linux-2.6.16-rc2/kernel/sysctl.c linux-2.6.16-rc2-mpf/kernel/sysctl.c
--- linux-2.6.16-rc2/kernel/sysctl.c	2006-02-07 11:53:18 +0100
+++ linux-2.6.16-rc2-mpf/kernel/sysctl.c	2006-02-13 02:19:42 +0100
@@ -28,7 +28,6 @@
 #include <linux/capability.h>
 #include <linux/ctype.h>
 #include <linux/utsname.h>
-#include <linux/capability.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
diff -NurpP --minimal linux-2.6.16-rc2/kernel/time.c linux-2.6.16-rc2-mpf/kernel/time.c
--- linux-2.6.16-rc2/kernel/time.c	2006-02-07 11:53:18 +0100
+++ linux-2.6.16-rc2-mpf/kernel/time.c	2006-02-13 02:19:57 +0100
@@ -35,7 +35,6 @@
 #include <linux/syscalls.h>
 #include <linux/security.h>
 #include <linux/fs.h>
-#include <linux/module.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
diff -NurpP --minimal linux-2.6.16-rc2/mm/mempolicy.c linux-2.6.16-rc2-mpf/mm/mempolicy.c
--- linux-2.6.16-rc2/mm/mempolicy.c	2006-02-07 11:53:18 +0100
+++ linux-2.6.16-rc2-mpf/mm/mempolicy.c	2006-02-13 02:22:34 +0100
@@ -72,7 +72,6 @@
 #include <linux/hugetlb.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/mm.h>
 #include <linux/nodemask.h>
 #include <linux/cpuset.h>
 #include <linux/gfp.h>
@@ -82,7 +81,6 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/compat.h>
-#include <linux/mempolicy.h>
 #include <linux/swap.h>
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
diff -NurpP --minimal linux-2.6.16-rc2/mm/swap.c linux-2.6.16-rc2-mpf/mm/swap.c
--- linux-2.6.16-rc2/mm/swap.c	2006-02-07 11:53:18 +0100
+++ linux-2.6.16-rc2-mpf/mm/swap.c	2006-02-13 02:21:52 +0100
@@ -24,12 +24,10 @@
 #include <linux/module.h>
 #include <linux/mm_inline.h>
 #include <linux/buffer_head.h>	/* for try_to_release_page() */
-#include <linux/module.h>
 #include <linux/percpu_counter.h>
 #include <linux/percpu.h>
 #include <linux/cpu.h>
 #include <linux/notifier.h>
-#include <linux/init.h>
 
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
diff -NurpP --minimal linux-2.6.16-rc2/net/atm/lec.c linux-2.6.16-rc2-mpf/net/atm/lec.c
--- linux-2.6.16-rc2/net/atm/lec.c	2006-02-07 11:53:21 +0100
+++ linux-2.6.16-rc2-mpf/net/atm/lec.c	2006-02-13 02:15:12 +0100
@@ -22,7 +22,6 @@
 #include <net/dst.h>
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
-#include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
 /* TokenRing if needed */
diff -NurpP --minimal linux-2.6.16-rc2/net/bridge/netfilter/ebt_log.c linux-2.6.16-rc2-mpf/net/bridge/netfilter/ebt_log.c
--- linux-2.6.16-rc2/net/bridge/netfilter/ebt_log.c	2006-02-07 11:53:22 +0100
+++ linux-2.6.16-rc2-mpf/net/bridge/netfilter/ebt_log.c	2006-02-13 02:14:33 +0100
@@ -9,7 +9,6 @@
  *
  */
 
-#include <linux/in.h>
 #include <linux/netfilter_bridge/ebtables.h>
 #include <linux/netfilter_bridge/ebt_log.h>
 #include <linux/netfilter.h>
diff -NurpP --minimal linux-2.6.16-rc2/net/bridge/netfilter/ebt_ulog.c linux-2.6.16-rc2-mpf/net/bridge/netfilter/ebt_ulog.c
--- linux-2.6.16-rc2/net/bridge/netfilter/ebt_ulog.c	2006-02-07 11:53:22 +0100
+++ linux-2.6.16-rc2-mpf/net/bridge/netfilter/ebt_ulog.c	2006-02-13 02:14:51 +0100
@@ -37,7 +37,6 @@
 #include <linux/timer.h>
 #include <linux/netlink.h>
 #include <linux/netdevice.h>
-#include <linux/module.h>
 #include <linux/netfilter_bridge/ebtables.h>
 #include <linux/netfilter_bridge/ebt_ulog.h>
 #include <net/sock.h>
diff -NurpP --minimal linux-2.6.16-rc2/net/ipv4/ip_output.c linux-2.6.16-rc2-mpf/net/ipv4/ip_output.c
--- linux-2.6.16-rc2/net/ipv4/ip_output.c	2006-02-07 11:53:22 +0100
+++ linux-2.6.16-rc2-mpf/net/ipv4/ip_output.c	2006-02-13 02:09:48 +0100
@@ -76,7 +76,6 @@
 #include <net/icmp.h>
 #include <net/checksum.h>
 #include <net/inetpeer.h>
-#include <net/checksum.h>
 #include <linux/igmp.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_bridge.h>
diff -NurpP --minimal linux-2.6.16-rc2/net/ipv4/ipvs/ip_vs_ctl.c linux-2.6.16-rc2-mpf/net/ipv4/ipvs/ip_vs_ctl.c
--- linux-2.6.16-rc2/net/ipv4/ipvs/ip_vs_ctl.c	2006-02-07 11:53:22 +0100
+++ linux-2.6.16-rc2-mpf/net/ipv4/ipvs/ip_vs_ctl.c	2006-02-13 02:09:29 +0100
@@ -26,7 +26,6 @@
 #include <linux/capability.h>
 #include <linux/fs.h>
 #include <linux/sysctl.h>
-#include <linux/proc_fs.h>
 #include <linux/workqueue.h>
 #include <linux/swap.h>
 #include <linux/proc_fs.h>
diff -NurpP --minimal linux-2.6.16-rc2/net/ipv4/netfilter/ipt_CLUSTERIP.c linux-2.6.16-rc2-mpf/net/ipv4/netfilter/ipt_CLUSTERIP.c
--- linux-2.6.16-rc2/net/ipv4/netfilter/ipt_CLUSTERIP.c	2006-02-07 11:53:23 +0100
+++ linux-2.6.16-rc2-mpf/net/ipv4/netfilter/ipt_CLUSTERIP.c	2006-02-13 02:09:13 +0100
@@ -20,7 +20,6 @@
 #include <linux/udp.h>
 #include <linux/icmp.h>
 #include <linux/if_arp.h>
-#include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
 #include <net/checksum.h>
diff -NurpP --minimal linux-2.6.16-rc2/net/ipv6/tcp_ipv6.c linux-2.6.16-rc2-mpf/net/ipv6/tcp_ipv6.c
--- linux-2.6.16-rc2/net/ipv6/tcp_ipv6.c	2006-02-07 11:53:24 +0100
+++ linux-2.6.16-rc2-mpf/net/ipv6/tcp_ipv6.c	2006-02-13 02:15:34 +0100
@@ -57,7 +57,6 @@
 #include <net/inet_ecn.h>
 #include <net/protocol.h>
 #include <net/xfrm.h>
-#include <net/addrconf.h>
 #include <net/snmp.h>
 #include <net/dsfield.h>
 #include <net/timewait_sock.h>
diff -NurpP --minimal linux-2.6.16-rc2/net/netfilter/nf_conntrack_proto_tcp.c linux-2.6.16-rc2-mpf/net/netfilter/nf_conntrack_proto_tcp.c
--- linux-2.6.16-rc2/net/netfilter/nf_conntrack_proto_tcp.c	2006-02-07 11:53:24 +0100
+++ linux-2.6.16-rc2-mpf/net/netfilter/nf_conntrack_proto_tcp.c	2006-02-13 02:16:28 +0100
@@ -28,7 +28,6 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/timer.h>
-#include <linux/netfilter.h>
 #include <linux/module.h>
 #include <linux/in.h>
 #include <linux/tcp.h>
diff -NurpP --minimal linux-2.6.16-rc2/net/netfilter/nf_conntrack_proto_udp.c linux-2.6.16-rc2-mpf/net/netfilter/nf_conntrack_proto_udp.c
--- linux-2.6.16-rc2/net/netfilter/nf_conntrack_proto_udp.c	2006-02-07 11:53:24 +0100
+++ linux-2.6.16-rc2-mpf/net/netfilter/nf_conntrack_proto_udp.c	2006-02-13 02:16:42 +0100
@@ -15,7 +15,6 @@
 #include <linux/sched.h>
 #include <linux/timer.h>
 #include <linux/module.h>
-#include <linux/netfilter.h>
 #include <linux/udp.h>
 #include <linux/seq_file.h>
 #include <linux/skbuff.h>
diff -NurpP --minimal linux-2.6.16-rc2/net/sched/act_police.c linux-2.6.16-rc2-mpf/net/sched/act_police.c
--- linux-2.6.16-rc2/net/sched/act_police.c	2006-02-07 11:53:24 +0100
+++ linux-2.6.16-rc2-mpf/net/sched/act_police.c	2006-02-13 02:15:51 +0100
@@ -27,7 +27,6 @@
 #include <linux/interrupt.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
-#include <linux/module.h>
 #include <linux/rtnetlink.h>
 #include <linux/init.h>
 #include <net/sock.h>
diff -NurpP --minimal linux-2.6.16-rc2/net/sunrpc/auth_gss/svcauth_gss.c linux-2.6.16-rc2-mpf/net/sunrpc/auth_gss/svcauth_gss.c
--- linux-2.6.16-rc2/net/sunrpc/auth_gss/svcauth_gss.c	2006-02-07 11:53:27 +0100
+++ linux-2.6.16-rc2-mpf/net/sunrpc/auth_gss/svcauth_gss.c	2006-02-13 02:11:32 +0100
@@ -44,7 +44,6 @@
 #include <linux/sunrpc/auth_gss.h>
 #include <linux/sunrpc/svcauth.h>
 #include <linux/sunrpc/gss_err.h>
-#include <linux/sunrpc/svcauth.h>
 #include <linux/sunrpc/svcauth_gss.h>
 #include <linux/sunrpc/cache.h>
 
diff -NurpP --minimal linux-2.6.16-rc2/net/wanrouter/wanmain.c linux-2.6.16-rc2-mpf/net/wanrouter/wanmain.c
--- linux-2.6.16-rc2/net/wanrouter/wanmain.c	2006-02-07 11:53:27 +0100
+++ linux-2.6.16-rc2-mpf/net/wanrouter/wanmain.c	2006-02-13 02:16:09 +0100
@@ -58,7 +58,6 @@
 
 #include <linux/vmalloc.h>	/* vmalloc, vfree */
 #include <asm/uaccess.h>        /* copy_to/from_user */
-#include <linux/init.h>         /* __initfunc et al. */
 #include <net/syncppp.h>
 
 #define KMEM_SAFETYZONE 8
diff -NurpP --minimal linux-2.6.16-rc2/sound/core/rawmidi.c linux-2.6.16-rc2-mpf/sound/core/rawmidi.c
--- linux-2.6.16-rc2/sound/core/rawmidi.c	2006-02-07 11:53:29 +0100
+++ linux-2.6.16-rc2-mpf/sound/core/rawmidi.c	2006-02-13 02:19:02 +0100
@@ -30,7 +30,6 @@
 #include <linux/wait.h>
 #include <linux/moduleparam.h>
 #include <linux/delay.h>
-#include <linux/wait.h>
 #include <sound/rawmidi.h>
 #include <sound/info.h>
 #include <sound/control.h>
diff -NurpP --minimal linux-2.6.16-rc2/sound/oss/rme96xx.c linux-2.6.16-rc2-mpf/sound/oss/rme96xx.c
--- linux-2.6.16-rc2/sound/oss/rme96xx.c	2006-02-07 11:53:33 +0100
+++ linux-2.6.16-rc2-mpf/sound/oss/rme96xx.c	2006-02-13 02:18:41 +0100
@@ -55,7 +55,6 @@ TODO:
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
-#include <linux/interrupt.h>
 #include <linux/poll.h>
 #include <linux/wait.h>
 





diff -NurpP --minimal linux-2.6.16-rc2/arch/powerpc/kernel/signal_32.c linux-2.6.16-rc2-mpf/arch/powerpc/kernel/signal_32.c
--- linux-2.6.16-rc2/arch/powerpc/kernel/signal_32.c	2006-02-07 11:52:11 +0100
+++ linux-2.6.16-rc2-mpf/arch/powerpc/kernel/signal_32.c	2006-02-13 01:31:25 +0100
@@ -26,13 +26,12 @@
 #include <linux/signal.h>
 #include <linux/errno.h>
 #include <linux/elf.h>
+#include <linux/ptrace.h>
 #ifdef CONFIG_PPC64
 #include <linux/syscalls.h>
 #include <linux/compat.h>
-#include <linux/ptrace.h>
 #else
 #include <linux/wait.h>
-#include <linux/ptrace.h>
 #include <linux/unistd.h>
 #include <linux/stddef.h>
 #include <linux/tty.h>
diff -NurpP --minimal linux-2.6.16-rc2/net/ipv4/tcp_cubic.c linux-2.6.16-rc2-mpf/net/ipv4/tcp_cubic.c
--- linux-2.6.16-rc2/net/ipv4/tcp_cubic.c	2006-02-07 11:53:23 +0100
+++ linux-2.6.16-rc2-mpf/net/ipv4/tcp_cubic.c	2006-02-13 02:10:10 +0100
@@ -52,8 +52,6 @@ MODULE_PARM_DESC(bic_scale, "scale (scal
 module_param(tcp_friendliness, int, 0644);
 MODULE_PARM_DESC(tcp_friendliness, "turn on/off tcp friendliness");
 
-#include <asm/div64.h>
-
 /* BIC TCP Parameters */
 struct bictcp {
 	u32	cnt;		/* increase cwnd by 1 after ACKs */
diff -NurpP --minimal linux-2.6.16-rc2/mm/swapfile.c linux-2.6.16-rc2-mpf/mm/swapfile.c
--- linux-2.6.16-rc2/mm/swapfile.c	2006-02-07 11:53:18 +0100
+++ linux-2.6.16-rc2-mpf/mm/swapfile.c	2006-02-13 02:21:21 +0100
@@ -1070,7 +1070,6 @@ out:
 }
 
 #if 0	/* We don't need this yet */
-#include <linux/backing-dev.h>
 int page_queue_congested(struct page *page)
 {
 	struct backing_dev_info *bdi;
diff -NurpP --minimal linux-2.6.16-rc2/include/linux/udp.h linux-2.6.16-rc2-mpf/include/linux/udp.h
--- linux-2.6.16-rc2/include/linux/udp.h	2006-02-07 11:53:15 +0100
+++ linux-2.6.16-rc2-mpf/include/linux/udp.h	2006-02-13 01:05:13 +0100
@@ -36,7 +36,6 @@ struct udphdr {
 
 #ifdef __KERNEL__
 #include <linux/config.h>
-#include <linux/types.h>
 
 #include <net/inet_sock.h>
 
diff -NurpP --minimal linux-2.6.16-rc2/include/asm-ia64/unistd.h linux-2.6.16-rc2-mpf/include/asm-ia64/unistd.h
--- linux-2.6.16-rc2/include/asm-ia64/unistd.h	2006-02-07 11:53:08 +0100
+++ linux-2.6.16-rc2-mpf/include/asm-ia64/unistd.h	2006-02-13 01:03:49 +0100
@@ -301,7 +301,6 @@ extern long __ia64_syscall (long a0, lon
 
 #ifdef __KERNEL_SYSCALLS__
 
-#include <linux/compiler.h>
 #include <linux/string.h>
 #include <linux/signal.h>
 #include <asm/ptrace.h>
diff -NurpP --minimal linux-2.6.16-rc2/include/asm-ppc/page.h linux-2.6.16-rc2-mpf/include/asm-ppc/page.h
--- linux-2.6.16-rc2/include/asm-ppc/page.h	2006-01-03 17:30:07 +0100
+++ linux-2.6.16-rc2-mpf/include/asm-ppc/page.h	2006-02-13 01:03:09 +0100
@@ -15,7 +15,6 @@
 #define PAGE_MASK	(~((1 << PAGE_SHIFT) - 1))
 
 #ifdef __KERNEL__
-#include <linux/config.h>
 
 /* This must match what is in arch/ppc/Makefile */
 #define PAGE_OFFSET	CONFIG_KERNEL_START
diff -NurpP --minimal linux-2.6.16-rc2/include/asm-sparc/system.h linux-2.6.16-rc2-mpf/include/asm-sparc/system.h
--- linux-2.6.16-rc2/include/asm-sparc/system.h	2006-02-07 11:53:10 +0100
+++ linux-2.6.16-rc2-mpf/include/asm-sparc/system.h	2006-02-13 01:08:00 +0100
@@ -1,6 +1,4 @@
 /* $Id: system.h,v 1.86 2001/10/30 04:57:10 davem Exp $ */
-#include <linux/config.h>
-
 #ifndef __SPARC_SYSTEM_H
 #define __SPARC_SYSTEM_H
 
diff -NurpP --minimal linux-2.6.16-rc2/include/linux/aio.h linux-2.6.16-rc2-mpf/include/linux/aio.h
--- linux-2.6.16-rc2/include/linux/aio.h	2006-02-07 11:53:13 +0100
+++ linux-2.6.16-rc2-mpf/include/linux/aio.h	2006-02-13 01:04:42 +0100
@@ -236,8 +236,6 @@ do {									\
 #define io_wait_to_kiocb(wait) container_of(wait, struct kiocb, ki_wait)
 #define is_retried_kiocb(iocb) ((iocb)->ki_retried > 1)
 
-#include <linux/aio_abi.h>
-
 static inline struct kiocb *list_kiocb(struct list_head *h)
 {
 	return list_entry(h, struct kiocb, ki_list);
diff -NurpP --minimal linux-2.6.16-rc2/include/linux/atalk.h linux-2.6.16-rc2-mpf/include/linux/atalk.h
--- linux-2.6.16-rc2/include/linux/atalk.h	2006-02-07 11:53:13 +0100
+++ linux-2.6.16-rc2-mpf/include/linux/atalk.h	2006-02-13 01:05:54 +0100
@@ -85,8 +85,6 @@ static inline struct atalk_sock *at_sk(s
 	return (struct atalk_sock *)sk;
 }
 
-#include <asm/byteorder.h>
-
 struct ddpehdr {
 #ifdef __LITTLE_ENDIAN_BITFIELD
 	__u16	deh_len:10,
diff -NurpP --minimal linux-2.6.16-rc2/include/asm-arm26/signal.h linux-2.6.16-rc2-mpf/include/asm-arm26/signal.h
--- linux-2.6.16-rc2/include/asm-arm26/signal.h	2005-06-22 02:38:42 +0200
+++ linux-2.6.16-rc2-mpf/include/asm-arm26/signal.h	2006-02-13 01:09:26 +0100
@@ -166,11 +166,6 @@ typedef struct sigaltstack {
 #include <asm/sigcontext.h>
 
 #define sigmask(sig)	(1UL << ((sig) - 1))
-#endif
-
-
-#ifdef __KERNEL__
-#include <asm/sigcontext.h>
 #define ptrace_signal_deliver(regs, cookie) do { } while (0)
 #endif
 
diff -NurpP --minimal linux-2.6.16-rc2/drivers/net/cs89x0.c linux-2.6.16-rc2-mpf/drivers/net/cs89x0.c
--- linux-2.6.16-rc2/drivers/net/cs89x0.c	2006-02-07 11:52:37 +0100
+++ linux-2.6.16-rc2-mpf/drivers/net/cs89x0.c	2006-02-13 01:45:14 +0100
@@ -183,13 +183,10 @@ static unsigned int cs8900_irq_map[] = {
 #elif defined(CONFIG_MACH_IXDP2351)
 static unsigned int netcard_portlist[] __initdata = {IXDP2351_VIRT_CS8900_BASE, 0};
 static unsigned int cs8900_irq_map[] = {IRQ_IXDP2351_CS8900, 0, 0, 0};
-#include <asm/irq.h>
 #elif defined(CONFIG_ARCH_IXDP2X01)
-#include <asm/irq.h>
 static unsigned int netcard_portlist[] __initdata = {IXDP2X01_CS8900_VIRT_BASE, 0};
 static unsigned int cs8900_irq_map[] = {IRQ_IXDP2X01_CS8900, 0, 0, 0};
 #elif defined(CONFIG_ARCH_PNX010X)
-#include <asm/irq.h>
 #include <asm/arch/gpio.h>
 #define CIRRUS_DEFAULT_BASE	IO_ADDRESS(EXT_STATIC2_s0_BASE + 0x200000)	/* = Physical address 0x48200000 */
 #define CIRRUS_DEFAULT_IRQ	VH_INTC_INT_NUM_CASCADED_INTERRUPT_1 /* Event inputs bank 1 - ID 35/bit 3 */
diff -NurpP --minimal linux-2.6.16-rc2/drivers/char/drm/drm.h linux-2.6.16-rc2-mpf/drivers/char/drm/drm.h
--- linux-2.6.16-rc2/drivers/char/drm/drm.h	2006-02-07 11:52:24 +0100
+++ linux-2.6.16-rc2-mpf/drivers/char/drm/drm.h	2006-02-13 01:48:55 +0100
@@ -51,11 +51,9 @@
 #if defined(__FreeBSD__) && defined(IN_MODULE)
 /* Prevent name collision when including sys/ioccom.h */
 #undef ioctl
-#include <sys/ioccom.h>
 #define ioctl(a,b,c)		xf86ioctl(a,b,c)
-#else
-#include <sys/ioccom.h>
 #endif				/* __FreeBSD__ && xf86ioctl */
+#include <sys/ioccom.h>
 #define DRM_IOCTL_NR(n)		((n) & 0xff)
 #define DRM_IOC_VOID		IOC_VOID
 #define DRM_IOC_READ		IOC_OUT
diff -NurpP --minimal linux-2.6.16-rc2/drivers/char/drm/drm_memory.h linux-2.6.16-rc2-mpf/drivers/char/drm/drm_memory.h
--- linux-2.6.16-rc2/drivers/char/drm/drm_memory.h	2006-01-03 17:29:21 +0100
+++ linux-2.6.16-rc2-mpf/drivers/char/drm/drm_memory.h	2006-02-13 01:47:03 +0100
@@ -45,8 +45,6 @@
 
 #if __OS_HAS_AGP
 
-#include <linux/vmalloc.h>
-
 #ifdef HAVE_PAGE_AGP
 #include <asm/agp.h>
 #else
diff -NurpP --minimal linux-2.6.16-rc2/arch/sh64/kernel/process.c linux-2.6.16-rc2-mpf/arch/sh64/kernel/process.c
--- linux-2.6.16-rc2/arch/sh64/kernel/process.c	2006-02-07 11:52:14 +0100
+++ linux-2.6.16-rc2-mpf/arch/sh64/kernel/process.c	2006-02-13 01:26:18 +0100
@@ -897,7 +897,6 @@ unsigned long get_wchan(struct task_stru
    */
 
 #if defined(CONFIG_SH64_PROC_ASIDS)
-#include <linux/init.h>
 #include <linux/proc_fs.h>
 
 static int
