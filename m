Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424278AbWKIXow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424278AbWKIXow (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 18:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424250AbWKIXoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 18:44:38 -0500
Received: from www.osadl.org ([213.239.205.134]:55452 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161864AbWKIXjG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 18:39:06 -0500
Message-Id: <20061109233034.641665000@cruncher.tec.linutronix.de>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
Date: Thu, 09 Nov 2006 23:38:22 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Len Brown <lenb@kernel.org>, John Stultz <johnstul@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 05/19] ACPI: Include apic.h
Content-Disposition: inline; filename=acpi-include-apic-h.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

apic.h does not get included on UP compiles.
That way the APICTIMER_STOPS_ON_C3 is not there and UP boxen have no support
for timer broadcasting. This was never noticed, because the lapic timer is 
only used for profiling on UP.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux-2.6.19-rc5-mm1/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/drivers/acpi/processor_idle.c	2006-11-09 17:47:58.000000000 +0100
+++ linux-2.6.19-rc5-mm1/drivers/acpi/processor_idle.c	2006-11-09 20:20:06.000000000 +0100
@@ -40,6 +40,16 @@
 #include <linux/sched.h>	/* need_resched() */
 #include <linux/latency.h>
 
+/*
+ * Include the apic definitions for x86 to have the APIC timer related defines
+ * available also for UP (on SMP it gets magically included via linux/smp.h).
+ * asm/acpi.h is not an option, as it would require more include magic. Also
+ * creating an empty asm-ia64/apic.h would just trade pest vs. cholera.
+ */
+#ifdef CONFIG_X86
+#include <asm/apic.h>
+#endif
+
 #include <asm/io.h>
 #include <asm/uaccess.h>
 

--

