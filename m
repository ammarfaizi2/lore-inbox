Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbTELJzp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 05:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbTELJrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 05:47:11 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:38463 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S262037AbTELJpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 05:45:09 -0400
Date: Mon, 12 May 2003 11:54:41 +0200
Message-Id: <200305120954.h4C9sf2I001021@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IRQ API updates [12/20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k Sun-3x: Update to the new irq API (from Roman Zippel and me) [12/20]

--- linux-2.5.69/arch/m68k/sun3x/time.c	Thu Jan  2 12:53:58 2003
+++ linux-m68k-2.5.69/arch/m68k/sun3x/time.c	Tue May  6 13:50:50 2003
@@ -90,7 +90,7 @@
 }
 #endif
 
-void __init sun3x_sched_init(void (*vector)(int, void *, struct pt_regs *))
+void __init sun3x_sched_init(irqreturn_t (*vector)(int, void *, struct pt_regs *))
 {
 	
 	sun3_disable_interrupts();
--- linux-2.5.69/arch/m68k/sun3x/time.h	Mon May 13 10:55:12 2002
+++ linux-m68k-2.5.69/arch/m68k/sun3x/time.h	Tue May  6 13:50:50 2003
@@ -3,7 +3,7 @@
 
 extern int sun3x_hwclk(int set, struct rtc_time *t);
 unsigned long sun3x_gettimeoffset (void);
-void sun3x_sched_init(void (*vector)(int, void *, struct pt_regs *));
+void sun3x_sched_init(irqreturn_t (*vector)(int, void *, struct pt_regs *));
 
 struct mostek_dt {
 	volatile unsigned char csr;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
