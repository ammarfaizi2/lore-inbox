Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSGQUgI>; Wed, 17 Jul 2002 16:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316686AbSGQUgI>; Wed, 17 Jul 2002 16:36:08 -0400
Received: from dsl-213-023-038-064.arcor-ip.net ([213.23.38.64]:59582 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316684AbSGQUgF>;
	Wed, 17 Jul 2002 16:36:05 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Daniel Phillips <phillips@arcor.de>
To: root@chaos.analogic.com
Subject: Re: HZ, preferably as small as possible
Date: Wed, 17 Jul 2002 22:40:06 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.3.95.1020717162206.12592A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1020717162206.12592A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E17Uvam-0004Pz-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 July 2002 22:31, Richard B. Johnson wrote:
> On Wed, 17 Jul 2002, Daniel Phillips wrote:
> 
> > On Monday 15 July 2002 07:06, Linus Torvalds wrote:
> > > There is, of course, the option to do variable frequency (and make it
> > > integer multiples of the exposed "constant HZ" so that kernel code
> > > doesn't actually need to _care_ about the variability). There are
> > > patches to play with things like that.
> > 
> > We don't have to feel restricted to integer multiples.  I'll paste in my 
> > earlier post, for your convenience:
> > 
> > > ...If somebody wants a cruder scheduling interval than the raw timer
> > > interrupt, that's child's play, just step the interval down.  The
> > > only slightly challenging thing is do that without restricting
> > > choice of rate for the raw timer and scheduler, respectively.  Here,
> > > a novel application of Bresenham's algorithm (the line drawing
> > > algorithm) works nicely: at each raw interrupt, subtract the period
> > > of the raw interrupt from an accumulator; if the result is less
> > > than zero, add the period of the scheduler to the accumlator and
> > > drop into the scheduler's part of the timer interrupt.
> > 
> > [which just increments the timer variable I believe]
> > 
> > > This Bresenham trick works for arbitrary collections of interrupt
> > > rates, all with different periods.  It has the property that,
> > > over time, the total number of invocations at each rate remains
> > > *exactly* correct, and so long as the raw interrupt runs at a
> > > reasonably high rate, displacement isn't that bad either.
> > 
> > This technique is scarcely less efficient than the cruder method.
> 
> It is hardly novel and I can't imagine how Bresenham or whomever
> could make such a claim to the obvious. Even the DOS writer(s) used
> this technique to get one-second time intervals from the 18.206
> ticks/per second. This is simply division by subtraction, but you
> don't throw away the remainder. Therefore, in the limit, there is
> no remainder. However, at any instant, the time can be off by as
> much as the divisor -1. FYI, you make digital filters using this
> same method, it's hardly novel.

It's novel for Linux then, because it seems not to have occured to
anyone here.  I'll take your agressive response as a vote in favor.

-- 
Daniel
