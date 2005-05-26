Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVEZMm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVEZMm5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 08:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVEZMm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 08:42:57 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:47015 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261359AbVEZMmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 08:42:51 -0400
Date: Thu, 26 May 2005 13:42:50 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy Version
 11
In-Reply-To: <20050525204056.GA9257@w-mikek2.ibm.com>
Message-ID: <Pine.LNX.4.58.0505261335500.15422@skynet>
References: <20050522200507.6ED7AECFC@skynet.csn.ul.ie>
 <20050525204056.GA9257@w-mikek2.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2005, Mike Kravetz wrote:

> On Sun, May 22, 2005 at 09:05:07PM +0100, Mel Gorman wrote:
> >  /*
> > + * Calculate the size of the zone->usemap
> > + */
> > +static unsigned long __init usemap_size(unsigned long zonesize) {
> > +	unsigned long usemapsize;
> > +
> > +	/* - Number of MAX_ORDER blocks in the zone */
> > +	usemapsize = (zonesize + (1 << (MAX_ORDER-1))) >> (MAX_ORDER-1);
> > +
> > +	/* - BITS_PER_ALLOC_TYPE bits to record what type of block it is */
> > +	usemapsize = (usemapsize * BITS_PER_ALLOC_TYPE + (sizeof(unsigned long)*8)) / 8;
> > +
> > +	return L1_CACHE_ALIGN(usemapsize);
> > +}
>
> In the first calculation, I think you are trying to 'round up'.  If this
> is the case, then I believe the calculation should be:
>
> usemapsize = (zonesize + ((1 << (MAX_ORDER-1)) - 1) >> (MAX_ORDER-1);
>

You're right. This excessively large calculation is left-over from a Magic
Bug That Wouldn't Go Away at the time. I thought I might be overflowing
the usemap (even though I couldn't be but I was desperate for explanations
at the time). The second calculation does not need "+ sizeof(unsigned
long)"

This wastes a few bytes but should not cause problems. I'll fix it and
release a version against -rc5 on Monday (The delay is because I don't
have access to a test environment right now)

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
