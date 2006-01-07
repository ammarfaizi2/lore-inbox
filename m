Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030507AbWAGRHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030507AbWAGRHO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 12:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbWAGRHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 12:07:14 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:57376 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1030507AbWAGRHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 12:07:13 -0500
X-IronPort-AV: i="3.99,342,1131350400"; 
   d="scan'208"; a="388635769:sNHT30226684"
Subject: [git patch review 2/2] IB: Set GIDs correctly in
	ib_create_ah_from_wc()
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 07 Jan 2006 17:07:08 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1136653628658-5a13a5a36ef5dae2@cisco.com>
In-Reply-To: <1136653628658-9dad0e46bb1d8cba@cisco.com>
X-OriginalArrivalTime: 07 Jan 2006 17:07:12.0458 (UTC) FILETIME=[CD3282A0:01C613AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ib_create_ah_from_wc() doesn't create the correct return address (AH)
when there is a GRH present (source & dest GIDs need to be swapped).

Signed-off-by: Ralph Campbell <ralphc@pathscale.com>
Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/verbs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

4f8448dfe8d3804fadad90c9b77494238b4a4eae
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 4c15e11..c857361 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -107,9 +107,9 @@ struct ib_ah *ib_create_ah_from_wc(struc
 
 	if (wc->wc_flags & IB_WC_GRH) {
 		ah_attr.ah_flags = IB_AH_GRH;
-		ah_attr.grh.dgid = grh->dgid;
+		ah_attr.grh.dgid = grh->sgid;
 
-		ret = ib_find_cached_gid(pd->device, &grh->sgid, &port_num,
+		ret = ib_find_cached_gid(pd->device, &grh->dgid, &port_num,
 					 &gid_index);
 		if (ret)
 			return ERR_PTR(ret);
-- 
0.99.9n
