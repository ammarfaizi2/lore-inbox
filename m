Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264195AbUDRWsc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 18:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264202AbUDRWsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 18:48:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30995 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264195AbUDRWsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 18:48:23 -0400
Date: Sun, 18 Apr 2004 23:48:20 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/2] Clean up asm/pgalloc.h include
Message-ID: <20040418234820.D12222@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20040418231720.C12222@flint.arm.linux.org.uk> <20040418232314.A2045@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040418232314.A2045@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Apr 18, 2004 at 11:23:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up needless includes of asm/pgalloc.h from the
arch/i386/ subtree.  Compile tested on x86_pc SMP.

[I also tried VISWS + SMP without PM doesn't build in smpboot.c,
 though I don't believe its caused by this patch.  With PM, fails
 to link complaining maxcpus is undefined.  Therefore, I presume
 VISWS + SMP is an invalid configuration.]

This patch is part of a larger patch aiming towards getting the
include of asm/pgtable.h out of linux/mm.h, so that asm/pgtable.h
can sanely get at things like mm_struct and friends.

I suggest testing in -mm for a while to ensure there aren't any
hidden arch issues.

The outstanding list of files for other architectures can be found
at http://www.arm.linux.org.uk/misc/pgalloc.txt

 arch/i386/kernel/acpi/boot.c            |    2 +-
 arch/i386/kernel/apic.c                 |    1 -
 arch/i386/kernel/efi.c                  |    1 -
 arch/i386/kernel/i386_ksyms.c           |    1 -
 arch/i386/kernel/irq.c                  |    1 -
 arch/i386/kernel/mpparse.c              |    1 -
 arch/i386/kernel/smp.c                  |    1 -
 arch/i386/kernel/smpboot.c              |    1 -
 arch/i386/kernel/traps.c                |    1 -
 arch/i386/kernel/vm86.c                 |    1 -
 arch/i386/mach-visws/traps.c            |    1 -
 arch/i386/mach-voyager/voyager_basic.c  |    1 -
 arch/i386/mach-voyager/voyager_smp.c    |    1 -
 arch/i386/mach-voyager/voyager_thread.c |    1 -
 arch/i386/mm/fault.c                    |    1 -
 arch/i386/mm/hugetlbpage.c              |    1 -
 arch/i386/mm/init.c                     |    1 -
 arch/i386/mm/ioremap.c                  |    1 -
 18 files changed, 1 insertion(+), 18 deletions(-)

diff -urpN orig/arch/i386/kernel/acpi/boot.c linux/arch/i386/kernel/acpi/boot.c
--- orig/arch/i386/kernel/acpi/boot.c	Sat Apr 10 12:31:37 2004
+++ linux/arch/i386/kernel/acpi/boot.c	Sun Apr 18 23:28:55 2004
@@ -28,7 +28,7 @@
 #include <linux/acpi.h>
 #include <linux/efi.h>
 #include <linux/irq.h>
-#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
 #include <asm/io.h>
diff -urpN orig/arch/i386/kernel/apic.c linux/arch/i386/kernel/apic.c
--- orig/arch/i386/kernel/apic.c	Thu Mar  4 13:25:17 2004
+++ linux/arch/i386/kernel/apic.c	Sun Apr 18 23:24:53 2004
@@ -31,7 +31,6 @@
 #include <asm/smp.h>
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
-#include <asm/pgalloc.h>
 #include <asm/desc.h>
 #include <asm/arch_hooks.h>
 #include <asm/hpet.h>
diff -urpN orig/arch/i386/kernel/efi.c linux/arch/i386/kernel/efi.c
--- orig/arch/i386/kernel/efi.c	Thu Feb  5 15:24:49 2004
+++ linux/arch/i386/kernel/efi.c	Sun Apr 18 23:25:02 2004
@@ -37,7 +37,6 @@
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/desc.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
 #define EFI_DEBUG	0
diff -urpN orig/arch/i386/kernel/i386_ksyms.c linux/arch/i386/kernel/i386_ksyms.c
--- orig/arch/i386/kernel/i386_ksyms.c	Sat Mar 20 09:22:13 2004
+++ linux/arch/i386/kernel/i386_ksyms.c	Sun Apr 18 23:25:11 2004
@@ -29,7 +29,6 @@
 #include <asm/mmx.h>
 #include <asm/desc.h>
 #include <asm/pgtable.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/nmi.h>
 #include <asm/ist.h>
diff -urpN orig/arch/i386/kernel/irq.c linux/arch/i386/kernel/irq.c
--- orig/arch/i386/kernel/irq.c	Tue Apr 13 19:40:03 2004
+++ linux/arch/i386/kernel/irq.c	Sun Apr 18 23:25:20 2004
@@ -41,7 +41,6 @@
 #include <asm/system.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/delay.h>
 #include <asm/desc.h>
 #include <asm/irq.h>
diff -urpN orig/arch/i386/kernel/mpparse.c linux/arch/i386/kernel/mpparse.c
--- orig/arch/i386/kernel/mpparse.c	Thu Apr  1 19:33:01 2004
+++ linux/arch/i386/kernel/mpparse.c	Sun Apr 18 23:25:28 2004
@@ -28,7 +28,6 @@
 #include <asm/acpi.h>
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
-#include <asm/pgalloc.h>
 #include <asm/io_apic.h>
 
 #include <mach_apic.h>
diff -urpN orig/arch/i386/kernel/smp.c linux/arch/i386/kernel/smp.c
--- orig/arch/i386/kernel/smp.c	Thu Mar 11 09:56:46 2004
+++ linux/arch/i386/kernel/smp.c	Sun Apr 18 23:25:34 2004
@@ -21,7 +21,6 @@
 #include <linux/interrupt.h>
 
 #include <asm/mtrr.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <mach_ipi.h>
 #include <mach_apic.h>
