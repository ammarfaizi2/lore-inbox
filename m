Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266438AbTGETXB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 15:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266454AbTGETRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 15:17:19 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:12436 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266439AbTGETOn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 15:14:43 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: kai.germaschewski@gmx.de
Subject: [PATCH 2.4.21-bk1] isdn_ppp compile warning fix
Date: Sat, 5 Jul 2003 20:58:55 +0200
User-Agent: KMail/1.5.2
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307052058.55539.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

fixes these warnings:
isdn_ppp.c: In function `isdn_ppp_free':
isdn_ppp.c:114: Warnung: concatenation of string literals with __FUNCTION__ is deprecated
isdn_ppp.c:134: Warnung: concatenation of string literals with __FUNCTION__ is deprecated
isdn_ppp.c: In function `isdn_ppp_wakeup_daemon':
isdn_ppp.c:235: Warnung: concatenation of string literals with __FUNCTION__ is deprecated
isdn_ppp.c: In function `isdn_ppp_closewait':
isdn_ppp.c:254: Warnung: concatenation of string literals with __FUNCTION__ is deprecated
isdn_ppp.c: In function `isdn_ppp_release':
isdn_ppp.c:353: Warnung: concatenation of string literals with __FUNCTION__ is deprecated
isdn_ppp.c:363: Warnung: concatenation of string literals with __FUNCTION__ is deprecated
isdn_ppp.c: In function `isdn_ppp_push_higher':
isdn_ppp.c:1080: Warnung: concatenation of string literals with __FUNCTION__ is deprecated
isdn_ppp.c:1106: Warnung: concatenation of string literals with __FUNCTION__ is deprecated
isdn_ppp.c: In function `isdn_ppp_mp_init':
isdn_ppp.c:1543: Warnung: concatenation of string literals with __FUNCTION__ is deprecated
isdn_ppp.c: In function `isdn_ppp_mp_receive':
isdn_ppp.c:1594: Warnung: concatenation of string literals with __FUNCTION__ is deprecated
isdn_ppp.c:1631: Warnung: concatenation of string literals with __FUNCTION__ is deprecated
isdn_ppp.c: In function `isdn_ppp_mp_reassembly':
isdn_ppp.c:1865: Warnung: concatenation of string literals with __FUNCTION__ is deprecated
isdn_ppp.c: In function `isdn_ppp_receive_ccp':
isdn_ppp.c:2642: Warnung: concatenation of string literals with __FUNCTION__ is deprecated
isdn_ppp.c:2652: Warnung: concatenation of string literals with __FUNCTION__ is deprecated
isdn_ppp.c: In function `isdn_ppp_send_ccp':
isdn_ppp.c:2816: Warnung: concatenation of string literals with __FUNCTION__ is deprecated
isdn_ppp.c:2839: Warnung: concatenation of string literals with __FUNCTION__ is deprecated


- --- drivers/isdn/isdn_ppp.c.orig	2003-07-05 20:45:35.000000000 +0200
+++ drivers/isdn/isdn_ppp.c	2003-07-05 20:51:34.000000000 +0200
@@ -111,8 +111,8 @@
 	struct ippp_struct *is;
 
 	if (lp->ppp_slot < 0 || lp->ppp_slot > ISDN_MAX_CHANNELS) {
- -		printk(KERN_ERR __FUNCTION__": ppp_slot(%d) out of range\n",
- -			lp->ppp_slot);
+		printk(KERN_ERR "%s: ppp_slot(%d) out of range\n",
+			__FUNCTION__, lp->ppp_slot);
 		return 0;
 	}
 
@@ -131,8 +131,8 @@
 	spin_unlock(&lp->netdev->pb->lock);
 #endif /* CONFIG_ISDN_MPP */
 	if (lp->ppp_slot < 0 || lp->ppp_slot > ISDN_MAX_CHANNELS) {
- -		printk(KERN_ERR __FUNCTION__": ppp_slot(%d) now invalid\n",
- -			lp->ppp_slot);
+		printk(KERN_ERR "%s: ppp_slot(%d) now invalid\n",
+			__FUNCTION__, lp->ppp_slot);
 		restore_flags(flags);
 		return 0;
 	}
