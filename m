Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbVBQUzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbVBQUzG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 15:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVBQUzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 15:55:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9485 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262326AbVBQUwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:52:41 -0500
Date: Thu, 17 Feb 2005 21:52:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ayyappan.veeraiyan@intel.com, ganesh.venkatesan@intel.com,
       john.ronciak@intel.com
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/ixgb/: possible cleanups
Message-ID: <20050217205236.GG6194@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- remove the following unused global functions:
  - ixgb_ee.c: ixgb_get_ee_compatibility
  - ixgb_ee.c: ixgb_get_ee_init_ctrl_reg_1
  - ixgb_ee.c: ixgb_get_ee_init_ctrl_reg_2
  - ixgb_ee.c: ixgb_get_ee_subsystem_id
  - ixgb_ee.c: ixgb_get_ee_subvendor_id
  - ixgb_ee.c: ixgb_get_ee_vendor_id
  - ixgb_ee.c: ixgb_get_ee_swdpins_reg
  - ixgb_ee.c: ixgb_get_ee_d3_power
  - ixgb_ee.c: ixgb_get_ee_d0_power

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/ixgb/ixgb_ee.c      |  170 --------------------------------
 drivers/net/ixgb/ixgb_ethtool.c |    2 
 drivers/net/ixgb/ixgb_hw.c      |   26 +++-
 drivers/net/ixgb/ixgb_hw.h      |   26 ----
 drivers/net/ixgb/ixgb_main.c    |    6 -
 5 files changed, 21 insertions(+), 209 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/net/ixgb/ixgb_hw.h.old	2005-02-16 15:55:21.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/ixgb/ixgb_hw.h	2005-02-16 16:06:28.000000000 +0100
@@ -784,23 +784,8 @@
 extern boolean_t ixgb_adapter_stop(struct ixgb_hw *hw);
 extern boolean_t ixgb_init_hw(struct ixgb_hw *hw);
 extern boolean_t ixgb_adapter_start(struct ixgb_hw *hw);
-extern void ixgb_init_rx_addrs(struct ixgb_hw *hw);
 extern void ixgb_check_for_link(struct ixgb_hw *hw);
 extern boolean_t ixgb_check_for_bad_link(struct ixgb_hw *hw);
-extern boolean_t ixgb_setup_fc(struct ixgb_hw *hw);
-extern void ixgb_clear_hw_cntrs(struct ixgb_hw *hw);
-extern boolean_t mac_addr_valid(uint8_t *mac_addr);
-
-extern uint16_t ixgb_read_phy_reg(struct ixgb_hw *hw,
-				uint32_t reg_addr,
-				uint32_t phy_addr,
-				uint32_t device_type);
-
-extern void ixgb_write_phy_reg(struct ixgb_hw *hw,
-				uint32_t reg_addr,
-				uint32_t phy_addr,
-				uint32_t device_type,
-				uint16_t data);
 
 extern void ixgb_rar_set(struct ixgb_hw *hw,
 				uint8_t *addr,
@@ -818,21 +803,10 @@
 				 uint32_t offset,
 				 uint32_t value);
 
-extern void ixgb_clear_vfta(struct ixgb_hw *hw);
-
 /* Access functions to eeprom data */
 void ixgb_get_ee_mac_addr(struct ixgb_hw *hw, uint8_t *mac_addr);
-uint16_t ixgb_get_ee_compatibility(struct ixgb_hw *hw);
 uint32_t ixgb_get_ee_pba_number(struct ixgb_hw *hw);
-uint16_t ixgb_get_ee_init_ctrl_reg_1(struct ixgb_hw *hw);
-uint16_t ixgb_get_ee_init_ctrl_reg_2(struct ixgb_hw *hw);
-uint16_t ixgb_get_ee_subsystem_id(struct ixgb_hw *hw);
-uint16_t ixgb_get_ee_subvendor_id(struct ixgb_hw *hw);
 uint16_t ixgb_get_ee_device_id(struct ixgb_hw *hw);
