Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVBSADq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVBSADq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 19:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVBSADh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 19:03:37 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25363 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261544AbVBSACQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 19:02:16 -0500
Date: Sat, 19 Feb 2005 01:02:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Raghavendra Koushik <raghavendra.koushik@s2io.com>
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/s2io.c: cleanups
Message-ID: <20050219000213.GH4337@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make needlessly global code static
- remove the unused blobal function get_xena_rev_id

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/s2io.c |   75 ++++++++++++++++++---------------------------
 drivers/net/s2io.h |    8 ++--
 2 files changed, 35 insertions(+), 48 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/net/s2io.h.old	2005-02-16 18:09:41.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/s2io.h	2005-02-16 18:15:42.000000000 +0100
@@ -848,7 +848,7 @@
 static void alarm_intr_handler(struct s2io_nic *sp);
 
 static int s2io_starter(void);
-void s2io_closer(void);
+static void s2io_closer(void);
 static void s2io_tx_watchdog(struct net_device *dev);
 static void s2io_tasklet(unsigned long dev_addr);
 static void s2io_set_multicast(struct net_device *dev);
@@ -858,13 +858,13 @@
 static int rx_osm_handler(nic_t * sp, RxD_t * rxdp, int ring_no,
 			  buffAdd_t * ba);
 #endif
-void s2io_link(nic_t * sp, int link);
-void s2io_reset(nic_t * sp);
+static void s2io_link(nic_t * sp, int link);
+static void s2io_reset(nic_t * sp);
 #ifdef CONFIG_S2IO_NAPI
 static int s2io_poll(struct net_device *dev, int *budget);
 #endif
 static void s2io_init_pci(nic_t * sp);
-int s2io_set_mac_addr(struct net_device *dev, u8 * addr);
+static int s2io_set_mac_addr(struct net_device *dev, u8 * addr);
 static irqreturn_t s2io_isr(int irq, void *dev_id, struct pt_regs *regs);
 static int verify_xena_quiescence(u64 val64, int flag);
 static struct ethtool_ops netdev_ethtool_ops;
--- linux-2.6.11-rc3-mm2-full/drivers/net/s2io.c.old	2005-02-16 18:07:48.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/s2io.c	2005-02-16 19:05:11.000000000 +0100
@@ -1350,7 +1350,7 @@
  *
  */
 