@@ -232,8 +232,8 @@
 isdn_ppp_wakeup_daemon(isdn_net_local * lp)
 {
 	if (lp->ppp_slot < 0 || lp->ppp_slot >= ISDN_MAX_CHANNELS) {
- -		printk(KERN_ERR __FUNCTION__": ppp_slot(%d) out of range\n",
- -			lp->ppp_slot);
+		printk(KERN_ERR "%s: ppp_slot(%d) out of range\n",
+			__FUNCTION__, lp->ppp_slot);
 		return;
 	}
 	ippp_table[lp->ppp_slot]->state = IPPP_OPEN | IPPP_CONNECT | IPPP_NOBLOCK;
@@ -251,8 +251,8 @@
 	struct ippp_struct *is;
 
 	if (slot < 0 || slot >= ISDN_MAX_CHANNELS) {
- -		printk(KERN_ERR __FUNCTION__": slot(%d) out of range\n",
- -			slot);
+		printk(KERN_ERR "%s: slot(%d) out of range\n",
+			__FUNCTION__, slot);
 		return 0;
 	}
 	is = ippp_table[slot];
@@ -350,7 +350,7 @@
 	is = file->private_data;
 
 	if (!is) {
- -		printk(KERN_ERR __FUNCTION__": no file->private_data\n");
+		printk(KERN_ERR "%s: no file->private_data\n", __FUNCTION__);
 		return;
 	}
 	if (is->debug & 0x1)
@@ -360,7 +360,7 @@
 		isdn_net_dev *p = is->lp->netdev;
 
 		if (!p) {
- -			printk(KERN_ERR __FUNCTION__": no lp->netdev\n");
+			printk(KERN_ERR "%s: no lp->netdev\n", __FUNCTION__);
 			return;
 		}
 		is->state &= ~IPPP_CONNECT;	/* -> effect: no call of wakeup */
@@ -1077,8 +1077,8 @@
 			if (is->debug & 0x20)
 				printk(KERN_DEBUG "isdn_ppp: VJC_UNCOMP\n");
 			if (net_dev->local->ppp_slot < 0) {
- -				printk(KERN_ERR __FUNCTION__": net_dev->local->ppp_slot(%d) out of range\n",
- -					net_dev->local->ppp_slot);
+				printk(KERN_ERR "%s: net_dev->local->ppp_slot(%d) out of range\n",
+					__FUNCTION__, net_dev->local->ppp_slot);
 				goto drop_packet;
 			}
 			if (slhc_remember(ippp_table[net_dev->local->ppp_slot]->slcomp, skb->data, skb->len) <= 0) {
@@ -1103,8 +1103,8 @@
 				skb_put(skb, skb_old->len + 128);
 				memcpy(skb->data, skb_old->data, skb_old->len);
 				if (net_dev->local->ppp_slot < 0) {
- -					printk(KERN_ERR __FUNCTION__": net_dev->local->ppp_slot(%d) out of range\n",
- -						net_dev->local->ppp_slot);
+					printk(KERN_ERR "%s: net_dev->local->ppp_slot(%d) out of range\n",
+						__FUNCTION__, net_dev->local->ppp_slot);
 					goto drop_packet;
 				}
 				pkt_len = slhc_uncompress(ippp_table[net_dev->local->ppp_slot]->slcomp,
@@ -1540,8 +1540,8 @@
 	struct ippp_struct * is;
 
 	if (lp->ppp_slot < 0) {
- -		printk(KERN_ERR __FUNCTION__": lp->ppp_slot(%d) out of range\n",
- -			lp->ppp_slot);
+		printk(KERN_ERR "%s: lp->ppp_slot(%d) out of range\n",
+			__FUNCTION__, lp->ppp_slot);
 		return(-EINVAL);
 	}
 
@@ -1591,8 +1591,8 @@
         stats = &mp->stats;
 	slot = lp->ppp_slot;
 	if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
- -		printk(KERN_ERR __FUNCTION__": lp->ppp_slot(%d)\n",
- -			lp->ppp_slot);
+		printk(KERN_ERR "%s: lp->ppp_slot(%d)\n",
+			__FUNCTION__, lp->ppp_slot);
 		stats->frame_drops++;
 		dev_kfree_skb(skb);
 		spin_unlock_irqrestore(&mp->lock, flags);
@@ -1628,8 +1628,8 @@
 	for (lpq = net_dev->queue;;) {
 		slot = lpq->ppp_slot;
 		if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
- -			printk(KERN_ERR __FUNCTION__": lpq->ppp_slot(%d)\n",
- -				lpq->ppp_slot);
+			printk(KERN_ERR "%s: lpq->ppp_slot(%d)\n",
+				__FUNCTION__, lpq->ppp_slot);
 		} else {
 			u32 lls = ippp_table[slot]->last_link_seqno;
 			if (MP_LT(lls, minseq))
@@ -1862,8 +1862,8 @@
 	unsigned int tot_len;
 
 	if (lp->ppp_slot < 0 || lp->ppp_slot > ISDN_MAX_CHANNELS) {
- -		printk(KERN_ERR __FUNCTION__": lp->ppp_slot(%d) out of range\n",
- -			lp->ppp_slot);
+		printk(KERN_ERR "%s: lp->ppp_slot(%d) out of range\n",
+			__FUNCTION__, lp->ppp_slot);
 		return;
 	}
 	if( MP_FLAGS(from) == (MP_BEGIN_FRAG | MP_END_FRAG) ) {
@@ -2639,8 +2639,8 @@
 	printk(KERN_DEBUG "Received CCP frame from peer slot(%d)\n",
 		lp->ppp_slot);
 	if (lp->ppp_slot < 0 || lp->ppp_slot > ISDN_MAX_CHANNELS) {
- -		printk(KERN_ERR __FUNCTION__": lp->ppp_slot(%d) out of range\n",
- -			lp->ppp_slot);
+		printk(KERN_ERR "%s: lp->ppp_slot(%d) out of range\n",
+			__FUNCTION__, lp->ppp_slot);
 		return;
 	}
 	is = ippp_table[lp->ppp_slot];
@@ -2649,8 +2649,8 @@
 	if(lp->master) {
 		int slot = ((isdn_net_local *) (lp->master->priv))->ppp_slot;
 		if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
- -			printk(KERN_ERR __FUNCTION__": slot(%d) out of range\n",
- -				slot);
+			printk(KERN_ERR "%s: slot(%d) out of range\n",
+				__FUNCTION__, slot);
 			return;
 		}	
 		mis = ippp_table[slot];
@@ -2813,8 +2813,8 @@
 	if(!skb || skb->len < 3)
 		return;
 	if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
- -		printk(KERN_ERR __FUNCTION__": lp->ppp_slot(%d) out of range\n",
- -			slot);
+		printk(KERN_ERR "%s: lp->ppp_slot(%d) out of range\n",
+			__FUNCTION__, slot);
 		return;
 	}	
 	is = ippp_table[slot];
@@ -2836,8 +2836,8 @@
 	if (lp->master) {
 		slot = ((isdn_net_local *) (lp->master->priv))->ppp_slot;
 		if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
- -			printk(KERN_ERR __FUNCTION__": slot(%d) out of range\n",
- -				slot);
+			printk(KERN_ERR "%s: slot(%d) out of range\n",
+				__FUNCTION__, slot);
 			return;
 		}	
 		mis = ippp_table[slot];

- -- 
Regards Michael Buesch
http://www.8ung.at/tuxsoft
 20:51:53 up  1:54,  3 users,  load average: 0.07, 0.10, 0.41

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/Bx/voxoigfggmSgRAilwAJ9UNBK7AMAqKQ+/Q8NgYuzUbx3JEwCfdpHA
GcHH2NotO9j+65pm9/m+FZ4=
=Mtn/
-----END PGP SIGNATURE-----


