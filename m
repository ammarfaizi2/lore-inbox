Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422716AbWGJRWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422716AbWGJRWV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 13:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422717AbWGJRWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 13:22:21 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5809 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1422716AbWGJRWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 13:22:21 -0400
Date: Mon, 10 Jul 2006 10:22:14 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm1 oops on x86_64
In-Reply-To: <Pine.LNX.4.64.0607100851400.4491@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0607101018210.4931@schroedinger.engr.sgi.com>
References: <20060709021106.9310d4d1.akpm@osdl.org> <44B12C74.9090104@fr.ibm.com>
 <20060709132135.6c786cfb.akpm@osdl.org> <Pine.LNX.4.64.0607100851400.4491@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006, Christoph Lameter wrote:

> Hmm.. What this should be then is
> 
> VM_BUG_ON(gfp_flags & __GFP_WAIT

Wrong.

> +#ifdef CONFIG_HIGHMEM
>  	VM_BUG_ON((gfp_flags & (__GFP_WAIT | __GFP_HIGHMEM)) == __GFP_HIGHMEM);

> +#else
> +	VM_BUG_ON((gfp_flags & __GFP_WAIT);

We would have to drop these two. sigh.

> +#endif

Disregard the earlier stuff. Sigh.

Index: linux-2.6.17-mm6/mm/page_alloc.c
===================================================================
--- linux-2.6.17-mm6.orig/mm/page_alloc.c	2006-07-07 16:51:50.430063305 -0700
+++ linux-2.6.17-mm6/mm/page_alloc.c	2006-07-10 10:21:32.507743432 -0700
@@ -255,7 +255,9 @@ static inline void prep_zero_page(struct
 {
 	int i;
 
+#ifdef CONFIG_HIGHMEM
 	VM_BUG_ON((gfp_flags & (__GFP_WAIT | __GFP_HIGHMEM)) == __GFP_HIGHMEM);
+#endif
 	/*
 	 * clear_highpage() will use KM_USER0, so it's a bug to use __GFP_ZERO
 	 * and __GFP_HIGHMEM from hard or soft interrupt context.
