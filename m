Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965298AbWGJWnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965298AbWGJWnz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965301AbWGJWny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:43:54 -0400
Received: from mxl145v67.mxlogic.net ([208.65.145.67]:45277 "EHLO
	p02c11o144.mxlogic.net") by vger.kernel.org with ESMTP
	id S965298AbWGJWnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:43:53 -0400
Date: Tue, 11 Jul 2006 01:10:11 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Sean Hefty <sean.hefty@intel.com>, Roland Dreier <rolandd@cisco.com>,
       openib-general@openib.org, netdev@vger.kernel.org
Subject: [PATCH fixed] srp: fix fmr error handling
Message-ID: <20060710221011.GA32328@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060710193814.GA30521@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060710193814.GA30521@mellanox.co.il>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 10 Jul 2006 22:14:48.0359 (UTC) FILETIME=[41C78370:01C6A46E]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, the last patch I sent was corrupted, here's an updated version:

---

commit 7289361d5f81463e4abb27334773750279547e8a
Author: Vu Pham <vu@mellanox.com>
Date:   Mon Jul 10 22:38:14 2006 +0300

    [PATCH] srp: fix fmr error handling
    
    srp_unmap_data assumes req->fmr is NULL if the request is not mapped,
    so we must clean it out in case of an error.
    
    Signed-off-by: Vu Pham <vu@mellanox.com>
    Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
    Acked-by: Roland Dreier <rolandd@cisco.com>

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 4e22afe..6191180 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -618,6 +618,7 @@ static int srp_map_fmr(struct srp_device
 					dma_pages, page_cnt, &io_addr);
 	if (IS_ERR(req->fmr)) {
 		ret = PTR_ERR(req->fmr);
+		req->fmr = NULL;
 		goto out;
 	}

-- 
MST
