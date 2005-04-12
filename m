Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbVDLOQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbVDLOQV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVDLLIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:08:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:28362 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262254AbVDLKdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:14 -0400
Message-Id: <200504121033.j3CAX4Rl005769@shell0.pdx.osdl.net>
Subject: [patch 153/198] IPoIB: set skb->mac.raw on receive
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, halr@voltaire.com,
       roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Hal Rosenstock <halr@voltaire.com>

Set skb->mac.raw on receive.  This fixes crashes when this is
dereferenced, for example by netfilter or when PF_PACKET is used.

Signed-off-by: Hal Rosenstock <halr@voltaire.com>
Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/ulp/ipoib/ipoib_ib.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/infiniband/ulp/ipoib/ipoib_ib.c~ipoib-set-skb-macraw-on-receive drivers/infiniband/ulp/ipoib/ipoib_ib.c
--- 25/drivers/infiniband/ulp/ipoib/ipoib_ib.c~ipoib-set-skb-macraw-on-receive	2005-04-12 03:21:40.242019184 -0700
+++ 25-akpm/drivers/infiniband/ulp/ipoib/ipoib_ib.c	2005-04-12 03:21:40.245018728 -0700
@@ -201,7 +201,7 @@ static void ipoib_ib_handle_wc(struct ne
 			if (wc->slid != priv->local_lid ||
 			    wc->src_qp != priv->qp->qp_num) {
 				skb->protocol = ((struct ipoib_header *) skb->data)->proto;
-
+				skb->mac.raw = skb->data;
 				skb_pull(skb, IPOIB_ENCAP_LEN);
 
 				dev->last_rx = jiffies;
_
