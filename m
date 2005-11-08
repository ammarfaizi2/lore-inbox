Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbVKHA63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbVKHA63 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 19:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbVKHA62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 19:58:28 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:51884 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964977AbVKHA61
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 19:58:27 -0500
Message-ID: <436FF82E.1050004@us.ibm.com>
Date: Mon, 07 Nov 2005 16:58:22 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel-janitors@lists.osdl.org
CC: Pekka J Enberg <penberg@cs.Helsinki.FI>, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] Cleanup set_slab_attr()
References: <436FF51D.8080509@us.ibm.com>
In-Reply-To: <436FF51D.8080509@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------030909090309050809020606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030909090309050809020606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Cleanup a loop in set_slab_attr().

mcd@arrakis:~/linux/source/linux-2.6.14+slab_cleanup/patches $ diffstat
set_slab_attr.patch
 slab.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

-Matt

--------------030909090309050809020606
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

Index: linux-2.6.14+slab_cleanup/mm/slab.c
===================================================================
--- linux-2.6.14+slab_cleanup.orig/mm/slab.c	2005-11-07 16:00:09.005539608 -0800
+++ linux-2.6.14+slab_cleanup/mm/slab.c	2005-11-07 16:07:59.169063888 -0800
@@ -2141,11 +2141,11 @@ static void set_slab_attr(kmem_cache_t *
 
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

--------------030909090309050809020606--
