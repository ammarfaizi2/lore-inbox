Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262585AbRE3EXy>; Wed, 30 May 2001 00:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262589AbRE3EXe>; Wed, 30 May 2001 00:23:34 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:37639 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S262585AbRE3EX1>; Wed, 30 May 2001 00:23:27 -0400
Date: Tue, 29 May 2001 21:24:12 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: <linux-kernel@vger.kernel.org>
cc: Rik van Riel <riel@conectiva.com.br>
Subject: Re: Plain 2.4.5 VM
Message-ID: <Pine.LNX.4.33.0105292009310.9556-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Galbraith (mikeg@wen-online.de) wrote:
>
> Emphatic yes.  We went from cache collapse to cache bloat.

Rik, I think Mike deserves his beer.  ;)

Agreed.  Swap reclaim doesn't seem to be the root issue here, IMHO.
But instead: his box was capable of maintaining a modest cache
and the desired user processes without massive allocations (and use)
of swap space.  There was plenty of cache to reap, but VM decided to
swapout instead.  Seems we're out of balance here (IMHO).

I see this too, and it's only a symptom of post-2.4.4 kernels.

Example: on a 128M system w/2.4.5, loading X and a simulation code of
RSS=70M causes the system to drop 40-50M into swap...with 100M of cache
sitting there, and some of those cache pages are fairly old. It's not
just allocation; there is noticable disk activity associated with paging
that causes a lag in interactivity.  In 2.4.4, there is no swap activity
at all.

And if the application causes heavy I/O *and* memory load (think
StarOffice, or Quake 3), this situation gets even worse (because there's
typically more competition/demand for cache pages).

And on low-memory systems (ex. 32M), even a basic Web browsing test w/
Opera drops the 2.4.5 system 25M into swap where 2.4.4 barely cracks 5 MB
on the same test (and the interactivity shows).  This is all independent
of swap reclaim.

So is there an ideal VM balance for everyone?  I have found that low-RAM
systems seem to benefit from being on the "cache-collapse" side of the
curve (so I prefer the pre-2.4.5 balance more than Mike probably does) and
those low-RAM systems are the first hit when, as now, we're favoring
"cache bloat".  Should balance behaviors could be altered by the user
(via sysctl's maybe?  Yeah, I hear the cringes)?  Or better, is it
possible to dynamically choose where the watermarks in balancing should
lie, and alter them automatically?  2.5 stuff there, no doubt.  Balancing
seems so *fragile* (to me).

Cheers,

Craig Kulesa
ckulesa@as.arizona.edu

