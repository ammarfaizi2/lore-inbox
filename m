Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423264AbWANCJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423264AbWANCJn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 21:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423268AbWANCJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 21:09:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18450 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1423264AbWANCJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 21:09:40 -0500
Date: Sat, 14 Jan 2006 03:09:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Raghavendra Koushik <raghavendra.koushik@neterion.com>, jgarzik@pobox.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/s2io.c: make code static
Message-ID: <20060114020940.GA29663@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 5 Jan 2006

 drivers/net/s2io.c |   22 +++++++++++-----------
 drivers/net/s2io.h |   17 +++++++----------
 2 files changed, 18 insertions(+), 21 deletions(-)

--- linux-2.6.15-mm1-full/drivers/net/s2io.h.old	2006-01-05 20:46:34.000000000 +0100
+++ linux-2.6.15-mm1-full/drivers/net/s2io.h	2006-01-05 21:10:33.000000000 +0100
@@ -64,7 +64,7 @@
 #define	INTR_DBG	4
 
 /* Global variable that defines the present debug level of the driver. */
-int debug_level = ERR_DBG;	/* Default level. */
+static int debug_level = ERR_DBG;
 
 /* DEBUG message print. */
 #define DBG_PRINT(dbg_level, args...)  if(!(debug_level<dbg_level)) printk(args)
@@ -268,7 +268,7 @@
 #define MAX_RX_RINGS 8
 
 /* FIFO mappings for all possible number of fifos configured */
-int fifo_map[][MAX_TX_FIFOS] = {
+static int fifo_map[][MAX_TX_FIFOS] = {
 	{0, 0, 0, 0, 0, 0, 0, 0},
 	{0, 0, 0, 0, 1, 1, 1, 1},
 	{0, 0, 0, 1, 1, 1, 2, 2},
@@ -911,18 +911,16 @@
 static void alarm_intr_handler(struct s2io_nic *sp);
 
 static int s2io_starter(void);
-void s2io_closer(void);
 static void s2io_tx_watchdog(struct net_device *dev);
 static void s2io_tasklet(unsigned long dev_addr);
 static void s2io_set_multicast(struct net_device *dev);
 static int rx_osm_handler(ring_info_t *ring_data, RxD_t * rxdp);
-void s2io_link(nic_t * sp, int link);
-void s2io_reset(nic_t * sp);
+static void s2io_link(nic_t * sp, int link);
 #if defined(CONFIG_S2IO_NAPI)
 static int s2io_poll(struct net_device *dev, int *budget);
 #endif
 static void s2io_init_pci(nic_t * sp);
-int s2io_set_mac_addr(struct net_device *dev, u8 * addr);
+static int s2io_set_mac_addr(struct net_device *dev, u8 * addr);
 static void s2io_alarm_handle(unsigned long data);
 static int s2io_enable_msi(nic_t *nic);
 static irqreturn_t s2io_msi_handle(int irq, void *dev_id, struct pt_regs *regs);
@@ -930,14 +928,13 @@
 s2io_msix_ring_handle(int irq, void *dev_id, struct pt_regs *regs);
 static irqreturn_t
 s2io_msix_fifo_handle(int irq, void *dev_id, struct pt_regs *regs);
-int s2io_enable_msi_x(nic_t *nic);
 static irqreturn_t s2io_isr(int irq, void *dev_id, struct pt_regs *regs);
 static int verify_xena_quiescence(nic_t *sp, u64 val64, int flag);
 static struct ethtool_ops netdev_ethtool_ops;
 static void s2io_set_link(unsigned long data);
-int s2io_set_swapper(nic_t * sp);
+static int s2io_set_swapper(nic_t * sp);
 static void s2io_card_down(nic_t *nic);
 static int s2io_card_up(nic_t *nic);
-int get_xena_rev_id(struct pci_dev *pdev);
-void restore_xmsi_data(nic_t *nic);
+static int get_xena_rev_id(struct pci_dev *pdev);
+static void restore_xmsi_data(nic_t *nic);
 #endif				/* _S2IO_H */
--- linux-2.6.15-mm1-full/drivers/net/s2io.c.old	2006-01-05 20:45:51.000000000 +0100
+++ linux-2.6.15-mm1-full/drivers/net/s2io.c	2006-01-05 20:54:26.000000000 +0100
@@ -72,8 +72,8 @@
 static char s2io_driver_name[] = "Neterion";
 static char s2io_driver_version[] = DRV_VERSION;
 
-int rxd_size[4] = {32,48,48,64};
-int rxd_count[4] = {127,85,85,63};
+static int rxd_size[4] = {32,48,48,64};
+static int rxd_count[4] = {127,85,85,63};
 
 static inline int RXD_IS_UP2DT(RxD_t *rxdp)
 {
@@ -2127,7 +2127,7 @@
 	}
 }
 
-int fill_rxd_3buf(nic_t *nic, RxD_t *rxdp, struct sk_buff *skb)
+static int fill_rxd_3buf(nic_t *nic, RxD_t *rxdp, struct sk_buff *skb)
 {
 	struct net_device *dev = nic->dev;
 	struct sk_buff *frag_list;
@@ -2852,7 +2852,7 @@
  *  void.
  */
 
-void s2io_reset(nic_t * sp)
+static void s2io_reset(nic_t * sp)
 {
 	XENA_dev_config_t __iomem *bar0 = sp->bar0;
 	u64 val64;
@@ -2940,7 +2940,7 @@
  *  SUCCESS on success and FAILURE on failure.
  */
 
-int s2io_set_swapper(nic_t * sp)
+static int s2io_set_swapper(nic_t * sp)
 {
 	struct net_device *dev = sp->dev;
 	XENA_dev_config_t __iomem *bar0 = sp->bar0;
@@ -3089,7 +3089,7 @@
 	return ret;
 }
 
-void restore_xmsi_data(nic_t *nic)
+static void restore_xmsi_data(nic_t *nic)
 {
 	XENA_dev_config_t __iomem *bar0 = nic->bar0;
 	u64 val64;
@@ -3180,7 +3180,7 @@
 	return 0;
 }
 
-int s2io_enable_msi_x(nic_t *nic)
+static int s2io_enable_msi_x(nic_t *nic)
 {
 	XENA_dev_config_t __iomem *bar0 = nic->bar0;
 	u64 tx_mat, rx_mat;
@@ -4128,7 +4128,7 @@
  *  as defined in errno.h file on failure.
  */
 
-int s2io_set_mac_addr(struct net_device *dev, u8 * addr)
+static int s2io_set_mac_addr(struct net_device *dev, u8 * addr)
 {
 	nic_t *sp = dev->priv;
 	XENA_dev_config_t __iomem *bar0 = sp->bar0;
@@ -5713,7 +5713,7 @@
  *  void.
  */
 
-void s2io_link(nic_t * sp, int link)
+static void s2io_link(nic_t * sp, int link)
 {
 	struct net_device *dev = (struct net_device *) sp->dev;
 
@@ -5738,7 +5738,7 @@
  *  returns the revision ID of the device.
  */
 
-int get_xena_rev_id(struct pci_dev *pdev)
+static int get_xena_rev_id(struct pci_dev *pdev)
 {
 	u8 id = 0;
 	int ret;
@@ -6343,7 +6343,7 @@
  * Description: This function is the cleanup routine for the driver. It unregist * ers the driver.
  */
 
-void s2io_closer(void)
+static void s2io_closer(void)
 {
 	pci_unregister_driver(&s2io_driver);
 	DBG_PRINT(INIT_DBG, "cleanup done\n");

