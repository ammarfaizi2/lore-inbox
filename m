Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbVIZEtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbVIZEtq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 00:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVIZEtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 00:49:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:8576 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932374AbVIZEtp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 00:49:45 -0400
Date: Mon, 26 Sep 2005 05:49:44 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] useless includes of linux/irq.h in arch/i386
Message-ID: <20050926044944.GN7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Most of these guys are simply not needed (pulled by other stuff
via asm-i386/hardirq.h).  One that is not entirely useless is hilarious -
arch/i386/oprofile/nmi_timer_int.c includes linux/irq.h... as a way to
get linux/errno.h

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git5-n_r3964/arch/i386/kernel/acpi/boot.c RC14-rc2-git5-i386-irq/arch/i386/kernel/acpi/boot.c
--- RC14-rc2-git5-n_r3964/arch/i386/kernel/acpi/boot.c	2005-09-10 15:41:34.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/kernel/acpi/boot.c	2005-09-25 23:46:56.000000000 -0400
@@ -27,7 +27,6 @@
 #include <linux/config.h>
 #include <linux/acpi.h>
 #include <linux/efi.h>
-#include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/dmi.h>
 
diff -urN RC14-rc2-git5-n_r3964/arch/i386/kernel/apic.c RC14-rc2-git5-i386-irq/arch/i386/kernel/apic.c
--- RC14-rc2-git5-n_r3964/arch/i386/kernel/apic.c	2005-08-28 23:09:39.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/kernel/apic.c	2005-09-25 23:46:56.000000000 -0400
@@ -18,7 +18,6 @@
 #include <linux/init.h>
 
 #include <linux/mm.h>
-#include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/bootmem.h>
 #include <linux/smp_lock.h>
diff -urN RC14-rc2-git5-n_r3964/arch/i386/kernel/cpu/mcheck/k7.c RC14-rc2-git5-i386-irq/arch/i386/kernel/cpu/mcheck/k7.c
--- RC14-rc2-git5-n_r3964/arch/i386/kernel/cpu/mcheck/k7.c	2005-08-28 23:09:39.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/kernel/cpu/mcheck/k7.c	2005-09-25 23:46:56.000000000 -0400
@@ -7,7 +7,6 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/config.h>
-#include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/smp.h>
 
diff -urN RC14-rc2-git5-n_r3964/arch/i386/kernel/cpu/mcheck/non-fatal.c RC14-rc2-git5-i386-irq/arch/i386/kernel/cpu/mcheck/non-fatal.c
--- RC14-rc2-git5-n_r3964/arch/i386/kernel/cpu/mcheck/non-fatal.c	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/kernel/cpu/mcheck/non-fatal.c	2005-09-25 23:46:56.000000000 -0400
@@ -12,7 +12,6 @@
 #include <linux/kernel.h>
 #include <linux/jiffies.h>
 #include <linux/config.h>
-#include <linux/irq.h>
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
 #include <linux/smp.h>
diff -urN RC14-rc2-git5-n_r3964/arch/i386/kernel/cpu/mcheck/p4.c RC14-rc2-git5-i386-irq/arch/i386/kernel/cpu/mcheck/p4.c
--- RC14-rc2-git5-n_r3964/arch/i386/kernel/cpu/mcheck/p4.c	2005-08-28 23:09:39.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/kernel/cpu/mcheck/p4.c	2005-09-25 23:46:56.000000000 -0400
@@ -6,7 +6,6 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/config.h>
-#include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/smp.h>
 
diff -urN RC14-rc2-git5-n_r3964/arch/i386/kernel/cpu/mcheck/p5.c RC14-rc2-git5-i386-irq/arch/i386/kernel/cpu/mcheck/p5.c
--- RC14-rc2-git5-n_r3964/arch/i386/kernel/cpu/mcheck/p5.c	2005-08-28 23:09:39.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/kernel/cpu/mcheck/p5.c	2005-09-25 23:46:56.000000000 -0400
@@ -6,7 +6,6 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/smp.h>
 
diff -urN RC14-rc2-git5-n_r3964/arch/i386/kernel/cpu/mcheck/p6.c RC14-rc2-git5-i386-irq/arch/i386/kernel/cpu/mcheck/p6.c
--- RC14-rc2-git5-n_r3964/arch/i386/kernel/cpu/mcheck/p6.c	2005-08-28 23:09:39.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/kernel/cpu/mcheck/p6.c	2005-09-25 23:46:56.000000000 -0400
@@ -6,7 +6,6 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/smp.h>
 
