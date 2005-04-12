Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbVDLQfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVDLQfE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 12:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbVDLKkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:40:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:42442 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262274AbVDLKd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:28 -0400
Message-Id: <200504121033.j3CAXGVT005834@shell0.pdx.osdl.net>
Subject: [patch 167/198] IB/mthca: allow unaligned memory regions
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mst@mellanox.co.il,
       roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael S. Tsirkin <mst@mellanox.co.il>

The first buffer of a memory region is not required to be page-aligned, so
don't return an error if it's not.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_provider.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/infiniband/hw/mthca/mthca_provider.c~ib-mthca-allow-unaligned-memory-regions drivers/infiniband/hw/mthca/mthca_provider.c
--- 25/drivers/infiniband/hw/mthca/mthca_provider.c~ib-mthca-allow-unaligned-memory-regions	2005-04-12 03:21:43.262559992 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_provider.c	2005-04-12 03:21:43.265559536 -0700
@@ -494,7 +494,7 @@ static struct ib_mr *mthca_reg_phys_mr(s
 	mask = 0;
 	total_size = 0;
 	for (i = 0; i < num_phys_buf; ++i) {
-		if (buffer_list[i].addr & ~PAGE_MASK)
+		if (i != 0 && buffer_list[i].addr & ~PAGE_MASK)
 			return ERR_PTR(-EINVAL);
 		if (i != 0 && i != num_phys_buf - 1 &&
 		    (buffer_list[i].size & ~PAGE_MASK))
_
