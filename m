Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270559AbTGNMKm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270567AbTGNMIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:08:39 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:38276
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270559AbTGNMGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:06:02 -0400
Date: Mon, 14 Jul 2003 13:20:00 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141220.h6ECK0RM030860@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: PATCH: warning fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/isdn/isdn_ppp.c linux.22-pre5-ac1/drivers/isdn/isdn_ppp.c
--- linux.22-pre5/drivers/isdn/isdn_ppp.c	2003-07-14 12:27:37.000000000 +0100
+++ linux.22-pre5-ac1/drivers/isdn/isdn_ppp.c	2003-07-07 15:55:23.000000000 +0100
@@ -111,8 +111,8 @@
 	struct ippp_struct *is;
 
 	if (lp->ppp_slot < 0 || lp->ppp_slot > ISDN_MAX_CHANNELS) {
-		printk(KERN_ERR __FUNCTION__": ppp_slot(%d) out of range\n",
-			lp->ppp_slot);
+		printk(KERN_ERR "%s: ppp_slot(%d) out of range\n",
+			__FUNCTION__, lp->ppp_slot);
 		return 0;
 	}
 
@@ -131,8 +131,8 @@
 	spin_unlock(&lp->netdev->pb->lock);
 #endif /* CONFIG_ISDN_MPP */
 	if (lp->ppp_slot < 0 || lp->ppp_slot > ISDN_MAX_CHANNELS) {
-		printk(KERN_ERR __FUNCTION__": ppp_slot(%d) now invalid\n",
-			lp->ppp_slot);
+		printk(KERN_ERR "%s: ppp_slot(%d) now invalid\n",
+			__FUNCTION__, lp->ppp_slot);
 		restore_flags(flags);
 		return 0;
 	}
