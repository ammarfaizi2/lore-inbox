Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWAFAUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWAFAUP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWAFATs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:19:48 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:40003 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1752324AbWAFATp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:19:45 -0500
X-IronPort-AV: i="3.99,336,1131350400"; 
   d="scan'208"; a="247400754:sNHT30179548"
Subject: [git patch review 4/4] IB/mthca: create_eq with size not a power of 2
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 06 Jan 2006 00:19:41 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1136506781420-ac8ffb517687652c@cisco.com>
In-Reply-To: <1136506781419-5ed071c9c7a80e29@cisco.com>
X-OriginalArrivalTime: 06 Jan 2006 00:19:43.0591 (UTC) FILETIME=[E473A770:01C61256]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix mthca_create_eq for when the EQ size is not a power of 2.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_eq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

466200562ccd80f728f7ef602d2b97b4fdedd566
diff --git a/drivers/infiniband/hw/mthca/mthca_eq.c b/drivers/infiniband/hw/mthca/mthca_eq.c
index 34d68e5..e8a948f 100644
--- a/drivers/infiniband/hw/mthca/mthca_eq.c
+++ b/drivers/infiniband/hw/mthca/mthca_eq.c
@@ -484,8 +484,7 @@ static int __devinit mthca_create_eq(str
 				     u8 intr,
 				     struct mthca_eq *eq)
 {
-	int npages = (nent * MTHCA_EQ_ENTRY_SIZE + PAGE_SIZE - 1) /
-		PAGE_SIZE;
+	int npages;
 	u64 *dma_list = NULL;
 	dma_addr_t t;
 	struct mthca_mailbox *mailbox;
@@ -496,6 +495,7 @@ static int __devinit mthca_create_eq(str
 
 	eq->dev  = dev;
 	eq->nent = roundup_pow_of_two(max(nent, 2));
+ 	npages = ALIGN(eq->nent * MTHCA_EQ_ENTRY_SIZE, PAGE_SIZE) / PAGE_SIZE;
 
 	eq->page_list = kmalloc(npages * sizeof *eq->page_list,
 				GFP_KERNEL);
-- 
0.99.9n
