Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316588AbSGQT3m>; Wed, 17 Jul 2002 15:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316589AbSGQT3m>; Wed, 17 Jul 2002 15:29:42 -0400
Received: from dsl-213-023-038-064.arcor-ip.net ([213.23.38.64]:16830 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316586AbSGQT2p>;
	Wed, 17 Jul 2002 15:28:45 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Daniel Phillips <phillips@arcor.de>
To: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: HZ, preferably as small as possible
Date: Wed, 17 Jul 2002 21:33:07 +0200
X-Mailer: KMail [version 1.3.2]
References: <59885C5E3098D511AD690002A5072D3C02AB7F88@orsmsx111.jf.intel.com> <agtl95$ihe$1@penguin.transmeta.com>
In-Reply-To: <agtl95$ihe$1@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E17UuXr-0004PH-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 July 2002 07:06, Linus Torvalds wrote:
> There is, of course, the option to do variable frequency (and make it
> integer multiples of the exposed "constant HZ" so that kernel code
> doesn't actually need to _care_ about the variability). There are
> patches to play with things like that.

We don't have to feel restricted to integer multiples.  I'll paste in my 
earlier post, for your convenience:

> ...If somebody wants a cruder scheduling interval than the raw timer
> interrupt, that's child's play, just step the interval down.  The
> only slightly challenging thing is do that without restricting
> choice of rate for the raw timer and scheduler, respectively.  Here,
> a novel application of Bresenham's algorithm (the line drawing
> algorithm) works nicely: at each raw interrupt, subtract the period
> of the raw interrupt from an accumulator; if the result is less
> than zero, add the period of the scheduler to the accumlator and
> drop into the scheduler's part of the timer interrupt.

[which just increments the timer variable I believe]

> This Bresenham trick works for arbitrary collections of interrupt
> rates, all with different periods.  It has the property that,
> over time, the total number of invocations at each rate remains
> *exactly* correct, and so long as the raw interrupt runs at a
> reasonably high rate, displacement isn't that bad either.

This technique is scarcely less efficient than the cruder method.

-- 
Daniel
