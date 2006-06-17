Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWFQQjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWFQQjE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 12:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWFQQjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 12:39:03 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:27271 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750720AbWFQQjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 12:39:01 -0400
Date: Sat, 17 Jun 2006 09:38:51 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 2/2] slab: consolidate allocation paths
In-Reply-To: <1150355565.4633.8.camel@ubuntu>
Message-ID: <Pine.LNX.4.64.0606170936570.18882@schroedinger.engr.sgi.com>
References: <1150355565.4633.8.camel@ubuntu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2006, Pekka Enberg wrote:

> -static inline void *cache_alloc_cpucache(struct kmem_cache *cache, gfp_t flags)
> +static inline void *__cache_alloc(struct kmem_cache *cache, gfp_t flags,
> +				  int nodeid)
>  {
> +	if (nodeid != -1 && nodeid != numa_node_id() &&
> +	    cache->nodelists[nodeid])
> +		return __cache_alloc_node(cache, flags, nodeid);
> +
>  	if (unlikely(current->flags & (PF_SPREAD_SLAB | PF_MEMPOLICY))) {
>  		void *objp = alternate_node_alloc(cache, flags);

So we always run through the additional code that you added for each 
allocation on a numa system? The case of nodeid != -1 is a rare case.

