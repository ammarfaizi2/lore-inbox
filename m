Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262590AbVDAD6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbVDAD6z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 22:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVDAD6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 22:58:55 -0500
Received: from webmail.topspin.com ([12.162.17.3]:202 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262590AbVDAD6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 22:58:53 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][1/3] IPoIB: set skb->mac.raw on receive
In-Reply-To: 
X-Mailer: Roland's Patchbomber
Date: Thu, 31 Mar 2005 19:36:11 -0800
Message-Id: <20053311936.983q6QLaPvAkIcQj@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 03:36:12.0233 (UTC) FILETIME=[F35DAB90:01C5366B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hal Rosenstock <halr@voltaire.com>

Set skb->mac.raw on receive.  This fixes crashes when this is
dereferenced, for example by netfilter or when PF_PACKET is used.

Signed-off-by: Hal Rosenstock <halr@voltaire.com>
Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-export.orig/drivers/infiniband/ulp/ipoib/ipoib_ib.c	2005-03-31 19:07:06.912605203 -0800
+++ linux-export/drivers/infiniband/ulp/ipoib/ipoib_ib.c	2005-03-31 19:23:30.599053347 -0800
@@ -201,7 +201,7 @@
 			if (wc->slid != priv->local_lid ||
 			    wc->src_qp != priv->qp->qp_num) {
 				skb->protocol = ((struct ipoib_header *) skb->data)->proto;
-
+				skb->mac.raw = skb->data;
 				skb_pull(skb, IPOIB_ENCAP_LEN);
 
 				dev->last_rx = jiffies;

