Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbTJGTPY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 15:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262748AbTJGTPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 15:15:23 -0400
Received: from gprs149-208.eurotel.cz ([160.218.149.208]:10883 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262736AbTJGTPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 15:15:13 -0400
Date: Tue, 7 Oct 2003 21:14:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: lm@bitmover.com
Subject: bkcvs problems?
Message-ID: <20031007191433.GA683@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

According to bkbits, andi's cpufreq changes are in:

http://linus.bkbits.net:8080/linux-2.5/patch@1.1480?nav=index.html|ChangeSet@-1d|cset@1.1480
....
diff -Nru a/arch/x86_64/kernel/Makefile b/arch/x86_64/kernel/Makefile
--- a/arch/x86_64/kernel/Makefile	Fri Sep 26 06:53:37 2003
+++ b/arch/x86_64/kernel/Makefile	Sun Oct  5 13:31:26 2003
@@ -26,3 +26,5 @@
 
 bootflag-y			+= ../../i386/kernel/bootflag.o
 cpuid-$(CONFIG_X86_CPUID)	+= ../../i386/kernel/cpuid.o
+
+obj-$(CONFIG_CPU_FREQ)	+=	cpufreq/
....

but bkcvs thinks otherwise:

head	1.26;
access;
symbols;
locks; strict;
comment	@# @;
expand	@o@;


1.26
date	2003.09.26.15.56.18;	author ak;	state Exp;
branches;
next	1.25;
...
1.26
log
@Another small x86-64 merge

(Logical change 1.13489)
@
text
@#
# Makefile for the linux kernel.
#

extra-y 	:= head.o head64.o init_task.o vmlinux.lds.s
EXTRA_AFLAGS	:= -traditional
obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_x86_64.o \
		x8664_ksyms.o i387.o syscall.o vsyscall.o \
		setup64.o bluesmoke.o bootflag.o e820.o reboot.o warmreboot.o

obj-$(CONFIG_MTRR)		+= ../../i386/kernel/cpu/mtrr/
obj-$(CONFIG_ACPI)		+= acpi/
obj-$(CONFIG_X86_MSR)		+= msr.o
obj-$(CONFIG_X86_CPUID)		+= cpuid.o
obj-$(CONFIG_SMP)		+= smp.o smpboot.o trampoline.o
obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o  nmi.o
obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o mpparse.o
obj-$(CONFIG_PM)		+= suspend.o
obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend_asm.o
obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
obj-$(CONFIG_GART_IOMMU)	+= pci-gart.o aperture.o
obj-$(CONFIG_DUMMY_IOMMU)	+= pci-nommu.o pci-dma.o

obj-$(CONFIG_MODULES)		+= module.o

bootflag-y			+= ../../i386/kernel/bootflag.o
cpuid-$(CONFIG_X86_CPUID)	+= ../../i386/kernel/cpuid.o
@
....

(Of course, I initally tried with simple cvs update, then I killed
whole tree and did cvs update, but that did not help. I did bk sync
five minutes ago, just to be sure, but it did not help).

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
