Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267257AbSLRNHr>; Wed, 18 Dec 2002 08:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267263AbSLRNHr>; Wed, 18 Dec 2002 08:07:47 -0500
Received: from chaos.analogic.com ([204.178.40.224]:42379 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267257AbSLRNHr>; Wed, 18 Dec 2002 08:07:47 -0500
Date: Wed, 18 Dec 2002 08:17:17 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Ulrich Drepper <drepper@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212171716020.1362-100000@home.transmeta.com>
Message-ID: <Pine.LNX.3.95.1021218081345.29893A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2002, Linus Torvalds wrote:

> 
> On Tue, 17 Dec 2002, Linus Torvalds wrote:
> >
> > How about this diff? It does both the 6-parameter thing _and_ the
> > AT_SYSINFO addition.
> 
> The 6-parameter thing is broken. It's clever, but playing games with %ebp
> is not going to work with restarting of the system call - we need to
> restart with the proper %ebp.
> 
> I pushed out the AT_SYSINFO stuff, but we're back to the "needs to use
> 'int $0x80' for system calls that take 6 arguments" drawing board.
> 
> The only sane way I see to fix the %ebp problem is to actually expand the
> kernel "struct ptregs" to have separate "ebp" and "arg6" fields (so that
> we can re-start with the right ebp, and have arg6 as the right argument on
> the stack). That would work but is not really worth it.
> 
> 		Linus
> 

How about for the new interface, a one-parameter arg, i.e., a pointer
to a descriptor (structure)?? For the typical one-argument call, i.e.,
getpid(), it's just one de-reference. The pointer register can be
EAX on Intel, a register normally available in a 'C' call.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


