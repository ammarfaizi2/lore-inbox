Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbVBQUdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbVBQUdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 15:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVBQUc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 15:32:58 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60171 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261192AbVBQUbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:31:22 -0500
Date: Thu, 17 Feb 2005 21:31:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: cramerj@intel.com, john.ronciak@intel.com, ganesh.venkatesan@intel.com
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/e1000/: possible cleanups
Message-ID: <20050217203120.GD6194@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- #if 0 the following unised functions:
  - e1000_hw.c: e1000_mc_addr_list_update
  - e1000_hw.c: e1000_read_reg_io

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/e1000/e1000_ethtool.c |    2 -
 drivers/net/e1000/e1000_hw.c      |   51 +++++++++++++++++++++---------
 drivers/net/e1000/e1000_hw.h      |   21 ------------
 drivers/net/e1000/e1000_main.c    |    6 +--
 4 files changed, 41 insertions(+), 39 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/net/e1000/e1000_ethtool.c.old	2005-02-16 15:26:52.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/e1000/e1000_ethtool.c	2005-02-16 15:27:03.000000000 +0100
@@ -1629,7 +1629,7 @@
 	}
 }
 
-struct ethtool_ops e1000_ethtool_ops = {
+static struct ethtool_ops e1000_ethtool_ops = {
 	.get_settings           = e1000_get_settings,
 	.set_settings           = e1000_set_settings,
 	.get_drvinfo            = e1000_get_drvinfo,
--- linux-2.6.11-rc3-mm2-full/drivers/net/e1000/e1000_hw.h.old	2005-02-16 15:27:21.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/e1000/e1000_hw.h	2005-02-16 15:38:29.000000000 +0100
@@ -266,10 +266,8 @@
 int32_t e1000_setup_link(struct e1000_hw *hw);
 int32_t e1000_phy_setup_autoneg(struct e1000_hw *hw);
 void e1000_config_collision_dist(struct e1000_hw *hw);
-int32_t e1000_config_fc_after_link_up(struct e1000_hw *hw);
 int32_t e1000_check_for_link(struct e1000_hw *hw);
 int32_t e1000_get_speed_and_duplex(struct e1000_hw *hw, uint16_t * speed, uint16_t * duplex);
-int32_t e1000_wait_autoneg(struct e1000_hw *hw);
 int32_t e1000_force_mac_fc(struct e1000_hw *hw);
 
 /* PHY */
@@ -277,13 +275,7 @@
 int32_t e1000_write_phy_reg(struct e1000_hw *hw, uint32_t reg_addr, uint16_t data);
 void e1000_phy_hw_reset(struct e1000_hw *hw);
 int32_t e1000_phy_reset(struct e1000_hw *hw);
-int32_t e1000_detect_gig_phy(struct e1000_hw *hw);
 int32_t e1000_phy_get_info(struct e1000_hw *hw, struct e1000_phy_info *phy_info);
-int32_t e1000_phy_m88_get_info(struct e1000_hw *hw, struct e1000_phy_info *phy_info);
-int32_t e1000_phy_igp_get_info(struct e1000_hw *hw, struct e1000_phy_info *phy_info);
-int32_t e1000_get_cable_length(struct e1000_hw *hw, uint16_t *min_length, uint16_t *max_length);
-int32_t e1000_check_polarity(struct e1000_hw *hw, uint16_t *polarity);
-int32_t e1000_check_downshift(struct e1000_hw *hw);
 int32_t e1000_validate_mdi_setting(struct e1000_hw *hw);
 
 /* EEPROM Functions */
@@ -296,13 +288,10 @@
 int32_t e1000_read_mac_addr(struct e1000_hw * hw);
 
 /* Filters (multicast, vlan, receive) */
-void e1000_init_rx_addrs(struct e1000_hw *hw);
-void e1000_mc_addr_list_update(struct e1000_hw *hw, uint8_t * mc_addr_list, uint32_t mc_addr_count, uint32_t pad, uint32_t rar_used_count);
 uint32_t e1000_hash_mc_addr(struct e1000_hw *hw, uint8_t * mc_addr);
 void e1000_mta_set(struct e1000_hw *hw, uint32_t hash_value);
 void e1000_rar_set(struct e1000_hw *hw, uint8_t * mc_addr, uint32_t rar_index);
 void e1000_write_vfta(struct e1000_hw *hw, uint32_t offset, uint32_t value);
-void e1000_clear_vfta(struct e1000_hw *hw);
 
 /* LED functions */
 int32_t e1000_setup_led(struct e1000_hw *hw);
@@ -314,7 +303,6 @@
 
 /* Everything else */
 uint32_t e1000_enable_mng_pass_thru(struct e1000_hw *hw);
-void e1000_clear_hw_cntrs(struct e1000_hw *hw);
 void e1000_reset_adaptive(struct e1000_hw *hw);
 void e1000_update_adaptive(struct e1000_hw *hw);
 void e1000_tbi_adjust_stats(struct e1000_hw *hw, struct e1000_hw_stats *stats, uint32_t frame_len, uint8_t * mac_addr);
@@ -325,16 +313,7 @@
 void e1000_write_pci_cfg(struct e1000_hw *hw, uint32_t reg, uint16_t * value);
 /* Port I/O is only supported on 82544 and newer */
 uint32_t e1000_io_read(struct e1000_hw *hw, unsigned long port);
-uint32_t e1000_read_reg_io(struct e1000_hw *hw, uint32_t offset);
 void e1000_io_write(struct e1000_hw *hw, unsigned long port, uint32_t value);
-void e1000_write_reg_io(struct e1000_hw *hw, uint32_t offset, uint32_t value);
-int32_t e1000_config_dsp_after_link_change(struct e1000_hw *hw, boolean_t link_up);
-int32_t e1000_set_d3_lplu_state(struct e1000_hw *hw, boolean_t active);
-
-#define E1000_READ_REG_IO(a, reg) \
-    e1000_read_reg_io((a), E1000_##reg)
-#define E1000_WRITE_REG_IO(a, reg, val) \
-    e1000_write_reg_io((a), E1000_##reg, val)
 
 /* PCI Device IDs */
 #define E1000_DEV_ID_82542               0x1000
--- linux-2.6.11-rc3-mm2-full/drivers/net/e1000/e1000_hw.c.old	2005-02-16 15:27:38.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/e1000/e1000_hw.c	2005-02-16 15:38:24.000000000 +0100
@@ -67,6 +67,25 @@
 static int32_t e1000_set_vco_speed(struct e1000_hw *hw);
 static int32_t e1000_polarity_reversal_workaround(struct e1000_hw *hw);
 static int32_t e1000_set_phy_mode(struct e1000_hw *hw);
+static int32_t e1000_check_downshift(struct e1000_hw *hw);
+static int32_t e1000_check_polarity(struct e1000_hw *hw, uint16_t *polarity);
+static void e1000_clear_hw_cntrs(struct e1000_hw *hw);
+static void e1000_clear_vfta(struct e1000_hw *hw);
+static int32_t e1000_config_dsp_after_link_change(struct e1000_hw *hw,
+						  boolean_t link_up);
+static int32_t e1000_config_fc_after_link_up(struct e1000_hw *hw);
+static int32_t e1000_detect_gig_phy(struct e1000_hw *hw);
+static int32_t e1000_get_cable_length(struct e1000_hw *hw,
+				      uint16_t *min_length,
+				      uint16_t *max_length);
+static void e1000_init_rx_addrs(struct e1000_hw *hw);
+static int32_t e1000_set_d3_lplu_state(struct e1000_hw *hw, boolean_t active);
+static int32_t e1000_wait_autoneg(struct e1000_hw *hw);
+static void e1000_write_reg_io(struct e1000_hw *hw, uint32_t offset,
+			       uint32_t value);
+
+#define E1000_WRITE_REG_IO(a, reg, val) \
+    e1000_write_reg_io((a), E1000_##reg, val)
 
 /* IGP cable length table */
 static const
@@ -1809,7 +1828,7 @@
  * based on the flow control negotiated by the PHY. In TBI mode, the TFCE
  * and RFCE bits will be automaticaly set to the negotiated flow control mode.
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_config_fc_after_link_up(struct e1000_hw *hw)
 {
     int32_t ret_val;
@@ -2311,7 +2330,7 @@
 *
 * hw - Struct containing variables accessed by shared code
 ******************************************************************************/
-int32_t
+static int32_t
 e1000_wait_autoneg(struct e1000_hw *hw)
 {
     int32_t ret_val;
@@ -2767,7 +2786,7 @@
 *
 * hw - Struct containing variables accessed by shared code
 ******************************************************************************/
-int32_t
+static int32_t
 e1000_detect_gig_phy(struct e1000_hw *hw)
 {
     int32_t phy_init_status, ret_val;
@@ -2854,7 +2873,7 @@
 * hw - Struct containing variables accessed by shared code
 * phy_info - PHY information structure
 ******************************************************************************/
-int32_t
+static int32_t
 e1000_phy_igp_get_info(struct e1000_hw *hw,
                        struct e1000_phy_info *phy_info)
 {
@@ -2928,7 +2947,7 @@
 * hw - Struct containing variables accessed by shared code
 * phy_info - PHY information structure
 ******************************************************************************/
-int32_t
+static int32_t
 e1000_phy_m88_get_info(struct e1000_hw *hw,
                        struct e1000_phy_info *phy_info)
 {
@@ -3907,7 +3926,7 @@
  * of the receive addresss registers. Clears the multicast table. Assumes
  * the receiver is in reset when the routine is called.
  *****************************************************************************/
-void
+static void
 e1000_init_rx_addrs(struct e1000_hw *hw)
 {
     uint32_t i;
@@ -3941,6 +3960,7 @@
  * for the first 15 multicast addresses, and hashes the rest into the
  * multicast table.
  *****************************************************************************/
+#if 0
 void
 e1000_mc_addr_list_update(struct e1000_hw *hw,
                           uint8_t *mc_addr_list,
@@ -4000,6 +4020,7 @@
     }
     DEBUGOUT("MC Update Complete\n");
 }
+#endif  /*  0  */
 
 /******************************************************************************
  * Hashes an address to determine its location in the multicast table
@@ -4140,7 +4161,7 @@
  *
  * hw - Struct containing variables accessed by shared code
  *****************************************************************************/
-void
+static void
 e1000_clear_vfta(struct e1000_hw *hw)
 {
     uint32_t offset;
@@ -4411,7 +4432,7 @@
  *
  * hw - Struct containing variables accessed by shared code
  *****************************************************************************/
-void
+static void
 e1000_clear_hw_cntrs(struct e1000_hw *hw)
 {
     volatile uint32_t temp;
@@ -4682,6 +4703,7 @@
  * hw - Struct containing variables accessed by shared code
  * offset - offset to read from
  *****************************************************************************/
+#if 0
 uint32_t
 e1000_read_reg_io(struct e1000_hw *hw,
                   uint32_t offset)
@@ -4692,6 +4714,7 @@
     e1000_io_write(hw, io_addr, offset);
     return e1000_io_read(hw, io_data);
 }
+#endif  /*  0  */
 
 /******************************************************************************
  * Writes a value to one of the devices registers using port I/O (as opposed to
@@ -4701,7 +4724,7 @@
  * offset - offset to write to
  * value - value to write
  *****************************************************************************/
-void
+static void
 e1000_write_reg_io(struct e1000_hw *hw,
                    uint32_t offset,
                    uint32_t value)
@@ -4729,7 +4752,7 @@
  * register to the minimum and maximum range.
  * For IGP phy's, the function calculates the range by the AGC registers.
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_get_cable_length(struct e1000_hw *hw,
                        uint16_t *min_length,
                        uint16_t *max_length)
@@ -4843,7 +4866,7 @@
  * return 0.  If the link speed is 1000 Mbps the polarity status is in the
  * IGP01E1000_PHY_PCS_INIT_REG.
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_check_polarity(struct e1000_hw *hw,
                      uint16_t *polarity)
 {
@@ -4904,7 +4927,7 @@
  * Link Health register.  In IGP this bit is latched high, so the driver must
  * read it immediately after link is established.
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_check_downshift(struct e1000_hw *hw)
 {
     int32_t ret_val;
@@ -4944,7 +4967,7 @@
  *
  ****************************************************************************/
 
-int32_t
+static int32_t
 e1000_config_dsp_after_link_change(struct e1000_hw *hw,
                                    boolean_t link_up)
 {
@@ -5175,7 +5198,7 @@
  *
  ****************************************************************************/
 
-int32_t
+static int32_t
 e1000_set_d3_lplu_state(struct e1000_hw *hw,
                         boolean_t active)
 {
--- linux-2.6.11-rc3-mm2-full/drivers/net/e1000/e1000_main.c.old	2005-02-16 15:38:42.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/e1000/e1000_main.c	2005-02-16 15:39:23.000000000 +0100
@@ -51,14 +51,14 @@
  */
 
 char e1000_driver_name[] = "e1000";
-char e1000_driver_string[] = "Intel(R) PRO/1000 Network Driver";
+static char e1000_driver_string[] = "Intel(R) PRO/1000 Network Driver";
 #ifndef CONFIG_E1000_NAPI
 #define DRIVERNAPI
 #else
 #define DRIVERNAPI "-NAPI"
 #endif
 char e1000_driver_version[] = "5.6.10.1-k2"DRIVERNAPI;
-char e1000_copyright[] = "Copyright (c) 1999-2004 Intel Corporation.";
+static char e1000_copyright[] = "Copyright (c) 1999-2004 Intel Corporation.";
 
 /* e1000_pci_tbl - PCI Device ID Table
  *
@@ -176,7 +176,7 @@
 static void e1000_netpoll (struct net_device *netdev);
 #endif
 
-struct notifier_block e1000_notifier_reboot = {
+static struct notifier_block e1000_notifier_reboot = {
 	.notifier_call	= e1000_notify_reboot,
 	.next		= NULL,
 	.priority	= 0

