Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270381AbRHHHQT>; Wed, 8 Aug 2001 03:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270380AbRHHHQJ>; Wed, 8 Aug 2001 03:16:09 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:7434 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S270381AbRHHHP6>; Wed, 8 Aug 2001 03:15:58 -0400
Date: Wed, 8 Aug 2001 02:46:52 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] total_free_shortage() using zone_free_shortage()
In-Reply-To: <Pine.LNX.4.33.0108072353530.956-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0108080240250.13133-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Aug 2001, Linus Torvalds wrote:

> 
> [ Hey, I can have long discussions by myself. I don't need you guys to
>   answer me at all.
> 
>   This must be what senility feels like. Linus "doddering fool" Torvalds ]
> 
> On Tue, 7 Aug 2001, Linus Torvalds wrote:
> >
> > We should really document the ranges clearly. Right now (with these
> > changes), the ranges would be (with users in parenthesis):
> >
> >  free (free + inactive_clean):
> >
> > 	low water mark: zone->pages_high	(__alloc_pages, zone_free_shortage)
> > 	high water mark: zone->pages_high*2	(zone_free_plenty)
> 
> That's subtly wrong, __alloc_pages really has "zone->pages_low", not
> "pages_high"  as the low water mark on when to start kswapd.
> 
> It does use "pages_high" too - but it is used as a "prefer this zone
> because it isn't close to empty" marker. In short, it's really more of a
> local high water mark.
> 
> So the free_shortage() logic really should be:
>  - we want zone to have "pages_high" on _average_, but it's a shortage
>    only if any zone is under the "pages_low" thing.

I think you are misunderstanding things here.

Having "zone->pages_low" as the low water mark to when start kswapd does
_not_ mean we want "zone->pages_low" as the freetarget (or the "free
shortage" indicator). 

Could you be more verbose ? 

