Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268812AbUHYVcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268812AbUHYVcF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 17:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268749AbUHYV1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 17:27:35 -0400
Received: from holomorphy.com ([207.189.100.168]:56975 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268807AbUHYVKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 17:10:36 -0400
Date: Wed, 25 Aug 2004 14:10:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [5/4] move most signal functions to signal.h
Message-ID: <20040825211016.GL2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20040819143907.GA4236@redhat.com> <20040819150632.GP11200@holomorphy.com> <20040825180138.GA2793@holomorphy.com> <20040825180342.GB2793@holomorphy.com> <20040825193921.GC2793@holomorphy.com> <20040825194207.GE2793@holomorphy.com> <20040825194304.GF2793@holomorphy.com> <20040825194413.GG2793@holomorphy.com> <20040825194527.GH2793@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040825194527.GH2793@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 12:45:27PM -0700, William Lee Irwin III wrote:
> Move signal_struct -related bits over to include/linux/signal.h

Move signal-related function declarations over to include/linux/signal.h
It was kind of painful to doublecheck the grepping for false positives,
so some unnecessary inclusions may be introduced here.

Index: mm4-2.6.8.1/arch/alpha/kernel/osf_sys.c
===================================================================
--- mm4-2.6.8.1.orig/arch/alpha/kernel/osf_sys.c	2004-08-25 09:54:39.878898384 -0700
+++ mm4-2.6.8.1/arch/alpha/kernel/osf_sys.c	2004-08-25 13:25:43.283768224 -0700
@@ -12,6 +12,7 @@
 
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
Index: mm4-2.6.8.1/arch/alpha/kernel/traps.c
===================================================================
--- mm4-2.6.8.1.orig/arch/alpha/kernel/traps.c	2004-08-23 16:11:10.000000000 -0700
+++ mm4-2.6.8.1/arch/alpha/kernel/traps.c	2004-08-25 13:25:47.474131192 -0700
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kallsyms.h>
+#include <linux/signal.h>
 
 #include <asm/gentrap.h>
 #include <asm/uaccess.h>
Index: mm4-2.6.8.1/arch/arm/kernel/apm.c
===================================================================
--- mm4-2.6.8.1.orig/arch/arm/kernel/apm.c	2004-08-14 03:56:22.000000000 -0700
+++ mm4-2.6.8.1/arch/arm/kernel/apm.c	2004-08-25 13:25:59.990228456 -0700
@@ -25,6 +25,7 @@
 #include <linux/list.h>
 #include <linux/init.h>
 #include <linux/completion.h>
+#include <linux/signal.h>
 
 #include <asm/apm.h> /* apm_power_info */
 #include <asm/system.h>
Index: mm4-2.6.8.1/arch/arm/kernel/armksyms.c
===================================================================
--- mm4-2.6.8.1.orig/arch/arm/kernel/armksyms.c	2004-08-14 03:55:10.000000000 -0700
+++ mm4-2.6.8.1/arch/arm/kernel/armksyms.c	2004-08-25 13:26:04.251580632 -0700
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/in6.h>
 #include <linux/syscalls.h>
+#include <linux/signal.h>
 
 #include <asm/checksum.h>
 #include <asm/io.h>
Index: mm4-2.6.8.1/arch/arm/mm/alignment.c
===================================================================
--- mm4-2.6.8.1.orig/arch/arm/mm/alignment.c	2004-08-14 03:54:50.000000000 -0700
+++ mm4-2.6.8.1/arch/arm/mm/alignment.c	2004-08-25 13:26:10.481633520 -0700
@@ -16,6 +16,7 @@
 #include <linux/ptrace.h>
 #include <linux/proc_fs.h>
 #include <linux/init.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 #include <asm/unaligned.h>
Index: mm4-2.6.8.1/arch/arm26/kernel/armksyms.c
===================================================================
--- mm4-2.6.8.1.orig/arch/arm26/kernel/armksyms.c	2004-08-25 09:55:21.754532320 -0700
+++ mm4-2.6.8.1/arch/arm26/kernel/armksyms.c	2004-08-25 13:25:50.632651024 -0700
@@ -21,6 +21,7 @@
 #include <linux/vt_kern.h>
 #include <linux/smp_lock.h>
 #include <linux/syscalls.h>
+#include <linux/signal.h>
 
 #include <asm/user.h>
 #include <asm/byteorder.h>
Index: mm4-2.6.8.1/arch/cris/arch-v10/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/cris/arch-v10/kernel/ptrace.c	2004-08-25 09:54:39.879898232 -0700
+++ mm4-2.6.8.1/arch/cris/arch-v10/kernel/ptrace.c	2004-08-25 13:26:13.121232240 -0700
@@ -9,6 +9,7 @@
 #include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
+#include <linux/signal.h>
 
 #include <asm/user.h>
 #include <asm/uaccess.h>
Index: mm4-2.6.8.1/arch/cris/mm/fault.c
===================================================================
--- mm4-2.6.8.1.orig/arch/cris/mm/fault.c	2004-08-25 11:06:48.162899200 -0700
+++ mm4-2.6.8.1/arch/cris/mm/fault.c	2004-08-25 13:26:18.703383624 -0700
@@ -99,6 +99,7 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/signal.h>
 #include <asm/uaccess.h>
 
 extern int find_fixup_code(struct pt_regs *);
Index: mm4-2.6.8.1/arch/h8300/platform/h8300h/ptrace_h8300h.c
===================================================================
--- mm4-2.6.8.1.orig/arch/h8300/platform/h8300h/ptrace_h8300h.c	2004-08-14 03:55:09.000000000 -0700
+++ mm4-2.6.8.1/arch/h8300/platform/h8300h/ptrace_h8300h.c	2004-08-25 13:26:21.829908320 -0700
@@ -11,6 +11,7 @@
 
 #include <linux/linkage.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <asm/ptrace.h>
 
 #define CCR_MASK 0x6f    /* mode/imask not set */
Index: mm4-2.6.8.1/arch/h8300/platform/h8s/ptrace_h8s.c
===================================================================
--- mm4-2.6.8.1.orig/arch/h8300/platform/h8s/ptrace_h8s.c	2004-08-14 03:54:51.000000000 -0700
+++ mm4-2.6.8.1/arch/h8300/platform/h8s/ptrace_h8s.c	2004-08-25 13:26:24.885443808 -0700
@@ -11,6 +11,7 @@
 
 #include <linux/linkage.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/errno.h>
 #include <asm/ptrace.h>
 
Index: mm4-2.6.8.1/arch/i386/kernel/traps.c
===================================================================
--- mm4-2.6.8.1.orig/arch/i386/kernel/traps.c	2004-08-23 16:11:10.000000000 -0700
+++ mm4-2.6.8.1/arch/i386/kernel/traps.c	2004-08-25 13:26:27.796001336 -0700
@@ -13,6 +13,7 @@
  */
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/errno.h>
Index: mm4-2.6.8.1/arch/ia64/ia32/ia32_support.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ia64/ia32/ia32_support.c	2004-08-23 16:10:53.000000000 -0700
+++ mm4-2.6.8.1/arch/ia64/ia32/ia32_support.c	2004-08-25 13:26:31.034509008 -0700
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/personality.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 
 #include <asm/intrinsics.h>
 #include <asm/page.h>
Index: mm4-2.6.8.1/arch/ia64/ia32/ia32_traps.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ia64/ia32/ia32_traps.c	2004-08-14 03:55:10.000000000 -0700
+++ mm4-2.6.8.1/arch/ia64/ia32/ia32_traps.c	2004-08-25 13:26:34.050050576 -0700
@@ -11,6 +11,7 @@
 
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 
 #include "ia32priv.h"
 
Index: mm4-2.6.8.1/arch/ia64/kernel/brl_emu.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ia64/kernel/brl_emu.c	2004-08-14 03:55:59.000000000 -0700
+++ mm4-2.6.8.1/arch/ia64/kernel/brl_emu.c	2004-08-25 13:26:37.040595944 -0700
@@ -9,6 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 
Index: mm4-2.6.8.1/arch/ia64/kernel/traps.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ia64/kernel/traps.c	2004-08-23 16:10:56.000000000 -0700
+++ mm4-2.6.8.1/arch/ia64/kernel/traps.c	2004-08-25 13:26:39.944154536 -0700
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/tty.h>
 #include <linux/vt_kern.h>		/* For unblank_screen() */
 #include <linux/module.h>       /* for EXPORT_SYMBOL */
Index: mm4-2.6.8.1/arch/ia64/mm/fault.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ia64/mm/fault.c	2004-08-25 11:06:48.166898592 -0700
+++ mm4-2.6.8.1/arch/ia64/mm/fault.c	2004-08-25 13:26:45.006384960 -0700
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
+#include <linux/signal.h>
 
 #include <asm/pgtable.h>
 #include <asm/processor.h>
Index: mm4-2.6.8.1/arch/m68k/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/m68k/kernel/ptrace.c	2004-08-25 09:54:39.882897776 -0700
+++ mm4-2.6.8.1/arch/m68k/kernel/ptrace.c	2004-08-25 13:26:52.483248304 -0700
@@ -18,6 +18,7 @@
 #include <linux/errno.h>
 #include <linux/ptrace.h>
 #include <linux/config.h>
+#include <linux/signal.h>
 
 #include <asm/user.h>
 #include <asm/uaccess.h>
Index: mm4-2.6.8.1/arch/m68k/mm/fault.c
===================================================================
--- mm4-2.6.8.1.orig/arch/m68k/mm/fault.c	2004-08-25 11:06:48.166898592 -0700
+++ mm4-2.6.8.1/arch/m68k/mm/fault.c	2004-08-25 13:26:55.114848240 -0700
@@ -10,6 +10,7 @@
 #include <linux/ptrace.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/signal.h>
 
 #include <asm/setup.h>
 #include <asm/traps.h>
Index: mm4-2.6.8.1/arch/m68knommu/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/m68knommu/kernel/ptrace.c	2004-08-25 09:54:39.884897472 -0700
+++ mm4-2.6.8.1/arch/m68knommu/kernel/ptrace.c	2004-08-25 13:26:57.825436168 -0700
@@ -12,6 +12,7 @@
 
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
Index: mm4-2.6.8.1/arch/mips/au1000/db1x00/mirage_ts.c
===================================================================
--- mm4-2.6.8.1.orig/arch/mips/au1000/db1x00/mirage_ts.c	2004-08-14 03:55:35.000000000 -0700
+++ mm4-2.6.8.1/arch/mips/au1000/db1x00/mirage_ts.c	2004-08-25 13:27:03.519570528 -0700
@@ -42,6 +42,7 @@
 #include <linux/proc_fs.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
+#include <linux/signal.h>
 
 #include <asm/segment.h>
 #include <asm/irq.h>
Index: mm4-2.6.8.1/arch/mips/kernel/traps.c
===================================================================
--- mm4-2.6.8.1.orig/arch/mips/kernel/traps.c	2004-08-14 03:55:20.000000000 -0700
+++ mm4-2.6.8.1/arch/mips/kernel/traps.c	2004-08-25 13:27:28.590759128 -0700
@@ -20,6 +20,7 @@
 #include <linux/smp_lock.h>
 #include <linux/spinlock.h>
 #include <linux/kallsyms.h>
+#include <linux/signal.h>
 
 #include <asm/bootinfo.h>
 #include <asm/branch.h>
Index: mm4-2.6.8.1/arch/mips/sgi-ip22/ip22-berr.c
===================================================================
--- mm4-2.6.8.1.orig/arch/mips/sgi-ip22/ip22-berr.c	2004-08-14 03:55:32.000000000 -0700
+++ mm4-2.6.8.1/arch/mips/sgi-ip22/ip22-berr.c	2004-08-25 13:27:31.126373656 -0700
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 
 #include <asm/addrspace.h>
 #include <asm/system.h>
Index: mm4-2.6.8.1/arch/mips/sgi-ip22/ip22-reset.c
===================================================================
--- mm4-2.6.8.1.orig/arch/mips/sgi-ip22/ip22-reset.c	2004-08-14 03:56:22.000000000 -0700
+++ mm4-2.6.8.1/arch/mips/sgi-ip22/ip22-reset.c	2004-08-25 13:27:33.804966448 -0700
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/notifier.h>
 #include <linux/timer.h>
+#include <linux/signal.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
Index: mm4-2.6.8.1/arch/mips/sgi-ip27/ip27-berr.c
===================================================================
--- mm4-2.6.8.1.orig/arch/mips/sgi-ip27/ip27-berr.c	2004-08-14 03:55:09.000000000 -0700
+++ mm4-2.6.8.1/arch/mips/sgi-ip27/ip27-berr.c	2004-08-25 13:27:36.380574896 -0700
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/signal.h>
 
 #include <asm/module.h>
 #include <asm/sn/addrs.h>
Index: mm4-2.6.8.1/arch/mips/sgi-ip32/ip32-berr.c
===================================================================
--- mm4-2.6.8.1.orig/arch/mips/sgi-ip32/ip32-berr.c	2004-08-14 03:55:35.000000000 -0700
+++ mm4-2.6.8.1/arch/mips/sgi-ip32/ip32-berr.c	2004-08-25 13:27:38.955183496 -0700
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <asm/traps.h>
 #include <asm/uaccess.h>
 #include <asm/addrspace.h>
Index: mm4-2.6.8.1/arch/mips/sgi-ip32/ip32-reset.c
===================================================================
--- mm4-2.6.8.1.orig/arch/mips/sgi-ip32/ip32-reset.c	2004-08-14 03:56:01.000000000 -0700
+++ mm4-2.6.8.1/arch/mips/sgi-ip32/ip32-reset.c	2004-08-25 13:27:41.506795592 -0700
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/notifier.h>
 #include <linux/delay.h>
 #include <linux/ds17287rtc.h>
Index: mm4-2.6.8.1/arch/parisc/kernel/traps.c
===================================================================
--- mm4-2.6.8.1.orig/arch/parisc/kernel/traps.c	2004-08-14 03:56:24.000000000 -0700
+++ mm4-2.6.8.1/arch/parisc/kernel/traps.c	2004-08-25 13:27:44.721306912 -0700
@@ -12,6 +12,7 @@
 
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/errno.h>
Index: mm4-2.6.8.1/arch/parisc/kernel/unaligned.c
===================================================================
--- mm4-2.6.8.1.orig/arch/parisc/kernel/unaligned.c	2004-08-14 03:55:10.000000000 -0700
+++ mm4-2.6.8.1/arch/parisc/kernel/unaligned.c	2004-08-25 13:27:50.863373176 -0700
@@ -23,6 +23,7 @@
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/signal.h>
 
 /* #define DEBUG_UNALIGNED 1 */
 
Index: mm4-2.6.8.1/arch/parisc/math-emu/driver.c
===================================================================
--- mm4-2.6.8.1.orig/arch/parisc/math-emu/driver.c	2004-08-14 03:56:01.000000000 -0700
+++ mm4-2.6.8.1/arch/parisc/math-emu/driver.c	2004-08-25 13:28:07.737807872 -0700
@@ -29,6 +29,7 @@
 
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include "float.h"
 #include "math-emu.h"
 
Index: mm4-2.6.8.1/arch/parisc/mm/fault.c
===================================================================
--- mm4-2.6.8.1.orig/arch/parisc/mm/fault.c	2004-08-25 11:06:48.168898288 -0700
+++ mm4-2.6.8.1/arch/parisc/mm/fault.c	2004-08-25 13:28:11.152288792 -0700
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/ptrace.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 
Index: mm4-2.6.8.1/arch/ppc/kernel/traps.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ppc/kernel/traps.c	2004-08-25 09:56:41.239448776 -0700
+++ mm4-2.6.8.1/arch/ppc/kernel/traps.c	2004-08-25 13:28:23.644389704 -0700
@@ -18,6 +18,7 @@
 
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/stddef.h>
Index: mm4-2.6.8.1/arch/ppc64/kernel/mf.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ppc64/kernel/mf.c	2004-08-14 03:55:48.000000000 -0700
+++ mm4-2.6.8.1/arch/ppc64/kernel/mf.c	2004-08-25 13:28:16.230516784 -0700
@@ -31,6 +31,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/signal.h>
 #include <linux/completion.h>
 #include <asm/iSeries/HvLpConfig.h>
 #include <linux/slab.h>
Index: mm4-2.6.8.1/arch/ppc64/kernel/traps.c
===================================================================
--- mm4-2.6.8.1.orig/arch/ppc64/kernel/traps.c	2004-08-25 09:54:39.888896864 -0700
+++ mm4-2.6.8.1/arch/ppc64/kernel/traps.c	2004-08-25 13:28:20.533862576 -0700
@@ -19,6 +19,7 @@
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/stddef.h>
Index: mm4-2.6.8.1/arch/s390/kernel/traps.c
===================================================================
--- mm4-2.6.8.1.orig/arch/s390/kernel/traps.c	2004-08-14 03:55:10.000000000 -0700
+++ mm4-2.6.8.1/arch/s390/kernel/traps.c	2004-08-25 13:28:26.650932640 -0700
@@ -16,6 +16,7 @@
  */
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/errno.h>
Index: mm4-2.6.8.1/arch/sh/kernel/traps.c
===================================================================
--- mm4-2.6.8.1.orig/arch/sh/kernel/traps.c	2004-08-14 03:54:48.000000000 -0700
+++ mm4-2.6.8.1/arch/sh/kernel/traps.c	2004-08-25 13:28:34.448747192 -0700
@@ -14,6 +14,7 @@
  */
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/errno.h>
Index: mm4-2.6.8.1/arch/sh64/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/sh64/kernel/ptrace.c	2004-08-25 09:54:39.890896560 -0700
+++ mm4-2.6.8.1/arch/sh64/kernel/ptrace.c	2004-08-25 13:28:30.313375864 -0700
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/rwsem.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
Index: mm4-2.6.8.1/arch/sh64/kernel/traps.c
===================================================================
--- mm4-2.6.8.1.orig/arch/sh64/kernel/traps.c	2004-08-14 03:56:00.000000000 -0700
+++ mm4-2.6.8.1/arch/sh64/kernel/traps.c	2004-08-25 13:28:32.473047544 -0700
@@ -16,6 +16,7 @@
  * state in 'entry.S'.
  */
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/errno.h>
Index: mm4-2.6.8.1/arch/sparc/kernel/sys_solaris.c
===================================================================
--- mm4-2.6.8.1.orig/arch/sparc/kernel/sys_solaris.c	2004-08-14 03:54:52.000000000 -0700
+++ mm4-2.6.8.1/arch/sparc/kernel/sys_solaris.c	2004-08-25 13:28:38.510129768 -0700
@@ -6,6 +6,7 @@
 
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/errno.h>
Index: mm4-2.6.8.1/arch/sparc/kernel/sys_sparc.c
===================================================================
--- mm4-2.6.8.1.orig/arch/sparc/kernel/sys_sparc.c	2004-08-14 03:55:10.000000000 -0700
+++ mm4-2.6.8.1/arch/sparc/kernel/sys_sparc.c	2004-08-25 13:28:40.638806160 -0700
@@ -9,6 +9,7 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/file.h>
Index: mm4-2.6.8.1/arch/sparc/kernel/unaligned.c
===================================================================
--- mm4-2.6.8.1.orig/arch/sparc/kernel/unaligned.c	2004-08-14 03:56:00.000000000 -0700
+++ mm4-2.6.8.1/arch/sparc/kernel/unaligned.c	2004-08-25 13:28:42.717490152 -0700
@@ -9,6 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <asm/ptrace.h>
Index: mm4-2.6.8.1/arch/sparc64/kernel/sys_sparc.c
===================================================================
--- mm4-2.6.8.1.orig/arch/sparc64/kernel/sys_sparc.c	2004-08-14 03:55:33.000000000 -0700
+++ mm4-2.6.8.1/arch/sparc64/kernel/sys_sparc.c	2004-08-25 13:28:36.527431184 -0700
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/mm.h>
Index: mm4-2.6.8.1/arch/um/drivers/line.c
===================================================================
--- mm4-2.6.8.1.orig/arch/um/drivers/line.c	2004-08-23 16:11:03.000000000 -0700
+++ mm4-2.6.8.1/arch/um/drivers/line.c	2004-08-25 13:28:54.089761304 -0700
@@ -4,6 +4,7 @@
  */
 
 #include "linux/sched.h"
+#include "linux/signal.h"
 #include "linux/slab.h"
 #include "linux/list.h"
 #include "linux/interrupt.h"
Index: mm4-2.6.8.1/arch/um/drivers/port_kern.c
===================================================================
--- mm4-2.6.8.1.orig/arch/um/drivers/port_kern.c	2004-08-23 16:11:03.000000000 -0700
+++ mm4-2.6.8.1/arch/um/drivers/port_kern.c	2004-08-25 13:29:03.086393608 -0700
@@ -5,6 +5,7 @@
 
 #include "linux/list.h"
 #include "linux/sched.h"
+#include "linux/signal.h"
 #include "linux/slab.h"
 #include "linux/interrupt.h"
 #include "linux/irq.h"
Index: mm4-2.6.8.1/arch/um/drivers/ubd_kern.c
===================================================================
--- mm4-2.6.8.1.orig/arch/um/drivers/ubd_kern.c	2004-08-23 16:11:03.000000000 -0700
+++ mm4-2.6.8.1/arch/um/drivers/ubd_kern.c	2004-08-25 13:29:10.204311520 -0700
@@ -35,6 +35,7 @@
 #include "linux/blkpg.h"
 #include "linux/genhd.h"
 #include "linux/spinlock.h"
+#include "linux/signal.h"
 #include "asm/segment.h"
 #include "asm/uaccess.h"
 #include "asm/irq.h"
Index: mm4-2.6.8.1/arch/um/include/kern_util.h
===================================================================
--- mm4-2.6.8.1.orig/arch/um/include/kern_util.h	2004-08-23 16:11:03.000000000 -0700
+++ mm4-2.6.8.1/arch/um/include/kern_util.h	2004-08-25 13:29:22.887383400 -0700
@@ -7,6 +7,7 @@
 #define __KERN_UTIL_H__
 
 #include "linux/threads.h"
+#include "linux/signal.h"
 #include "sysdep/ptrace.h"
 
 extern int ncpus;
Index: mm4-2.6.8.1/arch/um/kernel/process_kern.c
===================================================================
--- mm4-2.6.8.1.orig/arch/um/kernel/process_kern.c	2004-08-23 16:11:04.000000000 -0700
+++ mm4-2.6.8.1/arch/um/kernel/process_kern.c	2004-08-25 13:29:59.478820656 -0700
@@ -6,6 +6,7 @@
 #include "linux/config.h"
 #include "linux/kernel.h"
 #include "linux/sched.h"
+#include "linux/signal.h"
 #include "linux/interrupt.h"
 #include "linux/mm.h"
 #include "linux/slab.h"
Index: mm4-2.6.8.1/arch/um/kernel/reboot.c
===================================================================
--- mm4-2.6.8.1.orig/arch/um/kernel/reboot.c	2004-08-23 16:11:03.000000000 -0700
+++ mm4-2.6.8.1/arch/um/kernel/reboot.c	2004-08-25 13:30:02.642339728 -0700
@@ -5,6 +5,7 @@
 
 #include "linux/module.h"
 #include "linux/sched.h"
+#include "linux/signal.h"
 #include "user_util.h"
 #include "kern_util.h"
 #include "kern.h"
Index: mm4-2.6.8.1/arch/um/kernel/trap_kern.c
===================================================================
--- mm4-2.6.8.1.orig/arch/um/kernel/trap_kern.c	2004-08-23 16:11:04.000000000 -0700
+++ mm4-2.6.8.1/arch/um/kernel/trap_kern.c	2004-08-25 13:30:04.960987240 -0700
@@ -6,6 +6,7 @@
 #include "linux/kernel.h"
 #include "asm/errno.h"
 #include "linux/sched.h"
+#include "linux/signal.h"
 #include "linux/mm.h"
 #include "linux/spinlock.h"
 #include "linux/config.h"
Index: mm4-2.6.8.1/arch/um/kernel/tt/syscall_kern.c
===================================================================
--- mm4-2.6.8.1.orig/arch/um/kernel/tt/syscall_kern.c	2004-08-23 16:11:03.000000000 -0700
+++ mm4-2.6.8.1/arch/um/kernel/tt/syscall_kern.c	2004-08-25 13:30:09.039367232 -0700
@@ -7,6 +7,7 @@
 #include "linux/utime.h"
 #include "linux/sys.h"
 #include "linux/ptrace.h"
+#include "linux/signal.h"
 #include "asm/unistd.h"
 #include "asm/ptrace.h"
 #include "asm/uaccess.h"
Index: mm4-2.6.8.1/arch/v850/kernel/ptrace.c
===================================================================
--- mm4-2.6.8.1.orig/arch/v850/kernel/ptrace.c	2004-08-23 16:11:18.000000000 -0700
+++ mm4-2.6.8.1/arch/v850/kernel/ptrace.c	2004-08-25 13:30:35.294375864 -0700
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/smp_lock.h>
 #include <linux/ptrace.h>
 
Index: mm4-2.6.8.1/arch/x86_64/kernel/traps.c
===================================================================
--- mm4-2.6.8.1.orig/arch/x86_64/kernel/traps.c	2004-08-23 16:11:09.000000000 -0700
+++ mm4-2.6.8.1/arch/x86_64/kernel/traps.c	2004-08-25 13:30:38.005963640 -0700
@@ -16,6 +16,7 @@
  */
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/errno.h>
Index: mm4-2.6.8.1/drivers/block/pktcdvd.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/block/pktcdvd.c	2004-08-23 16:11:03.000000000 -0700
+++ mm4-2.6.8.1/drivers/block/pktcdvd.c	2004-08-25 13:30:49.250254248 -0700
@@ -46,6 +46,7 @@
 #include <linux/seq_file.h>
 #include <linux/miscdevice.h>
 #include <linux/suspend.h>
+#include <linux/signal.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_ioctl.h>
 
Index: mm4-2.6.8.1/drivers/char/drm/drmP.h
===================================================================
--- mm4-2.6.8.1.orig/drivers/char/drm/drmP.h	2004-08-23 16:10:53.000000000 -0700
+++ mm4-2.6.8.1/drivers/char/drm/drmP.h	2004-08-25 13:31:31.690802304 -0700
@@ -55,6 +55,7 @@
 #include <linux/jiffies.h>
 #include <linux/smp_lock.h>	/* For (un)lock_kernel */
 #include <linux/mm.h>
+#include <linux/signal.h>
 #if defined(__alpha__) || defined(__powerpc__)
 #include <asm/pgtable.h> /* For pte_wrprotect */
 #endif
Index: mm4-2.6.8.1/drivers/char/drm/drm_irq.h
===================================================================
--- mm4-2.6.8.1.orig/drivers/char/drm/drm_irq.h	2004-08-14 03:55:35.000000000 -0700
+++ mm4-2.6.8.1/drivers/char/drm/drm_irq.h	2004-08-25 13:31:15.097324896 -0700
@@ -36,6 +36,7 @@
 #include "drmP.h"
 
 #include <linux/interrupt.h>	/* For task queue support */
+#include <linux/signal.h>
 
 #ifndef __HAVE_SHARED_IRQ
 #define __HAVE_SHARED_IRQ	0
Index: mm4-2.6.8.1/drivers/char/keyboard.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/char/keyboard.c	2004-08-23 16:10:56.000000000 -0700
+++ mm4-2.6.8.1/drivers/char/keyboard.c	2004-08-25 13:31:46.462556656 -0700
@@ -27,6 +27,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/mm.h>
Index: mm4-2.6.8.1/drivers/char/nwbutton.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/char/nwbutton.c	2004-08-14 03:56:23.000000000 -0700
+++ mm4-2.6.8.1/drivers/char/nwbutton.c	2004-08-25 13:31:50.652919624 -0700
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/interrupt.h>
 #include <linux/time.h>
 #include <linux/timer.h>
Index: mm4-2.6.8.1/drivers/char/sysrq.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/char/sysrq.c	2004-08-23 16:10:56.000000000 -0700
+++ mm4-2.6.8.1/drivers/char/sysrq.c	2004-08-25 13:31:52.595624288 -0700
@@ -14,6 +14,7 @@
 
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/interrupt.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
Index: mm4-2.6.8.1/drivers/input/serio/serio.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/input/serio/serio.c	2004-08-23 16:10:53.000000000 -0700
+++ mm4-2.6.8.1/drivers/input/serio/serio.c	2004-08-25 13:32:02.368138640 -0700
@@ -33,6 +33,7 @@
 #include <linux/wait.h>
 #include <linux/completion.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/smp_lock.h>
 #include <linux/suspend.h>
 #include <linux/slab.h>
Index: mm4-2.6.8.1/drivers/macintosh/adb.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/macintosh/adb.c	2004-08-14 03:56:24.000000000 -0700
+++ mm4-2.6.8.1/drivers/macintosh/adb.c	2004-08-25 13:32:04.999738576 -0700
@@ -25,6 +25,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/smp_lock.h>
 #include <linux/adb.h>
 #include <linux/cuda.h>
Index: mm4-2.6.8.1/drivers/md/md.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/md/md.c	2004-08-23 16:11:15.000000000 -0700
+++ mm4-2.6.8.1/drivers/md/md.c	2004-08-25 13:32:10.286934800 -0700
@@ -37,6 +37,7 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/buffer_head.h> /* for invalidate_bdev */
 #include <linux/suspend.h>
+#include <linux/signal.h>
 
 #include <linux/init.h>
 
Index: mm4-2.6.8.1/drivers/media/dvb/dvb-core/dvb_ca_en50221.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2004-08-14 03:55:10.000000000 -0700
+++ mm4-2.6.8.1/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2004-08-25 13:32:16.236030400 -0700
@@ -34,6 +34,7 @@
 #include <linux/module.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
+#include <linux/signal.h>
 #include <asm/semaphore.h>
 #include <asm/atomic.h>
 
Index: mm4-2.6.8.1/drivers/media/dvb/dvb-core/dvb_frontend.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/media/dvb/dvb-core/dvb_frontend.c	2004-08-14 03:54:51.000000000 -0700
+++ mm4-2.6.8.1/drivers/media/dvb/dvb-core/dvb_frontend.c	2004-08-25 13:32:19.794489432 -0700
@@ -32,6 +32,7 @@
 #include <linux/poll.h>
 #include <linux/module.h>
 #include <linux/list.h>
+#include <linux/signal.h>
 #include <asm/processor.h>
 #include <asm/semaphore.h>
 
Index: mm4-2.6.8.1/drivers/net/8139too.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/net/8139too.c	2004-08-23 16:11:14.000000000 -0700
+++ mm4-2.6.8.1/drivers/net/8139too.c	2004-08-25 13:32:24.193820632 -0700
@@ -109,6 +109,7 @@
 #include <linux/completion.h>
 #include <linux/crc32.h>
 #include <linux/suspend.h>
+#include <linux/signal.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/irq.h>
Index: mm4-2.6.8.1/drivers/net/eql.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/net/eql.c	2004-08-14 03:56:01.000000000 -0700
+++ mm4-2.6.8.1/drivers/net/eql.c	2004-08-25 13:32:29.567003784 -0700
@@ -116,6 +116,7 @@
 #include <linux/init.h>
 #include <linux/timer.h>
 #include <linux/netdevice.h>
+#include <linux/signal.h>
 
 #include <linux/if.h>
 #include <linux/if_arp.h>
Index: mm4-2.6.8.1/drivers/net/irda/stir4200.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/net/irda/stir4200.c	2004-08-14 03:54:52.000000000 -0700
+++ mm4-2.6.8.1/drivers/net/irda/stir4200.c	2004-08-25 13:32:33.966334984 -0700
@@ -51,6 +51,7 @@
 #include <linux/delay.h>
 #include <linux/usb.h>
 #include <linux/crc32.h>
+#include <linux/signal.h>
 #include <net/irda/irda.h>
 #include <net/irda/irlap.h>
 #include <net/irda/irda_device.h>
Index: mm4-2.6.8.1/drivers/net/wireless/airo.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/net/wireless/airo.c	2004-08-23 16:11:13.000000000 -0700
+++ mm4-2.6.8.1/drivers/net/wireless/airo.c	2004-08-25 13:32:38.086708592 -0700
@@ -34,6 +34,7 @@
 #include <linux/interrupt.h>
 #include <linux/suspend.h>
 #include <linux/in.h>
+#include <linux/signal.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/bitops.h>
Index: mm4-2.6.8.1/drivers/parisc/power.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/parisc/power.c	2004-08-14 03:54:48.000000000 -0700
+++ mm4-2.6.8.1/drivers/parisc/power.c	2004-08-25 13:32:40.819293176 -0700
@@ -43,6 +43,7 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
 
Index: mm4-2.6.8.1/drivers/perfctr/virtual.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/perfctr/virtual.c	2004-08-23 16:11:00.000000000 -0700
+++ mm4-2.6.8.1/drivers/perfctr/virtual.c	2004-08-25 13:32:44.489735184 -0700
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/perfctr.h>
+#include <linux/signal.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
Index: mm4-2.6.8.1/drivers/s390/char/fs3270.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/s390/char/fs3270.c	2004-08-14 03:55:09.000000000 -0700
+++ mm4-2.6.8.1/drivers/s390/char/fs3270.c	2004-08-25 13:32:48.937059088 -0700
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/types.h>
+#include <linux/signal.h>
 
 #include <asm/ccwdev.h>
 #include <asm/cio.h>
Index: mm4-2.6.8.1/drivers/s390/net/qeth_main.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/s390/net/qeth_main.c	2004-08-14 03:55:32.000000000 -0700
+++ mm4-2.6.8.1/drivers/s390/net/qeth_main.c	2004-08-25 13:32:51.514667232 -0700
@@ -56,6 +56,7 @@
 #include <linux/inetdevice.h>
 #include <linux/netdevice.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/workqueue.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
Index: mm4-2.6.8.1/drivers/s390/s390mach.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/s390/s390mach.c	2004-08-14 03:56:23.000000000 -0700
+++ mm4-2.6.8.1/drivers/s390/s390mach.c	2004-08-25 13:32:53.574354112 -0700
@@ -11,6 +11,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/errno.h>
 #include <linux/workqueue.h>
 
Index: mm4-2.6.8.1/drivers/sbus/char/bbc_envctrl.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/sbus/char/bbc_envctrl.c	2004-08-14 03:56:26.000000000 -0700
+++ mm4-2.6.8.1/drivers/sbus/char/bbc_envctrl.c	2004-08-25 13:32:55.590047680 -0700
@@ -6,6 +6,7 @@
 
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <asm/oplib.h>
Index: mm4-2.6.8.1/drivers/sbus/char/envctrl.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/sbus/char/envctrl.c	2004-08-14 03:54:50.000000000 -0700
+++ mm4-2.6.8.1/drivers/sbus/char/envctrl.c	2004-08-25 13:32:57.701726656 -0700
@@ -22,6 +22,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
Index: mm4-2.6.8.1/drivers/scsi/aacraid/linit.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/scsi/aacraid/linit.c	2004-08-23 16:10:54.000000000 -0700
+++ mm4-2.6.8.1/drivers/scsi/aacraid/linit.c	2004-08-25 13:33:03.755806296 -0700
@@ -45,6 +45,7 @@
 #include <linux/syscalls.h>
 #include <linux/ioctl32.h>
 #include <linux/delay.h>
+#include <linux/signal.h>
 #include <asm/semaphore.h>
 
 #include <scsi/scsi.h>
Index: mm4-2.6.8.1/drivers/scsi/cpqfcTSinit.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/scsi/cpqfcTSinit.c	2004-08-23 16:11:13.000000000 -0700
+++ mm4-2.6.8.1/drivers/scsi/cpqfcTSinit.c	2004-08-25 13:33:08.962014832 -0700
@@ -45,6 +45,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>  // request_region() prototype
 #include <linux/completion.h>
+#include <linux/signal.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>   // ioctl related
Index: mm4-2.6.8.1/drivers/scsi/qla2xxx/qla_os.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/scsi/qla2xxx/qla_os.c	2004-08-23 16:11:08.000000000 -0700
+++ mm4-2.6.8.1/drivers/scsi/qla2xxx/qla_os.c	2004-08-25 13:33:13.905263344 -0700
@@ -21,6 +21,7 @@
 #include <linux/moduleparam.h>
 #include <linux/vmalloc.h>
 #include <linux/smp_lock.h>
+#include <linux/signal.h>
 
 #include <scsi/scsi_tcq.h>
 #include <scsi/scsicam.h>
Index: mm4-2.6.8.1/drivers/usb/core/hub.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/usb/core/hub.c	2004-08-23 16:10:55.000000000 -0700
+++ mm4-2.6.8.1/drivers/usb/core/hub.c	2004-08-25 13:33:16.201914200 -0700
@@ -20,6 +20,7 @@
 #include <linux/moduleparam.h>
 #include <linux/completion.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
Index: mm4-2.6.8.1/drivers/usb/core/inode.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/usb/core/inode.c	2004-08-23 16:10:55.000000000 -0700
+++ mm4-2.6.8.1/drivers/usb/core/inode.c	2004-08-25 13:33:20.445269112 -0700
@@ -39,6 +39,7 @@
 #include <linux/usbdevice_fs.h>
 #include <linux/smp_lock.h>
 #include <linux/parser.h>
+#include <linux/signal.h>
 #include <asm/byteorder.h>
 
 static struct super_operations usbfs_ops;
Index: mm4-2.6.8.1/drivers/w1/w1.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/w1/w1.c	2004-08-23 16:10:54.000000000 -0700
+++ mm4-2.6.8.1/drivers/w1/w1.c	2004-08-25 13:33:22.676929848 -0700
@@ -32,6 +32,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/suspend.h>
 
 #include "w1.h"
Index: mm4-2.6.8.1/drivers/w1/w1_int.c
===================================================================
--- mm4-2.6.8.1.orig/drivers/w1/w1_int.c	2004-08-23 16:10:54.000000000 -0700
+++ mm4-2.6.8.1/drivers/w1/w1_int.c	2004-08-25 13:33:25.771459408 -0700
@@ -21,6 +21,7 @@
 
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/signal.h>
 
 #include "w1.h"
 #include "w1_log.h"
Index: mm4-2.6.8.1/fs/buffer.c
===================================================================
--- mm4-2.6.8.1.orig/fs/buffer.c	2004-08-23 16:19:32.000000000 -0700
+++ mm4-2.6.8.1/fs/buffer.c	2004-08-25 13:33:33.802238544 -0700
@@ -37,6 +37,7 @@
 #include <linux/bio.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
+#include <linux/signal.h>
 #include <asm/bitops.h>
 
 static void invalidate_bh_lrus(void);
Index: mm4-2.6.8.1/fs/cifs/cifsfs.c
===================================================================
--- mm4-2.6.8.1.orig/fs/cifs/cifsfs.c	2004-08-23 16:11:17.000000000 -0700
+++ mm4-2.6.8.1/fs/cifs/cifsfs.c	2004-08-25 13:33:42.677889240 -0700
@@ -32,6 +32,7 @@
 #include <linux/seq_file.h>
 #include <linux/vfs.h>
 #include <linux/mempool.h>
+#include <linux/signal.h>
 #include "cifsfs.h"
 #include "cifspdu.h"
 #define DECLARE_GLOBALS_HERE
Index: mm4-2.6.8.1/fs/cifs/connect.c
===================================================================
--- mm4-2.6.8.1.orig/fs/cifs/connect.c	2004-08-14 03:56:15.000000000 -0700
+++ mm4-2.6.8.1/fs/cifs/connect.c	2004-08-25 13:33:47.717123160 -0700
@@ -29,6 +29,7 @@
 #include <linux/ctype.h>
 #include <linux/utsname.h>
 #include <linux/mempool.h>
+#include <linux/signal.h>
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 #include "cifspdu.h"
Index: mm4-2.6.8.1/fs/dnotify.c
===================================================================
--- mm4-2.6.8.1.orig/fs/dnotify.c	2004-08-14 03:55:10.000000000 -0700
+++ mm4-2.6.8.1/fs/dnotify.c	2004-08-25 13:33:49.818803656 -0700
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/dnotify.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
Index: mm4-2.6.8.1/fs/jffs/inode-v23.c
===================================================================
--- mm4-2.6.8.1.orig/fs/jffs/inode-v23.c	2004-08-14 03:55:34.000000000 -0700
+++ mm4-2.6.8.1/fs/jffs/inode-v23.c	2004-08-25 13:33:56.001863688 -0700
@@ -42,6 +42,7 @@
 #include <linux/quotaops.h>
 #include <linux/highmem.h>
 #include <linux/vfs.h>
+#include <linux/signal.h>
 #include <asm/semaphore.h>
 #include <asm/byteorder.h>
 #include <asm/uaccess.h>
Index: mm4-2.6.8.1/fs/ncpfs/file.c
===================================================================
--- mm4-2.6.8.1.orig/fs/ncpfs/file.c	2004-08-23 16:11:20.000000000 -0700
+++ mm4-2.6.8.1/fs/ncpfs/file.c	2004-08-25 13:33:59.824282592 -0700
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/smp_lock.h>
+#include <linux/signal.h>
 
 #include <linux/ncp_fs.h>
 #include "ncplib_kernel.h"
Index: mm4-2.6.8.1/fs/ncpfs/inode.c
===================================================================
--- mm4-2.6.8.1.orig/fs/ncpfs/inode.c	2004-08-23 16:11:17.000000000 -0700
+++ mm4-2.6.8.1/fs/ncpfs/inode.c	2004-08-25 13:34:04.046640696 -0700
@@ -29,6 +29,7 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/vfs.h>
+#include <linux/signal.h>
 
 #include <linux/ncp_fs.h>
 
Index: mm4-2.6.8.1/fs/nfs/direct.c
===================================================================
--- mm4-2.6.8.1.orig/fs/nfs/direct.c	2004-08-14 03:56:09.000000000 -0700
+++ mm4-2.6.8.1/fs/nfs/direct.c	2004-08-25 13:34:06.301297936 -0700
@@ -39,6 +39,7 @@
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/kernel.h>
 #include <linux/smp_lock.h>
 #include <linux/file.h>
Index: mm4-2.6.8.1/fs/nfsd/nfssvc.c
===================================================================
--- mm4-2.6.8.1.orig/fs/nfsd/nfssvc.c	2004-08-14 03:55:33.000000000 -0700
+++ mm4-2.6.8.1/fs/nfsd/nfssvc.c	2004-08-25 13:34:10.132715472 -0700
@@ -21,6 +21,7 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/fs_struct.h>
+#include <linux/signal.h>
 
 #include <linux/sunrpc/types.h>
 #include <linux/sunrpc/stats.h>
Index: mm4-2.6.8.1/fs/pipe.c
===================================================================
--- mm4-2.6.8.1.orig/fs/pipe.c	2004-08-14 03:55:33.000000000 -0700
+++ mm4-2.6.8.1/fs/pipe.c	2004-08-25 13:34:13.907141672 -0700
@@ -14,6 +14,7 @@
 #include <linux/mount.h>
 #include <linux/pipe_fs_i.h>
 #include <linux/uio.h>
+#include <linux/signal.h>
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
 
Index: mm4-2.6.8.1/fs/smbfs/inode.c
===================================================================
--- mm4-2.6.8.1.orig/fs/smbfs/inode.c	2004-08-23 16:11:17.000000000 -0700
+++ mm4-2.6.8.1/fs/smbfs/inode.c	2004-08-25 13:34:23.929618024 -0700
@@ -29,6 +29,7 @@
 #include <linux/smb_fs.h>
 #include <linux/smbno.h>
 #include <linux/smb_mount.h>
+#include <linux/signal.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
Index: mm4-2.6.8.1/fs/smbfs/smbiod.c
===================================================================
--- mm4-2.6.8.1.orig/fs/smbfs/smbiod.c	2004-08-14 03:55:35.000000000 -0700
+++ mm4-2.6.8.1/fs/smbfs/smbiod.c	2004-08-25 13:34:25.991304600 -0700
@@ -8,6 +8,7 @@
 #include <linux/config.h>
 
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/string.h>
Index: mm4-2.6.8.1/include/linux/fs.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/fs.h	2004-08-23 16:11:19.000000000 -0700
+++ mm4-2.6.8.1/include/linux/fs.h	2004-08-25 13:34:41.819898288 -0700
@@ -18,6 +18,7 @@
 #include <linux/cache.h>
 #include <linux/prio_tree.h>
 #include <linux/kobject.h>
+#include <linux/signal.h>
 #include <asm/atomic.h>
 
 struct iovec;
Index: mm4-2.6.8.1/include/linux/sched.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/sched.h	2004-08-25 12:31:14.519695896 -0700
+++ mm4-2.6.8.1/include/linux/sched.h	2004-08-25 13:55:00.045699816 -0700
@@ -638,32 +638,6 @@
 extern int in_egroup_p(gid_t);
 
 extern void proc_caches_init(void);
-extern void flush_signals(struct task_struct *);
-extern void flush_signal_handlers(struct task_struct *, int force_default);
-extern int dequeue_signal(struct task_struct *tsk, sigset_t *mask, siginfo_t *info);
-
-extern void block_all_signals(int (*notifier)(void *priv), void *priv,
-			      sigset_t *mask);
-extern void unblock_all_signals(void);
-extern void release_task(struct task_struct * p);
-extern int send_sig_info(int, struct siginfo *, struct task_struct *);
-extern int send_group_sig_info(int, struct siginfo *, struct task_struct *);
-extern int force_sig_info(int, struct siginfo *, struct task_struct *);
-extern int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp);
-extern int kill_pg_info(int, struct siginfo *, pid_t);
-extern int kill_sl_info(int, struct siginfo *, pid_t);
-extern int kill_proc_info(int, struct siginfo *, pid_t);
-extern void do_notify_parent(struct task_struct *, int);
-extern void force_sig(int, struct task_struct *);
-extern void force_sig_specific(int, struct task_struct *);
-extern int send_sig(int, struct task_struct *, int);
-extern void zap_other_threads(struct task_struct *p);
-extern int kill_pg(pid_t, int, int);
-extern int kill_sl(pid_t, int, int);
-extern int kill_proc(pid_t, int, int);
-extern int do_sigaction(int, const struct k_sigaction *, struct k_sigaction *);
-extern int do_sigaltstack(const stack_t __user *, stack_t __user *, unsigned long);
-
 /* These can be the second arg to send_sig_info/send_group_sig_info.  */
 #define SEND_SIG_NOINFO ((struct siginfo *) 0)
 #define SEND_SIG_PRIV	((struct siginfo *) 1)
