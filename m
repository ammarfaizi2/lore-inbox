Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265198AbSLQRC4>; Tue, 17 Dec 2002 12:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbSLQRC4>; Tue, 17 Dec 2002 12:02:56 -0500
Received: from chaos.analogic.com ([204.178.40.224]:51338 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265198AbSLQRCz>; Tue, 17 Dec 2002 12:02:55 -0500
Date: Tue, 17 Dec 2002 12:13:04 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <3DFF51A3.5010201@colorfullife.com>
Message-ID: <Pine.LNX.3.95.1021217120925.25972A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2002, Manfred Spraul wrote:

> >
> >
> >   pushl %ebp
> >   movl $0xfffff000, %ebp
> >   call *%ebp
> >   popl %ebp
> >  
> >
> 
> You could avoid clobbering a register with something like
> 
> pushl $0xfffff000
> call *(%esp)
> addl %esp,4
> 

This is a near 'call'.

	pushl $0xfffff000
	ret

This is a 'far' 'call' that I think you will need to reload the segment
back to user-mode segments on the return.

	pushl	$KERNEL_CS
	pushl	$0xfffff000
	lret




Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


