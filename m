Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUBBUIx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266058AbUBBUH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:07:29 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:26760 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S266055AbUBBUFN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 15:05:13 -0500
X-BrightmailFiltered: true
Date: Mon, 2 Feb 2004 21:05:10 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 40/42]
Message-ID: <20040202200510.GN6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sundance.c:1678: warning: unsigned int format, different type arg (arg 3)
sundance.c:994: warning: unsigned int format, different type arg (arg 3)

dma_addr_t can be 64 bit long even on x86 (when CONFIG_HIGHMEM64G is
defined). Cast to dma64_addr_t in the printk.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/net/sundance.c linux-2.4/drivers/net/sundance.c
--- linux-2.4-vanilla/drivers/net/sundance.c	Tue Nov 11 17:51:13 2003
+++ linux-2.4/drivers/net/sundance.c	Sat Jan 31 19:13:53 2004
@@ -985,8 +985,8 @@
 	{
 		int i;
 		for (i=0; i<TX_RING_SIZE; i++) {
-			printk(KERN_DEBUG "%02x %08x %08x %08x(%02x) %08x %08x\n", i,
-				np->tx_ring_dma + i*sizeof(*np->tx_ring),	
+			printk(KERN_DEBUG "%02x %08Lx %08x %08x(%02x) %08x %08x\n", i,
+				(dma64_addr_t)np->tx_ring_dma + i*sizeof(*np->tx_ring),	
 				le32_to_cpu(np->tx_ring[i].next_desc),
 				le32_to_cpu(np->tx_ring[i].status),
 				(le32_to_cpu(np->tx_ring[i].status) >> 2) & 0xff,
@@ -1668,8 +1668,8 @@
 	switch (cmd) {
 		case SIOCDEVPRIVATE:
 		for (i=0; i<TX_RING_SIZE; i++) {
-			printk(KERN_DEBUG "%02x %08x %08x %08x(%02x) %08x %08x\n", i,
-				np->tx_ring_dma + i*sizeof(*np->tx_ring),	
+			printk(KERN_DEBUG "%02x %08Lx %08x %08x(%02x) %08x %08x\n", i,
+				(dma64_addr_t)np->tx_ring_dma + i*sizeof(*np->tx_ring),	
 				le32_to_cpu(np->tx_ring[i].next_desc),
 				le32_to_cpu(np->tx_ring[i].status),
 				(le32_to_cpu(np->tx_ring[i].status) >> 2) 

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
K.R.O.N.O.S
Kinetic Replicant Optimized for Nocturnal Observation and Sabotage
