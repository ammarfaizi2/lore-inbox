Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261296AbREZP1p>; Sat, 26 May 2001 11:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261351AbREZP1g>; Sat, 26 May 2001 11:27:36 -0400
Received: from [209.10.217.66] ([209.10.217.66]:59407 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261410AbREZP1a>; Sat, 26 May 2001 11:27:30 -0400
Date: Sat, 26 May 2001 08:23:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Rik van Riel <riel@conectiva.com.br>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <20010526171459.Y9634@athlon.random>
Message-ID: <Pine.LNX.4.21.0105260818150.3684-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 26 May 2001, Andrea Arcangeli wrote:
> 
> I don't see where you fixed the deadlock in create_buffers, if you did
> please show me which line of code is supposed to do that, I show you
> below which lines of code in my patch should fix the wait_event deadlock
> in create_buffers:

Andrea, look at the page_alloc() path, and the "don't loop forever if
__GFP_IO isn't set and we're not making progress". That looks entirely
sane.

It's the other limiting that I don't think really addresses the problem
(and I like your patch that removes some more magic limits - I suspect the
proper fix is the 5 lines from Rik's patch in page_alloc.c, and your patch
together - amybody mind testing that out?)

Oh, and I still _do_ think that we should rename the silly "async" flag as
"can_do_io", and then use that to determine whether to do SLAB_KERNEL or
SLAB_BUFFER. That would make more things able to do IO, which in turn
should help balance things out.

		Linus "leaving for the airport" Torvalds

