Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbTH2O6F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbTH2O4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:56:38 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:59987 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S261304AbTH2Ovx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:51:53 -0400
Date: Fri, 29 Aug 2003 16:50:59 +0200
Message-Id: <200308291450.h7TEoxBQ005889@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Sonic Ethernet unsafe interrupt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sonic Ethernet: Use the interrupt safe version of dev_kfree_skb{_irq} within
the interrupt handler (from Michael Müller)

--- linux-2.4.23-pre1/drivers/net/sonic.c	Sun Jun  8 10:07:52 2003
+++ linux-m68k-2.4.23-pre1/drivers/net/sonic.c	Mon Jun 30 16:21:50 2003
@@ -223,7 +223,7 @@
 
 			/* We must free the original skb */
 			if (lp->tx_skb[entry]) {
-				dev_kfree_skb(lp->tx_skb[entry]);
+				dev_kfree_skb_irq(lp->tx_skb[entry]);
 				lp->tx_skb[entry] = 0;
 			}
 			/* and the VDMA address */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
