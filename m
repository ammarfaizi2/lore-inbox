Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286215AbRLTIVa>; Thu, 20 Dec 2001 03:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286211AbRLTIVK>; Thu, 20 Dec 2001 03:21:10 -0500
Received: from mx2.elte.hu ([157.181.151.9]:30365 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286210AbRLTIVH>;
	Thu, 20 Dec 2001 03:21:07 -0500
Date: Thu, 20 Dec 2001 11:18:25 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, <bcrl@redhat.com>, <cs@zip.com.au>,
        <billh@tierra.ucsd.edu>, <linux-kernel@vger.kernel.org>,
        <linux-aio@kvack.org>
Subject: Re: aio
In-Reply-To: <Pine.LNX.4.33.0112192218020.19433-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0112201101580.2464-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Dec 2001, Linus Torvalds wrote:

> I think the question you _should_ be lobbying at Ben and the other aio
> people is how the aio stuff could do zero-copy from disk cache to the
> network, ie do the things that Tux does internally where it does
> nonblocking reads from disk ad then sends them out non-blocking to the
> network without havign to copy the data _or_ have to use extremely
> expensive TLB mapping tricks to get at it..

months ago i already offered Ben to port TUX to the aio interfaces once
they are available in the kernel. Unfortunately right now i cant afford
maintaining two separate TUX trees - so it's a chicken and egg thing in
this context.

But once aio is available, i *will* do it, because one of Ben's goals
fully state-machine-driven async block IO, which i'd like to use (and
test, and finetune, and improve) very much. (right now TUX does async
block IO via helper kernel threads. Async net-io is fully IRQ-driven.)
I'd also like to prove that our aio interfaces are capable.

there are two possibilities i can think of:

1) lets get Ben's patch in but do *not* export the syscalls, yet.

2) find some nice way of doing 'experimental syscalls', which are not
   guaranteed to stay that way. (Perhaps this is a naive proposition,
   often there is nothing more permanent than temporary solutions.)
   Something like reserving 'temporary' syscalls at the end of the syscall
   space, which would be frequently moved/removed/renamed just to keep
   folks from relying on it. No interface is guaranteed. Perhaps some
   technical solution can be find to make these syscalls truly temporary.

i'm sure people will get excited about (ie. use) aio once it's in the
kernel. Ben is very good at coding, perhaps not as good at PR, but should
such level of PR really be a natural part of Linux development?

> Ie tie the "sendfile" and "aio" threads together, and ask Ben if we
> can do aio-sendfile and have thousands of asynchronous sendfiles going
> on at the same time, like Tux can do. And if not, then why not?
> Missing or bad interfaces?

i'd love to find out. *If* it's guaranteed that some sort of sane aio will
always be available from the point on it's introduced into the kernel then
i'll switch TUX to it. (it will change TUX upside down, this is why i
cannot maintain two separate TUX trees.) TUX doesnt need stable
interfaces. While TUX might not be as important, usage-wise, it's
certainly a good playing ground for such things.

	Ingo

