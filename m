Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262898AbVDAUzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbVDAUzb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbVDAUyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:54:43 -0500
Received: from webmail.topspin.com ([12.162.17.3]:35887 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262898AbVDAUvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:08 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][7/27] IB/mthca: clean up mthca_dereg_mr()
In-Reply-To: <2005411249.VaroeECWUvqcGQCD@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:52 -0800
Message-Id: <2005411249.i5VdQJiPqpmwTj3T@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:52.0653 (UTC) FILETIME=[5A6ABBD0:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

It's cleaner to kfree mthca_mr, and not rely on the fact
that ib_mr is the first field in mthca_mr.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-04-01 12:38:21.926201103 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_provider.c	2005-04-01 12:38:22.630048317 -0800
@@ -568,8 +568,9 @@
 
 static int mthca_dereg_mr(struct ib_mr *mr)
 {
-	mthca_free_mr(to_mdev(mr->device), to_mmr(mr));
-	kfree(mr);
+	struct mthca_mr *mmr = to_mmr(mr);
+	mthca_free_mr(to_mdev(mr->device), mmr);
+	kfree(mmr);
 	return 0;
 }
 

