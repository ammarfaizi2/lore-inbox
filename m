Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbVDLQfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbVDLQfB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 12:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVDLKjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:39:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:42698 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262275AbVDLKd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:28 -0400
Message-Id: <200504121033.j3CAXJ0O005849@shell0.pdx.osdl.net>
Subject: [patch 171/198] IB/mthca: release mutex on doorbell alloc error path
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland Dreier <roland@topspin.com>

Release mutex on error return path from mthca_alloc_db().

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_memfree.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/infiniband/hw/mthca/mthca_memfree.c~ib-mthca-release-mutex-on-doorbell-alloc-error-path drivers/infiniband/hw/mthca/mthca_memfree.c
--- 25/drivers/infiniband/hw/mthca/mthca_memfree.c~ib-mthca-release-mutex-on-doorbell-alloc-error-path	2005-04-12 03:21:44.082435352 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-04-12 03:21:44.240411336 -0700
@@ -337,7 +337,8 @@ int mthca_alloc_db(struct mthca_dev *dev
 		break;
 
 	default:
-		return -1;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	for (i = start; i != end; i += dir)
_
