Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbSLQNK7>; Tue, 17 Dec 2002 08:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbSLQNK7>; Tue, 17 Dec 2002 08:10:59 -0500
Received: from chaos.analogic.com ([204.178.40.224]:35722 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265051AbSLQNK6>; Tue, 17 Dec 2002 08:10:58 -0500
Date: Tue, 17 Dec 2002 08:20:31 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Gianni Tedesco <gianni@ecsc.co.uk>
cc: Margit Schubert-While <margitsw@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 copy_from/to_user
In-Reply-To: <1040129576.1768.14.camel@lemsip>
Message-ID: <Pine.LNX.3.95.1021217081836.22324A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Dec 2002, Gianni Tedesco wrote:

> On Tue, 2002-12-17 at 10:42, Margit Schubert-While wrote:
> > Maybe talking through the top of my hat , however -
> > copy_from_user and copy_to_user are used all over the place and the
> > return tested to see if an EFAULT should be generated.
> > Looking at include/asm-i386/uaccess.h and arch/i386/lib/usercopy.c
> > I don't see how these return anything but the 3rd (length) param.
> 
> Kernel glibly copies data until a exception occurs, when that happens it
> looks at the address of the faulting instruction and jumps to some fixup
> code, which somehow makes the function returns the truncated value.
> 
> grep for ".section .fixup" and ".section .__ex_table." in those files.
> 

The 'somehow' is that ecx contains the count which is decremented
until the exception occurs. So, the return value (in eax) is the
remaining count. If no exception occurs, then it will be zero.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


