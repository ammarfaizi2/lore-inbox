Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271739AbTHHS3r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 14:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271733AbTHHS3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 14:29:46 -0400
Received: from [66.212.224.118] ([66.212.224.118]:26117 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S271739AbTHHS3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 14:29:45 -0400
Date: Fri, 8 Aug 2003 14:17:58 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6] Setup P4 thermal interrupt vector on UP
Message-ID: <Pine.LNX.4.53.0308081409010.10321@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The P4 thermal interrupt vector was only getting set on SMP builds.

Index: linux-2.5/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/kernel/smpboot.c,v
retrieving revision 1.63
diff -u -p -B -r1.63 smpboot.c
--- linux-2.5/arch/i386/kernel/smpboot.c	19 May 2003 18:45:28 -0000	1.63
+++ linux-2.5/arch/i386/kernel/smpboot.c	8 Aug 2003 15:25:39 -0000
@@ -1178,9 +1178,4 @@ void __init smp_intr_init(void)
 
 	/* IPI for generic function call */
 	set_intr_gate(CALL_FUNCTION_VECTOR, call_function_interrupt);
-
-	/* thermal monitor LVT interrupt */
-#ifdef CONFIG_X86_MCE_P4THERMAL
-	set_intr_gate(THERMAL_APIC_VECTOR, thermal_interrupt);
-#endif
 }
Index: linux-2.5/arch/i386/kernel/apic.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/kernel/apic.c,v
retrieving revision 1.46
diff -u -p -B -r1.46 apic.c
--- linux-2.5/arch/i386/kernel/apic.c	24 Jun 2003 19:50:23 -0000	1.46
+++ linux-2.5/arch/i386/kernel/apic.c	8 Aug 2003 15:25:40 -0000
@@ -52,6 +52,11 @@ void __init apic_intr_init(void)
 	/* IPI vectors for APIC spurious and error interrupts */
 	set_intr_gate(SPURIOUS_APIC_VECTOR, spurious_interrupt);
 	set_intr_gate(ERROR_APIC_VECTOR, error_interrupt);
+
+	/* thermal monitor LVT interrupt */
+#ifdef CONFIG_X86_MCE_P4THERMAL
+	set_intr_gate(THERMAL_APIC_VECTOR, thermal_interrupt);
+#endif
 }
 
 /* Using APIC to generate smp_local_timer_interrupt? */
