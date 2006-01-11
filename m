Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932569AbWAKDWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbWAKDWW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 22:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWAKDWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 22:22:21 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:9163 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932569AbWAKDWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 22:22:21 -0500
Date: Tue, 10 Jan 2006 19:22:08 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       Paul Jackson <pj@sgi.com>, Christoph Lameter <clameter@sgi.com>
Message-Id: <20060111032208.12172.35790.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH v2] mm gfp_atomic comments
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Clarify in comments that GFP_ATOMIC means both "don't sleep" and "use
emergency pools", hence both ALLOC_HARDER and ALLOC_HIGH.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

This is the same patch that Andrew tried sending to Linus
on Jan 6, 2006, except that it has been fixed to refer to
ALLOC_HARDER and ALLOC_HIGH, instead of the other ALLOC_DIP_*
terms that were rejected.

 include/linux/gfp.h |    1 +
 mm/page_alloc.c     |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- 2.6.15-mm2.orig/include/linux/gfp.h	2006-01-10 13:39:35.831271898 -0800
+++ 2.6.15-mm2/include/linux/gfp.h	2006-01-10 13:59:44.175302966 -0800
@@ -57,6 +57,7 @@ struct vm_area_struct;
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
 			__GFP_NOMEMALLOC|__GFP_HARDWALL)
 
+/* GFP_ATOMIC means both !wait (__GFP_WAIT not set) and use emergency pool */
 #define GFP_ATOMIC	(__GFP_HIGH)
 #define GFP_NOIO	(__GFP_WAIT)
 #define GFP_NOFS	(__GFP_WAIT | __GFP_IO)
--- 2.6.15-mm2.orig/mm/page_alloc.c	2006-01-10 13:41:57.345486682 -0800
+++ 2.6.15-mm2/mm/page_alloc.c	2006-01-10 14:07:44.845490827 -0800
@@ -998,7 +998,8 @@ restart:
 	 *
 	 * The caller may dip into page reserves a bit more if the caller
 	 * cannot run direct reclaim, or if the caller has realtime scheduling
-	 * policy.
+	 * policy or is asking for __GFP_HIGH memory.  GFP_ATOMIC requests will
+	 * set both ALLOC_HARDER (!wait) and ALLOC_HIGH (__GFP_HIGH).
 	 */
 	alloc_flags = ALLOC_WMARK_MIN;
 	if ((unlikely(rt_task(p)) && !in_interrupt()) || !wait)

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
