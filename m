Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269370AbUJWAWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269370AbUJWAWa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 20:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269364AbUJWAUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 20:20:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:63931 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269373AbUJWARs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:17:48 -0400
Subject: [PATCH] amd8111e 1/2 : Fix identation of amd8111e_rx_poll()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Content-Type: text/plain
Message-Id: <1098490589.6028.102.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 23 Oct 2004 10:16:30 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch does an indentation fix to amd8111e_rx_poll() which was
incorrectly shifting left in the middle of a while() loop, thus
rendering the function difficult to read. There is no actual code
change.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/net/amd8111e.c
===================================================================
--- linux-work.orig/drivers/net/amd8111e.c	2004-10-20 13:01:01.000000000 +1000
+++ linux-work/drivers/net/amd8111e.c	2004-10-23 09:59:44.318155200 +1000
@@ -745,97 +745,96 @@
 			/* check if err summary bit is set */ 
 			if(le16_to_cpu(lp->rx_ring[rx_index].rx_flags) 
 								& ERR_BIT){
-			/* 
-			 * There is a tricky error noted by John Murphy,
-			 * <murf@perftech.com> to Russ Nelson: Even with
-			 * full-sized * buffers it's possible for a  
-			 * jabber packet to use two buffers, with only 
-			 * the last correctly noting the error.
-			 */
-
-			/* reseting flags */
-			lp->rx_ring[rx_index].rx_flags &=RESET_RX_FLAGS;
-			goto err_next_pkt;
-
+				/* 
+				 * There is a tricky error noted by John Murphy,
+				 * <murf@perftech.com> to Russ Nelson: Even with
+				 * full-sized * buffers it's possible for a  
+				 * jabber packet to use two buffers, with only 
+				 * the last correctly noting the error.
+				 */
+
+				/* reseting flags */
+				lp->rx_ring[rx_index].rx_flags &=RESET_RX_FLAGS;
+				goto err_next_pkt;
 			}
 			/* check for STP and ENP */
-		status = le16_to_cpu(lp->rx_ring[rx_index].rx_flags);
-		if(!((status & STP_BIT) && (status & ENP_BIT))){
-			/* reseting flags */
-			lp->rx_ring[rx_index].rx_flags &=RESET_RX_FLAGS;
-			goto err_next_pkt;
-		}
-		pkt_len = le16_to_cpu(lp->rx_ring[rx_index].msg_count) - 4;
+			status = le16_to_cpu(lp->rx_ring[rx_index].rx_flags);
+			if(!((status & STP_BIT) && (status & ENP_BIT))){
+				/* reseting flags */
+				lp->rx_ring[rx_index].rx_flags &=RESET_RX_FLAGS;
+				goto err_next_pkt;
+			}
+			pkt_len = le16_to_cpu(lp->rx_ring[rx_index].msg_count) - 4;
 
 #if AMD8111E_VLAN_TAG_USED		
-		vtag = le16_to_cpu(lp->rx_ring[rx_index].rx_flags) & TT_MASK;
-		/*MAC will strip vlan tag*/ 
-		if(lp->vlgrp != NULL && vtag !=0)
-			min_pkt_len =MIN_PKT_LEN - 4;
-		else
+			vtag = le16_to_cpu(lp->rx_ring[rx_index].rx_flags) & TT_MASK;
+			/*MAC will strip vlan tag*/ 
+			if(lp->vlgrp != NULL && vtag !=0)
+				min_pkt_len =MIN_PKT_LEN - 4;
+			else
 #endif
-			min_pkt_len =MIN_PKT_LEN;
+				min_pkt_len =MIN_PKT_LEN;
 
-		if (pkt_len < min_pkt_len) {
-			lp->rx_ring[rx_index].rx_flags &= RESET_RX_FLAGS;
-			lp->drv_rx_errors++;
-			goto err_next_pkt;
-		}
-		if(--rx_pkt_limit < 0)
-			goto rx_not_empty;
-		if(!(new_skb = dev_alloc_skb(lp->rx_buff_len))){
-			/* if allocation fail, 
-				ignore that pkt and go to next one */
-			lp->rx_ring[rx_index].rx_flags &= RESET_RX_FLAGS;
-			lp->drv_rx_errors++;
-			goto err_next_pkt;
-		}
+			if (pkt_len < min_pkt_len) {
+				lp->rx_ring[rx_index].rx_flags &= RESET_RX_FLAGS;
+				lp->drv_rx_errors++;
+				goto err_next_pkt;
+			}
+			if(--rx_pkt_limit < 0)
+				goto rx_not_empty;
+			if(!(new_skb = dev_alloc_skb(lp->rx_buff_len))){
+				/* if allocation fail, 
+				   ignore that pkt and go to next one */
+				lp->rx_ring[rx_index].rx_flags &= RESET_RX_FLAGS;
+				lp->drv_rx_errors++;
+				goto err_next_pkt;
+			}
 		
