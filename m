Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWGLQjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWGLQjv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWGLQjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:39:51 -0400
Received: from [198.99.130.12] ([198.99.130.12]:4247 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751192AbWGLQju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:39:50 -0400
Message-Id: <200607121639.k6CGdiMw021221@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/5] UML - Fix ZONE_HIGHMEM compilation error
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 12 Jul 2006 12:39:43 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References to ZONE_HIGHMEM need to depend on CONFIG_HIGHMEM.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/mem.c	2006-07-12 11:29:02.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/mem.c	2006-07-12 11:29:11.000000000 -0400
@@ -226,7 +226,9 @@ void paging_init(void)
 	for(i=0;i<sizeof(zones_size)/sizeof(zones_size[0]);i++) 
 		zones_size[i] = 0;
 	zones_size[ZONE_DMA] = (end_iomem >> PAGE_SHIFT) - (uml_physmem >> PAGE_SHIFT);
+#ifdef CONFIG_HIGHMEM
 	zones_size[ZONE_HIGHMEM] = highmem >> PAGE_SHIFT;
+#endif
 	free_area_init(zones_size);
 
 	/*

