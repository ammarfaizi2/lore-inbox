Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132754AbRARWID>; Thu, 18 Jan 2001 17:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131565AbRARWHx>; Thu, 18 Jan 2001 17:07:53 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:50792 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136063AbRARWHh>; Thu, 18 Jan 2001 17:07:37 -0500
Date: Thu, 18 Jan 2001 22:54:32 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Rick Jones <raj@cup.hp.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
Message-ID: <20010118225432.K28276@athlon.random>
In-Reply-To: <20010118212441.E28276@athlon.random> <Pine.LNX.4.30.0101182135180.2034-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0101182135180.2034-100000@elte.hu>; from mingo@elte.hu on Thu, Jan 18, 2001 at 09:44:57PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 09:44:57PM +0100, Ingo Molnar wrote:
> why? TCP_CORK is equivalent to MSG_MORE, it's just a different

I thought you agreed it isn't (Linus's example I quoted).

> > Doing PUSH from setsockopt(TCP_CORK) looked obviously wrong because it
> > isn't setting any socket state, [...]
> 
> well, neither is clearing/setting TCP_CORK ...

clearing/setting TCP_CORK is a stateful opertaion, it changes a socket option.

> > and also because the SIOCPUSH has nothing specific with TCP_CORK, as
> > said it can be useful also to flush the last fragment of data pending
> > in the send queue without having to wait all the unacknowledged data
> > to be acknowledged from the receiver when TCP_NODELAY isn't set.
> 
> huh? in what way does the following:
> 
> {
>         int val = 1;
>         setsockopt(req->sock, IPPROTO_TCP, TCP_CORK,
> 			(char *)&val,sizeof(val));
>         val = 0;
>         setsockopt(req->sock, IPPROTO_TCP, TCP_CORK,
> 			(char *)&val,sizeof(val));
> }
> 
> differ from what you posted. It does the same in my opinion. Maybe we are
> not talking about the same thing?

The above is equivalent to SIOCPUSH _only_ if the caller wasn't using either
TCP_NODELAY or TCP_CORK.

> [this is nitpicking. I'm quite sure all the code uses '1' as the value,
> not 2.]

I'm quite sure too but I will not get suprirsed anymore by getting bugreports
because of such an innocent change ;). Though real reasons are others (I
mentioned the backwards compatibility breakage more as a side note).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
