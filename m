Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290000AbSAKQPx>; Fri, 11 Jan 2002 11:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290001AbSAKQPi>; Fri, 11 Jan 2002 11:15:38 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:49682 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S290000AbSAKQPU>; Fri, 11 Jan 2002 11:15:20 -0500
Date: Fri, 11 Jan 2002 16:15:15 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Lightweight user-level semaphores
In-Reply-To: <3C3F09AC.8EC143E2@colorfullife.com>
Message-ID: <Pine.LNX.4.33.0201111555310.4389-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2002, Manfred Spraul wrote:

> > Actually, the more I look at Linus's original idea, the more
> > sense it seems to make (and the more I regret scrapping my
> > almost-complete implementation of it for the fd idea :)
>
> Do you have a plan how to implement the no-contention case entirely in
> userspace?
> That would make them really fast, not just saving 50 or 100 cycles
> through a special syscall and bypassing VFS.

Yep, it was really easy.  Following Linus' design[0]
it was a really easy hack[1].

I'd like these things to be really easily shareable,
and that's harder to do when you need to communicate
a mapped area and a file descriptor.

But without an obvious handle, it's hard to collect
unreferenced locks.

Rusty's idea is nice (though I think it'd be better
with a filesystem than a device, so you can share
names rather than file descriptors) but the page per
lock seems like rather too much overhead.

Matthew.

[0] http://lwn.net/2001/0419/a/lt-semaphores.php3
[1] Kernel patch: http://hairy.beasts.org/usersem-2.4.17.diff
    (I have a more complete patch on a machine which isn't up
    right now.)
    Userspace bit: http://hairy.beasts.org/ust.tar.gz

