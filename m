Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275904AbSIULph>; Sat, 21 Sep 2002 07:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275905AbSIULph>; Sat, 21 Sep 2002 07:45:37 -0400
Received: from adambe1.lnk.telstra.net ([139.130.12.177]:15563 "HELO unibar")
	by vger.kernel.org with SMTP id <S275904AbSIULpb>;
	Sat, 21 Sep 2002 07:45:31 -0400
Message-ID: <20020921115031.27054.qmail@unibar>
From: adam@skullslayer.rod.org
Subject: [PATCH] __KERNEL__ pasting in drivers/net/gt96100eth.c
To: linux-kernel@vger.kernel.org
Date: Sat, 21 Sep 2002 21:50:31 +1000 (EST)
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A quick patch to fix the __FUNCTION pasting in
drivers/net/gt96100eth.c

    Adam


--- drivers/net/gt96100eth.c.orig	Sat Sep 21 21:23:24 2002
+++ drivers/net/gt96100eth.c	Sat Sep 21 21:47:24 2002
@@ -267,7 +267,7 @@
 		gt96100_delay(1);
 
 		if (--timedout == 0) {
-			printk(KERN_ERR __FUNCTION__ ": busy timeout!!\n");
+			printk(KERN_ERR "%s: busy timeout!!\n", __FUNCTION__);
 			return -ENODEV;
 		}
 	}
@@ -281,7 +281,7 @@
 		gt96100_delay(1);
 	
 		if (--timedout == 0) {
-			printk(KERN_ERR __FUNCTION__ ": timeout!!\n");
+			printk(KERN_ERR "%s: timeout!!\n", __FUNCTION__);
 			return -ENODEV;
 		}
 	}
@@ -333,7 +333,7 @@
 		gt96100_delay(1);
 	
 		if (--timedout == 0) {
-			printk(KERN_ERR __FUNCTION__ ": busy timeout!!\n");
+			printk(KERN_ERR "%s: busy timeout!!\n", __FUNCTION__);
 			return -1;
 		}
 	}
@@ -350,7 +350,7 @@
 	struct gt96100_private *gp = (struct gt96100_private *)dev->priv;
 	int i;
 
