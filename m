Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267268AbSLEKrN>; Thu, 5 Dec 2002 05:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267279AbSLEKqH>; Thu, 5 Dec 2002 05:46:07 -0500
Received: from holomorphy.com ([66.224.33.161]:42633 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267270AbSLEKqD>;
	Thu, 5 Dec 2002 05:46:03 -0500
Date: Thu, 05 Dec 2002 02:52:59 -0800
From: wli@holomorphy.com
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net,
       rmk@arm.linux.org.uk, jgarzik@pobox.com, miura@da-cha.org,
       alan@lxorguk.ukuu.org.uk, viro@math.psu.edu, pavel@ucw.cz
Subject: [warnings] [5/8] fix printk() type warning in drivers/net/starfire.c
Message-ID: <0212050252.Pd6dQaLdjd~bKaCc5bYa1cXb9dBdsb0a20143@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0212050252.IbRbEbGcFabaXbkavbedza0aAb2aGaxd20143@holomorphy.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change the format to %Lx and cast to u64 unconditionally.
Jeff, this is yours to ack.

===== drivers/net/starfire.c 1.22 vs edited =====
--- 1.22/drivers/net/starfire.c	Wed Nov 27 23:09:51 2002
+++ edited/drivers/net/starfire.c	Thu Dec  5 01:15:06 2002
@@ -1847,15 +1847,15 @@
 
 #ifdef __i386__
 	if (debug > 2) {
-		printk("\n"KERN_DEBUG"  Tx ring at %8.8x:\n",
-			   np->tx_ring_dma);
+		printk("\n"KERN_DEBUG"  Tx ring at %8.8Lx:\n",
+			   (u64)np->tx_ring_dma);
 		for (i = 0; i < 8 /* TX_RING_SIZE is huge! */; i++)
 			printk(KERN_DEBUG " #%d desc. %8.8x %8.8x -> %8.8x.\n",
 			       i, le32_to_cpu(np->tx_ring[i].status),
 			       le32_to_cpu(np->tx_ring[i].first_addr),
 			       le32_to_cpu(np->tx_done_q[i].status));
-		printk(KERN_DEBUG "  Rx ring at %8.8x -> %p:\n",
-		       np->rx_ring_dma, np->rx_done_q);
+		printk(KERN_DEBUG "  Rx ring at %8.8Lx -> %p:\n",
+		       (u64)np->rx_ring_dma, np->rx_done_q);
 		if (np->rx_done_q)
 			for (i = 0; i < 8 /* RX_RING_SIZE */; i++) {
 				printk(KERN_DEBUG " #%d desc. %8.8x -> %8.8x\n",
