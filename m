Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263304AbSJCO7w>; Thu, 3 Oct 2002 10:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263305AbSJCO7w>; Thu, 3 Oct 2002 10:59:52 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:40460 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263304AbSJCO7t>; Thu, 3 Oct 2002 10:59:49 -0400
Date: Thu, 3 Oct 2002 16:05:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kevin Corry <corryk@us.ibm.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Subject: Re: [PATCH] EVMS core 4/4: evms_biosplit.h
Message-ID: <20021003160507.A20553@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kevin Corry <corryk@us.ibm.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <02100307382404.05904@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <02100307382404.05904@boiler>; from corryk@us.ibm.com on Thu, Oct 03, 2002 at 07:38:24AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static mempool_t *my_bio_split_pool, *my_bio_pool;
> +static kmem_cache_t *my_bio_split_slab, *my_bio_pool_slab;

Umm, static variables in header files?

> +
> +/**
> + * slab_pool_alloc
> + * @gfp_mask:	GFP allocation flag
> + * @data:	mempool prototype required fields
> + *
> + * mempool allocate function
> + **/
> +static void *
> +slab_pool_alloc(int gfp_mask, void *data)
> +{
> +	return kmem_cache_alloc(data, gfp_mask);
> +}
> +
> +/**
> + * slab_pool_free
> + * @ptr:	mempool prototype required fields
> + * @data:	mempool prototype required fields
> + *
> + * mempool free function
> + **/
> +static void
> +slab_pool_free(void *ptr, void *data)
> +{
> +	kmem_cache_free(data, ptr);
> +}

I think these two could go to slab.c instead.

> +	if (!my_bio_split_slab) {
> +		panic("unable to create EVMS Bio Split cache.");

What about graceful error handling?

All in all I think this should rather be a source file, I can't
see anything EVMS-specific either.
