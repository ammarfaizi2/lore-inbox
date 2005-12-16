Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbVLPEBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVLPEBM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 23:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbVLPEAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 23:00:47 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:14458 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932116AbVLPEAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 23:00:22 -0500
X-IronPort-AV: i="3.99,259,1131350400"; 
   d="scan'208"; a="685293739:sNHT31343430"
Subject: [git patch review 4/7] IB/mthca: Fix thinko in mthca_table_find()
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 16 Dec 2005 04:00:17 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1134705617068-92874cd0c1ec02ff@cisco.com>
In-Reply-To: <1134705617068-301e9a8555929947@cisco.com>
X-OriginalArrivalTime: 16 Dec 2005 04:00:17.0922 (UTC) FILETIME=[3A0D8E20:01C601F5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

break only escapes from the innermost loop, and we want to escape both
loops and return an answer.  Noticed by Ishai Rabinovitch.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_memfree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

6c7d2a75b512c64c910b69adf32dbaddb461910b
diff --git a/drivers/infiniband/hw/mthca/mthca_memfree.c b/drivers/infiniband/hw/mthca/mthca_memfree.c
index 5798ed0..9fb985a 100644
--- a/drivers/infiniband/hw/mthca/mthca_memfree.c
+++ b/drivers/infiniband/hw/mthca/mthca_memfree.c
@@ -233,7 +233,7 @@ void *mthca_table_find(struct mthca_icm_
 		for (i = 0; i < chunk->npages; ++i) {
 			if (chunk->mem[i].length >= offset) {
 				page = chunk->mem[i].page;
-				break;
+				goto out;
 			}
 			offset -= chunk->mem[i].length;
 		}
-- 
0.99.9n
