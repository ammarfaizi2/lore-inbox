Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131825AbRARTx0>; Thu, 18 Jan 2001 14:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132205AbRARTxQ>; Thu, 18 Jan 2001 14:53:16 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:60686 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131825AbRARTxM>; Thu, 18 Jan 2001 14:53:12 -0500
Date: Thu, 18 Jan 2001 11:52:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrea Arcangeli <andrea@suse.de>, Rick Jones <raj@cup.hp.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <Pine.LNX.4.30.0101182041240.1009-100000@elte.hu>
Message-ID: <Pine.LNX.4.10.10101181146190.18387-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Jan 2001, Ingo Molnar wrote:
> 
> i believe a network-conscious application should use MSG_MORE - that has
> no system-call overhead.

I think Andrea was thinking more of the case of the anonymous IO
generator, and having the "controller" program thgat keeps the socket
always in CORK mode, but uses SIOCPUSH when it doesn't know what teh
future access patterns will be. 

Basically, it could use SIOCPUSH whenever its request queue is empty,
instead of uncorking (and re-corking when the next request comes in).

Again, the actual data _senders_ may not be aware of the network issues.
They are the worker bees, and they may not know or care that they are
pushing out data to the network. 

Ingo, you should realize that people actually _want_ to use things like
stdio. Not everything is a Tux web-server. There are specialized servers
out there, and there are tons of people who prefer to use "fprintf()"
and letting the library handle buffering etc.

Very few people want to use send() directly.

Mantra: "everything is a stream of bytes". Repeat until enlightened.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
