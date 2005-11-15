Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbVKOIij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbVKOIij (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 03:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbVKOIij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 03:38:39 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:53425 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751380AbVKOIii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 03:38:38 -0500
Subject: [git patch review 1/3] [IB] srp: increase max_luns
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 15 Nov 2005 08:38:30 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1132043910918-ccc552298b599865@cisco.com>
X-OriginalArrivalTime: 15 Nov 2005 08:38:31.0972 (UTC) FILETIME=[F5AD2E40:01C5E9BF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Increase SRP max_luns to 512 to match the kernel's default, since SRP
storage targets can have lots of LUNs and the SRP initiator itself
doesn't have any particular limit.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/srp/ib_srp.c |    2 ++
 drivers/infiniband/ulp/srp/ib_srp.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

applies-to: 84a581820bff0fa9830f18138da02d929e4edcb9
5f068992a1bccda5574b4f6d33458ef806686d7f
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 321a3a1..a364530 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1417,6 +1417,8 @@ static ssize_t srp_create_target(struct 
 	if (!target_host)
 		return -ENOMEM;
 
+	target_host->max_lun = SRP_MAX_LUN;
+
 	target = host_to_target(target_host);
 	memset(target, 0, sizeof *target);
 
diff --git a/drivers/infiniband/ulp/srp/ib_srp.h b/drivers/infiniband/ulp/srp/ib_srp.h
index 4fec28a..b564f18 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.h
+++ b/drivers/infiniband/ulp/srp/ib_srp.h
@@ -54,6 +54,7 @@ enum {
 	SRP_PORT_REDIRECT	= 1,
 	SRP_DLID_REDIRECT	= 2,
 
+	SRP_MAX_LUN		= 512,
 	SRP_MAX_IU_LEN		= 256,
 
 	SRP_RQ_SHIFT    	= 6,
---
0.99.9g
