Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266037AbUBBUIy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266041AbUBBUHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:07:03 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:11680 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S266068AbUBBUGg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 15:06:36 -0500
Date: Mon, 2 Feb 2004 21:06:33 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 42/42]
Message-ID: <20040202200633.GP6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


yellowfin.c:1282: warning: unsigned int format, different type arg (arg 2)
yellowfin.c:1294: warning: unsigned int format, different type arg (arg 2)

dma_addr_t can be 64 bit long even on x86 (when CONFIG_HIGHMEM64G is
defined). Cast to dma64_addr_t in the printk.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/net/yellowfin.c linux-2.4/drivers/net/yellowfin.c
--- linux-2.4-vanilla/drivers/net/yellowfin.c	Tue Nov 11 17:51:39 2003
+++ linux-2.4/drivers/net/yellowfin.c	Sat Jan 31 19:26:34 2004
@@ -1279,7 +1279,7 @@
 
 #if defined(__i386__)
 	if (yellowfin_debug > 2) {
-		printk("\n"KERN_DEBUG"  Tx ring at %8.8x:\n", yp->tx_ring_dma);
+		printk("\n"KERN_DEBUG"  Tx ring at %8.8Lx:\n", (dma64_addr_r)yp->tx_ring_dma);
 		for (i = 0; i < TX_RING_SIZE*2; i++)
 			printk(" %c #%d desc. %8.8x %8.8x %8.8x %8.8x.\n",
 				   inl(ioaddr + TxPtr) == (long)&yp->tx_ring[i] ? '>' : ' ',
@@ -1291,7 +1291,7 @@
 				   i, yp->tx_status[i].tx_cnt, yp->tx_status[i].tx_errs,
 				   yp->tx_status[i].total_tx_cnt, yp->tx_status[i].paused);
 
-		printk("\n"KERN_DEBUG "  Rx ring %8.8x:\n", yp->rx_ring_dma);
+		printk("\n"KERN_DEBUG "  Rx ring %8.8Lx:\n", (dma64_addr_t)yp->rx_ring_dma);
 		for (i = 0; i < RX_RING_SIZE; i++) {
 			printk(KERN_DEBUG " %c #%d desc. %8.8x %8.8x %8.8x\n",
 				   inl(ioaddr + RxPtr) == (long)&yp->rx_ring[i] ? '>' : ' ',

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"It is more complicated than you think"
                -- The Eighth Networking Truth from RFC 1925
