Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314512AbSDSATY>; Thu, 18 Apr 2002 20:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314513AbSDSATX>; Thu, 18 Apr 2002 20:19:23 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:2743 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314512AbSDSATW>;
	Thu, 18 Apr 2002 20:19:22 -0400
Date: Thu, 18 Apr 2002 18:17:47 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Mel <mel@csn.ul.ie>, linux-kernel@vger.kernel.org
Subject: Re: page_alloc.c comments patch v2
Message-ID: <1937110000.1019179067@flay>
In-Reply-To: <Pine.LNX.4.44.0204182332500.5700-100000@skynet>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, nice idea to actually comment the code ;-)

Re: __alloc_pages

> + * @zonelist: The preferred zone to allocate from

Zonelist is not a zone, it's a list of zones suitable for the given 
zonemask on that pg_data_t in order of preference. Maybe I'm
just misreading your syntax.

> +	/* Cycle through all the zones available */
>  	for (;;) {
>  		zone_t *z = *(zone++);
>  		if (!z)
>  			break;
> 
> +		/* Increase min by pages_low so that too many pages from a zone
> +		 * are not allocated. If pages_low is reached, kswapd needs to
> +		 * begin work
> +		 *
> +		 * QUERY: If there was more than one zone in ZONE_NORMAL and
> +		 *        each zone had a pages_low value of 10, wouldn't the
> +		 *        second zone have a min value of 20, the third of 30
> +		 *        and so on? Wouldn't this possibly wake kswapd before
> +		 *        it was really needed? Is this the expected behaviour?

I don't see how there could be "more that one zone in ZONE_NORMAL"?
There can only be one ZONE_NORMAL per pgdata_t. 

Look at build_zonelists to see how the fallback lists (zonelist) are built
up. 
There's one zonelist for each possible zonemask. Depending on the mask
we add one of:

1) ZONE_HIGHMEM, ZONE_NORMAL and ZONE_DMA
2) ZONE_NORMAL and ZONE_DMA
3) ZONE_DMA.

So there's no way there could be two ZONE_NORMAL's in a list, 
or that ZONE_NORMAL for that pgdat could be added twice.

M.
