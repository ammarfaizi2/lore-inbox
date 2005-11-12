Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbVKLAnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbVKLAnn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 19:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVKLAnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 19:43:43 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:6299 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750813AbVKLAnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 19:43:42 -0500
Date: Fri, 11 Nov 2005 16:43:22 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: Martin Hicks <mort@sgi.com>, Ray Bryant <raybry@mpdtxmail.amd.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Christoph Lameter <clameter@sgi.com>,
       "Rohit, Seth" <rohit.seth@intel.com>, Paul Jackson <pj@sgi.com>,
       Andi Kleen <ak@suse.de>
Message-Id: <20051112004322.30442.14753.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] mm gfp_noreclaim cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove last remnant of the defunct early reclaim page logic,
the no longer used __GFP_NORECLAIM flag bit.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 include/linux/gfp.h     |    5 ++---
 include/linux/pagemap.h |    4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

--- 2.6.14-mm2.orig/include/linux/gfp.h	2005-11-10 21:27:25.788622408 -0800
+++ 2.6.14-mm2/include/linux/gfp.h	2005-11-11 15:21:43.780529152 -0800
@@ -46,8 +46,7 @@ struct vm_area_struct;
 #define __GFP_COMP	((__force gfp_t)0x4000u)/* Add compound page metadata */
 #define __GFP_ZERO	((__force gfp_t)0x8000u)/* Return zeroed page on success */
 #define __GFP_NOMEMALLOC ((__force gfp_t)0x10000u) /* Don't use emergency reserves */
-#define __GFP_NORECLAIM  ((__force gfp_t)0x20000u) /* No realy zone reclaim during allocation */
-#define __GFP_HARDWALL   ((__force gfp_t)0x40000u) /* Enforce hardwall cpuset memory allocs */
+#define __GFP_HARDWALL   ((__force gfp_t)0x20000u) /* Enforce hardwall cpuset memory allocs */
 #define __GFP_VALID	((__force gfp_t)0x80000000u) /* valid GFP flags */
 
 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
@@ -57,7 +56,7 @@ struct vm_area_struct;
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
-			__GFP_NOMEMALLOC|__GFP_NORECLAIM|__GFP_HARDWALL)
+			__GFP_NOMEMALLOC|__GFP_HARDWALL)
 
 #define GFP_ATOMIC	(__GFP_VALID | __GFP_HIGH)
 #define GFP_NOIO	(__GFP_VALID | __GFP_WAIT)
--- 2.6.14-mm2.orig/include/linux/pagemap.h	2005-11-10 21:27:07.994469549 -0800
+++ 2.6.14-mm2/include/linux/pagemap.h	2005-11-11 15:24:00.719478936 -0800
@@ -53,12 +53,12 @@ void release_pages(struct page **pages, 
 
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
-	return alloc_pages(mapping_gfp_mask(x)|__GFP_NORECLAIM, 0);
+	return alloc_pages(mapping_gfp_mask(x), 0);
 }
 
 static inline struct page *page_cache_alloc_cold(struct address_space *x)
 {
-	return alloc_pages(mapping_gfp_mask(x)|__GFP_COLD|__GFP_NORECLAIM, 0);
+	return alloc_pages(mapping_gfp_mask(x)|__GFP_COLD, 0);
 }
 
 typedef int filler_t(void *, struct page *);

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
