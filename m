Return-Path: <linux-kernel-owner+w=401wt.eu-S932844AbWLZWqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932844AbWLZWqx (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 17:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932839AbWLZWqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 17:46:53 -0500
Received: from havoc.gtf.org ([69.61.125.42]:57381 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932838AbWLZWqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 17:46:48 -0500
Date: Tue, 26 Dec 2006 17:46:46 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] net driver fixes
Message-ID: <20061226224646.GA10417@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note that this is a completely separate branch from 'netxen-ioctl',
submitted separately.  Each can be pulled (or not) independently.  I
mention this mainly because this submit also includes [non-conflicting]
NetXen changes.

Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-linus

to receive the following updates:

 drivers/net/8139cp.c                           |    6 +-
 drivers/net/arm/ep93xx_eth.c                   |    4 +-
 drivers/net/b44.c                              |    6 +-
 drivers/net/e1000/e1000_ethtool.c              |    3 +
 drivers/net/e1000/e1000_hw.c                   |  296 +++++++++++----------
 drivers/net/e1000/e1000_hw.h                   |  310 +++++++++++-----------
 drivers/net/e1000/e1000_main.c                 |  345 +++++++++++++++++-------
 drivers/net/e1000/e1000_param.c                |    4 +-
 drivers/net/forcedeth.c                        |   16 +-
 drivers/net/ibm_emac/ibm_emac_phy.c            |    4 +-
 drivers/net/myri10ge/myri10ge.c                |  163 ++++++------
 drivers/net/netxen/netxen_nic.h                |   14 +-
 drivers/net/netxen/netxen_nic_hw.c             |    2 +-
 drivers/net/netxen/netxen_nic_init.c           |   14 +-
 drivers/net/netxen/netxen_nic_isr.c            |    3 +-
 drivers/net/netxen/netxen_nic_main.c           |   40 ++--
 drivers/net/r8169.c                            |    6 +-
 drivers/net/skge.c                             |    5 +-
 drivers/net/sky2.c                             |   35 +++-
 drivers/net/via-velocity.c                     |   18 +-
 drivers/net/wireless/zd1211rw/zd_mac.c         |   96 +++++--
 drivers/net/wireless/zd1211rw/zd_mac.h         |    5 +-
 drivers/net/wireless/zd1211rw/zd_usb.c         |    4 +-
 net/ieee80211/softmac/ieee80211softmac_assoc.c |    4 +-
 net/ieee80211/softmac/ieee80211softmac_wx.c    |    2 +-
 25 files changed, 830 insertions(+), 575 deletions(-)

Amit S. Kale (8):
      NetXen: Adding new device ids.
      NetXen: driver reload fix for newer firmware.
      NetXen: Using correct CHECKSUM flag.
      NetXen: Multiple adapter fix.
      NetXen: Link status message correction for quad port cards.
      NetXen: work queue fixes.
      NetXen: Fix for PPC machines.
      NetXen: Reducing ring sizes for IOMMU issue.

Ayaz Abdulla (1):
      forcedeth: modified comment header

Brice Goglin (5):
      myri10ge: match number of save_state and restore
      myri10ge: move request_irq to myri10ge_open
      myri10ge: make msi configurable at runtime through sysfs
      myri10ge: no need to save MSI and PCIe state in the driver
      myri10ge: handle failures in suspend and resume

Bruce Allan (2):
      e1000: fix to set the new max frame size before resetting the adapter
      e1000: Fix PBA allocation calculations

Francois Romieu (3):
      netpoll: drivers must not enable IRQ unconditionally in their NAPI handler
      r8169: use the broken_parity_status field in pci_dev
      r8169: extraneous Cmd{Tx/Rx}Enb write

Herbert Xu (1):
      e1000: Do not truncate TSO TCP header with 82544 workaround

Hynek Petrak (1):
      PHY probe not working properly for ibm_emac (PPC4xx)

Jeff Garzik (5):
      e1000: For sanity, reformat e1000_set_mac_type(), struct e1000_hw[_stats]
      e1000: omit stats for broken counter in 82543
      e1000: consolidate managability enabling/disabling
      e1000: workaround for the ESB2 NIC RX unit issue
      e1000: 3 new driver stats for managability testing

Jeff Kirsher (1):
      e1000: fix ethtool reported bus type for older adapters

Jesse Brandeburg (7):
      e1000: The user-supplied itr setting needs the lower 2 bits masked off
      e1000: dynamic itr: take TSO and jumbo into account
      e1000: Fix Wake-on-Lan with forced gigabit speed
      e1000: disable TSO on the 82544 with slab debugging
      e1000: narrow down the scope of the tipg timer tweak
      e1000: Make the copybreak value a module parameter
      e1000: No-delay link detection at interface up

Randy Dunlap (1):
      via-velocity uses INET interfaces

Stephen Hemminger (3):
      sky2: dual port NAPI problem
      sky2: power management/MSI workaround
      sky2: phy power down needs PCI config write enabled

Ulrich Kunitz (3):
      zd1211rw: Call ieee80211_rx in tasklet
      ieee80211softmac: Fix errors related to the work_struct changes
      ieee80211softmac: Fix mutex_lock at exit of ieee80211_softmac_get_genie

Yan Burman (1):
      ep93xx: some minor cleanups to the ep93xx eth driver

diff --git a/drivers/net/8139cp.c b/drivers/net/8139cp.c
index 458dd9f..e2cb19b 100644
--- a/drivers/net/8139cp.c
+++ b/drivers/net/8139cp.c
@@ -617,13 +617,15 @@ rx_next:
 	 * this round of polling
 	 */
 	if (rx_work) {
+		unsigned long flags;
+
 		if (cpr16(IntrStatus) & cp_rx_intr_mask)
 			goto rx_status_loop;
 
-		local_irq_disable();
+		local_irq_save(flags);
 		cpw16_f(IntrMask, cp_intr_mask);
 		__netif_rx_complete(dev);
-		local_irq_enable();
+		local_irq_restore(flags);
 
 		return 0;	/* done */
 	}
diff --git a/drivers/net/arm/ep93xx_eth.c b/drivers/net/arm/ep93xx_eth.c
index 8ebd68e..dd698b0 100644
--- a/drivers/net/arm/ep93xx_eth.c
+++ b/drivers/net/arm/ep93xx_eth.c
@@ -780,12 +780,10 @@ static struct ethtool_ops ep93xx_ethtool_ops = {
 struct net_device *ep93xx_dev_alloc(struct ep93xx_eth_data *data)
 {
 	struct net_device *dev;
-	struct ep93xx_priv *ep;
 
 	dev = alloc_etherdev(sizeof(struct ep93xx_priv));
 	if (dev == NULL)
 		return NULL;
-	ep = netdev_priv(dev);
 
 	memcpy(dev->dev_addr, data->dev_addr, ETH_ALEN);
 
@@ -840,9 +838,9 @@ static int ep93xx_eth_probe(struct platform_device *pdev)
 	struct ep93xx_priv *ep;
 	int err;
 
-	data = pdev->dev.platform_data;
 	if (pdev == NULL)
 		return -ENODEV;
+	data = pdev->dev.platform_data;
 
 	dev = ep93xx_dev_alloc(data);
 	if (dev == NULL) {
diff --git a/drivers/net/b44.c b/drivers/net/b44.c
index 474a4e3..5eb2ec6 100644
--- a/drivers/net/b44.c
+++ b/drivers/net/b44.c
@@ -879,12 +879,14 @@ static int b44_poll(struct net_device *netdev, int *budget)
 	}
 
 	if (bp->istat & ISTAT_ERRORS) {
-		spin_lock_irq(&bp->lock);
+		unsigned long flags;
+
+		spin_lock_irqsave(&bp->lock, flags);
 		b44_halt(bp);
 		b44_init_rings(bp);
 		b44_init_hw(bp, 1);
 		netif_wake_queue(bp->dev);
-		spin_unlock_irq(&bp->lock);
+		spin_unlock_irqrestore(&bp->lock, flags);
 		done = 1;
 	}
 
diff --git a/drivers/net/e1000/e1000_ethtool.c b/drivers/net/e1000/e1000_ethtool.c
index da459f7..fb96c87 100644
--- a/drivers/net/e1000/e1000_ethtool.c
+++ b/drivers/net/e1000/e1000_ethtool.c
@@ -100,6 +100,9 @@ static const struct e1000_stats e1000_gstrings_stats[] = {
 	{ "rx_csum_offload_errors", E1000_STAT(hw_csum_err) },
 	{ "rx_header_split", E1000_STAT(rx_hdr_split) },
 	{ "alloc_rx_buff_failed", E1000_STAT(alloc_rx_buff_failed) },
+	{ "tx_smbus", E1000_STAT(stats.mgptc) },
+	{ "rx_smbus", E1000_STAT(stats.mgprc) },
+	{ "dropped_smbus", E1000_STAT(stats.mgpdc) },
 };
 
 #define E1000_QUEUE_STATS_LEN 0
diff --git a/drivers/net/e1000/e1000_hw.c b/drivers/net/e1000/e1000_hw.c
index 3655d90..9be4469 100644
--- a/drivers/net/e1000/e1000_hw.c
+++ b/drivers/net/e1000/e1000_hw.c
@@ -308,141 +308,160 @@ e1000_phy_init_script(struct e1000_hw *hw)
 int32_t
 e1000_set_mac_type(struct e1000_hw *hw)
 {
-    DEBUGFUNC("e1000_set_mac_type");
-
-    switch (hw->device_id) {
-    case E1000_DEV_ID_82542:
-        switch (hw->revision_id) {
-        case E1000_82542_2_0_REV_ID:
-            hw->mac_type = e1000_82542_rev2_0;
-            break;
-        case E1000_82542_2_1_REV_ID:
-            hw->mac_type = e1000_82542_rev2_1;
-            break;
-        default:
-            /* Invalid 82542 revision ID */
-            return -E1000_ERR_MAC_TYPE;
-        }
-        break;
-    case E1000_DEV_ID_82543GC_FIBER:
-    case E1000_DEV_ID_82543GC_COPPER:
-        hw->mac_type = e1000_82543;
-        break;
-    case E1000_DEV_ID_82544EI_COPPER:
-    case E1000_DEV_ID_82544EI_FIBER:
-    case E1000_DEV_ID_82544GC_COPPER:
-    case E1000_DEV_ID_82544GC_LOM:
-        hw->mac_type = e1000_82544;
-        break;
-    case E1000_DEV_ID_82540EM:
-    case E1000_DEV_ID_82540EM_LOM:
-    case E1000_DEV_ID_82540EP:
-    case E1000_DEV_ID_82540EP_LOM:
-    case E1000_DEV_ID_82540EP_LP:
-        hw->mac_type = e1000_82540;
-        break;
-    case E1000_DEV_ID_82545EM_COPPER:
-    case E1000_DEV_ID_82545EM_FIBER:
-        hw->mac_type = e1000_82545;
-        break;
-    case E1000_DEV_ID_82545GM_COPPER:
-    case E1000_DEV_ID_82545GM_FIBER:
-    case E1000_DEV_ID_82545GM_SERDES:
-        hw->mac_type = e1000_82545_rev_3;
-        break;
-    case E1000_DEV_ID_82546EB_COPPER:
-    case E1000_DEV_ID_82546EB_FIBER:
-    case E1000_DEV_ID_82546EB_QUAD_COPPER:
-        hw->mac_type = e1000_82546;
-        break;
-    case E1000_DEV_ID_82546GB_COPPER:
-    case E1000_DEV_ID_82546GB_FIBER:
-    case E1000_DEV_ID_82546GB_SERDES:
-    case E1000_DEV_ID_82546GB_PCIE:
-    case E1000_DEV_ID_82546GB_QUAD_COPPER:
-    case E1000_DEV_ID_82546GB_QUAD_COPPER_KSP3:
-        hw->mac_type = e1000_82546_rev_3;
-        break;
-    case E1000_DEV_ID_82541EI:
-    case E1000_DEV_ID_82541EI_MOBILE:
-    case E1000_DEV_ID_82541ER_LOM:
-        hw->mac_type = e1000_82541;
-        break;
-    case E1000_DEV_ID_82541ER:
-    case E1000_DEV_ID_82541GI:
-    case E1000_DEV_ID_82541GI_LF:
-    case E1000_DEV_ID_82541GI_MOBILE:
-        hw->mac_type = e1000_82541_rev_2;
-        break;
-    case E1000_DEV_ID_82547EI:
-    case E1000_DEV_ID_82547EI_MOBILE:
-        hw->mac_type = e1000_82547;
-        break;
-    case E1000_DEV_ID_82547GI:
-        hw->mac_type = e1000_82547_rev_2;
-        break;
-    case E1000_DEV_ID_82571EB_COPPER:
-    case E1000_DEV_ID_82571EB_FIBER:
-    case E1000_DEV_ID_82571EB_SERDES:
-    case E1000_DEV_ID_82571EB_QUAD_COPPER:
-    case E1000_DEV_ID_82571EB_QUAD_COPPER_LOWPROFILE:
-            hw->mac_type = e1000_82571;
-        break;
-    case E1000_DEV_ID_82572EI_COPPER:
-    case E1000_DEV_ID_82572EI_FIBER:
-    case E1000_DEV_ID_82572EI_SERDES:
-    case E1000_DEV_ID_82572EI:
-        hw->mac_type = e1000_82572;
-        break;
-    case E1000_DEV_ID_82573E:
-    case E1000_DEV_ID_82573E_IAMT:
-    case E1000_DEV_ID_82573L:
-        hw->mac_type = e1000_82573;
-        break;
-    case E1000_DEV_ID_80003ES2LAN_COPPER_SPT:
-    case E1000_DEV_ID_80003ES2LAN_SERDES_SPT:
-    case E1000_DEV_ID_80003ES2LAN_COPPER_DPT:
-    case E1000_DEV_ID_80003ES2LAN_SERDES_DPT:
-        hw->mac_type = e1000_80003es2lan;
-        break;
-    case E1000_DEV_ID_ICH8_IGP_M_AMT:
-    case E1000_DEV_ID_ICH8_IGP_AMT:
-    case E1000_DEV_ID_ICH8_IGP_C:
-    case E1000_DEV_ID_ICH8_IFE:
-    case E1000_DEV_ID_ICH8_IFE_GT:
-    case E1000_DEV_ID_ICH8_IFE_G:
-    case E1000_DEV_ID_ICH8_IGP_M:
-        hw->mac_type = e1000_ich8lan;
-        break;
-    default:
-        /* Should never have loaded on this device */
-        return -E1000_ERR_MAC_TYPE;
-    }
-
-    switch (hw->mac_type) {
-    case e1000_ich8lan:
-        hw->swfwhw_semaphore_present = TRUE;
-        hw->asf_firmware_present = TRUE;
-        break;
-    case e1000_80003es2lan:
-        hw->swfw_sync_present = TRUE;
-        /* fall through */
-    case e1000_82571:
-    case e1000_82572:
-    case e1000_82573:
-        hw->eeprom_semaphore_present = TRUE;
-        /* fall through */
-    case e1000_82541:
-    case e1000_82547:
-    case e1000_82541_rev_2:
-    case e1000_82547_rev_2:
-        hw->asf_firmware_present = TRUE;
-        break;
-    default:
-        break;
-    }
-
-    return E1000_SUCCESS;
+	DEBUGFUNC("e1000_set_mac_type");
+
+	switch (hw->device_id) {
+	case E1000_DEV_ID_82542:
+		switch (hw->revision_id) {
+		case E1000_82542_2_0_REV_ID:
+			hw->mac_type = e1000_82542_rev2_0;
+			break;
+		case E1000_82542_2_1_REV_ID:
+			hw->mac_type = e1000_82542_rev2_1;
+			break;
+		default:
+			/* Invalid 82542 revision ID */
+			return -E1000_ERR_MAC_TYPE;
+		}
+		break;
+	case E1000_DEV_ID_82543GC_FIBER:
+	case E1000_DEV_ID_82543GC_COPPER:
+		hw->mac_type = e1000_82543;
+		break;
+	case E1000_DEV_ID_82544EI_COPPER:
+	case E1000_DEV_ID_82544EI_FIBER:
+	case E1000_DEV_ID_82544GC_COPPER:
+	case E1000_DEV_ID_82544GC_LOM:
+		hw->mac_type = e1000_82544;
+		break;
+	case E1000_DEV_ID_82540EM:
+	case E1000_DEV_ID_82540EM_LOM:
+	case E1000_DEV_ID_82540EP:
+	case E1000_DEV_ID_82540EP_LOM:
+	case E1000_DEV_ID_82540EP_LP:
+		hw->mac_type = e1000_82540;
+		break;
+	case E1000_DEV_ID_82545EM_COPPER:
+	case E1000_DEV_ID_82545EM_FIBER:
+		hw->mac_type = e1000_82545;
+		break;
+	case E1000_DEV_ID_82545GM_COPPER:
+	case E1000_DEV_ID_82545GM_FIBER:
+	case E1000_DEV_ID_82545GM_SERDES:
+		hw->mac_type = e1000_82545_rev_3;
+		break;
+	case E1000_DEV_ID_82546EB_COPPER:
+	case E1000_DEV_ID_82546EB_FIBER:
+	case E1000_DEV_ID_82546EB_QUAD_COPPER:
+		hw->mac_type = e1000_82546;
+		break;
+	case E1000_DEV_ID_82546GB_COPPER:
+	case E1000_DEV_ID_82546GB_FIBER:
+	case E1000_DEV_ID_82546GB_SERDES:
+	case E1000_DEV_ID_82546GB_PCIE:
+	case E1000_DEV_ID_82546GB_QUAD_COPPER:
+	case E1000_DEV_ID_82546GB_QUAD_COPPER_KSP3:
+		hw->mac_type = e1000_82546_rev_3;
+		break;
+	case E1000_DEV_ID_82541EI:
+	case E1000_DEV_ID_82541EI_MOBILE:
+	case E1000_DEV_ID_82541ER_LOM:
+		hw->mac_type = e1000_82541;
+		break;
+	case E1000_DEV_ID_82541ER:
+	case E1000_DEV_ID_82541GI:
+	case E1000_DEV_ID_82541GI_LF:
+	case E1000_DEV_ID_82541GI_MOBILE:
+		hw->mac_type = e1000_82541_rev_2;
+		break;
+	case E1000_DEV_ID_82547EI:
+	case E1000_DEV_ID_82547EI_MOBILE:
+		hw->mac_type = e1000_82547;
+		break;
+	case E1000_DEV_ID_82547GI:
+		hw->mac_type = e1000_82547_rev_2;
+		break;
+	case E1000_DEV_ID_82571EB_COPPER:
+	case E1000_DEV_ID_82571EB_FIBER:
+	case E1000_DEV_ID_82571EB_SERDES:
+	case E1000_DEV_ID_82571EB_QUAD_COPPER:
+	case E1000_DEV_ID_82571EB_QUAD_COPPER_LOWPROFILE:
+		hw->mac_type = e1000_82571;
+		break;
+	case E1000_DEV_ID_82572EI_COPPER:
+	case E1000_DEV_ID_82572EI_FIBER:
+	case E1000_DEV_ID_82572EI_SERDES:
+	case E1000_DEV_ID_82572EI:
+		hw->mac_type = e1000_82572;
+		break;
+	case E1000_DEV_ID_82573E:
+	case E1000_DEV_ID_82573E_IAMT:
+	case E1000_DEV_ID_82573L:
+		hw->mac_type = e1000_82573;
+		break;
+	case E1000_DEV_ID_80003ES2LAN_COPPER_SPT:
+	case E1000_DEV_ID_80003ES2LAN_SERDES_SPT:
+	case E1000_DEV_ID_80003ES2LAN_COPPER_DPT:
+	case E1000_DEV_ID_80003ES2LAN_SERDES_DPT:
+		hw->mac_type = e1000_80003es2lan;
+		break;
+	case E1000_DEV_ID_ICH8_IGP_M_AMT:
+	case E1000_DEV_ID_ICH8_IGP_AMT:
+	case E1000_DEV_ID_ICH8_IGP_C:
+	case E1000_DEV_ID_ICH8_IFE:
+	case E1000_DEV_ID_ICH8_IFE_GT:
+	case E1000_DEV_ID_ICH8_IFE_G:
+	case E1000_DEV_ID_ICH8_IGP_M:
+		hw->mac_type = e1000_ich8lan;
+		break;
+	default:
+		/* Should never have loaded on this device */
+		return -E1000_ERR_MAC_TYPE;
+	}
+
+	switch (hw->mac_type) {
+	case e1000_ich8lan:
+		hw->swfwhw_semaphore_present = TRUE;
+		hw->asf_firmware_present = TRUE;
+		break;
+	case e1000_80003es2lan:
+		hw->swfw_sync_present = TRUE;
+		/* fall through */
+	case e1000_82571:
+	case e1000_82572:
+	case e1000_82573:
+		hw->eeprom_semaphore_present = TRUE;
+		/* fall through */
+	case e1000_82541:
+	case e1000_82547:
+	case e1000_82541_rev_2:
+	case e1000_82547_rev_2:
+		hw->asf_firmware_present = TRUE;
+		break;
+	default:
+		break;
+	}
+
+	/* The 82543 chip does not count tx_carrier_errors properly in
+	 * FD mode
+	 */
+	if (hw->mac_type == e1000_82543)
+		hw->bad_tx_carr_stats_fd = TRUE;
+
+	/* capable of receiving management packets to the host */
+	if (hw->mac_type >= e1000_82571)
+		hw->has_manc2h = TRUE;
+
+	/* In rare occasions, ESB2 systems would end up started without
+	 * the RX unit being turned on.
+	 */
+	if (hw->mac_type == e1000_80003es2lan)
+		hw->rx_needs_kicking = TRUE;
+
+	if (hw->mac_type > e1000_82544)
+		hw->has_smbus = TRUE;
+
+	return E1000_SUCCESS;
 }
 
 /*****************************************************************************
@@ -6575,7 +6594,7 @@ e1000_get_bus_info(struct e1000_hw *hw)
     switch (hw->mac_type) {
     case e1000_82542_rev2_0:
     case e1000_82542_rev2_1:
-        hw->bus_type = e1000_bus_type_unknown;
+        hw->bus_type = e1000_bus_type_pci;
         hw->bus_speed = e1000_bus_speed_unknown;
         hw->bus_width = e1000_bus_width_unknown;
         break;
@@ -7817,9 +7836,8 @@ e1000_enable_mng_pass_thru(struct e1000_hw *hw)
             fwsm = E1000_READ_REG(hw, FWSM);
             factps = E1000_READ_REG(hw, FACTPS);
 
-            if (((fwsm & E1000_FWSM_MODE_MASK) ==
-                (e1000_mng_mode_pt << E1000_FWSM_MODE_SHIFT)) &&
-                (factps & E1000_FACTPS_MNGCG))
+            if ((((fwsm & E1000_FWSM_MODE_MASK) >> E1000_FWSM_MODE_SHIFT) ==
+                   e1000_mng_mode_pt) && !(factps & E1000_FACTPS_MNGCG))
                 return TRUE;
         } else
             if ((manc & E1000_MANC_SMBUS_EN) && !(manc & E1000_MANC_ASF_EN))
diff --git a/drivers/net/e1000/e1000_hw.h b/drivers/net/e1000/e1000_hw.h
index 3321fb1..d671058 100644
--- a/drivers/net/e1000/e1000_hw.h
+++ b/drivers/net/e1000/e1000_hw.h
@@ -1301,165 +1301,170 @@ struct e1000_ffvt_entry {
 #define E1000_82542_RSSIR       E1000_RSSIR
 #define E1000_82542_KUMCTRLSTA E1000_KUMCTRLSTA
 #define E1000_82542_SW_FW_SYNC E1000_SW_FW_SYNC
+#define E1000_82542_MANC2H      E1000_MANC2H
 
 /* Statistics counters collected by the MAC */
 struct e1000_hw_stats {
-    uint64_t crcerrs;
-    uint64_t algnerrc;
-    uint64_t symerrs;
-    uint64_t rxerrc;
-    uint64_t txerrc;
-    uint64_t mpc;
-    uint64_t scc;
-    uint64_t ecol;
-    uint64_t mcc;
-    uint64_t latecol;
-    uint64_t colc;
-    uint64_t dc;
-    uint64_t tncrs;
-    uint64_t sec;
-    uint64_t cexterr;
-    uint64_t rlec;
-    uint64_t xonrxc;
-    uint64_t xontxc;
-    uint64_t xoffrxc;
-    uint64_t xofftxc;
-    uint64_t fcruc;
-    uint64_t prc64;
-    uint64_t prc127;
-    uint64_t prc255;
-    uint64_t prc511;
-    uint64_t prc1023;
-    uint64_t prc1522;
-    uint64_t gprc;
-    uint64_t bprc;
-    uint64_t mprc;
-    uint64_t gptc;
-    uint64_t gorcl;
-    uint64_t gorch;
-    uint64_t gotcl;
-    uint64_t gotch;
-    uint64_t rnbc;
-    uint64_t ruc;
-    uint64_t rfc;
-    uint64_t roc;
-    uint64_t rlerrc;
-    uint64_t rjc;
-    uint64_t mgprc;
-    uint64_t mgpdc;
-    uint64_t mgptc;
-    uint64_t torl;
-    uint64_t torh;
-    uint64_t totl;
-    uint64_t toth;
-    uint64_t tpr;
-    uint64_t tpt;
-    uint64_t ptc64;
-    uint64_t ptc127;
-    uint64_t ptc255;
-    uint64_t ptc511;
-    uint64_t ptc1023;
-    uint64_t ptc1522;
-    uint64_t mptc;
-    uint64_t bptc;
-    uint64_t tsctc;
-    uint64_t tsctfc;
-    uint64_t iac;
-    uint64_t icrxptc;
-    uint64_t icrxatc;
-    uint64_t ictxptc;
-    uint64_t ictxatc;
-    uint64_t ictxqec;
-    uint64_t ictxqmtc;
-    uint64_t icrxdmtc;
-    uint64_t icrxoc;
+	uint64_t		crcerrs;
+	uint64_t		algnerrc;
+	uint64_t		symerrs;
+	uint64_t		rxerrc;
+	uint64_t		txerrc;
+	uint64_t		mpc;
+	uint64_t		scc;
+	uint64_t		ecol;
+	uint64_t		mcc;
+	uint64_t		latecol;
+	uint64_t		colc;
+	uint64_t		dc;
+	uint64_t		tncrs;
+	uint64_t		sec;
+	uint64_t		cexterr;
+	uint64_t		rlec;
+	uint64_t		xonrxc;
+	uint64_t		xontxc;
+	uint64_t		xoffrxc;
+	uint64_t		xofftxc;
+	uint64_t		fcruc;
+	uint64_t		prc64;
+	uint64_t		prc127;
+	uint64_t		prc255;
+	uint64_t		prc511;
+	uint64_t		prc1023;
+	uint64_t		prc1522;
+	uint64_t		gprc;
+	uint64_t		bprc;
+	uint64_t		mprc;
+	uint64_t		gptc;
+	uint64_t		gorcl;
+	uint64_t		gorch;
+	uint64_t		gotcl;
+	uint64_t		gotch;
+	uint64_t		rnbc;
+	uint64_t		ruc;
+	uint64_t		rfc;
+	uint64_t		roc;
+	uint64_t		rlerrc;
+	uint64_t		rjc;
+	uint64_t		mgprc;
+	uint64_t		mgpdc;
+	uint64_t		mgptc;
+	uint64_t		torl;
+	uint64_t		torh;
+	uint64_t		totl;
+	uint64_t		toth;
+	uint64_t		tpr;
+	uint64_t		tpt;
+	uint64_t		ptc64;
+	uint64_t		ptc127;
+	uint64_t		ptc255;
+	uint64_t		ptc511;
+	uint64_t		ptc1023;
+	uint64_t		ptc1522;
+	uint64_t		mptc;
+	uint64_t		bptc;
+	uint64_t		tsctc;
+	uint64_t		tsctfc;
+	uint64_t		iac;
+	uint64_t		icrxptc;
+	uint64_t		icrxatc;
+	uint64_t		ictxptc;
+	uint64_t		ictxatc;
+	uint64_t		ictxqec;
+	uint64_t		ictxqmtc;
+	uint64_t		icrxdmtc;
+	uint64_t		icrxoc;
 };
 
 /* Structure containing variables used by the shared code (e1000_hw.c) */
 struct e1000_hw {
-    uint8_t __iomem *hw_addr;
-    uint8_t __iomem *flash_address;
-    e1000_mac_type mac_type;
-    e1000_phy_type phy_type;
-    uint32_t phy_init_script;
-    e1000_media_type media_type;
-    void *back;
-    struct e1000_shadow_ram *eeprom_shadow_ram;
-    uint32_t flash_bank_size;
-    uint32_t flash_base_addr;
-    e1000_fc_type fc;
-    e1000_bus_speed bus_speed;
-    e1000_bus_width bus_width;
-    e1000_bus_type bus_type;
-    struct e1000_eeprom_info eeprom;
-    e1000_ms_type master_slave;
-    e1000_ms_type original_master_slave;
-    e1000_ffe_config ffe_config_state;
-    uint32_t asf_firmware_present;
-    uint32_t eeprom_semaphore_present;
-    uint32_t swfw_sync_present;
-    uint32_t swfwhw_semaphore_present;
-    unsigned long io_base;
-    uint32_t phy_id;
-    uint32_t phy_revision;
-    uint32_t phy_addr;
-    uint32_t original_fc;
-    uint32_t txcw;
-    uint32_t autoneg_failed;
-    uint32_t max_frame_size;
-    uint32_t min_frame_size;
-    uint32_t mc_filter_type;
-    uint32_t num_mc_addrs;
-    uint32_t collision_delta;
-    uint32_t tx_packet_delta;
-    uint32_t ledctl_default;
-    uint32_t ledctl_mode1;
-    uint32_t ledctl_mode2;
-    boolean_t tx_pkt_filtering;
-    struct e1000_host_mng_dhcp_cookie mng_cookie;
-    uint16_t phy_spd_default;
-    uint16_t autoneg_advertised;
-    uint16_t pci_cmd_word;
-    uint16_t fc_high_water;
-    uint16_t fc_low_water;
-    uint16_t fc_pause_time;
-    uint16_t current_ifs_val;
-    uint16_t ifs_min_val;
-    uint16_t ifs_max_val;
-    uint16_t ifs_step_size;
-    uint16_t ifs_ratio;
-    uint16_t device_id;
-    uint16_t vendor_id;
-    uint16_t subsystem_id;
-    uint16_t subsystem_vendor_id;
-    uint8_t revision_id;
-    uint8_t autoneg;
-    uint8_t mdix;
-    uint8_t forced_speed_duplex;
-    uint8_t wait_autoneg_complete;
-    uint8_t dma_fairness;
-    uint8_t mac_addr[NODE_ADDRESS_SIZE];
-    uint8_t perm_mac_addr[NODE_ADDRESS_SIZE];
-    boolean_t disable_polarity_correction;
-    boolean_t speed_downgraded;
-    e1000_smart_speed smart_speed;
-    e1000_dsp_config dsp_config_state;
-    boolean_t get_link_status;
-    boolean_t serdes_link_down;
-    boolean_t tbi_compatibility_en;
-    boolean_t tbi_compatibility_on;
-    boolean_t laa_is_present;
-    boolean_t phy_reset_disable;
-    boolean_t initialize_hw_bits_disable;
-    boolean_t fc_send_xon;
-    boolean_t fc_strict_ieee;
-    boolean_t report_tx_early;
-    boolean_t adaptive_ifs;
-    boolean_t ifs_params_forced;
-    boolean_t in_ifs_mode;
-    boolean_t mng_reg_access_disabled;
-    boolean_t leave_av_bit_off;
-    boolean_t kmrn_lock_loss_workaround_disabled;
+	uint8_t __iomem		*hw_addr;
+	uint8_t __iomem		*flash_address;
+	e1000_mac_type		mac_type;
+	e1000_phy_type		phy_type;
+	uint32_t		phy_init_script;
+	e1000_media_type	media_type;
+	void			*back;
+	struct e1000_shadow_ram	*eeprom_shadow_ram;
+	uint32_t		flash_bank_size;
+	uint32_t		flash_base_addr;
+	e1000_fc_type		fc;
+	e1000_bus_speed		bus_speed;
+	e1000_bus_width		bus_width;
+	e1000_bus_type		bus_type;
+	struct e1000_eeprom_info eeprom;
+	e1000_ms_type		master_slave;
+	e1000_ms_type		original_master_slave;
+	e1000_ffe_config	ffe_config_state;
+	uint32_t		asf_firmware_present;
+	uint32_t		eeprom_semaphore_present;
+	uint32_t		swfw_sync_present;
+	uint32_t		swfwhw_semaphore_present;
+	unsigned long		io_base;
+	uint32_t		phy_id;
+	uint32_t		phy_revision;
+	uint32_t		phy_addr;
+	uint32_t		original_fc;
+	uint32_t		txcw;
+	uint32_t		autoneg_failed;
+	uint32_t		max_frame_size;
+	uint32_t		min_frame_size;
+	uint32_t		mc_filter_type;
+	uint32_t		num_mc_addrs;
+	uint32_t		collision_delta;
+	uint32_t		tx_packet_delta;
+	uint32_t		ledctl_default;
+	uint32_t		ledctl_mode1;
+	uint32_t		ledctl_mode2;
+	boolean_t		tx_pkt_filtering;
+	struct e1000_host_mng_dhcp_cookie mng_cookie;
+	uint16_t		phy_spd_default;
+	uint16_t		autoneg_advertised;
+	uint16_t		pci_cmd_word;
+	uint16_t		fc_high_water;
+	uint16_t		fc_low_water;
+	uint16_t		fc_pause_time;
+	uint16_t		current_ifs_val;
+	uint16_t		ifs_min_val;
+	uint16_t		ifs_max_val;
+	uint16_t		ifs_step_size;
+	uint16_t		ifs_ratio;
+	uint16_t		device_id;
+	uint16_t		vendor_id;
+	uint16_t		subsystem_id;
+	uint16_t		subsystem_vendor_id;
+	uint8_t			revision_id;
+	uint8_t			autoneg;
+	uint8_t			mdix;
+	uint8_t			forced_speed_duplex;
+	uint8_t			wait_autoneg_complete;
+	uint8_t			dma_fairness;
+	uint8_t			mac_addr[NODE_ADDRESS_SIZE];
+	uint8_t			perm_mac_addr[NODE_ADDRESS_SIZE];
+	boolean_t		disable_polarity_correction;
+	boolean_t		speed_downgraded;
+	e1000_smart_speed	smart_speed;
+	e1000_dsp_config	dsp_config_state;
+	boolean_t		get_link_status;
+	boolean_t		serdes_link_down;
+	boolean_t		tbi_compatibility_en;
+	boolean_t		tbi_compatibility_on;
+	boolean_t		laa_is_present;
+	boolean_t		phy_reset_disable;
+	boolean_t		initialize_hw_bits_disable;
+	boolean_t		fc_send_xon;
+	boolean_t		fc_strict_ieee;
+	boolean_t		report_tx_early;
+	boolean_t		adaptive_ifs;
+	boolean_t		ifs_params_forced;
+	boolean_t		in_ifs_mode;
+	boolean_t		mng_reg_access_disabled;
+	boolean_t		leave_av_bit_off;
+	boolean_t		kmrn_lock_loss_workaround_disabled;
+	boolean_t		bad_tx_carr_stats_fd;
+	boolean_t		has_manc2h;
+	boolean_t		rx_needs_kicking;
+	boolean_t		has_smbus;
 };
 
 
@@ -2418,6 +2423,7 @@ struct e1000_host_command_info {
 #define E1000_PBA_8K 0x0008    /* 8KB, default Rx allocation */
 #define E1000_PBA_12K 0x000C    /* 12KB, default Rx allocation */
 #define E1000_PBA_16K 0x0010    /* 16KB, default TX allocation */
+#define E1000_PBA_20K 0x0014
 #define E1000_PBA_22K 0x0016
 #define E1000_PBA_24K 0x0018
 #define E1000_PBA_30K 0x001E
diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index 73f3a85..4c1ff75 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -213,6 +213,12 @@ static void e1000_netpoll (struct net_device *netdev);
 
 extern void e1000_check_options(struct e1000_adapter *adapter);
 
+#define COPYBREAK_DEFAULT 256
+static unsigned int copybreak __read_mostly = COPYBREAK_DEFAULT;
+module_param(copybreak, uint, 0644);
+MODULE_PARM_DESC(copybreak,
+	"Maximum size of packet that is copied to a new buffer on receive");
+
 static pci_ers_result_t e1000_io_error_detected(struct pci_dev *pdev,
                      pci_channel_state_t state);
 static pci_ers_result_t e1000_io_slot_reset(struct pci_dev *pdev);
@@ -264,7 +270,13 @@ e1000_init_module(void)
 	printk(KERN_INFO "%s\n", e1000_copyright);
 
 	ret = pci_register_driver(&e1000_driver);
-
+	if (copybreak != COPYBREAK_DEFAULT) {
+		if (copybreak == 0)
+			printk(KERN_INFO "e1000: copybreak disabled\n");
+		else
+			printk(KERN_INFO "e1000: copybreak enabled for "
+			       "packets <= %u bytes\n", copybreak);
+	}
 	return ret;
 }
 
@@ -464,6 +476,52 @@ e1000_get_hw_control(struct e1000_adapter *adapter)
 	}
 }
 
+static void
+e1000_init_manageability(struct e1000_adapter *adapter)
+{
+	if (adapter->en_mng_pt) {
+		uint32_t manc = E1000_READ_REG(&adapter->hw, MANC);
+
+		/* disable hardware interception of ARP */
+		manc &= ~(E1000_MANC_ARP_EN);
+
+		/* enable receiving management packets to the host */
+		/* this will probably generate destination unreachable messages
+		 * from the host OS, but the packets will be handled on SMBUS */
+		if (adapter->hw.has_manc2h) {
+			uint32_t manc2h = E1000_READ_REG(&adapter->hw, MANC2H);
+
+			manc |= E1000_MANC_EN_MNG2HOST;
+#define E1000_MNG2HOST_PORT_623 (1 << 5)
+#define E1000_MNG2HOST_PORT_664 (1 << 6)
+			manc2h |= E1000_MNG2HOST_PORT_623;
+			manc2h |= E1000_MNG2HOST_PORT_664;
+			E1000_WRITE_REG(&adapter->hw, MANC2H, manc2h);
+		}
+
+		E1000_WRITE_REG(&adapter->hw, MANC, manc);
+	}
+}
+
+static void
+e1000_release_manageability(struct e1000_adapter *adapter)
+{
+	if (adapter->en_mng_pt) {
+		uint32_t manc = E1000_READ_REG(&adapter->hw, MANC);
+
+		/* re-enable hardware interception of ARP */
+		manc |= E1000_MANC_ARP_EN;
+
+		if (adapter->hw.has_manc2h)
+			manc &= ~E1000_MANC_EN_MNG2HOST;
+
+		/* don't explicitly have to mess with MANC2H since
+		 * MANC has an enable disable that gates MANC2H */
+
+		E1000_WRITE_REG(&adapter->hw, MANC, manc);
+	}
+}
+
 int
 e1000_up(struct e1000_adapter *adapter)
 {
@@ -475,6 +533,7 @@ e1000_up(struct e1000_adapter *adapter)
 	e1000_set_multi(netdev);
 
 	e1000_restore_vlan(adapter);
+	e1000_init_manageability(adapter);
 
 	e1000_configure_tx(adapter);
 	e1000_setup_rctl(adapter);
@@ -497,7 +556,8 @@ e1000_up(struct e1000_adapter *adapter)
 
 	clear_bit(__E1000_DOWN, &adapter->flags);
 
-	mod_timer(&adapter->watchdog_timer, jiffies + 2 * HZ);
+	/* fire a link change interrupt to start the watchdog */
+	E1000_WRITE_REG(&adapter->hw, ICS, E1000_ICS_LSC);
 	return 0;
 }
 
@@ -614,16 +674,34 @@ e1000_reinit_locked(struct e1000_adapter *adapter)
 void
 e1000_reset(struct e1000_adapter *adapter)
 {
-	uint32_t pba, manc;
+	uint32_t pba = 0, tx_space, min_tx_space, min_rx_space;
 	uint16_t fc_high_water_mark = E1000_FC_HIGH_DIFF;
+	boolean_t legacy_pba_adjust = FALSE;
 
 	/* Repartition Pba for greater than 9k mtu
 	 * To take effect CTRL.RST is required.
 	 */
 
 	switch (adapter->hw.mac_type) {
+	case e1000_82542_rev2_0:
+	case e1000_82542_rev2_1:
+	case e1000_82543:
+	case e1000_82544:
+	case e1000_82540:
+	case e1000_82541:
+	case e1000_82541_rev_2:
+		legacy_pba_adjust = TRUE;
+		pba = E1000_PBA_48K;
+		break;
+	case e1000_82545:
+	case e1000_82545_rev_3:
+	case e1000_82546:
+	case e1000_82546_rev_3:
+		pba = E1000_PBA_48K;
+		break;
 	case e1000_82547:
 	case e1000_82547_rev_2:
+		legacy_pba_adjust = TRUE;
 		pba = E1000_PBA_30K;
 		break;
 	case e1000_82571:
@@ -632,27 +710,80 @@ e1000_reset(struct e1000_adapter *adapter)
 		pba = E1000_PBA_38K;
 		break;
 	case e1000_82573:
-		pba = E1000_PBA_12K;
+		pba = E1000_PBA_20K;
 		break;
 	case e1000_ich8lan:
 		pba = E1000_PBA_8K;
-		break;
-	default:
-		pba = E1000_PBA_48K;
+	case e1000_undefined:
+	case e1000_num_macs:
 		break;
 	}
 
-	if ((adapter->hw.mac_type != e1000_82573) &&
-	   (adapter->netdev->mtu > E1000_RXBUFFER_8192))
-		pba -= 8; /* allocate more FIFO for Tx */
+	if (legacy_pba_adjust == TRUE) {
+		if (adapter->netdev->mtu > E1000_RXBUFFER_8192)
+			pba -= 8; /* allocate more FIFO for Tx */
 
+		if (adapter->hw.mac_type == e1000_82547) {
+			adapter->tx_fifo_head = 0;
+			adapter->tx_head_addr = pba << E1000_TX_HEAD_ADDR_SHIFT;
+			adapter->tx_fifo_size =
+				(E1000_PBA_40K - pba) << E1000_PBA_BYTES_SHIFT;
+			atomic_set(&adapter->tx_fifo_stall, 0);
+		}
+	} else if (adapter->hw.max_frame_size > MAXIMUM_ETHERNET_FRAME_SIZE) {
+		/* adjust PBA for jumbo frames */
+		E1000_WRITE_REG(&adapter->hw, PBA, pba);
+
+		/* To maintain wire speed transmits, the Tx FIFO should be
+		 * large enough to accomodate two full transmit packets,
+		 * rounded up to the next 1KB and expressed in KB.  Likewise,
+		 * the Rx FIFO should be large enough to accomodate at least
+		 * one full receive packet and is similarly rounded up and
+		 * expressed in KB. */
+		pba = E1000_READ_REG(&adapter->hw, PBA);
+		/* upper 16 bits has Tx packet buffer allocation size in KB */
+		tx_space = pba >> 16;
+		/* lower 16 bits has Rx packet buffer allocation size in KB */
+		pba &= 0xffff;
+		/* don't include ethernet FCS because hardware appends/strips */
+		min_rx_space = adapter->netdev->mtu + ENET_HEADER_SIZE +
+		               VLAN_TAG_SIZE;
+		min_tx_space = min_rx_space;
+		min_tx_space *= 2;
+		E1000_ROUNDUP(min_tx_space, 1024);
+		min_tx_space >>= 10;
+		E1000_ROUNDUP(min_rx_space, 1024);
+		min_rx_space >>= 10;
+
+		/* If current Tx allocation is less than the min Tx FIFO size,
+		 * and the min Tx FIFO size is less than the current Rx FIFO
+		 * allocation, take space away from current Rx allocation */
+		if (tx_space < min_tx_space &&
+		    ((min_tx_space - tx_space) < pba)) {
+			pba = pba - (min_tx_space - tx_space);
+
+			/* PCI/PCIx hardware has PBA alignment constraints */
+			switch (adapter->hw.mac_type) {
+			case e1000_82545 ... e1000_82546_rev_3:
+				pba &= ~(E1000_PBA_8K - 1);
+				break;
+			default:
+				break;
+			}
 
-	if (adapter->hw.mac_type == e1000_82547) {
-		adapter->tx_fifo_head = 0;
-		adapter->tx_head_addr = pba << E1000_TX_HEAD_ADDR_SHIFT;
-		adapter->tx_fifo_size =
-			(E1000_PBA_40K - pba) << E1000_PBA_BYTES_SHIFT;
-		atomic_set(&adapter->tx_fifo_stall, 0);
+			/* if short on rx space, rx wins and must trump tx
+			 * adjustment or use Early Receive if available */
+			if (pba < min_rx_space) {
+				switch (adapter->hw.mac_type) {
+				case e1000_82573:
+					/* ERT enabled in e1000_configure_rx */
+					break;
+				default:
+					pba = min_rx_space;
+					break;
+				}
+			}
+		}
 	}
 
 	E1000_WRITE_REG(&adapter->hw, PBA, pba);
@@ -685,6 +816,20 @@ e1000_reset(struct e1000_adapter *adapter)
 	if (e1000_init_hw(&adapter->hw))
 		DPRINTK(PROBE, ERR, "Hardware Error\n");
 	e1000_update_mng_vlan(adapter);
+
+	/* if (adapter->hwflags & HWFLAGS_PHY_PWR_BIT) { */
+	if (adapter->hw.mac_type >= e1000_82544 &&
+	    adapter->hw.mac_type <= e1000_82547_rev_2 &&
+	    adapter->hw.autoneg == 1 &&
+	    adapter->hw.autoneg_advertised == ADVERTISE_1000_FULL) {
+		uint32_t ctrl = E1000_READ_REG(&adapter->hw, CTRL);
+		/* clear phy power management bit if we are in gig only mode,
+		 * which if enabled will attempt negotiation to 100Mb, which
+		 * can cause a loss of link at power off or driver unload */
+		ctrl &= ~E1000_CTRL_SWDPIN3;
+		E1000_WRITE_REG(&adapter->hw, CTRL, ctrl);
+	}
+
 	/* Enable h/w to recognize an 802.1Q VLAN Ethernet packet */
 	E1000_WRITE_REG(&adapter->hw, VET, ETHERNET_IEEE_VLAN_TYPE);
 
@@ -705,14 +850,7 @@ e1000_reset(struct e1000_adapter *adapter)
 		                    phy_data);
 	}
 
-	if ((adapter->en_mng_pt) &&
-	    (adapter->hw.mac_type >= e1000_82540) &&
-	    (adapter->hw.mac_type < e1000_82571) &&
-	    (adapter->hw.media_type == e1000_media_type_copper)) {
-		manc = E1000_READ_REG(&adapter->hw, MANC);
-		manc |= (E1000_MANC_ARP_EN | E1000_MANC_EN_MNG2HOST);
-		E1000_WRITE_REG(&adapter->hw, MANC, manc);
-	}
+	e1000_release_manageability(adapter);
 }
 
 /**
@@ -857,6 +995,12 @@ e1000_probe(struct pci_dev *pdev,
 	   (adapter->hw.mac_type != e1000_82547))
 		netdev->features |= NETIF_F_TSO;
 
+#ifdef CONFIG_DEBUG_SLAB
+	/* 82544's work arounds do not play nicely with DEBUG SLAB */
+	if (adapter->hw.mac_type == e1000_82544)
+		netdev->features &= ~NETIF_F_TSO;
+#endif
+
 #ifdef NETIF_F_TSO6
 	if (adapter->hw.mac_type > e1000_82547_rev_2)
 		netdev->features |= NETIF_F_TSO6;
