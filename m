Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262383AbVBLD0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbVBLD0Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 22:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbVBLD0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 22:26:16 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:24234 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262383AbVBLD0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 22:26:01 -0500
Date: Fri, 11 Feb 2005 19:25:48 -0800 (PST)
From: Ray Bryant <raybry@sgi.com>
To: Hirokazu Takahashi <taka@valinux.co.jp>, Hugh DIckins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       Marcello Tosatti <marcello@cyclades.com>
Cc: Ray Bryant <raybry@sgi.com>, Ray Bryant <raybry@austin.rr.com>,
       linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-Id: <20050212032548.18524.21094.13670@tomahawk.engr.sgi.com>
In-Reply-To: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
Subject: [RFC 2.6.11-rc2-mm2 2/7] mm: manual page migration -- cleanup 2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes some remaining Memory HOTPLUG specific code
from the page migration patch.  I have sent Dave Hansen the -R
version of this patch so that this code can be added back
later at the start of the Memory HOTPLUG patches themselves.

In particular, this patch removes some #ifdef CONFIG_MEMORY_HOTPLUG
code from the page migration patch.

Signed-off-by: Ray Bryant <raybry@sgi.com>

Index: linux-2.6.11-rc2-mm2/mm/vmalloc.c
===================================================================
--- linux-2.6.11-rc2-mm2.orig/mm/vmalloc.c	2005-02-11 10:08:10.000000000 -0800
+++ linux-2.6.11-rc2-mm2/mm/vmalloc.c	2005-02-11 10:35:47.000000000 -0800
@@ -523,16 +523,7 @@ EXPORT_SYMBOL(__vmalloc);
  */
 void *vmalloc(unsigned long size)
 {
-#ifdef CONFIG_MEMORY_HOTPLUG
-	/*
-	 * XXXX: This is temprary code, which should be replaced with proper one
-	 * 	 after the scheme to specify hot removable region has defined.
-	 *				25/Sep/2004	-- taka
-	 */
-       return __vmalloc(size, GFP_KERNEL, PAGE_KERNEL);
-#else
        return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL);
-#endif
 }
 
 EXPORT_SYMBOL(vmalloc);
Index: linux-2.6.11-rc2-mm2/mm/shmem.c
===================================================================
--- linux-2.6.11-rc2-mm2.orig/mm/shmem.c	2005-02-11 10:08:10.000000000 -0800
+++ linux-2.6.11-rc2-mm2/mm/shmem.c	2005-02-11 10:35:47.000000000 -0800
@@ -93,16 +93,7 @@ static inline struct page *shmem_dir_all
 	 * BLOCKS_PER_PAGE on indirect pages, assume PAGE_CACHE_SIZE:
 	 * might be reconsidered if it ever diverges from PAGE_SIZE.
 	 */
-#ifdef CONFIG_MEMORY_HOTPLUG
-	/*
-	 * XXXX: This is temprary code, which should be replaced with proper one
-	 * 	 after the scheme to specify hot removable region has defined.
-	 *				25/Sep/2004	-- taka
-	 */
-	return alloc_pages(gfp_mask & ~__GFP_HIGHMEM, PAGE_CACHE_SHIFT-PAGE_SHIFT);
-#else
 	return alloc_pages(gfp_mask, PAGE_CACHE_SHIFT-PAGE_SHIFT);
-#endif
 }
 
 static inline void shmem_dir_free(struct page *page)

-- 
Best Regards,
Ray
-----------------------------------------------
Ray Bryant                       raybry@sgi.com
The box said: "Requires Windows 98 or better",
           so I installed Linux.
-----------------------------------------------
