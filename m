Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264483AbRFITgx>; Sat, 9 Jun 2001 15:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264484AbRFITgn>; Sat, 9 Jun 2001 15:36:43 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:42744 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264483AbRFITgf>;
	Sat, 9 Jun 2001 15:36:35 -0400
Date: Sat, 9 Jun 2001 15:36:32 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org, Dawson Engler <engler@csl.Stanford.EDU>
Subject: Re: [CHECKER] a couple potential deadlocks in 2.4.5-ac8
In-Reply-To: <Pine.LNX.4.21.0106091148380.26187-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0106091524420.19361-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Jun 2001, Linus Torvalds wrote:

> Anyway, in a 2.5.x timeframe we should probably make sure that we do not
> have the need for a recursive BKL any more. That shouldn't be that hard to
> fix, especially with help from CHECKER to verify that we didn't forget
> some case.

True, but... I can easily see the situation when ->foo() and ->bar()
both call a helper function which needs BKL for a small piece of code.
->foo() callers take BKL (and it's choke-full of places that still need
BKL, anyway). ->bar() is called without BKL. Moreover, grabbing BKL
over the whole helper is a massive overkill.

ObUnrelated: fs/super.c is getting to the point where it naturally
falls into two files - one that deals with mount cache and all things
vfsmount-related, mount tree manipulations, etc. and another that deals
with superblocks. Mind if I split the thing?