-uint16_t ixgb_get_ee_vendor_id(struct ixgb_hw *hw);
-uint16_t ixgb_get_ee_swdpins_reg(struct ixgb_hw *hw);
-uint8_t ixgb_get_ee_d3_power(struct ixgb_hw *hw);
-uint8_t ixgb_get_ee_d0_power(struct ixgb_hw *hw);
 boolean_t ixgb_get_eeprom_data(struct ixgb_hw *hw);
 uint16_t ixgb_get_eeprom_word(struct ixgb_hw *hw, uint16_t index);
 
--- linux-2.6.11-rc3-mm2-full/drivers/net/ixgb/ixgb_ee.c.old	2005-02-16 15:55:34.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/ixgb/ixgb_ee.c	2005-02-16 15:58:37.000000000 +0100
@@ -560,25 +560,6 @@
 }
 
 /******************************************************************************
- * return the compatibility flags from EEPROM
- *
- * hw - Struct containing variables accessed by shared code
- *
- * Returns:
- *          compatibility flags if EEPROM contents are valid, 0 otherwise
- ******************************************************************************/
-uint16_t
-ixgb_get_ee_compatibility(struct ixgb_hw *hw)
-{
-	struct ixgb_ee_map_type *ee_map = (struct ixgb_ee_map_type *)hw->eeprom;
-
-	if(ixgb_check_and_get_eeprom_data(hw) == TRUE)
-		return(ee_map->compatibility);
-
-	return(0);
-}
-
-/******************************************************************************
  * return the Printed Board Assembly number from EEPROM
  *
  * hw - Struct containing variables accessed by shared code
@@ -597,82 +578,6 @@
 }
 
 /******************************************************************************
- * return the Initialization Control Word 1 from EEPROM
- *
- * hw - Struct containing variables accessed by shared code
- *
- * Returns:
- *          Initialization Control Word 1 if EEPROM contents are valid, 0 otherwise
- ******************************************************************************/
-uint16_t
-ixgb_get_ee_init_ctrl_reg_1(struct ixgb_hw *hw)
-{
-	struct ixgb_ee_map_type *ee_map = (struct ixgb_ee_map_type *)hw->eeprom;
-
-	if(ixgb_check_and_get_eeprom_data(hw) == TRUE)
-		return(ee_map->init_ctrl_reg_1);
-
-	return(0);
-}
-
-/******************************************************************************
- * return the Initialization Control Word 2 from EEPROM
- *
- * hw - Struct containing variables accessed by shared code
- *
- * Returns:
- *          Initialization Control Word 2 if EEPROM contents are valid, 0 otherwise
- ******************************************************************************/
-uint16_t
-ixgb_get_ee_init_ctrl_reg_2(struct ixgb_hw *hw)
-{
-	struct ixgb_ee_map_type *ee_map = (struct ixgb_ee_map_type *)hw->eeprom;
-
-	if(ixgb_check_and_get_eeprom_data(hw) == TRUE)
-		return(ee_map->init_ctrl_reg_2);
-
-	return(0);
-}
-
-/******************************************************************************
- * return the Subsystem Id from EEPROM
- *
- * hw - Struct containing variables accessed by shared code
- *
- * Returns:
- *          Subsystem Id if EEPROM contents are valid, 0 otherwise
- ******************************************************************************/
-uint16_t
-ixgb_get_ee_subsystem_id(struct ixgb_hw *hw)
-{
-	struct ixgb_ee_map_type *ee_map = (struct ixgb_ee_map_type *)hw->eeprom;
-
-	if(ixgb_check_and_get_eeprom_data(hw) == TRUE)
-	   return(ee_map->subsystem_id);
-
-	return(0);
-}
-
-/******************************************************************************
- * return the Sub Vendor Id from EEPROM
- *
- * hw - Struct containing variables accessed by shared code
- *
- * Returns:
- *          Sub Vendor Id if EEPROM contents are valid, 0 otherwise
- ******************************************************************************/
-uint16_t
-ixgb_get_ee_subvendor_id(struct ixgb_hw *hw)
-{
-	struct ixgb_ee_map_type *ee_map = (struct ixgb_ee_map_type *)hw->eeprom;
-
-	if(ixgb_check_and_get_eeprom_data(hw) == TRUE)
-		return(ee_map->subvendor_id);
-
-	return(0);
-}
-
-/******************************************************************************
  * return the Device Id from EEPROM
  *
  * hw - Struct containing variables accessed by shared code
@@ -691,78 +596,3 @@
 	return(0);
 }
 
-/******************************************************************************
- * return the Vendor Id from EEPROM
- *
- * hw - Struct containing variables accessed by shared code
- *
- * Returns:
- *          Device Id if EEPROM contents are valid, 0 otherwise
- ******************************************************************************/
-uint16_t
-ixgb_get_ee_vendor_id(struct ixgb_hw *hw)
-{
-	struct ixgb_ee_map_type *ee_map = (struct ixgb_ee_map_type *)hw->eeprom;
-
-	if(ixgb_check_and_get_eeprom_data(hw) == TRUE)
-		return(ee_map->vendor_id);
-
-	return(0);
-}
-
-/******************************************************************************
- * return the Software Defined Pins Register from EEPROM
- *
- * hw - Struct containing variables accessed by shared code
- *
- * Returns:
- *          SDP Register if EEPROM contents are valid, 0 otherwise
- ******************************************************************************/
-uint16_t
-ixgb_get_ee_swdpins_reg(struct ixgb_hw *hw)
-{
-	struct ixgb_ee_map_type *ee_map = (struct ixgb_ee_map_type *)hw->eeprom;
-
-	if(ixgb_check_and_get_eeprom_data(hw) == TRUE)
-		return(ee_map->swdpins_reg);
-
-	return(0);
-}
-
-/******************************************************************************
- * return the D3 Power Management Bits from EEPROM
- *
- * hw - Struct containing variables accessed by shared code
- *
- * Returns:
- *          D3 Power Management Bits if EEPROM contents are valid, 0 otherwise
- ******************************************************************************/
-uint8_t
-ixgb_get_ee_d3_power(struct ixgb_hw *hw)
-{
-	struct ixgb_ee_map_type *ee_map = (struct ixgb_ee_map_type *)hw->eeprom;
-
-	if(ixgb_check_and_get_eeprom_data(hw) == TRUE)
-		return(ee_map->d3_power);
-
-	return(0);
-}
-
-/******************************************************************************
- * return the D0 Power Management Bits from EEPROM
- *
- * hw - Struct containing variables accessed by shared code
- *
- * Returns:
- *          D0 Power Management Bits if EEPROM contents are valid, 0 otherwise
- ******************************************************************************/
-uint8_t
-ixgb_get_ee_d0_power(struct ixgb_hw *hw)
-{
-	struct ixgb_ee_map_type *ee_map = (struct ixgb_ee_map_type *)hw->eeprom;
-
-	if(ixgb_check_and_get_eeprom_data(hw) == TRUE)
-		return(ee_map->d0_power);
-
-	return(0);
-}
--- linux-2.6.11-rc3-mm2-full/drivers/net/ixgb/ixgb_ethtool.c.old	2005-02-16 15:58:51.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/ixgb/ixgb_ethtool.c	2005-02-16 15:59:00.000000000 +0100
@@ -665,7 +665,7 @@
 	}
 }
 
