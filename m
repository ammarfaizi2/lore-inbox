Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVCCGI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVCCGI2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 01:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVCCFeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 00:34:13 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:54897 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261485AbVCCFbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 00:31:48 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][9/11] IB/ipoib: small fixes
In-Reply-To: <2005322131.OKEJHXn13XfMX2Aa@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 2 Mar 2005 21:31:22 -0800
Message-Id: <2005322131.kDy0lnKe0rjDV0tv@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 05:31:22.0960 (UTC) FILETIME=[3C802D00:01C51FB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shirley Ma <xma@us.ibm.com>

IPoIB small fixes: Initialize path->ah to NULL, and fix dereference
after free of neigh in error path of neigh_add_path().

Signed-off-by: Shirley Ma <xma@us.ibm.com>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/ulp/ipoib/ipoib_main.c	2005-03-02 20:26:13.207621227 -0800
+++ linux-export/drivers/infiniband/ulp/ipoib/ipoib_main.c	2005-03-02 20:26:13.653524436 -0800
@@ -346,8 +346,9 @@
 	if (!path)
 		return NULL;
 
-	path->dev = dev;
+	path->dev          = dev;
 	path->pathrec.dlid = 0;
+	path->ah           = NULL;
 
 	skb_queue_head_init(&path->queue);
 
@@ -450,8 +451,8 @@
 err:
 	*to_ipoib_neigh(skb->dst->neighbour) = NULL;
 	list_del(&neigh->list);
-	kfree(neigh);
 	neigh->neighbour->ops->destructor = NULL;
+	kfree(neigh);
 
 	++priv->stats.tx_dropped;
 	dev_kfree_skb_any(skb);

