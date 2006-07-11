Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWGKVpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWGKVpo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 17:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWGKVpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 17:45:24 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22476 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751332AbWGKVpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 17:45:22 -0400
Date: Tue, 11 Jul 2006 15:34:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: pavel@ucw.cz
Cc: yi.zhu@intel.com, jketreno@linux.intel.com,
       Netdev list <netdev@vger.kernel.org>, linville@tuxdriver.com,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [patch] cleanup // comments from ipw2200
Message-ID: <20060711133405.GB1650@elf.ucw.cz>
References: <20060710152032.GA8540@elf.ucw.cz> <44B2940A.2080102@pobox.com> <200607102305.06572.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607102305.06572.mb@bu3sch.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ipw2200 uses // comments, and uses them for removing unneeded
code. Clean it up a bit.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/net/wireless/ipw2200.c b/drivers/net/wireless/ipw2200.c
index b3300ff..758459e 100644
--- a/drivers/net/wireless/ipw2200.c
+++ b/drivers/net/wireless/ipw2200.c
@@ -2667,7 +2667,7 @@ static void ipw_fw_dma_abort(struct ipw_
 
 	IPW_DEBUG_FW(">> :\n");
 
-	//set the Stop and Abort bit
+	/* set the Stop and Abort bit */
 	control = DMA_CONTROL_SMALL_CB_CONST_VALUE | DMA_CB_STOP_AND_ABORT;
 	ipw_write_reg32(priv, IPW_DMA_I_DMA_CONTROL, control);
 	priv->sram_desc.last_cb_index = 0;
@@ -3002,8 +3002,6 @@ static int ipw_load_ucode(struct ipw_pri
 	if (rc < 0)
 		return rc;
 
-//      spin_lock_irqsave(&priv->lock, flags);
-
 	for (addr = IPW_SHARED_LOWER_BOUND;
 	     addr < IPW_REGISTER_DOMAIN1_END; addr += 4) {
 		ipw_write32(priv, addr, 0);
@@ -3097,8 +3095,6 @@ static int ipw_load_ucode(struct ipw_pri
 	   firmware have problem getting alive resp. */
 	ipw_write_reg8(priv, IPW_BASEBAND_CONTROL_STATUS, 0);
 
-//      spin_unlock_irqrestore(&priv->lock, flags);
-
 	return rc;
 }
 
@@ -6387,13 +6383,6 @@ static int ipw_wx_set_genie(struct net_d
 	    (wrqu->data.length && extra == NULL))
 		return -EINVAL;
 
-	//mutex_lock(&priv->mutex);
-
-	//if (!ieee->wpa_enabled) {
-	//      err = -EOPNOTSUPP;
-	//      goto out;
-	//}
-
 	if (wrqu->data.length) {
 		buf = kmalloc(wrqu->data.length, GFP_KERNEL);
 		if (buf == NULL) {
@@ -6413,7 +6402,6 @@ static int ipw_wx_set_genie(struct net_d
 
 	ipw_wpa_assoc_frame(priv, ieee->wpa_ie, ieee->wpa_ie_len);
       out:
-	//mutex_unlock(&priv->mutex);
 	return err;
 }
 
@@ -6426,13 +6414,6 @@ static int ipw_wx_get_genie(struct net_d
 	struct ieee80211_device *ieee = priv->ieee;
 	int err = 0;
 
-	//mutex_lock(&priv->mutex);
-
-	//if (!ieee->wpa_enabled) {
-	//      err = -EOPNOTSUPP;
-	//      goto out;
-	//}
-
 	if (ieee->wpa_ie_len == 0 || ieee->wpa_ie == NULL) {
 		wrqu->data.length = 0;
 		goto out;
@@ -6447,7 +6428,6 @@ static int ipw_wx_get_genie(struct net_d
 	memcpy(extra, ieee->wpa_ie, ieee->wpa_ie_len);
 
       out:
-	//mutex_unlock(&priv->mutex);
 	return err;
 }
 
@@ -6558,7 +6538,6 @@ static int ipw_wx_set_auth(struct net_de
 		ieee->ieee802_1x = param->value;
 		break;
 
-		//case IW_AUTH_ROAMING_CONTROL:
 	case IW_AUTH_PRIVACY_INVOKED:
 		ieee->privacy_invoked = param->value;
 		break;
@@ -6680,7 +6659,7 @@ static int ipw_wx_set_mlme(struct net_de
 
 	switch (mlme->cmd) {
 	case IW_MLME_DEAUTH:
-		// silently ignore
+		/* silently ignore */
 		break;
 
 	case IW_MLME_DISASSOC:
@@ -9766,7 +9745,7 @@ static int ipw_wx_set_monitor(struct net
 	return 0;
 }
 
-#endif				// CONFIG_IPW2200_MONITOR
+#endif				/* CONFIG_IPW2200_MONITOR */
 
 static int ipw_wx_reset(struct net_device *dev,
 			struct iw_request_info *info,
@@ -10009,7 +9988,7 @@ static  void init_sys_config(struct ipw_
 	sys_config->dot11g_auto_detection = 0;
 	sys_config->enable_cts_to_self = 0;
 	sys_config->bt_coexist_collision_thr = 0;
-	sys_config->pass_noise_stats_to_host = 1;	//1 -- fix for 256
+	sys_config->pass_noise_stats_to_host = 1;	/* 1 -- fix for 256 */
 	sys_config->silence_threshold = 0x1e;
 }
 



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
