Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbUBTMrV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 07:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbUBTMrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:47:21 -0500
Received: from amsfep18-int.chello.nl ([213.46.243.13]:60214 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S261182AbUBTMqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:46:53 -0500
Date: Fri, 20 Feb 2004 13:46:38 +0100
Message-Id: <200402201246.i1KCkcPe004193@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 394] Sun-3 LANCE Ethernet
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sun3lance updates from Sam Creasey:
  - Pass the correct flags to request_irq()
  - Add debug code for transmitting packets

--- linux-2.6.3/drivers/net/sun3lance.c	2003-05-27 19:03:01.000000000 +0200
+++ linux-m68k-2.6.3/drivers/net/sun3lance.c	2004-01-15 13:58:42.000000000 +0100
@@ -321,7 +321,7 @@
 
 	REGA(CSR0) = CSR0_STOP; 
 
-	request_irq(LANCE_IRQ, lance_interrupt, 0, "SUN3 Lance", dev);
+	request_irq(LANCE_IRQ, lance_interrupt, SA_INTERRUPT, "SUN3 Lance", dev);
 	dev->irq = (unsigned short)LANCE_IRQ;
 
 
@@ -484,6 +484,9 @@
 	struct lance_tx_head *head;
 	unsigned long flags;
 
+	DPRINTK( 1, ( "%s: transmit start.\n",
+		      dev->name));
+
 	/* Transmitter timeout, serious problems. */
 	if (netif_queue_stopped(dev)) {
 		int tickssofar = jiffies - dev->trans_start;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
