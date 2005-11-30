Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbVK3A6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVK3A6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 19:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVK3A6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 19:58:10 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:37405 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750747AbVK3A5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 19:57:33 -0500
Subject: [git patch review 4/8] IPoIB: don't zero members after we allocate
	with kzalloc
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 30 Nov 2005 00:57:25 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1133312245797-2006ed5b68ef5482@cisco.com>
In-Reply-To: <1133312245796-cb4f80534d10c1b9@cisco.com>
X-OriginalArrivalTime: 30 Nov 2005 00:57:27.0081 (UTC) FILETIME=[08501190:01C5F549]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ipoib_mcast_alloc() uses kzalloc(), so there's no need to zero out
members of the mcast struct after it's allocated.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

applies-to: bbb88a18ee78fa43c0f887c138011a055a9c8045
2e86541ec878de9ec5771600a77f451a80bebfc4
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 10404e0..ef3ee03 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -138,15 +138,11 @@ static struct ipoib_mcast *ipoib_mcast_a
 	mcast->dev = dev;
 	mcast->created = jiffies;
 	mcast->backoff = 1;
-	mcast->logcount = 0;
 
 	INIT_LIST_HEAD(&mcast->list);
 	INIT_LIST_HEAD(&mcast->neigh_list);
 	skb_queue_head_init(&mcast->pkt_queue);
 
-	mcast->ah    = NULL;
-	mcast->query = NULL;
-
 	return mcast;
 }
 
---
0.99.9k
