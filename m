Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282866AbRK0Iif>; Tue, 27 Nov 2001 03:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282867AbRK0IiZ>; Tue, 27 Nov 2001 03:38:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:266 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S282866AbRK0IiT>;
	Tue, 27 Nov 2001 03:38:19 -0500
Date: Tue, 27 Nov 2001 09:38:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: "Nathan G. Grennan" <ngrennan@okcforum.org>, linux-kernel@vger.kernel.org
Subject: Re: Unresponiveness of 2.4.16
Message-ID: <20011127093800.A5129@suse.de>
In-Reply-To: <1006812135.1420.0.camel@cygnusx-1.okcforum.org> <3C02C06A.E1389092@zip.com.au>, <3C02C06A.E1389092@zip.com.au> <20011127084234.V5129@suse.de> <3C034F7E.96880768@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C034F7E.96880768@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27 2001, Andrew Morton wrote:
> Jens Axboe wrote:
> > 
> > I agree that the current i/o scheduler has really bad interactive
> > performance -- at first sight your changes looks mostly like add-on
> > hacks though.
> 
> Good hacks, or bad ones?
> 
> It keeps things localised.  It works.  It's tunable.  It's the best
> IO scheduler presently available.

Hacks look ok on cursory glances :-)

> > Arjan's priority based scheme is more promising.
> 
> If the IO priority becomes an attribute of the calling process
> then an approach like that has value.  For writes, the priority
> should be driven by VM pressure and it's probably simpler just
> to stick the priority into struct buffer_head -> struct request.
> For reads, the priority could just be scooped out of *current.
> 
> If we're not going to push the IO priority all the way down from
> userspace then you may as well keep the logic inside the elevator
> and just say reads-go-here and writes-go-there.

Priority will be passed down for reads as you suggest, at least that is
the intention I had as well. I've only worked on 2.5 with this, but I
guess we can find some space in the buffer_head to squeeze in some
priority bits.

> But this has potential to turn into a great designfest.  Are

Oh yeah

> we going to leave 2.4 as-is?  Please say no.  

I'd be happy to review anything you come up with -- or in other works,
feel free to knock yourself out, I'm busy with other stuff currently :)

-- 
Jens Axboe