@@ -723,17 +697,11 @@
 
 extern void exit_mm(struct task_struct *);
 extern void exit_files(struct task_struct *);
-extern void exit_signal(struct task_struct *);
-extern void __exit_signal(struct task_struct *);
-extern void exit_sighand(struct task_struct *);
-extern void __exit_sighand(struct task_struct *);
 
 extern NORET_TYPE void do_group_exit(int);
 
 extern void reparent_to_init(void);
 extern void daemonize(const char *, ...);
-extern int allow_signal(int);
-extern int disallow_signal(int);
 extern task_t *child_reaper;
 
 extern int do_execve(char *, char __user * __user *, char __user * __user *, struct pt_regs *);
Index: mm4-2.6.8.1/include/linux/signal.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/signal.h	2004-08-25 12:31:14.520695744 -0700
+++ mm4-2.6.8.1/include/linux/signal.h	2004-08-25 13:55:18.261930528 -0700
@@ -268,6 +268,7 @@
 	INIT_LIST_HEAD(&sig->list);
 }
 
+int dequeue_signal(task_t *, sigset_t *, siginfo_t *);
 static inline int dequeue_signal_lock(task_t *task, sigset_t *mask, siginfo_t *info)
 {
 	unsigned long flags;
@@ -292,6 +293,34 @@
 int send_sigqueue(int, struct sigqueue *, struct task_struct *);
 int send_group_sigqueue(int, struct sigqueue *, struct task_struct *);
 void exit_itimers(struct signal_struct *);
+void flush_signals(task_t *);
+void flush_signal_handlers(task_t *, int force_default);
+void block_all_signals(int (*)(void *), void *, sigset_t *);
+void unblock_all_signals(void);
+void release_task(task_t *);
+int send_sig_info(int, struct siginfo *, task_t *);
+int send_group_sig_info(int, struct siginfo *, task_t *);
+int force_sig_info(int, struct siginfo *, task_t *);
+int __kill_pg_info(int, struct siginfo *, pid_t);
+int kill_pg_info(int, struct siginfo *, pid_t);
+int kill_sl_info(int, struct siginfo *, pid_t);
+int kill_proc_info(int, struct siginfo *, pid_t);
+void do_notify_parent(task_t *, int);
+void force_sig(int, task_t *);
+void force_sig_specific(int, task_t *);
+int send_sig(int, task_t *, int);
+void zap_other_threads(task_t *);
+int kill_pg(pid_t, int, int);
+int kill_sl(pid_t, int, int);
+int kill_proc(pid_t, int, int);
+int do_sigaction(int, const struct k_sigaction *, struct k_sigaction *);
+int do_sigaltstack(const stack_t __user *, stack_t __user *, unsigned long);
+void exit_signal(task_t *);
+void __exit_signal(task_t *);
+void exit_sighand(task_t *);
+void __exit_sighand(task_t *);
+int allow_signal(int);
+int disallow_signal(int);
 
 #ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
 struct pt_regs;
Index: mm4-2.6.8.1/ipc/mqueue.c
===================================================================
--- mm4-2.6.8.1.orig/ipc/mqueue.c	2004-08-25 10:05:14.862366224 -0700
+++ mm4-2.6.8.1/ipc/mqueue.c	2004-08-25 13:34:52.518271888 -0700
@@ -23,6 +23,7 @@
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
 #include <linux/user.h>
+#include <linux/signal.h>
 #include <net/sock.h>
 #include "util.h"
 
Index: mm4-2.6.8.1/kernel/exec_domain.c
===================================================================
--- mm4-2.6.8.1.orig/kernel/exec_domain.c	2004-08-14 03:55:34.000000000 -0700
+++ mm4-2.6.8.1/kernel/exec_domain.c	2004-08-25 13:34:54.532965608 -0700
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/personality.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/sysctl.h>
 #include <linux/types.h>
 
Index: mm4-2.6.8.1/kernel/futex.c
===================================================================
--- mm4-2.6.8.1.orig/kernel/futex.c	2004-08-14 03:55:09.000000000 -0700
+++ mm4-2.6.8.1/kernel/futex.c	2004-08-25 13:34:59.139265344 -0700
@@ -39,6 +39,7 @@
 #include <linux/mount.h>
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
+#include <linux/signal.h>
 
 #define FUTEX_HASHBITS 8
 
Index: mm4-2.6.8.1/kernel/timer.c
===================================================================
--- mm4-2.6.8.1.orig/kernel/timer.c	2004-08-23 16:11:20.000000000 -0700
+++ mm4-2.6.8.1/kernel/timer.c	2004-08-25 13:35:04.354472512 -0700
@@ -32,6 +32,7 @@
 #include <linux/jiffies.h>
 #include <linux/cpu.h>
 #include <linux/perfctr.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
Index: mm4-2.6.8.1/mm/memory.c
===================================================================
--- mm4-2.6.8.1.orig/mm/memory.c	2004-08-23 16:11:10.000000000 -0700
+++ mm4-2.6.8.1/mm/memory.c	2004-08-25 13:35:10.336563096 -0700
@@ -46,6 +46,7 @@
 #include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/signal.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
Index: mm4-2.6.8.1/mm/nommu.c
===================================================================
--- mm4-2.6.8.1.orig/mm/nommu.c	2004-08-14 03:56:01.000000000 -0700
+++ mm4-2.6.8.1/mm/nommu.c	2004-08-25 13:35:13.470086728 -0700
@@ -19,6 +19,7 @@
 #include <linux/vmalloc.h>
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
+#include <linux/signal.h>
 
 #include <asm/uaccess.h>
 #include <asm/tlb.h>
Index: mm4-2.6.8.1/mm/oom_kill.c
===================================================================
--- mm4-2.6.8.1.orig/mm/oom_kill.c	2004-08-23 16:11:01.000000000 -0700
+++ mm4-2.6.8.1/mm/oom_kill.c	2004-08-25 13:35:16.989551688 -0700
@@ -20,6 +20,7 @@
 #include <linux/swap.h>
 #include <linux/timex.h>
 #include <linux/jiffies.h>
+#include <linux/signal.h>
 
 /* #define DEBUG */
 
Index: mm4-2.6.8.1/net/atm/common.c
===================================================================
--- mm4-2.6.8.1.orig/net/atm/common.c	2004-08-14 03:56:25.000000000 -0700
+++ mm4-2.6.8.1/net/atm/common.c	2004-08-25 13:35:20.092080032 -0700
@@ -14,6 +14,7 @@
 #include <linux/capability.h>
 #include <linux/mm.h>		/* verify_area */
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/time.h>		/* struct timeval */
 #include <linux/skbuff.h>
 #include <linux/bitops.h>
Index: mm4-2.6.8.1/net/ax25/af_ax25.c
===================================================================
--- mm4-2.6.8.1.orig/net/ax25/af_ax25.c	2004-08-14 03:56:22.000000000 -0700
+++ mm4-2.6.8.1/net/ax25/af_ax25.c	2004-08-25 13:35:22.387731040 -0700
@@ -21,6 +21,7 @@
 #include <linux/in.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/timer.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
Index: mm4-2.6.8.1/net/core/sock.c
===================================================================
--- mm4-2.6.8.1.orig/net/core/sock.c	2004-08-14 03:55:48.000000000 -0700
+++ mm4-2.6.8.1/net/core/sock.c	2004-08-25 13:35:24.531405152 -0700
@@ -100,6 +100,7 @@
 #include <linux/major.h>
 #include <linux/module.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/timer.h>
 #include <linux/string.h>
 #include <linux/sockios.h>
Index: mm4-2.6.8.1/net/decnet/af_decnet.c
===================================================================
--- mm4-2.6.8.1.orig/net/decnet/af_decnet.c	2004-08-14 03:55:32.000000000 -0700
+++ mm4-2.6.8.1/net/decnet/af_decnet.c	2004-08-25 13:35:26.755067104 -0700
@@ -108,6 +108,7 @@
 #include <linux/in.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/timer.h>
 #include <linux/string.h>
 #include <linux/sockios.h>
Index: mm4-2.6.8.1/net/ipv4/tcp_input.c
===================================================================
--- mm4-2.6.8.1.orig/net/ipv4/tcp_input.c	2004-08-14 03:55:48.000000000 -0700
+++ mm4-2.6.8.1/net/ipv4/tcp_input.c	2004-08-25 13:35:33.730006752 -0700
@@ -71,6 +71,7 @@
 #include <net/tcp.h>
 #include <net/inet_common.h>
 #include <linux/ipsec.h>
+#include <linux/signal.h>
 
 int sysctl_tcp_timestamps = 1;
 int sysctl_tcp_window_scaling = 1;
Index: mm4-2.6.8.1/net/ipv4/tcp_minisocks.c
===================================================================
--- mm4-2.6.8.1.orig/net/ipv4/tcp_minisocks.c	2004-08-14 03:55:48.000000000 -0700
+++ mm4-2.6.8.1/net/ipv4/tcp_minisocks.c	2004-08-25 13:35:37.559424592 -0700
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/sysctl.h>
 #include <linux/workqueue.h>
+#include <linux/signal.h>
 #include <net/tcp.h>
 #include <net/inet_common.h>
 #include <net/xfrm.h>
Index: mm4-2.6.8.1/net/irda/af_irda.c
===================================================================
--- mm4-2.6.8.1.orig/net/irda/af_irda.c	2004-08-14 03:55:10.000000000 -0700
+++ mm4-2.6.8.1/net/irda/af_irda.c	2004-08-25 13:35:42.110732688 -0700
@@ -51,6 +51,7 @@
 #include <linux/net.h>
 #include <linux/irda.h>
 #include <linux/poll.h>
+#include <linux/signal.h>
 
 #include <asm/ioctls.h>		/* TIOCOUTQ, TIOCINQ */
 #include <asm/uaccess.h>
Index: mm4-2.6.8.1/net/netrom/af_netrom.c
===================================================================
--- mm4-2.6.8.1.orig/net/netrom/af_netrom.c	2004-08-14 03:55:32.000000000 -0700
+++ mm4-2.6.8.1/net/netrom/af_netrom.c	2004-08-25 13:35:44.661344936 -0700
@@ -17,6 +17,7 @@
 #include <linux/in.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/timer.h>
 #include <linux/string.h>
 #include <linux/sockios.h>
Index: mm4-2.6.8.1/net/rose/af_rose.c
===================================================================
--- mm4-2.6.8.1.orig/net/rose/af_rose.c	2004-08-14 03:55:32.000000000 -0700
+++ mm4-2.6.8.1/net/rose/af_rose.c	2004-08-25 13:35:46.797020264 -0700
@@ -19,6 +19,7 @@
 #include <linux/in.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/spinlock.h>
 #include <linux/timer.h>
 #include <linux/string.h>
Index: mm4-2.6.8.1/net/sctp/socket.c
===================================================================
--- mm4-2.6.8.1.orig/net/sctp/socket.c	2004-08-23 16:11:06.000000000 -0700
+++ mm4-2.6.8.1/net/sctp/socket.c	2004-08-25 13:35:51.404319848 -0700
@@ -67,6 +67,7 @@
 #include <linux/poll.h>
 #include <linux/init.h>
 #include <linux/crypto.h>
+#include <linux/signal.h>
 
 #include <net/ip.h>
 #include <net/icmp.h>
Index: mm4-2.6.8.1/net/x25/af_x25.c
===================================================================
--- mm4-2.6.8.1.orig/net/x25/af_x25.c	2004-08-14 03:56:22.000000000 -0700
+++ mm4-2.6.8.1/net/x25/af_x25.c	2004-08-25 13:35:53.552993200 -0700
@@ -39,6 +39,7 @@
 #include <linux/in.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/timer.h>
 #include <linux/string.h>
 #include <linux/sockios.h>
Index: mm4-2.6.8.1/net/x25/x25_in.c
===================================================================
--- mm4-2.6.8.1.orig/net/x25/x25_in.c	2004-08-14 03:56:23.000000000 -0700
+++ mm4-2.6.8.1/net/x25/x25_in.c	2004-08-25 13:35:59.550081504 -0700
@@ -29,6 +29,7 @@
 #include <linux/in.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/timer.h>
 #include <linux/string.h>
 #include <linux/sockios.h>