-		skb_reserve(new_skb, 2);
-		skb = lp->rx_skbuff[rx_index];
-		pci_unmap_single(lp->pci_dev,lp->rx_dma_addr[rx_index],
-			lp->rx_buff_len-2, PCI_DMA_FROMDEVICE);
-		skb_put(skb, pkt_len);
-		skb->dev = dev;
-		lp->rx_skbuff[rx_index] = new_skb;
-		new_skb->dev = dev;
-		lp->rx_dma_addr[rx_index] = pci_map_single(lp->pci_dev,
-			new_skb->data, lp->rx_buff_len-2,PCI_DMA_FROMDEVICE);
+			skb_reserve(new_skb, 2);
+			skb = lp->rx_skbuff[rx_index];
+			pci_unmap_single(lp->pci_dev,lp->rx_dma_addr[rx_index],
+					 lp->rx_buff_len-2, PCI_DMA_FROMDEVICE);
+			skb_put(skb, pkt_len);
+			skb->dev = dev;
+			lp->rx_skbuff[rx_index] = new_skb;
+			new_skb->dev = dev;
+			lp->rx_dma_addr[rx_index] = pci_map_single(lp->pci_dev,
+								   new_skb->data,
+								   lp->rx_buff_len-2,
+								   PCI_DMA_FROMDEVICE);
 	
-		skb->protocol = eth_type_trans(skb, dev);
+			skb->protocol = eth_type_trans(skb, dev);
 
 #if AMD8111E_VLAN_TAG_USED		
-		
-		vtag = lp->rx_ring[rx_index].rx_flags & TT_MASK;
-		if(lp->vlgrp != NULL && (vtag == TT_VLAN_TAGGED)){
-			amd8111e_vlan_rx(lp, skb,
+			vtag = lp->rx_ring[rx_index].rx_flags & TT_MASK;
+			if(lp->vlgrp != NULL && (vtag == TT_VLAN_TAGGED)){
+				amd8111e_vlan_rx(lp, skb,
 				    lp->rx_ring[rx_index].tag_ctrl_info);
-		} else
+			} else
 #endif
-			
-			netif_receive_skb(skb);
-		/*COAL update rx coalescing parameters*/
-		lp->coal_conf.rx_packets++;
-		lp->coal_conf.rx_bytes += pkt_len;	
-		num_rx_pkt++;
-		dev->last_rx = jiffies;
+				netif_receive_skb(skb);
+			/*COAL update rx coalescing parameters*/
+			lp->coal_conf.rx_packets++;
+			lp->coal_conf.rx_bytes += pkt_len;	
+			num_rx_pkt++;
+			dev->last_rx = jiffies;
 	
-err_next_pkt:	
-		lp->rx_ring[rx_index].buff_phy_addr
-			 = cpu_to_le32(lp->rx_dma_addr[rx_index]);
-		lp->rx_ring[rx_index].buff_count = 
+		err_next_pkt:	
+			lp->rx_ring[rx_index].buff_phy_addr
+				= cpu_to_le32(lp->rx_dma_addr[rx_index]);
+			lp->rx_ring[rx_index].buff_count = 
 				cpu_to_le16(lp->rx_buff_len-2);
-		lp->rx_ring[rx_index].rx_flags |= cpu_to_le16(OWN_BIT);
-		rx_index = (++lp->rx_idx) & RX_RING_DR_MOD_MASK;
-	}
-	/* Check the interrupt status register for more packets in the 
-	mean time. Process them since we have not used up our quota.*/
+			lp->rx_ring[rx_index].rx_flags |= cpu_to_le16(OWN_BIT);
+			rx_index = (++lp->rx_idx) & RX_RING_DR_MOD_MASK;
+		}
+		/* Check the interrupt status register for more packets in the 
+		   mean time. Process them since we have not used up our quota.*/
 
-	intr0 = readl(mmio + INT0);
-	/*Ack receive packets */
-	writel(intr0 & RINT0,mmio + INT0);
+		intr0 = readl(mmio + INT0);
+		/*Ack receive packets */
+		writel(intr0 & RINT0,mmio + INT0);
 
-	}while(intr0 & RINT0);
+	} while(intr0 & RINT0);
 
 	/* Receive descriptor is empty now */
 	dev->quota -= num_rx_pkt;


