Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268934AbRHaS4o>; Fri, 31 Aug 2001 14:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268940AbRHaS4e>; Fri, 31 Aug 2001 14:56:34 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:18706 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268934AbRHaS4W>; Fri, 31 Aug 2001 14:56:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Date: Fri, 31 Aug 2001 21:03:22 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010829140706.3fcb735c.skraw@ithnet.com> <20010829232929Z16206-32383+2351@humbolt.nl.linux.org> <20010831130618.0d3b4b4c.skraw@ithnet.com>
In-Reply-To: <20010831130618.0d3b4b4c.skraw@ithnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010831185637Z16380-32383+2716@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 31, 2001 01:06 pm, Stephan von Krawczynski wrote:
> On Thu, 30 Aug 2001 01:36:10 +0200
> Daniel Phillips <phillips@bonn-fries.net> wrote:
> 
> > [...]
> > Let's try another way of dealing with it.  What I'm trying to do with the
> > patch below is leave a small reserve of 1/12 of pages->min, above the
> > emergency reserve, to be consumed by non-PF_MEMALLOC atomic allocators.
> > Please bear in mind this is completely untested, but would you try it
> > please and see if the failure frequency goes down?
> > 
> > --- ../2.4.9.clean/mm/page_alloc.c	Thu Aug 16 12:43:02 2001
> > +++ ./mm/page_alloc.c	Wed Aug 29 23:47:39 2001
> > @@ -493,6 +493,9 @@
> >  		}
> >  
> >  		/* XXX: is pages_min/4 a good amount to reserve for this? */
> > +		if (z->free_pages < z->pages_min / 3 && (gfp_mask & __GFP_WAIT) &&
> > +				!(current->flags & PF_MEMALLOC))
> > +			continue;
> >  		if (z->free_pages < z->pages_min / 4 &&
> >  				!(current->flags & PF_MEMALLOC))
> >  			continue;
> > 
> 
> Hello Daniel,
> 
> I tried this patch and it makes _no_ difference. Failures show up in same 
> situation and amount. Do you need traces? They look the same

OK, first would you confirm that the frequency of 0 order failures has
stayed the same?

If some other thread is always in PF_MEMALLOC when these failures are 
happening then no, this approach would not be any help.

--
Daniel
