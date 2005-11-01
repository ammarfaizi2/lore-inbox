Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbVKAUc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbVKAUc6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbVKAUc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:32:57 -0500
Received: from host175-37.pool8253.interbusiness.it ([82.53.37.175]:51368 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1751167AbVKAUc5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:32:57 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH] uml: fix hardcoded ZONE_* constants in zone setup
Date: Tue, 01 Nov 2005 21:37:21 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051101203721.26156.11021.stgit@zion.home.lan>
In-Reply-To: <20051101170633.GB6448@ccure.user-mode-linux.org>
References: <20051101170633.GB6448@ccure.user-mode-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Remove usage of hardcoded constants in paging_init().

By chance I spotted a bug in zones_setup involving a change to ZONE_* constants,
due to the ZONE_DMA32 patch from Andi Kleen (which is in -mm). So, possibly,
instead of zones_size[2] you will find zones_size[3] in the code, but that
change is wrong and this patch is still correct.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/mem.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -234,8 +234,8 @@ void paging_init(void)
 	empty_bad_page = (unsigned long *) alloc_bootmem_low_pages(PAGE_SIZE);
 	for(i=0;i<sizeof(zones_size)/sizeof(zones_size[0]);i++) 
 		zones_size[i] = 0;
-	zones_size[0] = (end_iomem >> PAGE_SHIFT) - (uml_physmem >> PAGE_SHIFT);
-	zones_size[2] = highmem >> PAGE_SHIFT;
+	zones_size[ZONE_DMA] = (end_iomem >> PAGE_SHIFT) - (uml_physmem >> PAGE_SHIFT);
+	zones_size[ZONE_HIGHMEM] = highmem >> PAGE_SHIFT;
 	free_area_init(zones_size);
 
 	/*