diff -urN RC14-rc2-git5-n_r3964/arch/i386/kernel/cpu/mcheck/winchip.c RC14-rc2-git5-i386-irq/arch/i386/kernel/cpu/mcheck/winchip.c
--- RC14-rc2-git5-n_r3964/arch/i386/kernel/cpu/mcheck/winchip.c	2005-08-28 23:09:39.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/kernel/cpu/mcheck/winchip.c	2005-09-25 23:46:56.000000000 -0400
@@ -6,7 +6,6 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/irq.h>
 #include <linux/interrupt.h>
 
 #include <asm/processor.h> 
diff -urN RC14-rc2-git5-n_r3964/arch/i386/kernel/crash.c RC14-rc2-git5-i386-irq/arch/i386/kernel/crash.c
--- RC14-rc2-git5-n_r3964/arch/i386/kernel/crash.c	2005-09-05 07:05:13.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/kernel/crash.c	2005-09-25 23:46:56.000000000 -0400
@@ -11,10 +11,8 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/smp.h>
-#include <linux/irq.h>
 #include <linux/reboot.h>
 #include <linux/kexec.h>
-#include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/elf.h>
 #include <linux/elfcore.h>
diff -urN RC14-rc2-git5-n_r3964/arch/i386/kernel/i8259.c RC14-rc2-git5-i386-irq/arch/i386/kernel/i8259.c
--- RC14-rc2-git5-n_r3964/arch/i386/kernel/i8259.c	2005-08-28 23:09:39.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/kernel/i8259.c	2005-09-25 23:46:56.000000000 -0400
@@ -16,7 +16,6 @@
 #include <asm/atomic.h>
 #include <asm/system.h>
 #include <asm/io.h>
-#include <asm/irq.h>
 #include <asm/timer.h>
 #include <asm/pgtable.h>
 #include <asm/delay.h>
@@ -25,8 +24,6 @@
 #include <asm/arch_hooks.h>
 #include <asm/i8259.h>
 
-#include <linux/irq.h>
-
 #include <io_ports.h>
 
 /*
diff -urN RC14-rc2-git5-n_r3964/arch/i386/kernel/io_apic.c RC14-rc2-git5-i386-irq/arch/i386/kernel/io_apic.c
--- RC14-rc2-git5-n_r3964/arch/i386/kernel/io_apic.c	2005-09-13 13:29:27.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/kernel/io_apic.c	2005-09-25 23:46:56.000000000 -0400
@@ -21,7 +21,6 @@
  */
 
 #include <linux/mm.h>
-#include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/delay.h>
diff -urN RC14-rc2-git5-n_r3964/arch/i386/kernel/mpparse.c RC14-rc2-git5-i386-irq/arch/i386/kernel/mpparse.c
--- RC14-rc2-git5-n_r3964/arch/i386/kernel/mpparse.c	2005-09-10 15:41:34.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/kernel/mpparse.c	2005-09-25 23:46:56.000000000 -0400
@@ -14,7 +14,6 @@
  */
 
 #include <linux/mm.h>
-#include <linux/irq.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
 #include <linux/delay.h>
diff -urN RC14-rc2-git5-n_r3964/arch/i386/kernel/nmi.c RC14-rc2-git5-i386-irq/arch/i386/kernel/nmi.c
--- RC14-rc2-git5-n_r3964/arch/i386/kernel/nmi.c	2005-09-08 10:07:30.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/kernel/nmi.c	2005-09-25 23:46:56.000000000 -0400
@@ -15,7 +15,6 @@
 
 #include <linux/config.h>
 #include <linux/mm.h>
-#include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/bootmem.h>
 #include <linux/smp_lock.h>
diff -urN RC14-rc2-git5-n_r3964/arch/i386/kernel/process.c RC14-rc2-git5-i386-irq/arch/i386/kernel/process.c
--- RC14-rc2-git5-n_r3964/arch/i386/kernel/process.c	2005-09-05 07:05:13.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/kernel/process.c	2005-09-25 23:46:56.000000000 -0400
@@ -47,13 +47,11 @@
 #include <asm/ldt.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
-#include <asm/irq.h>
 #include <asm/desc.h>
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
 #endif
 
-#include <linux/irq.h>
 #include <linux/err.h>
 
 #include <asm/tlbflush.h>
diff -urN RC14-rc2-git5-n_r3964/arch/i386/kernel/smp.c RC14-rc2-git5-i386-irq/arch/i386/kernel/smp.c
--- RC14-rc2-git5-n_r3964/arch/i386/kernel/smp.c	2005-09-05 07:05:13.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/kernel/smp.c	2005-09-25 23:46:56.000000000 -0400
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 
 #include <linux/mm.h>
