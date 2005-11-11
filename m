Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbVKKAH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVKKAH3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 19:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbVKKAH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 19:07:29 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:19904 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932178AbVKKAH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 19:07:28 -0500
Message-ID: <4373E0BD.7020709@us.ibm.com>
Date: Thu, 10 Nov 2005 16:07:25 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel-janitors@lists.osdl.org
CC: manfred@colorfullife.com, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] Cleanup a loop in set_slab_attr()
References: <4373DD82.8010606@us.ibm.com>
In-Reply-To: <4373DD82.8010606@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------050707040201070202090208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050707040201070202090208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Last, but not least, fix a loop in set_slab_attr() to match the rest of the
functionally similar loops in mm/slab.c.

-Matt

--------------050707040201070202090208
Content-Type: text/x-patch;
 name="set_slab_attr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="set_slab_attr.patch"

Change the
	do { ... } while (--i);
loop in set_slab_attr to a
	while (i--) { ... }
loop like the rest of the functions that do similar loops in mm/slab.c.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

Index: linux-2.6.14+slab_cleanup/mm/slab.c
===================================================================
--- linux-2.6.14+slab_cleanup.orig/mm/slab.c	2005-11-10 11:49:19.028840752 -0800
+++ linux-2.6.14+slab_cleanup/mm/slab.c	2005-11-10 11:49:21.636444336 -0800
@@ -2157,11 +2157,11 @@ static void set_slab_attr(kmem_cache_t *
 
 	i = 1 << cachep->gfporder;
 	page = virt_to_page(objp);
-	do {
+	while (i--) {
 		SET_PAGE_CACHE(page, cachep);
 		SET_PAGE_SLAB(page, slabp);
 		page++;
-	} while (--i);
+	}
 }
 
 /*

--------------050707040201070202090208--
