Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbTFOTC3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 15:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTFOTA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 15:00:27 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:40794 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262710AbTFOS7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:59:54 -0400
Date: Sun, 15 Jun 2003 21:10:33 +0200
Message-Id: <200306151910.h5FJAX9j008616@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Mac/m68k sonic updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mac/m68k sonic: Kill warning and remainings of 2.2-style flow control

--- linux-2.4.x/drivers/net/macsonic.c	Mon Aug  5 12:48:53 2002
+++ linux-m68k-2.4.x/drivers/net/macsonic.c	Fri Jun  6 12:22:46 2003
@@ -142,7 +142,7 @@
 
 int __init macsonic_init(struct net_device* dev)
 {
-	struct sonic_local* lp;
+	struct sonic_local* lp = NULL;
 	int i;
 
 	/* Allocate the entire chunk of memory for the descriptors.
--- linux-2.4.x/drivers/net/sonic.c	Fri Mar  1 11:05:29 2002
+++ linux-m68k-2.4.x/drivers/net/sonic.c	Mon Sep 16 14:41:46 2002
@@ -113,15 +113,6 @@
 	if (sonic_debug > 2)
 		printk("sonic_send_packet: skb=%p, dev=%p\n", skb, dev);
 
-	/* 
-	 * Block a timer-based transmit from overlapping.  This could better be
-	 * done with atomic_swap(1, dev->tbusy), but set_bit() works as well.
-	 */
-	if (test_and_set_bit(0, (void *) &dev->tbusy) != 0) {
-		printk("%s: Transmitter access conflict.\n", dev->name);
-		return 1;
-	}
-
 	/*
 	 * Map the packet data into the logical DMA address space
 	 */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
