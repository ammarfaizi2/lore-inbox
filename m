Return-Path: <linux-kernel-owner+w=401wt.eu-S1750939AbWLNRDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWLNRDM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWLNRDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:03:12 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:39572 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750939AbWLNRDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:03:10 -0500
Date: Thu, 14 Dec 2006 09:03:00 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] slab: fix kmem_ptr_validate prototype
In-Reply-To: <1166099200.32332.233.camel@twins>
Message-ID: <Pine.LNX.4.64.0612140857240.29461@schroedinger.engr.sgi.com>
References: <1166099200.32332.233.camel@twins>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The declaration of kmem_ptr_validate in slab.h does not match the
one in slab.c. Remove the fastcall attribute (this is the only use in 
slab.c).

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6/mm/slab.c
===================================================================
--- linux-2.6.orig/mm/slab.c	2006-12-14 08:56:59.000000000 -0800
+++ linux-2.6/mm/slab.c	2006-12-14 08:57:10.000000000 -0800
@@ -3553,7 +3553,7 @@ EXPORT_SYMBOL(kmem_cache_zalloc);
  *
  * Currently only used for dentry validation.
  */
-int fastcall kmem_ptr_validate(struct kmem_cache *cachep, const void *ptr)
+int kmem_ptr_validate(struct kmem_cache *cachep, const void *ptr)
 {
 	unsigned long addr = (unsigned long)ptr;
 	unsigned long min_addr = PAGE_OFFSET;
