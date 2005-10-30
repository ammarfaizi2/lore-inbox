Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbVJ3Pxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVJ3Pxj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 10:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVJ3Pxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 10:53:38 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:46606 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932157AbVJ3Pxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 10:53:35 -0500
Date: Sun, 30 Oct 2005 16:53:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: cramerj@intel.com, john.ronciak@intel.com, ganesh.venkatesan@intel.com
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/e1000/: possible cleanups
Message-ID: <20051030155334.GB4180@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- #if 0 the following unused global functions:
  - e1000_hw.c: e1000_mc_addr_list_update
  - e1000_hw.c: e1000_read_reg_io
  - e1000_hw.c: e1000_enable_pciex_master


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/e1000/e1000_ethtool.c |    2 
 drivers/net/e1000/e1000_hw.c      |  101 ++++++++++++++++++++----------
 drivers/net/e1000/e1000_hw.h      |   42 ------------
 drivers/net/e1000/e1000_main.c    |   31 ++++-----
 4 files changed, 87 insertions(+), 89 deletions(-)

--- linux-2.6.14-rc5-mm1-full/drivers/net/e1000/e1000_ethtool.c.old	2005-10-30 15:48:13.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/net/e1000/e1000_ethtool.c	2005-10-30 15:48:20.000000000 +0100
@@ -1739,7 +1739,7 @@
 	}
 }
 
