Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131105AbRATVBf>; Sat, 20 Jan 2001 16:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131799AbRATVB0>; Sat, 20 Jan 2001 16:01:26 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:20832 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131105AbRATVBI>; Sat, 20 Jan 2001 16:01:08 -0500
Date: Sat, 20 Jan 2001 21:56:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: kuznet@ms2.inr.ac.ru, mingo@elte.hu, raj@cup.hp.com,
        linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
Message-ID: <20010120215615.B5274@athlon.random>
In-Reply-To: <20010120203023.A5274@athlon.random> <Pine.LNX.4.10.10101201138100.10317-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10101201138100.10317-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Jan 20, 2001 at 11:39:30AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2001 at 11:39:30AM -0800, Linus Torvalds wrote:
> As far as I can tell, the second "write(1)" will always merge with the
> first one - unless the first one has already been sent out, [..]

Here the question is only if the first write(1) will be still there when we do the
second write(1).

If the first write(1) is still there it will of course merge fine with the second
write(1) as usual.

With 2.4 we'll send out the first write(1) immediatly on the wire if cwnd and
receiver window allows that without caring that there are packets out. While
the classcal nagle (the only one I known about) would wait for the second
write(1) to arrive until all the previously sent data is been acknowledged from
the receiver (to give to the second write(1) the time to be merged with the
first write(1)).

It's not obvious this new algorithm a good thing to me but I won't argue if
this is the new standard algorithm.

So now the question is: when does this new nagle algorithm delay packets in the
write queue? It _must_ do something, otherwise TCP_NODELAY would obviously be a
noop.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
