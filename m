Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWAUAjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWAUAjo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 19:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWAUAjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 19:39:44 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19475 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932322AbWAUAjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 19:39:43 -0500
Date: Sat, 21 Jan 2006 01:39:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: yi.zhu@intel.com, jketreno@linux.intel.com
Cc: linville@tuxdriver.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/wireless/ipw2200: possible cleanups
Message-ID: <20060121003942.GL31803@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global functions static
- "extern inline" -> "static inline"
- #if 0 the unused global function ipw_led_activity_on()


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/wireless/ipw2200.c |   33 ++++++++++++++++++---------------
 drivers/net/wireless/ipw2200.h |    4 ++--
 2 files changed, 20 insertions(+), 17 deletions(-)

--- linux-2.6.16-rc1-mm2-full/drivers/net/wireless/ipw2200.h.old	2006-01-21 01:15:58.000000000 +0100
+++ linux-2.6.16-rc1-mm2-full/drivers/net/wireless/ipw2200.h	2006-01-21 01:16:30.000000000 +0100
@@ -853,7 +853,7 @@
 	u16 dwell_time[IPW_SCAN_TYPES];
 } __attribute__ ((packed));
 
-extern inline u8 ipw_get_scan_type(struct ipw_scan_request_ext *scan, u8 index)
+static inline u8 ipw_get_scan_type(struct ipw_scan_request_ext *scan, u8 index)
 {
 	if (index % 2)
 		return scan->scan_type[index / 2] & 0x0F;
@@ -861,7 +861,7 @@
 		return (scan->scan_type[index / 2] & 0xF0) >> 4;
 }
 
-extern inline void ipw_set_scan_type(struct ipw_scan_request_ext *scan,
+static inline void ipw_set_scan_type(struct ipw_scan_request_ext *scan,
 				     u8 index, u8 scan_type)
 {
 	if (index % 2)
--- linux-2.6.16-rc1-mm2-full/drivers/net/wireless/ipw2200.c.old	2006-01-21 00:54:24.000000000 +0100
+++ linux-2.6.16-rc1-mm2-full/drivers/net/wireless/ipw2200.c	2006-01-21 01:17:04.000000000 +0100
@@ -701,7 +701,7 @@
 
 }
 
-u32 ipw_register_toggle(u32 reg)
+static u32 ipw_register_toggle(u32 reg)
 {
 	reg &= ~IPW_START_STANDBY;
 	if (reg & IPW_GATE_ODMA)
@@ -726,7 +726,7 @@
 #define LD_TIME_LINK_OFF 2700
 #define LD_TIME_ACT_ON 250
 
-void ipw_led_link_on(struct ipw_priv *priv)
+static void ipw_led_link_on(struct ipw_priv *priv)
 {
 	unsigned long flags;
 	u32 led;
@@ -769,7 +769,7 @@
 	mutex_unlock(&priv->mutex);
 }
 
-void ipw_led_link_off(struct ipw_priv *priv)
+static void ipw_led_link_off(struct ipw_priv *priv)
 {
 	unsigned long flags;
 	u32 led;
@@ -847,6 +847,7 @@
 	}
 }
 
+#if 0
 void ipw_led_activity_on(struct ipw_priv *priv)
 {
 	unsigned long flags;
@@ -854,8 +855,9 @@
 	__ipw_led_activity_on(priv);
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
+#endif  /*  0  */
 
-void ipw_led_activity_off(struct ipw_priv *priv)
+static void ipw_led_activity_off(struct ipw_priv *priv)
 {
 	unsigned long flags;
 	u32 led;
@@ -890,7 +892,7 @@
 	mutex_unlock(&priv->mutex);
 }
 
-void ipw_led_band_on(struct ipw_priv *priv)
+static void ipw_led_band_on(struct ipw_priv *priv)
 {
 	unsigned long flags;
 	u32 led;
@@ -925,7 +927,7 @@
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
-void ipw_led_band_off(struct ipw_priv *priv)
+static void ipw_led_band_off(struct ipw_priv *priv)
 {
 	unsigned long flags;
 	u32 led;
@@ -948,24 +950,24 @@
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
-void ipw_led_radio_on(struct ipw_priv *priv)
+static void ipw_led_radio_on(struct ipw_priv *priv)
 {
 	ipw_led_link_on(priv);
 }
 
-void ipw_led_radio_off(struct ipw_priv *priv)
+static void ipw_led_radio_off(struct ipw_priv *priv)
 {
 	ipw_led_activity_off(priv);
 	ipw_led_link_off(priv);
 }
 
-void ipw_led_link_up(struct ipw_priv *priv)
+static void ipw_led_link_up(struct ipw_priv *priv)
 {
 	/* Set the Link Led on for all nic types */
 	ipw_led_link_on(priv);
 }
 
-void ipw_led_link_down(struct ipw_priv *priv)
+static void ipw_led_link_down(struct ipw_priv *priv)
 {
 	ipw_led_activity_off(priv);
 	ipw_led_link_off(priv);
@@ -974,7 +976,7 @@
 		ipw_led_radio_off(priv);
 }
 
-void ipw_led_init(struct ipw_priv *priv)
+static void ipw_led_init(struct ipw_priv *priv)
 {
 	priv->nic_type = priv->eeprom[EEPROM_NIC_TYPE];
 
@@ -1025,7 +1027,7 @@
 	}
 }
 
-void ipw_led_shutdown(struct ipw_priv *priv)
+static void ipw_led_shutdown(struct ipw_priv *priv)
 {
 	ipw_led_activity_off(priv);
 	ipw_led_link_off(priv);
@@ -6146,7 +6148,8 @@
 	return ret;
 }
 
-void ipw_wpa_assoc_frame(struct ipw_priv *priv, char *wpa_ie, int wpa_ie_len)
+static void ipw_wpa_assoc_frame(struct ipw_priv *priv, char *wpa_ie,
+				int wpa_ie_len)
 {
 	/* make sure WPA is enabled */
 	ipw_wpa_enable(priv, 1);
@@ -9977,7 +9980,7 @@
 	mutex_unlock(&priv->mutex);
 }
 
-void ipw_link_up(struct ipw_priv *priv)
+static void ipw_link_up(struct ipw_priv *priv)
 {
 	priv->last_seq_num = -1;
 	priv->last_frag_num = -1;
@@ -10012,7 +10015,7 @@
 	mutex_unlock(&priv->mutex);
 }
 
-void ipw_link_down(struct ipw_priv *priv)
+static void ipw_link_down(struct ipw_priv *priv)
 {
 	ipw_led_link_down(priv);
 	netif_carrier_off(priv->net_dev);

