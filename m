Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVF2Cb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVF2Cb5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 22:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVF1Xe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:34:56 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:32272 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S262227AbVF1XDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:03:54 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 03/16] IB uverbs: update mthca for new API
In-Reply-To: <2005628163.TnJHv5fpNVcYsu6I@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 28 Jun 2005 16:03:43 -0700
Message-Id: <2005628163.01zcuUvu5mtvwzkX@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update mthca to compile against the updated API for low-level drivers.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_provider.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)



--- linux.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-06-28 15:19:55.005985043 -0700
+++ linux/drivers/infiniband/hw/mthca/mthca_provider.c	2005-06-28 15:20:00.882715841 -0700
@@ -284,7 +284,9 @@ static int mthca_query_gid(struct ib_dev
 	return err;
 }
 
-static struct ib_pd *mthca_alloc_pd(struct ib_device *ibdev)
+static struct ib_pd *mthca_alloc_pd(struct ib_device *ibdev,
+				    struct ib_ucontext *context,
+				    struct ib_udata *udata)
 {
 	struct mthca_pd *pd;
 	int err;
@@ -338,7 +340,8 @@ static int mthca_ah_destroy(struct ib_ah
 }
 
 static struct ib_qp *mthca_create_qp(struct ib_pd *pd,
-				     struct ib_qp_init_attr *init_attr)
+				     struct ib_qp_init_attr *init_attr,
+				     struct ib_udata *udata)
 {
 	struct mthca_qp *qp;
 	int err;
@@ -409,7 +412,9 @@ static int mthca_destroy_qp(struct ib_qp
 	return 0;
 }
 
-static struct ib_cq *mthca_create_cq(struct ib_device *ibdev, int entries)
+static struct ib_cq *mthca_create_cq(struct ib_device *ibdev, int entries,
+				     struct ib_ucontext *context,
+				     struct ib_udata *udata)
 {
 	struct mthca_cq *cq;
 	int nent;
@@ -692,6 +697,8 @@ int mthca_register_device(struct mthca_d
 	int i;
 
 	strlcpy(dev->ib_dev.name, "mthca%d", IB_DEVICE_NAME_MAX);
+	dev->ib_dev.owner                = THIS_MODULE;
+
 	dev->ib_dev.node_type            = IB_NODE_CA;
 	dev->ib_dev.phys_port_cnt        = dev->limits.num_ports;
 	dev->ib_dev.dma_device           = &dev->pdev->dev;
