Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTH2OzM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbTH2Owq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:52:46 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:26178 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S261306AbTH2OwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:52:00 -0400
Date: Fri, 29 Aug 2003 16:51:07 +0200
Message-Id: <200308291451.h7TEp7BC005902@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k invalid vs. illegal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Use `invalid' instead of `illegal' (from Steven Cole in 2.5.x)

--- linux-2.4.23-pre1/arch/m68k/apollo/dn_ints.c	Tue Jun  4 15:23:04 2002
+++ linux-m68k-2.4.23-pre1/arch/m68k/apollo/dn_ints.c	Mon Jul 21 20:39:55 2003
@@ -43,7 +43,7 @@
 int dn_request_irq(unsigned int irq, void (*handler)(int, void *, struct pt_regs *), unsigned long flags, const char *devname, void *dev_id) {
 
   if((irq<0) || (irq>15)) {
-    printk("Trying to request illegal IRQ\n");
+    printk("Trying to request invalid IRQ\n");
     return -ENXIO;
   }
 
@@ -69,7 +69,7 @@
 void dn_free_irq(unsigned int irq, void *dev_id) {
 
   if((irq<0) || (irq>15)) {
-    printk("Trying to free illegal IRQ\n");
+    printk("Trying to free invalid IRQ\n");
     return ;
   }
 
--- linux-2.4.23-pre1/arch/m68k/q40/q40ints.c	Thu Mar 13 07:43:37 2003
+++ linux-m68k-2.4.23-pre1/arch/m68k/q40/q40ints.c	Mon Jul 21 20:39:55 2003
@@ -168,7 +168,7 @@
 	  {
 	  case 1: case 2: case 8: case 9:
 	  case 12: case 13:
-	    printk("%s: ISA IRQ %d from %x illegal\n", __FUNCTION__, irq, (unsigned)dev_id);
+	    printk("%s: ISA IRQ %d from %x invalid\n", __FUNCTION__, irq, (unsigned)dev_id);
 	    return;
 	  case 11: irq=10;
 	  default:

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