@@ -232,8 +232,8 @@
 isdn_ppp_wakeup_daemon(isdn_net_local * lp)
 {
 	if (lp->ppp_slot < 0 || lp->ppp_slot >= ISDN_MAX_CHANNELS) {
-		printk(KERN_ERR __FUNCTION__": ppp_slot(%d) out of range\n",
-			lp->ppp_slot);
+		printk(KERN_ERR "%s: ppp_slot(%d) out of range\n",
+			__FUNCTION__, lp->ppp_slot);
 		return;
 	}
 	ippp_table[lp->ppp_slot]->state = IPPP_OPEN | IPPP_CONNECT | IPPP_NOBLOCK;
@@ -251,8 +251,8 @@
 	struct ippp_struct *is;
 
 	if (slot < 0 || slot >= ISDN_MAX_CHANNELS) {
-		printk(KERN_ERR __FUNCTION__": slot(%d) out of range\n",
-			slot);
+		printk(KERN_ERR "%s: slot(%d) out of range\n",
+			__FUNCTION__, slot);
 		return 0;
 	}
 	is = ippp_table[slot];
@@ -350,7 +350,7 @@
 	is = file->private_data;
 
 	if (!is) {
-		printk(KERN_ERR __FUNCTION__": no file->private_data\n");
+		printk(KERN_ERR "%s: no file->private_data\n", __FUNCTION__);
 		return;
 	}
 	if (is->debug & 0x1)
@@ -360,7 +360,7 @@
 		isdn_net_dev *p = is->lp->netdev;
 
 		if (!p) {
-			printk(KERN_ERR __FUNCTION__": no lp->netdev\n");
+			printk(KERN_ERR "%s: no lp->netdev\n", __FUNCTION__);
 			return;
 		}
 		is->state &= ~IPPP_CONNECT;	/* -> effect: no call of wakeup */
@@ -1077,8 +1077,8 @@
 			if (is->debug & 0x20)
 				printk(KERN_DEBUG "isdn_ppp: VJC_UNCOMP\n");
 			if (net_dev->local->ppp_slot < 0) {
-				printk(KERN_ERR __FUNCTION__": net_dev->local->ppp_slot(%d) out of range\n",
-					net_dev->local->ppp_slot);
+				printk(KERN_ERR "%s: net_dev->local->ppp_slot(%d) out of range\n",
+					__FUNCTION__, net_dev->local->ppp_slot);
 				goto drop_packet;
 			}
 			if (slhc_remember(ippp_table[net_dev->local->ppp_slot]->slcomp, skb->data, skb->len) <= 0) {
@@ -1103,8 +1103,8 @@
 				skb_put(skb, skb_old->len + 128);
 				memcpy(skb->data, skb_old->data, skb_old->len);
 				if (net_dev->local->ppp_slot < 0) {
-					printk(KERN_ERR __FUNCTION__": net_dev->local->ppp_slot(%d) out of range\n",
-						net_dev->local->ppp_slot);
+					printk(KERN_ERR "%s: net_dev->local->ppp_slot(%d) out of range\n",
+						__FUNCTION__, net_dev->local->ppp_slot);
 					goto drop_packet;
 				}
 				pkt_len = slhc_uncompress(ippp_table[net_dev->local->ppp_slot]->slcomp,
@@ -1540,8 +1540,8 @@
 	struct ippp_struct * is;
 
 	if (lp->ppp_slot < 0) {
-		printk(KERN_ERR __FUNCTION__": lp->ppp_slot(%d) out of range\n",
-			lp->ppp_slot);
+		printk(KERN_ERR "%s: lp->ppp_slot(%d) out of range\n",
+			__FUNCTION__, lp->ppp_slot);
 		return(-EINVAL);
 	}
 
@@ -1591,8 +1591,8 @@
         stats = &mp->stats;
 	slot = lp->ppp_slot;
 	if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
-		printk(KERN_ERR __FUNCTION__": lp->ppp_slot(%d)\n",
-			lp->ppp_slot);
+		printk(KERN_ERR "%s: lp->ppp_slot(%d)\n",
+			__FUNCTION__, lp->ppp_slot);
 		stats->frame_drops++;
 		dev_kfree_skb(skb);
 		spin_unlock_irqrestore(&mp->lock, flags);
@@ -1628,8 +1628,8 @@
 	for (lpq = net_dev->queue;;) {
 		slot = lpq->ppp_slot;
 		if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
-			printk(KERN_ERR __FUNCTION__": lpq->ppp_slot(%d)\n",
-				lpq->ppp_slot);
+			printk(KERN_ERR "%s: lpq->ppp_slot(%d)\n",
+				__FUNCTION__, lpq->ppp_slot);
 		} else {
 			u32 lls = ippp_table[slot]->last_link_seqno;
 			if (MP_LT(lls, minseq))
@@ -1862,8 +1862,8 @@
 	unsigned int tot_len;
 
 	if (lp->ppp_slot < 0 || lp->ppp_slot > ISDN_MAX_CHANNELS) {
-		printk(KERN_ERR __FUNCTION__": lp->ppp_slot(%d) out of range\n",
-			lp->ppp_slot);
+		printk(KERN_ERR "%s: lp->ppp_slot(%d) out of range\n",
+			__FUNCTION__, lp->ppp_slot);
 		return;
 	}
 	if( MP_FLAGS(from) == (MP_BEGIN_FRAG | MP_END_FRAG) ) {
@@ -2639,8 +2639,8 @@
 	printk(KERN_DEBUG "Received CCP frame from peer slot(%d)\n",
 		lp->ppp_slot);
 	if (lp->ppp_slot < 0 || lp->ppp_slot > ISDN_MAX_CHANNELS) {
-		printk(KERN_ERR __FUNCTION__": lp->ppp_slot(%d) out of range\n",
-			lp->ppp_slot);
+		printk(KERN_ERR "%s: lp->ppp_slot(%d) out of range\n",
+			__FUNCTION__, lp->ppp_slot);
 		return;
 	}
 	is = ippp_table[lp->ppp_slot];
@@ -2649,8 +2649,8 @@
 	if(lp->master) {
 		int slot = ((isdn_net_local *) (lp->master->priv))->ppp_slot;
 		if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
-			printk(KERN_ERR __FUNCTION__": slot(%d) out of range\n",
-				slot);
+			printk(KERN_ERR "%s: slot(%d) out of range\n",
+				__FUNCTION__, slot);
 			return;
 		}	
 		mis = ippp_table[slot];
@@ -2813,8 +2813,8 @@
 	if(!skb || skb->len < 3)
 		return;
 	if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
-		printk(KERN_ERR __FUNCTION__": lp->ppp_slot(%d) out of range\n",
-			slot);
+		printk(KERN_ERR "%s: lp->ppp_slot(%d) out of range\n",
+			__FUNCTION__, slot);
 		return;
 	}	
 	is = ippp_table[slot];
@@ -2836,8 +2836,8 @@
 	if (lp->master) {
 		slot = ((isdn_net_local *) (lp->master->priv))->ppp_slot;
 		if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
-			printk(KERN_ERR __FUNCTION__": slot(%d) out of range\n",
-				slot);
+			printk(KERN_ERR "%s: slot(%d) out of range\n",
+				__FUNCTION__, slot);
 			return;
 		}	
 		mis = ippp_table[slot];
