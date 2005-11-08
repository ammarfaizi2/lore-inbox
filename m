Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965260AbVKHGa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965260AbVKHGa2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 01:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965273AbVKHGa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 01:30:28 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:22383 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965260AbVKHGa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 01:30:27 -0500
Subject: [git patch review 6/6] [IB] mthca: fix typo in catastrophic error
	polling
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 08 Nov 2005 06:30:19 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1131431419061-a91722e21245ff50@cisco.com>
In-Reply-To: <1131431419061-26662c4d4f27ac0a@cisco.com>
X-OriginalArrivalTime: 08 Nov 2005 06:30:21.0081 (UTC) FILETIME=[E4A81890:01C5E42D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo in the rearming of the catastrophic error polling timer: we
should rearm the timer as long as the stop flag is _not_ set.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_catas.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 35085d3edccfc4f18930f45c4a1c896d041e7856
b523cfbb7bab356f66525e518f5b8c25cf0357d7
diff --git a/drivers/infiniband/hw/mthca/mthca_catas.c b/drivers/infiniband/hw/mthca/mthca_catas.c
index 7ac52af..3447cd7 100644
--- a/drivers/infiniband/hw/mthca/mthca_catas.c
+++ b/drivers/infiniband/hw/mthca/mthca_catas.c
@@ -94,7 +94,7 @@ static void poll_catas(unsigned long dev
 		}
 
 	spin_lock_irqsave(&catas_lock, flags);
-	if (dev->catas_err.stop)
+	if (!dev->catas_err.stop)
 		mod_timer(&dev->catas_err.timer,
 			  jiffies + MTHCA_CATAS_POLL_INTERVAL);
 	spin_unlock_irqrestore(&catas_lock, flags);
---
0.99.9e
