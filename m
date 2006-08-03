Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWHCHTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWHCHTj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 03:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWHCHTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 03:19:39 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:7445 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP id S932356AbWHCHTi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 03:19:38 -0400
Date: Thu, 3 Aug 2006 10:19:35 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Jon Mason <jdmason@us.ibm.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH 2 of 4] [x86-64] Calgary: only verify the allocation bitmap if CONFIG_IOMMU_DEBUG is on
Message-ID: <20060803071935.GB4736@rhun.haifa.ibm.com>
References: <patchbomb.1154559547@rhun.haifa.ibm.com> <515131a26b151f1e4596.1154559549@rhun.haifa.ibm.com> <20060803035723.GA7323@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803035723.GA7323@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 10:57:24PM -0500, Jon Mason wrote:

> > diff -r 9cd758467ce1 -r 515131a26b15 arch/x86_64/kernel/pci-calgary.c
> > --- a/arch/x86_64/kernel/pci-calgary.c	Thu Aug 03 01:37:12 2006 +0300
> > +++ b/arch/x86_64/kernel/pci-calgary.c	Thu Aug 03 01:40:21 2006 +0300
> > @@ -133,12 +133,35 @@ static inline void tce_cache_blast_stres
> >  {
> >  	tce_cache_blast(tbl);
> >  }
> > +
> > +static inline unsigned long verify_bit_range(unsigned long* bitmap,
> > +	int expected, unsigned long start, unsigned long end)
> > +{
> > +	unsigned long idx = start;
> > +
> > +	BUG_ON(start > end);
> 
> This should be ">=".

I considered both options and decided that since this is debug code,
we might as well be permissive and not trip when start == end (because
I'm not 100% sure we never do it). However since it could arguably be
masking a real bug if we do, I agree with the change.

Cheers,
Muli
