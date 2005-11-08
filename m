Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965263AbVKHGa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965263AbVKHGa3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 01:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965279AbVKHGa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 01:30:29 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:22383 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965263AbVKHGa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 01:30:28 -0500
Subject: [git patch review 1/6] [IB] mthca: report page size capability
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 08 Nov 2005 06:30:19 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1131431419060-378986988cf168d2@cisco.com>
X-OriginalArrivalTime: 08 Nov 2005 06:30:20.0209 (UTC) FILETIME=[E4230A10:01C5E42D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Report the device's real page size capability in mthca_query_device().

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_dev.h      |    1 +
 drivers/infiniband/hw/mthca/mthca_main.c     |    1 +
 drivers/infiniband/hw/mthca/mthca_provider.c |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

applies-to: c403b29783de27e290b5d12f12054d03f96ce8b2
0f69ce1e4474e5d5e266457e8a1f4166cf71f6c7
diff --git a/drivers/infiniband/hw/mthca/mthca_dev.h b/drivers/infiniband/hw/mthca/mthca_dev.h
index e7e5d3b..808037f 100644
--- a/drivers/infiniband/hw/mthca/mthca_dev.h
+++ b/drivers/infiniband/hw/mthca/mthca_dev.h
@@ -154,6 +154,7 @@ struct mthca_limits {
 	int      reserved_mcgs;
 	int      num_pds;
 	int      reserved_pds;
+	u32      page_size_cap;
 	u32      flags;
 	u8       port_width_cap;
 };
diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/hw/mthca/mthca_main.c
index 45c6328..16594d1 100644
--- a/drivers/infiniband/hw/mthca/mthca_main.c
+++ b/drivers/infiniband/hw/mthca/mthca_main.c
@@ -181,6 +181,7 @@ static int __devinit mthca_dev_lim(struc
 	mdev->limits.reserved_uars      = dev_lim->reserved_uars;
 	mdev->limits.reserved_pds       = dev_lim->reserved_pds;
 	mdev->limits.port_width_cap     = dev_lim->max_port_width;
+	mdev->limits.page_size_cap      = ~(u32) (dev_lim->min_page_sz - 1);
 	mdev->limits.flags              = dev_lim->flags;
 
 	/* IB_DEVICE_RESIZE_MAX_WR not supported by driver.
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 6b01666..e78259b 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -90,6 +90,7 @@ static int mthca_query_device(struct ib_
 	memcpy(&props->node_guid,      out_mad->data + 12, 8);
 
 	props->max_mr_size         = ~0ull;
+	props->page_size_cap       = mdev->limits.page_size_cap;
 	props->max_qp              = mdev->limits.num_qps - mdev->limits.reserved_qps;
 	props->max_qp_wr           = mdev->limits.max_wqes;
 	props->max_sge             = mdev->limits.max_sg;
---
0.99.9e
