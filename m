Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVALVzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVALVzs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVALVzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:55:01 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:39078 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261498AbVALVsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:48:38 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051121348.cZjtF8ckKVdplJpJ@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 12 Jan 2005 13:48:13 -0800
Message-Id: <20051121348.O0tqjPJiAF6eouQF@topspin.com>
Mime-Version: 1.0
To: akpm@osdl.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][14/18] InfiniBand/core: add qp_type to struct ib_qp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 12 Jan 2005 21:48:19.0407 (UTC) FILETIME=[6DF8ADF0:01C4F8F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add qp_type to struct ib_qp.

Signed-off by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux/drivers/infiniband/include/ib_verbs.h	(revision 1507)
+++ linux/drivers/infiniband/include/ib_verbs.h	(revision 1508)
@@ -659,6 +659,7 @@
 	void                  (*event_handler)(struct ib_event *, void *);
 	void		       *qp_context;
 	u32			qp_num;
+	enum ib_qp_type		qp_type;
 };
 
 struct ib_mr {
--- linux/drivers/infiniband/core/verbs.c	(revision 1507)
+++ linux/drivers/infiniband/core/verbs.c	(revision 1508)
@@ -132,6 +132,7 @@
 		qp->srq	       	  = qp_init_attr->srq;
 		qp->event_handler = qp_init_attr->event_handler;
 		qp->qp_context    = qp_init_attr->qp_context;
+		qp->qp_type	  = qp_init_attr->qp_type;
 		atomic_inc(&pd->usecnt);
 		atomic_inc(&qp_init_attr->send_cq->usecnt);
 		atomic_inc(&qp_init_attr->recv_cq->usecnt);

