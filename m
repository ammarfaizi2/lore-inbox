Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbTAEFAG>; Sun, 5 Jan 2003 00:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbTAEFAG>; Sun, 5 Jan 2003 00:00:06 -0500
Received: from franka.aracnet.com ([216.99.193.44]:18095 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262821AbTAEFAE>; Sun, 5 Jan 2003 00:00:04 -0500
Date: Sat, 04 Jan 2003 21:08:33 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jeff Garzik <garzik@pobox.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix starfire compiler warning on PAE
Message-ID: <99960000.1041743313@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN -X /home/fletch/.diff.exclude 
12-boot_error/drivers/net/starfire.c 
19-fix_starfire_warning/drivers/net/starfire.c
--- 12-boot_error/drivers/net/starfire.c	Fri Dec 13 23:17:59 2002
+++ 19-fix_starfire_warning/drivers/net/starfire.c	Thu Jan  2 22:18:18 2003
@@ -1847,15 +1847,15 @@ static int netdev_close(struct net_devic

 #ifdef __i386__
 	if (debug > 2) {
-		printk("\n"KERN_DEBUG"  Tx ring at %8.8x:\n",
-			   np->tx_ring_dma);
+		printk("\n"KERN_DEBUG"  Tx ring at %9.9Lx:\n",
+			   (u64) np->tx_ring_dma);
 		for (i = 0; i < 8 /* TX_RING_SIZE is huge! */; i++)
 			printk(KERN_DEBUG " #%d desc. %8.8x %8.8x -> %8.8x.\n",
 			       i, le32_to_cpu(np->tx_ring[i].status),
 			       le32_to_cpu(np->tx_ring[i].first_addr),
 			       le32_to_cpu(np->tx_done_q[i].status));
-		printk(KERN_DEBUG "  Rx ring at %8.8x -> %p:\n",
-		       np->rx_ring_dma, np->rx_done_q);
+		printk(KERN_DEBUG "  Rx ring at %9.9Lx -> %p:\n",
+		       (u64) np->rx_ring_dma, np->rx_done_q);
 		if (np->rx_done_q)
 			for (i = 0; i < 8 /* RX_RING_SIZE */; i++) {
 				printk(KERN_DEBUG " #%d desc. %8.8x -> %8.8x\n",

