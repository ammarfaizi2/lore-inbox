Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030524AbVKCXLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030524AbVKCXLe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030520AbVKCXLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:11:12 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:22347 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1030519AbVKCXLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:11:11 -0500
Subject: [git patch review 3/7] [IPoIB] remove unneeded initializations to 0
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 03 Nov 2005 23:10:59 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1131059459423-3dc7f03665037bf0@cisco.com>
In-Reply-To: <1131059459423-f6e7ac335ed94eef@cisco.com>
X-OriginalArrivalTime: 03 Nov 2005 23:11:00.0574 (UTC) FILETIME=[DAEAEFE0:01C5E0CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shrink our source and .text a little by removing a few assignments of
NULL and 0 to memory that is already cleared as part of the allocation.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/ipoib/ipoib_main.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

applies-to: 7463446a05b5e9a5d2fc400da0be8d4a6c2ff6f1
21a384897d48c116b879924c3dd9e96f6f1e764b
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 8b67db8..ce02962 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -356,18 +356,15 @@ static struct ipoib_path *path_rec_creat
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 	struct ipoib_path *path;
 
-	path = kmalloc(sizeof *path, GFP_ATOMIC);
+	path = kzalloc(sizeof *path, GFP_ATOMIC);
 	if (!path)
 		return NULL;
 
-	path->dev          = dev;
-	path->pathrec.dlid = 0;
-	path->ah           = NULL;
+	path->dev = dev;
 
 	skb_queue_head_init(&path->queue);
 
 	INIT_LIST_HEAD(&path->neigh_list);
-	path->query = NULL;
 	init_completion(&path->done);
 
 	memcpy(path->pathrec.dgid.raw, gid->raw, sizeof (union ib_gid));
@@ -800,10 +797,6 @@ static void ipoib_setup(struct net_devic
 
 	dev->watchdog_timeo 	 = HZ;
 
-	dev->rebuild_header 	 = NULL;
-	dev->set_mac_address 	 = NULL;
-	dev->header_cache_update = NULL;
-
 	dev->flags              |= IFF_BROADCAST | IFF_MULTICAST;
 
 	/*
---
0.99.9