-struct ethtool_ops e1000_ethtool_ops = {
+static struct ethtool_ops e1000_ethtool_ops = {
 	.get_settings           = e1000_get_settings,
 	.set_settings           = e1000_set_settings,
 	.get_drvinfo            = e1000_get_drvinfo,
--- linux-2.6.14-rc5-mm1-full/drivers/net/e1000/e1000_hw.h.old	2005-10-30 15:48:35.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/net/e1000/e1000_hw.h	2005-10-30 16:04:05.000000000 +0100
@@ -284,7 +284,6 @@
 /* Initialization */
 int32_t e1000_reset_hw(struct e1000_hw *hw);
 int32_t e1000_init_hw(struct e1000_hw *hw);
-int32_t e1000_id_led_init(struct e1000_hw * hw);
 int32_t e1000_set_mac_type(struct e1000_hw *hw);
 void e1000_set_media_type(struct e1000_hw *hw);
 
@@ -292,10 +291,8 @@
 int32_t e1000_setup_link(struct e1000_hw *hw);
 int32_t e1000_phy_setup_autoneg(struct e1000_hw *hw);
 void e1000_config_collision_dist(struct e1000_hw *hw);
-int32_t e1000_config_fc_after_link_up(struct e1000_hw *hw);
 int32_t e1000_check_for_link(struct e1000_hw *hw);
 int32_t e1000_get_speed_and_duplex(struct e1000_hw *hw, uint16_t * speed, uint16_t * duplex);
-int32_t e1000_wait_autoneg(struct e1000_hw *hw);
 int32_t e1000_force_mac_fc(struct e1000_hw *hw);
 
 /* PHY */
@@ -303,21 +300,11 @@
 int32_t e1000_write_phy_reg(struct e1000_hw *hw, uint32_t reg_addr, uint16_t data);
 int32_t e1000_phy_hw_reset(struct e1000_hw *hw);
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
 int32_t e1000_init_eeprom_params(struct e1000_hw *hw);
-boolean_t e1000_is_onboard_nvm_eeprom(struct e1000_hw *hw);
-int32_t e1000_read_eeprom_eerd(struct e1000_hw *hw, uint16_t offset, uint16_t words, uint16_t *data);
-int32_t e1000_write_eeprom_eewr(struct e1000_hw *hw, uint16_t offset, uint16_t words, uint16_t *data);
-int32_t e1000_poll_eerd_eewr_done(struct e1000_hw *hw, int eerd);
 
 /* MNG HOST IF functions */
 uint32_t e1000_enable_mng_pass_thru(struct e1000_hw *hw);
@@ -377,13 +364,6 @@
 							uint16_t length);
 boolean_t e1000_check_mng_mode(struct e1000_hw *hw);
 boolean_t e1000_enable_tx_pkt_filtering(struct e1000_hw *hw);
-int32_t e1000_mng_enable_host_if(struct e1000_hw *hw);
-int32_t e1000_mng_host_if_write(struct e1000_hw *hw, uint8_t *buffer,
-                            uint16_t length, uint16_t offset, uint8_t *sum);
-int32_t e1000_mng_write_cmd_header(struct e1000_hw* hw, 
-                                   struct e1000_host_mng_command_header* hdr);
-
-int32_t e1000_mng_write_commit(struct e1000_hw *hw);
 
 int32_t e1000_read_eeprom(struct e1000_hw *hw, uint16_t reg, uint16_t words, uint16_t *data);
 int32_t e1000_validate_eeprom_checksum(struct e1000_hw *hw);
@@ -395,13 +375,10 @@
 void e1000_swfw_sync_release(struct e1000_hw *hw, uint16_t mask);
 
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
@@ -412,7 +389,6 @@
 /* Adaptive IFS Functions */
 
 /* Everything else */
-void e1000_clear_hw_cntrs(struct e1000_hw *hw);
 void e1000_reset_adaptive(struct e1000_hw *hw);
 void e1000_update_adaptive(struct e1000_hw *hw);
 void e1000_tbi_adjust_stats(struct e1000_hw *hw, struct e1000_hw_stats *stats, uint32_t frame_len, uint8_t * mac_addr);
@@ -423,29 +399,11 @@
 void e1000_write_pci_cfg(struct e1000_hw *hw, uint32_t reg, uint16_t * value);
 /* Port I/O is only supported on 82544 and newer */
 uint32_t e1000_io_read(struct e1000_hw *hw, unsigned long port);
-uint32_t e1000_read_reg_io(struct e1000_hw *hw, uint32_t offset);
 void e1000_io_write(struct e1000_hw *hw, unsigned long port, uint32_t value);
-void e1000_write_reg_io(struct e1000_hw *hw, uint32_t offset, uint32_t value);
-int32_t e1000_config_dsp_after_link_change(struct e1000_hw *hw, boolean_t link_up);
-int32_t e1000_set_d3_lplu_state(struct e1000_hw *hw, boolean_t active);
-int32_t e1000_set_d0_lplu_state(struct e1000_hw *hw, boolean_t active);
-void e1000_set_pci_express_master_disable(struct e1000_hw *hw);
-void e1000_enable_pciex_master(struct e1000_hw *hw);
 int32_t e1000_disable_pciex_master(struct e1000_hw *hw);
-int32_t e1000_get_auto_rd_done(struct e1000_hw *hw);
-int32_t e1000_get_phy_cfg_done(struct e1000_hw *hw);
 int32_t e1000_get_software_semaphore(struct e1000_hw *hw);
 void e1000_release_software_semaphore(struct e1000_hw *hw);
 int32_t e1000_check_phy_reset_block(struct e1000_hw *hw);
-int32_t e1000_get_hw_eeprom_semaphore(struct e1000_hw *hw);
-void e1000_put_hw_eeprom_semaphore(struct e1000_hw *hw);
-int32_t e1000_commit_shadow_ram(struct e1000_hw *hw);
-uint8_t e1000_arc_subsystem_valid(struct e1000_hw *hw);
-
-#define E1000_READ_REG_IO(a, reg) \
-    e1000_read_reg_io((a), E1000_##reg)
-#define E1000_WRITE_REG_IO(a, reg, val) \
-    e1000_write_reg_io((a), E1000_##reg, val)
 
 /* PCI Device IDs */
 #define E1000_DEV_ID_82542               0x1000
--- linux-2.6.14-rc5-mm1-full/drivers/net/e1000/e1000_hw.c.old	2005-10-30 15:49:27.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/net/e1000/e1000_hw.c	2005-10-30 16:05:02.000000000 +0100
@@ -68,6 +68,38 @@
 static int32_t e1000_set_phy_mode(struct e1000_hw *hw);
 static int32_t e1000_host_if_read_cookie(struct e1000_hw *hw, uint8_t *buffer);
 static uint8_t e1000_calculate_mng_checksum(char *buffer, uint32_t length);
+static uint8_t e1000_arc_subsystem_valid(struct e1000_hw *hw);
+static int32_t e1000_check_downshift(struct e1000_hw *hw);
+static int32_t e1000_check_polarity(struct e1000_hw *hw, uint16_t *polarity);
+static void e1000_clear_hw_cntrs(struct e1000_hw *hw);
+static void e1000_clear_vfta(struct e1000_hw *hw);
+static int32_t e1000_commit_shadow_ram(struct e1000_hw *hw);
+static int32_t e1000_config_dsp_after_link_change(struct e1000_hw *hw,
+						  boolean_t link_up);
+static int32_t e1000_config_fc_after_link_up(struct e1000_hw *hw);
+static int32_t e1000_detect_gig_phy(struct e1000_hw *hw);
+static int32_t e1000_get_auto_rd_done(struct e1000_hw *hw);
+static int32_t e1000_get_cable_length(struct e1000_hw *hw,
+				      uint16_t *min_length,
+				      uint16_t *max_length);
+static int32_t e1000_get_hw_eeprom_semaphore(struct e1000_hw *hw);
+static int32_t e1000_get_phy_cfg_done(struct e1000_hw *hw);
+static int32_t e1000_id_led_init(struct e1000_hw * hw);
+static void e1000_init_rx_addrs(struct e1000_hw *hw);
+static boolean_t e1000_is_onboard_nvm_eeprom(struct e1000_hw *hw);
+static int32_t e1000_poll_eerd_eewr_done(struct e1000_hw *hw, int eerd);
+static void e1000_put_hw_eeprom_semaphore(struct e1000_hw *hw);
+static int32_t e1000_read_eeprom_eerd(struct e1000_hw *hw, uint16_t offset,
+				      uint16_t words, uint16_t *data);
+static int32_t e1000_set_d0_lplu_state(struct e1000_hw *hw, boolean_t active);
+static int32_t e1000_set_d3_lplu_state(struct e1000_hw *hw, boolean_t active);
+static int32_t e1000_wait_autoneg(struct e1000_hw *hw);
+
+static void e1000_write_reg_io(struct e1000_hw *hw, uint32_t offset,
+			       uint32_t value);
+
+#define E1000_WRITE_REG_IO(a, reg, val) \
+	    e1000_write_reg_io((a), E1000_##reg, val)
 
 /* IGP cable length table */
 static const
@@ -2035,7 +2067,7 @@
  * based on the flow control negotiated by the PHY. In TBI mode, the TFCE
  * and RFCE bits will be automaticaly set to the negotiated flow control mode.
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_config_fc_after_link_up(struct e1000_hw *hw)
 {
     int32_t ret_val;
@@ -2537,7 +2569,7 @@
 *
 * hw - Struct containing variables accessed by shared code
 ******************************************************************************/
-int32_t
+static int32_t
 e1000_wait_autoneg(struct e1000_hw *hw)
 {
     int32_t ret_val;
@@ -3021,7 +3053,7 @@
 *
 * hw - Struct containing variables accessed by shared code
 ******************************************************************************/
-int32_t
+static int32_t
 e1000_detect_gig_phy(struct e1000_hw *hw)
 {
     int32_t phy_init_status, ret_val;
@@ -3121,7 +3153,7 @@
 * hw - Struct containing variables accessed by shared code
 * phy_info - PHY information structure
 ******************************************************************************/
-int32_t
+static int32_t
 e1000_phy_igp_get_info(struct e1000_hw *hw,
                        struct e1000_phy_info *phy_info)
 {
@@ -3195,7 +3227,7 @@
 * hw - Struct containing variables accessed by shared code
 * phy_info - PHY information structure
 ******************************************************************************/
-int32_t
+static int32_t
 e1000_phy_m88_get_info(struct e1000_hw *hw,
                        struct e1000_phy_info *phy_info)
 {
@@ -3905,7 +3937,7 @@
  * data - word read from the EEPROM
  * words - number of words to read
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_read_eeprom_eerd(struct e1000_hw *hw,
                   uint16_t offset,
                   uint16_t words,
@@ -3939,7 +3971,7 @@
  * data - word read from the EEPROM
  * words - number of words to read
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_write_eeprom_eewr(struct e1000_hw *hw,
                    uint16_t offset,
                    uint16_t words,
@@ -3976,7 +4008,7 @@
  *
  * hw - Struct containing variables accessed by shared code
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_poll_eerd_eewr_done(struct e1000_hw *hw, int eerd)
 {
     uint32_t attempts = 100000;
@@ -4004,7 +4036,7 @@
 *
 * hw - Struct containing variables accessed by shared code
 ****************************************************************************/
-boolean_t
+static boolean_t
 e1000_is_onboard_nvm_eeprom(struct e1000_hw *hw)
 {
     uint32_t eecd = 0;
@@ -4322,7 +4354,7 @@
  * data - word read from the EEPROM
  * words - number of words to read
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_commit_shadow_ram(struct e1000_hw *hw)
 {
     uint32_t attempts = 100000;
@@ -4453,7 +4485,7 @@
  * of the receive addresss registers. Clears the multicast table. Assumes
  * the receiver is in reset when the routine is called.
  *****************************************************************************/
-void
+static void
 e1000_init_rx_addrs(struct e1000_hw *hw)
 {
     uint32_t i;
@@ -4481,6 +4513,7 @@
     }
 }
 
+#if 0
 /******************************************************************************
  * Updates the MAC's list of multicast addresses.
  *
@@ -4564,6 +4597,7 @@
     }
     DEBUGOUT("MC Update Complete\n");
 }
+#endif  /*  0  */
 
 /******************************************************************************
  * Hashes an address to determine its location in the multicast table
@@ -4705,7 +4739,7 @@
  *
  * hw - Struct containing variables accessed by shared code
  *****************************************************************************/
-void
+static void
 e1000_clear_vfta(struct e1000_hw *hw)
 {
     uint32_t offset;
@@ -4735,7 +4769,7 @@
     }
 }
 
-int32_t
+static int32_t
 e1000_id_led_init(struct e1000_hw * hw)
 {
     uint32_t ledctl;
@@ -4997,7 +5031,7 @@
  *
  * hw - Struct containing variables accessed by shared code
  *****************************************************************************/
-void
+static void
 e1000_clear_hw_cntrs(struct e1000_hw *hw)
 {
     volatile uint32_t temp;
@@ -5283,6 +5317,8 @@
         break;
     }
 }
+
+#if 0
 /******************************************************************************
  * Reads a value from one of the devices registers using port I/O (as opposed
  * memory mapped I/O). Only 82544 and newer devices support port I/O.
@@ -5300,6 +5336,7 @@
     e1000_io_write(hw, io_addr, offset);
     return e1000_io_read(hw, io_data);
 }
+#endif  /*  0  */
 
 /******************************************************************************
  * Writes a value to one of the devices registers using port I/O (as opposed to
@@ -5309,7 +5346,7 @@
  * offset - offset to write to
  * value - value to write
  *****************************************************************************/
-void
+static void
 e1000_write_reg_io(struct e1000_hw *hw,
                    uint32_t offset,
                    uint32_t value)
@@ -5337,7 +5374,7 @@
  * register to the minimum and maximum range.
  * For IGP phy's, the function calculates the range by the AGC registers.
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_get_cable_length(struct e1000_hw *hw,
                        uint16_t *min_length,
                        uint16_t *max_length)
@@ -5489,7 +5526,7 @@
  * return 0.  If the link speed is 1000 Mbps the polarity status is in the
  * IGP01E1000_PHY_PCS_INIT_REG.
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_check_polarity(struct e1000_hw *hw,
                      uint16_t *polarity)
 {
@@ -5551,7 +5588,7 @@
  * Link Health register.  In IGP this bit is latched high, so the driver must
  * read it immediately after link is established.
  *****************************************************************************/
-int32_t
+static int32_t
 e1000_check_downshift(struct e1000_hw *hw)
 {
     int32_t ret_val;
@@ -5592,7 +5629,7 @@
  *
  ****************************************************************************/
 
-int32_t
+static int32_t
 e1000_config_dsp_after_link_change(struct e1000_hw *hw,
                                    boolean_t link_up)
 {
@@ -5823,7 +5860,7 @@
  *
  ****************************************************************************/
 
-int32_t
+static int32_t
 e1000_set_d3_lplu_state(struct e1000_hw *hw,
                         boolean_t active)
 {
@@ -5936,7 +5973,7 @@
  *
  ****************************************************************************/
 
-int32_t
+static int32_t
 e1000_set_d0_lplu_state(struct e1000_hw *hw,
                         boolean_t active)
 {
@@ -6103,7 +6140,7 @@
  *            timeout
  *          - E1000_SUCCESS for success.
  ****************************************************************************/
-int32_t
+static int32_t
 e1000_mng_enable_host_if(struct e1000_hw * hw)
 {
     uint32_t hicr;
@@ -6137,7 +6174,7 @@
  *
  * returns  - E1000_SUCCESS for success.
  ****************************************************************************/
-int32_t
+static int32_t
 e1000_mng_host_if_write(struct e1000_hw * hw, uint8_t *buffer,
                         uint16_t length, uint16_t offset, uint8_t *sum)
 {
@@ -6205,7 +6242,7 @@
  *
  * returns  - E1000_SUCCESS for success.
  ****************************************************************************/
-int32_t
+static int32_t
 e1000_mng_write_cmd_header(struct e1000_hw * hw,
                            struct e1000_host_mng_command_header * hdr)
 {
@@ -6243,7 +6280,7 @@
  *
  * returns  - E1000_SUCCESS for success.
  ****************************************************************************/
-int32_t
+static int32_t
 e1000_mng_write_commit(
     struct e1000_hw * hw)
 {
@@ -6496,7 +6533,7 @@
  * returns: - none.
  *
  ***************************************************************************/
-void
+static void
 e1000_set_pci_express_master_disable(struct e1000_hw *hw)
 {
     uint32_t ctrl;
@@ -6511,6 +6548,7 @@
     E1000_WRITE_REG(hw, CTRL, ctrl);
 }
 
+#if 0
 /***************************************************************************
  *
  * Enables PCI-Express master access.
@@ -6534,6 +6572,7 @@
     ctrl &= ~E1000_CTRL_GIO_MASTER_DISABLE;
     E1000_WRITE_REG(hw, CTRL, ctrl);
 }
+#endif  /*  0  */
 
 /*******************************************************************************
  *
@@ -6584,7 +6623,7 @@
  *            E1000_SUCCESS at any other case.
  *
  ******************************************************************************/
-int32_t
+static int32_t
 e1000_get_auto_rd_done(struct e1000_hw *hw)
 {
     int32_t timeout = AUTO_READ_DONE_TIMEOUT;
@@ -6623,7 +6662,7 @@
  *            E1000_SUCCESS at any other case.
  *
  ***************************************************************************/
-int32_t
+static int32_t
 e1000_get_phy_cfg_done(struct e1000_hw *hw)
 {
     int32_t timeout = PHY_CFG_TIMEOUT;
@@ -6666,7 +6705,7 @@
  *            E1000_SUCCESS at any other case.
  *
  ***************************************************************************/
-int32_t
+static int32_t
 e1000_get_hw_eeprom_semaphore(struct e1000_hw *hw)
 {
     int32_t timeout;
@@ -6711,7 +6750,7 @@
  * returns: - None.
  *
  ***************************************************************************/
-void
+static void
 e1000_put_hw_eeprom_semaphore(struct e1000_hw *hw)
 {
     uint32_t swsm;
@@ -6747,7 +6786,7 @@
 	    E1000_BLK_PHY_RESET : E1000_SUCCESS;
 }
 
-uint8_t
+static uint8_t
 e1000_arc_subsystem_valid(struct e1000_hw *hw)
 {
     uint32_t fwsm;
--- linux-2.6.14-rc5-mm1-full/drivers/net/e1000/e1000_main.c.old	2005-10-30 16:05:15.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/net/e1000/e1000_main.c	2005-10-30 16:07:44.000000000 +0100
@@ -37,7 +37,7 @@
  */
 
 char e1000_driver_name[] = "e1000";
-char e1000_driver_string[] = "Intel(R) PRO/1000 Network Driver";
+static char e1000_driver_string[] = "Intel(R) PRO/1000 Network Driver";
 #ifndef CONFIG_E1000_NAPI
 #define DRIVERNAPI
 #else
@@ -45,7 +45,7 @@
 #endif
 #define DRV_VERSION "6.1.16-k2"DRIVERNAPI
 char e1000_driver_version[] = DRV_VERSION;
-char e1000_copyright[] = "Copyright (c) 1999-2005 Intel Corporation.";
+static char e1000_copyright[] = "Copyright (c) 1999-2005 Intel Corporation.";
 
 /* e1000_pci_tbl - PCI Device ID Table
  *
@@ -112,14 +112,14 @@
 int e1000_setup_all_rx_resources(struct e1000_adapter *adapter);
 void e1000_free_all_tx_resources(struct e1000_adapter *adapter);
 void e1000_free_all_rx_resources(struct e1000_adapter *adapter);
-int e1000_setup_tx_resources(struct e1000_adapter *adapter,
-                             struct e1000_tx_ring *txdr);
-int e1000_setup_rx_resources(struct e1000_adapter *adapter,
-                             struct e1000_rx_ring *rxdr);
-void e1000_free_tx_resources(struct e1000_adapter *adapter,
-                             struct e1000_tx_ring *tx_ring);
-void e1000_free_rx_resources(struct e1000_adapter *adapter,
-                             struct e1000_rx_ring *rx_ring);
+static int e1000_setup_tx_resources(struct e1000_adapter *adapter,
+				    struct e1000_tx_ring *txdr);
+static int e1000_setup_rx_resources(struct e1000_adapter *adapter,
+				    struct e1000_rx_ring *rxdr);
+static void e1000_free_tx_resources(struct e1000_adapter *adapter,
+				    struct e1000_tx_ring *tx_ring);
+static void e1000_free_rx_resources(struct e1000_adapter *adapter,
+				    struct e1000_rx_ring *rx_ring);
 void e1000_update_stats(struct e1000_adapter *adapter);
 
 /* Local Function Prototypes */
@@ -296,7 +296,8 @@
 		E1000_WRITE_FLUSH(&adapter->hw);
 	}
 }
-void
+
+static void
 e1000_update_mng_vlan(struct e1000_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
@@ -1141,7 +1142,7 @@
  * Return 0 on success, negative on failure
  **/
 
-int
+static int
 e1000_setup_tx_resources(struct e1000_adapter *adapter,
                          struct e1000_tx_ring *txdr)
 {
@@ -1359,7 +1360,7 @@
  * Returns 0 on success, negative on failure
  **/
 
-int
+static int
 e1000_setup_rx_resources(struct e1000_adapter *adapter,
                          struct e1000_rx_ring *rxdr)
 {
@@ -1747,7 +1748,7 @@
  * Free all transmit software resources
  **/
 
-void
+static void
 e1000_free_tx_resources(struct e1000_adapter *adapter,
                         struct e1000_tx_ring *tx_ring)
 {
@@ -1858,7 +1859,7 @@
  * Free all receive software resources
  **/
 
-void
+static void
 e1000_free_rx_resources(struct e1000_adapter *adapter,
                         struct e1000_rx_ring *rx_ring)
 {