-#include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
 #include <linux/smp_lock.h>
diff -urN RC14-rc2-git5-n_r3964/arch/i386/kernel/smpboot.c RC14-rc2-git5-i386-irq/arch/i386/kernel/smpboot.c
--- RC14-rc2-git5-n_r3964/arch/i386/kernel/smpboot.c	2005-09-22 01:17:30.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/kernel/smpboot.c	2005-09-25 23:46:56.000000000 -0400
@@ -42,7 +42,6 @@
 #include <linux/sched.h>
 #include <linux/kernel_stat.h>
 #include <linux/smp_lock.h>
-#include <linux/irq.h>
 #include <linux/bootmem.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
diff -urN RC14-rc2-git5-n_r3964/arch/i386/kernel/timers/timer_pit.c RC14-rc2-git5-i386-irq/arch/i386/kernel/timers/timer_pit.c
--- RC14-rc2-git5-n_r3964/arch/i386/kernel/timers/timer_pit.c	2005-09-05 07:05:13.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/kernel/timers/timer_pit.c	2005-09-25 23:46:56.000000000 -0400
@@ -6,7 +6,6 @@
 #include <linux/spinlock.h>
 #include <linux/module.h>
 #include <linux/device.h>
-#include <linux/irq.h>
 #include <linux/sysdev.h>
 #include <linux/timex.h>
 #include <asm/delay.h>
diff -urN RC14-rc2-git5-n_r3964/arch/i386/kernel/traps.c RC14-rc2-git5-i386-irq/arch/i386/kernel/traps.c
--- RC14-rc2-git5-n_r3964/arch/i386/kernel/traps.c	2005-09-22 01:17:30.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/kernel/traps.c	2005-09-25 23:46:56.000000000 -0400
@@ -52,7 +52,6 @@
 #include <asm/arch_hooks.h>
 #include <asm/kdebug.h>
 
-#include <linux/irq.h>
 #include <linux/module.h>
 
 #include "mach_traps.h"
diff -urN RC14-rc2-git5-n_r3964/arch/i386/mach-default/setup.c RC14-rc2-git5-i386-irq/arch/i386/mach-default/setup.c
--- RC14-rc2-git5-n_r3964/arch/i386/mach-default/setup.c	2005-08-28 23:09:39.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/mach-default/setup.c	2005-09-25 23:46:56.000000000 -0400
@@ -5,7 +5,6 @@
 #include <linux/config.h>
 #include <linux/smp.h>
 #include <linux/init.h>
-#include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <asm/acpi.h>
 #include <asm/arch_hooks.h>
diff -urN RC14-rc2-git5-n_r3964/arch/i386/mach-visws/setup.c RC14-rc2-git5-i386-irq/arch/i386/mach-visws/setup.c
--- RC14-rc2-git5-n_r3964/arch/i386/mach-visws/setup.c	2005-08-28 23:09:39.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/mach-visws/setup.c	2005-09-25 23:46:56.000000000 -0400
@@ -5,7 +5,6 @@
 
 #include <linux/smp.h>
 #include <linux/init.h>
-#include <linux/irq.h>
 #include <linux/interrupt.h>
 
 #include <asm/fixmap.h>
diff -urN RC14-rc2-git5-n_r3964/arch/i386/mach-visws/visws_apic.c RC14-rc2-git5-i386-irq/arch/i386/mach-visws/visws_apic.c
--- RC14-rc2-git5-n_r3964/arch/i386/mach-visws/visws_apic.c	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/mach-visws/visws_apic.c	2005-09-25 23:46:56.000000000 -0400
@@ -19,7 +19,6 @@
 #include <linux/config.h>
 #include <linux/kernel_stat.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 
diff -urN RC14-rc2-git5-n_r3964/arch/i386/mach-voyager/setup.c RC14-rc2-git5-i386-irq/arch/i386/mach-voyager/setup.c
--- RC14-rc2-git5-n_r3964/arch/i386/mach-voyager/setup.c	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/mach-voyager/setup.c	2005-09-25 23:46:56.000000000 -0400
@@ -4,7 +4,6 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
-#include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <asm/acpi.h>
 #include <asm/arch_hooks.h>
diff -urN RC14-rc2-git5-n_r3964/arch/i386/mach-voyager/voyager_basic.c RC14-rc2-git5-i386-irq/arch/i386/mach-voyager/voyager_basic.c
--- RC14-rc2-git5-n_r3964/arch/i386/mach-voyager/voyager_basic.c	2005-09-05 07:05:13.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/mach-voyager/voyager_basic.c	2005-09-25 23:46:56.000000000 -0400
@@ -27,7 +27,6 @@
 #include <asm/voyager.h>
 #include <asm/vic.h>
 #include <linux/pm.h>
