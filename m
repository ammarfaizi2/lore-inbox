Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbQL1UA1>; Thu, 28 Dec 2000 15:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129835AbQL1UAS>; Thu, 28 Dec 2000 15:00:18 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:54026 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129525AbQL1UAA>; Thu, 28 Dec 2000 15:00:00 -0500
Date: Thu, 28 Dec 2000 11:29:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Mason <mason@suse.com>
cc: Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
In-Reply-To: <447650000.978031159@coffee>
Message-ID: <Pine.LNX.4.10.10012281125260.12260-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Dec 2000, Chris Mason wrote:
> 
> Linus and Rik are cc'd in to find out if this is a good idea in
> general.

Probably. 

There are some arguments for starting the writeout early, but there are
tons of arguments against it too (the main one being "avoid doing IO if
you can do so"), so your patch is probably fine. In the end, the
performance characteristics are what matters. Does the patch make for
smoother behaviour and better performance?

Anyway, the "can_get_io_locks" check is subsumed by the "launder_loop"
check: we will never set "launder_loop" to non-zero if we can't get the
io_locks, so you might as well just make the test be

	/* First loop through? Don't start IO, just move it to the back of the list */
	if (!launder_loop) {
		....

and be done with it.

I'd like to hear what that does for dbench.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
