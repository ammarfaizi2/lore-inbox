Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965168AbVITWI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbVITWI5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbVITWIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:08:54 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:886 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965166AbVITWI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:08:28 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 10/10] IB/mthca: Fix device removal memory leak
In-Reply-To: <2005920158.3byIBzMT2aE3fDZQ@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 20 Sep 2005 15:08:11 -0700
Message-Id: <2005920158.lu2Dy0AsB1k9T11l@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 20 Sep 2005 22:08:13.0072 (UTC) FILETIME=[CB22C100:01C5BE2F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] IB/mthca: Fix device removal memory leak
From: Michael S. Tsirkin <mst@mellanox.co.il>
Date: 1127238888 -0700

Clean up QP table array on device removal.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_qp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

71eea47d853bb0ce0c6befe11b3e08111263170f
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -2123,5 +2123,6 @@ void __devexit mthca_cleanup_qp_table(st
 	for (i = 0; i < 2; ++i)
 		mthca_CONF_SPECIAL_QP(dev, i, 0, &status);
 
+	mthca_array_cleanup(&dev->qp_table.qp, dev->limits.num_qps);
 	mthca_alloc_cleanup(&dev->qp_table.alloc);
 }
