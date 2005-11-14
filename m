Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbVKNEEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbVKNEEr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 23:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbVKNEEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 23:04:47 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:20685 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750893AbVKNEEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 23:04:25 -0500
Date: Sun, 13 Nov 2005 20:04:15 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Simon Derr <Simon.Derr@bull.net>, Christoph Lameter <clameter@sgi.com>,
       "Rohit, Seth" <rohit.seth@intel.com>, Paul Jackson <pj@sgi.com>
Message-Id: <20051114040415.13951.86293.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051114040329.13951.39891.sendpatchset@jackhammer.engr.sgi.com>
References: <20051114040329.13951.39891.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 05/05] mm GFP_ATOMIC comment
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify in comments that GFP_ATOMIC means both "don't sleep"
and "use emergency pools", hence both ALLOC_DIP_ALOT and
ALLOC_DIP_SOME.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 include/linux/gfp.h |    1 +
 mm/page_alloc.c     |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- 2.6.14-mm2.orig/include/linux/gfp.h	2005-11-13 09:57:03.317369370 -0800
+++ 2.6.14-mm2/include/linux/gfp.h	2005-11-13 10:31:05.590802684 -0800
@@ -58,6 +58,7 @@ struct vm_area_struct;
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
 			__GFP_NOMEMALLOC|__GFP_HARDWALL)
 
+/* GFP_ATOMIC means both !wait (__GFP_WAIT not set) and use emergency pool */
 #define GFP_ATOMIC	(__GFP_VALID | __GFP_HIGH)
 #define GFP_NOIO	(__GFP_VALID | __GFP_WAIT)
 #define GFP_NOFS	(__GFP_VALID | __GFP_WAIT | __GFP_IO)
--- 2.6.14-mm2.orig/mm/page_alloc.c	2005-11-13 10:21:13.804965981 -0800
+++ 2.6.14-mm2/mm/page_alloc.c	2005-11-13 10:32:33.090792563 -0800
@@ -926,7 +926,8 @@ restart:
 	 *
 	 * The caller may dip into page reserves a bit more if the caller
 	 * cannot run direct reclaim, or if the caller has realtime scheduling
-	 * policy or is asking for __GFP_HIGH memory.
+	 * policy or is asking for __GFP_HIGH memory.  GFP_ATOMIC requests will
+	 * set both ALLOC_DIP_ALOT (!wait) and ALLOC_DIP_SOME (__GFP_HIGH).
 	 */
 	alloc_flags = 0;
 	if ((unlikely(rt_task(p)) && !in_interrupt()) || !wait)

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
