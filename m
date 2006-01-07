Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965372AbWAGA1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965372AbWAGA1E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965384AbWAGAZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:25:55 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:18065 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S965372AbWAGAZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:25:49 -0500
X-IronPort-AV: i="3.99,341,1131350400"; 
   d="scan'208"; a="388438782:sNHT30923612"
Subject: [git patch review 5/8] IB/mthca: Fill in vendor_err field in
	completion with error
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 07 Jan 2006 00:25:42 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1136593543000-0e0e6d306b8be206@cisco.com>
In-Reply-To: <1136593542999-1260d5ab9345c4eb@cisco.com>
X-OriginalArrivalTime: 07 Jan 2006 00:25:45.0898 (UTC) FILETIME=[E6D110A0:01C61320]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fill vendor_err field in completion with error.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_cq.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

0f8e8f9607d77ffc1f9820446dfcf781e96fdfd4
diff --git a/drivers/infiniband/hw/mthca/mthca_cq.c b/drivers/infiniband/hw/mthca/mthca_cq.c
index fcef8dc..96f1a86 100644
--- a/drivers/infiniband/hw/mthca/mthca_cq.c
+++ b/drivers/infiniband/hw/mthca/mthca_cq.c
@@ -128,12 +128,12 @@ struct mthca_err_cqe {
 	__be32 my_qpn;
 	u32    reserved1[3];
 	u8     syndrome;
-	u8     reserved2;
+	u8     vendor_err;
 	__be16 db_cnt;
-	u32    reserved3;
+	u32    reserved2;
 	__be32 wqe;
 	u8     opcode;
-	u8     reserved4[2];
+	u8     reserved3[2];
 	u8     owner;
 };
 
@@ -342,8 +342,8 @@ static int handle_error_cqe(struct mthca
 	}
 
 	/*
-	 * For completions in error, only work request ID, status (and
-	 * freed resource count for RD) have to be set.
+	 * For completions in error, only work request ID, status, vendor error
+	 * (and freed resource count for RD) have to be set.
 	 */
 	switch (cqe->syndrome) {
 	case SYNDROME_LOCAL_LENGTH_ERR:
@@ -405,6 +405,8 @@ static int handle_error_cqe(struct mthca
 		break;
 	}
 
+	entry->vendor_err = cqe->vendor_err;
+
 	/*
 	 * Mem-free HCAs always generate one CQE per WQE, even in the
 	 * error case, so we don't have to check the doorbell count, etc.
-- 
0.99.9n
