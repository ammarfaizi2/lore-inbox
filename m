Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbVJ3Pxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbVJ3Pxd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 10:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbVJ3Pxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 10:53:32 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45070 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932157AbVJ3Pxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 10:53:31 -0500
Date: Sun, 30 Oct 2005 16:53:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ayyappan.veeraiyan@intel.com, ganesh.venkatesan@intel.com,
       john.ronciak@intel.com
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/ixgb/: make some code static
Message-ID: <20051030155330.GA4180@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/ixgb/ixgb_ethtool.c |    2 +-
 drivers/net/ixgb/ixgb_hw.c      |   31 ++++++++++++++++++++++---------
 drivers/net/ixgb/ixgb_hw.h      |   17 -----------------
 drivers/net/ixgb/ixgb_main.c    |    2 +-
 4 files changed, 24 insertions(+), 28 deletions(-)

--- linux-2.6.14-rc5-mm1-full/drivers/net/ixgb/ixgb_ethtool.c.old	2005-10-30 15:37:22.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/net/ixgb/ixgb_ethtool.c	2005-10-30 15:37:29.000000000 +0100
@@ -694,7 +694,7 @@
 	}
 }
 
-struct ethtool_ops ixgb_ethtool_ops = {
+static struct ethtool_ops ixgb_ethtool_ops = {
 	.get_settings = ixgb_get_settings,
 	.set_settings = ixgb_set_settings,
 	.get_drvinfo = ixgb_get_drvinfo,
--- linux-2.6.14-rc5-mm1-full/drivers/net/ixgb/ixgb_hw.h.old	2005-10-30 15:37:57.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/net/ixgb/ixgb_hw.h	2005-10-30 15:41:28.000000000 +0100
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
@@ -818,8 +803,6 @@
 				 uint32_t offset,
 				 uint32_t value);
 
-extern void ixgb_clear_vfta(struct ixgb_hw *hw);
-
 /* Access functions to eeprom data */
 void ixgb_get_ee_mac_addr(struct ixgb_hw *hw, uint8_t *mac_addr);
 uint32_t ixgb_get_ee_pba_number(struct ixgb_hw *hw);
--- linux-2.6.14-rc5-mm1-full/drivers/net/ixgb/ixgb_hw.c.old	2005-10-30 15:38:11.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/net/ixgb/ixgb_hw.c	2005-10-30 15:41:44.000000000 +0100
@@ -47,9 +47,22 @@
 
 static ixgb_phy_type ixgb_identify_phy(struct ixgb_hw *hw);
 
-uint32_t ixgb_mac_reset(struct ixgb_hw *hw);
+static void ixgb_clear_hw_cntrs(struct ixgb_hw *hw);
 
-uint32_t ixgb_mac_reset(struct ixgb_hw *hw)
+static void ixgb_clear_vfta(struct ixgb_hw *hw);
+
+static void ixgb_init_rx_addrs(struct ixgb_hw *hw);
+
+static uint16_t ixgb_read_phy_reg(struct ixgb_hw *hw,
+				  uint32_t reg_address,
+				  uint32_t phy_address,
+				  uint32_t device_type);
+
+static boolean_t ixgb_setup_fc(struct ixgb_hw *hw);
+
+static boolean_t mac_addr_valid(uint8_t *mac_addr);
+
+static uint32_t ixgb_mac_reset(struct ixgb_hw *hw)
 {
 	uint32_t ctrl_reg;
 
@@ -335,7 +348,7 @@
  * of the receive addresss registers. Clears the multicast table. Assumes
  * the receiver is in reset when the routine is called.
  *****************************************************************************/
-void
+static void
 ixgb_init_rx_addrs(struct ixgb_hw *hw)
 {
 	uint32_t i;
@@ -604,7 +617,7 @@
  *
  * hw - Struct containing variables accessed by shared code
  *****************************************************************************/
-void
+static void
 ixgb_clear_vfta(struct ixgb_hw *hw)
 {
 	uint32_t offset;
@@ -620,7 +633,7 @@
  * hw - Struct containing variables accessed by shared code
  *****************************************************************************/
 
-boolean_t
+static boolean_t
 ixgb_setup_fc(struct ixgb_hw *hw)
 {
 	uint32_t ctrl_reg;
@@ -722,7 +735,7 @@
  * This requires that first an address cycle command is sent, followed by a
  * read command.
  *****************************************************************************/
-uint16_t
+static uint16_t
 ixgb_read_phy_reg(struct ixgb_hw *hw,
 		uint32_t reg_address,
 		uint32_t phy_address,
@@ -815,7 +828,7 @@
  * This requires that first an address cycle command is sent, followed by a
  * write command.
  *****************************************************************************/
-void
+static void
 ixgb_write_phy_reg(struct ixgb_hw *hw,
 			uint32_t reg_address,
 			uint32_t phy_address,
@@ -959,7 +972,7 @@
  *
  * hw - Struct containing variables accessed by shared code
  *****************************************************************************/
-void
+static void
 ixgb_clear_hw_cntrs(struct ixgb_hw *hw)
 {
 	volatile uint32_t temp_reg;
@@ -1114,7 +1127,7 @@
  * mac_addr - pointer to MAC address.
  *
  *****************************************************************************/
-boolean_t
+static boolean_t
 mac_addr_valid(uint8_t *mac_addr)
 {
 	boolean_t is_valid = TRUE;
--- linux-2.6.14-rc5-mm1-full/drivers/net/ixgb/ixgb_main.c.old	2005-10-30 15:42:00.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/net/ixgb/ixgb_main.c	2005-10-30 15:42:10.000000000 +0100
@@ -45,7 +45,7 @@
  */
 
 char ixgb_driver_name[] = "ixgb";
-char ixgb_driver_string[] = "Intel(R) PRO/10GbE Network Driver";
+static char ixgb_driver_string[] = "Intel(R) PRO/10GbE Network Driver";
 
 #ifndef CONFIG_IXGB_NAPI
 #define DRIVERNAPI

