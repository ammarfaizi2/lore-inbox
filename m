Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbQKEQXZ>; Sun, 5 Nov 2000 11:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129422AbQKEQXQ>; Sun, 5 Nov 2000 11:23:16 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:17192 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129413AbQKEQW7>; Sun, 5 Nov 2000 11:22:59 -0500
Date: Sun, 5 Nov 2000 17:22:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Negative scalability by removal of
Message-ID: <20001105172245.A3976@athlon.random>
In-Reply-To: <E13s0y9-0004TB-00@the-village.bc.nu> <Pine.LNX.4.10.10011040919550.3864-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10011040919550.3864-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Nov 04, 2000 at 09:22:58AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2000 at 09:22:58AM -0800, Linus Torvalds wrote:
> We don't need to backport of the full exclusive wait queues: we could do
> the equivalent of the semaphore inside the kernel around just accept(). It
> wouldn't be a generic thing, but it would fix the specific case of
> accept().

The first wake-one patch floating around was against 2.2.x waitqueues and
it's a very simple patch and it fixes the problem (it also gives LIFO
to accept with the downside that it needs to do an O(N) browse on the
waitqueue before doing the exclusive wakeup compared to 2.4.x that does
the wake-one task selection in O(1) if everybody is sleeping in accept, but it
does that FIFO unfortunately).

The real problem that DaveM knows well is that TCP in 2.2.x will end doing
three wakeups every time the socket moves from LISTEN to ESTABLISHED state, so
it was really doing a wake-three not a wake-one :). So the brainer part
is to fix TCP and not the scheduler/waitqueue part.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
