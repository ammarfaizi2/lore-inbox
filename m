Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbTGAQPI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 12:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbTGAQPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 12:15:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:31112 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262589AbTGAQPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 12:15:04 -0400
Message-Id: <5.2.0.9.2.20030701174513.026efe70@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Tue, 01 Jul 2003 18:31:11 +0200
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] patch-O1int-0306302317 for 2.5.73 interactivity
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200307012329.49069.kernel@kolivas.org>
References: <1057065479.1171.3.camel@teapot.felipe-alfaro.com>
 <200307010029.19423.kernel@kolivas.org>
 <200307012204.47605.kernel@kolivas.org>
 <1057065479.1171.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:29 PM 7/1/2003 +1000, Con Kolivas wrote:
>On Tue, 1 Jul 2003 23:17, Felipe Alfaro Solana wrote:
> > On Tue, 2003-07-01 at 14:04, Con Kolivas wrote:
> > > >When I say "X feels jerky", I mean that I can notice the scheduler is
> > > >not giving the X server enough CPU cycles (I mean, a continuous,
> > > >smaller, but more frequent CPU timeslice) to perform window movement and
> > > >redrawing fast enough to get ~25fps. Also, I don't think it's related to
> > > >the video card. The combo patch I did with Mike's + Ingo's enhacements
> > > >works beautifully for me.
> > >
> > > Actually just the bastardised Ingo patch will do that on it's own.
> > > However that's never going to be incorporated.
> >
> > So, I guess we won't have the option to choose between different CPU
> > schedulers (desktop or server, for example), like we have in -mm kernels
> > with IO schedulers (deadline or anticipatory).
> >
> > Seriously talking, I prefer to have the best performance in my server
> > boxes, but for my laptop, I prefer shorter timeslices, lower peformance
> > and better turnaround times and a wiser CPU scheduler. Just my two
> > cents.
> >
> > It's sad to say but I feel the vanilla 2.5 CPU scheduler doesn't match
> > my end-user preferences :-(
>
>There will always be alternate trees. Whether options like this make it into
>mainline will be up to the maintainer of course, but given that we seem to
>have a "swappiness" dial in mainline then I suspect we may have more dials in
>2.6 than before.

I don't like knobs at all [1], but I have to ~agree with Felipe.

A prime candidate for a knob (rather switch) would be a slightly more sane 
back-boost for desktop use. I'm playing with back-boost in my tree, 
allowing a limited quantity, and strictly from user tasks... it helps the 
desktop quite a bit.  Another thing that's very important for the desktop 
(and shell) is startup time for new tasks.  I'm working on something there 
too (works great when it's not busy breaking everything to 
pieces;).  Modulo me ever getting that darn thing working acceptably well, 
another candidate is to either export CHILD_PENALTY as in scheduler knobs 
patch, or just set it to ~75-~85 when back-boost is enabled, ie make one 
desktop mode switch and hope like heck it doesn't cause more trouble than 
it's worth.

         -Mike

1.  Dear LKML, why does performance suck?  My .config and 10000 random knob 
settings attached. 

