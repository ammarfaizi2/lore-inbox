Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUDRRyc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 13:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUDRRyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 13:54:32 -0400
Received: from witte.sonytel.be ([80.88.33.193]:4343 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262605AbUDRRyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 13:54:00 -0400
Date: Sun, 18 Apr 2004 19:53:20 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH 437] Amiga eth%d
In-Reply-To: <407C164F.1090501@pobox.com>
Message-ID: <Pine.GSO.4.58.0404181952540.17347@waterleaf.sonytel.be>
References: <200404130838.i3D8cI26018497@callisto.of.borg> <407C164F.1090501@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2004, Jeff Garzik wrote:
> As a further change, can you please add KERN_xxx prefixes to those printk's?

To: akpm, linus, jeff
Cc: lkml
Subject: [PATCH] Amiga Ariadne Ethernet KERN_*

Amiga Ariadne Ethernet: Add KERN_* prefixes to printk() messages

--- linux-2.6.6-rc1/drivers/net/ariadne.c	2004-04-15 11:44:13.000000000 +0200
+++ linux-m68k-2.6.6-rc1/drivers/net/ariadne.c	2004-04-16 13:38:01.000000000 +0200
@@ -216,7 +216,7 @@
     }
     zorro_set_drvdata(z, dev);

-    printk("%s: Ariadne at 0x%08lx, Ethernet Address "
+    printk(KERN_INFO "%s: Ariadne at 0x%08lx, Ethernet Address "
 	   "%02x:%02x:%02x:%02x:%02x:%02x\n", dev->name, board,
 	   dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
 	   dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
@@ -245,16 +245,16 @@
     lance->RAP = CSR89;		/* Chip ID */
     version |= swapw(lance->RDP)<<16;
     if ((version & 0x00000fff) != 0x00000003) {
-	printk("ariadne_open: Couldn't find AMD Ethernet Chip\n");
+	printk(KERN_WARNING "ariadne_open: Couldn't find AMD Ethernet Chip\n");
 	return -EAGAIN;
     }
     if ((version & 0x0ffff000) != 0x00003000) {
-	printk("ariadne_open: Couldn't find Am79C960 (Wrong part number = %ld)\n",
-	       (version & 0x0ffff000)>>12);
+	printk(KERN_WARNING "ariadne_open: Couldn't find Am79C960 (Wrong part "
+	       "number = %ld)\n", (version & 0x0ffff000)>>12);
 	return -EAGAIN;
     }
 #if 0
-    printk("ariadne_open: Am79C960 (PCnet-ISA) Revision %ld\n",
+    printk(KERN_DEBUG "ariadne_open: Am79C960 (PCnet-ISA) Revision %ld\n",
 	   (version & 0xf0000000)>>28);
 #endif

@@ -354,8 +354,8 @@
 	priv->tx_ring[i] = &lancedata->tx_ring[i];
 	priv->tx_buff[i] = lancedata->tx_buff[i];
 #if 0
-	printk("TX Entry %2d at %p, Buf at %p\n", i, &lancedata->tx_ring[i],
-	       lancedata->tx_buff[i]);
+	printk(KERN_DEBUG "TX Entry %2d at %p, Buf at %p\n", i,
+	       &lancedata->tx_ring[i], lancedata->tx_buff[i]);
 #endif
     }

@@ -370,8 +370,8 @@
 	priv->rx_ring[i] = &lancedata->rx_ring[i];
 	priv->rx_buff[i] = lancedata->rx_buff[i];
 #if 0
-	printk("RX Entry %2d at %p, Buf at %p\n", i, &lancedata->rx_ring[i],
-	       lancedata->rx_buff[i]);
+	printk(KERN_DEBUG "RX Entry %2d at %p, Buf at %p\n", i,
+	       &lancedata->rx_ring[i], lancedata->rx_buff[i]);
 #endif
     }
 }
@@ -389,9 +389,9 @@
     lance->RAP = CSR0;		/* PCnet-ISA Controller Status */

     if (ariadne_debug > 1) {
-	printk("%s: Shutting down ethercard, status was %2.2x.\n", dev->name,
-	       lance->RDP);
-	printk("%s: %lu packets missed\n", dev->name,
+	printk(KERN_DEBUG "%s: Shutting down ethercard, status was %2.2x.\n",
+	       dev->name, lance->RDP);
+	printk(KERN_DEBUG "%s: %lu packets missed\n", dev->name,
 	       priv->stats.rx_missed_errors);
     }

@@ -425,7 +425,7 @@
     int handled = 0;

     if (dev == NULL) {
-	printk("ariadne_interrupt(): irq for unknown device.\n");
+	printk(KERN_WARNING "ariadne_interrupt(): irq for unknown device.\n");
 	return IRQ_NONE;
     }

@@ -443,8 +443,8 @@

 #if 0
 	if (ariadne_debug > 5) {
-	    printk("%s: interrupt  csr0=%#2.2x new csr=%#2.2x.", dev->name,
-		   csr0, lance->RDP);
+	    printk(KERN_DEBUG "%s: interrupt  csr0=%#2.2x new csr=%#2.2x.",
+		   dev->name, csr0, lance->RDP);
 	    printk("[");
 	    if (csr0 & INTR)
 		printk(" INTR");
@@ -514,8 +514,8 @@
 			/* Ackk!  On FIFO errors the Tx unit is turned off! */
 			priv->stats.tx_fifo_errors++;
 			/* Remove this verbosity later! */
-			printk("%s: Tx FIFO error! Status %4.4x.\n", dev->name,
-			       csr0);
+			printk(KERN_ERR "%s: Tx FIFO error! Status %4.4x.\n",
+			       dev->name, csr0);
 			/* Restart the chip. */
 			lance->RDP = STRT;
 		    }
@@ -529,8 +529,8 @@

 #ifndef final_version
 	    if (priv->cur_tx - dirty_tx >= TX_RING_SIZE) {
-		printk("out-of-sync dirty pointer, %d vs. %d, full=%d.\n",
-		       dirty_tx, priv->cur_tx, priv->tx_full);
+		printk(KERN_ERR "out-of-sync dirty pointer, %d vs. %d, "
+		       "full=%d.\n", dirty_tx, priv->cur_tx, priv->tx_full);
 		dirty_tx += TX_RING_SIZE;
 	    }
 #endif
@@ -556,8 +556,8 @@
 	}
 	if (csr0 & MERR) {
 	    handled = 1;
-	    printk("%s: Bus master arbitration failure, status %4.4x.\n",
-		   dev->name, csr0);
+	    printk(KERN_ERR "%s: Bus master arbitration failure, status "
+		   "%4.4x.\n", dev->name, csr0);
 	    /* Restart the chip. */
 	    lance->RDP = STRT;
 	}
