Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbTEQMr1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 08:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbTEQMr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 08:47:27 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:32401 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261444AbTEQMr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 08:47:26 -0400
Date: Sat, 17 May 2003 15:00:14 +0200 (MEST)
Message-Id: <200305171300.h4HD0Er2008743@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: torvalds@transmeta.com
Subject: [PATCH] fix CONFIG_APM=m in 2.5.69-bk11
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here is a patch to fix CONFIG_APM=m in 2.5.69-bk11.
My patch to have APM restore the systenter MSRs failed to
handle the modular case, which fails with unresolved symbols.

Since suspend.o is used from both APM (module or built-in)
and ACPI sleep (built-in), I made suspend.o built-in and
dependent on CONFIG_PM.

/Mikael

--- linux-2.5.69-bk11/arch/i386/kernel/Makefile.~1~	2003-05-17 13:02:25.000000000 +0200
+++ linux-2.5.69-bk11/arch/i386/kernel/Makefile	2003-05-17 13:42:21.000000000 +0200
@@ -17,7 +17,8 @@
 obj-$(CONFIG_X86_MSR)		+= msr.o
 obj-$(CONFIG_X86_CPUID)		+= cpuid.o
 obj-$(CONFIG_MICROCODE)		+= microcode.o
-obj-$(CONFIG_APM)		+= apm.o suspend.o
+obj-$(CONFIG_PM)		+= suspend.o
+obj-$(CONFIG_APM)		+= apm.o
 obj-$(CONFIG_X86_SMP)		+= smp.o smpboot.o
 obj-$(CONFIG_X86_TRAMPOLINE)	+= trampoline.o
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
--- linux-2.5.69-bk11/arch/i386/kernel/suspend.c.~1~	2003-05-17 13:02:25.000000000 +0200
+++ linux-2.5.69-bk11/arch/i386/kernel/suspend.c	2003-05-17 13:53:29.000000000 +0200
@@ -130,3 +130,6 @@
 	}
 
 }
+
+EXPORT_SYMBOL(save_processor_state);
+EXPORT_SYMBOL(restore_processor_state);
