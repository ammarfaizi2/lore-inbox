Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316774AbSGQU6S>; Wed, 17 Jul 2002 16:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316757AbSGQU6S>; Wed, 17 Jul 2002 16:58:18 -0400
Received: from chaos.analogic.com ([204.178.40.224]:31617 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316774AbSGQU6Q> convert rfc822-to-8bit; Wed, 17 Jul 2002 16:58:16 -0400
Date: Wed, 17 Jul 2002 17:02:23 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Daniel Phillips <phillips@arcor.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: HZ, preferably as small as possible
In-Reply-To: <E17Uvam-0004Pz-00@starship>
Message-ID: <Pine.LNX.3.95.1020717165221.12771A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2002, Daniel Phillips wrote:

> On Wednesday 17 July 2002 22:31, Richard B. Johnson wrote:
> > On Wed, 17 Jul 2002, Daniel Phillips wrote:
> > 
> > > On Monday 15 July 2002 07:06, Linus Torvalds wrote:
> > > > There is, of course, the option to do variable frequency (and make it
> > > > integer multiples of the exposed "constant HZ" so that kernel code
> > > > doesn't actually need to _care_ about the variability). There are
> > > > patches to play with things like that.
> > > 
> > > We don't have to feel restricted to integer multiples.  I'll paste in my 
> > > earlier post, for your convenience:
> > > 
> > > > ...If somebody wants a cruder scheduling interval than the raw timer
> > > > interrupt, that's child's play, just step the interval down.  The
> > > > only slightly challenging thing is do that without restricting
> > > > choice of rate for the raw timer and scheduler, respectively.  Here,
> > > > a novel application of Bresenham's algorithm (the line drawing
> > > > algorithm) works nicely: at each raw interrupt, subtract the period
> > > > of the raw interrupt from an accumulator; if the result is less
> > > > than zero, add the period of the scheduler to the accumlator and
> > > > drop into the scheduler's part of the timer interrupt.
> > > 
> > > [which just increments the timer variable I believe]
> > > 
> > > > This Bresenham trick works for arbitrary collections of interrupt
> > > > rates, all with different periods.  It has the property that,
> > > > over time, the total number of invocations at each rate remains
> > > > *exactly* correct, and so long as the raw interrupt runs at a
> > > > reasonably high rate, displacement isn't that bad either.
> > > 
> > > This technique is scarcely less efficient than the cruder method.
> > 
> > It is hardly novel and I can't imagine how Bresenham or whomever
> > could make such a claim to the obvious. Even the DOS writer(s) used
> > this technique to get one-second time intervals from the 18.206
> > ticks/per second. This is simply division by subtraction, but you
> > don't throw away the remainder. Therefore, in the limit, there is
> > no remainder. However, at any instant, the time can be off by as
> > much as the divisor -1. FYI, you make digital filters using this
> > same method, it's hardly novel.
> 
> It's novel for Linux then, because it seems not to have occured to
> anyone here.  I'll take your agressive response as a vote in favor.
> 

It's basically no overhead greater than the minimum if written in
assembly because the carry to less-than-zero is in the flags. In
'C' it requires a subtraction and then a test, but it's trivial code
and it provides for non-integral divisions with integers. I'm all
for it.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

