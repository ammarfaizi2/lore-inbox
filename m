Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965212AbWADEPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965212AbWADEPP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 23:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965211AbWADEPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 23:15:15 -0500
Received: from fmr17.intel.com ([134.134.136.16]:49366 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S965212AbWADEPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 23:15:13 -0500
Date: Wed, 4 Jan 2006 12:09:54 +0800
From: Zhu Yi <yi.zhu@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jketreno@linux.intel.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ipw2200: Fix NETDEV_TX_BUSY erroneous returned
Message-ID: <20060104040954.GA19618@mail.intel.com>
Reply-To: yi.zhu@intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes the warning below warning for the ipw2200 driver.

  NETDEV_TX_BUSY returned; driver should report queue full via
  ieee_device->is_queue_full.

Signed-off-by: Hong Liu <hong.liu@intel.com>
Signed-off-by: Zhu Yi <yi.zhu@intel.com>
--

diff -urp linux.orig/drivers/net/wireless/ipw2200.c linux/drivers/net/wireless/ipw2200.c
--- linux.orig/drivers/net/wireless/ipw2200.c	2005-10-21 05:35:24.000000000 +0800
+++ linux/drivers/net/wireless/ipw2200.c	2005-10-25 13:22:38.000000000
+0800
@@ -9649,11 +9649,6 @@ static inline int ipw_tx_skb(struct ipw_
 	u16 remaining_bytes;
 	int fc;
 
-	/* If there isn't room in the queue, we return busy and let the
-	 * network stack requeue the packet for us */
-	if (ipw_queue_space(q) < q->high_mark)
-		return NETDEV_TX_BUSY;
-
 	switch (priv->ieee->iw_mode) {
 	case IW_MODE_ADHOC:
 		hdr_len = IEEE80211_3ADDR_LEN;
@@ -9871,7 +9866,7 @@ static int ipw_net_hard_start_xmit(struc
 
       fail_unlock:
 	spin_unlock_irqrestore(&priv->lock, flags);
-	return 1;
+	return -1;
 }
 
 static struct net_device_stats *ipw_net_get_stats(struct net_device *dev)
