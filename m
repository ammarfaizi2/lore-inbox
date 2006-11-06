Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753103AbWKFOWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103AbWKFOWN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 09:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbWKFOWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 09:22:11 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:19728 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1753210AbWKFOVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 09:21:47 -0500
Date: Mon, 6 Nov 2006 15:21:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linville@tuxdriver.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] hostap_80211_rx(): fix a use-after-free
Message-ID: <20061106142148.GO5778@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a use-after-free for "skb" spotted by the Coverity 
checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/drivers/net/wireless/hostap/hostap_80211_rx.c.old	2006-11-06 14:51:36.000000000 +0100
+++ linux-2.6/drivers/net/wireless/hostap/hostap_80211_rx.c	2006-11-06 14:52:16.000000000 +0100
@@ -1004,10 +1004,10 @@ void hostap_80211_rx(struct net_device *
 			if (local->hostapd && local->apdev) {
 				/* Send IEEE 802.1X frames to the user
 				 * space daemon for processing */
-				prism2_rx_80211(local->apdev, skb, rx_stats,
-						PRISM2_RX_MGMT);
 				local->apdevstats.rx_packets++;
 				local->apdevstats.rx_bytes += skb->len;
+				prism2_rx_80211(local->apdev, skb, rx_stats,
+						PRISM2_RX_MGMT);
 				goto rx_exit;
 			}
 		} else if (!frame_authorized) {

