Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264486AbRFIUn0>; Sat, 9 Jun 2001 16:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264488AbRFIUnR>; Sat, 9 Jun 2001 16:43:17 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:52496 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264486AbRFIUnL>; Sat, 9 Jun 2001 16:43:11 -0400
Date: Sat, 9 Jun 2001 13:42:10 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org, Dawson Engler <engler@csl.Stanford.EDU>
Subject: Re: [CHECKER] a couple potential deadlocks in 2.4.5-ac8
In-Reply-To: <Pine.GSO.4.21.0106091524420.19361-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0106091339090.26520-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 9 Jun 2001, Alexander Viro wrote:
> 
> True, but... I can easily see the situation when ->foo() and ->bar()
> both call a helper function which needs BKL for a small piece of code.

I'd hope that we can fix the small helper functions to not need BKL -
there are already many circumstances where you can't use the BKL anyway
(ie you already hold a spinlock - I'd really like to have the rule that
the BKL is the "outermost" of all spinlocks, as we could in theory some
day use it as a point to schedule away on BKL contention).

> ObUnrelated: fs/super.c is getting to the point where it naturally
> falls into two files - one that deals with mount cache and all things
> vfsmount-related, mount tree manipulations, etc. and another that deals
> with superblocks. Mind if I split the thing?

Sure. As long as there is some sane naming and not too many new non-static
functions. Maybe just "fs/mount.c" for the vfsmount caches etc.

		Linus

