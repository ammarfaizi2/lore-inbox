Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUEWKxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUEWKxX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 06:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUEWKxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 06:53:23 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:16362 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S262450AbUEWKu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 06:50:58 -0400
Date: Sun, 23 May 2004 12:50:13 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [2/4][PATCH 2.6] via-rhine: Rename some symbols
Message-ID: <20040523105012.GA10200@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <20040523104650.GA9979@k3.hellgate.ch>
X-Operating-System: Linux 2.6.6 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch renames symbols:
via_rhine_* -> rhine_*
struct netdev_private *np -> struct rhine_private *rp

--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-rhine-2.6.6-2-names.diff"

--- linux-2.6.6/drivers/net/via-rhine.c	2004-05-20 18:13:30.000000000 +0200
+++ linux-2.6.6-patch/drivers/net/via-rhine.c	2004-05-23 10:23:00.792437570 +0200
@@ -361,14 +361,14 @@ enum pci_flags_bit {
 	PCI_ADDR0=0x10<<0, PCI_ADDR1=0x10<<1, PCI_ADDR2=0x10<<2, PCI_ADDR3=0x10<<3,
 };
 
-enum via_rhine_chips {
+enum rhine_chips {
 	VT86C100A = 0,
 	VT6102,
 	VT6105,
 	VT6105M
 };
 
-struct via_rhine_chip_info {
+struct rhine_chip_info {
 	const char *name;
 	u16 pci_flags;
 	int io_size;
@@ -388,8 +388,8 @@ enum chip_capability_flags {
 /* Beware of PCI posted writes */
 #define IOSYNC	do { readb(dev->base_addr + StationAddr); } while (0)
 
-/* directly indexed by enum via_rhine_chips, above */
-static struct via_rhine_chip_info via_rhine_chip_info[] __devinitdata =
+/* directly indexed by enum rhine_chips, above */
+static struct rhine_chip_info rhine_chip_info[] __devinitdata =
 {
 	{ "VIA VT86C100A Rhine", RHINE_IOTYPE, 128,
 	  CanHaveMII | ReqTxAlign | HasDavicomPhy },
@@ -401,7 +401,7 @@ static struct via_rhine_chip_info via_rh
 	  CanHaveMII | HasWOL },
 };
 
-static struct pci_device_id via_rhine_pci_tbl[] =
+static struct pci_device_id rhine_pci_tbl[] =
 {
 	{0x1106, 0x3043, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT86C100A},
 	{0x1106, 0x3065, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT6102},
@@ -409,7 +409,7 @@ static struct pci_device_id via_rhine_pc
 	{0x1106, 0x3053, PCI_ANY_ID, PCI_ANY_ID, 0, 0, VT6105M},
 	{0,}			/* terminate list */
 };
-MODULE_DEVICE_TABLE(pci, via_rhine_pci_tbl);
+MODULE_DEVICE_TABLE(pci, rhine_pci_tbl);
 
 
 /* Offsets to the device registers. */
@@ -489,7 +489,7 @@ enum chip_cmd_bits {
 };
 
 #define MAX_MII_CNT	4
-struct netdev_private {
+struct rhine_private {
 	/* Descriptor rings */
 	struct rx_desc *rx_ring;
 	struct tx_desc *tx_ring;
@@ -535,30 +535,30 @@ struct netdev_private {
 
 static int  mdio_read(struct net_device *dev, int phy_id, int location);
 static void mdio_write(struct net_device *dev, int phy_id, int location, int value);
-static int  via_rhine_open(struct net_device *dev);
-static void via_rhine_check_duplex(struct net_device *dev);
-static void via_rhine_timer(unsigned long data);
-static void via_rhine_tx_timeout(struct net_device *dev);
-static int  via_rhine_start_tx(struct sk_buff *skb, struct net_device *dev);
-static irqreturn_t via_rhine_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
-static void via_rhine_tx(struct net_device *dev);
-static void via_rhine_rx(struct net_device *dev);
-static void via_rhine_error(struct net_device *dev, int intr_status);
-static void via_rhine_set_rx_mode(struct net_device *dev);
-static struct net_device_stats *via_rhine_get_stats(struct net_device *dev);
+static int  rhine_open(struct net_device *dev);
+static void rhine_check_duplex(struct net_device *dev);
+static void rhine_timer(unsigned long data);
+static void rhine_tx_timeout(struct net_device *dev);
+static int  rhine_start_tx(struct sk_buff *skb, struct net_device *dev);
+static irqreturn_t rhine_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
+static void rhine_tx(struct net_device *dev);
+static void rhine_rx(struct net_device *dev);
+static void rhine_error(struct net_device *dev, int intr_status);
+static void rhine_set_rx_mode(struct net_device *dev);
+static struct net_device_stats *rhine_get_stats(struct net_device *dev);
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static struct ethtool_ops netdev_ethtool_ops;
-static int  via_rhine_close(struct net_device *dev);
+static int  rhine_close(struct net_device *dev);
 
 static inline u32 get_intr_status(struct net_device *dev)
 {
 	long ioaddr = dev->base_addr;
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 	u32 intr_status;
 
 	intr_status = readw(ioaddr + IntrStatus);
 	/* On Rhine-II, Bit 3 indicates Tx descriptor write-back race. */
-	if (np->chip_id == VT6102)
+	if (rp->chip_id == VT6102)
 		intr_status |= readb(ioaddr + IntrStatus2) << 16;
 	return intr_status;
 }
@@ -616,19 +616,19 @@ static void __devinit reload_eeprom(long
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
-static void via_rhine_poll(struct net_device *dev)
+static void rhine_poll(struct net_device *dev)
 {
 	disable_irq(dev->irq);
-	via_rhine_interrupt(dev->irq, (void *)dev, NULL);
+	rhine_interrupt(dev->irq, (void *)dev, NULL);
 	enable_irq(dev->irq);
 }
 #endif
 
-static int __devinit via_rhine_init_one (struct pci_dev *pdev,
+static int __devinit rhine_init_one (struct pci_dev *pdev,
 					 const struct pci_device_id *ent)
 {
 	struct net_device *dev;
-	struct netdev_private *np;
+	struct rhine_private *rp;
 	int i, option;
 	int chip_id = (int) ent->driver_data;
 	static int card_idx = -1;
@@ -649,8 +649,8 @@ static int __devinit via_rhine_init_one 
 
 	card_idx++;
 	option = card_idx < MAX_UNITS ? options[card_idx] : 0;
-	io_size = via_rhine_chip_info[chip_id].io_size;
-	pci_flags = via_rhine_chip_info[chip_id].pci_flags;
+	io_size = rhine_chip_info[chip_id].io_size;
+	pci_flags = rhine_chip_info[chip_id].pci_flags;
 
 	if (pci_enable_device (pdev))
 		goto err_out;
@@ -674,7 +674,7 @@ static int __devinit via_rhine_init_one 
 	if (pci_flags & PCI_USES_MASTER)
 		pci_set_master (pdev);
 
-	dev = alloc_etherdev(sizeof(*np));
+	dev = alloc_etherdev(sizeof(*rp));
 	if (dev == NULL) {
 		printk (KERN_ERR "init_ethernet failed for card #%d\n", card_idx);
 		goto err_out;
@@ -711,7 +711,7 @@ static int __devinit via_rhine_init_one 
 #endif
 
 	/* D-Link provided reset code (with comment additions) */
-	if (via_rhine_chip_info[chip_id].drv_flags & HasWOL) {
+	if (rhine_chip_info[chip_id].drv_flags & HasWOL) {
 		unsigned char byOrgValue;
 
 		/* clear sticky bit before reset & read ethernet address */
@@ -769,34 +769,34 @@ static int __devinit via_rhine_init_one 
 
 	dev->irq = pdev->irq;
 
-	np = dev->priv;
-	spin_lock_init (&np->lock);
-	np->chip_id = chip_id;
-	np->drv_flags = via_rhine_chip_info[chip_id].drv_flags;
-	np->pdev = pdev;
-	np->mii_if.dev = dev;
-	np->mii_if.mdio_read = mdio_read;
-	np->mii_if.mdio_write = mdio_write;
-	np->mii_if.phy_id_mask = 0x1f;
-	np->mii_if.reg_num_mask = 0x1f;
+	rp = dev->priv;
+	spin_lock_init (&rp->lock);
+	rp->chip_id = chip_id;
+	rp->drv_flags = rhine_chip_info[chip_id].drv_flags;
+	rp->pdev = pdev;
+	rp->mii_if.dev = dev;
+	rp->mii_if.mdio_read = mdio_read;
+	rp->mii_if.mdio_write = mdio_write;
+	rp->mii_if.phy_id_mask = 0x1f;
+	rp->mii_if.reg_num_mask = 0x1f;
 
 	if (dev->mem_start)
 		option = dev->mem_start;
 
 	/* The chip-specific entries in the device structure. */
-	dev->open = via_rhine_open;
-	dev->hard_start_xmit = via_rhine_start_tx;
-	dev->stop = via_rhine_close;
-	dev->get_stats = via_rhine_get_stats;
-	dev->set_multicast_list = via_rhine_set_rx_mode;
+	dev->open = rhine_open;
+	dev->hard_start_xmit = rhine_start_tx;
+	dev->stop = rhine_close;
+	dev->get_stats = rhine_get_stats;
+	dev->set_multicast_list = rhine_set_rx_mode;
 	dev->do_ioctl = netdev_ioctl;
 	dev->ethtool_ops = &netdev_ethtool_ops;
-	dev->tx_timeout = via_rhine_tx_timeout;
+	dev->tx_timeout = rhine_tx_timeout;
 	dev->watchdog_timeo = TX_TIMEOUT;
 #ifdef CONFIG_NET_POLL_CONTROLLER
-	dev->poll_controller = via_rhine_poll;
+	dev->poll_controller = rhine_poll;
 #endif
-	if (np->drv_flags & ReqTxAlign)
+	if (rp->drv_flags & ReqTxAlign)
 		dev->features |= NETIF_F_SG|NETIF_F_HW_CSUM;
 
 	/* dev->name not defined before register_netdev()! */
@@ -807,20 +807,20 @@ static int __devinit via_rhine_init_one 
 	/* The lower four bits are the media type. */
 	if (option > 0) {
 		if (option & 0x220)
-			np->mii_if.full_duplex = 1;
-		np->default_port = option & 15;
+			rp->mii_if.full_duplex = 1;
+		rp->default_port = option & 15;
 	}
 	if (card_idx < MAX_UNITS  &&  full_duplex[card_idx] > 0)
-		np->mii_if.full_duplex = 1;
+		rp->mii_if.full_duplex = 1;
 
-	if (np->mii_if.full_duplex) {
+	if (rp->mii_if.full_duplex) {
 		printk(KERN_INFO "%s: Set to forced full duplex, autonegotiation"
 			   " disabled.\n", dev->name);
-		np->mii_if.force_media = 1;
+		rp->mii_if.force_media = 1;
 	}
 
 	printk(KERN_INFO "%s: %s at 0x%lx, ",
-		   dev->name, via_rhine_chip_info[chip_id].name,
+		   dev->name, rhine_chip_info[chip_id].name,
 		   (pci_flags & PCI_USES_IO) ? ioaddr : memaddr);
 
 	for (i = 0; i < 5; i++)
@@ -829,17 +829,17 @@ static int __devinit via_rhine_init_one 
 
 	pci_set_drvdata(pdev, dev);
 
-	if (np->drv_flags & CanHaveMII) {
+	if (rp->drv_flags & CanHaveMII) {
 		int phy, phy_idx = 0;
-		np->phys[0] = 1;		/* Standard for this chip. */
+		rp->phys[0] = 1;		/* Standard for this chip. */
 		for (phy = 1; phy < 32 && phy_idx < MAX_MII_CNT; phy++) {
 			int mii_status = mdio_read(dev, phy, 1);
 			if (mii_status != 0xffff  &&  mii_status != 0x0000) {
-				np->phys[phy_idx++] = phy;
-				np->mii_if.advertising = mdio_read(dev, phy, 4);
+				rp->phys[phy_idx++] = phy;
+				rp->mii_if.advertising = mdio_read(dev, phy, 4);
 				printk(KERN_INFO "%s: MII PHY found at address %d, status "
 					   "0x%4.4x advertising %4.4x Link %4.4x.\n",
-					   dev->name, phy, mii_status, np->mii_if.advertising,
+					   dev->name, phy, mii_status, rp->mii_if.advertising,
 					   mdio_read(dev, phy, 5));
 
 				/* set IFF_RUNNING */
@@ -851,23 +851,23 @@ static int __devinit via_rhine_init_one 
 				break;
 			}
 		}
-		np->mii_cnt = phy_idx;
-		np->mii_if.phy_id = np->phys[0];
+		rp->mii_cnt = phy_idx;
+		rp->mii_if.phy_id = rp->phys[0];
 	}
 
 	/* Allow forcing the media type. */
 	if (option > 0) {
 		if (option & 0x220)
-			np->mii_if.full_duplex = 1;
-		np->default_port = option & 0x3ff;
+			rp->mii_if.full_duplex = 1;
+		rp->default_port = option & 0x3ff;
 		if (option & 0x330) {
 			/* FIXME: shouldn't someone check this variable? */
-			/* np->medialock = 1; */
+			/* rp->medialock = 1; */
 			printk(KERN_INFO "  Forcing %dMbs %s-duplex operation.\n",
 				   (option & 0x300 ? 100 : 10),
 				   (option & 0x220 ? "full" : "half"));
-			if (np->mii_cnt)
-				mdio_write(dev, np->phys[0], MII_BMCR,
+			if (rp->mii_cnt)
+				mdio_write(dev, rp->phys[0], MII_BMCR,
 						   ((option & 0x300) ? 0x2000 : 0) |  /* 100mbps? */
 						   ((option & 0x220) ? 0x0100 : 0));  /* Full duplex? */
 		}
@@ -889,11 +889,11 @@ err_out:
 
 static int alloc_ring(struct net_device* dev)
 {
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 	void *ring;
 	dma_addr_t ring_dma;
 
-	ring = pci_alloc_consistent(np->pdev,
+	ring = pci_alloc_consistent(rp->pdev,
 				    RX_RING_SIZE * sizeof(struct rx_desc) +
 				    TX_RING_SIZE * sizeof(struct tx_desc),
 				    &ring_dma);
@@ -901,11 +901,11 @@ static int alloc_ring(struct net_device*
 		printk(KERN_ERR "Could not allocate DMA memory.\n");
 		return -ENOMEM;
 	}
-	if (np->drv_flags & ReqTxAlign) {
-		np->tx_bufs = pci_alloc_consistent(np->pdev, PKT_BUF_SZ * TX_RING_SIZE,
-								   &np->tx_bufs_dma);
-		if (np->tx_bufs == NULL) {
-			pci_free_consistent(np->pdev,
+	if (rp->drv_flags & ReqTxAlign) {
+		rp->tx_bufs = pci_alloc_consistent(rp->pdev, PKT_BUF_SZ * TX_RING_SIZE,
+								   &rp->tx_bufs_dma);
+		if (rp->tx_bufs == NULL) {
+			pci_free_consistent(rp->pdev,
 				    RX_RING_SIZE * sizeof(struct rx_desc) +
 				    TX_RING_SIZE * sizeof(struct tx_desc),
 				    ring, ring_dma);
@@ -913,137 +913,137 @@ static int alloc_ring(struct net_device*
 		}
 	}
 
-	np->rx_ring = ring;
-	np->tx_ring = ring + RX_RING_SIZE * sizeof(struct rx_desc);
-	np->rx_ring_dma = ring_dma;
-	np->tx_ring_dma = ring_dma + RX_RING_SIZE * sizeof(struct rx_desc);
+	rp->rx_ring = ring;
+	rp->tx_ring = ring + RX_RING_SIZE * sizeof(struct rx_desc);
+	rp->rx_ring_dma = ring_dma;
+	rp->tx_ring_dma = ring_dma + RX_RING_SIZE * sizeof(struct rx_desc);
 
 	return 0;
 }
 
 void free_ring(struct net_device* dev)
 {
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 
-	pci_free_consistent(np->pdev,
+	pci_free_consistent(rp->pdev,
 			    RX_RING_SIZE * sizeof(struct rx_desc) +
 			    TX_RING_SIZE * sizeof(struct tx_desc),
-			    np->rx_ring, np->rx_ring_dma);
-	np->tx_ring = NULL;
+			    rp->rx_ring, rp->rx_ring_dma);
+	rp->tx_ring = NULL;
 
-	if (np->tx_bufs)
-		pci_free_consistent(np->pdev, PKT_BUF_SZ * TX_RING_SIZE,
-							np->tx_bufs, np->tx_bufs_dma);
+	if (rp->tx_bufs)
+		pci_free_consistent(rp->pdev, PKT_BUF_SZ * TX_RING_SIZE,
+							rp->tx_bufs, rp->tx_bufs_dma);
 
-	np->tx_bufs = NULL;
+	rp->tx_bufs = NULL;
 
 }
 
 static void alloc_rbufs(struct net_device *dev)
 {
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 	dma_addr_t next;
 	int i;
 
-	np->dirty_rx = np->cur_rx = 0;
+	rp->dirty_rx = rp->cur_rx = 0;
 
-	np->rx_buf_sz = (dev->mtu <= 1500 ? PKT_BUF_SZ : dev->mtu + 32);
-	np->rx_head_desc = &np->rx_ring[0];
-	next = np->rx_ring_dma;
+	rp->rx_buf_sz = (dev->mtu <= 1500 ? PKT_BUF_SZ : dev->mtu + 32);
+	rp->rx_head_desc = &rp->rx_ring[0];
+	next = rp->rx_ring_dma;
 
 	/* Init the ring entries */
 	for (i = 0; i < RX_RING_SIZE; i++) {
-		np->rx_ring[i].rx_status = 0;
-		np->rx_ring[i].desc_length = cpu_to_le32(np->rx_buf_sz);
+		rp->rx_ring[i].rx_status = 0;
+		rp->rx_ring[i].desc_length = cpu_to_le32(rp->rx_buf_sz);
 		next += sizeof(struct rx_desc);
-		np->rx_ring[i].next_desc = cpu_to_le32(next);
-		np->rx_skbuff[i] = 0;
+		rp->rx_ring[i].next_desc = cpu_to_le32(next);
+		rp->rx_skbuff[i] = 0;
 	}
 	/* Mark the last entry as wrapping the ring. */
-	np->rx_ring[i-1].next_desc = cpu_to_le32(np->rx_ring_dma);
+	rp->rx_ring[i-1].next_desc = cpu_to_le32(rp->rx_ring_dma);
 
 	/* Fill in the Rx buffers.  Handle allocation failure gracefully. */
 	for (i = 0; i < RX_RING_SIZE; i++) {
-		struct sk_buff *skb = dev_alloc_skb(np->rx_buf_sz);
-		np->rx_skbuff[i] = skb;
+		struct sk_buff *skb = dev_alloc_skb(rp->rx_buf_sz);
+		rp->rx_skbuff[i] = skb;
 		if (skb == NULL)
 			break;
 		skb->dev = dev;                 /* Mark as being used by this device. */
 
-		np->rx_skbuff_dma[i] =
-			pci_map_single(np->pdev, skb->tail, np->rx_buf_sz,
+		rp->rx_skbuff_dma[i] =
+			pci_map_single(rp->pdev, skb->tail, rp->rx_buf_sz,
 						   PCI_DMA_FROMDEVICE);
 
-		np->rx_ring[i].addr = cpu_to_le32(np->rx_skbuff_dma[i]);
-		np->rx_ring[i].rx_status = cpu_to_le32(DescOwn);
+		rp->rx_ring[i].addr = cpu_to_le32(rp->rx_skbuff_dma[i]);
+		rp->rx_ring[i].rx_status = cpu_to_le32(DescOwn);
 	}
-	np->dirty_rx = (unsigned int)(i - RX_RING_SIZE);
+	rp->dirty_rx = (unsigned int)(i - RX_RING_SIZE);
 }
 
 static void free_rbufs(struct net_device* dev)
 {
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 	int i;
 
 	/* Free all the skbuffs in the Rx queue. */
 	for (i = 0; i < RX_RING_SIZE; i++) {
-		np->rx_ring[i].rx_status = 0;
-		np->rx_ring[i].addr = cpu_to_le32(0xBADF00D0); /* An invalid address. */
-		if (np->rx_skbuff[i]) {
-			pci_unmap_single(np->pdev,
-							 np->rx_skbuff_dma[i],
-							 np->rx_buf_sz, PCI_DMA_FROMDEVICE);
-			dev_kfree_skb(np->rx_skbuff[i]);
+		rp->rx_ring[i].rx_status = 0;
+		rp->rx_ring[i].addr = cpu_to_le32(0xBADF00D0); /* An invalid address. */
+		if (rp->rx_skbuff[i]) {
+			pci_unmap_single(rp->pdev,
+							 rp->rx_skbuff_dma[i],
+							 rp->rx_buf_sz, PCI_DMA_FROMDEVICE);
+			dev_kfree_skb(rp->rx_skbuff[i]);
 		}
-		np->rx_skbuff[i] = 0;
+		rp->rx_skbuff[i] = 0;
 	}
 }
 
 static void alloc_tbufs(struct net_device* dev)
 {
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 	dma_addr_t next;
 	int i;
 
-	np->dirty_tx = np->cur_tx = 0;
-	next = np->tx_ring_dma;
+	rp->dirty_tx = rp->cur_tx = 0;
+	next = rp->tx_ring_dma;
 	for (i = 0; i < TX_RING_SIZE; i++) {
-		np->tx_skbuff[i] = 0;
-		np->tx_ring[i].tx_status = 0;
-		np->tx_ring[i].desc_length = cpu_to_le32(TXDESC);
+		rp->tx_skbuff[i] = 0;
+		rp->tx_ring[i].tx_status = 0;
+		rp->tx_ring[i].desc_length = cpu_to_le32(TXDESC);
 		next += sizeof(struct tx_desc);
-		np->tx_ring[i].next_desc = cpu_to_le32(next);
-		np->tx_buf[i] = &np->tx_bufs[i * PKT_BUF_SZ];
+		rp->tx_ring[i].next_desc = cpu_to_le32(next);
+		rp->tx_buf[i] = &rp->tx_bufs[i * PKT_BUF_SZ];
 	}
-	np->tx_ring[i-1].next_desc = cpu_to_le32(np->tx_ring_dma);
+	rp->tx_ring[i-1].next_desc = cpu_to_le32(rp->tx_ring_dma);
 
 }
 
 static void free_tbufs(struct net_device* dev)
 {
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 	int i;
 
 	for (i = 0; i < TX_RING_SIZE; i++) {
-		np->tx_ring[i].tx_status = 0;
-		np->tx_ring[i].desc_length = cpu_to_le32(TXDESC);
-		np->tx_ring[i].addr = cpu_to_le32(0xBADF00D0); /* An invalid address. */
-		if (np->tx_skbuff[i]) {
-			if (np->tx_skbuff_dma[i]) {
-				pci_unmap_single(np->pdev,
-								 np->tx_skbuff_dma[i],
-								 np->tx_skbuff[i]->len, PCI_DMA_TODEVICE);
+		rp->tx_ring[i].tx_status = 0;
+		rp->tx_ring[i].desc_length = cpu_to_le32(TXDESC);
+		rp->tx_ring[i].addr = cpu_to_le32(0xBADF00D0); /* An invalid address. */
+		if (rp->tx_skbuff[i]) {
+			if (rp->tx_skbuff_dma[i]) {
+				pci_unmap_single(rp->pdev,
+								 rp->tx_skbuff_dma[i],
+								 rp->tx_skbuff[i]->len, PCI_DMA_TODEVICE);
 			}
-			dev_kfree_skb(np->tx_skbuff[i]);
+			dev_kfree_skb(rp->tx_skbuff[i]);
 		}
-		np->tx_skbuff[i] = 0;
-		np->tx_buf[i] = 0;
+		rp->tx_skbuff[i] = 0;
+		rp->tx_buf[i] = 0;
 	}
 }
 
 static void init_registers(struct net_device *dev)
 {
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 	long ioaddr = dev->base_addr;
 	int i;
 
@@ -1054,17 +1054,17 @@ static void init_registers(struct net_de
 	writew(0x0006, ioaddr + PCIBusConfig);	/* Tune configuration??? */
 	/* Configure initial FIFO thresholds. */
 	writeb(0x20, ioaddr + TxConfig);
-	np->tx_thresh = 0x20;
-	np->rx_thresh = 0x60;			/* Written in via_rhine_set_rx_mode(). */
-	np->mii_if.full_duplex = 0;
+	rp->tx_thresh = 0x20;
+	rp->rx_thresh = 0x60;			/* Written in rhine_set_rx_mode(). */
+	rp->mii_if.full_duplex = 0;
 
 	if (dev->if_port == 0)
-		dev->if_port = np->default_port;
+		dev->if_port = rp->default_port;
 
-	writel(np->rx_ring_dma, ioaddr + RxRingPtr);
-	writel(np->tx_ring_dma, ioaddr + TxRingPtr);
+	writel(rp->rx_ring_dma, ioaddr + RxRingPtr);
+	writel(rp->tx_ring_dma, ioaddr + TxRingPtr);
 
-	via_rhine_set_rx_mode(dev);
+	rhine_set_rx_mode(dev);
 
 	/* Enable interrupts by setting the interrupt mask. */
 	writew(IntrRxDone | IntrRxErr | IntrRxEmpty| IntrRxOverflow |
@@ -1073,18 +1073,18 @@ static void init_registers(struct net_de
 		   IntrPCIErr | IntrStatsMax | IntrLinkChange,
 		   ioaddr + IntrEnable);
 
-	np->chip_cmd = CmdStart|CmdTxOn|CmdRxOn|CmdNoTxPoll;
-	if (np->mii_if.force_media)
-		np->chip_cmd |= CmdFDuplex;
-	writew(np->chip_cmd, ioaddr + ChipCmd);
+	rp->chip_cmd = CmdStart|CmdTxOn|CmdRxOn|CmdNoTxPoll;
+	if (rp->mii_if.force_media)
+		rp->chip_cmd |= CmdFDuplex;
+	writew(rp->chip_cmd, ioaddr + ChipCmd);
 
-	via_rhine_check_duplex(dev);
+	rhine_check_duplex(dev);
 
 	/* The LED outputs of various MII xcvrs should be configured.  */
 	/* For NS or Mison phys, turn on bit 1 in register 0x17 */
 	/* For ESI phys, turn on bit 7 in register 0x17. */
-	mdio_write(dev, np->phys[0], 0x17, mdio_read(dev, np->phys[0], 0x17) |
-			   (np->drv_flags & HasESIPhy) ? 0x0080 : 0x0001);
+	mdio_write(dev, rp->phys[0], 0x17, mdio_read(dev, rp->phys[0], 0x17) |
+			   (rp->drv_flags & HasESIPhy) ? 0x0080 : 0x0001);
 }
 /* Read and write over the MII Management Data I/O (MDIO) interface. */
 
@@ -1108,20 +1108,20 @@ static int mdio_read(struct net_device *
 
 static void mdio_write(struct net_device *dev, int phy_id, int regnum, int value)
 {
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 	long ioaddr = dev->base_addr;
 	int boguscnt = 1024;
 
-	if (phy_id == np->phys[0]) {
+	if (phy_id == rp->phys[0]) {
 		switch (regnum) {
 		case MII_BMCR:					/* Is user forcing speed/duplex? */
 			if (value & 0x9000)			/* Autonegotiation. */
-				np->mii_if.force_media = 0;
+				rp->mii_if.force_media = 0;
 			else
-				np->mii_if.full_duplex = (value & 0x0100) ? 1 : 0;
+				rp->mii_if.full_duplex = (value & 0x0100) ? 1 : 0;
 			break;
 		case MII_ADVERTISE:
-			np->mii_if.advertising = value;
+			rp->mii_if.advertising = value;
 			break;
 		}
 	}
@@ -1137,78 +1137,78 @@ static void mdio_write(struct net_device
 }
 
 
-static int via_rhine_open(struct net_device *dev)
+static int rhine_open(struct net_device *dev)
 {
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 	long ioaddr = dev->base_addr;
 	int i;
 
 	/* Reset the chip. */
 	writew(CmdReset, ioaddr + ChipCmd);
 
-	i = request_irq(np->pdev->irq, &via_rhine_interrupt, SA_SHIRQ, dev->name, dev);
+	i = request_irq(rp->pdev->irq, &rhine_interrupt, SA_SHIRQ, dev->name, dev);
 	if (i)
 		return i;
 
 	if (debug > 1)
-		printk(KERN_DEBUG "%s: via_rhine_open() irq %d.\n",
-			   dev->name, np->pdev->irq);
+		printk(KERN_DEBUG "%s: rhine_open() irq %d.\n",
+			   dev->name, rp->pdev->irq);
 
 	i = alloc_ring(dev);
 	if (i)
 		return i;
 	alloc_rbufs(dev);
 	alloc_tbufs(dev);
-	wait_for_reset(dev, np->chip_id, dev->name);
+	wait_for_reset(dev, rp->chip_id, dev->name);
 	init_registers(dev);
 	if (debug > 2)
-		printk(KERN_DEBUG "%s: Done via_rhine_open(), status %4.4x "
+		printk(KERN_DEBUG "%s: Done rhine_open(), status %4.4x "
 			   "MII status: %4.4x.\n",
 			   dev->name, readw(ioaddr + ChipCmd),
-			   mdio_read(dev, np->phys[0], MII_BMSR));
+			   mdio_read(dev, rp->phys[0], MII_BMSR));
 
 	netif_start_queue(dev);
 
 	/* Set the timer to check for link beat. */
-	init_timer(&np->timer);
-	np->timer.expires = jiffies + 2 * HZ/100;
-	np->timer.data = (unsigned long)dev;
-	np->timer.function = &via_rhine_timer;				/* timer handler */
-	add_timer(&np->timer);
+	init_timer(&rp->timer);
+	rp->timer.expires = jiffies + 2 * HZ/100;
+	rp->timer.data = (unsigned long)dev;
+	rp->timer.function = &rhine_timer;				/* timer handler */
+	add_timer(&rp->timer);
 
 	return 0;
 }
 
-static void via_rhine_check_duplex(struct net_device *dev)
+static void rhine_check_duplex(struct net_device *dev)
 {
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 	long ioaddr = dev->base_addr;
-	int mii_lpa = mdio_read(dev, np->phys[0], MII_LPA);
-	int negotiated = mii_lpa & np->mii_if.advertising;
+	int mii_lpa = mdio_read(dev, rp->phys[0], MII_LPA);
+	int negotiated = mii_lpa & rp->mii_if.advertising;
 	int duplex;
 
-	if (np->mii_if.force_media  ||  mii_lpa == 0xffff)
+	if (rp->mii_if.force_media  ||  mii_lpa == 0xffff)
 		return;
 	duplex = (negotiated & 0x0100) || (negotiated & 0x01C0) == 0x0040;
-	if (np->mii_if.full_duplex != duplex) {
-		np->mii_if.full_duplex = duplex;
+	if (rp->mii_if.full_duplex != duplex) {
+		rp->mii_if.full_duplex = duplex;
 		if (debug)
 			printk(KERN_INFO "%s: Setting %s-duplex based on MII #%d link"
 				   " partner capability of %4.4x.\n", dev->name,
-				   duplex ? "full" : "half", np->phys[0], mii_lpa);
+				   duplex ? "full" : "half", rp->phys[0], mii_lpa);
 		if (duplex)
-			np->chip_cmd |= CmdFDuplex;
+			rp->chip_cmd |= CmdFDuplex;
 		else
-			np->chip_cmd &= ~CmdFDuplex;
-		writew(np->chip_cmd, ioaddr + ChipCmd);
+			rp->chip_cmd &= ~CmdFDuplex;
+		writew(rp->chip_cmd, ioaddr + ChipCmd);
 	}
 }
 
 
-static void via_rhine_timer(unsigned long data)
+static void rhine_timer(unsigned long data)
 {
 	struct net_device *dev = (struct net_device *)data;
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 	long ioaddr = dev->base_addr;
 	int next_tick = 10*HZ;
 	int mii_status;
@@ -1218,43 +1218,43 @@ static void via_rhine_timer(unsigned lon
 			   dev->name, readw(ioaddr + IntrStatus));
 	}
 
-	spin_lock_irq (&np->lock);
+	spin_lock_irq (&rp->lock);
 
-	via_rhine_check_duplex(dev);
+	rhine_check_duplex(dev);
 
 	/* make IFF_RUNNING follow the MII status bit "Link established" */
-	mii_status = mdio_read(dev, np->phys[0], MII_BMSR);
-	if ( (mii_status & BMSR_LSTATUS) != (np->mii_status & BMSR_LSTATUS) ) {
+	mii_status = mdio_read(dev, rp->phys[0], MII_BMSR);
+	if ( (mii_status & BMSR_LSTATUS) != (rp->mii_status & BMSR_LSTATUS) ) {
 		if (mii_status & BMSR_LSTATUS)
 			netif_carrier_on(dev);
 		else
 			netif_carrier_off(dev);
 	}
-	np->mii_status = mii_status;
+	rp->mii_status = mii_status;
 
-	spin_unlock_irq (&np->lock);
+	spin_unlock_irq (&rp->lock);
 
-	np->timer.expires = jiffies + next_tick;
-	add_timer(&np->timer);
+	rp->timer.expires = jiffies + next_tick;
+	add_timer(&rp->timer);
 }
 
 
-static void via_rhine_tx_timeout (struct net_device *dev)
+static void rhine_tx_timeout (struct net_device *dev)
 {
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 	long ioaddr = dev->base_addr;
 
 	printk (KERN_WARNING "%s: Transmit timed out, status %4.4x, PHY status "
 		"%4.4x, resetting...\n",
 		dev->name, readw (ioaddr + IntrStatus),
-		mdio_read (dev, np->phys[0], MII_BMSR));
+		mdio_read (dev, rp->phys[0], MII_BMSR));
 
 	dev->if_port = 0;
 
 	/* protect against concurrent rx interrupts */
-	disable_irq(np->pdev->irq);
+	disable_irq(rp->pdev->irq);
 
-	spin_lock(&np->lock);
+	spin_lock(&rp->lock);
 
 	/* Reset the chip. */
 	writew(CmdReset, ioaddr + ChipCmd);
@@ -1266,20 +1266,20 @@ static void via_rhine_tx_timeout (struct
 	alloc_rbufs(dev);
 
 	/* Reinitialize the hardware. */
-	wait_for_reset(dev, np->chip_id, dev->name);
+	wait_for_reset(dev, rp->chip_id, dev->name);
 	init_registers(dev);
 
-	spin_unlock(&np->lock);
-	enable_irq(np->pdev->irq);
+	spin_unlock(&rp->lock);
+	enable_irq(rp->pdev->irq);
 
 	dev->trans_start = jiffies;
-	np->stats.tx_errors++;
+	rp->stats.tx_errors++;
 	netif_wake_queue(dev);
 }
 
-static int via_rhine_start_tx(struct sk_buff *skb, struct net_device *dev)
+static int rhine_start_tx(struct sk_buff *skb, struct net_device *dev)
 {
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 	unsigned entry;
 	u32 intr_status;
 
@@ -1287,7 +1287,7 @@ static int via_rhine_start_tx(struct sk_
 	   with the "ownership" bits last. */
 
 	/* Calculate the next Tx descriptor entry. */
-	entry = np->cur_tx % TX_RING_SIZE;
+	entry = rp->cur_tx % TX_RING_SIZE;
 
 	if (skb->len < ETH_ZLEN) {
 		skb = skb_padto(skb, ETH_ZLEN);
@@ -1295,39 +1295,39 @@ static int via_rhine_start_tx(struct sk_
 			return 0;
 	}
 
-	np->tx_skbuff[entry] = skb;
+	rp->tx_skbuff[entry] = skb;
 
-	if ((np->drv_flags & ReqTxAlign) &&
+	if ((rp->drv_flags & ReqTxAlign) &&
 		(((long)skb->data & 3) || skb_shinfo(skb)->nr_frags != 0 || skb->ip_summed == CHECKSUM_HW)
 		) {
 		/* Must use alignment buffer. */
 		if (skb->len > PKT_BUF_SZ) {
 			/* packet too long, drop it */
 			dev_kfree_skb(skb);
-			np->tx_skbuff[entry] = NULL;
-			np->stats.tx_dropped++;
+			rp->tx_skbuff[entry] = NULL;
+			rp->stats.tx_dropped++;
 			return 0;
 		}
-		skb_copy_and_csum_dev(skb, np->tx_buf[entry]);
-		np->tx_skbuff_dma[entry] = 0;
-		np->tx_ring[entry].addr = cpu_to_le32(np->tx_bufs_dma +
-										  (np->tx_buf[entry] - np->tx_bufs));
+		skb_copy_and_csum_dev(skb, rp->tx_buf[entry]);
+		rp->tx_skbuff_dma[entry] = 0;
+		rp->tx_ring[entry].addr = cpu_to_le32(rp->tx_bufs_dma +
+										  (rp->tx_buf[entry] - rp->tx_bufs));
 	} else {
-		np->tx_skbuff_dma[entry] =
-			pci_map_single(np->pdev, skb->data, skb->len, PCI_DMA_TODEVICE);
-		np->tx_ring[entry].addr = cpu_to_le32(np->tx_skbuff_dma[entry]);
+		rp->tx_skbuff_dma[entry] =
+			pci_map_single(rp->pdev, skb->data, skb->len, PCI_DMA_TODEVICE);
+		rp->tx_ring[entry].addr = cpu_to_le32(rp->tx_skbuff_dma[entry]);
 	}
 
-	np->tx_ring[entry].desc_length =
+	rp->tx_ring[entry].desc_length =
 		cpu_to_le32(TXDESC | (skb->len >= ETH_ZLEN ? skb->len : ETH_ZLEN));
 
 	/* lock eth irq */
-	spin_lock_irq (&np->lock);
+	spin_lock_irq (&rp->lock);
 	wmb();
-	np->tx_ring[entry].tx_status = cpu_to_le32(DescOwn);
+	rp->tx_ring[entry].tx_status = cpu_to_le32(DescOwn);
 	wmb();
 
-	np->cur_tx++;
+	rp->cur_tx++;
 
 	/* Non-x86 Todo: explicitly flush cache lines here. */
 
@@ -1337,27 +1337,27 @@ static int via_rhine_start_tx(struct sk_
 	 */
 	intr_status = get_intr_status(dev);
 	if ((intr_status & IntrTxErrSummary) == 0) {
-		writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
+		writew(CmdTxDemand | rp->chip_cmd, dev->base_addr + ChipCmd);
 	}
 	IOSYNC;
 
-	if (np->cur_tx == np->dirty_tx + TX_QUEUE_LEN)
+	if (rp->cur_tx == rp->dirty_tx + TX_QUEUE_LEN)
 		netif_stop_queue(dev);
 
 	dev->trans_start = jiffies;
 
-	spin_unlock_irq (&np->lock);
+	spin_unlock_irq (&rp->lock);
 
 	if (debug > 4) {
 		printk(KERN_DEBUG "%s: Transmit frame #%d queued in slot %d.\n",
-			   dev->name, np->cur_tx-1, entry);
+			   dev->name, rp->cur_tx-1, entry);
 	}
 	return 0;
 }
 
 /* The interrupt handler does all of the Rx thread work and cleans up
    after the Tx thread. */
-static irqreturn_t via_rhine_interrupt(int irq, void *dev_instance, struct pt_regs *rgs)
+static irqreturn_t rhine_interrupt(int irq, void *dev_instance, struct pt_regs *rgs)
 {
 	struct net_device *dev = dev_instance;
 	long ioaddr;
@@ -1382,7 +1382,7 @@ static irqreturn_t via_rhine_interrupt(i
 
 		if (intr_status & (IntrRxDone | IntrRxErr | IntrRxDropped |
 						   IntrRxWakeUp | IntrRxEmpty | IntrRxNoBuf))
-			via_rhine_rx(dev);
+			rhine_rx(dev);
 
 		if (intr_status & (IntrTxErrSummary | IntrTxDone)) {
 			if (intr_status & IntrTxErrSummary) {
@@ -1391,18 +1391,18 @@ static irqreturn_t via_rhine_interrupt(i
 				while ((readw(ioaddr+ChipCmd) & CmdTxOn) && --cnt)
 					udelay(5);
 				if (debug > 2 && !cnt)
-					printk(KERN_WARNING "%s: via_rhine_interrupt() "
+					printk(KERN_WARNING "%s: rhine_interrupt() "
 						   "Tx engine still on.\n",
 						   dev->name);
 			}
-			via_rhine_tx(dev);
+			rhine_tx(dev);
 		}
 
 		/* Abnormal error summary/uncommon events handlers. */
 		if (intr_status & (IntrPCIErr | IntrLinkChange |
 				   IntrStatsMax | IntrTxError | IntrTxAborted |
 				   IntrTxUnderrun | IntrTxDescRace))
-			via_rhine_error(dev, intr_status);
+			rhine_error(dev, intr_status);
 
 		if (--boguscnt < 0) {
 			printk(KERN_WARNING "%s: Too much work at interrupt, "
@@ -1420,16 +1420,16 @@ static irqreturn_t via_rhine_interrupt(i
 
 /* This routine is logically part of the interrupt handler, but isolated
    for clarity. */
-static void via_rhine_tx(struct net_device *dev)
+static void rhine_tx(struct net_device *dev)
 {
-	struct netdev_private *np = dev->priv;
-	int txstatus = 0, entry = np->dirty_tx % TX_RING_SIZE;
+	struct rhine_private *rp = dev->priv;
+	int txstatus = 0, entry = rp->dirty_tx % TX_RING_SIZE;
 
-	spin_lock (&np->lock);
+	spin_lock (&rp->lock);
 
 	/* find and cleanup dirty tx descriptors */
-	while (np->dirty_tx != np->cur_tx) {
-		txstatus = le32_to_cpu(np->tx_ring[entry].tx_status);
+	while (rp->dirty_tx != rp->cur_tx) {
+		txstatus = le32_to_cpu(rp->tx_ring[entry].tx_status);
 		if (debug > 6)
 			printk(KERN_DEBUG " Tx scavenge %d status %8.8x.\n",
 				   entry, txstatus);
@@ -1439,67 +1439,67 @@ static void via_rhine_tx(struct net_devi
 			if (debug > 1)
 				printk(KERN_DEBUG "%s: Transmit error, Tx status %8.8x.\n",
 					   dev->name, txstatus);
-			np->stats.tx_errors++;
-			if (txstatus & 0x0400) np->stats.tx_carrier_errors++;
-			if (txstatus & 0x0200) np->stats.tx_window_errors++;
-			if (txstatus & 0x0100) np->stats.tx_aborted_errors++;
-			if (txstatus & 0x0080) np->stats.tx_heartbeat_errors++;
-			if (((np->chip_id == VT86C100A) && txstatus & 0x0002) ||
+			rp->stats.tx_errors++;
+			if (txstatus & 0x0400) rp->stats.tx_carrier_errors++;
+			if (txstatus & 0x0200) rp->stats.tx_window_errors++;
+			if (txstatus & 0x0100) rp->stats.tx_aborted_errors++;
+			if (txstatus & 0x0080) rp->stats.tx_heartbeat_errors++;
+			if (((rp->chip_id == VT86C100A) && txstatus & 0x0002) ||
 				(txstatus & 0x0800) || (txstatus & 0x1000)) {
-				np->stats.tx_fifo_errors++;
-				np->tx_ring[entry].tx_status = cpu_to_le32(DescOwn);
+				rp->stats.tx_fifo_errors++;
+				rp->tx_ring[entry].tx_status = cpu_to_le32(DescOwn);
 				break; /* Keep the skb - we try again */
 			}
 			/* Transmitter restarted in 'abnormal' handler. */
 		} else {
-			if (np->chip_id == VT86C100A)
-				np->stats.collisions += (txstatus >> 3) & 0x0F;
+			if (rp->chip_id == VT86C100A)
+				rp->stats.collisions += (txstatus >> 3) & 0x0F;
 			else
-				np->stats.collisions += txstatus & 0x0F;
+				rp->stats.collisions += txstatus & 0x0F;
 			if (debug > 6)
 				printk(KERN_DEBUG "collisions: %1.1x:%1.1x\n",
 					(txstatus >> 3) & 0xF,
 					txstatus & 0xF);
-			np->stats.tx_bytes += np->tx_skbuff[entry]->len;
-			np->stats.tx_packets++;
+			rp->stats.tx_bytes += rp->tx_skbuff[entry]->len;
+			rp->stats.tx_packets++;
 		}
 		/* Free the original skb. */
-		if (np->tx_skbuff_dma[entry]) {
-			pci_unmap_single(np->pdev,
-							 np->tx_skbuff_dma[entry],
-							 np->tx_skbuff[entry]->len, PCI_DMA_TODEVICE);
+		if (rp->tx_skbuff_dma[entry]) {
+			pci_unmap_single(rp->pdev,
+							 rp->tx_skbuff_dma[entry],
+							 rp->tx_skbuff[entry]->len, PCI_DMA_TODEVICE);
 		}
-		dev_kfree_skb_irq(np->tx_skbuff[entry]);
-		np->tx_skbuff[entry] = NULL;
-		entry = (++np->dirty_tx) % TX_RING_SIZE;
+		dev_kfree_skb_irq(rp->tx_skbuff[entry]);
+		rp->tx_skbuff[entry] = NULL;
+		entry = (++rp->dirty_tx) % TX_RING_SIZE;
 	}
-	if ((np->cur_tx - np->dirty_tx) < TX_QUEUE_LEN - 4)
+	if ((rp->cur_tx - rp->dirty_tx) < TX_QUEUE_LEN - 4)
 		netif_wake_queue (dev);
 
-	spin_unlock (&np->lock);
+	spin_unlock (&rp->lock);
 }
 
 /* This routine is logically part of the interrupt handler, but isolated
    for clarity and better register allocation. */
-static void via_rhine_rx(struct net_device *dev)
+static void rhine_rx(struct net_device *dev)
 {
-	struct netdev_private *np = dev->priv;
-	int entry = np->cur_rx % RX_RING_SIZE;
-	int boguscnt = np->dirty_rx + RX_RING_SIZE - np->cur_rx;
+	struct rhine_private *rp = dev->priv;
+	int entry = rp->cur_rx % RX_RING_SIZE;
+	int boguscnt = rp->dirty_rx + RX_RING_SIZE - rp->cur_rx;
 
 	if (debug > 4) {
-		printk(KERN_DEBUG "%s: via_rhine_rx(), entry %d status %8.8x.\n",
-			   dev->name, entry, le32_to_cpu(np->rx_head_desc->rx_status));
+		printk(KERN_DEBUG "%s: rhine_rx(), entry %d status %8.8x.\n",
+			   dev->name, entry, le32_to_cpu(rp->rx_head_desc->rx_status));
 	}
 
 	/* If EOP is set on the next entry, it's a new packet. Send it up. */
-	while ( ! (np->rx_head_desc->rx_status & cpu_to_le32(DescOwn))) {
-		struct rx_desc *desc = np->rx_head_desc;
+	while ( ! (rp->rx_head_desc->rx_status & cpu_to_le32(DescOwn))) {
+		struct rx_desc *desc = rp->rx_head_desc;
 		u32 desc_status = le32_to_cpu(desc->rx_status);
 		int data_size = desc_status >> 16;
 
 		if (debug > 4)
-			printk(KERN_DEBUG "  via_rhine_rx() status is %8.8x.\n",
+			printk(KERN_DEBUG "  rhine_rx() status is %8.8x.\n",
 				   desc_status);
 		if (--boguscnt < 0)
 			break;
@@ -1509,22 +1509,22 @@ static void via_rhine_rx(struct net_devi
 					   "multiple buffers, entry %#x length %d status %8.8x!\n",
 					   dev->name, entry, data_size, desc_status);
 				printk(KERN_WARNING "%s: Oversized Ethernet frame %p vs %p.\n",
-					   dev->name, np->rx_head_desc, &np->rx_ring[entry]);
-				np->stats.rx_length_errors++;
+					   dev->name, rp->rx_head_desc, &rp->rx_ring[entry]);
+				rp->stats.rx_length_errors++;
 			} else if (desc_status & RxErr) {
 				/* There was a error. */
 				if (debug > 2)
-					printk(KERN_DEBUG "  via_rhine_rx() Rx error was %8.8x.\n",
+					printk(KERN_DEBUG "  rhine_rx() Rx error was %8.8x.\n",
 						   desc_status);
-				np->stats.rx_errors++;
-				if (desc_status & 0x0030) np->stats.rx_length_errors++;
-				if (desc_status & 0x0048) np->stats.rx_fifo_errors++;
-				if (desc_status & 0x0004) np->stats.rx_frame_errors++;
+				rp->stats.rx_errors++;
+				if (desc_status & 0x0030) rp->stats.rx_length_errors++;
+				if (desc_status & 0x0048) rp->stats.rx_fifo_errors++;
+				if (desc_status & 0x0004) rp->stats.rx_frame_errors++;
 				if (desc_status & 0x0002) {
 					/* this can also be updated outside the interrupt handler */
-					spin_lock (&np->lock);
-					np->stats.rx_crc_errors++;
-					spin_unlock (&np->lock);
+					spin_lock (&rp->lock);
+					rp->stats.rx_crc_errors++;
+					spin_unlock (&rp->lock);
 				}
 			}
 		} else {
@@ -1538,59 +1538,59 @@ static void via_rhine_rx(struct net_devi
 				(skb = dev_alloc_skb(pkt_len + 2)) != NULL) {
 				skb->dev = dev;
 				skb_reserve(skb, 2);	/* 16 byte align the IP header */
-				pci_dma_sync_single_for_cpu(np->pdev, np->rx_skbuff_dma[entry],
-						    np->rx_buf_sz, PCI_DMA_FROMDEVICE);
+				pci_dma_sync_single_for_cpu(rp->pdev, rp->rx_skbuff_dma[entry],
+						    rp->rx_buf_sz, PCI_DMA_FROMDEVICE);
 
 				/* *_IP_COPYSUM isn't defined anywhere and eth_copy_and_sum
 				   is memcpy for all archs so this is kind of pointless right
 				   now ... or? */
 #if HAS_IP_COPYSUM                     /* Call copy + cksum if available. */
-				eth_copy_and_sum(skb, np->rx_skbuff[entry]->tail, pkt_len, 0);
+				eth_copy_and_sum(skb, rp->rx_skbuff[entry]->tail, pkt_len, 0);
 				skb_put(skb, pkt_len);
 #else
-				memcpy(skb_put(skb, pkt_len), np->rx_skbuff[entry]->tail,
+				memcpy(skb_put(skb, pkt_len), rp->rx_skbuff[entry]->tail,
 					   pkt_len);
 #endif
-				pci_dma_sync_single_for_device(np->pdev, np->rx_skbuff_dma[entry],
-						    np->rx_buf_sz, PCI_DMA_FROMDEVICE);
+				pci_dma_sync_single_for_device(rp->pdev, rp->rx_skbuff_dma[entry],
+						    rp->rx_buf_sz, PCI_DMA_FROMDEVICE);
 			} else {
-				skb = np->rx_skbuff[entry];
+				skb = rp->rx_skbuff[entry];
 				if (skb == NULL) {
 					printk(KERN_ERR "%s: Inconsistent Rx descriptor chain.\n",
 						   dev->name);
 					break;
 				}
-				np->rx_skbuff[entry] = NULL;
+				rp->rx_skbuff[entry] = NULL;
 				skb_put(skb, pkt_len);
-				pci_unmap_single(np->pdev, np->rx_skbuff_dma[entry],
-								 np->rx_buf_sz, PCI_DMA_FROMDEVICE);
+				pci_unmap_single(rp->pdev, rp->rx_skbuff_dma[entry],
+								 rp->rx_buf_sz, PCI_DMA_FROMDEVICE);
 			}
 			skb->protocol = eth_type_trans(skb, dev);
 			netif_rx(skb);
 			dev->last_rx = jiffies;
-			np->stats.rx_bytes += pkt_len;
-			np->stats.rx_packets++;
+			rp->stats.rx_bytes += pkt_len;
+			rp->stats.rx_packets++;
 		}
-		entry = (++np->cur_rx) % RX_RING_SIZE;
-		np->rx_head_desc = &np->rx_ring[entry];
+		entry = (++rp->cur_rx) % RX_RING_SIZE;
+		rp->rx_head_desc = &rp->rx_ring[entry];
 	}
 
 	/* Refill the Rx ring buffers. */
-	for (; np->cur_rx - np->dirty_rx > 0; np->dirty_rx++) {
+	for (; rp->cur_rx - rp->dirty_rx > 0; rp->dirty_rx++) {
 		struct sk_buff *skb;
-		entry = np->dirty_rx % RX_RING_SIZE;
-		if (np->rx_skbuff[entry] == NULL) {
-			skb = dev_alloc_skb(np->rx_buf_sz);
-			np->rx_skbuff[entry] = skb;
+		entry = rp->dirty_rx % RX_RING_SIZE;
+		if (rp->rx_skbuff[entry] == NULL) {
+			skb = dev_alloc_skb(rp->rx_buf_sz);
+			rp->rx_skbuff[entry] = skb;
 			if (skb == NULL)
 				break;			/* Better luck next round. */
 			skb->dev = dev;			/* Mark as being used by this device. */
-			np->rx_skbuff_dma[entry] =
-				pci_map_single(np->pdev, skb->tail, np->rx_buf_sz,
+			rp->rx_skbuff_dma[entry] =
+				pci_map_single(rp->pdev, skb->tail, rp->rx_buf_sz,
 							   PCI_DMA_FROMDEVICE);
-			np->rx_ring[entry].addr = cpu_to_le32(np->rx_skbuff_dma[entry]);
+			rp->rx_ring[entry].addr = cpu_to_le32(rp->rx_skbuff_dma[entry]);
 		}
-		np->rx_ring[entry].rx_status = cpu_to_le32(DescOwn);
+		rp->rx_ring[entry].rx_status = cpu_to_le32(DescOwn);
 	}
 
 	/* Pre-emptively restart Rx engine. */
@@ -1609,10 +1609,10 @@ static inline void clear_tally_counters(
 	readw(ioaddr + RxMissed);
 }
 
-static void via_rhine_restart_tx(struct net_device *dev) {
-	struct netdev_private *np = dev->priv;
+static void rhine_restart_tx(struct net_device *dev) {
+	struct rhine_private *rp = dev->priv;
 	long ioaddr = dev->base_addr;
-	int entry = np->dirty_tx % TX_RING_SIZE;
+	int entry = rp->dirty_tx % TX_RING_SIZE;
 	u32 intr_status;
 
 	/*
@@ -1624,45 +1624,45 @@ static void via_rhine_restart_tx(struct 
 	if ((intr_status & IntrTxErrSummary) == 0) {
 
 		/* We know better than the chip where it should continue. */
-		writel(np->tx_ring_dma + entry * sizeof(struct tx_desc),
+		writel(rp->tx_ring_dma + entry * sizeof(struct tx_desc),
 			   ioaddr + TxRingPtr);
 
-		writew(CmdTxDemand | np->chip_cmd, ioaddr + ChipCmd);
+		writew(CmdTxDemand | rp->chip_cmd, ioaddr + ChipCmd);
 		IOSYNC;
 	}
 	else {
 		/* This should never happen */
 		if (debug > 1)
-			printk(KERN_WARNING "%s: via_rhine_restart_tx() "
+			printk(KERN_WARNING "%s: rhine_restart_tx() "
 				   "Another error occured %8.8x.\n",
 				   dev->name, intr_status);
 	}
 
 }
 
-static void via_rhine_error(struct net_device *dev, int intr_status)
+static void rhine_error(struct net_device *dev, int intr_status)
 {
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 	long ioaddr = dev->base_addr;
 
-	spin_lock (&np->lock);
+	spin_lock (&rp->lock);
 
 	if (intr_status & (IntrLinkChange)) {
 		if (readb(ioaddr + MIIStatus) & 0x02) {
 			/* Link failed, restart autonegotiation. */
-			if (np->drv_flags & HasDavicomPhy)
-				mdio_write(dev, np->phys[0], MII_BMCR, 0x3300);
+			if (rp->drv_flags & HasDavicomPhy)
+				mdio_write(dev, rp->phys[0], MII_BMCR, 0x3300);
 		} else
-			via_rhine_check_duplex(dev);
+			rhine_check_duplex(dev);
 		if (debug)
 			printk(KERN_ERR "%s: MII status changed: Autonegotiation "
 				   "advertising %4.4x  partner %4.4x.\n", dev->name,
-			   mdio_read(dev, np->phys[0], MII_ADVERTISE),
-			   mdio_read(dev, np->phys[0], MII_LPA));
+			   mdio_read(dev, rp->phys[0], MII_ADVERTISE),
+			   mdio_read(dev, rp->phys[0], MII_LPA));
 	}
 	if (intr_status & IntrStatsMax) {
-		np->stats.rx_crc_errors	+= readw(ioaddr + RxCRCErrs);
-		np->stats.rx_missed_errors	+= readw(ioaddr + RxMissed);
+		rp->stats.rx_crc_errors	+= readw(ioaddr + RxCRCErrs);
+		rp->stats.rx_missed_errors	+= readw(ioaddr + RxMissed);
 		clear_tally_counters(ioaddr);
 	}
 	if (intr_status & IntrTxAborted) {
@@ -1671,12 +1671,12 @@ static void via_rhine_error(struct net_d
 				   dev->name, intr_status);
 	}
 	if (intr_status & IntrTxUnderrun) {
-		if (np->tx_thresh < 0xE0)
-			writeb(np->tx_thresh += 0x20, ioaddr + TxConfig);
+		if (rp->tx_thresh < 0xE0)
+			writeb(rp->tx_thresh += 0x20, ioaddr + TxConfig);
 		if (debug > 1)
 			printk(KERN_INFO "%s: Transmitter underrun, Tx "
 				   "threshold now %2.2x.\n",
-				   dev->name, np->tx_thresh);
+				   dev->name, rp->tx_thresh);
 	}
 	if (intr_status & IntrTxDescRace) {
 		if (debug > 2)
@@ -1686,17 +1686,17 @@ static void via_rhine_error(struct net_d
 	if ((intr_status & IntrTxError) &&
 			(intr_status & ( IntrTxAborted |
 			IntrTxUnderrun | IntrTxDescRace )) == 0) {
-		if (np->tx_thresh < 0xE0) {
-			writeb(np->tx_thresh += 0x20, ioaddr + TxConfig);
+		if (rp->tx_thresh < 0xE0) {
+			writeb(rp->tx_thresh += 0x20, ioaddr + TxConfig);
 		}
 		if (debug > 1)
 			printk(KERN_INFO "%s: Unspecified error. Tx "
 				   "threshold now %2.2x.\n",
-				   dev->name, np->tx_thresh);
+				   dev->name, rp->tx_thresh);
 	}
 	if (intr_status & ( IntrTxAborted | IntrTxUnderrun | IntrTxDescRace |
 						IntrTxError ))
-		via_rhine_restart_tx(dev);
+		rhine_restart_tx(dev);
 
 	if (intr_status & ~( IntrLinkChange | IntrStatsMax | IntrTxUnderrun |
 						 IntrTxError | IntrTxAborted | IntrNormalSummary |
@@ -1706,27 +1706,27 @@ static void via_rhine_error(struct net_d
 				   dev->name, intr_status);
 	}
 
-	spin_unlock (&np->lock);
+	spin_unlock (&rp->lock);
 }
 
-static struct net_device_stats *via_rhine_get_stats(struct net_device *dev)
+static struct net_device_stats *rhine_get_stats(struct net_device *dev)
 {
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 	long ioaddr = dev->base_addr;
 	unsigned long flags;
 
-	spin_lock_irqsave(&np->lock, flags);
-	np->stats.rx_crc_errors	+= readw(ioaddr + RxCRCErrs);
-	np->stats.rx_missed_errors	+= readw(ioaddr + RxMissed);
+	spin_lock_irqsave(&rp->lock, flags);
+	rp->stats.rx_crc_errors	+= readw(ioaddr + RxCRCErrs);
+	rp->stats.rx_missed_errors	+= readw(ioaddr + RxMissed);
 	clear_tally_counters(ioaddr);
-	spin_unlock_irqrestore(&np->lock, flags);
+	spin_unlock_irqrestore(&rp->lock, flags);
 
-	return &np->stats;
+	return &rp->stats;
 }
 
-static void via_rhine_set_rx_mode(struct net_device *dev)
+static void rhine_set_rx_mode(struct net_device *dev)
 {
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 	long ioaddr = dev->base_addr;
 	u32 mc_filter[2];			/* Multicast hash filter */
 	u8 rx_mode;					/* Note: 0x02=accept runt, 0x01=accept errs */
@@ -1757,66 +1757,66 @@ static void via_rhine_set_rx_mode(struct
 		writel(mc_filter[1], ioaddr + MulticastFilter1);
 		rx_mode = 0x0C;
 	}
-	writeb(np->rx_thresh | rx_mode, ioaddr + RxConfig);
+	writeb(rp->rx_thresh | rx_mode, ioaddr + RxConfig);
 }
 
 static void netdev_get_drvinfo (struct net_device *dev, struct ethtool_drvinfo *info)
 {
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 
 	strcpy (info->driver, DRV_NAME);
 	strcpy (info->version, DRV_VERSION);
-	strcpy (info->bus_info, pci_name(np->pdev));
+	strcpy (info->bus_info, pci_name(rp->pdev));
 }
 
 static int netdev_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 	int rc;
 
-	if (!(np->drv_flags & CanHaveMII))
+	if (!(rp->drv_flags & CanHaveMII))
 		return -EINVAL;
 
-	spin_lock_irq(&np->lock);
-	rc = mii_ethtool_gset(&np->mii_if, cmd);
-	spin_unlock_irq(&np->lock);
+	spin_lock_irq(&rp->lock);
+	rc = mii_ethtool_gset(&rp->mii_if, cmd);
+	spin_unlock_irq(&rp->lock);
 
 	return rc;
 }
 
 static int netdev_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 	int rc;
 
-	if (!(np->drv_flags & CanHaveMII))
+	if (!(rp->drv_flags & CanHaveMII))
 		return -EINVAL;
 
-	spin_lock_irq(&np->lock);
-	rc = mii_ethtool_sset(&np->mii_if, cmd);
-	spin_unlock_irq(&np->lock);
+	spin_lock_irq(&rp->lock);
+	rc = mii_ethtool_sset(&rp->mii_if, cmd);
+	spin_unlock_irq(&rp->lock);
 
 	return rc;
 }
 
 static int netdev_nway_reset(struct net_device *dev)
 {
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 
-	if (!(np->drv_flags & CanHaveMII))
+	if (!(rp->drv_flags & CanHaveMII))
 		return -EINVAL;
 
-	return mii_nway_restart(&np->mii_if);
+	return mii_nway_restart(&rp->mii_if);
 }
 
 static u32 netdev_get_link(struct net_device *dev)
 {
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 
-	if (!(np->drv_flags & CanHaveMII))
+	if (!(rp->drv_flags & CanHaveMII))
 		return 0;	/* -EINVAL */
 
-	return mii_link_ok(&np->mii_if);
+	return mii_link_ok(&rp->mii_if);
 }
 
 static u32 netdev_get_msglevel(struct net_device *dev)
@@ -1843,28 +1843,28 @@ static struct ethtool_ops netdev_ethtool
 
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 	struct mii_ioctl_data *data = (struct mii_ioctl_data *) & rq->ifr_data;
 	int rc;
 
 	if (!netif_running(dev))
 		return -EINVAL;
 
-	spin_lock_irq(&np->lock);
-	rc = generic_mii_ioctl(&np->mii_if, data, cmd, NULL);
-	spin_unlock_irq(&np->lock);
+	spin_lock_irq(&rp->lock);
+	rc = generic_mii_ioctl(&rp->mii_if, data, cmd, NULL);
+	spin_unlock_irq(&rp->lock);
 
 	return rc;
 }
 
-static int via_rhine_close(struct net_device *dev)
+static int rhine_close(struct net_device *dev)
 {
 	long ioaddr = dev->base_addr;
-	struct netdev_private *np = dev->priv;
+	struct rhine_private *rp = dev->priv;
 
-	del_timer_sync(&np->timer);
+	del_timer_sync(&rp->timer);
 
-	spin_lock_irq(&np->lock);
+	spin_lock_irq(&rp->lock);
 
 	netif_stop_queue(dev);
 
@@ -1873,7 +1873,7 @@ static int via_rhine_close(struct net_de
 			   dev->name, readw(ioaddr + ChipCmd));
 
 	/* Switch to loopback mode to avoid hardware races. */
-	writeb(np->tx_thresh | 0x02, ioaddr + TxConfig);
+	writeb(rp->tx_thresh | 0x02, ioaddr + TxConfig);
 
 	/* Disable interrupts by clearing the interrupt mask. */
 	writew(0x0000, ioaddr + IntrEnable);
@@ -1881,9 +1881,9 @@ static int via_rhine_close(struct net_de
 	/* Stop the chip's Tx and Rx processes. */
 	writew(CmdStop, ioaddr + ChipCmd);
 
-	spin_unlock_irq(&np->lock);
+	spin_unlock_irq(&rp->lock);
 
-	free_irq(np->pdev->irq, dev);
+	free_irq(rp->pdev->irq, dev);
 	free_rbufs(dev);
 	free_tbufs(dev);
 	free_ring(dev);
@@ -1892,7 +1892,7 @@ static int via_rhine_close(struct net_de
 }
 
 
-static void __devexit via_rhine_remove_one (struct pci_dev *pdev)
+static void __devexit rhine_remove_one (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
@@ -1910,32 +1910,32 @@ static void __devexit via_rhine_remove_o
 }
 
 
-static struct pci_driver via_rhine_driver = {
+static struct pci_driver rhine_driver = {
 	.name		= "via-rhine",
-	.id_table	= via_rhine_pci_tbl,
-	.probe		= via_rhine_init_one,
-	.remove		= __devexit_p(via_rhine_remove_one),
+	.id_table	= rhine_pci_tbl,
+	.probe		= rhine_init_one,
+	.remove		= __devexit_p(rhine_remove_one),
 };
 
 
-static int __init via_rhine_init (void)
+static int __init rhine_init (void)
 {
 /* when a module, this is printed whether or not devices are found in probe */
 #ifdef MODULE
 	printk(version);
 #endif
-	return pci_module_init (&via_rhine_driver);
+	return pci_module_init (&rhine_driver);
 }
 
 
-static void __exit via_rhine_cleanup (void)
+static void __exit rhine_cleanup (void)
 {
-	pci_unregister_driver (&via_rhine_driver);
+	pci_unregister_driver (&rhine_driver);
 }
 
 
-module_init(via_rhine_init);
-module_exit(via_rhine_cleanup);
+module_init(rhine_init);
+module_exit(rhine_cleanup);
 
 
 /*

--h31gzZEtNLTqOjlF--