-#include <linux/irq.h>
 #include <asm/tlbflush.h>
 #include <asm/arch_hooks.h>
 #include <asm/i8253.h>
diff -urN RC14-rc2-git5-n_r3964/arch/i386/mach-voyager/voyager_smp.c RC14-rc2-git5-i386-irq/arch/i386/mach-voyager/voyager_smp.c
--- RC14-rc2-git5-n_r3964/arch/i386/mach-voyager/voyager_smp.c	2005-09-05 07:05:13.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/mach-voyager/voyager_smp.c	2005-09-25 23:46:56.000000000 -0400
@@ -30,8 +30,6 @@
 #include <asm/tlbflush.h>
 #include <asm/arch_hooks.h>
 
-#include <linux/irq.h>
-
 /* TLB state -- visible externally, indexed physically */
 DEFINE_PER_CPU(struct tlb_state, cpu_tlbstate) ____cacheline_aligned = { &init_mm, 0 };
 
diff -urN RC14-rc2-git5-n_r3964/arch/i386/mach-voyager/voyager_thread.c RC14-rc2-git5-i386-irq/arch/i386/mach-voyager/voyager_thread.c
--- RC14-rc2-git5-n_r3964/arch/i386/mach-voyager/voyager_thread.c	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/mach-voyager/voyager_thread.c	2005-09-25 23:46:56.000000000 -0400
@@ -31,8 +31,6 @@
 #include <asm/mtrr.h>
 #include <asm/msr.h>
 
-#include <linux/irq.h>
-
 #define THREAD_NAME "kvoyagerd"
 
 /* external variables */
diff -urN RC14-rc2-git5-n_r3964/arch/i386/oprofile/nmi_timer_int.c RC14-rc2-git5-i386-irq/arch/i386/oprofile/nmi_timer_int.c
--- RC14-rc2-git5-n_r3964/arch/i386/oprofile/nmi_timer_int.c	2005-09-08 10:07:30.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/oprofile/nmi_timer_int.c	2005-09-25 23:46:56.000000000 -0400
@@ -9,7 +9,7 @@
 
 #include <linux/init.h>
 #include <linux/smp.h>
-#include <linux/irq.h>
+#include <linux/errno.h>
 #include <linux/oprofile.h>
 #include <linux/rcupdate.h>
 
diff -urN RC14-rc2-git5-n_r3964/arch/i386/pci/acpi.c RC14-rc2-git5-i386-irq/arch/i386/pci/acpi.c
--- RC14-rc2-git5-n_r3964/arch/i386/pci/acpi.c	2005-09-13 13:29:27.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/pci/acpi.c	2005-09-25 23:46:56.000000000 -0400
@@ -1,7 +1,6 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/init.h>
-#include <linux/irq.h>
 #include <asm/hw_irq.h>
 #include <asm/numa.h>
 #include "pci.h"
diff -urN RC14-rc2-git5-n_r3964/arch/i386/pci/irq.c RC14-rc2-git5-i386-irq/arch/i386/pci/irq.c
--- RC14-rc2-git5-n_r3964/arch/i386/pci/irq.c	2005-09-10 15:41:34.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/pci/irq.c	2005-09-25 23:46:56.000000000 -0400
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/dmi.h>
 #include <asm/io.h>
 #include <asm/smp.h>
diff -urN RC14-rc2-git5-n_r3964/arch/i386/power/cpu.c RC14-rc2-git5-i386-irq/arch/i386/power/cpu.c
--- RC14-rc2-git5-n_r3964/arch/i386/power/cpu.c	2005-09-05 07:05:13.000000000 -0400
+++ RC14-rc2-git5-i386-irq/arch/i386/power/cpu.c	2005-09-25 23:46:56.000000000 -0400
@@ -8,25 +8,8 @@
  */
 
 #include <linux/config.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/spinlock.h>
-#include <linux/poll.h>
-#include <linux/delay.h>
-#include <linux/sysrq.h>
-#include <linux/proc_fs.h>
-#include <linux/irq.h>
-#include <linux/pm.h>
-#include <linux/device.h>
 #include <linux/suspend.h>
-#include <linux/acpi.h>
-
-#include <asm/uaccess.h>
-#include <asm/acpi.h>
-#include <asm/tlbflush.h>
-#include <asm/processor.h>
 
 static struct saved_context saved_context;
 
