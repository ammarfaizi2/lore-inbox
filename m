Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318088AbSG2Urn>; Mon, 29 Jul 2002 16:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318092AbSG2Urn>; Mon, 29 Jul 2002 16:47:43 -0400
Received: from [195.223.140.120] ([195.223.140.120]:59516 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318088AbSG2Urm>; Mon, 29 Jul 2002 16:47:42 -0400
Date: Mon, 29 Jul 2002 22:52:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of PAGE_{CACHE_,}{MASK,ALIGN}
Message-ID: <20020729205211.GB1201@dualathlon.random>
References: <5.1.0.14.2.20020728193528.04336a80@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0207281622350.8208-100000@home.transmeta.com> <3D448808.CF8D18BA@zip.com.au> <20020729004942.GL1201@dualathlon.random> <3D44A2DF.F751B564@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D44A2DF.F751B564@zip.com.au>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 07:05:19PM -0700, Andrew Morton wrote:
> But yes, all of this is a straight speed/space tradeoff.  Probably
> some of it should be ifdeffed.

I would say so. recalculating page_address in cpu core with no cacheline
access is one thing, deriving the index is a different thing.

> The cost of the tree walk doesn't worry me much - generally we
> walk the tree with good locality of reference, so most everything is
> in cache anyway.

well, the rbtree showedup heavily when it started growing more than a
few steps, it has less locality of reference though.

>    Good luck setting up a testcase which does this ;)

a gigabit will trigger it in a millisecond. of course nobody tested it
either I guess (I guess not many people tested the 800Gbyte offset
either in the first place).

> Then again, Andi says that sizeof(struct page) is a problem for
> x86-64.

not true.

> No recursion needed, no allocations needed.

the 28 bytes if they're on the stack they're like recursion, just using
an interactive algorithm.

you're done with 28 bytes with a max 7/8 level tree, so 7*4 = 28 (4 size
of pointer/long). On a 32bit arch the max index supported is
2^32, on a 64bit arch the max index supported is
2^(64-PAGE_CACHE_SHFIT), plus each pointer is 8 bytes. You may want to
do the math to verify if you've enough stack to walk the tree in order,
it's not obvious.

> But I don't see any showstoppers here.

on a 32bit arch with 32bit index it seems ok to me too, on 64bit
somebody has to do the math and it's not really obvious to me that's
feasible.

Andrea
