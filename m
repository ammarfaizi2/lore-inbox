Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbVDAUzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbVDAUzb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbVDAUyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:54:36 -0500
Received: from webmail.topspin.com ([12.162.17.3]:37423 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262897AbVDAUvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:08 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][8/27] IB/mthca: fix MR allocation error path
In-Reply-To: <2005411249.i5VdQJiPqpmwTj3T@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:52 -0800
Message-Id: <2005411249.mKyALgAB0GbtFnjH@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:52.0763 (UTC) FILETIME=[5A7B84B0:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael S. Tsirkin <mst@mellanox.co.il>

Fix error handling in MR allocation for mem-free mode:
mthca_free must get an MR index, not a key.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_mr.c	2005-04-01 12:38:19.903640145 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_mr.c	2005-04-01 12:38:22.968974746 -0800
@@ -231,7 +231,7 @@
 		mthca_table_put(dev, dev->mr_table.mpt_table, key);
 
 err_out_mpt_free:
-	mthca_free(&dev->mr_table.mpt_alloc, mr->ibmr.lkey);
+	mthca_free(&dev->mr_table.mpt_alloc, key);
 	kfree(mailbox);
 	return err;
 }
@@ -368,7 +368,7 @@
 		mthca_table_put(dev, dev->mr_table.mpt_table, key);
 
 err_out_mpt_free:
-	mthca_free(&dev->mr_table.mpt_alloc, mr->ibmr.lkey);
+	mthca_free(&dev->mr_table.mpt_alloc, key);
 	return err;
 }
 

