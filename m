Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbTDGF5H (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 01:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbTDGF5H (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 01:57:07 -0400
Received: from modemcable169.130-200-24.mtl.mc.videotron.ca ([24.200.130.169]:1568
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263268AbTDGF5G (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 01:57:06 -0400
Date: Mon, 7 Apr 2003 02:04:05 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] Disable irqbalance for single cpu SMP configurations
Message-ID: <Pine.LNX.4.50.0304062214290.2268-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch disables irqbalance and doesn't spawn a kernel thread for 
systems which run SMP kernels and only have one online cpu.

Index: linux-2.5.66/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.66/arch/i386/kernel/io_apic.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 io_apic.c
--- linux-2.5.66/arch/i386/kernel/io_apic.c	24 Mar 2003 23:40:27 -0000	1.1.1.1
+++ linux-2.5.66/arch/i386/kernel/io_apic.c	7 Apr 2003 05:19:26 -0000
@@ -603,6 +603,12 @@ static int __init balanced_irq_init(void
         c = &boot_cpu_data;
 	if (irqbalance_disabled)
 		return 0;
+	
+	 /* disable irqbalance completely if there is only one processor online */
+	if (num_online_cpus() < 2) {
+		irqbalance_disabled = 1;
+		return 0;
+	}
 	/*
 	 * Enable physical balance only if more than 1 physical processor
 	 * is present

-- 
function.linuxpower.ca
