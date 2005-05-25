Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVEYUlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVEYUlb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 16:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVEYUlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 16:41:31 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:40606 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261187AbVEYUlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 16:41:25 -0400
Date: Wed, 25 May 2005 13:40:56 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy Version 11
Message-ID: <20050525204056.GA9257@w-mikek2.ibm.com>
References: <20050522200507.6ED7AECFC@skynet.csn.ul.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050522200507.6ED7AECFC@skynet.csn.ul.ie>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2005 at 09:05:07PM +0100, Mel Gorman wrote:
>  /*
> + * Calculate the size of the zone->usemap
> + */
> +static unsigned long __init usemap_size(unsigned long zonesize) {
> +	unsigned long usemapsize;
> +
> +	/* - Number of MAX_ORDER blocks in the zone */
> +	usemapsize = (zonesize + (1 << (MAX_ORDER-1))) >> (MAX_ORDER-1);
> +
> +	/* - BITS_PER_ALLOC_TYPE bits to record what type of block it is */
> +	usemapsize = (usemapsize * BITS_PER_ALLOC_TYPE + (sizeof(unsigned long)*8)) / 8;
> +
> +	return L1_CACHE_ALIGN(usemapsize);
> +}

In the first calculation, I think you are trying to 'round up'.  If this
is the case, then I believe the calculation should be:

usemapsize = (zonesize + ((1 << (MAX_ORDER-1)) - 1) >> (MAX_ORDER-1);

I don't know if there is a similar issue in the second calculation.
Arithmetic is not one of my strengths.

-- 
Mike
