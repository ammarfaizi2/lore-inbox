Return-Path: <linux-kernel-owner+w=401wt.eu-S965076AbXADSnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbXADSnQ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbXADSnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:43:16 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:41785 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965076AbXADSnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:43:15 -0500
Date: Thu, 4 Jan 2007 10:43:09 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix BUG_ON(!PageSlab) from fallback_alloc
In-Reply-To: <84144f020701041023g5910f40ej19a80905c9ed370@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0701041042020.21800@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0701041741490.16466@blonde.wat.veritas.com>
 <84144f020701041023g5910f40ej19a80905c9ed370@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007, Pekka Enberg wrote:

> So, how about we rename the current cache_grow() to __cache_grow() and
> move the kmem_freepages() to a higher level function like this:
> 
> static int cache_grow(struct kmem_cache *cache,
>                                gfp_t flags, int nodeid)
> {
>        void *objp;
>        int ret;
> 
>        if (flags & __GFP_NO_GROW)
>                return 0;
> 
>        objp = kmem_getpages(cachep, flags, nodeid);
>        if (!objp)
>                return 0;
> 
>        ret = __cache_grow(cache, flags, nodeid, objp);
>        if (!ret)
>                kmem_freepages(cachep, objp);
> 
>        return ret;
> }
> 
> And use the non-allocating __cache_grow version() in fallback_alloc() instead?

Good idea if you can make it so that it is clean. There is some 
additional processing in cache_grow() that would have to be taken into 
account.

