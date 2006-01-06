Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752319AbWAFATq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbWAFATq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWAFATp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:19:45 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:845 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1752319AbWAFATo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:19:44 -0500
X-IronPort-AV: i="3.99,336,1131350400"; 
   d="scan'208"; a="247400749:sNHT30389744"
Subject: [git patch review 2/4] IB/mthca: check return value in mthca_dev_lim
	call
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 06 Jan 2006 00:19:41 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1136506781419-2b71405b820f1e9d@cisco.com>
In-Reply-To: <1136506781419-a5fabee982034082@cisco.com>
X-OriginalArrivalTime: 06 Jan 2006 00:19:43.0517 (UTC) FILETIME=[E4685CD0:01C61256]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check error return on call to mthca_dev_lim for Tavor
(as is done for memfree).

Signed-off-by: Jack Morgenstein <jackm@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_main.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

aa2f9367790ad81ef51d3f667124227ca3003d3b
diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/hw/mthca/mthca_main.c
index 6f94b25..8b00d9a 100644
--- a/drivers/infiniband/hw/mthca/mthca_main.c
+++ b/drivers/infiniband/hw/mthca/mthca_main.c
@@ -261,6 +261,10 @@ static int __devinit mthca_init_tavor(st
 	}
 
 	err = mthca_dev_lim(mdev, &dev_lim);
+	if (err) {
+		mthca_err(mdev, "QUERY_DEV_LIM command failed, aborting.\n");
+		goto err_disable;
+	}
 
 	profile = default_profile;
 	profile.num_uar   = dev_lim.uar_size / PAGE_SIZE;
-- 
0.99.9n
