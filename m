Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262902AbUEWOxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUEWOxV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 10:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbUEWOxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 10:53:21 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:4272 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S262902AbUEWOxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 10:53:10 -0400
Date: Sun, 23 May 2004 16:52:47 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [5/4][PATCH 2.6] via-rhine: netdev_priv()
Message-ID: <20040523145247.GA17910@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20040523104650.GA9979@k3.hellgate.ch>
X-Operating-System: Linux 2.6.6 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Found another patch that should go with this batch:

Switch to netdev_priv(). Fix outdated comment and bump version number
while we're at it.

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-rhine-2.6.6-5-netdev_priv.diff"

--- linux-2.6.6/drivers/net/via-rhine.c	2004-05-23 11:56:08.043812192 +0200
+++ linux-2.6.6-patch/drivers/net/via-rhine.c	2004-05-23 16:42:26.550821369 +0200
@@ -128,8 +128,8 @@
 */
 
 #define DRV_NAME	"via-rhine"
-#define DRV_VERSION	"1.1.19-2.5"
-#define DRV_RELDATE	"July-12-2003"
+#define DRV_VERSION	"1.1.20-2.6"
+#define DRV_RELDATE	"May-23-2004"
 
 
 /* A few user-configurable values.
@@ -219,8 +219,8 @@ KERN_INFO DRV_NAME ".c:v1.10-LK" DRV_VER
 static char shortname[] = DRV_NAME;
 
 
-/* This driver was written to use PCI memory space, however most versions
-   of the Rhine only work correctly with I/O space accesses. */
+/* This driver was written to use PCI memory space. Some early versions
+   of the Rhine may only work correctly with I/O space accesses. */
 #ifdef CONFIG_VIA_RHINE_MMIO
 #define USE_MMIO
 #else
