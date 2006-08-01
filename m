Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWHAQSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWHAQSn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 12:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWHAQSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 12:18:43 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:26297 "EHLO
	several.ru") by vger.kernel.org with ESMTP id S1750802AbWHAQSn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 12:18:43 -0400
Date: Wed, 2 Aug 2006 00:42:02 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Nick Piggin <npiggin@suse.de>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/2] mm: speculative get_page
Message-ID: <20060801204202.GA223@oleg>
References: <20060801193203.GA191@oleg> <1154447729.10401.16.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154447729.10401.16.camel@kleikamp.austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01, Dave Kleikamp wrote:
>
> On Tue, 2006-08-01 at 23:32 +0400, Oleg Nesterov wrote:
> > Nick Piggin wrote:
> > >
> > > --- linux-2.6.orig/mm/vmscan.c
> > > +++ linux-2.6/mm/vmscan.c
> > > @@ -380,6 +380,8 @@ int remove_mapping(struct address_space 
> > >  	if (!mapping)
> > >  		return 0;		/* truncate got there first */
> > >
> > > +	SetPageNoNewRefs(page);
> > > +	smp_wmb();
> > >  	write_lock_irq(&mapping->tree_lock);
> > >
> > 
> > Is it enough?
> > 
> > PG_nonewrefs could be already set by another add_to_page_cache()/remove_mapping(),
> > and it will be cleared when we take ->tree_lock.
> 
> Isn't the page locked when calling remove_mapping()?  It looks like
> SetPageNoNewRefs & ClearPageNoNewRefs are called in safe places.  Either
> the page is locked, or it's newly allocated.  I could have missed
> something, though.

No, I think it is I who missed something, thanks.

Oleg.

