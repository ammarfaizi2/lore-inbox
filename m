Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWEMADg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWEMADg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 20:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWEMADL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 20:03:11 -0400
Received: from mx.pathscale.com ([64.160.42.68]:52649 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932197AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 10 of 53] ipath - require capabilities when creating a QP
X-Mercurial-Node: 2fea0d127a41b26adcadba984866a69e9577b355
Message-Id: <2fea0d127a41b26adcad.1147477375@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:42:55 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You have to specify some capabilities when creating a QP.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r a89145f4846c -r 2fea0d127a41 drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Fri May 12 15:55:27 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Fri May 12 15:55:27 2006 -0700
@@ -667,6 +667,14 @@ struct ib_qp *ipath_create_qp(struct ib_
 		goto bail;
 	}
 
+	if (init_attr->cap.max_send_sge +
+	    init_attr->cap.max_recv_sge +
+	    init_attr->cap.max_send_wr +
+	    init_attr->cap.max_recv_wr == 0) {
+		ret = ERR_PTR(-EINVAL);
+		goto bail;
+	}
+
 	switch (init_attr->qp_type) {
 	case IB_QPT_UC:
 	case IB_QPT_RC:
