Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbVDLSk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbVDLSk0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVDLShs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:37:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:5323 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262303AbVDLKeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:34:02 -0400
Message-Id: <200504121033.j3CAXMXx005859@shell0.pdx.osdl.net>
Subject: [patch 174/198] IB/mthca: fix format of CQ number for CQ events
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland Dreier <roland@topspin.com>

CQ numbers are only 24 bits, so only print 6 hex digits and mask off reserved
part when reporting a CQ event.

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_eq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/infiniband/hw/mthca/mthca_eq.c~ib-mthca-fix-format-of-cq-number-for-cq-events drivers/infiniband/hw/mthca/mthca_eq.c
--- 25/drivers/infiniband/hw/mthca/mthca_eq.c~ib-mthca-fix-format-of-cq-number-for-cq-events	2005-04-12 03:21:44.893312080 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_eq.c	2005-04-12 03:21:44.896311624 -0700
@@ -344,10 +344,10 @@ static int mthca_eq_int(struct mthca_dev
 			break;
 
 		case MTHCA_EVENT_TYPE_CQ_ERROR:
-			mthca_warn(dev, "CQ %s on CQN %08x\n",
+			mthca_warn(dev, "CQ %s on CQN %06x\n",
 				   eqe->event.cq_err.syndrome == 1 ?
 				   "overrun" : "access violation",
-				   be32_to_cpu(eqe->event.cq_err.cqn));
+				   be32_to_cpu(eqe->event.cq_err.cqn) & 0xffffff);
 			break;
 
 		case MTHCA_EVENT_TYPE_EQ_OVERFLOW:
_
