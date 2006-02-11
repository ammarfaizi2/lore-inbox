Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWBKUW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWBKUW2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 15:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWBKUW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 15:22:27 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:14709 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932354AbWBKUW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 15:22:26 -0500
X-IronPort-AV: i="4.02,105,1139212800"; 
   d="scan'208"; a="403834576:sNHT30925876"
Subject: [git patch review 3/4] IB/mthca: Don't print debugging info until we
	have all values
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 11 Feb 2006 20:22:21 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1139689341370-48a55ba994088cbc@cisco.com>
In-Reply-To: <1139689341370-af4160238007a6e3@cisco.com>
X-OriginalArrivalTime: 11 Feb 2006 20:22:24.0357 (UTC) FILETIME=[DE7DB950:01C62F48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When debugging is enabled, the mthca_QUERY_DEV_LIM() firmware command
function prints out some of the device limits that it queries.
However the debugging prints happen before all of the fields are
extracted from the firmware response, so some of the values that get
printed are uninitialized junk.  Move the prints to the end of the
function to fix this.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_cmd.c |   38 ++++++++++++++++---------------
 1 files changed, 19 insertions(+), 19 deletions(-)

f295c79b6766b25fe8c1aad88211c54d1caa7e0b
diff --git a/drivers/infiniband/hw/mthca/mthca_cmd.c b/drivers/infiniband/hw/mthca/mthca_cmd.c
index f9b9b93..2825615 100644
--- a/drivers/infiniband/hw/mthca/mthca_cmd.c
+++ b/drivers/infiniband/hw/mthca/mthca_cmd.c
@@ -1029,25 +1029,6 @@ int mthca_QUERY_DEV_LIM(struct mthca_dev
 	MTHCA_GET(size, outbox, QUERY_DEV_LIM_UAR_ENTRY_SZ_OFFSET);
 	dev_lim->uar_scratch_entry_sz = size;
 
-	mthca_dbg(dev, "Max QPs: %d, reserved QPs: %d, entry size: %d\n",
-		  dev_lim->max_qps, dev_lim->reserved_qps, dev_lim->qpc_entry_sz);
-	mthca_dbg(dev, "Max SRQs: %d, reserved SRQs: %d, entry size: %d\n",
-		  dev_lim->max_srqs, dev_lim->reserved_srqs, dev_lim->srq_entry_sz);
-	mthca_dbg(dev, "Max CQs: %d, reserved CQs: %d, entry size: %d\n",
-		  dev_lim->max_cqs, dev_lim->reserved_cqs, dev_lim->cqc_entry_sz);
-	mthca_dbg(dev, "Max EQs: %d, reserved EQs: %d, entry size: %d\n",
-		  dev_lim->max_eqs, dev_lim->reserved_eqs, dev_lim->eqc_entry_sz);
-	mthca_dbg(dev, "reserved MPTs: %d, reserved MTTs: %d\n",
-		  dev_lim->reserved_mrws, dev_lim->reserved_mtts);
-	mthca_dbg(dev, "Max PDs: %d, reserved PDs: %d, reserved UARs: %d\n",
-		  dev_lim->max_pds, dev_lim->reserved_pds, dev_lim->reserved_uars);
-	mthca_dbg(dev, "Max QP/MCG: %d, reserved MGMs: %d\n",
-		  dev_lim->max_pds, dev_lim->reserved_mgms);
-	mthca_dbg(dev, "Max CQEs: %d, max WQEs: %d, max SRQ WQEs: %d\n",
-		  dev_lim->max_cq_sz, dev_lim->max_qp_sz, dev_lim->max_srq_sz);
-
-	mthca_dbg(dev, "Flags: %08x\n", dev_lim->flags);
-
 	if (mthca_is_memfree(dev)) {
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_SRQ_SZ_OFFSET);
 		dev_lim->max_srq_sz = 1 << field;
@@ -1093,6 +1074,25 @@ int mthca_QUERY_DEV_LIM(struct mthca_dev
 		dev_lim->mpt_entry_sz = MTHCA_MPT_ENTRY_SIZE;
 	}
 
+	mthca_dbg(dev, "Max QPs: %d, reserved QPs: %d, entry size: %d\n",
+		  dev_lim->max_qps, dev_lim->reserved_qps, dev_lim->qpc_entry_sz);
+	mthca_dbg(dev, "Max SRQs: %d, reserved SRQs: %d, entry size: %d\n",
+		  dev_lim->max_srqs, dev_lim->reserved_srqs, dev_lim->srq_entry_sz);
+	mthca_dbg(dev, "Max CQs: %d, reserved CQs: %d, entry size: %d\n",
+		  dev_lim->max_cqs, dev_lim->reserved_cqs, dev_lim->cqc_entry_sz);
+	mthca_dbg(dev, "Max EQs: %d, reserved EQs: %d, entry size: %d\n",
+		  dev_lim->max_eqs, dev_lim->reserved_eqs, dev_lim->eqc_entry_sz);
+	mthca_dbg(dev, "reserved MPTs: %d, reserved MTTs: %d\n",
+		  dev_lim->reserved_mrws, dev_lim->reserved_mtts);
+	mthca_dbg(dev, "Max PDs: %d, reserved PDs: %d, reserved UARs: %d\n",
+		  dev_lim->max_pds, dev_lim->reserved_pds, dev_lim->reserved_uars);
+	mthca_dbg(dev, "Max QP/MCG: %d, reserved MGMs: %d\n",
+		  dev_lim->max_pds, dev_lim->reserved_mgms);
+	mthca_dbg(dev, "Max CQEs: %d, max WQEs: %d, max SRQ WQEs: %d\n",
+		  dev_lim->max_cq_sz, dev_lim->max_qp_sz, dev_lim->max_srq_sz);
+
+	mthca_dbg(dev, "Flags: %08x\n", dev_lim->flags);
+
 out:
 	mthca_free_mailbox(dev, mailbox);
 	return err;
-- 
1.1.3