@@ -1078,22 +1222,13 @@ e1000_remove(struct pci_dev *pdev)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct e1000_adapter *adapter = netdev_priv(netdev);
-	uint32_t manc;
 #ifdef CONFIG_E1000_NAPI
 	int i;
 #endif
 
 	flush_scheduled_work();
 
-	if (adapter->hw.mac_type >= e1000_82540 &&
-	    adapter->hw.mac_type < e1000_82571 &&
-	    adapter->hw.media_type == e1000_media_type_copper) {
-		manc = E1000_READ_REG(&adapter->hw, MANC);
-		if (manc & E1000_MANC_SMBUS_EN) {
-			manc |= E1000_MANC_ARP_EN;
-			E1000_WRITE_REG(&adapter->hw, MANC, manc);
-		}
-	}
+	e1000_release_manageability(adapter);
 
 	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
 	 * would have already happened in close and is redundant. */
@@ -1531,9 +1666,9 @@ e1000_configure_tx(struct e1000_adapter *adapter)
 	}
 
 	/* Set the default values for the Tx Inter Packet Gap timer */
-
-	if (hw->media_type == e1000_media_type_fiber ||
-	    hw->media_type == e1000_media_type_internal_serdes)
+	if (adapter->hw.mac_type <= e1000_82547_rev_2 &&
+	    (hw->media_type == e1000_media_type_fiber ||
+	     hw->media_type == e1000_media_type_internal_serdes))
 		tipg = DEFAULT_82543_TIPG_IPGT_FIBER;
 	else
 		tipg = DEFAULT_82543_TIPG_IPGT_COPPER;
