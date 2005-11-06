Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbVKFAqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVKFAqu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 19:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbVKFAqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 19:46:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6413 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932251AbVKFAqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 19:46:48 -0500
Date: Sun, 6 Nov 2005 01:46:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/s2io.c: make functions static
Message-ID: <20051106004647.GD3668@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes needlessly global functions static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/s2io.c |   43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

--- linux-2.6.14-rc5-mm1-full/drivers/net/s2io.c.old	2005-11-06 00:19:48.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/net/s2io.c	2005-11-06 00:25:39.000000000 +0100
@@ -1515,7 +1515,7 @@
 #define LINK_UP_DOWN_INTERRUPT		1
 #define MAC_RMAC_ERR_TIMER		2
 
-int s2io_link_fault_indication(nic_t *nic)
+static int s2io_link_fault_indication(nic_t *nic)
 {
 	if (nic->intr_type != INTA)
 		return MAC_RMAC_ERR_TIMER;
@@ -1847,7 +1847,7 @@
  *
  */
 
-void fix_mac_address(nic_t * sp)
+static void fix_mac_address(nic_t * sp)
 {
 	XENA_dev_config_t __iomem *bar0 = sp->bar0;
 	u64 val64;
@@ -2111,7 +2111,7 @@
  *  SUCCESS on success or an appropriate -ve value on failure.
  */
 
-int fill_rx_buffers(struct s2io_nic *nic, int ring_no)
+static int fill_rx_buffers(struct s2io_nic *nic, int ring_no)
 {
 	struct net_device *dev = nic->dev;
 	struct sk_buff *skb;
@@ -2796,7 +2796,7 @@
  *   SUCCESS on success and FAILURE on failure.
  */
 
-int wait_for_cmd_complete(nic_t * sp)
+static int wait_for_cmd_complete(nic_t * sp)
 {
 	XENA_dev_config_t __iomem *bar0 = sp->bar0;
 	int ret = FAILURE, cnt = 0;
@@ -3042,7 +3042,7 @@
 	return SUCCESS;
 }
 
-int wait_for_msix_trans(nic_t *nic, int i)
+static int wait_for_msix_trans(nic_t *nic, int i)
 {
 	XENA_dev_config_t *bar0 = (XENA_dev_config_t *) nic->bar0;
 	u64 val64;
@@ -3081,7 +3081,7 @@
 	}
 }
 
-void store_xmsi_data(nic_t *nic)
+static void store_xmsi_data(nic_t *nic)
 {
 	XENA_dev_config_t *bar0 = (XENA_dev_config_t *) nic->bar0;
 	u64 val64, addr, data;
@@ -3253,7 +3253,7 @@
  *   file on failure.
  */
 
-int s2io_open(struct net_device *dev)
+static int s2io_open(struct net_device *dev)
 {
 	nic_t *sp = dev->priv;
 	int err = 0;
@@ -3383,7 +3383,7 @@
  *  file on failure.
  */
 
-int s2io_close(struct net_device *dev)
+static int s2io_close(struct net_device *dev)
 {
 	nic_t *sp = dev->priv;
 	int i;
@@ -3432,7 +3432,7 @@
  *  0 on success & 1 on failure.
  */
 
-int s2io_xmit(struct sk_buff *skb, struct net_device *dev)
+static int s2io_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	nic_t *sp = dev->priv;
 	u16 frg_cnt, frg_len, i, queue, queue_len, put_off, get_off;
@@ -3878,7 +3878,7 @@
  *  pointer to the updated net_device_stats structure.
  */
 
-struct net_device_stats *s2io_get_stats(struct net_device *dev)
+static struct net_device_stats *s2io_get_stats(struct net_device *dev)
 {
 	nic_t *sp = dev->priv;
 	mac_info_t *mac_control;
@@ -5071,19 +5071,20 @@
 	tmp_stats[i++] = stat_info->sw_stat.double_ecc_errs;
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
 
@@ -5094,17 +5095,19 @@
 
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
@@ -5120,7 +5123,7 @@
 	return (S2IO_STAT_LEN);
 }
 
-int s2io_ethtool_op_set_tx_csum(struct net_device *dev, u32 data)
+static int s2io_ethtool_op_set_tx_csum(struct net_device *dev, u32 data)
 {
 	if (data)
 		dev->features |= NETIF_F_IP_CSUM;
@@ -5173,7 +5176,7 @@
  *  function always return EOPNOTSUPPORTED
  */
 
-int s2io_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+static int s2io_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	return -EOPNOTSUPP;
 }
@@ -5189,7 +5192,7 @@
  *   file on failure.
  */
 
-int s2io_change_mtu(struct net_device *dev, int new_mtu)
+static int s2io_change_mtu(struct net_device *dev, int new_mtu)
 {
 	nic_t *sp = dev->priv;
 

