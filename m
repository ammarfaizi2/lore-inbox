Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTINJcL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 05:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbTINJcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 05:32:11 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:2577 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id S262196AbTINJcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 05:32:08 -0400
Date: Sun, 14 Sep 2003 04:32:01 -0500 (CDT)
Message-Id: <200309140932.h8E9W1An062395@sullivan.realtime.net>
Subject: Re: [linux-2.4.0-test5] swsusp w/o swap fail...
To: Andi Kleen <ak@suse.de>
From: Milton Miller <miltonm@bga.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030913072327.GA23992@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Sep 13 2003 - 02:24:36 EST, Andi Kleen wrote:
> On Fri, Sep 12, 2003 at 10:49:29PM -0500, Milton Miller wrote:
> > ... Rather than say ACPI_SLEEP also enables SWAP, how about having
> > X86_64 pick up a change made to x86, and compile suspend.c on CONFIG_PM.
> >
> > Andi, can you test this?
> 
> That won't work. suspend won't compile without suspend_asm
> 

Care to expand?   suspend_asm.S calls into suspend.c, but I don't
see the converse.   I checked i386 and it compiles, and don't see
how x86_64 will break.

===== drivers/acpi/Kconfig 1.20 vs edited =====
--- 1.20/drivers/acpi/Kconfig	Sat Aug 23 06:07:34 2003
+++ edited/drivers/acpi/Kconfig	Fri Sep 12 22:28:08 2003
@@ -69,7 +69,6 @@
 	bool "Sleep States (EXPERIMENTAL)"
 	depends on X86 && ACPI
 	depends on EXPERIMENTAL && PM
-	select SOFTWARE_SUSPEND
 	default y
 	---help---
 	  This option adds support for ACPI suspend states. 
===== arch/x86_64/kernel/Makefile 1.23 vs edited =====
--- 1.23/arch/x86_64/kernel/Makefile	Mon Aug 18 13:16:59 2003
+++ edited/arch/x86_64/kernel/Makefile	Fri Sep 12 22:28:56 2003
@@ -16,7 +16,8 @@
 obj-$(CONFIG_SMP)	+= smp.o smpboot.o trampoline.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o  nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o mpparse.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o suspend_asm.o
+obj-$(CONFIG_PM)	+= suspend.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend_asm.o
 obj-$(CONFIG_EARLY_PRINTK)    += early_printk.o
 obj-$(CONFIG_GART_IOMMU) += pci-gart.o aperture.o
 obj-$(CONFIG_DUMMY_IOMMU) += pci-nommu.o pci-dma.o