@@ -569,8 +569,8 @@

 #if 0
     if (ariadne_debug > 4)
-	printk("%s: exiting interrupt, csr%d=%#4.4x.\n", dev->name, lance->RAP,
-	       lance->RDP);
+	printk(KERN_DEBUG "%s: exiting interrupt, csr%d=%#4.4x.\n", dev->name,
+	       lance->RAP, lance->RDP);
 #endif
     return IRQ_RETVAL(handled);
 }
@@ -598,8 +598,8 @@
 #if 0
     if (ariadne_debug > 3) {
 	lance->RAP = CSR0;	/* PCnet-ISA Controller Status */
-	printk("%s: ariadne_start_xmit() called, csr0 %4.4x.\n", dev->name,
-	       lance->RDP);
+	printk(KERN_DEBUG "%s: ariadne_start_xmit() called, csr0 %4.4x.\n",
+	       dev->name, lance->RDP);
 	lance->RDP = 0x0000;
     }
 #endif
@@ -616,7 +616,7 @@
     /* Fill in a Tx ring entry */

 #if 0
-    printk("TX pkt type 0x%04x from ", ((u_short *)skb->data)[6]);
+    printk(KERN_DEBUG "TX pkt type 0x%04x from ", ((u_short *)skb->data)[6]);
     {
 	int i;
 	u_char *ptr = &((u_char *)skb->data)[6];
@@ -652,7 +652,7 @@
 	len >>= 1;
 	for (i = 0; i < len; i += 8) {
 	    int j;
-	    printk("%04x:", i);
+	    printk(KERN_DEBUG "%04x:", i);
 	    for (j = 0; (j < 8) && ((i+j) < len); j++) {
 		if (!(j & 1))
 		    printk(" ");
@@ -671,8 +671,8 @@
     if ((priv->cur_tx >= TX_RING_SIZE) && (priv->dirty_tx >= TX_RING_SIZE)) {

 #if 0
-	printk("*** Subtracting TX_RING_SIZE from cur_tx (%d) and dirty_tx (%d)\n",
-	       priv->cur_tx, priv->dirty_tx);
+	printk(KERN_DEBUG "*** Subtracting TX_RING_SIZE from cur_tx (%d) and "
+	       "dirty_tx (%d)\n", priv->cur_tx, priv->dirty_tx);
 #endif

 	priv->cur_tx -= TX_RING_SIZE;
@@ -729,7 +729,8 @@

 	    skb = dev_alloc_skb(pkt_len+2);
 	    if (skb == NULL) {
-		printk("%s: Memory squeeze, deferring packet.\n", dev->name);
+		printk(KERN_WARNING "%s: Memory squeeze, deferring packet.\n",
+		       dev->name);
 		for (i = 0; i < RX_RING_SIZE; i++)
 		    if (lowb(priv->rx_ring[(entry+i) % RX_RING_SIZE]->RMD1) & RF_OWN)
 			break;
@@ -749,7 +750,8 @@
 	    eth_copy_and_sum(skb, (char *)priv->rx_buff[entry], pkt_len,0);
 	    skb->protocol=eth_type_trans(skb,dev);
 #if 0
-	    printk("RX pkt type 0x%04x from ", ((u_short *)skb->data)[6]);
+	    printk(KERN_DEBUG "RX pkt type 0x%04x from ",
+		   ((u_short *)skb->data)[6]);
 	    {
 		int i;
 		u_char *ptr = &((u_char *)skb->data)[6];
@@ -825,7 +827,7 @@

     if (dev->flags & IFF_PROMISC) {
 	/* Log any net taps. */
-	printk("%s: Promiscuous mode enabled.\n", dev->name);
+	printk(KERN_INFO "%s: Promiscuous mode enabled.\n", dev->name);
 	lance->RAP = CSR15;		/* Mode Register */
 	lance->RDP = PROM;		/* Set promiscuous mode */
     } else {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
