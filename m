Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161595AbWAMAN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161595AbWAMAN1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 19:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161594AbWAMAN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 19:13:27 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:26743 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1161589AbWAMAN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 19:13:26 -0500
Subject: [git patch review 5/6] IB/mthca: Cosmetic: use the ALIGN macro
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 13 Jan 2006 00:13:17 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1137111197380-d647455e061ba3b8@cisco.com>
In-Reply-To: <1137111197380-64102fbf42547cb5@cisco.com>
X-OriginalArrivalTime: 13 Jan 2006 00:13:22.0701 (UTC) FILETIME=[2A50B3D0:01C617D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the ALIGN macro to simplify some rounding code.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_cmd.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

c063a06835d3ccfa6c039d3a3869fcf22249c862
diff --git a/drivers/infiniband/hw/mthca/mthca_cmd.c b/drivers/infiniband/hw/mthca/mthca_cmd.c
index f69e489..be1791b 100644
--- a/drivers/infiniband/hw/mthca/mthca_cmd.c
+++ b/drivers/infiniband/hw/mthca/mthca_cmd.c
@@ -727,8 +727,8 @@ int mthca_QUERY_FW(struct mthca_dev *dev
 		 * system pages needed.
 		 */
 		dev->fw.arbel.fw_pages =
-			(dev->fw.arbel.fw_pages + (1 << (PAGE_SHIFT - 12)) - 1) >>
-			(PAGE_SHIFT - 12);
+			ALIGN(dev->fw.arbel.fw_pages, PAGE_SIZE >> 12) >>
+				(PAGE_SHIFT - 12);
 
 		mthca_dbg(dev, "Clear int @ %llx, EQ arm @ %llx, EQ set CI @ %llx\n",
 			  (unsigned long long) dev->fw.arbel.clr_int_base,
@@ -1445,6 +1445,7 @@ int mthca_SET_ICM_SIZE(struct mthca_dev 
 	 * pages needed.
 	 */
 	*aux_pages = (*aux_pages + (1 << (PAGE_SHIFT - 12)) - 1) >> (PAGE_SHIFT - 12);
+	*aux_pages = ALIGN(*aux_pages, PAGE_SIZE >> 12) >> (PAGE_SHIFT - 12);
 
 	return 0;
 }
-- 
1.0.7
