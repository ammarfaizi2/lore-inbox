Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbTI1NCu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 09:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262553AbTI1NCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 09:02:50 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:53014 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S262551AbTI1NCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 09:02:48 -0400
Date: Sun, 28 Sep 2003 14:55:20 +0200
Message-Id: <200309281255.h8SCtKXU005492@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 302] Q40/Q60 interrupts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Q40/Q60: Fix warnings, add diagnostic message (from Richard Zidlicky)

--- linux-2.6.0-test6/arch/m68k/q40/q40ints.c	Thu Sep  4 13:47:37 2003
+++ linux-m68k-2.6.0-test6/arch/m68k/q40/q40ints.c	Tue Sep  9 14:55:32 2003
@@ -200,7 +200,9 @@
 
 irqreturn_t q40_process_int (int level, struct pt_regs *fp)
 {
-  printk("unexpected interrupt %x\n",level);
+  printk("unexpected interrupt vec=%x, pc=%lx, d0=%lx, d0_orig=%lx, d1=%lx, d2=%lx\n",
+          level, fp->pc, fp->d0, fp->orig_d0, fp->d1, fp->d2);
+  printk("\tIIRQ_REG = %x, EIRQ_REG = %x\n",master_inb(IIRQ_REG),master_inb(EIRQ_REG));
   return IRQ_HANDLED;
 }
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
