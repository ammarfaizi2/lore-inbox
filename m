Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132148AbRARUeZ>; Thu, 18 Jan 2001 15:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132301AbRARUeP>; Thu, 18 Jan 2001 15:34:15 -0500
Received: from chiara.elte.hu ([157.181.150.200]:32275 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132148AbRARUeF>;
	Thu, 18 Jan 2001 15:34:05 -0500
Date: Thu, 18 Jan 2001 21:33:37 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Rick Jones <raj@cup.hp.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <Pine.LNX.4.10.10101181146190.18387-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101182121290.1838-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 Jan 2001, Linus Torvalds wrote:

> I think Andrea was thinking more of the case of the anonymous IO
> generator, and having the "controller" program thgat keeps the socket
> always in CORK mode, but uses SIOCPUSH when it doesn't know what teh
> future access patterns will be.

yep.

> Again, the actual data _senders_ may not be aware of the network
> issues. They are the worker bees, and they may not know or care that
> they are pushing out data to the network.

yep.

> Ingo, you should realize that people actually _want_ to use things
> like stdio. [...]

yep, i already acknowledged that not all applications want to care about
issues like that and rather want to have a 'default behavior' - ie. a
persistent cork.

i also said that user-space (ie. libc) could maintain a persistent flag
itself (a user-space variable) much cheaper than the kernel, and could
pass the current 'more' value to the kernel, whenever sendmsg is done. I
understand that normal file IO has no 'flag' for MSG_MORE - a pity that no
extra flags can be passed in to write(). But this doesnt make it right. It
makes it a practical problem, it shows the (perhaps-) weakness of the file
API which is right now not prepared to pass 'streaming related info' along
with a send, but doesnt make it right.

now if your point is that passing a flag (or flags) along every (generic)
file-write would be a mistake, that would be a point. But you didnt say
that so far.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