-void fix_mac_address(nic_t * sp)
+static void fix_mac_address(nic_t * sp)
 {
 	XENA_dev_config_t __iomem *bar0 = sp->bar0;
 	u64 val64;
@@ -1506,7 +1506,7 @@
  *  Return Value: void 
 */
 
-void free_tx_buffers(struct s2io_nic *nic)
+static void free_tx_buffers(struct s2io_nic *nic)
 {
 	struct net_device *dev = nic->dev;
 	struct sk_buff *skb;
@@ -1597,7 +1597,7 @@
  *  SUCCESS on success or an appropriate -ve value on failure.
  */
 
-int fill_rx_buffers(struct s2io_nic *nic, int ring_no)
+static int fill_rx_buffers(struct s2io_nic *nic, int ring_no)
 {
 	struct net_device *dev = nic->dev;
 	struct sk_buff *skb;
@@ -2422,7 +2422,7 @@
  *   SUCCESS on success and FAILURE on failure.
  */
 
-int wait_for_cmd_complete(nic_t * sp)
+static int wait_for_cmd_complete(nic_t * sp)
 {
 	XENA_dev_config_t __iomem *bar0 = sp->bar0;
 	int ret = FAILURE, cnt = 0;
@@ -2452,7 +2452,7 @@
  *  void.
  */
 
-void s2io_reset(nic_t * sp)
+static void s2io_reset(nic_t * sp)
 {
 	XENA_dev_config_t __iomem *bar0 = sp->bar0;
 	u64 val64;
@@ -2504,7 +2504,7 @@
  *  SUCCESS on success and FAILURE on failure.
  */
 
-int s2io_set_swapper(nic_t * sp)
+static int s2io_set_swapper(nic_t * sp)
 {
 	struct net_device *dev = sp->dev;
 	XENA_dev_config_t __iomem *bar0 = sp->bar0;
@@ -2598,7 +2598,7 @@
  *   file on failure.
  */
 
-int s2io_open(struct net_device *dev)
+static int s2io_open(struct net_device *dev)
 {
 	nic_t *sp = dev->priv;
 	int err = 0;
@@ -2650,7 +2650,7 @@
  *  file on failure.
  */
 
-int s2io_close(struct net_device *dev)
+static int s2io_close(struct net_device *dev)
 {
 	nic_t *sp = dev->priv;
 
@@ -2677,7 +2677,7 @@
  *  0 on success & 1 on failure.
  */
 
-int s2io_xmit(struct sk_buff *skb, struct net_device *dev)
+static int s2io_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	nic_t *sp = dev->priv;
 	u16 frg_cnt, frg_len, i, queue, queue_len, put_off, get_off;
@@ -2897,7 +2897,7 @@
  *  pointer to the updated net_device_stats structure.
  */
 
-struct net_device_stats *s2io_get_stats(struct net_device *dev)
+static struct net_device_stats *s2io_get_stats(struct net_device *dev)
 {
 	nic_t *sp = dev->priv;
 	mac_info_t *mac_control;
@@ -3145,7 +3145,7 @@
  * return 0 on success.
  */
 
-int s2io_ethtool_gset(struct net_device *dev, struct ethtool_cmd *info)
+static int s2io_ethtool_gset(struct net_device *dev, struct ethtool_cmd *info)
 {
 	nic_t *sp = dev->priv;
 	info->supported = (SUPPORTED_10000baseT_Full | SUPPORTED_FIBRE);
@@ -3342,8 +3342,8 @@
  * int, returns 0 on Success
  */
 
-int s2io_ethtool_setpause_data(struct net_device *dev,
-			       struct ethtool_pauseparam *ep)
+static int s2io_ethtool_setpause_data(struct net_device *dev,
+				      struct ethtool_pauseparam *ep)
 {
 	u64 val64;
 	nic_t *sp = dev->priv;
@@ -3458,8 +3458,8 @@
  *  int  0 on success
  */
 
-int s2io_ethtool_geeprom(struct net_device *dev,
-			 struct ethtool_eeprom *eeprom, u8 * data_buf)
+static int s2io_ethtool_geeprom(struct net_device *dev,
+				struct ethtool_eeprom *eeprom, u8 * data_buf)
 {
 	u32 data, i, valid;
 	nic_t *sp = dev->priv;
@@ -3956,19 +3956,20 @@
 	tmp_stats[i++] = stat_info->rmac_err_tcp;
 }
 
-int s2io_ethtool_get_regs_len(struct net_device *dev)
+static int s2io_ethtool_get_regs_len(struct net_device *dev)
 {
 	return (XENA_REG_SPACE);
 }
 
 
-u32 s2io_ethtool_get_rx_csum(struct net_device * dev)
+static u32 s2io_ethtool_get_rx_csum(struct net_device * dev)
 {
 	nic_t *sp = dev->priv;
 
 	return (sp->rx_csum);
 }
-int s2io_ethtool_set_rx_csum(struct net_device *dev, u32 data)
+
+static int s2io_ethtool_set_rx_csum(struct net_device *dev, u32 data)
 {
 	nic_t *sp = dev->priv;
 
@@ -3979,17 +3980,19 @@
 
 	return 0;
 }
-int s2io_get_eeprom_len(struct net_device *dev)
+
+static int s2io_get_eeprom_len(struct net_device *dev)
 {
 	return (XENA_EEPROM_SPACE);
 }
 
-int s2io_ethtool_self_test_count(struct net_device *dev)
+static int s2io_ethtool_self_test_count(struct net_device *dev)
 {
 	return (S2IO_TEST_LEN);
 }
-void s2io_ethtool_get_strings(struct net_device *dev,
-			      u32 stringset, u8 * data)
+
+static void s2io_ethtool_get_strings(struct net_device *dev,
+				     u32 stringset, u8 * data)
 {
 	switch (stringset) {
 	case ETH_SS_TEST:
@@ -4000,12 +4003,13 @@
 		       sizeof(ethtool_stats_keys));
 	}
 }
+
 static int s2io_ethtool_get_stats_count(struct net_device *dev)
 {
 	return (S2IO_STAT_LEN);
 }
 
-int s2io_ethtool_op_set_tx_csum(struct net_device *dev, u32 data)
+static int s2io_ethtool_op_set_tx_csum(struct net_device *dev, u32 data)
 {
 	if (data)
 		dev->features |= NETIF_F_IP_CSUM;
@@ -4061,7 +4065,7 @@
  *  function returns OP NOT SUPPORTED value.
  */
 
-int s2io_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+static int s2io_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	return -EOPNOTSUPP;
 }
@@ -4077,7 +4081,7 @@
  *   file on failure.
  */
 
-int s2io_change_mtu(struct net_device *dev, int new_mtu)
+static int s2io_change_mtu(struct net_device *dev, int new_mtu)
 {
 	nic_t *sp = dev->priv;
 	XENA_dev_config_t __iomem *bar0 = sp->bar0;
@@ -4471,7 +4475,7 @@
  *  void.
  */
 
-void s2io_link(nic_t * sp, int link)
+static void s2io_link(nic_t * sp, int link)
 {
 	struct net_device *dev = (struct net_device *) sp->dev;
 
@@ -4488,23 +4492,6 @@
 }
 
 /**
- *  get_xena_rev_id - to identify revision ID of xena. 
- *  @pdev : PCI Dev structure
- *  Description:
- *  Function to identify the Revision ID of xena.
- *  Return value:
- *  returns the revision ID of the device.
- */
-
-int get_xena_rev_id(struct pci_dev *pdev)
-{
-	u8 id = 0;
-	int ret;
-	ret = pci_read_config_byte(pdev, PCI_REVISION_ID, (u8 *) & id);
-	return id;
-}
-
-/**
  *  s2io_init_pci -Initialization of PCI and PCI-X configuration registers . 
  *  @sp : private member of the device structure, which is a pointer to the 
  *  s2io_nic structure.
@@ -4957,7 +4944,7 @@
  * Description: This function is the cleanup routine for the driver. It unregist * ers the driver.
  */
 
-void s2io_closer(void)
+static void s2io_closer(void)
 {
 	pci_unregister_driver(&s2io_driver);
 	DBG_PRINT(INIT_DBG, "cleanup done\n");

