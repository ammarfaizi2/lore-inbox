Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131658AbRCSXhK>; Mon, 19 Mar 2001 18:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131665AbRCSXhB>; Mon, 19 Mar 2001 18:37:01 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:47372 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131658AbRCSXgy>; Mon, 19 Mar 2001 18:36:54 -0500
Date: Mon, 19 Mar 2001 15:35:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: 3rd version of R/W mmap_sem patch available
In-Reply-To: <Pine.LNX.4.31.0103191525480.937-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.31.0103191529530.967-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Mar 2001, Linus Torvalds wrote:
>
> Excellent point. We used to do all the looping and re-trying, but it got
> ripped out a long time ago (and in any case, it historically didn't do
> SMP, so the old code doesn't really work).

Actually, funnily enough, I see that the old thread-safe stuff is still
there in get_pte_kernel_slow(). The only thing that breaks it is that we
don't hold any locks, so it's only UP-safe, not SMP-safe.

However, it definitely looks like we should just un-inline that thing
completely, and make a lot of it architecture-independent anyway.

		Linus

