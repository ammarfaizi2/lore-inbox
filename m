Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135356AbRARUoP>; Thu, 18 Jan 2001 15:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135447AbRARUoG>; Thu, 18 Jan 2001 15:44:06 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:28510 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135270AbRARUn5>; Thu, 18 Jan 2001 15:43:57 -0500
Date: Thu, 18 Jan 2001 21:44:32 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
Message-ID: <20010118214432.F28276@athlon.random>
In-Reply-To: <20010118203802.D28276@athlon.random> <200101181959.WAA08376@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200101181959.WAA08376@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Thu, Jan 18, 2001 at 10:59:11PM +0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 10:59:11PM +0300, kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > I'm all for TCP_CORK but it has the disavantage of two syscalls for doing the
> 
> MSG_MORE was invented to allow to collapse this to 0 of syscalls. 8)

Yes, I know.

> > A new ioctl on the socket should be able to do that (and ioctl looks ligther
> > than a setsockopt, ok ignoring actually the VFS is grabbing the big lock
> > until we relase it in sock_ioctl, ugly, but I feel good ignoring this fact as
> > it will gets fixed eventually and this is userspace API that will stay longer).
> 
> setsockopt() exists, which does not have the flaw. (SOL_SOCKET, TCP_DOPUSH)
> or something like this. Actually, I would convert TCP_CORK to set of flags

That is ok for me after all, as said I thought ioctl was conceptually the
right place but setsockopt TCP_PUSH or TCP_DOPUSH are certainly fine too in
practice.

> (1 is reserved for current corking), but I feel this operation is more generic
> and should be moved to SOL_SOCKET level.

Agreed. (btw everything != 0 is reseved for current corking as far as the code
is concerned ;)

> BTW I see no reasons not to move BKL down for ioctl().

No theorical reason indeed. But pratically moving the BKL down into the
callback means a big patch due the zillon of device drivers out there in and
out the tree and it may end to hurting somebody who is upgrading from 2.4.0 to
2.4.1 and using a driver out of the tree. I believe it's one of the things that
should be done in an unstable branch for those kind of pratical reasons
(however I'm not the one who will complain if that happens during 2.4.x but I'm
not either the one who suggests that because I couldn't complain the
complains ;).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
