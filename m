Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264649AbSKIF2F>; Sat, 9 Nov 2002 00:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264650AbSKIF2F>; Sat, 9 Nov 2002 00:28:05 -0500
Received: from modemcable191.130-200-24.mtl.mc.videotron.ca ([24.200.130.191]:1807
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264649AbSKIF2E>; Sat, 9 Nov 2002 00:28:04 -0500
Date: Sat, 9 Nov 2002 00:34:08 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Robert Love <rml@tech9.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] do_nmi needs irq_enter/irq_exit lovin...
Message-ID: <Pine.LNX.4.44.0211082345101.10475-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You don't even want to see the oops ;) But there is some more work 
required before this will all work. I'll require your comments on a few 
more incoming patches.

Index: linux-2.5.46-bochs/arch/i386/kernel/traps.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.46/arch/i386/kernel/traps.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 traps.c
--- linux-2.5.46-bochs/arch/i386/kernel/traps.c	5 Nov 2002 01:47:29 -0000	1.1.1.1
+++ linux-2.5.46-bochs/arch/i386/kernel/traps.c	9 Nov 2002 04:45:07 -0000
@@ -528,10 +528,14 @@
 {
 	int cpu = smp_processor_id();
 
+	irq_enter();
+
 	++nmi_count(cpu);
 
 	if (!nmi_callback(regs, cpu))
 		default_do_nmi(regs);
+
+	irq_exit();
 }
 
 void set_nmi_callback(nmi_callback_t callback)

-- 
function.linuxpower.ca


