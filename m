Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751608AbVJMTUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbVJMTUA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbVJMTUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:20:00 -0400
Received: from xproxy.gmail.com ([66.249.82.204]:5470 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751611AbVJMTT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:19:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=TXRhcJ/e8H6ao1XLfe2/25PZLhJzRBxWIlXU+6uZe2C6Dmyth1BrrG7Vg9QxeuBQe/bpKZAqLTw8n1wrD5pbDblQZU4o6M78ysowb2u7J+O6g35ZFThUX9atF/wfdBizUhWAIV/pKG3OdRdwDAkH+7R6O6Wq9zTvYO/YEwJsm4s=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/14] Big kfree NULL check cleanup - drivers/net
Date: Thu, 13 Oct 2005 21:22:47 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       Jes Sorensen <jes@trained-monkey.org>,
       Matt Porter <mporter@kernel.crashing.org>,
       Michael Chan <mchan@broadcom.com>, linux.nics@intel.com,
       hans@esrac.ele.tue.nl, Santiago Leon <santil@us.ibm.com>,
       Jean Tourrilhes <jt@hpl.hp.com>, Paul Mackerras <paulus@samba.org>,
       Michael Hipp <hippm@informatik.uni-tuebingen.de>,
       Jes Sorensen <jes@wildopensource.com>,
       Carsten Langgaard <carstenl@mips.com>, Jeff Garzik <jgarzik@pobox.com>,
       Benjamin Reed <breed@users.sourceforge.net>,
       Jouni Malinen <jkmaline@cc.hut.fi>, prism54-private@prism54.org,
       netdev@vger.kernel.org, Stuart Cheshire <cheshire@cs.stanford.edu>,
       g4klx@g4klx.demon.co.uk, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200510132122.48035.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the drivers/net/ part of the big kfree cleanup patch.

Remove pointless checks for NULL prior to calling kfree() in drivers/net/.


Sorry about the long Cc: list, but I wanted to make sure I included everyone
who's code I've changed with this patch.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

Please see the initial announcement mail on LKML with subject
"[PATCH 00/14] Big kfree NULL check cleanup"
for additional details.

 drivers/net/acenic.c                       |    6 +--
 drivers/net/au1000_eth.c                   |    6 +--
 drivers/net/b44.c                          |   12 ++-----
 drivers/net/bmac.c                         |    6 +--
 drivers/net/bnx2.c                         |   12 ++-----
 drivers/net/e1000/e1000_ethtool.c          |    7 +---
 drivers/net/hamradio/mkiss.c               |    6 +--
 drivers/net/ibmveth.c                      |   19 +++--------
 drivers/net/irda/donauboe.c                |    6 +--
 drivers/net/irda/irda-usb.c                |    6 +--
 drivers/net/irda/irport.c                  |    3 -
 drivers/net/irda/sir_dev.c                 |    3 -
 drivers/net/irda/vlsi_ir.c                 |    3 -
 drivers/net/mace.c                         |    6 +--
 drivers/net/ni65.c                         |    9 +----
 drivers/net/rrunner.c                      |    6 +--
 drivers/net/s2io.c                         |    3 -
 drivers/net/saa9730.c                      |    8 +---
 drivers/net/sb1250-mac.c                   |   12 +------
 drivers/net/tg3.c                          |    6 +--
 drivers/net/tulip/de2104x.c                |    6 +--
 drivers/net/tulip/tulip_core.c             |    6 +--
 drivers/net/via-velocity.c                 |    6 +--
 drivers/net/wireless/airo.c                |   48 +++++++++++------------------
 drivers/net/wireless/airo_cs.c             |    4 --
 drivers/net/wireless/atmel.c               |    6 +--
 drivers/net/wireless/atmel_cs.c            |    3 -
 drivers/net/wireless/hostap/hostap_ioctl.c |    9 +----
 drivers/net/wireless/prism54/islpci_dev.c  |    3 -
 drivers/net/wireless/prism54/oid_mgt.c     |    9 ++---
 drivers/net/wireless/strip.c               |   38 +++++++---------------
 include/net/ax25.h                         |    3 -
 include/net/netrom.h                       |    3 -
 33 files changed, 97 insertions(+), 192 deletions(-)

