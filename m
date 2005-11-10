Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbVKJVuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVKJVuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 16:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbVKJVuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 16:50:00 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:10122 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932175AbVKJVt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 16:49:59 -0500
Date: Thu, 10 Nov 2005 13:49:50 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org, Pekka Enberg <penberg@gmail.com>, alokk@calsoftinc.com
Subject: [PATCH] Remove alloc_pages() use from slab allocator
Message-ID: <Pine.LNX.4.62.0511101347430.16380@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The slab allocator never uses alloc_pages since kmem_getpages() is always
called with a valid nodeid. Remove the branch and the code from kmem_getpages()

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-mm1/mm/slab.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/slab.c	2005-11-10 11:06:34.000000000 -0800
+++ linux-2.6.14-mm1/mm/slab.c	2005-11-10 11:41:15.000000000 -0800
@@ -1193,11 +1194,7 @@ static void *kmem_getpages(kmem_cache_t 
 	int i;
 
 	flags |= cachep->gfpflags;
-	if (likely(nodeid == -1)) {
-		page = alloc_pages(flags, cachep->gfporder);
-	} else {
-		page = alloc_pages_node(nodeid, flags, cachep->gfporder);
-	}
+	page = alloc_pages_node(nodeid, flags, cachep->gfporder);
 	if (!page)
 		return NULL;
 	addr = page_address(page);

