Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262892AbVDAWF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262892AbVDAWF7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 17:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262895AbVDAUyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:54:17 -0500
Received: from webmail.topspin.com ([12.162.17.3]:35887 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262892AbVDAUvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:05 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][5/27] IB/mthca: allow unaligned memory regions
In-Reply-To: <2005411249.dKg4ijljsqXo1Rt6@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:52 -0800
Message-Id: <2005411249.cEJmE9mY2eziJTR6@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:52.0481 (UTC) FILETIME=[5A507D10:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael S. Tsirkin <mst@mellanox.co.il>

The first buffer of a memory region is not required to be
page-aligned, so don't return an error if it's not.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-04-01 12:38:20.839437009 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_provider.c	2005-04-01 12:38:21.926201103 -0800
@@ -494,7 +494,7 @@
 	mask = 0;
 	total_size = 0;
 	for (i = 0; i < num_phys_buf; ++i) {
-		if (buffer_list[i].addr & ~PAGE_MASK)
+		if (i != 0 && buffer_list[i].addr & ~PAGE_MASK)
 			return ERR_PTR(-EINVAL);
 		if (i != 0 && i != num_phys_buf - 1 &&
 		    (buffer_list[i].size & ~PAGE_MASK))