--- linux-2.6.14-rc4-orig/drivers/net/irda/vlsi_ir.c	2005-10-11 22:41:11.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/irda/vlsi_ir.c	2005-10-12 15:43:54.000000000 +0200
@@ -473,8 +473,7 @@ static int vlsi_free_ring(struct vlsi_ri
 		rd_set_addr_status(rd, 0, 0);
 		if (busaddr)
 			pci_unmap_single(r->pdev, busaddr, r->len, r->dir);
-		if (rd->buf)
-			kfree(rd->buf);
+		kfree(rd->buf);
 	}
 	kfree(r);
 	return 0;
--- linux-2.6.14-rc4-orig/drivers/net/irda/donauboe.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/irda/donauboe.c	2005-10-12 15:45:19.000000000 +0200
@@ -1695,11 +1695,9 @@ toshoboe_open (struct pci_dev *pci_dev, 
 
 freebufs:
   for (i = 0; i < TX_SLOTS; ++i)
-    if (self->tx_bufs[i])
-      kfree (self->tx_bufs[i]);
+    kfree (self->tx_bufs[i]);
   for (i = 0; i < RX_SLOTS; ++i)
-    if (self->rx_bufs[i])
-      kfree (self->rx_bufs[i]);
+    kfree (self->rx_bufs[i]);
   kfree(self->ringbuf);
 
 freeregion:
--- linux-2.6.14-rc4-orig/drivers/net/irda/irda-usb.c	2005-10-11 22:41:11.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/irda/irda-usb.c	2005-10-12 15:45:55.000000000 +0200
@@ -1168,10 +1168,8 @@ static inline void irda_usb_close(struct
 	unregister_netdev(self->netdev);
 
 	/* Remove the speed buffer */
-	if (self->speed_buff != NULL) {
-		kfree(self->speed_buff);
-		self->speed_buff = NULL;
-	}
+	kfree(self->speed_buff);
+	self->speed_buff = NULL;
 }
 
 /********************** USB CONFIG SUBROUTINES **********************/
--- linux-2.6.14-rc4-orig/drivers/net/irda/sir_dev.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/irda/sir_dev.c	2005-10-12 15:46:45.000000000 +0200
@@ -490,8 +490,7 @@ static void sirdev_free_buffers(struct s
 {
 	if (dev->rx_buff.skb)
 		kfree_skb(dev->rx_buff.skb);
-	if (dev->tx_buff.head)
-		kfree(dev->tx_buff.head);
+	kfree(dev->tx_buff.head);
 	dev->rx_buff.head = dev->tx_buff.head = NULL;
 	dev->rx_buff.skb = NULL;
 }
--- linux-2.6.14-rc4-orig/drivers/net/irda/irport.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/irda/irport.c	2005-10-12 15:47:03.000000000 +0200
@@ -235,8 +235,7 @@ static int irport_close(struct irport_cb
 		   __FUNCTION__, self->io.sir_base);
 	release_region(self->io.sir_base, self->io.sir_ext);
 
-	if (self->tx_buff.head)
-		kfree(self->tx_buff.head);
+	kfree(self->tx_buff.head);
 	
 	if (self->rx_buff.skb)
 		kfree_skb(self->rx_buff.skb);
--- linux-2.6.14-rc4-orig/drivers/net/b44.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/b44.c	2005-10-12 15:47:33.000000000 +0200
@@ -1076,14 +1076,10 @@ static void b44_init_rings(struct b44 *b
  */
 static void b44_free_consistent(struct b44 *bp)
 {
-	if (bp->rx_buffers) {
-		kfree(bp->rx_buffers);
-		bp->rx_buffers = NULL;
-	}
-	if (bp->tx_buffers) {
-		kfree(bp->tx_buffers);
-		bp->tx_buffers = NULL;
-	}
+	kfree(bp->rx_buffers);
+	bp->rx_buffers = NULL;
+	kfree(bp->tx_buffers);
+	bp->tx_buffers = NULL;
 	if (bp->rx_ring) {
 		pci_free_consistent(bp->pdev, DMA_TABLE_BYTES,
 				    bp->rx_ring, bp->rx_ring_dma);
--- linux-2.6.14-rc4-orig/drivers/net/e1000/e1000_ethtool.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/e1000/e1000_ethtool.c	2005-10-12 15:48:04.000000000 +0200
@@ -930,11 +930,8 @@ e1000_free_desc_rings(struct e1000_adapt
 	if(rxdr->desc)
 		pci_free_consistent(pdev, rxdr->size, rxdr->desc, rxdr->dma);
 
-	if(txdr->buffer_info)
-		kfree(txdr->buffer_info);
-	if(rxdr->buffer_info)
-		kfree(rxdr->buffer_info);
-
+	kfree(txdr->buffer_info);
+	kfree(rxdr->buffer_info);
 	return;
 }
 
--- linux-2.6.14-rc4-orig/drivers/net/tg3.c	2005-10-11 22:41:11.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/tg3.c	2005-10-12 15:48:37.000000000 +0200
@@ -3905,10 +3905,8 @@ static void tg3_init_rings(struct tg3 *t
  */
 static void tg3_free_consistent(struct tg3 *tp)
 {
-	if (tp->rx_std_buffers) {
-		kfree(tp->rx_std_buffers);
-		tp->rx_std_buffers = NULL;
-	}
+	kfree(tp->rx_std_buffers);
+	tp->rx_std_buffers = NULL;
 	if (tp->rx_std) {
 		pci_free_consistent(tp->pdev, TG3_RX_RING_BYTES,
 				    tp->rx_std, tp->rx_std_mapping);
--- linux-2.6.14-rc4-orig/drivers/net/tulip/tulip_core.c	2005-10-11 22:41:11.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/tulip/tulip_core.c	2005-10-12 15:48:58.000000000 +0200
@@ -1727,8 +1727,7 @@ err_out_free_ring:
 			     tp->rx_ring, tp->rx_ring_dma);
 
 err_out_mtable:
-	if (tp->mtable)
-		kfree (tp->mtable);
+	kfree (tp->mtable);
 	pci_iounmap(pdev, ioaddr);
 
 err_out_free_res:
@@ -1806,8 +1805,7 @@ static void __devexit tulip_remove_one (
 			     sizeof (struct tulip_rx_desc) * RX_RING_SIZE +
 			     sizeof (struct tulip_tx_desc) * TX_RING_SIZE,
 			     tp->rx_ring, tp->rx_ring_dma);
-	if (tp->mtable)
-		kfree (tp->mtable);
+	kfree (tp->mtable);
 	pci_iounmap(pdev, tp->base_addr);
 	free_netdev (dev);
 	pci_release_regions (pdev);
--- linux-2.6.14-rc4-orig/drivers/net/tulip/de2104x.c	2005-10-11 22:41:11.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/tulip/de2104x.c	2005-10-12 15:49:20.000000000 +0200
@@ -2071,8 +2071,7 @@ static int __init de_init_one (struct pc
 	return 0;
 
 err_out_iomap:
-	if (de->ee_data)
-		kfree(de->ee_data);
+	kfree(de->ee_data);
 	iounmap(regs);
 err_out_res:
 	pci_release_regions(pdev);
@@ -2091,8 +2090,7 @@ static void __exit de_remove_one (struct
 	if (!dev)
 		BUG();
 	unregister_netdev(dev);
-	if (de->ee_data)
-		kfree(de->ee_data);
+	kfree(de->ee_data);
 	iounmap(de->regs);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
--- linux-2.6.14-rc4-orig/drivers/net/au1000_eth.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/au1000_eth.c	2005-10-12 15:49:37.000000000 +0200
@@ -1609,8 +1609,7 @@ err_out:
 	/* here we should have a valid dev plus aup-> register addresses
 	 * so we can reset the mac properly.*/
 	reset_mac(dev);
-	if (aup->mii)
-		kfree(aup->mii);
+	kfree(aup->mii);
 	for (i = 0; i < NUM_RX_DMA; i++) {
 		if (aup->rx_db_inuse[i])
 			ReleaseDB(aup, aup->rx_db_inuse[i]);
@@ -1809,8 +1808,7 @@ static void __exit au1000_cleanup_module
 		if (dev) {
 			aup = (struct au1000_private *) dev->priv;
 			unregister_netdev(dev);
-			if (aup->mii)
-				kfree(aup->mii);
+			kfree(aup->mii);
 			for (j = 0; j < NUM_RX_DMA; j++) {
 				if (aup->rx_db_inuse[j])
 					ReleaseDB(aup, aup->rx_db_inuse[j]);
--- linux-2.6.14-rc4-orig/drivers/net/sb1250-mac.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/sb1250-mac.c	2005-10-12 15:50:29.000000000 +0200
@@ -1426,15 +1426,9 @@ static int sbmac_initctx(struct sbmac_so
 
 static void sbdma_uninitctx(struct sbmacdma_s *d)
 {
-	if (d->sbdma_dscrtable) {
-		kfree(d->sbdma_dscrtable);
-		d->sbdma_dscrtable = NULL;
-	}
-	
-	if (d->sbdma_ctxtable) {
-		kfree(d->sbdma_ctxtable);
-		d->sbdma_ctxtable = NULL;
-	}
+	kfree(d->sbdma_dscrtable);
+	kfree(d->sbdma_ctxtable);
+	d->sbdma_dscrtable = d->sbdma_ctxtable = NULL;
 }
 
 
--- linux-2.6.14-rc4-orig/drivers/net/hamradio/mkiss.c	2005-10-11 22:41:11.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/hamradio/mkiss.c	2005-10-12 15:50:51.000000000 +0200
@@ -352,10 +352,8 @@ static void ax_changedmtu(struct mkiss *
 		       "MTU change cancelled.\n",
 		       ax->dev->name);
 		dev->mtu = ax->mtu;
-		if (xbuff != NULL)
-			kfree(xbuff);
-		if (rbuff != NULL)
-			kfree(rbuff);
+		kfree(xbuff);
+		kfree(rbuff);
 		return;
 	}
 
--- linux-2.6.14-rc4-orig/drivers/net/acenic.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/acenic.c	2005-10-12 15:51:18.000000000 +0200
@@ -871,10 +871,8 @@ static void ace_init_cleanup(struct net_
 	if (ap->info)
 		pci_free_consistent(ap->pdev, sizeof(struct ace_info),
 				    ap->info, ap->info_dma);
-	if (ap->skb)
-		kfree(ap->skb);
-	if (ap->trace_buf)
-		kfree(ap->trace_buf);
+	kfree(ap->skb);
+	kfree(ap->trace_buf);
 
 	if (dev->irq)
 		free_irq(dev->irq, dev);
--- linux-2.6.14-rc4-orig/drivers/net/bmac.c	2005-10-11 22:41:10.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/bmac.c	2005-10-12 15:51:48.000000000 +0200
@@ -1689,10 +1689,8 @@ static void __exit bmac_exit(void)
 {
 	macio_unregister_driver(&bmac_driver);
 
-	if (bmac_emergency_rxbuf != NULL) {
-		kfree(bmac_emergency_rxbuf);
-		bmac_emergency_rxbuf = NULL;
-	}
+	kfree(bmac_emergency_rxbuf);
+	bmac_emergency_rxbuf = NULL;
 }
 
 MODULE_AUTHOR("Randy Gobbel/Paul Mackerras");
--- linux-2.6.14-rc4-orig/drivers/net/bnx2.c	2005-10-11 22:41:10.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/bnx2.c	2005-10-12 15:52:16.000000000 +0200
@@ -314,20 +314,16 @@ bnx2_free_mem(struct bnx2 *bp)
 				    bp->tx_desc_ring, bp->tx_desc_mapping);
 		bp->tx_desc_ring = NULL;
 	}
-	if (bp->tx_buf_ring) {
-		kfree(bp->tx_buf_ring);
-		bp->tx_buf_ring = NULL;
-	}
+	kfree(bp->tx_buf_ring);
+	bp->tx_buf_ring = NULL;
 	if (bp->rx_desc_ring) {
 		pci_free_consistent(bp->pdev,
 				    sizeof(struct rx_bd) * RX_DESC_CNT,
 				    bp->rx_desc_ring, bp->rx_desc_mapping);
 		bp->rx_desc_ring = NULL;
 	}
-	if (bp->rx_buf_ring) {
-		kfree(bp->rx_buf_ring);
-		bp->rx_buf_ring = NULL;
-	}
+	kfree(bp->rx_buf_ring);
+	bp->rx_buf_ring = NULL;
 }
 
 static int
--- linux-2.6.14-rc4-orig/drivers/net/saa9730.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/saa9730.c	2005-10-12 15:53:22.000000000 +0200
@@ -997,10 +997,7 @@ static void __devexit saa9730_remove_one
 
         if (dev) {
                 unregister_netdev(dev);
-
-		if (dev->priv)
-			kfree(dev->priv);
-
+		kfree(dev->priv);
                 free_netdev(dev);
                 pci_release_regions(pdev);
                 pci_disable_device(pdev);
@@ -1096,8 +1093,7 @@ static int lan_saa9730_init(struct net_d
 	return 0;
 
  out:
-	if (dev->priv)
-		kfree(dev->priv);
+	kfree(dev->priv);
 	return ret;
 }
 
--- linux-2.6.14-rc4-orig/drivers/net/mace.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/mace.c	2005-10-12 15:53:41.000000000 +0200
@@ -1035,10 +1035,8 @@ static void __exit mace_cleanup(void)
 {
 	macio_unregister_driver(&mace_driver);
 
-	if (dummy_buf) {
-		kfree(dummy_buf);
-		dummy_buf = NULL;
-	}
+	kfree(dummy_buf);
+	dummy_buf = NULL;
 }
 
 MODULE_AUTHOR("Paul Mackerras");
--- linux-2.6.14-rc4-orig/drivers/net/ni65.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/ni65.c	2005-10-12 15:55:01.000000000 +0200
@@ -696,8 +696,7 @@ static void ni65_free_buffer(struct priv
 		return;
 
 	for(i=0;i<TMDNUM;i++) {
-		if(p->tmdbounce[i])
-			kfree(p->tmdbounce[i]);
+		kfree(p->tmdbounce[i]);
 #ifdef XMT_VIA_SKB
 		if(p->tmd_skb[i])
 			dev_kfree_skb(p->tmd_skb[i]);
@@ -710,12 +709,10 @@ static void ni65_free_buffer(struct priv
 		if(p->recv_skb[i])
 			dev_kfree_skb(p->recv_skb[i]);
 #else
-		if(p->recvbounce[i])
-			kfree(p->recvbounce[i]);
+		kfree(p->recvbounce[i]);
 #endif
 	}
-	if(p->self)
-		kfree(p->self);
+	kfree(p->self);
 }
 
 
--- linux-2.6.14-rc4-orig/drivers/net/s2io.c	2005-10-11 22:41:11.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/s2io.c	2005-10-12 15:55:30.000000000 +0200
@@ -701,8 +701,7 @@ static void free_shared_mem(struct s2io_
 			}
 			kfree(mac_control->rings[i].ba[j]);
 		}
-		if (mac_control->rings[i].ba)
-			kfree(mac_control->rings[i].ba);
+		kfree(mac_control->rings[i].ba);
 	}
 #endif
 
--- linux-2.6.14-rc4-orig/drivers/net/wireless/atmel_cs.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/wireless/atmel_cs.c	2005-10-12 16:01:15.000000000 +0200
@@ -259,8 +259,7 @@ static void atmel_detach(dev_link_t *lin
 
 	/* Unlink device structure, free pieces */
 	*linkp = link->next;
-	if (link->priv)
-		kfree(link->priv);
+	kfree(link->priv);
 	kfree(link);
 }
 
--- linux-2.6.14-rc4-orig/drivers/net/wireless/airo_cs.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/wireless/airo_cs.c	2005-10-12 16:01:27.000000000 +0200
@@ -258,9 +258,7 @@ static void airo_detach(dev_link_t *link
 	
 	/* Unlink device structure, free pieces */
 	*linkp = link->next;
-	if (link->priv) {
-		kfree(link->priv);
-	}
+	kfree(link->priv);
 	kfree(link);
 	
 } /* airo_detach */
--- linux-2.6.14-rc4-orig/drivers/net/wireless/airo.c	2005-10-11 22:41:11.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/wireless/airo.c	2005-10-12 16:10:37.000000000 +0200
@@ -2387,14 +2387,10 @@ void stop_airo_card( struct net_device *
 			dev_kfree_skb(skb);
 	}
 
-	if (ai->flash)
-		kfree(ai->flash);
-	if (ai->rssi)
-		kfree(ai->rssi);
-	if (ai->APList)
-		kfree(ai->APList);
-	if (ai->SSID)
-		kfree(ai->SSID);
+	kfree(ai->flash);
+	kfree(ai->rssi);
+	kfree(ai->APList);
+	kfree(ai->SSID);
 	if (freeres) {
 		/* PCMCIA frees this stuff, so only for PCI and ISA */
 	        release_region( dev->base_addr, 64 );
@@ -3637,10 +3633,8 @@ static u16 setup_card(struct airo_info *
 	int rc;
 
 	memset( &mySsid, 0, sizeof( mySsid ) );
-	if (ai->flash) {
-		kfree (ai->flash);
-		ai->flash = NULL;
-	}
+	kfree (ai->flash);
+	ai->flash = NULL;
 
 	/* The NOP is the first step in getting the card going */
 	cmd.cmd = NOP;
@@ -3677,14 +3671,10 @@ static u16 setup_card(struct airo_info *
 		tdsRssiRid rssi_rid;
 		CapabilityRid cap_rid;
 
-		if (ai->APList) {
-			kfree(ai->APList);
-			ai->APList = NULL;
-		}
-		if (ai->SSID) {
-			kfree(ai->SSID);
-			ai->SSID = NULL;
-		}
+		kfree(ai->APList);
+		ai->APList = NULL;
+		kfree(ai->SSID);
+		ai->SSID = NULL;
 		// general configuration (read/modify/write)
 		status = readConfigRid(ai, lock);
 		if ( status != SUCCESS ) return ERROR;
@@ -3698,10 +3688,8 @@ static u16 setup_card(struct airo_info *
 				memcpy(ai->rssi, (u8*)&rssi_rid + 2, 512); /* Skip RID length member */
 		}
 		else {
-			if (ai->rssi) {
-				kfree(ai->rssi);
-				ai->rssi = NULL;
-			}
+			kfree(ai->rssi);
+			ai->rssi = NULL;
 			if (cap_rid.softCap & 8)
 				ai->config.rmode |= RXMODE_NORMALIZED_RSSI;
 			else
@@ -5380,11 +5368,13 @@ static int proc_BSSList_open( struct ino
 
 static int proc_close( struct inode *inode, struct file *file )
 {
-	struct proc_data *data = (struct proc_data *)file->private_data;
-	if ( data->on_close != NULL ) data->on_close( inode, file );
-	if ( data->rbuffer ) kfree( data->rbuffer );
-	if ( data->wbuffer ) kfree( data->wbuffer );
-	kfree( data );
+	struct proc_data *data = file->private_data;
+
+	if (data->on_close != NULL)
+		data->on_close(inode, file);
+	kfree(data->rbuffer);
+	kfree(data->wbuffer);
+	kfree(data);
 	return 0;
 }
 
--- linux-2.6.14-rc4-orig/drivers/net/wireless/strip.c	2005-10-11 22:41:12.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/wireless/strip.c	2005-10-12 16:11:41.000000000 +0200
@@ -860,12 +860,9 @@ static int allocate_buffers(struct strip
 		strip_info->mtu = dev->mtu = mtu;
 		return (1);
 	}
-	if (r)
-		kfree(r);
-	if (s)
-		kfree(s);
-	if (t)
-		kfree(t);
+	kfree(r);
+	kfree(s);
+	kfree(t);
 	return (0);
 }
 
@@ -922,13 +919,9 @@ static int strip_change_mtu(struct net_d
 	printk(KERN_NOTICE "%s: strip MTU changed fom %d to %d.\n",
 	       strip_info->dev->name, old_mtu, strip_info->mtu);
 
-	if (orbuff)
-		kfree(orbuff);
-	if (osbuff)
-		kfree(osbuff);
-	if (otbuff)
-		kfree(otbuff);
-
+	kfree(orbuff);
+	kfree(osbuff);
+	kfree(otbuff);
 	return 0;
 }
 
@@ -2498,18 +2491,13 @@ static int strip_close_low(struct net_de
 	/*
 	 * Free all STRIP frame buffers.
 	 */
-	if (strip_info->rx_buff) {
-		kfree(strip_info->rx_buff);
-		strip_info->rx_buff = NULL;
-	}
-	if (strip_info->sx_buff) {
-		kfree(strip_info->sx_buff);
-		strip_info->sx_buff = NULL;
-	}
-	if (strip_info->tx_buff) {
-		kfree(strip_info->tx_buff);
-		strip_info->tx_buff = NULL;
-	}
+	kfree(strip_info->rx_buff);
+	strip_info->rx_buff = NULL;
+	kfree(strip_info->sx_buff);
+	strip_info->sx_buff = NULL;
+	kfree(strip_info->tx_buff);
+	strip_info->tx_buff = NULL;
+
 	del_timer(&strip_info->idle_timer);
 	return 0;
 }
--- linux-2.6.14-rc4-orig/drivers/net/wireless/hostap/hostap_ioctl.c	2005-10-11 22:41:12.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/wireless/hostap/hostap_ioctl.c	2005-10-12 16:13:42.000000000 +0200
@@ -551,7 +551,6 @@ static int prism2_ioctl_giwaplist(struct
 
 	kfree(addr);
 	kfree(qual);
-
 	return 0;
 }
 
@@ -3088,9 +3087,7 @@ static int prism2_ioctl_priv_download(lo
 	ret = local->func->download(local, param);
 
  out:
-	if (param != NULL)
-		kfree(param);
-
+	kfree(param);
 	return ret;
 }
 #endif /* PRISM2_DOWNLOAD_SUPPORT */
@@ -3897,9 +3894,7 @@ static int prism2_ioctl_priv_hostapd(loc
 	}
 
  out:
-	if (param != NULL)
-		kfree(param);
-
+	kfree(param);
 	return ret;
 }
 
--- linux-2.6.14-rc4-orig/drivers/net/wireless/atmel.c	2005-10-11 22:41:11.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/wireless/atmel.c	2005-10-12 16:14:10.000000000 +0200
@@ -1653,8 +1653,7 @@ void stop_atmel_card(struct net_device *
 	unregister_netdev(dev);
 	remove_proc_entry("driver/atmel", NULL);
 	free_irq(dev->irq, dev);
-	if (priv->firmware)
-		kfree(priv->firmware);
+	kfree(priv->firmware);
 	if (freeres) {
 		/* PCMCIA frees this stuff, so only for PCI */
 	        release_region(dev->base_addr, 64);
@@ -2450,8 +2449,7 @@ static int atmel_ioctl(struct net_device
 			break;
 		}
 
-		if (priv->firmware)
-			kfree(priv->firmware);
+		kfree(priv->firmware);
 		
 		priv->firmware = new_firmware;
 		priv->firmware_length = com.len;
--- linux-2.6.14-rc4-orig/drivers/net/wireless/prism54/islpci_dev.c	2005-10-11 22:41:12.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/wireless/prism54/islpci_dev.c	2005-10-12 16:14:19.000000000 +0200
@@ -756,8 +756,7 @@ islpci_free_memory(islpci_private *priv)
 			pci_unmap_single(priv->pdev, buf->pci_addr,
 					 buf->size, PCI_DMA_FROMDEVICE);
 		buf->pci_addr = 0;
-		if (buf->mem)
-			kfree(buf->mem);
+		kfree(buf->mem);
 		buf->size = 0;
 		buf->mem = NULL;
         }
--- linux-2.6.14-rc4-orig/drivers/net/wireless/prism54/oid_mgt.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/wireless/prism54/oid_mgt.c	2005-10-12 16:15:05.000000000 +0200
@@ -268,11 +268,10 @@ mgt_clean(islpci_private *priv)
 
 	if (!priv->mib)
 		return;
-	for (i = 0; i < OID_NUM_LAST; i++)
-		if (priv->mib[i]) {
-			kfree(priv->mib[i]);
-			priv->mib[i] = NULL;
-		}
+	for (i = 0; i < OID_NUM_LAST; i++) {
+		kfree(priv->mib[i]);
+		priv->mib[i] = NULL;
+	}
 	kfree(priv->mib);
 	priv->mib = NULL;
 }
--- linux-2.6.14-rc4-orig/drivers/net/via-velocity.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/via-velocity.c	2005-10-12 16:16:00.000000000 +0200
@@ -1212,10 +1212,8 @@ static void velocity_free_td_ring(struct
 			velocity_free_td_ring_entry(vptr, j, i);
 
 		}
-		if (vptr->td_infos[j]) {
-			kfree(vptr->td_infos[j]);
-			vptr->td_infos[j] = NULL;
-		}
+		kfree(vptr->td_infos[j]);
+		vptr->td_infos[j] = NULL;
 	}
 }
 
--- linux-2.6.14-rc4-orig/drivers/net/rrunner.c	2005-10-11 22:41:11.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/rrunner.c	2005-10-12 16:16:19.000000000 +0200
@@ -1710,10 +1710,8 @@ static int rr_ioctl(struct net_device *d
 			error = -EFAULT;
 		}
 	wf_out:
-		if (oldimage)
-			kfree(oldimage);
-		if (image)
-			kfree(image);
+		kfree(oldimage);
+		kfree(image);
 		return error;
 		
 	case SIOCRRID:
--- linux-2.6.14-rc4-orig/drivers/net/ibmveth.c	2005-10-11 22:41:11.000000000 +0200
+++ linux-2.6.14-rc4/drivers/net/ibmveth.c	2005-10-12 16:17:22.000000000 +0200
@@ -293,10 +293,8 @@ static void ibmveth_free_buffer_pool(str
 {
 	int i;
 
-	if(pool->free_map) {
-		kfree(pool->free_map);
-		pool->free_map  = NULL;
-	}
+	kfree(pool->free_map);
+	pool->free_map = NULL;
 
 	if(pool->skbuff && pool->dma_addr) {
 		for(i = 0; i < pool->size; ++i) {
@@ -312,15 +310,10 @@ static void ibmveth_free_buffer_pool(str
 		}
 	}
 
-	if(pool->dma_addr) {
-		kfree(pool->dma_addr);
-		pool->dma_addr = NULL;
-	}
-
-	if(pool->skbuff) {
-		kfree(pool->skbuff);
-		pool->skbuff = NULL;
-	}
+	kfree(pool->dma_addr);
+	pool->dma_addr = NULL;
+	kfree(pool->skbuff);
+	pool->skbuff = NULL;
 }
 
 /* remove a buffer from a pool */
--- linux-2.6.14-rc4-orig/include/net/ax25.h	2005-10-11 22:41:32.000000000 +0200
+++ linux-2.6.14-rc4/include/net/ax25.h	2005-10-13 11:23:56.000000000 +0200
@@ -237,8 +237,7 @@ typedef struct ax25_cb {
 static __inline__ void ax25_cb_put(ax25_cb *ax25)
 {
 	if (atomic_dec_and_test(&ax25->refcount)) {
-		if (ax25->digipeat)
-			kfree(ax25->digipeat);
+		kfree(ax25->digipeat);
 		kfree(ax25);
 	}
 }
--- linux-2.6.14-rc4-orig/include/net/netrom.h	2005-10-11 22:41:32.000000000 +0200
+++ linux-2.6.14-rc4/include/net/netrom.h	2005-10-13 11:24:09.000000000 +0200
@@ -136,8 +136,7 @@ static __inline__ void nr_node_put(struc
 static __inline__ void nr_neigh_put(struct nr_neigh *nr_neigh)
 {
 	if (atomic_dec_and_test(&nr_neigh->refcount)) {
-		if (nr_neigh->digipeat != NULL)
-			kfree(nr_neigh->digipeat);
+		kfree(nr_neigh->digipeat);
 		kfree(nr_neigh);
 	}
 }