-	dbg(0, __FUNCTION__ ": txno/txni/cnt=%d/%d/%d\n",
+	dbg(0, "%s: txno/txni/cnt=%d/%d/%d\n", __FUNCTION__,
 	    gp->tx_next_out, gp->tx_next_in, gp->tx_count);
 
 	for (i=0; i<TX_RING_SIZE; i++)
@@ -363,7 +363,7 @@
 	struct gt96100_private *gp = (struct gt96100_private *)dev->priv;
 	int i;
 
-	dbg(0, __FUNCTION__ ": rxno=%d\n", gp->rx_next_out);
+	dbg(0, "%s: rxno=%d\n", __FUNCTION__, gp->rx_next_out);
 
 	for (i=0; i<RX_RING_SIZE; i++)
 		dump_rx_desc(0, dev, i);
@@ -414,9 +414,8 @@
 	unsigned char* skbdata;
     
 	if (dbg_lvl <= GT96100_DEBUG) {
-		dbg(dbg_lvl, __FUNCTION__
-		    ": skb=%p, skb->data=%p, skb->len=%d\n",
-		    skb, skb->data, skb->len);
+		dbg(dbg_lvl, "%s: skb=%p, skb->data=%p, skb->len=%d\n",
+		    __FUNCTION__, skb, skb->data, skb->len);
 
 		skbdata = (unsigned char*)KSEG1ADDR(skb->data);
     
@@ -446,11 +445,11 @@
 	tblEntry1 |= (u32)addr[4] << 11;
 	tblEntry1 |= (u32)addr[3] << 19;
 	tblEntry1 |= ((u32)addr[2] & 0x1f) << 27;
-	dbg(3, __FUNCTION__ ": tblEntry1=%x\n", tblEntry1);
+	dbg(3, "%s: tblEntry1=%x\n", __FUNCTION__, tblEntry1);
 	tblEntry0 = ((u32)addr[2] >> 5) & 0x07;
 	tblEntry0 |= (u32)addr[1] << 3;
 	tblEntry0 |= (u32)addr[0] << 11;
-	dbg(3, __FUNCTION__ ": tblEntry0=%x\n", tblEntry0);
+	dbg(3, "%s: tblEntry0=%x\n", __FUNCTION__, tblEntry0);
 
 #if 0
 
@@ -464,7 +463,7 @@
 			((ctmp&0x20)<<1) | ((ctmp&0x40)>>1);
 	}
 
-	dump_hw_addr(3, dev, __FUNCTION__ ": nib swap/invt addr=", hash_ea);
+	dump_hw_addr(3, dev, "%s: nib swap/invt addr=", __FUNCTION__, hash_ea);
     
 	if (gp->hash_mode == 0) {
 		hashResult = ((u16)hash_ea[0] & 0xfc) << 7;
@@ -478,19 +477,19 @@
 		return -1; // don't support hash mode 1
 	}
 
-	dbg(3, __FUNCTION__ ": hashResult=%x\n", hashResult);
+	dbg(3, "%s: hashResult=%x\n", __FUNCTION__, hashResult);
 
 	tblEntryAddr =
 		(u32 *)(&gp->hash_table[((u32)hashResult & 0x7ff) << 3]);
     
-	dbg(3, __FUNCTION__ ": tblEntryAddr=%p\n", tblEntryAddr);
+	dbg(3, "%s: tblEntryAddr=%p\n", tblEntryAddr, __FUNCTION__);
 
 	for (i=0; i<HASH_HOP_NUMBER; i++) {
 		if ((*tblEntryAddr & hteValid) &&
 		    !(*tblEntryAddr & hteSkip)) {
 			// This entry is already occupied, go to next entry
 			tblEntryAddr += 2;
-			dbg(3, __FUNCTION__ ": skipping to %p\n",
+			dbg(3, "%s: skipping to %p\n", __FUNCTION__, 
 			    tblEntryAddr);
 		} else {
 			memset(tblEntryAddr, 0, 8);
@@ -501,7 +500,7 @@
 	}
 
 	if (i >= HASH_HOP_NUMBER) {
-		err(__FUNCTION__ ": expired!\n");
+		err("%s: expired!\n", __FUNCTION__);
 		return -1; // Couldn't find an unused entry
 	}
 
@@ -563,7 +562,7 @@
 	struct gt96100_private *gp = (struct gt96100_private *)dev->priv;
 	int timedout = 100; // wait up to 100 msec for hard stop to complete
 
-	dbg(3, __FUNCTION__ "\n");
+	dbg(3, "%s\n", __FUNCTION__);
 
 	// Return if neither Rx or Tx abort bits are set
 	if (!(abort_bits & (sdcmrAR | sdcmrAT)))
@@ -577,7 +576,7 @@
 	// abort any Rx/Tx DMA immediately
 	GT96100ETH_WRITE(gp, GT96100_ETH_SDMA_COMM, abort_bits);
 
-	dbg(3, __FUNCTION__ ": SDMA comm = %x\n",
+	dbg(3, "%s: SDMA comm = %x\n", __FUNCTION__,
 	    GT96100ETH_READ(gp, GT96100_ETH_SDMA_COMM));
 
 	// wait for abort to complete
@@ -586,7 +585,7 @@
 		gt96100_delay(1);
 	
 		if (--timedout == 0) {
-			err(__FUNCTION__ ": timeout!!\n");
+			err("%s: timeout!!\n", __FUNCTION__);
 			break;
 		}
 	}
@@ -600,7 +599,7 @@
 {
 	struct gt96100_private *gp = (struct gt96100_private *)dev->priv;
 
-	dbg(3, __FUNCTION__ "\n");
+	dbg(3, "%s\n", __FUNCTION__);
 
 	disable_ether_irq(dev);
 
@@ -712,8 +711,7 @@
 	struct net_device *dev = NULL;
     
 	if (gtif->irq < 0) {
-		printk(KERN_ERR __FUNCTION__
-		       ": irq unknown - probing not supported\n");
+		printk(KERN_ERR "%s: irq unknown - probing not supported\n", __FUNCTION_);
 		return -ENODEV;
 	}
     
@@ -737,13 +735,12 @@
 	// probe for the external PHY
 	if ((phy_id1 = read_MII(phy_addr, 2)) <= 0 ||
 	    (phy_id2 = read_MII(phy_addr, 3)) <= 0) {
-		printk(KERN_ERR __FUNCTION__
-		       ": no PHY found on MII%d\n", port_num);
+		printk(KERN_ERR "%s: no PHY found on MII%d\n", __FUNCTION__, port_num);
 		return -ENODEV;
 	}
 	
 	if (!request_region(gtif->iobase, GT96100_ETH_IO_SIZE, "GT96100ETH")) {
-		printk(KERN_ERR __FUNCTION__ ": request_region failed\n");
+		printk(KERN_ERR "%s: request_region failed\n", __FUNCTION__);
 		return -EBUSY;
 	}
 
@@ -756,7 +753,7 @@
 	dev->irq = gtif->irq;
 
 	if ((retval = parse_mac_addr(dev, gtif->mac_str))) {
-		err(__FUNCTION__ ": MAC address parse failed\n");
+		err("%s: MAC address parse failed\n", __FUNCTION__);
 		retval = -EINVAL;
 		goto free_region;
 	}
@@ -820,7 +817,7 @@
 		}
 	}
     
-	dbg(3, __FUNCTION__ ": rx_ring=%p, tx_ring=%p\n",
+	dbg(3, "%s: rx_ring=%p, tx_ring=%p\n", __FUNCTION__,
 	    gp->rx_ring, gp->tx_ring);
 
 	// Allocate Rx Hash Table
@@ -837,7 +834,7 @@
 		}
 	}
     
-	dbg(3, __FUNCTION__ ": hash=%p\n", gp->hash_table);
+	dbg(3, "%s: hash=%p\n", __FUNCTION__, gp->hash_table);
 
 	spin_lock_init(&gp->lock);
     
@@ -860,7 +857,7 @@
 	if (dev->priv != NULL)
 		kfree (dev->priv);
 	kfree (dev);
-	err(__FUNCTION__ " failed.  Returns %d\n", retval);
+	err("%s failed.  Returns %d\n", __FUNCTION__, retval);
 	return retval;
 }
 
