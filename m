Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311265AbSCLQVy>; Tue, 12 Mar 2002 11:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311266AbSCLQVo>; Tue, 12 Mar 2002 11:21:44 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:28164 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S311265AbSCLQVh>; Tue, 12 Mar 2002 11:21:37 -0500
Date: Tue, 12 Mar 2002 17:21:34 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
Message-ID: <20020312172134.A5026@ucw.cz>
In-Reply-To: <E16kYXz-0001z3-00@the-village.bc.nu> <Pine.LNX.4.33.0203111431340.15427-100000@penguin.transmeta.com> <20020311234553.A3490@ucw.cz> <3C8DDFC8.5080501@evision-ventures.com> <20020312165937.A4987@ucw.cz> <3C8E28A1.1070902@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C8E28A1.1070902@evision-ventures.com>; from dalecki@evision-ventures.com on Tue, Mar 12, 2002 at 05:11:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 05:11:13PM +0100, Martin Dalecki wrote:

> > Reading through them as I was doing the changes, I found out that most
> > of them compute the timings incorrectly. Because of that I also removed
> > the pio blacklist (which is going to come back in a more powerful form,
> > merged together with the DMA blacklist), because that one is based on
> > ancient experiments with the broken CMD640 chip and a driver which
> > doesn't get the timings correct either. The blacklist is plain invalid.
> 
> Amen to this. May "the force" be with you! (I mean the force in you fingers!)
> 
> AS you may know I was once (an eon ago)
> during the Marc Lord "era" involved in the initial developement of the cmd640
> support. And well we got it working, but after that some friend got to the idea
> of the black list and my disk went from georgious 5M/sec to only lame 2.8M/sec
> rates (remember it was a conner 400MB drive then one of those "buggy" Quantums!)
> for no good reason. I was long time patching every single kernel those time for
> this. So if anything I very well know that the list found there is both:
> obsolete and invalid. Further on my CMD640 code wasn't even trying to compute
> the timing values in any dynamic ways. I was just using the original tables from
> CMD directly, but unfortunately the maintainer enjoyed Z/ ring arithmetics too
> much ;-)

Well, as much as I'd like to use safe pre-computed register values for
the chips, that ain't possible - even when we assumed the system bus
(PCI, VLB, whatever) was always 33 MHz, still the drives have various
ideas about what DMA and PIO modes should look like, see the tDMA and
tPIO entries in hdparm -t.  

So, arithmetics has to stay. Hopefully just one instance in
ide-timing.c.

> > I plan to focus on the most important drivers first, to fix and clean
> > them, working with the authors where possible.
> 
> PIIX na VIA comes to mind first ;-)...

VIA is already OK, well, it has my name in it. :) AMD is now also (well,
that one wasn't broken, just ugly), SiS is being revamped by Lionel
Bouton (whom I'm trying to help as much as I can), so yes, PIIX would be
next.

PIIX and ICH are pretty crazy hardware from the design perspective, very
legacy-bound back to the first Intel PIIX chip. And the driver for these
in the kernel has similarly evolved following the hardware. However, it
doesn't seem to be wrong at the first glance. Nevertheless, I'll take a
look at it. Unfortunately, I don't have any Intel hardware at hand to
test it with.

-- 
Vojtech Pavlik
SuSE Labs
