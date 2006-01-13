Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161596AbWAMAPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161596AbWAMAPB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 19:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161594AbWAMANz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 19:13:55 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:64036 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1161596AbWAMAN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 19:13:29 -0500
X-IronPort-AV: i="3.99,361,1131350400"; 
   d="scan'208"; a="391186730:sNHT1905873354"
Subject: [git patch review 3/6] IB/mthca: Fix memory leak of multicast group
	structures
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 13 Jan 2006 00:13:17 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1137111197380-7741e9b26c0a0236@cisco.com>
In-Reply-To: <1137111197380-f482e88c451680c0@cisco.com>
X-OriginalArrivalTime: 13 Jan 2006 00:13:22.0498 (UTC) FILETIME=[2A31BA20:01C617D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert "/ (1 << lg)" to ">> lg" for a slight code size reduction.

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-24 (-24)
function                                     old     new   delta
mthca_map_cmd                                613     589     -24

Signed-off-by: Ishai Rabinovitz <ishai@mellanox.co.il>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_cmd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

59f174faffd5dfee709fa0ead320cc6daf827e93
diff --git a/drivers/infiniband/hw/mthca/mthca_cmd.c b/drivers/infiniband/hw/mthca/mthca_cmd.c
index 22ac72b..f69e489 100644
--- a/drivers/infiniband/hw/mthca/mthca_cmd.c
+++ b/drivers/infiniband/hw/mthca/mthca_cmd.c
@@ -606,7 +606,7 @@ static int mthca_map_cmd(struct mthca_de
 			err = -EINVAL;
 			goto out;
 		}
-		for (i = 0; i < mthca_icm_size(&iter) / (1 << lg); ++i) {
+		for (i = 0; i < mthca_icm_size(&iter) >> lg; ++i) {
 			if (virt != -1) {
 				pages[nent * 2] = cpu_to_be64(virt);
 				virt += 1 << lg;
-- 
1.0.7
