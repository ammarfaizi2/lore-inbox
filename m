Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280479AbRKSSJG>; Mon, 19 Nov 2001 13:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280481AbRKSSI4>; Mon, 19 Nov 2001 13:08:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34571 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280479AbRKSSIs>; Mon, 19 Nov 2001 13:08:48 -0500
Date: Mon, 19 Nov 2001 10:03:34 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Simon Kirby <sim@netnation.com>
cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: VM-related Oops: 2.4.15pre1
In-Reply-To: <20011119095631.A24617@netnation.com>
Message-ID: <Pine.LNX.4.33.0111190958230.8205-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Nov 2001, Simon Kirby wrote:
>
> So, uh, any idea why the server is hitting the page->mapping BUG() thing
> in the first place? :)

No.

I suspect that your earlier oopses left something in a stale state - this
is the same machine that you've reported others oopses for, no?

> Is there some way to figure out if this page is special in some way or
> track down how it broke?

It looks like it's a bog-standard page, that was just free'd (probably
because of page->count corruption) while it was still in the page cache.
Now, how that page->count corruption actually happened, I have no idea,
which is why I suspect you had other earlier oopses that left the machine
in an inconsistent state.

There _is_ a known race in 2.4.15pre1, where we simply test a condition
that isn't true any more and that can cause spurious oopses (not this one,
though) under the right circumstances. Such an oops might have left
something in the VM in a half-way state...

Can you reproduce this on pre6, for example? And if so, what's the load?

		Linus


