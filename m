Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbVK3A5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVK3A5d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 19:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVK3A5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 19:57:32 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:37405 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750747AbVK3A5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 19:57:31 -0500
Subject: [git patch review 2/8] IPoIB: always set path->query to NULL when
	query finishes
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 30 Nov 2005 00:57:25 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1133312245796-b000d53a5b61afe0@cisco.com>
In-Reply-To: <1133312245796-394e1098d722d830@cisco.com>
X-OriginalArrivalTime: 30 Nov 2005 00:57:27.0018 (UTC) FILETIME=[084674A0:01C5F549]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Always set path->query to NULL when the SA path record query
completes, rather than only when we don't have an address handle.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/ipoib/ipoib_main.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

applies-to: 5f96a0797d23e7cee4f2a6c4770bacadee31a261
5872a9fc28e6cd3a4e51479a50970d19a01573b3
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index cd58b3d..826d7a7 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -398,9 +398,9 @@ static void path_rec_completion(int stat
 			while ((skb = __skb_dequeue(&neigh->queue)))
 				__skb_queue_tail(&skqueue, skb);
 		}
-	} else
-		path->query = NULL;
+	}
 
+	path->query = NULL;
 	complete(&path->done);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
---
0.99.9k
