Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932630AbWFVTlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbWFVTlc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbWFVTlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:41:32 -0400
Received: from sbz-30.cs.helsinki.fi ([128.214.9.98]:26517 "EHLO
	sbz-30.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S932630AbWFVTlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:41:31 -0400
Date: Thu, 22 Jun 2006 22:41:29 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Christoph Lameter <clameter@sgi.com>
cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Theodore Tso <tytso@mit.edu>,
       Dave Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 4/4] Slab Reclaim logic
In-Reply-To: <20060619184712.23130.65271.sendpatchset@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0606222234400.5385@sbz-30.cs.Helsinki.FI>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
 <20060619184712.23130.65271.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006, Christoph Lameter wrote:
> Add kmem_cache_reclaim() function.
> 
> This patch adds the new slab reclaim functionalty. For that purpose we add a
> new function:
> 
> long kmem_cache_reclaim(struct kmem_cache *cache, unsigned long nr_pages)

Some coding style comments below.

> +extern long kmem_cache_reclaim(struct kmem_cache *, gfp_t flags, unsigned long);

The parameter name is redundant.

> +static int try_reclaim_one(kmem_cache_t *cachep, struct kmem_list3 *l3,
> +	struct list_head *list, unsigned short marker)

Please use struct kmem_cache instead of the typedef.  Better name for l3 
would be nice.

> +static int reclaim_scan(kmem_cache_t *cachep, struct kmem_list3 *l3,
> +	int slabs_to_free, struct list_head *list, unsigned short marker)

Ditto.

> +{
> +	int nr_freed = 0;

s/nr_freed/ret/

> +
> +	while (nr_freed < slabs_to_free) {
> +		int x;

s/x/nr_freed/

> +
> +		x = try_reclaim_one(cachep, l3, list, marker);
> +		if (x > 0)
> +			nr_freed += x;
> +		else
> +			break;
> +	}
> +	return nr_freed;
> +}

> +long kmem_cache_reclaim(kmem_cache_t *cachep, gfp_t flags, unsigned long pages)
> +{

Typedef.

