Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265099AbSLQRJ2>; Tue, 17 Dec 2002 12:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265130AbSLQRJ2>; Tue, 17 Dec 2002 12:09:28 -0500
Received: from chaos.analogic.com ([204.178.40.224]:52362 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265099AbSLQRJ1>; Tue, 17 Dec 2002 12:09:27 -0500
Date: Tue, 17 Dec 2002 12:19:31 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.3.95.1021217120925.25972A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.3.95.1021217121612.25972B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2002, Richard B. Johnson wrote:

> On Tue, 17 Dec 2002, Manfred Spraul wrote:
> 
> > >
> > >
> > >   pushl %ebp
> > >   movl $0xfffff000, %ebp
> > >   call *%ebp
> > >   popl %ebp
> > >  
> > >
> > 
> > You could avoid clobbering a register with something like
> > 
> > pushl $0xfffff000
> > call *(%esp)
> > addl %esp,4
> > 
> 
> This is a near 'call'.
> 
> 	pushl $0xfffff000
> 	ret
> 

I hate answering my own stuff......... This gets back and modifies
no registers.

Actually I should be:

	pushl	$next_address	# Where to go when the call returns
	pushl	$0xfffff000	# Put this on the stack
	ret			# 'Return' to it (jump)
next_address:			# Were we end up after



Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


