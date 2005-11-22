Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbVKVG5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVKVG5S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 01:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbVKVG5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 01:57:17 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:2196 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932106AbVKVG5R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 01:57:17 -0500
Date: Tue, 22 Nov 2005 08:57:13 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Christoph Lameter <clameter@engr.sgi.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       Joe Perches <joe@perches.com>
Subject: Re: [PATCH] slab: minor cleanup to kmem_cache_alloc_node
In-Reply-To: <Pine.LNX.4.62.0511211314560.10768@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0511220856140.14208@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0511211627460.18869@sbz-30.cs.Helsinki.FI> 
 <Pine.LNX.4.62.0511210919001.6497@graphe.net>  <1132598194.8972.4.camel@localhost>
  <Pine.LNX.4.62.0511211145500.7813@schroedinger.engr.sgi.com>
 <1132607272.19332.7.camel@localhost> <Pine.LNX.4.62.0511211314560.10768@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005, Christoph Lameter wrote:
> If we drop the printk then this may be even simpler
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>

Even better. Thanks!

Acked-by: Pekka Enberg <penberg@cs.helsinki.fi>

> Index: linux-2.6.15-rc1-mm2/mm/slab.c
> ===================================================================
> --- linux-2.6.15-rc1-mm2.orig/mm/slab.c	2005-11-21 13:16:07.000000000 -0800
> +++ linux-2.6.15-rc1-mm2/mm/slab.c	2005-11-21 13:16:59.000000000 -0800
> @@ -2890,21 +2890,14 @@ void *kmem_cache_alloc_node(kmem_cache_t
>  	unsigned long save_flags;
>  	void *ptr;
>  
> -	if (nodeid == -1)
> -		return __cache_alloc(cachep, flags);
> -
> -	if (unlikely(!cachep->nodelists[nodeid])) {
> -		/* Fall back to __cache_alloc if we run into trouble */
> -		printk(KERN_WARNING "slab: not allocating in inactive node %d for cache %s\n", nodeid, cachep->name);
> -		return __cache_alloc(cachep,flags);
> -	}
> -
>  	cache_alloc_debugcheck_before(cachep, flags);
>  	local_irq_save(save_flags);
> -	if (nodeid == numa_node_id())
> +
> +	if (nodeid == -1 || nodeid == numa_node_id() || !cachep->nodelists[nodeid])
>  		ptr = ____cache_alloc(cachep, flags);
>  	else
>  		ptr = __cache_alloc_node(cachep, flags, nodeid);
> +
>  	local_irq_restore(save_flags);
>  	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, __builtin_return_address(0));
>  
> 
