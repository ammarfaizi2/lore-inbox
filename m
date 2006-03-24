Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWCXSSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWCXSSC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWCXSNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:13:34 -0500
Received: from [198.99.130.12] ([198.99.130.12]:37782 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751144AbWCXSNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:13:30 -0500
Message-Id: <200603241814.k2OIEaZw005510@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 3/16] UML - Fix some printf formats
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Mar 2006 13:14:36 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some printf formats are incorrect for large memory sizes.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/um_arch.c	2006-02-21 17:40:12.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/um_arch.c	2006-02-21 17:59:39.000000000 -0500
@@ -421,7 +421,7 @@ int linux_main(int argc, char **argv)
 #ifndef CONFIG_HIGHMEM
 		highmem = 0;
 		printf("CONFIG_HIGHMEM not enabled - physical memory shrunk "
-		       "to %lu bytes\n", physmem_size);
+		       "to %Lu bytes\n", physmem_size);
 #endif
 	}
 
@@ -433,8 +433,8 @@ int linux_main(int argc, char **argv)
 
 	setup_physmem(uml_physmem, uml_reserved, physmem_size, highmem);
 	if(init_maps(physmem_size, iomem_size, highmem)){
-		printf("Failed to allocate mem_map for %lu bytes of physical "
-		       "memory and %lu bytes of highmem\n", physmem_size,
+		printf("Failed to allocate mem_map for %Lu bytes of physical "
+		       "memory and %Lu bytes of highmem\n", physmem_size,
 		       highmem);
 		exit(1);
 	}

