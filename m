Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268341AbUIBT2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268341AbUIBT2h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 15:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268346AbUIBT2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 15:28:37 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:37320 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268341AbUIBT2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 15:28:33 -0400
Date: Thu, 2 Sep 2004 12:28:20 -0700
From: Chris Wedgwood <cw@f00f.org>
To: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] i386 reduce spurious interrupt noise
Message-ID: <20040902192820.GA6427@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386 hardware can (and does) see spurious interrupts from time to
tome.  Ideally I would like the printk removed completely but this is
probably good enough for now.

Singed-of-By: Chris Wedgwood <cw@f00f.org>

===== arch/i386/kernel/apic.c 1.58 vs edited =====
--- 1.58/arch/i386/kernel/apic.c	2004-08-26 23:30:31 -07:00
+++ edited/arch/i386/kernel/apic.c	2004-09-02 12:19:19 -07:00
@@ -1190,7 +1190,7 @@
 	   6: Received illegal vector
 	   7: Illegal register address
 	*/
-	printk (KERN_INFO "APIC error on CPU%d: %02lx(%02lx)\n",
+	printk (KERN_DEBUG "APIC error on CPU%d: %02lx(%02lx)\n",
 	        smp_processor_id(), v , v1);
 	irq_exit();
 }
===== arch/i386/kernel/i8259.c 1.36 vs edited =====
--- 1.36/arch/i386/kernel/i8259.c	2004-08-23 12:48:32 -07:00
+++ edited/arch/i386/kernel/i8259.c	2004-09-02 12:20:49 -07:00
@@ -226,7 +226,7 @@
 		 * lets ACK and report it. [once per IRQ]
 		 */
 		if (!(spurious_irq_mask & irqmask)) {
-			printk("spurious 8259A interrupt: IRQ%d.\n", irq);
+			printk(KERN_DEBUG "spurious 8259A interrupt: IRQ%d.\n", irq);
 			spurious_irq_mask |= irqmask;
 		}
 		atomic_inc(&irq_err_count);


