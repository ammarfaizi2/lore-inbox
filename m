Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262940AbVDAVJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbVDAVJk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 16:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbVDAVIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 16:08:09 -0500
Received: from webmail.topspin.com ([12.162.17.3]:37423 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262911AbVDAUvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:24 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][23/27] IB/mthca: tweaks to mthca_cmd.c
In-Reply-To: <2005411249.CxF3RBWpNJELwaqL@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:54 -0800
Message-Id: <2005411249.5GDmFAellTSOT0Ai@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:54.0138 (UTC) FILETIME=[5B4D53A0:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor tweaks to firmware command handling: kill off an unused get of a
value, and add a little more info to debug output.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-04-01 12:38:27.495992056 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-04-01 12:38:30.084430178 -0800
@@ -989,7 +989,6 @@
 		dev_lim->hca.arbel.resize_srq = field & 1;
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_MAX_SG_RQ_OFFSET);
 		dev_lim->max_sg = min_t(int, field, dev_lim->max_sg);
-		MTHCA_GET(size, outbox, QUERY_DEV_LIM_MTT_ENTRY_SZ_OFFSET);
 		MTHCA_GET(size, outbox, QUERY_DEV_LIM_MPT_ENTRY_SZ_OFFSET);
 		dev_lim->mpt_entry_sz = size;
 		MTHCA_GET(field, outbox, QUERY_DEV_LIM_PBL_SZ_OFFSET);
@@ -1297,8 +1296,8 @@
 	pci_free_consistent(dev->pdev, 16, inbox, indma);
 
 	if (!err)
-		mthca_dbg(dev, "Mapped page at %llx for ICM.\n",
-			  (unsigned long long) virt);
+		mthca_dbg(dev, "Mapped page at %llx to %llx for ICM.\n",
+			  (unsigned long long) dma_addr, (unsigned long long) virt);
 
 	return err;
 }

