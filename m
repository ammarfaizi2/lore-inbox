Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135590AbRARVTT>; Thu, 18 Jan 2001 16:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135756AbRARVTJ>; Thu, 18 Jan 2001 16:19:09 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:25698 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135190AbRARVS5>; Thu, 18 Jan 2001 16:18:57 -0500
Date: Thu, 18 Jan 2001 22:14:11 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Rick Jones <raj@cup.hp.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
Message-ID: <20010118221411.H28276@athlon.random>
In-Reply-To: <Pine.LNX.4.30.0101182041240.1009-100000@elte.hu> <Pine.LNX.4.10.10101181146190.18387-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10101181146190.18387-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Jan 18, 2001 at 11:52:33AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 11:52:33AM -0800, Linus Torvalds wrote:
> On Thu, 18 Jan 2001, Ingo Molnar wrote:
> > 
> > i believe a network-conscious application should use MSG_MORE - that has
> > no system-call overhead.
> 
> I think Andrea was thinking more of the case of the anonymous IO
> generator, and having the "controller" program thgat keeps the socket
> always in CORK mode, but uses SIOCPUSH when it doesn't know what teh
> future access patterns will be. 

Yes. Your one is an example where TCP_CORK is necessary to make sure not to
send small packets and where instead MSG_MORE can't help.

> Basically, it could use SIOCPUSH whenever its request queue is empty,
> instead of uncorking (and re-corking when the next request comes in).

Exactly.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
