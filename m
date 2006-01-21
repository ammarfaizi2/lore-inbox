Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWAUWDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWAUWDg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 17:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWAUWDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 17:03:17 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:32526 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S932401AbWAUWDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 17:03:15 -0500
Subject: [git patch review 5/5] IB/mthca: Use correct GID in MADs sent on port
	2
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 21 Jan 2006 22:03:10 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1137880990999-4d027d1b419c13b2@cisco.com>
In-Reply-To: <1137880990999-7f911bca79a83d08@cisco.com>
X-OriginalArrivalTime: 21 Jan 2006 22:03:14.0948 (UTC) FILETIME=[7A3FE440:01C61ED6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mthca_create_ah() includes the port number in the GID index. The reverse
needs to be done in mthca_read_ah().

Noted by Hal Rosenstock.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_av.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

f9e61929e5e1dacc2afefbde6abc3e6571ca2887
diff --git a/drivers/infiniband/hw/mthca/mthca_av.c b/drivers/infiniband/hw/mthca/mthca_av.c
index a14eed0..a19e0ed 100644
--- a/drivers/infiniband/hw/mthca/mthca_av.c
+++ b/drivers/infiniband/hw/mthca/mthca_av.c
@@ -184,7 +184,7 @@ int mthca_read_ah(struct mthca_dev *dev,
 			ah->av->sl_tclass_flowlabel & cpu_to_be32(0xfffff);
 		ib_get_cached_gid(&dev->ib_dev,
 				  be32_to_cpu(ah->av->port_pd) >> 24,
-				  ah->av->gid_index,
+				  ah->av->gid_index % dev->limits.gid_table_len,
 				  &header->grh.source_gid);
 		memcpy(header->grh.destination_gid.raw,
 		       ah->av->dgid, 16);
-- 
1.1.3
