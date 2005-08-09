Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbVHILXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbVHILXv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 07:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbVHILXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 07:23:51 -0400
Received: from silver.veritas.com ([143.127.12.111]:53326 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932518AbVHILXu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 07:23:50 -0400
Date: Tue, 9 Aug 2005 12:25:36 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Daniel Phillips <phillips@arcor.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
In-Reply-To: <1123577509.30257.173.camel@gaston>
Message-ID: <Pine.LNX.4.61.0508091215490.11660@goblin.wat.veritas.com>
References: <42F57FCA.9040805@yahoo.com.au>  <200508090710.00637.phillips@arcor.de>
  <42F7F5AE.6070403@yahoo.com.au> <1123577509.30257.173.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Aug 2005 11:23:50.0463 (UTC) FILETIME=[D1134CF0:01C59CD4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2005, Benjamin Herrenschmidt wrote:
> > 
> > What we don't have is something to indicate the page does not point
> > to valid ram.
> 
> I have no problem keeping PG_reserved for that, and _ONLY_ for that.

Yes, if a table won't suffice.

> (though i'd rather see it renamed then).

Definitely.

> I'm just afraid by doing so,
> some drivers will jump in the gap and abuse it again...

I don't think that was abuse, it was just playing by the silly rules
remap_pfn_range and ioremap demanded.

> Also, we should
> make sure we kill the "trick" of refcounting only in one direction.

Very hard to find anyone to disagree with you on that!

> Either we refcount both (but do nothing, or maybe just BUG_ON if the
> page is "reserved" -> not valid RAM), or we don't refcount at all.

We do what's most efficient for the core.  Which I think is refcount
both ways regardless, since these "page"s are exceptional, and the
majority really do need refcounting.

> For things like Cell, We'll really end up needing struct page covering
> the SPUs for example. That is not valid RAM, shouldn't be refcounted,

But you don't mind if they are refcounted, do you?
Just so long as they start out from 1 so never get freed.

> but we need to be able to have nopage() returning these etc...

You'll actually be needing nopage() on them?  That idea has come up
before, it's not out of the question (though I think wli suggested
we ought rather to change the nopage interface if so), but it's a
different topic from the current removal of PageReserved anyway.

Hugh
