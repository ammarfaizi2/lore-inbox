Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262936AbUB0SnC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbUB0Sju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:39:50 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:42406 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263097AbUB0Sj3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:39:29 -0500
Message-ID: <403F8F3A.70302@austin.ibm.com>
Date: Fri, 27 Feb 2004 12:40:58 -0600
From: Nathan Lynch <nathanl@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] [2.6.3-mm4] mm/slab.c warning in cache_alloc_debugcheck_after
Content-Type: multipart/mixed;
 boundary="------------090105060801050702070001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090105060801050702070001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

 From a ppc64 build:

   CC      mm/slab.o
mm/slab.c: In function `cache_alloc_debugcheck_after':
mm/slab.c:1976: warning: cast from pointer to integer of different size

Thanks,
Nathan

--------------090105060801050702070001
Content-Type: text/x-patch;
 name="cache_alloc_debugcheck_after.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cache_alloc_debugcheck_after.patch"

diff -urp linux-2.6.3-mm4/mm/slab.c linux-2.6.3-mm4.new/mm/slab.c
--- linux-2.6.3-mm4/mm/slab.c	2004-02-27 12:09:48.000000000 -0600
+++ linux-2.6.3-mm4.new/mm/slab.c	2004-02-27 12:26:09.000000000 -0600
@@ -1973,7 +1973,7 @@ cache_alloc_debugcheck_after(kmem_cache_
 		slabp = GET_PAGE_SLAB(virt_to_page(objp));
 
 		objnr = (objp - slabp->s_mem) / cachep->objsize;
-		slab_bufctl(slabp)[objnr] = (int)caller;
+		slab_bufctl(slabp)[objnr] = (unsigned long)caller;
 	}
 	objp += obj_dbghead(cachep);
 	if (cachep->ctor && cachep->flags & SLAB_POISON) {

--------------090105060801050702070001--
