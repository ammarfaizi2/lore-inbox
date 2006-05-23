Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWEWSeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWEWSeG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWEWSdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:33:43 -0400
Received: from mx.pathscale.com ([64.160.42.68]:8887 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751225AbWEWSdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:33:35 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 10 of 10] ipath - deref correct pointer when using kernel SMA
X-Mercurial-Node: c892bcb21ac15c451be3dd8d50d42269ee772dc9
Message-Id: <c892bcb21ac15c451be3.1148409158@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1148409148@eng-12.pathscale.com>
Date: Tue, 23 May 2006 11:32:38 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At this point, the core QP structure hasn't been initialized, so what's
in there isn't valid.  Get the same information elsewhere.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 3d844dee2f61 -r c892bcb21ac1 drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Tue May 23 11:29:16 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Tue May 23 11:29:16 2006 -0700
@@ -734,7 +734,7 @@ struct ib_qp *ipath_create_qp(struct ib_
 		ipath_reset_qp(qp);
 
 		/* Tell the core driver that the kernel SMA is present. */
-		if (qp->ibqp.qp_type == IB_QPT_SMI)
+		if (init_attr->qp_type == IB_QPT_SMI)
 			ipath_layer_set_verbs_flags(dev->dd,
 						    IPATH_VERBS_KERNEL_SMA);
 		break;
