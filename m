Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTELJzn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 05:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbTELJr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 05:47:58 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:26393 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262039AbTELJpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 05:45:12 -0400
Date: Mon, 12 May 2003 11:54:44 +0200
Message-Id: <200305120954.h4C9si9H001057@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IRQ API updates [18/20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k parport drivers: Update to the new irq API (from Roman Zippel and me) [18/20]

--- linux-2.5.69/drivers/parport/parport_amiga.c	Tue Mar 25 10:06:46 2003
+++ linux-m68k-2.5.69/drivers/parport/parport_amiga.c	Tue May  6 13:50:50 2003
@@ -138,9 +138,10 @@
 }
 
 /* as this ports irq handling is already done, we use a generic funktion */
-static void amiga_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t amiga_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	parport_generic_irq(irq, (struct parport *) dev_id, regs);
+	return IRQ_HANDLED;
 }
 
 static void amiga_enable_irq(struct parport *p)
--- linux-2.5.69/drivers/parport/parport_atari.c	Tue Mar 25 10:06:46 2003
+++ linux-m68k-2.5.69/drivers/parport/parport_atari.c	Fri May  9 10:21:33 2003
@@ -103,10 +103,11 @@
 {
 }
 
-static void
+static irqreturn_t
 parport_atari_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	parport_generic_irq(irq, (struct parport *) dev_id, regs);
+	return IRQ_HANDLED;
 }
 
 static void
--- linux-2.5.69/drivers/parport/parport_mfc3.c	Tue Mar 25 10:06:47 2003
+++ linux-m68k-2.5.69/drivers/parport/parport_mfc3.c	Tue May  6 13:50:50 2003
@@ -211,7 +211,7 @@
 
 static int use_cnt = 0;
 
-static void mfc3_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t mfc3_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	int i;
 
@@ -221,6 +221,7 @@
 				dummy = pia(this_port[i])->pprb; /* clear irq bit */
 				parport_generic_irq(irq, this_port[i], regs);
 			}
+	return IRQ_HANDLED;
 }
 
 static void mfc3_enable_irq(struct parport *p)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
