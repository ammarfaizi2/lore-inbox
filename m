Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143779AbRA1Sa1>; Sun, 28 Jan 2001 13:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143762AbRA1SaR>; Sun, 28 Jan 2001 13:30:17 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:15890 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S143754AbRA1SaG>; Sun, 28 Jan 2001 13:30:06 -0500
Date: Sun, 28 Jan 2001 10:29:53 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: Lorenzo Allegrucci <lenstra@tiscalinet.it>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre10 deadlock (Re: ps hang in 241-pre10)
In-Reply-To: <20010128192306.C4871@suse.de>
Message-ID: <Pine.LNX.4.10.10101281026250.3812-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jan 2001, Jens Axboe wrote:
> 
> How about this instead?

I really don't like this one. It will basically re-introduce the old
behaviour of waking people up in a trickle, as far as I can tell. The
reason we want the batching is to make people have more requests to sort
in the elevator, and as far as I can tell this will just hurt that.

Are there any downsides to just _always_ batching, regardless of whether
the request freelist is empty or not? Sure, it will make the "effective"
size of the freelist a bit smaller, but that's probably not actually
noticeable under any load except for the one that empties the freelist (in
which case the old code would have triggered the batching anyway).

Performance numbers?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
