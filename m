Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280447AbRJaTtE>; Wed, 31 Oct 2001 14:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280443AbRJaTsu>; Wed, 31 Oct 2001 14:48:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23827 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280447AbRJaTsd>; Wed, 31 Oct 2001 14:48:33 -0500
Date: Wed, 31 Oct 2001 11:46:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Bernt Hansen <bernt@norang.ca>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: Re: new OOM heuristic failure  (was: Re: VM: qsbench)
In-Reply-To: <Pine.LNX.3.96.1011031133645.448B-100000@gollum.norang.ca>
Message-ID: <Pine.LNX.4.33.0110311138590.32727-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Cc'd to linux-kernel just in case other people are wondering ]

On Wed, 31 Oct 2001, Bernt Hansen wrote:
>
> Do I need to rebuild my systems with my swap partitions >= my physical
> memory size for the 2.4.x kernels?  All of my systems have total swap
> space less than their physical memory size and are running 2.4.13 kernels.

No. With the two-liner patch on linux-kernel, your old setup should work
as-is.

And performance will be fine, _except_ if you regularly actually have your
swap usage up in the 75%+ range. But if you do work that typically puts a
lot of pressure on swap, and you find that you almost always end up using
clearly more than half your swapspace, that implies that you should
consider perhaps reconfiguring so that you have a bigger swap partition.

When I pointed out the performance problems to Lorenzo, I specifically
meant only that one load that he is testing - the fact that the load fills
up the swap device implies that for _that_ load, performance could be
improved by making sure he has enough swap to cover it.

I bet Lorenzo doesn't even come _close_ to 80% full swap under normal
usage, so he probably wouldn't see any performance impact normally. It's
just that when you report VM benchmarks, maybe you want to try to improve
the numbers..

[ It's equally valid to say that Lorenzo's numbers are _especially_
  interesting exactly because they also test the behaviour when we need to
  start pruning the swap cache, though. So I'm in no way trying to
  criticise his benchmark - I think the qsort benchmark is actually one of
  the more valid VM patterns we have ever had as a benchmark, and I
  really like how it mixes random accesses with non-random ones ]

So don't worry.

		Linus

