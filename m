Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWELX6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWELX6B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWELX5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:57:38 -0400
Received: from mx.pathscale.com ([64.160.42.68]:56745 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932211AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 21 of 53] ipath - use phys_to_virt instead of bus_to_virt
X-Mercurial-Node: 4e0a07d20868c6c4f0386f118daa3fcfc4000d2c
Message-Id: <4e0a07d20868c6c4f038.1147477386@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:06 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think Roland already has this patch.

diff -r 201654fe1962 -r 4e0a07d20868 drivers/infiniband/hw/ipath/ipath_keys.c
--- a/drivers/infiniband/hw/ipath/ipath_keys.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_keys.c	Fri May 12 15:55:28 2006 -0700
@@ -126,11 +126,11 @@ int ipath_lkey_ok(struct ipath_lkey_tabl
 	/*
 	 * We use LKEY == zero to mean a physical kmalloc() address.
 	 * This is a bit of a hack since we rely on dma_map_single()
-	 * being reversible by calling bus_to_virt().
+	 * being reversible by calling phys_to_virt().
 	 */
 	if (sge->lkey == 0) {
 		isge->mr = NULL;
-		isge->vaddr = bus_to_virt(sge->addr);
+		isge->vaddr = phys_to_virt(sge->addr);
 		isge->length = sge->length;
 		isge->sge_length = sge->length;
 		ret = 1;
