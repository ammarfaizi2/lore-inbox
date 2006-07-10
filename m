Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965297AbWGJWn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965297AbWGJWn3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965298AbWGJWn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:43:28 -0400
Received: from mxl145v69.mxlogic.net ([208.65.145.69]:52356 "EHLO
	p02c11o146.mxlogic.net") by vger.kernel.org with ESMTP
	id S965296AbWGJWn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:43:27 -0400
Date: Tue, 11 Jul 2006 01:43:42 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andrew Morton <akpm@osdl.org>
Cc: Sean Hefty <sean.hefty@intel.com>, Roland Dreier <rolandd@cisco.com>,
       openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: [PATCH] IB/cm: set private data length for reject messages
Message-ID: <20060710224342.GA496@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 10 Jul 2006 22:48:19.0812 (UTC) FILETIME=[F0B2E240:01C6A472]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
Here's another infiniband patch that needs to go upstream.

---

From: "Ira Weiny" <weiny2@llnl.gov>

Set private data length for reject messages to the correct size.
Fix from openib svn r8483.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

Index: openib/drivers/infiniband/core/cma.c
===================================================================
--- openib/drivers/infiniband/core/cma.c	(revision 8482)
+++ openib/drivers/infiniband/core/cma.c	(revision 8483)
@@ -906,6 +906,7 @@ static int cma_ib_handler(struct ib_cm_i
 		cma_modify_qp_err(&id_priv->id);
 		status = ib_event->param.rej_rcvd.reason;
 		event = RDMA_CM_EVENT_REJECTED;
+		private_data_len = IB_CM_REJ_PRIVATE_DATA_SIZE;
 		break;
 	default:
 		printk(KERN_ERR "RDMA CMA: unexpected IB CM event: %d",

-- 
MST
