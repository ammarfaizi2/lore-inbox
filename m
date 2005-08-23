Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbVHWVyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbVHWVyx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVHWVmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:42:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56757 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932414AbVHWVmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:42:32 -0400
To: torvalds@osdl.org
Subject: [PATCH] (10/43) Kconfig fix (DEBUG_PAGEALLOC on m32r)
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Message-Id: <E1E7gaO-00079Z-9h@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:45:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DEBUG_PAGEALLOC is broken on m32r - the option had been blindly copied from
i386; kernel_map_pages() had not and that's what is needed for DEBUG_PAGEALLOC
to work (or link, while we are at it).

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-m32r-pci/arch/m32r/Kconfig.debug RC13-rc6-git13-m32r-pagealloc/arch/m32r/Kconfig.debug
--- RC13-rc6-git13-m32r-pci/arch/m32r/Kconfig.debug	2005-08-10 10:37:46.000000000 -0400
+++ RC13-rc6-git13-m32r-pagealloc/arch/m32r/Kconfig.debug	2005-08-21 13:16:53.000000000 -0400
@@ -20,7 +20,7 @@
 
 config DEBUG_PAGEALLOC
 	bool "Page alloc debugging"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && BROKEN
 	help
 	  Unmap pages from the kernel linear mapping after free_pages().
 	  This results in a large slowdown, but helps to find certain types