diff -urpN orig/arch/i386/kernel/smpboot.c linux/arch/i386/kernel/smpboot.c
--- orig/arch/i386/kernel/smpboot.c	Tue Apr 13 19:40:05 2004
+++ linux/arch/i386/kernel/smpboot.c	Sun Apr 18 23:25:41 2004
@@ -46,7 +46,6 @@
 
 #include <linux/delay.h>
 #include <linux/mc146818rtc.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/desc.h>
 #include <asm/arch_hooks.h>
diff -urpN orig/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
--- orig/arch/i386/kernel/traps.c	Tue Apr 13 19:40:05 2004
+++ linux/arch/i386/kernel/traps.c	Sun Apr 18 23:25:52 2004
@@ -47,7 +47,6 @@
 #include <asm/nmi.h>
 
 #include <asm/smp.h>
-#include <asm/pgalloc.h>
 #include <asm/arch_hooks.h>
 
 #include <linux/irq.h>
diff -urpN orig/arch/i386/kernel/vm86.c linux/arch/i386/kernel/vm86.c
--- orig/arch/i386/kernel/vm86.c	Thu Mar 11 09:56:46 2004
+++ linux/arch/i386/kernel/vm86.c	Sun Apr 18 23:26:01 2004
@@ -44,7 +44,6 @@
 #include <linux/ptrace.h>
 
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/io.h>
 #include <asm/tlbflush.h>
 #include <asm/irq.h>
diff -urpN orig/arch/i386/mach-visws/traps.c linux/arch/i386/mach-visws/traps.c
--- orig/arch/i386/mach-visws/traps.c	Tue Feb 25 10:57:32 2003
+++ linux/arch/i386/mach-visws/traps.c	Sun Apr 18 23:26:10 2004
@@ -8,7 +8,6 @@
 #include <linux/pci_ids.h>
 
 #include <asm/io.h>
-#include <asm/pgalloc.h>
 #include <asm/arch_hooks.h>
 #include <asm/apic.h>
 #include "cobalt.h"
diff -urpN orig/arch/i386/mach-voyager/voyager_basic.c linux/arch/i386/mach-voyager/voyager_basic.c
--- orig/arch/i386/mach-voyager/voyager_basic.c	Thu Oct  9 00:03:45 2003
+++ linux/arch/i386/mach-voyager/voyager_basic.c	Sun Apr 18 23:26:19 2004
@@ -24,7 +24,6 @@
 #include <linux/reboot.h>
 #include <linux/sysrq.h>
 #include <asm/io.h>
-#include <asm/pgalloc.h>
 #include <asm/voyager.h>
 #include <asm/vic.h>
 #include <linux/pm.h>
diff -urpN orig/arch/i386/mach-voyager/voyager_smp.c linux/arch/i386/mach-voyager/voyager_smp.c
--- orig/arch/i386/mach-voyager/voyager_smp.c	Fri Mar 19 11:55:21 2004
+++ linux/arch/i386/mach-voyager/voyager_smp.c	Sun Apr 18 23:26:27 2004
@@ -24,7 +24,6 @@
 #include <asm/desc.h>
 #include <asm/voyager.h>
 #include <asm/vic.h>
-#include <asm/pgalloc.h>
 #include <asm/mtrr.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
diff -urpN orig/arch/i386/mach-voyager/voyager_thread.c linux/arch/i386/mach-voyager/voyager_thread.c
--- orig/arch/i386/mach-voyager/voyager_thread.c	Fri Feb 21 19:48:37 2003
+++ linux/arch/i386/mach-voyager/voyager_thread.c	Sun Apr 18 23:26:33 2004
@@ -28,7 +28,6 @@
 #include <asm/desc.h>
 #include <asm/voyager.h>
 #include <asm/vic.h>
-#include <asm/pgalloc.h>
 #include <asm/mtrr.h>
 #include <asm/msr.h>
 
diff -urpN orig/arch/i386/mm/fault.c linux/arch/i386/mm/fault.c
--- orig/arch/i386/mm/fault.c	Thu Dec 18 09:57:40 2003
+++ linux/arch/i386/mm/fault.c	Sun Apr 18 23:26:40 2004
@@ -24,7 +24,6 @@
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/hardirq.h>
 #include <asm/desc.h>
 
diff -urpN orig/arch/i386/mm/hugetlbpage.c linux/arch/i386/mm/hugetlbpage.c
--- orig/arch/i386/mm/hugetlbpage.c	Tue Apr 13 19:40:05 2004
+++ linux/arch/i386/mm/hugetlbpage.c	Sun Apr 18 23:26:48 2004
@@ -16,7 +16,6 @@
 #include <linux/err.h>
 #include <linux/sysctl.h>
 #include <asm/mman.h>
-#include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
diff -urpN orig/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- orig/arch/i386/mm/init.c	Wed Apr 14 21:17:13 2004
+++ linux/arch/i386/mm/init.c	Sun Apr 18 23:26:56 2004
@@ -32,7 +32,6 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
-#include <asm/pgalloc.h>
 #include <asm/dma.h>
 #include <asm/fixmap.h>
 #include <asm/e820.h>
diff -urpN orig/arch/i386/mm/ioremap.c linux/arch/i386/mm/ioremap.c
--- orig/arch/i386/mm/ioremap.c	Tue Nov 25 15:56:31 2003
+++ linux/arch/i386/mm/ioremap.c	Sun Apr 18 23:27:02 2004
@@ -12,7 +12,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <asm/io.h>
-#include <asm/pgalloc.h>
 #include <asm/fixmap.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
