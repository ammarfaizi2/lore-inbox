Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276150AbRJCMdd>; Wed, 3 Oct 2001 08:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276155AbRJCMdN>; Wed, 3 Oct 2001 08:33:13 -0400
Received: from mailout5-1.nyroc.rr.com ([24.92.226.169]:54343 "EHLO
	mailout5.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S276150AbRJCMdC>; Wed, 3 Oct 2001 08:33:02 -0400
Date: Wed, 3 Oct 2001 08:33:26 -0400
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>
Subject: Re: status of nfs and tcp with 2.4
Message-ID: <20011003083326.A12840@rochester.rr.com>
In-Reply-To: <20010927105321.A15128@rochester.rr.com> <shssnd88xae.fsf@charged.uio.no> <20010927131030.A15669@rochester.rr.com> <shslmizaejh.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shslmizaejh.fsf@charged.uio.no>
User-Agent: Mutt/1.3.20i
From: jstrand1@rochester.rr.com (James D Strandboge)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgive me, Trond, for sending a second reply to this, I am trying to
dig in and get my hands dirty, but want to make sure I understand the
problem.

> The biggest problem is to prevent the TCP server hogging all the
> threads when a client gets congested.
>
> With the UDP code, we use non-blocking I/O and simply drop all replies
> that don't get through. For TCP dropping replies is not acceptable as
> the client will only resend requests every ~60seconds. Currently, the
> code therefore uses blocking I/O something which means that if the
> socket blocks, you run out of free nfsd threads...

By 'when a client gets congested' my understanding is you mean 'when
a client is sending a lot to the server, and the server can't respond
quickly enough.'  Therefore, dropping udp replies is ok, since the
client will just send it again, however, with tcp, the client will only
resend every 60 seconds and that is too slow, and it blocks the socket
in the meantime.  Is my understanding correct?

> There are 2 possible strategies:
> 
>   1 Allocate 1 thread per TCP connection

This seems to be the easier of the two to implement, however you opted
against this because we are putting an eventual limit on the number of 
clients we can serve based on NFSD_MAXSERVS.  Is this correct?

>   2 Use non-blocking I/O, but allow TCP connections to defer sending
>     the reply until the socket is available (and allow the thread to
>     service other requests while the socket is busy).
>
> I started work on (2) last autumn, <snip>

Are there patches for this that I could look at?

Jamie Strandboge

-- 
GPG/PGP Info
Email:        jstrand1@rochester.rr.com
ID:           26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A
--
