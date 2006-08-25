Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422745AbWHYSZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422745AbWHYSZz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422711AbWHYSZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:25:54 -0400
Received: from mx.pathscale.com ([64.160.42.68]:42882 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422754AbWHYSZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:25:19 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 12 of 23] IB/ipath - do not allow use of CQ entries with
	invalid counts
X-Mercurial-Node: 94b773e8d36a655ea5405abfb9cc95ab5fc2a8e0
Message-Id: <94b773e8d36a655ea540.1156530277@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1156530265@eng-12.pathscale.com>
Date: Fri, 25 Aug 2006 11:24:37 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff --git a/drivers/infiniband/hw/ipath/ipath_cq.c b/drivers/infiniband/hw/ipath/ipath_cq.c
--- a/drivers/infiniband/hw/ipath/ipath_cq.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_cq.c	Fri Aug 25 11:19:45 2006 -0700
@@ -172,7 +172,7 @@ struct ib_cq *ipath_create_cq(struct ib_
 	struct ipath_cq_wc *wc;
 	struct ib_cq *ret;
 
-	if (entries > ib_ipath_max_cqes) {
+	if (entries < 1 || entries > ib_ipath_max_cqes) {
 		ret = ERR_PTR(-EINVAL);
 		goto done;
 	}
@@ -324,6 +324,11 @@ int ipath_resize_cq(struct ib_cq *ibcq, 
 	u32 head, tail, n;
 	int ret;
 
+	if (cqe < 1 || cqe > ib_ipath_max_cqes) {
+		ret = -EINVAL;
+		goto bail;
+	}
+
 	/*
 	 * Need to use vmalloc() if we want to support large #s of entries.
 	 */
