Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265945AbRGERSG>; Thu, 5 Jul 2001 13:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265928AbRGERR5>; Thu, 5 Jul 2001 13:17:57 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:2830 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265934AbRGERRp>; Thu, 5 Jul 2001 13:17:45 -0400
Date: Thu, 5 Jul 2001 10:17:22 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: GFP_NOFS broken
In-Reply-To: <20010705190739.A704@athlon.random>
Message-ID: <Pine.LNX.4.33.0107051014430.22305-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Jul 2001, Andrea Arcangeli wrote:
>
> getblk called from the fs calls grow_buffers with GFP_NOFS which doesn't
> inhibit shrink_dcache_memory to re-enter the fs in prune_dcache because
> __GFP_IO is set. And it will deadlock as usual when shrink_dcache reenter
> the fs that way.

Good catch. I renamed GFP_BUFFER on purpose to make sure that nobody
relied on the old semantics, but I didn't think of the low-level __GFP_IO
one which also changed semantics.

A quick "grep" indicates that you seem to have found the only two that
were left.  Thanks.

> Secondly this cleanups a bit in page_launder. If we are allowed to enter
> the FS we can certainly also do I/O.

Yup.

		Linus

