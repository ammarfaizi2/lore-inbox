Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422803AbWGJThs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422803AbWGJThs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 15:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422802AbWGJThr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 15:37:47 -0400
Received: from mxl145v65.mxlogic.net ([208.65.145.65]:58752 "EHLO
	p02c11o142.mxlogic.net") by vger.kernel.org with ESMTP
	id S1422799AbWGJThq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 15:37:46 -0400
Date: Mon, 10 Jul 2006 22:38:14 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Sean Hefty <sean.hefty@intel.com>, Roland Dreier <rolandd@cisco.com>,
       openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: [PATCH] srp: fix fmr error handling
Message-ID: <20060710193814.GA30521@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 10 Jul 2006 19:42:51.0406 (UTC) FILETIME=[07A6E2E0:01C6A459]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, could you pls drop the following in -mm and on to Linus?

---

 From: Vu Pham <vu@mellanox.com>

srp_unmap_data assumes req->fmr is NULL if the request is not mapped,
so we must clean it out in case of an error.

Signed-off-by: Vu Pham <vu@mellanox.com>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Acked-by: Roland Dreier <rolandd@cisco.com>

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 4e22afe..8f472e7 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -615,9 +615,10 @@ static int srp_map_fmr(struct srp_device
 				(sg_dma_address(&scat[i]) & dev->fmr_page_mask) + j;
 
 	req->fmr = ib_fmr_pool_map_phys(dev->fmr_pool,
					dma_pages, page_cnt, &io_addr);
 	if (IS_ERR(req->fmr)) {
 		ret = PTR_ERR(req->fmr);
+		req->fmr = NULL;
 		goto out;
 	}
 

-- 
MST

----- End forwarded message -----

-- 
MST