@@ -967,10 +964,10 @@
 	u32 tmp;
 	u16 mii_reg;
     
-	dbg(3, __FUNCTION__ ": dev=%p\n", dev);
-	dbg(3, __FUNCTION__ ": scs10_lo=%4x, scs10_hi=%4x\n",
+	dbg(3, "%s: dev=%p\n", __FUNCTION__, dev);
+	dbg(3, "%s: scs10_lo=%4x, scs10_hi=%4x\n", __FUNCTION__, 
 	    GT96100_READ(0x8), GT96100_READ(0x10));
-	dbg(3, __FUNCTION__ ": scs32_lo=%4x, scs32_hi=%4x\n",
+	dbg(3, "%s: scs32_lo=%4x, scs32_hi=%4x\n", __FUNCTION__,
 	    GT96100_READ(0x18), GT96100_READ(0x20));
     
 	// Stop and disable Port
@@ -985,7 +982,7 @@
 	tmp |= (1<<31);
 #endif
 	GT96100_WRITE(GT96100_CIU_ARBITER_CONFIG, tmp);
-	dbg(3, __FUNCTION__ ": CIU Config=%x/%x\n",
+	dbg(3, "%s: CIU Config=%x/%x\n", __FUNCTION__, 
 	    tmp, GT96100_READ(GT96100_CIU_ARBITER_CONFIG));
 
 	// Set routing.
@@ -1010,19 +1007,19 @@
 	gt96100_add_hash_entry(dev, dev->dev_addr);
 	// Set-up DMA ptr to hash table
 	GT96100ETH_WRITE(gp, GT96100_ETH_HASH_TBL_PTR, gp->hash_table_dma);
-	dbg(3, __FUNCTION__ ": Hash Tbl Ptr=%x\n",
+	dbg(3, "%s: Hash Tbl Ptr=%x\n", __FUNCTION__,
 	    GT96100ETH_READ(gp, GT96100_ETH_HASH_TBL_PTR));
 
 	// Setup Tx
 	reset_tx(dev);
 
-	dbg(3, __FUNCTION__ ": Curr Tx Desc Ptr0=%x\n",
+	dbg(3, "%s: Curr Tx Desc Ptr0=%x\n", __FUNCTION__,
 	    GT96100ETH_READ(gp, GT96100_ETH_CURR_TX_DESC_PTR0));
 
 	// Setup Rx
 	reset_rx(dev);
 
-	dbg(3, __FUNCTION__ ": 1st/Curr Rx Desc Ptr0=%x/%x\n",
+	dbg(3, "%s: 1st/Curr Rx Desc Ptr0=%x/%x\n", __FUNCTION__,
 	    GT96100ETH_READ(gp, GT96100_ETH_1ST_RX_DESC_PTR0),
 	    GT96100ETH_READ(gp, GT96100_ETH_CURR_RX_DESC_PTR0));
 
@@ -1034,7 +1031,7 @@
 	mii_reg |= 2;  /* enable mii interrupt */
 	write_MII(gp->phy_addr, 0x11, mii_reg);
 	
-	dbg(3, __FUNCTION__ ": PhyAD=%x\n",
+	dbg(3, "%s: PhyAD=%x\n", __FUNCTION__,
 	    GT96100_READ(GT96100_ETH_PHY_ADDR_REG));
 
 	// setup DMA
@@ -1049,17 +1046,17 @@
 			 sdcrBLMR | sdcrBLMT |
 			 (0xf<<sdcrRCBit) | sdcrRIFB | (3<<sdcrBSZBit));
 #endif
-	dbg(3, __FUNCTION__ ": SDMA Config=%x\n",
+	dbg(3, "%s: SDMA Config=%x\n", __FUNCTION__,
 	    GT96100ETH_READ(gp, GT96100_ETH_SDMA_CONFIG));
 
 	// start Rx DMA
 	GT96100ETH_WRITE(gp, GT96100_ETH_SDMA_COMM, sdcmrERD);
-	dbg(3, __FUNCTION__ ": SDMA Comm=%x\n",
+	dbg(3, "%s: SDMA Comm=%x\n", __FUNCTION__,
 	    GT96100ETH_READ(gp, GT96100_ETH_SDMA_COMM));
     
 	// enable this port (set hash size to 1/2K)
 	GT96100ETH_WRITE(gp, GT96100_ETH_PORT_CONFIG, pcrEN | pcrHS);
-	dbg(3, __FUNCTION__ ": Port Config=%x\n",
+	dbg(3, "%s: Port Config=%x\n", __FUNCTION__,
 	    GT96100ETH_READ(gp, GT96100_ETH_PORT_CONFIG));
     
 	/*
@@ -1079,7 +1076,7 @@
 			 pcxrFCTL | pcxrFCTLen | pcxrFLP |
 			 pcxrPRIOrxOverride | pcxrMIBclrMode);
     
-	dbg(3, __FUNCTION__ ": Port Config Ext=%x\n",
+	dbg(3, "%s: Port Config Ext=%x\n", __FUNCTION__,
 	    GT96100ETH_READ(gp, GT96100_ETH_PORT_CONFIG_EXT));
 
 	netif_start_queue(dev);
@@ -1101,7 +1098,7 @@
     
 	MOD_INC_USE_COUNT;
 
-	dbg(2, __FUNCTION__ ": dev=%p\n", dev);
+	dbg(2, "%s: dev=%p\n", __FUNCTION__, dev);
 
 	// Initialize and startup the GT-96100 ethernet port
 	if ((retval = gt96100_init(dev))) {
@@ -1118,7 +1115,7 @@
 		return retval;
 	}
 	
-	dbg(2, __FUNCTION__ ": Initialization done.\n");
+	dbg(2, "%s: Initialization done.\n", __FUNCTION__);
 
 	return 0;
 }
@@ -1126,7 +1123,7 @@
 static int
 gt96100_close(struct net_device *dev)
 {
-	dbg(3, __FUNCTION__ ": dev=%p\n", dev);
+	dbg(3, "%s: dev=%p\n", __FUNCTION__, dev);
 
 	// stop the device
 	if (netif_device_present(dev)) {
@@ -1152,7 +1149,7 @@
 
 	nextIn = gp->tx_next_in;
 
-	dbg(3, __FUNCTION__ ": nextIn=%d\n", nextIn);
+	dbg(3, "%s: nextIn=%d\n", __FUNCTION__, nextIn);
     
 	if (gp->tx_count >= TX_RING_SIZE) {
 		warn("Tx Ring full, pkt dropped.\n");
@@ -1162,14 +1159,14 @@
 	}
     
 	if (!(gp->last_psr & psrLink)) {
-		err(__FUNCTION__ ": Link down, pkt dropped.\n");
+		err("%s: Link down, pkt dropped.\n", __FUNCTION__);
 		gp->stats.tx_dropped++;
 		spin_unlock_irqrestore(&gp->lock, flags);
 		return 1;
 	}
     
 	if (dma32_to_cpu(gp->tx_ring[nextIn].cmdstat) & txOwn) {
-		err(__FUNCTION__ ": device owns descriptor, pkt dropped.\n");
+		err("%s: device owns descriptor, pkt dropped.\n", __FUNCTION__);
 		gp->stats.tx_dropped++;
 		// stop the queue, so Tx timeout can fix it
 		netif_stop_queue(dev);
@@ -1222,7 +1219,7 @@
 	gt96100_rd_t *rd;
 	u32 cmdstat;
     
-	dbg(3, __FUNCTION__ ": dev=%p, status=%x\n", dev, status);
+	dbg(3, "%s: dev=%p, status=%x\n", __FUNCTION__, dev, status);
 
 	cdp = (GT96100ETH_READ(gp, GT96100_ETH_1ST_RX_DESC_PTR0)
 	       - gp->rx_ring_dma) / sizeof(gt96100_rd_t);
@@ -1237,7 +1234,7 @@
 		rd = &gp->rx_ring[nextOut];
 		cmdstat = dma32_to_cpu(rd->cmdstat);
 	
-		dbg(4, __FUNCTION__ ": Rx desc cmdstat=%x, nextOut=%d\n",
+		dbg(4, "%s: Rx desc cmdstat=%x, nextOut=%d\n", __FUNCTION__,
 		    cmdstat, nextOut);
 
 		if (cmdstat & (u32)rxOwn) {
@@ -1279,8 +1276,7 @@
 				 * the deal with this packet? Good question,
 				 * let's dump it out.
 				 */
-				err(__FUNCTION__
-				    ": desc not first and last!\n");
+				err("%s: desc not first and last!\n", __FUNCTION__);
 				dump_rx_desc(0, dev, nextOut);
 			}
 			cmdstat |= (u32)rxOwn;
@@ -1294,8 +1290,7 @@
 		/* Create new skb. */
 		skb = dev_alloc_skb(pkt_len+2);
 		if (skb == NULL) {
-			err(__FUNCTION__
-			    ": Memory squeeze, dropping packet.\n");
+			err("%s: Memory squeeze, dropping packet.\n", __FUNCTION__);
 			gp->stats.rx_dropped++;
 			cmdstat |= (u32)rxOwn;
 			rd->cmdstat = cpu_to_dma32(cmdstat);
@@ -1317,7 +1312,7 @@
 	}
     
 	if (nextOut == gp->rx_next_out)
-		dbg(3, __FUNCTION__ ": RxCDP did not increment?\n");
+		dbg(3, "%s: RxCDP did not increment?\n", __FUNCTION__);
 
 	gp->rx_next_out = nextOut;
 	return 0;
@@ -1345,7 +1340,7 @@
 		td = &gp->tx_ring[nextOut];
 		cmdstat = dma32_to_cpu(td->cmdstat);
 	
-		dbg(3, __FUNCTION__ ": Tx desc cmdstat=%x, nextOut=%d\n",
+		dbg(3, "%s: Tx desc cmdstat=%x, nextOut=%d\n", __FUNCTION__,
 		    cmdstat, nextOut);
 	
 		if (cmdstat & (u32)txOwn) {
@@ -1358,7 +1353,7 @@
 	
 		// increment Tx error stats
 		if (cmdstat & (u32)txErrorSummary) {
-			dbg(2, __FUNCTION__ ": Tx error, cmdstat = %x\n",
+			dbg(2, "%s: Tx error, cmdstat = %x\n", __FUNCTION__,
 			    cmdstat);
 			gp->stats.tx_errors++;
 			if (cmdstat & (u32)txReTxLimit)
@@ -1379,8 +1374,7 @@
 			gp->tx_full = 0;
 			if (gp->last_psr & psrLink) {
 				netif_wake_queue(dev);
-				dbg(2, __FUNCTION__
-				    ": Tx Ring was full, queue waked\n");
+				dbg(2, "%s: Tx Ring was full, queue waked\n", __FUNCTION_);
 			}
 		}
 	
@@ -1389,24 +1383,24 @@
 	
 		// free the skb
 		if (gp->tx_skbuff[nextOut]) {
-			dbg(3, __FUNCTION__ ": good Tx, skb=%p\n",
+			dbg(3, "%s: good Tx, skb=%p\n", __FUNCTION__,
 			    gp->tx_skbuff[nextOut]);
 			dev_kfree_skb_irq(gp->tx_skbuff[nextOut]);
 			gp->tx_skbuff[nextOut] = NULL;
 		} else {
-			err(__FUNCTION__ ": no skb!\n");
+			err("%s: no skb!\n", __FUNCTION__);
 		}
 	}
 
 	gp->tx_next_out = nextOut;
 
 	if (gt96100_check_tx_consistent(gp)) {
-		err(__FUNCTION__ ": Tx queue inconsistent!\n");
+		err("%s: Tx queue inconsistent!\n", __FUNCTION__);
 	}
     
 	if ((status & icrTxEndLow) && gp->tx_count != 0) {
 		// we must restart the DMA
-		dbg(3, __FUNCTION__ ": Restarting Tx DMA\n");
+		dbg(3, "%s: Restarting Tx DMA\n", __FUNCTION__);
 		GT96100ETH_WRITE(gp, GT96100_ETH_SDMA_COMM,
 				 sdcmrERD | sdcmrTXDL);
 	}
@@ -1421,11 +1415,11 @@
 	u32 status;
     
 	if (dev == NULL) {
-		err(__FUNCTION__ ": null dev ptr\n");
+		err("%s: null dev ptr\n", __FUNCTION__);
 		return;
 	}
 
-	dbg(3, __FUNCTION__ ": entry, icr=%x\n",
+	dbg(3, "%s: entry, icr=%x\n", __FUNCTION__,
 	    GT96100ETH_READ(gp, GT96100_ETH_INT_CAUSE));
 
 	spin_lock(&gp->lock);
@@ -1460,13 +1454,13 @@
 		
 				if ((psr & psrLink) && !gp->tx_full &&
 				    netif_queue_stopped(dev)) {
-					dbg(0, __FUNCTION__
-					    ": Link up, waking queue.\n");
+					dbg(0, ": Link up, waking queue.\n",
+					    __FUNCTION_);
 					netif_wake_queue(dev);
 				} else if (!(psr & psrLink) &&
 					   !netif_queue_stopped(dev)) {
-					dbg(0, __FUNCTION__
-					    "Link down, stopping queue.\n");
+					dbg(0, "Link down, stopping queue.\n",
+					    __FUNCTION__);
 					netif_stop_queue(dev);
 				}
 
@@ -1486,13 +1480,13 @@
 	
 		// Now check TX errors (RX errors were handled in gt96100_rx)
 		if (status & icrTxErrorLow) {
-			err(__FUNCTION__ ": Tx resource error\n");
+			err("%s: Tx resource error\n", __FUNCTION__);
 			if (--gp->intr_work_done == 0)
 				break;
 		}
 	
 		if (status & icrTxUdr) {
-			err(__FUNCTION__ ": Tx underrun error\n");
+			err("%s: Tx underrun error\n", __FUNCTION__);
 			if (--gp->intr_work_done == 0)
 				break;
 		}
@@ -1501,10 +1495,10 @@
 	if (gp->intr_work_done == 0) {
 		// ACK any remaining pending interrupts
 		GT96100ETH_WRITE(gp, GT96100_ETH_INT_CAUSE, 0);
-		dbg(3, __FUNCTION__ ": hit max work\n");
+		dbg(3, "%s: hit max work\n", __FUNCTION__);
 	}
     
-	dbg(3, __FUNCTION__ ": exit, icr=%x\n",
+	dbg(3, "%s: exit, icr=%x\n", __FUNCTION__,
 	    GT96100ETH_READ(gp, GT96100_ETH_INT_CAUSE));
 
 	spin_unlock(&gp->lock);
@@ -1543,7 +1537,7 @@
 	unsigned long flags;
 	//struct dev_mc_list *mcptr;
     
-	dbg(3, __FUNCTION__ ": dev=%p, flags=%x\n", dev, dev->flags);
+	dbg(3, "%s: dev=%p, flags=%x\n", __FUNCTION__, dev, dev->flags);
 
 	// stop the Receiver DMA
 	abort(dev, sdcmrAR);
@@ -1586,7 +1580,7 @@
 	struct gt96100_private *gp = (struct gt96100_private *)dev->priv;
 	unsigned long flags;
 
-	dbg(3, __FUNCTION__ ": dev=%p\n", dev);
+	dbg(3, "%s: dev=%p\n", __FUNCTION__, dev);
 
 	if (netif_device_present(dev)) {
 		spin_lock_irqsave (&gp->lock, flags);
