Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030562AbWHIHBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030562AbWHIHBJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 03:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030558AbWHIHBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 03:01:08 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:49702 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S965091AbWHIHBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 03:01:07 -0400
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Daniel Phillips <phillips@google.com>
Cc: David Miller <davem@davemloft.net>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <44D97645.90104@google.com>
References: <20060808193345.1396.16773.sendpatchset@lappy>
	 <20060808.151020.94555184.davem@davemloft.net>
	 <44D93BEE.4000001@google.com>
	 <20060808.184144.71088399.davem@davemloft.net>  <44D97645.90104@google.com>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 09:00:19 +0200
Message-Id: <1155106820.23134.37.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 22:44 -0700, Daniel Phillips wrote:
> David Miller wrote:
> >From: Daniel Phillips <phillips@google.com>
> >>David Miller wrote:
> >>>I think the new atomic operation that will seemingly occur on every
> >>>device SKB free is unacceptable.
> >>
> >>Alternate suggestion?
> > 
> > Sorry, I have none.  But you're unlikely to get your changes
> > considered seriously unless you can avoid any new overhead your patch
> > has which is of this level.
> 
> We just skip anything new unless the socket is actively carrying block
> IO traffic, in which case we pay a miniscule price to avoid severe
> performance artifacts or in the worst case, deadlock.  So in this design
> the new atomic operation does not occur on every device SKP free.
> 
> All atomic ops sit behind the cheap test:
> 
>     (dev->flags & IFF_MEMALLOC)
> 
> or if any have escaped that is just an oversight.   Peter?

That should be so indeed. Except on the allocation path ofcourse, there
it only occurs when the first allocation fails.

> > We're busy trying to make these data structures smaller, and eliminate
> > atomic operations, as much as possible.  Therefore anything which adds
> > new datastructure elements and new atomic operations will be met with
> > fierce resistence unless it results an equal or greater shrink of
> > datastructures elsewhere or removes atomic operations elsewhere in
> > the critical path.
> 
> Right now we have a problem because our network stack cannot support
> block IO reliably.  Without that, Linux is no enterprise storage
> platform.

Indeed, surely not all wanted new features come with zero cost. If its a
hard condition that all new features remove data and operations progress
is going to be challenging.

