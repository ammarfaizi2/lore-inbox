Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319069AbSH2CGB>; Wed, 28 Aug 2002 22:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319068AbSH2CGB>; Wed, 28 Aug 2002 22:06:01 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:51687 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S319069AbSH2CGA>; Wed, 28 Aug 2002 22:06:00 -0400
Date: Wed, 28 Aug 2002 23:10:01 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
cc: William Lee Irwin III <wli@holomorphy.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] adjustments to dirty memory thresholds
In-Reply-To: <3D6D82A3.A3A0C7F0@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0208282306110.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2002, Andrew Morton wrote:
> Rik van Riel wrote:
> >
> > On Wed, 28 Aug 2002, Andrew Morton wrote:
> >
> > > But sigh.  Pointlessly scanning zillions of dirty pages and doing
> > > nothing with them is dumb.  So much better to go for a FIFO snooze on a
> > > per-zone waitqueue, be woken when some memory has been cleansed.
> >
> > But not per-zone, since many (most?) allocations can be satisfied
> > from multiple zones.  Guess what 2.4-rmap has had for ages ?
>
> Per-classzone ;)

I pull the NUMA-fallback card ;)

But serious, having one waitqueue for this case should be
fine. If the system is not under lots of VM pressure with
tons of dirty pages, kswapd will free pages as fast as
they get allocated.

If the system can't keep up and we have to wait for dirty
page writeout to finish before we can allocate more, it
shouldn't really matter how many waitqueues we have.
Except for the fact that having a more complex system can
introduce more opportunities for unfairness and starvation.

> > Interested in a port for 2.5 on top of 2.5.32-mm2 ? ;)
> >
> > [I'll mercilessly increase your patch queue since it doesn't show
> > any sign of ever shrinking anyway]
>
> Lack of patches is not a huge problem at present ;).  It's getting them
> tested for performance, stability and general does-good-thingsness
> which is the rate limiting step.

Yup, but if I were to wait for your queue to shrink I'd never get
any patches merged ;)

> But yes, I'm interested in a port of the code, and in the description
> of the problems which it solves, and how it solves them.

I'll introduce this stuff in 2 or 3 steps, with descriptions.

> But what is even more valuable than the code is a report of its
> before-and-after effectiveness under a broad range of loads on a broad
> range of hardware.  That's the most time-consuming part...

Eeeks ;)   I don't even have a broad range of hardware...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

