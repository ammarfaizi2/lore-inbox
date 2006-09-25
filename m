Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWIYSg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWIYSg1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 14:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWIYSg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 14:36:27 -0400
Received: from [198.99.130.12] ([198.99.130.12]:53396 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751448AbWIYSgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 14:36:03 -0400
Message-Id: <200609251834.k8PIYU2o005026@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/8] UML - Get rid of ZONE_DMA use
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 25 Sep 2006 14:34:30 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ZONE_DMA is now dependent on CONFIG_ZONE_DMA, which UML doesn't define.
So, let's change ZONE_DMA to ZONE_NORMAL.

This is prompted by optional-zone_dma-in-the-vm.patch, but should be harmless
on its own.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/mem.c	2006-09-22 13:17:47.000000000 -0400
+++ linux-2.6.18-mm/arch/um/kernel/mem.c	2006-09-22 13:18:11.000000000 -0400
@@ -226,7 +226,8 @@ void paging_init(void)
 	for(i = 0; i < ARRAY_SIZE(zones_size); i++)
 		zones_size[i] = 0;
 
-	zones_size[ZONE_DMA] = (end_iomem >> PAGE_SHIFT) - (uml_physmem >> PAGE_SHIFT);
+	zones_size[ZONE_NORMAL] = (end_iomem >> PAGE_SHIFT) -
+		(uml_physmem >> PAGE_SHIFT);
 #ifdef CONFIG_HIGHMEM
 	zones_size[ZONE_HIGHMEM] = highmem >> PAGE_SHIFT;
 #endif

