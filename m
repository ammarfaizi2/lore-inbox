Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWELXof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWELXof (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWELXof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:35 -0400
Received: from mx.pathscale.com ([64.160.42.68]:34217 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932184AbWELXoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:32 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 3 of 53] ipath - report max MR and QP sizes based on table
	sizes
X-Mercurial-Node: 5d5e1e641b16088c313809a1823972ce62e2200d
Message-Id: <5d5e1e641b16088c3138.1147477368@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:42:48 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Report max MR based on the lkey table size.
Report max QP based on the QP table size.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 3ab7a7b10bf2 -r 5d5e1e641b16 drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:27 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:27 2006 -0700
@@ -583,12 +583,12 @@ static int ipath_query_device(struct ib_
 	props->sys_image_guid = dev->sys_image_guid;
 
 	props->max_mr_size = ~0ull;
-	props->max_qp = 0xffff;
+	props->max_qp = dev->qp_table.max;
 	props->max_qp_wr = 0xffff;
 	props->max_sge = 255;
 	props->max_cq = 0xffff;
 	props->max_cqe = 0xffff;
-	props->max_mr = 0xffff;
+	props->max_mr = dev->lk_table.max;
 	props->max_pd = 0xffff;
 	props->max_qp_rd_atom = 1;
 	props->max_qp_init_rd_atom = 1;
