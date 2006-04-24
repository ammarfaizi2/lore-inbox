Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWDXV2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWDXV2D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWDXVXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:23:47 -0400
Received: from mx.pathscale.com ([64.160.42.68]:35011 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751288AbWDXVXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:23:41 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 5 of 13] ipath - use proper address translation routine
X-Mercurial-Node: 1ab168913f0fea5d18b4fc339a43b30f09530b2e
Message-Id: <1ab168913f0fea5d18b4.1145913781@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1145913776@eng-12.pathscale.com>
Date: Mon, 24 Apr 2006 14:23:01 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move away from an obsolete, unportable routine for translating physical
addresses.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 8e724d49e74b -r 1ab168913f0f drivers/infiniband/hw/ipath/ipath_keys.c
--- a/drivers/infiniband/hw/ipath/ipath_keys.c	Wed Apr 19 15:24:36 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_keys.c	Wed Apr 19 15:24:36 2006 -0700
@@ -125,12 +125,12 @@ int ipath_lkey_ok(struct ipath_lkey_tabl
 
 	/*
 	 * We use LKEY == zero to mean a physical kmalloc() address.
-	 * This is a bit of a hack since we rely on dma_map_single()
-	 * being reversible by calling bus_to_virt().
+	 * This is a bit of a hack since we rely on being able to
+	 * reverse the mapping by calling phys_to_virt().
 	 */
 	if (sge->lkey == 0) {
 		isge->mr = NULL;
-		isge->vaddr = bus_to_virt(sge->addr);
+		isge->vaddr = phys_to_virt(sge->addr);
 		isge->length = sge->length;
 		isge->sge_length = sge->length;
 		ret = 1;
