Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262921AbVDAWF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262921AbVDAWF6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 17:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbVDAUyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:54:25 -0500
Received: from webmail.topspin.com ([12.162.17.3]:37423 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262896AbVDAUvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:05 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][6/27] IB/mthca: allocate correct number of doorbell pages
In-Reply-To: <2005411249.cEJmE9mY2eziJTR6@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:52 -0800
Message-Id: <2005411249.VaroeECWUvqcGQCD@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:52.0575 (UTC) FILETIME=[5A5ED4F0:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doorbell record pages are allocated in HCA page size chunks (always
4096 bytes), so we need to divide by 4096 and not PAGE_SIZE when
figuring out how many pages we'll need space for.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-04-01 12:38:19.911638409 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-04-01 12:38:22.274125578 -0800
@@ -446,7 +446,7 @@
 
 	init_MUTEX(&dev->db_tab->mutex);
 
-	dev->db_tab->npages     = dev->uar_table.uarc_size / PAGE_SIZE;
+	dev->db_tab->npages     = dev->uar_table.uarc_size / 4096;
 	dev->db_tab->max_group1 = 0;
 	dev->db_tab->min_group2 = dev->db_tab->npages - 1;
 