@@ -2528,6 +2663,13 @@ e1000_watchdog(unsigned long data)
 			netif_wake_queue(netdev);
 			mod_timer(&adapter->phy_info_timer, jiffies + 2 * HZ);
 			adapter->smartspeed = 0;
+		} else {
+			/* make sure the receive unit is started */
+			if (adapter->hw.rx_needs_kicking) {
+				struct e1000_hw *hw = &adapter->hw;
+				uint32_t rctl = E1000_READ_REG(hw, RCTL);
+				E1000_WRITE_REG(hw, RCTL, rctl | E1000_RCTL_EN);
+			}
 		}
 	} else {
 		if (netif_carrier_ok(netdev)) {
@@ -2628,29 +2770,34 @@ static unsigned int e1000_update_itr(struct e1000_adapter *adapter,
 	if (packets == 0)
 		goto update_itr_done;
 
-
 	switch (itr_setting) {
 	case lowest_latency:
-		if ((packets < 5) && (bytes > 512))
+		/* jumbo frames get bulk treatment*/
+		if (bytes/packets > 8000)
+			retval = bulk_latency;
+		else if ((packets < 5) && (bytes > 512))
 			retval = low_latency;
 		break;
 	case low_latency:  /* 50 usec aka 20000 ints/s */
 		if (bytes > 10000) {
-			if ((packets < 10) ||
-			     ((bytes/packets) > 1200))
+			/* jumbo frames need bulk latency setting */
+			if (bytes/packets > 8000)
+				retval = bulk_latency;
+			else if ((packets < 10) || ((bytes/packets) > 1200))
 				retval = bulk_latency;
 			else if ((packets > 35))
 				retval = lowest_latency;
-		} else if (packets <= 2 && bytes < 512)
+		} else if (bytes/packets > 2000)
+			retval = bulk_latency;
+		else if (packets <= 2 && bytes < 512)
 			retval = lowest_latency;
 		break;
 	case bulk_latency: /* 250 usec aka 4000 ints/s */
 		if (bytes > 25000) {
 			if (packets > 35)
 				retval = low_latency;
-		} else {
-			if (bytes < 6000)
-				retval = low_latency;
+		} else if (bytes < 6000) {
+			retval = low_latency;
 		}
 		break;
 	}
@@ -2679,17 +2826,20 @@ static void e1000_set_itr(struct e1000_adapter *adapter)
 	                            adapter->tx_itr,
 	                            adapter->total_tx_packets,
 	                            adapter->total_tx_bytes);
+	/* conservative mode (itr 3) eliminates the lowest_latency setting */
+	if (adapter->itr_setting == 3 && adapter->tx_itr == lowest_latency)
+		adapter->tx_itr = low_latency;
+
 	adapter->rx_itr = e1000_update_itr(adapter,
 	                            adapter->rx_itr,
 	                            adapter->total_rx_packets,
 	                            adapter->total_rx_bytes);
+	/* conservative mode (itr 3) eliminates the lowest_latency setting */
+	if (adapter->itr_setting == 3 && adapter->rx_itr == lowest_latency)
+		adapter->rx_itr = low_latency;
 
 	current_itr = max(adapter->rx_itr, adapter->tx_itr);
 
-	/* conservative mode eliminates the lowest_latency setting */
-	if (current_itr == lowest_latency && (adapter->itr_setting == 3))
-		current_itr = low_latency;
-
 	switch (current_itr) {
 	/* counts and packets in update_itr are dependent on these numbers */
 	case lowest_latency:
@@ -3168,6 +3318,16 @@ e1000_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 		if (skb->data_len && (hdr_len == (skb->len - skb->data_len))) {
 			switch (adapter->hw.mac_type) {
 				unsigned int pull_size;
+			case e1000_82544:
+				/* Make sure we have room to chop off 4 bytes,
+				 * and that the end alignment will work out to
+				 * this hardware's requirements
+				 * NOTE: this is a TSO only workaround
+				 * if end byte alignment not correct move us
+				 * into the next dword */
+				if ((unsigned long)(skb->tail - 1) & 4)
+					break;
+				/* fall through */
 			case e1000_82571:
 			case e1000_82572:
 			case e1000_82573:
@@ -3419,12 +3579,11 @@ e1000_change_mtu(struct net_device *netdev, int new_mtu)
 		adapter->rx_buffer_len = MAXIMUM_ETHERNET_VLAN_SIZE;
 
 	netdev->mtu = new_mtu;
+	adapter->hw.max_frame_size = max_frame;
 
 	if (netif_running(netdev))
 		e1000_reinit_locked(adapter);
 
-	adapter->hw.max_frame_size = max_frame;
-
 	return 0;
 }
 
@@ -3573,6 +3732,11 @@ e1000_update_stats(struct e1000_adapter *adapter)
 	adapter->net_stats.tx_aborted_errors = adapter->stats.ecol;
 	adapter->net_stats.tx_window_errors = adapter->stats.latecol;
 	adapter->net_stats.tx_carrier_errors = adapter->stats.tncrs;
+	if (adapter->hw.bad_tx_carr_stats_fd &&
+	    adapter->link_duplex == FULL_DUPLEX) {
+		adapter->net_stats.tx_carrier_errors = 0;
+		adapter->stats.tncrs = 0;
+	}
 
 	/* Tx Dropped needs to be maintained elsewhere */
 
@@ -3590,6 +3754,13 @@ e1000_update_stats(struct e1000_adapter *adapter)
 			adapter->phy_stats.receive_errors += phy_tmp;
 	}
 
+	/* Management Stats */
+	if (adapter->hw.has_smbus) {
+		adapter->stats.mgptc += E1000_READ_REG(hw, MGTPTC);
+		adapter->stats.mgprc += E1000_READ_REG(hw, MGTPRC);
+		adapter->stats.mgpdc += E1000_READ_REG(hw, MGTPDC);
+	}
+
 	spin_unlock_irqrestore(&adapter->stats_lock, flags);
 }
 #ifdef CONFIG_PCI_MSI
@@ -3868,11 +4039,11 @@ e1000_clean_tx_irq(struct e1000_adapter *adapter,
 			cleaned = (i == eop);
 
 			if (cleaned) {
-				/* this packet count is wrong for TSO but has a
-				 * tendency to make dynamic ITR change more
-				 * towards bulk */
+				struct sk_buff *skb = buffer_info->skb;
+				unsigned int segs = skb_shinfo(skb)->gso_segs;
+				total_tx_packets += segs;
 				total_tx_packets++;
-				total_tx_bytes += buffer_info->skb->len;
+				total_tx_bytes += skb->len;
 			}
 			e1000_unmap_and_free_tx_resource(adapter, buffer_info);
 			tx_desc->upper.data = 0;
@@ -4094,8 +4265,7 @@ e1000_clean_rx_irq(struct e1000_adapter *adapter,
 		/* code added for copybreak, this should improve
 		 * performance for small packets with large amounts
 		 * of reassembly being done in the stack */
-#define E1000_CB_LENGTH 256
-		if (length < E1000_CB_LENGTH) {
+		if (length < copybreak) {
 			struct sk_buff *new_skb =
 			    netdev_alloc_skb(netdev, length + NET_IP_ALIGN);
 			if (new_skb) {
@@ -4253,7 +4423,7 @@ e1000_clean_rx_irq_ps(struct e1000_adapter *adapter,
 
 		/* page alloc/put takes too long and effects small packet
 		 * throughput, so unsplit small packets and save the alloc/put*/
-		if (l1 && ((length + l1) <= adapter->rx_ps_bsize0)) {
+		if (l1 && (l1 <= copybreak) && ((length + l1) <= adapter->rx_ps_bsize0)) {
 			u8 *vaddr;
 			/* there is no documentation about how to call
 			 * kmap_atomic, so we can't hold the mapping
@@ -4998,7 +5168,7 @@ e1000_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct e1000_adapter *adapter = netdev_priv(netdev);
-	uint32_t ctrl, ctrl_ext, rctl, manc, status;
+	uint32_t ctrl, ctrl_ext, rctl, status;
 	uint32_t wufc = adapter->wol;
 #ifdef CONFIG_PM
 	int retval = 0;
@@ -5067,16 +5237,12 @@ e1000_suspend(struct pci_dev *pdev, pm_message_t state)
 		pci_enable_wake(pdev, PCI_D3cold, 0);
 	}
 
-	if (adapter->hw.mac_type >= e1000_82540 &&
-	    adapter->hw.mac_type < e1000_82571 &&
-	    adapter->hw.media_type == e1000_media_type_copper) {
-		manc = E1000_READ_REG(&adapter->hw, MANC);
-		if (manc & E1000_MANC_SMBUS_EN) {
-			manc |= E1000_MANC_ARP_EN;
-			E1000_WRITE_REG(&adapter->hw, MANC, manc);
-			pci_enable_wake(pdev, PCI_D3hot, 1);
-			pci_enable_wake(pdev, PCI_D3cold, 1);
-		}
+	e1000_release_manageability(adapter);
+
+	/* make sure adapter isn't asleep if manageability is enabled */
+	if (adapter->en_mng_pt) {
+		pci_enable_wake(pdev, PCI_D3hot, 1);
+		pci_enable_wake(pdev, PCI_D3cold, 1);
 	}
 
 	if (adapter->hw.phy_type == e1000_phy_igp_3)
@@ -5102,7 +5268,7 @@ e1000_resume(struct pci_dev *pdev)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct e1000_adapter *adapter = netdev_priv(netdev);
-	uint32_t manc, err;
+	uint32_t err;
 
 	pci_set_power_state(pdev, PCI_D0);
 	e1000_pci_restore_state(adapter);
@@ -5122,19 +5288,13 @@ e1000_resume(struct pci_dev *pdev)
 	e1000_reset(adapter);
 	E1000_WRITE_REG(&adapter->hw, WUS, ~0);
 
+	e1000_init_manageability(adapter);
+
 	if (netif_running(netdev))
 		e1000_up(adapter);
 
 	netif_device_attach(netdev);
 
-	if (adapter->hw.mac_type >= e1000_82540 &&
-	    adapter->hw.mac_type < e1000_82571 &&
-	    adapter->hw.media_type == e1000_media_type_copper) {
-		manc = E1000_READ_REG(&adapter->hw, MANC);
-		manc &= ~(E1000_MANC_ARP_EN);
-		E1000_WRITE_REG(&adapter->hw, MANC, manc);
-	}
-
 	/* If the controller is 82573 and f/w is AMT, do not set
 	 * DRV_LOAD until the interface is up.  For all other cases,
 	 * let the f/w know that the h/w is now under the control
@@ -5235,7 +5395,8 @@ static void e1000_io_resume(struct pci_dev *pdev)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct e1000_adapter *adapter = netdev->priv;
-	uint32_t manc, swsm;
+
+	e1000_init_manageability(adapter);
 
 	if (netif_running(netdev)) {
 		if (e1000_up(adapter)) {
@@ -5246,26 +5407,14 @@ static void e1000_io_resume(struct pci_dev *pdev)
 
 	netif_device_attach(netdev);
 
-	if (adapter->hw.mac_type >= e1000_82540 &&
-	    adapter->hw.mac_type < e1000_82571 &&
-	    adapter->hw.media_type == e1000_media_type_copper) {
-		manc = E1000_READ_REG(&adapter->hw, MANC);
-		manc &= ~(E1000_MANC_ARP_EN);
-		E1000_WRITE_REG(&adapter->hw, MANC, manc);
-	}
-
-	switch (adapter->hw.mac_type) {
-	case e1000_82573:
-		swsm = E1000_READ_REG(&adapter->hw, SWSM);
-		E1000_WRITE_REG(&adapter->hw, SWSM,
-				swsm | E1000_SWSM_DRV_LOAD);
-		break;
-	default:
-		break;
-	}
+	/* If the controller is 82573 and f/w is AMT, do not set
+	 * DRV_LOAD until the interface is up.  For all other cases,
+	 * let the f/w know that the h/w is now under the control
+	 * of the driver. */
+	if (adapter->hw.mac_type != e1000_82573 ||
+	    !e1000_check_mng_mode(&adapter->hw))
+		e1000_get_hw_control(adapter);
 
-	if (netif_running(netdev))
-		mod_timer(&adapter->watchdog_timer, jiffies);
 }
 
 /* e1000_main.c */
diff --git a/drivers/net/e1000/e1000_param.c b/drivers/net/e1000/e1000_param.c
index cbfcd7f..cf2a279 100644
--- a/drivers/net/e1000/e1000_param.c
+++ b/drivers/net/e1000/e1000_param.c
@@ -487,7 +487,9 @@ e1000_check_options(struct e1000_adapter *adapter)
 				e1000_validate_option(&adapter->itr, &opt,
 				        adapter);
 				/* save the setting, because the dynamic bits change itr */
-				adapter->itr_setting = adapter->itr;
+				/* clear the lower two bits because they are
+				 * used as control */
+				adapter->itr_setting = adapter->itr & ~3;
 				break;
 			}
 		} else {
diff --git a/drivers/net/forcedeth.c b/drivers/net/forcedeth.c
index 439f413..2f48fe9 100644
--- a/drivers/net/forcedeth.c
+++ b/drivers/net/forcedeth.c
@@ -3,8 +3,7 @@
  *
  * Note: This driver is a cleanroom reimplementation based on reverse
  *      engineered documentation written by Carl-Daniel Hailfinger
- *      and Andrew de Quincey. It's neither supported nor endorsed
- *      by NVIDIA Corp. Use at your own risk.
+ *      and Andrew de Quincey.
  *
  * NVIDIA, nForce and other NVIDIA marks are trademarks or registered
  * trademarks of NVIDIA Corporation in the United States and other
@@ -14,7 +13,7 @@
  * Copyright (C) 2004 Andrew de Quincey (wol support)
  * Copyright (C) 2004 Carl-Daniel Hailfinger (invalid MAC handling, insane
  *		IRQ rate fixes, bigendian fixes, cleanups, verification)
- * Copyright (c) 2004 NVIDIA Corporation
+ * Copyright (c) 2004,5,6 NVIDIA Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -2576,14 +2575,15 @@ static int nv_napi_poll(struct net_device *dev, int *budget)
 	int pkts, limit = min(*budget, dev->quota);
 	struct fe_priv *np = netdev_priv(dev);
 	u8 __iomem *base = get_hwbase(dev);
+	unsigned long flags;
 
 	pkts = nv_rx_process(dev, limit);
 
 	if (nv_alloc_rx(dev)) {
-		spin_lock_irq(&np->lock);
+		spin_lock_irqsave(&np->lock, flags);
 		if (!np->in_shutdown)
 			mod_timer(&np->oom_kick, jiffies + OOM_REFILL);
-		spin_unlock_irq(&np->lock);
+		spin_unlock_irqrestore(&np->lock, flags);
 	}
 
 	if (pkts < limit) {
@@ -2591,13 +2591,15 @@ static int nv_napi_poll(struct net_device *dev, int *budget)
 		netif_rx_complete(dev);
 
 		/* re-enable receive interrupts */
-		spin_lock_irq(&np->lock);
+		spin_lock_irqsave(&np->lock, flags);
+
 		np->irqmask |= NVREG_IRQ_RX_ALL;
 		if (np->msi_flags & NV_MSI_X_ENABLED)
 			writel(NVREG_IRQ_RX_ALL, base + NvRegIrqMask);
 		else
 			writel(np->irqmask, base + NvRegIrqMask);
-		spin_unlock_irq(&np->lock);
+
+		spin_unlock_irqrestore(&np->lock, flags);
 		return 0;
 	} else {
 		/* used up our quantum, so reschedule */
diff --git a/drivers/net/ibm_emac/ibm_emac_phy.c b/drivers/net/ibm_emac/ibm_emac_phy.c
index 4a97024..9074f76 100644
--- a/drivers/net/ibm_emac/ibm_emac_phy.c
+++ b/drivers/net/ibm_emac/ibm_emac_phy.c
@@ -309,7 +309,7 @@ int mii_phy_probe(struct mii_phy *phy, int address)
 {
 	struct mii_phy_def *def;
 	int i;
-	u32 id;
+	int id;
 
 	phy->autoneg = AUTONEG_DISABLE;
 	phy->advertising = 0;
@@ -324,6 +324,8 @@ int mii_phy_probe(struct mii_phy *phy, int address)
 
 	/* Read ID and find matching entry */
 	id = (phy_read(phy, MII_PHYSID1) << 16) | phy_read(phy, MII_PHYSID2);
+	if (id < 0)
+		return -ENODEV;
 	for (i = 0; (def = mii_phy_table[i]) != NULL; i++)
 		if ((id & def->phy_id_mask) == def->phy_id)
 			break;
diff --git a/drivers/net/myri10ge/myri10ge.c b/drivers/net/myri10ge/myri10ge.c
index 94ac168..07cf574 100644
--- a/drivers/net/myri10ge/myri10ge.c
+++ b/drivers/net/myri10ge/myri10ge.c
@@ -199,8 +199,6 @@ struct myri10ge_priv {
 	unsigned long serial_number;
 	int vendor_specific_offset;
 	int fw_multicast_support;
-	u32 devctl;
-	u16 msi_flags;
 	u32 read_dma;
 	u32 write_dma;
 	u32 read_write_dma;
@@ -228,7 +226,7 @@ module_param(myri10ge_small_bytes, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(myri10ge_small_bytes, "Threshold of small packets\n");
 
 static int myri10ge_msi = 1;	/* enable msi by default */
-module_param(myri10ge_msi, int, S_IRUGO);
+module_param(myri10ge_msi, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(myri10ge_msi, "Enable Message Signalled Interrupts\n");
 
 static int myri10ge_intr_coal_delay = 25;
@@ -721,12 +719,10 @@ static int myri10ge_reset(struct myri10ge_priv *mgp)
 	status |=
 	    myri10ge_send_cmd(mgp, MXGEFW_CMD_GET_IRQ_ACK_OFFSET, &cmd, 0);
 	mgp->irq_claim = (__iomem __be32 *) (mgp->sram + cmd.data0);
-	if (!mgp->msi_enabled) {
-		status |= myri10ge_send_cmd
-		    (mgp, MXGEFW_CMD_GET_IRQ_DEASSERT_OFFSET, &cmd, 0);
-		mgp->irq_deassert = (__iomem __be32 *) (mgp->sram + cmd.data0);
+	status |= myri10ge_send_cmd(mgp, MXGEFW_CMD_GET_IRQ_DEASSERT_OFFSET,
+				    &cmd, 0);
+	mgp->irq_deassert = (__iomem __be32 *) (mgp->sram + cmd.data0);
 
-	}
 	status |= myri10ge_send_cmd
 	    (mgp, MXGEFW_CMD_GET_INTR_COAL_DELAY_OFFSET, &cmd, 0);
 	mgp->intr_coal_delay_ptr = (__iomem __be32 *) (mgp->sram + cmd.data0);
@@ -1619,6 +1615,41 @@ static void myri10ge_free_rings(struct net_device *dev)
 	mgp->tx.req_list = NULL;
 }
 
+static int myri10ge_request_irq(struct myri10ge_priv *mgp)
+{
+	struct pci_dev *pdev = mgp->pdev;
+	int status;
+
+	if (myri10ge_msi) {
+		status = pci_enable_msi(pdev);
+		if (status != 0)
+			dev_err(&pdev->dev,
+				"Error %d setting up MSI; falling back to xPIC\n",
+				status);
+		else
+			mgp->msi_enabled = 1;
+	} else {
+		mgp->msi_enabled = 0;
+	}
+	status = request_irq(pdev->irq, myri10ge_intr, IRQF_SHARED,
+			     mgp->dev->name, mgp);
+	if (status != 0) {
+		dev_err(&pdev->dev, "failed to allocate IRQ\n");
+		if (mgp->msi_enabled)
+			pci_disable_msi(pdev);
+	}
+	return status;
+}
+
+static void myri10ge_free_irq(struct myri10ge_priv *mgp)
+{
+	struct pci_dev *pdev = mgp->pdev;
+
+	free_irq(pdev->irq, mgp);
+	if (mgp->msi_enabled)
+		pci_disable_msi(pdev);
+}
+
 static int myri10ge_open(struct net_device *dev)
 {
 	struct myri10ge_priv *mgp;
@@ -1634,10 +1665,13 @@ static int myri10ge_open(struct net_device *dev)
 	status = myri10ge_reset(mgp);
 	if (status != 0) {
 		printk(KERN_ERR "myri10ge: %s: failed reset\n", dev->name);
-		mgp->running = MYRI10GE_ETH_STOPPED;
-		return -ENXIO;
+		goto abort_with_nothing;
 	}
 
+	status = myri10ge_request_irq(mgp);
+	if (status != 0)
+		goto abort_with_nothing;
+
 	/* decide what small buffer size to use.  For good TCP rx
 	 * performance, it is important to not receive 1514 byte
 	 * frames into jumbo buffers, as it confuses the socket buffer
@@ -1677,7 +1711,7 @@ static int myri10ge_open(struct net_device *dev)
 		       "myri10ge: %s: failed to get ring sizes or locations\n",
 		       dev->name);
 		mgp->running = MYRI10GE_ETH_STOPPED;
-		return -ENXIO;
+		goto abort_with_irq;
 	}
 
 	if (mgp->mtrr >= 0) {
@@ -1708,7 +1742,7 @@ static int myri10ge_open(struct net_device *dev)
 
 	status = myri10ge_allocate_rings(dev);
 	if (status != 0)
-		goto abort_with_nothing;
+		goto abort_with_irq;
 
 	/* now give firmware buffers sizes, and MTU */
 	cmd.data0 = dev->mtu + ETH_HLEN + VLAN_HLEN;
@@ -1771,6 +1805,9 @@ static int myri10ge_open(struct net_device *dev)
 abort_with_rings:
 	myri10ge_free_rings(dev);
 
+abort_with_irq:
+	myri10ge_free_irq(mgp);
+
 abort_with_nothing:
 	mgp->running = MYRI10GE_ETH_STOPPED;
 	return -ENOMEM;
@@ -1807,7 +1844,7 @@ static int myri10ge_close(struct net_device *dev)
 		printk(KERN_ERR "myri10ge: %s never got down irq\n", dev->name);
 
 	netif_tx_disable(dev);
-
+	myri10ge_free_irq(mgp);
 	myri10ge_free_rings(dev);
 
 	mgp->running = MYRI10GE_ETH_STOPPED;
@@ -2481,34 +2518,6 @@ static void myri10ge_select_firmware(struct myri10ge_priv *mgp)
 	}
 }
 
-static void myri10ge_save_state(struct myri10ge_priv *mgp)
-{
-	struct pci_dev *pdev = mgp->pdev;
-	int cap;
-
-	pci_save_state(pdev);
-	/* now save PCIe and MSI state that Linux will not
-	 * save for us */
-	cap = pci_find_capability(pdev, PCI_CAP_ID_EXP);
-	pci_read_config_dword(pdev, cap + PCI_EXP_DEVCTL, &mgp->devctl);
-	cap = pci_find_capability(pdev, PCI_CAP_ID_MSI);
-	pci_read_config_word(pdev, cap + PCI_MSI_FLAGS, &mgp->msi_flags);
-}
-
-static void myri10ge_restore_state(struct myri10ge_priv *mgp)
-{
-	struct pci_dev *pdev = mgp->pdev;
-	int cap;
-
-	/* restore PCIe and MSI state that linux will not */
-	cap = pci_find_capability(pdev, PCI_CAP_ID_EXP);
-	pci_write_config_dword(pdev, cap + PCI_CAP_ID_EXP, mgp->devctl);
-	cap = pci_find_capability(pdev, PCI_CAP_ID_MSI);
-	pci_write_config_word(pdev, cap + PCI_MSI_FLAGS, mgp->msi_flags);
-
-	pci_restore_state(pdev);
-}
-
 #ifdef CONFIG_PM
 
 static int myri10ge_suspend(struct pci_dev *pdev, pm_message_t state)
@@ -2529,11 +2538,10 @@ static int myri10ge_suspend(struct pci_dev *pdev, pm_message_t state)
 		rtnl_unlock();
 	}
 	myri10ge_dummy_rdma(mgp, 0);
-	free_irq(pdev->irq, mgp);
-	myri10ge_save_state(mgp);
+	pci_save_state(pdev);
 	pci_disable_device(pdev);
-	pci_set_power_state(pdev, pci_choose_state(pdev, state));
-	return 0;
+
+	return pci_set_power_state(pdev, pci_choose_state(pdev, state));
 }
 
 static int myri10ge_resume(struct pci_dev *pdev)
@@ -2555,34 +2563,33 @@ static int myri10ge_resume(struct pci_dev *pdev)
 		       mgp->dev->name);
 		return -EIO;
 	}
-	myri10ge_restore_state(mgp);
+
+	status = pci_restore_state(pdev);
+	if (status)
+		return status;
 
 	status = pci_enable_device(pdev);
-	if (status < 0) {
+	if (status) {
 		dev_err(&pdev->dev, "failed to enable device\n");
-		return -EIO;
+		return status;
 	}
 
 	pci_set_master(pdev);
 
-	status = request_irq(pdev->irq, myri10ge_intr, IRQF_SHARED,
-			     netdev->name, mgp);
-	if (status != 0) {
-		dev_err(&pdev->dev, "failed to allocate IRQ\n");
-		goto abort_with_enabled;
-	}
-
 	myri10ge_reset(mgp);
 	myri10ge_dummy_rdma(mgp, 1);
 
 	/* Save configuration space to be restored if the
 	 * nic resets due to a parity error */
-	myri10ge_save_state(mgp);
+	pci_save_state(pdev);
 
 	if (netif_running(netdev)) {
 		rtnl_lock();
-		myri10ge_open(netdev);
+		status = myri10ge_open(netdev);
 		rtnl_unlock();
+		if (status != 0)
+			goto abort_with_enabled;
+
 	}
 	netif_device_attach(netdev);
 
@@ -2640,7 +2647,11 @@ static void myri10ge_watchdog(struct work_struct *work)
 		 * when the driver was loaded, or the last time the
 		 * nic was resumed from power saving mode.
 		 */
-		myri10ge_restore_state(mgp);
+		pci_restore_state(mgp->pdev);
+
+		/* save state again for accounting reasons */
+		pci_save_state(mgp->pdev);
+
 	} else {
 		/* if we get back -1's from our slot, perhaps somebody
 		 * powered off our card.  Don't try to reset it in
@@ -2856,23 +2867,6 @@ static int myri10ge_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto abort_with_firmware;
 	}
 
-	if (myri10ge_msi) {
-		status = pci_enable_msi(pdev);
-		if (status != 0)
-			dev_err(&pdev->dev,
-				"Error %d setting up MSI; falling back to xPIC\n",
-				status);
-		else
-			mgp->msi_enabled = 1;
-	}
-
-	status = request_irq(pdev->irq, myri10ge_intr, IRQF_SHARED,
-			     netdev->name, mgp);
-	if (status != 0) {
-		dev_err(&pdev->dev, "failed to allocate IRQ\n");
-		goto abort_with_firmware;
-	}
-
 	pci_set_drvdata(pdev, mgp);
 	if ((myri10ge_initial_mtu + ETH_HLEN) > MYRI10GE_MAX_ETHER_MTU)
 		myri10ge_initial_mtu = MYRI10GE_MAX_ETHER_MTU - ETH_HLEN;
@@ -2896,7 +2890,7 @@ static int myri10ge_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* Save configuration space to be restored if the
 	 * nic resets due to a parity error */
-	myri10ge_save_state(mgp);
+	pci_save_state(pdev);
 
 	/* Setup the watchdog timer */
 	setup_timer(&mgp->watchdog_timer, myri10ge_watchdog_timer,
@@ -2907,19 +2901,16 @@ static int myri10ge_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	status = register_netdev(netdev);
 	if (status != 0) {
 		dev_err(&pdev->dev, "register_netdev failed: %d\n", status);
-		goto abort_with_irq;
+		goto abort_with_state;
 	}
-	dev_info(dev, "%s IRQ %d, tx bndry %d, fw %s, WC %s\n",
-		 (mgp->msi_enabled ? "MSI" : "xPIC"),
+	dev_info(dev, "%d, tx bndry %d, fw %s, WC %s\n",
 		 pdev->irq, mgp->tx.boundary, mgp->fw_name,
 		 (mgp->mtrr >= 0 ? "Enabled" : "Disabled"));
 
 	return 0;
 
-abort_with_irq:
-	free_irq(pdev->irq, mgp);
-	if (mgp->msi_enabled)
-		pci_disable_msi(pdev);
+abort_with_state:
+	pci_restore_state(pdev);
 
 abort_with_firmware:
 	myri10ge_dummy_rdma(mgp, 0);
@@ -2970,12 +2961,12 @@ static void myri10ge_remove(struct pci_dev *pdev)
 	flush_scheduled_work();
 	netdev = mgp->dev;
 	unregister_netdev(netdev);
-	free_irq(pdev->irq, mgp);
-	if (mgp->msi_enabled)
-		pci_disable_msi(pdev);
 
 	myri10ge_dummy_rdma(mgp, 0);
 
+	/* avoid a memory leak */
+	pci_restore_state(pdev);
+
 	bytes = myri10ge_max_intr_slots * sizeof(*mgp->rx_done.entry);
 	dma_free_coherent(&pdev->dev, bytes,
 			  mgp->rx_done.entry, mgp->rx_done.bus);
diff --git a/drivers/net/netxen/netxen_nic.h b/drivers/net/netxen/netxen_nic.h
index b5410be..edd725e 100644
--- a/drivers/net/netxen/netxen_nic.h
+++ b/drivers/net/netxen/netxen_nic.h
@@ -63,7 +63,7 @@
 
 #include "netxen_nic_hw.h"
 
-#define NETXEN_NIC_BUILD_NO     "1"
+#define NETXEN_NIC_BUILD_NO     "4"
 #define _NETXEN_NIC_LINUX_MAJOR 3
 #define _NETXEN_NIC_LINUX_MINOR 3
 #define _NETXEN_NIC_LINUX_SUBVERSION 2
@@ -137,7 +137,7 @@ extern struct workqueue_struct *netxen_workq;
 #define THIRD_PAGE_GROUP_SIZE  THIRD_PAGE_GROUP_END - THIRD_PAGE_GROUP_START
 
 #define MAX_RX_BUFFER_LENGTH		1760
-#define MAX_RX_JUMBO_BUFFER_LENGTH 	9046
+#define MAX_RX_JUMBO_BUFFER_LENGTH 	8062
 #define MAX_RX_LRO_BUFFER_LENGTH	((48*1024)-512)
 #define RX_DMA_MAP_LEN			(MAX_RX_BUFFER_LENGTH - 2)
 #define RX_JUMBO_DMA_MAP_LEN	\
@@ -199,9 +199,9 @@ enum {
 			(RCV_DESC_NORMAL)))
 
 #define MAX_CMD_DESCRIPTORS		1024
-#define MAX_RCV_DESCRIPTORS		32768
-#define MAX_JUMBO_RCV_DESCRIPTORS	4096
-#define MAX_LRO_RCV_DESCRIPTORS		2048
+#define MAX_RCV_DESCRIPTORS		16384
+#define MAX_JUMBO_RCV_DESCRIPTORS	1024
+#define MAX_LRO_RCV_DESCRIPTORS		64
 #define MAX_RCVSTATUS_DESCRIPTORS	MAX_RCV_DESCRIPTORS
 #define MAX_JUMBO_RCV_DESC	MAX_JUMBO_RCV_DESCRIPTORS
 #define MAX_RCV_DESC		MAX_RCV_DESCRIPTORS
@@ -852,8 +852,6 @@ struct netxen_adapter {
 	spinlock_t tx_lock;
 	spinlock_t lock;
 	struct work_struct watchdog_task;
-	struct work_struct tx_timeout_task;
-	struct net_device *netdev;
 	struct timer_list watchdog_timer;
 
 	u32 curr_window;
@@ -887,7 +885,6 @@ struct netxen_adapter {
 	struct netxen_recv_context recv_ctx[MAX_RCV_CTX];
 
 	int is_up;
-	int number;
 	struct netxen_dummy_dma dummy_dma;
 
 	/* Context interface shared between card and host */
@@ -950,6 +947,7 @@ struct netxen_port {
 	struct pci_dev *pdev;
 	struct net_device_stats net_stats;
 	struct netxen_port_stats stats;
+	struct work_struct tx_timeout_task;
 };
 
 #define PCI_OFFSET_FIRST_RANGE(adapter, off)    \
diff --git a/drivers/net/netxen/netxen_nic_hw.c b/drivers/net/netxen/netxen_nic_hw.c
index 9147b60..f2850bf 100644
--- a/drivers/net/netxen/netxen_nic_hw.c
+++ b/drivers/net/netxen/netxen_nic_hw.c
@@ -376,7 +376,7 @@ void netxen_tso_check(struct netxen_adapter *adapter,
 		    ((skb->nh.iph)->ihl * sizeof(u32)) +
 		    ((skb->h.th)->doff * sizeof(u32));
 		netxen_set_cmd_desc_opcode(desc, TX_TCP_LSO);
-	} else if (skb->ip_summed == CHECKSUM_COMPLETE) {
+	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		if (skb->nh.iph->protocol == IPPROTO_TCP) {
 			netxen_set_cmd_desc_opcode(desc, TX_TCP_PKT);
 		} else if (skb->nh.iph->protocol == IPPROTO_UDP) {
diff --git a/drivers/net/netxen/netxen_nic_init.c b/drivers/net/netxen/netxen_nic_init.c
index 869725f..c0cbc30 100644
--- a/drivers/net/netxen/netxen_nic_init.c
+++ b/drivers/net/netxen/netxen_nic_init.c
@@ -928,7 +928,7 @@ u32 netxen_process_rcv_ring(struct netxen_adapter *adapter, int ctxid, int max)
 		}
 		netxen_process_rcv(adapter, ctxid, desc);
 		netxen_clear_sts_owner(desc);
-		netxen_set_sts_owner(desc, STATUS_OWNER_PHANTOM);
+		netxen_set_sts_owner(desc, cpu_to_le16(STATUS_OWNER_PHANTOM));
 		consumer = (consumer + 1) & (adapter->max_rx_desc_count - 1);
 		count++;
 	}
@@ -1023,7 +1023,7 @@ int netxen_process_cmd_ring(unsigned long data)
 			     && netif_carrier_ok(port->netdev))
 		    && ((jiffies - port->netdev->trans_start) >
 			port->netdev->watchdog_timeo)) {
-			SCHEDULE_WORK(&port->adapter->tx_timeout_task);
+			SCHEDULE_WORK(&port->tx_timeout_task);
 		}
 
 		last_consumer = get_next_index(last_consumer,
@@ -1138,13 +1138,13 @@ void netxen_post_rx_buffers(struct netxen_adapter *adapter, u32 ctx, u32 ringid)
 		 */
 		dma = pci_map_single(pdev, skb->data, rcv_desc->dma_size,
 				     PCI_DMA_FROMDEVICE);
-		pdesc->addr_buffer = dma;
+		pdesc->addr_buffer = cpu_to_le64(dma);
 		buffer->skb = skb;
 		buffer->state = NETXEN_BUFFER_BUSY;
 		buffer->dma = dma;
 		/* make a rcv descriptor  */
-		pdesc->reference_handle = buffer->ref_handle;
-		pdesc->buffer_length = rcv_desc->dma_size;
+		pdesc->reference_handle = cpu_to_le16(buffer->ref_handle);
+		pdesc->buffer_length = cpu_to_le32(rcv_desc->dma_size);
 		DPRINTK(INFO, "done writing descripter\n");
 		producer =
 		    get_next_index(producer, rcv_desc->max_rx_desc_count);
@@ -1232,8 +1232,8 @@ void netxen_post_rx_buffers_nodb(struct netxen_adapter *adapter, uint32_t ctx,
 					     PCI_DMA_FROMDEVICE);
 
 		/* make a rcv descriptor  */
-		pdesc->reference_handle = le16_to_cpu(buffer->ref_handle);
-		pdesc->buffer_length = le16_to_cpu(rcv_desc->dma_size);
+		pdesc->reference_handle = cpu_to_le16(buffer->ref_handle);
+		pdesc->buffer_length = cpu_to_le16(rcv_desc->dma_size);
 		pdesc->addr_buffer = cpu_to_le64(buffer->dma);
 		DPRINTK(INFO, "done writing descripter\n");
 		producer =
diff --git a/drivers/net/netxen/netxen_nic_isr.c b/drivers/net/netxen/netxen_nic_isr.c
index 1b45f50..06847d4 100644
--- a/drivers/net/netxen/netxen_nic_isr.c
+++ b/drivers/net/netxen/netxen_nic_isr.c
@@ -157,7 +157,8 @@ void netxen_nic_isr_other(struct netxen_adapter *adapter)
 	for (portno = 0; portno < NETXEN_NIU_MAX_GBE_PORTS; portno++) {
 		linkup = val & 1;
 		if (linkup != (qg_linksup & 1)) {
-			printk(KERN_INFO "%s: PORT %d link %s\n",
+			printk(KERN_INFO "%s: %s PORT %d link %s\n",
+			       adapter->port[portno]->netdev->name,
 			       netxen_nic_driver_name, portno,
 			       ((linkup == 0) ? "down" : "up"));
 			netxen_indicate_link_status(adapter, portno, linkup);
diff --git a/drivers/net/netxen/netxen_nic_main.c b/drivers/net/netxen/netxen_nic_main.c
index 575b71b..aecc07d 100644
--- a/drivers/net/netxen/netxen_nic_main.c
+++ b/drivers/net/netxen/netxen_nic_main.c
@@ -53,8 +53,6 @@ char netxen_nic_driver_name[] = "netxen-nic";
 static char netxen_nic_driver_string[] = "NetXen Network Driver version "
     NETXEN_NIC_LINUX_VERSIONID;
 
-struct netxen_adapter *g_adapter = NULL;
-
 #define NETXEN_NETDEV_WEIGHT 120
 #define NETXEN_ADAPTER_UP_MAGIC 777
 #define NETXEN_NIC_PEG_TUNE 0
@@ -90,6 +88,8 @@ static struct pci_device_id netxen_pci_tbl[] __devinitdata = {
 	{PCI_DEVICE(0x4040, 0x0003)},
 	{PCI_DEVICE(0x4040, 0x0004)},
 	{PCI_DEVICE(0x4040, 0x0005)},
+	{PCI_DEVICE(0x4040, 0x0024)},
+	{PCI_DEVICE(0x4040, 0x0025)},
 	{0,}
 };
 
@@ -129,7 +129,6 @@ netxen_nic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct netxen_cmd_buffer *cmd_buf_arr = NULL;
 	u64 mac_addr[FLASH_NUM_PORTS + 1];
 	int valid_mac = 0;
-	static int netxen_cards_found = 0;
 
 	printk(KERN_INFO "%s \n", netxen_nic_driver_string);
 	/* In current scheme, we use only PCI function 0 */
@@ -220,9 +219,6 @@ netxen_nic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_dbunmap;
 	}
 
-	if (netxen_cards_found == 0) {
-		g_adapter = adapter;
-	}
 	adapter->max_tx_desc_count = MAX_CMD_DESCRIPTORS;
 	adapter->max_rx_desc_count = MAX_RCV_DESCRIPTORS;
 	adapter->max_jumbo_rx_desc_count = MAX_JUMBO_RCV_DESCRIPTORS;
@@ -428,8 +424,7 @@ netxen_nic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 							     netdev->dev_addr);
 			}
 		}
-		adapter->netdev = netdev;
-		INIT_WORK(&adapter->tx_timeout_task, netxen_tx_timeout_task);
+		INIT_WORK(&port->tx_timeout_task, netxen_tx_timeout_task);
 		netif_carrier_off(netdev);
 		netif_stop_queue(netdev);
 
@@ -444,6 +439,11 @@ netxen_nic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		adapter->port[i] = port;
 	}
 
+	writel(0, NETXEN_CRB_NORMALIZE(adapter, CRB_CMDPEG_STATE));
+	netxen_pinit_from_rom(adapter, 0);
+	udelay(500);
+	netxen_load_firmware(adapter);
+	netxen_phantom_init(adapter, NETXEN_NIC_PEG_TUNE);
 	/*
 	 * delay a while to ensure that the Pegs are up & running.
 	 * Otherwise, we might see some flaky behaviour.
@@ -461,7 +461,6 @@ netxen_nic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		break;
 	}
 
-	adapter->number = netxen_cards_found;
 	adapter->driver_mismatch = 0;
 
 	return 0;
@@ -531,6 +530,8 @@ static void __devexit netxen_nic_remove(struct pci_dev *pdev)
 
 	netxen_nic_stop_all_ports(adapter);
 	/* leave the hw in the same state as reboot */
+	netxen_pinit_from_rom(adapter, 0);
+	writel(0, NETXEN_CRB_NORMALIZE(adapter, CRB_CMDPEG_STATE));
 	netxen_load_firmware(adapter);
 	netxen_free_adapter_offload(adapter);
 
@@ -821,8 +822,8 @@ static int netxen_nic_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 	/* Take skb->data itself */
 	pbuf = &adapter->cmd_buf_arr[producer];
 	if ((netdev->features & NETIF_F_TSO) && skb_shinfo(skb)->gso_size > 0) {
-		pbuf->mss = skb_shinfo(skb)->gso_size;
-		hwdesc->mss = skb_shinfo(skb)->gso_size;
+		pbuf->mss = cpu_to_le16(skb_shinfo(skb)->gso_size);
+		hwdesc->mss = cpu_to_le16(skb_shinfo(skb)->gso_size);
 	} else {
 		pbuf->mss = 0;
 		hwdesc->mss = 0;
@@ -956,11 +957,6 @@ static int netxen_nic_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 static void netxen_watchdog(unsigned long v)
 {
 	struct netxen_adapter *adapter = (struct netxen_adapter *)v;
-	if (adapter != g_adapter) {
-		printk("%s: ***BUG*** adapter[%p] != g_adapter[%p]\n",
-		       __FUNCTION__, adapter, g_adapter);
-		return;
-	}
 
 	SCHEDULE_WORK(&adapter->watchdog_task);
 }
@@ -969,23 +965,23 @@ static void netxen_tx_timeout(struct net_device *netdev)
 {
 	struct netxen_port *port = (struct netxen_port *)netdev_priv(netdev);
 
-	SCHEDULE_WORK(&port->adapter->tx_timeout_task);
+	SCHEDULE_WORK(&port->tx_timeout_task);
 }
 
 static void netxen_tx_timeout_task(struct work_struct *work)
 {
-	struct netxen_adapter *adapter =
-		container_of(work, struct netxen_adapter, tx_timeout_task);
-	struct net_device *netdev = adapter->netdev;
+	struct netxen_port *port =
+		container_of(work, struct netxen_port, tx_timeout_task);
+	struct net_device *netdev = port->netdev;
 	unsigned long flags;
 
 	printk(KERN_ERR "%s %s: transmit timeout, resetting.\n",
 	       netxen_nic_driver_name, netdev->name);
 
-	spin_lock_irqsave(&adapter->lock, flags);
+	spin_lock_irqsave(&port->adapter->lock, flags);
 	netxen_nic_close(netdev);
 	netxen_nic_open(netdev);
-	spin_unlock_irqrestore(&adapter->lock, flags);
+	spin_unlock_irqrestore(&port->adapter->lock, flags);
 	netdev->trans_start = jiffies;
 	netif_wake_queue(netdev);
 }
diff --git a/drivers/net/r8169.c b/drivers/net/r8169.c
index f83b41d..577babd 100644
--- a/drivers/net/r8169.c
+++ b/drivers/net/r8169.c
@@ -225,7 +225,6 @@ MODULE_DEVICE_TABLE(pci, rtl8169_pci_tbl);
 
 static int rx_copybreak = 200;
 static int use_dac;
-static int ignore_parity_err;
 static struct {
 	u32 msg_enable;
 } debug = { -1 };
@@ -471,8 +470,6 @@ module_param(use_dac, int, 0);
 MODULE_PARM_DESC(use_dac, "Enable PCI DAC. Unsafe on 32 bit PCI slot.");
 module_param_named(debug, debug.msg_enable, int, 0);
 MODULE_PARM_DESC(debug, "Debug verbosity level (0=none, ..., 16=all)");
-module_param_named(ignore_parity_err, ignore_parity_err, bool, 0);
-MODULE_PARM_DESC(ignore_parity_err, "Ignore PCI parity error as target. Default: false");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(RTL8169_VERSION);
 
@@ -1885,7 +1882,6 @@ static void rtl8169_hw_start(struct net_device *dev)
 	    (tp->mac_version == RTL_GIGA_MAC_VER_02) ||
 	    (tp->mac_version == RTL_GIGA_MAC_VER_03) ||
 	    (tp->mac_version == RTL_GIGA_MAC_VER_04))
-		RTL_W8(ChipCmd, CmdTxEnb | CmdRxEnb);
 		rtl8169_set_rx_tx_config_registers(tp);
 
 	cmd = RTL_R16(CPlusCmd);
@@ -2388,7 +2384,7 @@ static void rtl8169_pcierr_interrupt(struct net_device *dev)
 	 *
 	 * Feel free to adjust to your needs.
 	 */
-	if (ignore_parity_err)
+	if (pdev->broken_parity_status)
 		pci_cmd &= ~PCI_COMMAND_PARITY;
 	else
 		pci_cmd |= PCI_COMMAND_SERR | PCI_COMMAND_PARITY;
diff --git a/drivers/net/skge.c b/drivers/net/skge.c
index 8a39376..deedfd5 100644
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -2920,6 +2920,7 @@ static int skge_poll(struct net_device *dev, int *budget)
 	struct skge_hw *hw = skge->hw;
 	struct skge_ring *ring = &skge->rx_ring;
 	struct skge_element *e;
+	unsigned long flags;
 	int to_do = min(dev->quota, *budget);
 	int work_done = 0;
 
@@ -2957,12 +2958,12 @@ static int skge_poll(struct net_device *dev, int *budget)
 	if (work_done >=  to_do)
 		return 1; /* not done */
 
-	spin_lock_irq(&hw->hw_lock);
+	spin_lock_irqsave(&hw->hw_lock, flags);
 	__netif_rx_complete(dev);
 	hw->intr_mask |= irqmask[skge->port];
   	skge_write32(hw, B0_IMSK, hw->intr_mask);
 	skge_read32(hw, B0_IMSK);
-	spin_unlock_irq(&hw->hw_lock);
+	spin_unlock_irqrestore(&hw->hw_lock, flags);
 
 	return 0;
 }
diff --git a/drivers/net/sky2.c b/drivers/net/sky2.c
index fb1d2c3..a6601e8 100644
--- a/drivers/net/sky2.c
+++ b/drivers/net/sky2.c
@@ -569,8 +569,8 @@ static void sky2_phy_power(struct sky2_hw *hw, unsigned port, int onoff)
 	if (hw->chip_id == CHIP_ID_YUKON_XL && hw->chip_rev > 1)
 		onoff = !onoff;
 
+	sky2_write8(hw, B2_TST_CTRL1, TST_CFG_WRITE_ON);
 	reg1 = sky2_pci_read32(hw, PCI_DEV_REG1);
-
 	if (onoff)
 		/* Turn off phy power saving */
 		reg1 &= ~phy_power[port];
@@ -579,6 +579,7 @@ static void sky2_phy_power(struct sky2_hw *hw, unsigned port, int onoff)
 
 	sky2_pci_write32(hw, PCI_DEV_REG1, reg1);
 	sky2_pci_read32(hw, PCI_DEV_REG1);
+	sky2_write8(hw, B2_TST_CTRL1, TST_CFG_WRITE_OFF);
 	udelay(100);
 }
 
@@ -1511,6 +1512,13 @@ static int sky2_down(struct net_device *dev)
 	imask &= ~portirq_msk[port];
 	sky2_write32(hw, B0_IMSK, imask);
 
+	/*
+	 * Both ports share the NAPI poll on port 0, so if necessary undo the
+	 * the disable that is done in dev_close.
+	 */
+	if (sky2->port == 0 && hw->ports > 1)
+		netif_poll_enable(dev);
+
 	sky2_gmac_reset(hw, port);
 
 	/* Stop transmitter */
@@ -3631,6 +3639,29 @@ static int sky2_resume(struct pci_dev *pdev)
 out:
 	return err;
 }
+
+/* BIOS resume runs after device (it's a bug in PM)
+ * as a temporary workaround on suspend/resume leave MSI disabled
+ */
+static int sky2_suspend_late(struct pci_dev *pdev, pm_message_t state)
+{
+	struct sky2_hw *hw = pci_get_drvdata(pdev);
+
+	free_irq(pdev->irq, hw);
+	if (hw->msi) {
+		pci_disable_msi(pdev);
+		hw->msi = 0;
+	}
+	return 0;
+}
+
+static int sky2_resume_early(struct pci_dev *pdev)
+{
+	struct sky2_hw *hw = pci_get_drvdata(pdev);
+	struct net_device *dev = hw->dev[0];
+
+	return request_irq(pdev->irq, sky2_intr, IRQF_SHARED, dev->name, hw);
+}
 #endif
 
 static struct pci_driver sky2_driver = {
@@ -3641,6 +3672,8 @@ static struct pci_driver sky2_driver = {
 #ifdef CONFIG_PM
 	.suspend = sky2_suspend,
 	.resume = sky2_resume,
+	.suspend_late = sky2_suspend_late,
+	.resume_early = sky2_resume_early,
 #endif
 };
 
diff --git a/drivers/net/via-velocity.c b/drivers/net/via-velocity.c
index 4587f23..8e5d820 100644
--- a/drivers/net/via-velocity.c
+++ b/drivers/net/via-velocity.c
@@ -265,15 +265,19 @@ static int velocity_set_media_mode(struct velocity_info *vptr, u32 mii_status);
 static int velocity_suspend(struct pci_dev *pdev, pm_message_t state);
 static int velocity_resume(struct pci_dev *pdev);
 
+static DEFINE_SPINLOCK(velocity_dev_list_lock);
+static LIST_HEAD(velocity_dev_list);
+
+#endif
+
+#if defined(CONFIG_PM) && defined(CONFIG_INET)
+
 static int velocity_netdev_event(struct notifier_block *nb, unsigned long notification, void *ptr);
 
 static struct notifier_block velocity_inetaddr_notifier = {
       .notifier_call	= velocity_netdev_event,
 };
 
-static DEFINE_SPINLOCK(velocity_dev_list_lock);
-static LIST_HEAD(velocity_dev_list);
-
 static void velocity_register_notifier(void)
 {
 	register_inetaddr_notifier(&velocity_inetaddr_notifier);
@@ -284,12 +288,12 @@ static void velocity_unregister_notifier(void)
 	unregister_inetaddr_notifier(&velocity_inetaddr_notifier);
 }
 
-#else				/* CONFIG_PM */
+#else
 
 #define velocity_register_notifier()	do {} while (0)
 #define velocity_unregister_notifier()	do {} while (0)
 
-#endif				/* !CONFIG_PM */
+#endif
 
 /*
  *	Internal board variants. At the moment we have only one
@@ -3292,6 +3296,8 @@ static int velocity_resume(struct pci_dev *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_INET
+
 static int velocity_netdev_event(struct notifier_block *nb, unsigned long notification, void *ptr)
 {
 	struct in_ifaddr *ifa = (struct in_ifaddr *) ptr;
@@ -3312,4 +3318,6 @@ static int velocity_netdev_event(struct notifier_block *nb, unsigned long notifi
 	}
 	return NOTIFY_DONE;
 }
+
+#endif
 #endif
diff --git a/drivers/net/wireless/zd1211rw/zd_mac.c b/drivers/net/wireless/zd1211rw/zd_mac.c
index 00ca704..a085241 100644
--- a/drivers/net/wireless/zd1211rw/zd_mac.c
+++ b/drivers/net/wireless/zd1211rw/zd_mac.c
@@ -41,6 +41,8 @@ static void housekeeping_disable(struct zd_mac *mac);
 
 static void set_multicast_hash_handler(struct work_struct *work);
 
+static void do_rx(unsigned long mac_ptr);
+
 int zd_mac_init(struct zd_mac *mac,
 	        struct net_device *netdev,
 	        struct usb_interface *intf)
@@ -53,6 +55,10 @@ int zd_mac_init(struct zd_mac *mac,
 	INIT_DELAYED_WORK(&mac->set_rts_cts_work, set_rts_cts_work);
 	INIT_DELAYED_WORK(&mac->set_basic_rates_work, set_basic_rates_work);
 
+	skb_queue_head_init(&mac->rx_queue);
+	tasklet_init(&mac->rx_tasklet, do_rx, (unsigned long)mac);
+	tasklet_disable(&mac->rx_tasklet);
+
 	ieee_init(ieee);
 	softmac_init(ieee80211_priv(netdev));
 	zd_chip_init(&mac->chip, netdev, intf);
@@ -140,6 +146,8 @@ out:
 void zd_mac_clear(struct zd_mac *mac)
 {
 	flush_workqueue(zd_workqueue);
+	skb_queue_purge(&mac->rx_queue);
+	tasklet_kill(&mac->rx_tasklet);
 	zd_chip_clear(&mac->chip);
 	ZD_ASSERT(!spin_is_locked(&mac->lock));
 	ZD_MEMCLEAR(mac, sizeof(struct zd_mac));
@@ -168,6 +176,8 @@ int zd_mac_open(struct net_device *netdev)
 	struct zd_chip *chip = &mac->chip;
 	int r;
 
+	tasklet_enable(&mac->rx_tasklet);
+
 	r = zd_chip_enable_int(chip);
 	if (r < 0)
 		goto out;
@@ -218,6 +228,8 @@ int zd_mac_stop(struct net_device *netdev)
 	 */
 
 	zd_chip_disable_rx(chip);
+	skb_queue_purge(&mac->rx_queue);
+	tasklet_disable(&mac->rx_tasklet);
 	housekeeping_disable(mac);
 	ieee80211softmac_stop(netdev);
 
@@ -470,13 +482,13 @@ static void bssinfo_change(struct net_device *netdev, u32 changes)
 
 	if (changes & IEEE80211SOFTMAC_BSSINFOCHG_RATES) {
 		/* Set RTS rate to highest available basic rate */
-		u8 rate = ieee80211softmac_highest_supported_rate(softmac,
+		u8 hi_rate = ieee80211softmac_highest_supported_rate(softmac,
 			&bssinfo->supported_rates, 1);
-		rate = rate_to_zd_rate(rate);
+		hi_rate = rate_to_zd_rate(hi_rate);
 
 		spin_lock_irqsave(&mac->lock, flags);
-		if (rate != mac->rts_rate) {
-			mac->rts_rate = rate;
+		if (hi_rate != mac->rts_rate) {
+			mac->rts_rate = hi_rate;
 			need_set_rts_cts = 1;
 		}
 		spin_unlock_irqrestore(&mac->lock, flags);
@@ -1072,43 +1084,75 @@ static int fill_rx_stats(struct ieee80211_rx_stats *stats,
 	return 0;
 }
 
-int zd_mac_rx(struct zd_mac *mac, const u8 *buffer, unsigned int length)
+static void zd_mac_rx(struct zd_mac *mac, struct sk_buff *skb)
 {
 	int r;
 	struct ieee80211_device *ieee = zd_mac_to_ieee80211(mac);
 	struct ieee80211_rx_stats stats;
 	const struct rx_status *status;
-	struct sk_buff *skb;
 
-	if (length < ZD_PLCP_HEADER_SIZE + IEEE80211_1ADDR_LEN +
-	             IEEE80211_FCS_LEN + sizeof(struct rx_status))
-		return -EINVAL;
+	if (skb->len < ZD_PLCP_HEADER_SIZE + IEEE80211_1ADDR_LEN +
+	               IEEE80211_FCS_LEN + sizeof(struct rx_status))
+	{
+		dev_dbg_f(zd_mac_dev(mac), "Packet with length %u to small.\n",
+			 skb->len);
+		goto free_skb;
+	}
 
-	r = fill_rx_stats(&stats, &status, mac, buffer, length);
-	if (r)
-		return r;
+	r = fill_rx_stats(&stats, &status, mac, skb->data, skb->len);
+	if (r) {
+		/* Only packets with rx errors are included here. */
+		goto free_skb;
+	}
 
-	length -= ZD_PLCP_HEADER_SIZE+IEEE80211_FCS_LEN+
-		  sizeof(struct rx_status);
-	buffer += ZD_PLCP_HEADER_SIZE;
+	__skb_pull(skb, ZD_PLCP_HEADER_SIZE);
+	__skb_trim(skb, skb->len -
+		        (IEEE80211_FCS_LEN + sizeof(struct rx_status)));
 
-	update_qual_rssi(mac, buffer, length, stats.signal, stats.rssi);
+	update_qual_rssi(mac, skb->data, skb->len, stats.signal,
+		         status->signal_strength);
 
-	r = filter_rx(ieee, buffer, length, &stats);
-	if (r <= 0)
-		return r;
+	r = filter_rx(ieee, skb->data, skb->len, &stats);
+	if (r <= 0) {
+		if (r < 0)
+			dev_dbg_f(zd_mac_dev(mac), "Error in packet.\n");
+		goto free_skb;
+	}
 
-	skb = dev_alloc_skb(sizeof(struct zd_rt_hdr) + length);
-	if (!skb)
-		return -ENOMEM;
 	if (ieee->iw_mode == IW_MODE_MONITOR)
-		fill_rt_header(skb_put(skb, sizeof(struct zd_rt_hdr)), mac,
+		fill_rt_header(skb_push(skb, sizeof(struct zd_rt_hdr)), mac,
 			       &stats, status);
-	memcpy(skb_put(skb, length), buffer, length);
 
 	r = ieee80211_rx(ieee, skb, &stats);
-	if (!r)
-		dev_kfree_skb_any(skb);
+	if (r)
+		return;
+free_skb:
+	/* We are always in a soft irq. */
+	dev_kfree_skb(skb);
+}
+
+static void do_rx(unsigned long mac_ptr)
+{
+	struct zd_mac *mac = (struct zd_mac *)mac_ptr;
+	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(&mac->rx_queue)) != NULL)
+		zd_mac_rx(mac, skb);
+}
+
+int zd_mac_rx_irq(struct zd_mac *mac, const u8 *buffer, unsigned int length)
+{
+	struct sk_buff *skb;
+
+	skb = dev_alloc_skb(sizeof(struct zd_rt_hdr) + length);
+	if (!skb) {
+		dev_warn(zd_mac_dev(mac), "Could not allocate skb.\n");
+		return -ENOMEM;
+	}
+	skb_reserve(skb, sizeof(struct zd_rt_hdr));
+	memcpy(__skb_put(skb, length), buffer, length);
+	skb_queue_tail(&mac->rx_queue, skb);
+	tasklet_schedule(&mac->rx_tasklet);
 	return 0;
 }
 
diff --git a/drivers/net/wireless/zd1211rw/zd_mac.h b/drivers/net/wireless/zd1211rw/zd_mac.h
index f0cf05d..faf4c78 100644
--- a/drivers/net/wireless/zd1211rw/zd_mac.h
+++ b/drivers/net/wireless/zd1211rw/zd_mac.h
@@ -138,6 +138,9 @@ struct zd_mac {
 	struct delayed_work set_rts_cts_work;
 	struct delayed_work set_basic_rates_work;
 
+	struct tasklet_struct rx_tasklet;
+	struct sk_buff_head rx_queue;
+
 	unsigned int stats_count;
 	u8 qual_buffer[ZD_MAC_STATS_BUFFER_SIZE];
 	u8 rssi_buffer[ZD_MAC_STATS_BUFFER_SIZE];
@@ -193,7 +196,7 @@ int zd_mac_stop(struct net_device *netdev);
 int zd_mac_set_mac_address(struct net_device *dev, void *p);
 void zd_mac_set_multicast_list(struct net_device *netdev);
 
-int zd_mac_rx(struct zd_mac *mac, const u8 *buffer, unsigned int length);
+int zd_mac_rx_irq(struct zd_mac *mac, const u8 *buffer, unsigned int length);
 
 int zd_mac_set_regdomain(struct zd_mac *zd_mac, u8 regdomain);
 u8 zd_mac_get_regdomain(struct zd_mac *zd_mac);
diff --git a/drivers/net/wireless/zd1211rw/zd_usb.c b/drivers/net/wireless/zd1211rw/zd_usb.c
index aa782e8..605e96e 100644
--- a/drivers/net/wireless/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zd1211rw/zd_usb.c
@@ -598,13 +598,13 @@ static void handle_rx_packet(struct zd_usb *usb, const u8 *buffer,
 			n = l+k;
 			if (n > length)
 				return;
-			zd_mac_rx(mac, buffer+l, k);
+			zd_mac_rx_irq(mac, buffer+l, k);
 			if (i >= 2)
 				return;
 			l = (n+3) & ~3;
 		}
 	} else {
-		zd_mac_rx(mac, buffer, length);
+		zd_mac_rx_irq(mac, buffer, length);
 	}
 }
 
diff --git a/net/ieee80211/softmac/ieee80211softmac_assoc.c b/net/ieee80211/softmac/ieee80211softmac_assoc.c
index e3f37fd..a824852 100644
--- a/net/ieee80211/softmac/ieee80211softmac_assoc.c
+++ b/net/ieee80211/softmac/ieee80211softmac_assoc.c
@@ -167,7 +167,7 @@ static void
 ieee80211softmac_assoc_notify_scan(struct net_device *dev, int event_type, void *context)
 {
 	struct ieee80211softmac_device *mac = ieee80211_priv(dev);
-	ieee80211softmac_assoc_work((void*)mac);
+	ieee80211softmac_assoc_work(&mac->associnfo.work.work);
 }
 
 static void
@@ -177,7 +177,7 @@ ieee80211softmac_assoc_notify_auth(struct net_device *dev, int event_type, void
 
 	switch (event_type) {
 	case IEEE80211SOFTMAC_EVENT_AUTHENTICATED:
-		ieee80211softmac_assoc_work((void*)mac);
+		ieee80211softmac_assoc_work(&mac->associnfo.work.work);
 		break;
 	case IEEE80211SOFTMAC_EVENT_AUTH_FAILED:
 	case IEEE80211SOFTMAC_EVENT_AUTH_TIMEOUT:
diff --git a/net/ieee80211/softmac/ieee80211softmac_wx.c b/net/ieee80211/softmac/ieee80211softmac_wx.c
index 480d72c..fa2f7da 100644
--- a/net/ieee80211/softmac/ieee80211softmac_wx.c
+++ b/net/ieee80211/softmac/ieee80211softmac_wx.c
@@ -463,7 +463,7 @@ ieee80211softmac_wx_get_genie(struct net_device *dev,
 			err = -E2BIG;
 	}
 	spin_unlock_irqrestore(&mac->lock, flags);
-	mutex_lock(&mac->associnfo.mutex);
+	mutex_unlock(&mac->associnfo.mutex);
 
 	return err;
 }