@@ -552,7 +552,7 @@ static int  rhine_close(struct net_devic
 static inline u32 get_intr_status(struct net_device *dev)
 {
 	long ioaddr = dev->base_addr;
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 	u32 intr_status;
 
 	intr_status = readw(ioaddr + IntrStatus);
@@ -770,7 +770,7 @@ static int __devinit rhine_init_one(stru
 
 	dev->irq = pdev->irq;
 
-	rp = dev->priv;
+	rp = netdev_priv(dev);
 	spin_lock_init(&rp->lock);
 	rp->chip_id = chip_id;
 	rp->drv_flags = rhine_chip_info[chip_id].drv_flags;
@@ -892,7 +892,7 @@ err_out:
 
 static int alloc_ring(struct net_device* dev)
 {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 	void *ring;
 	dma_addr_t ring_dma;
 
@@ -927,7 +927,7 @@ static int alloc_ring(struct net_device*
 
 void free_ring(struct net_device* dev)
 {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 
 	pci_free_consistent(rp->pdev,
 			    RX_RING_SIZE * sizeof(struct rx_desc) +
@@ -945,7 +945,7 @@ void free_ring(struct net_device* dev)
 
 static void alloc_rbufs(struct net_device *dev)
 {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 	dma_addr_t next;
 	int i;
 
@@ -986,7 +986,7 @@ static void alloc_rbufs(struct net_devic
 
 static void free_rbufs(struct net_device* dev)
 {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 	int i;
 
 	/* Free all the skbuffs in the Rx queue. */
@@ -1005,7 +1005,7 @@ static void free_rbufs(struct net_device
 
 static void alloc_tbufs(struct net_device* dev)
 {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 	dma_addr_t next;
 	int i;
 
@@ -1025,7 +1025,7 @@ static void alloc_tbufs(struct net_devic
 
 static void free_tbufs(struct net_device* dev)
 {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 	int i;
 
 	for (i = 0; i < TX_RING_SIZE; i++) {
@@ -1048,7 +1048,7 @@ static void free_tbufs(struct net_device
 
 static void init_registers(struct net_device *dev)
 {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	int i;
 
@@ -1114,7 +1114,7 @@ static int mdio_read(struct net_device *
 
 static void mdio_write(struct net_device *dev, int phy_id, int regnum, int value)
 {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	int boguscnt = 1024;
 
@@ -1145,7 +1145,7 @@ static void mdio_write(struct net_device
 
 static int rhine_open(struct net_device *dev)
 {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	int i;
 
@@ -1188,7 +1188,7 @@ static int rhine_open(struct net_device 
 
 static void rhine_check_duplex(struct net_device *dev)
 {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	int mii_lpa = mdio_read(dev, rp->phys[0], MII_LPA);
 	int negotiated = mii_lpa & rp->mii_if.advertising;
@@ -1216,7 +1216,7 @@ static void rhine_check_duplex(struct ne
 static void rhine_timer(unsigned long data)
 {
 	struct net_device *dev = (struct net_device *)data;
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	int next_tick = 10*HZ;
 	int mii_status;
@@ -1249,7 +1249,7 @@ static void rhine_timer(unsigned long da
 
 static void rhine_tx_timeout(struct net_device *dev)
 {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 
 	printk(KERN_WARNING "%s: Transmit timed out, status %4.4x, PHY status "
@@ -1287,7 +1287,7 @@ static void rhine_tx_timeout(struct net_
 
 static int rhine_start_tx(struct sk_buff *skb, struct net_device *dev)
 {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 	unsigned entry;
 	u32 intr_status;
 
@@ -1431,7 +1431,7 @@ static irqreturn_t rhine_interrupt(int i
    for clarity. */
 static void rhine_tx(struct net_device *dev)
 {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 	int txstatus = 0, entry = rp->dirty_tx % TX_RING_SIZE;
 
 	spin_lock(&rp->lock);
@@ -1494,7 +1494,7 @@ static void rhine_tx(struct net_device *
    for clarity and better register allocation. */
 static void rhine_rx(struct net_device *dev)
 {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 	int entry = rp->cur_rx % RX_RING_SIZE;
 	int boguscnt = rp->dirty_rx + RX_RING_SIZE - rp->cur_rx;
 
@@ -1639,7 +1639,7 @@ static inline void clear_tally_counters(
 }
 
 static void rhine_restart_tx(struct net_device *dev) {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	int entry = rp->dirty_tx % TX_RING_SIZE;
 	u32 intr_status;
@@ -1671,7 +1671,7 @@ static void rhine_restart_tx(struct net_
 
 static void rhine_error(struct net_device *dev, int intr_status)
 {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 
 	spin_lock(&rp->lock);
@@ -1741,7 +1741,7 @@ static void rhine_error(struct net_devic
 
 static struct net_device_stats *rhine_get_stats(struct net_device *dev)
 {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	unsigned long flags;
 
@@ -1756,7 +1756,7 @@ static struct net_device_stats *rhine_ge
 
 static void rhine_set_rx_mode(struct net_device *dev)
 {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 	u32 mc_filter[2];	/* Multicast hash filter */
 	u8 rx_mode;		/* Note: 0x02=accept runt, 0x01=accept errs */
@@ -1793,7 +1793,7 @@ static void rhine_set_rx_mode(struct net
 
 static void netdev_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
 {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 
 	strcpy(info->driver, DRV_NAME);
 	strcpy(info->version, DRV_VERSION);
@@ -1802,7 +1802,7 @@ static void netdev_get_drvinfo(struct ne
 
 static int netdev_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 	int rc;
 
 	if (!(rp->drv_flags & CanHaveMII))
@@ -1817,7 +1817,7 @@ static int netdev_get_settings(struct ne
 
 static int netdev_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 	int rc;
 
 	if (!(rp->drv_flags & CanHaveMII))
@@ -1832,7 +1832,7 @@ static int netdev_set_settings(struct ne
 
 static int netdev_nway_reset(struct net_device *dev)
 {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 
 	if (!(rp->drv_flags & CanHaveMII))
 		return -EINVAL;
@@ -1842,7 +1842,7 @@ static int netdev_nway_reset(struct net_
 
 static u32 netdev_get_link(struct net_device *dev)
 {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 
 	if (!(rp->drv_flags & CanHaveMII))
 		return 0;	/* -EINVAL */
@@ -1874,7 +1874,7 @@ static struct ethtool_ops netdev_ethtool
 
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 	struct mii_ioctl_data *data = (struct mii_ioctl_data *) & rq->ifr_data;
 	int rc;
 
@@ -1891,7 +1891,7 @@ static int netdev_ioctl(struct net_devic
 static int rhine_close(struct net_device *dev)
 {
 	long ioaddr = dev->base_addr;
-	struct rhine_private *rp = dev->priv;
+	struct rhine_private *rp = netdev_priv(dev);
 
 	del_timer_sync(&rp->timer);
 

--gKMricLos+KVdGMg--
