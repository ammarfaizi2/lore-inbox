Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271197AbRHOOIT>; Wed, 15 Aug 2001 10:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271199AbRHOOIM>; Wed, 15 Aug 2001 10:08:12 -0400
Received: from dfmail.f-secure.com ([194.252.6.39]:52236 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S271197AbRHOOH7>; Wed, 15 Aug 2001 10:07:59 -0400
Date: Wed, 15 Aug 2001 17:21:40 +0300 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Alexander Viro <viro@math.psu.edu>
cc: "Magnus Naeslund(f)" <mag@fbab.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8 Resource leaks + limits
In-Reply-To: <Pine.GSO.4.21.0108150225120.13928-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.30.0108151427400.2660-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Aug 2001, Alexander Viro wrote:
> > The more serious part of my little alloc adventure is much more dangerous:
> > Whattaheck happened to my resources?
> > I _still_ can't log in to that box as a luser (root works).
> May be memory fragmentation. You need an order 1 allocation for fork(), just
> to allocate task_struct...

No, 2.4.8 seems to like to soft lockup in cases after it used up all
swap. I also run some trivial memory stressing tests on a UP, 128 MB,
256 swap, 7 MB/sec UDMA disk subsytem box and after a couple of
successful recovery [couple = max 1 in my case] the system soft locks.
swap space was 0, no disk activity, CPU apparently spins in kswapd, all
relevant zones, inactive_* had plenty free pages and no memory
fragmentation. After it soft locked none of the VM stat value changed
at all. Rik also called for help in another thread but the problem seems
to be not out_of_memory() tuning (when to jump in) however either
accounting bug or other (kswapd related?) thing - kernel stacks were a
bit strange [using Right_ALT+Scroll_Lock when soft locked], like
page_launder
do_try_to_free_pages
kswapd
kswapd
kswapd

	Szaka




