Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbTIMDtk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 23:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbTIMDtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 23:49:40 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:37384 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id S261811AbTIMDti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 23:49:38 -0400
Date: Fri, 12 Sep 2003 22:49:29 -0500 (CDT)
Message-Id: <200309130349.h8D3nTvG035109@sullivan.realtime.net>
Subject: Re: [linux-2.4.0-test5] swsusp w/o swap fail...
To: Patrick Mochel <mochel@osdl.org>, Andi Kleen <ak@suse.de>,
       Daniel Blueman <daniel.blueman@gmx.net>
From: Milton Miller <miltonm@bga.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0309121509120.984-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To fix bugzilla 1131, Andi added select SOFTWARE_SUSPEND when ACPI_SLEEP
is selected.  However, as discussed elsewhere [1], select superceedes
depends.  Rather than say ACPI_SLEEP also enables SWAP, how about having
X86_64 pick up a change made to x86, and compile suspend.c on CONFIG_PM.

Andi, can you test this?


milton


[1] Re: [patch] 2.6.0-test5: serio config broken? 
http://www.ussg.iu.edu/hypermail/linux/kernel/0309.1/1572.html


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
