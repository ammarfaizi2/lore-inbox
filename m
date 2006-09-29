Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161102AbWI2QLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161102AbWI2QLO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 12:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWI2QLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 12:11:14 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:40089 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161116AbWI2QLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 12:11:12 -0400
Date: Fri, 29 Sep 2006 09:10:55 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
cc: manfred@colorfullife.com, christoph@lameter.com, pj@sgi.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC/PATCH] slab: clean up allocation
In-Reply-To: <Pine.LNX.4.58.0609291353060.30021@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.64.0609290906350.23840@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0609291353060.30021@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006, Pekka J Enberg wrote:

> + * When allocating from current node.
> + */
> +#define SLAB_CURRENT_NODE (-1)
> +

If we want a constant here then we would better define a global one and 
use it throughout the kernel.

Something like

#define LOCAL_NODE (-1)

Maybe in include/*/topology.h ?


>  #endif
>  
> -static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
> +static inline void *cache_alloc_local(struct kmem_cache *cachep, gfp_t flags)
>  {
>  	void *objp;
>  	struct array_cache *ac;
> @@ -3059,35 +3064,6 @@ static inline void *____cache_alloc(stru
>  	return objp;
>  }

This is not really local in the sense of node local but its processor 
local. The speciality here is that we allocate from the per processor
list of objects. cache_alloc_cpu?

The rest looks fine on first glance.