-struct ethtool_ops ixgb_ethtool_ops = {
+static struct ethtool_ops ixgb_ethtool_ops = {
 	.get_settings = ixgb_get_settings,
 	.set_settings = ixgb_set_settings,
 	.get_drvinfo = ixgb_get_drvinfo,
--- linux-2.6.11-rc3-mm2-full/drivers/net/ixgb/ixgb_hw.c.old	2005-02-16 16:03:16.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/ixgb/ixgb_hw.c	2005-02-16 16:06:42.000000000 +0100
@@ -47,9 +47,17 @@
 
 static ixgb_phy_type ixgb_identify_phy(struct ixgb_hw *hw);
 
-uint32_t ixgb_mac_reset(struct ixgb_hw *hw);
+static void ixgb_clear_hw_cntrs(struct ixgb_hw *hw);
+static void ixgb_clear_vfta(struct ixgb_hw *hw);
+static void ixgb_init_rx_addrs(struct ixgb_hw *hw);
+static uint16_t ixgb_read_phy_reg(struct ixgb_hw *hw,
+				  uint32_t reg_address,
+				  uint32_t phy_address,
+				  uint32_t device_type);
+static boolean_t ixgb_setup_fc(struct ixgb_hw *hw);
+static boolean_t mac_addr_valid(uint8_t *mac_addr);
 
-uint32_t ixgb_mac_reset(struct ixgb_hw *hw)
+static uint32_t ixgb_mac_reset(struct ixgb_hw *hw)
 {
 	uint32_t ctrl_reg;
 
@@ -335,7 +343,7 @@
  * of the receive addresss registers. Clears the multicast table. Assumes
  * the receiver is in reset when the routine is called.
  *****************************************************************************/
-void
+static void
 ixgb_init_rx_addrs(struct ixgb_hw *hw)
 {
 	uint32_t i;
@@ -604,7 +612,7 @@
  *
  * hw - Struct containing variables accessed by shared code
  *****************************************************************************/
-void
+static void
 ixgb_clear_vfta(struct ixgb_hw *hw)
 {
 	uint32_t offset;
@@ -620,7 +628,7 @@
  * hw - Struct containing variables accessed by shared code
  *****************************************************************************/
 
-boolean_t
+static boolean_t
 ixgb_setup_fc(struct ixgb_hw *hw)
 {
 	uint32_t ctrl_reg;
@@ -722,7 +730,7 @@
  * This requires that first an address cycle command is sent, followed by a
  * read command.
  *****************************************************************************/
-uint16_t
+static uint16_t
 ixgb_read_phy_reg(struct ixgb_hw *hw,
 		uint32_t reg_address,
 		uint32_t phy_address,
@@ -815,7 +823,7 @@
  * This requires that first an address cycle command is sent, followed by a
  * write command.
  *****************************************************************************/
-void
+static void
 ixgb_write_phy_reg(struct ixgb_hw *hw,
 			uint32_t reg_address,
 			uint32_t phy_address,
@@ -959,7 +967,7 @@
  *
  * hw - Struct containing variables accessed by shared code
  *****************************************************************************/
-void
+static void
 ixgb_clear_hw_cntrs(struct ixgb_hw *hw)
 {
 	volatile uint32_t temp_reg;
@@ -1114,7 +1122,7 @@
  * mac_addr - pointer to MAC address.
  *
  *****************************************************************************/
-boolean_t
+static boolean_t
 mac_addr_valid(uint8_t *mac_addr)
 {
 	boolean_t is_valid = TRUE;
--- linux-2.6.11-rc3-mm2-full/drivers/net/ixgb/ixgb_main.c.old	2005-02-16 16:06:54.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/ixgb/ixgb_main.c	2005-02-16 16:07:31.000000000 +0100
@@ -37,14 +37,14 @@
  */
 
 char ixgb_driver_name[] = "ixgb";
-char ixgb_driver_string[] = "Intel(R) PRO/10GbE Network Driver";
+static char ixgb_driver_string[] = "Intel(R) PRO/10GbE Network Driver";
 #ifndef CONFIG_IXGB_NAPI
 #define DRIVERNAPI
 #else
 #define DRIVERNAPI "-NAPI"
 #endif
 char ixgb_driver_version[] = "1.0.87-k2"DRIVERNAPI;
-char ixgb_copyright[] = "Copyright (c) 1999-2004 Intel Corporation.";
+static char ixgb_copyright[] = "Copyright (c) 1999-2004 Intel Corporation.";
 
 /* ixgb_pci_tbl - PCI Device ID Table
  *
@@ -125,7 +125,7 @@
 static void ixgb_netpoll(struct net_device *dev);
 #endif
 
-struct notifier_block ixgb_notifier_reboot = {
+static struct notifier_block ixgb_notifier_reboot = {
 	.notifier_call = ixgb_notify_reboot,
 	.next = NULL,
 	.priority = 0

