Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWGJLNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWGJLNr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 07:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWGJLNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 07:13:47 -0400
Received: from mxl145v66.mxlogic.net ([208.65.145.66]:5025 "EHLO
	p02c11o143.mxlogic.net") by vger.kernel.org with ESMTP
	id S1751341AbWGJLNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 07:13:46 -0400
Date: Mon, 10 Jul 2006 14:14:12 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andrew Morton <akpm@osdl.org>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Ingo Molnar <mingo@elte.hu>,
       Zach Brown <zach.brown@oracle.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] IB/mthca: comment fix
Message-ID: <20060710111412.GD24705@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 10 Jul 2006 11:18:49.0906 (UTC) FILETIME=[9E503120:01C6A412]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
Here's a cosmetic patch for IB/mthca. Pls drop it into -mm and on.

---

comment in mthca_qp.c makes it seem lockdep is the only reason WQ locks should
be initialized separately, but as Zach Brown and Roland pointed out, there are
other reasons, e.g. that mthca_wq_init is called from modify qp as well.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 490fc78..2f3917e 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -1114,7 +1114,7 @@ static int mthca_alloc_qp_common(struct 
 	qp->sq_policy    = send_policy;
 	mthca_wq_init(&qp->sq);
 	mthca_wq_init(&qp->rq);
-	/* these are initialized separately so lockdep can tell them apart */
+
 	spin_lock_init(&qp->sq.lock);
 	spin_lock_init(&qp->rq.lock);
 

-- 
MST
