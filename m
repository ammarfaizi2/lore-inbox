Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290707AbSA3Wpa>; Wed, 30 Jan 2002 17:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290709AbSA3WpZ>; Wed, 30 Jan 2002 17:45:25 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:21512 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S290707AbSA3WpN>; Wed, 30 Jan 2002 17:45:13 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] per-cpu areas for 2.5.3-pre6 
In-Reply-To: Your message of "Wed, 30 Jan 2002 00:22:04 -0800."
             <20020130002204.A4480@are.twiddle.net> 
Date: Thu, 31 Jan 2002 09:45:45 +1100
Message-Id: <E16W3U9-0004Pd-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020130002204.A4480@are.twiddle.net> you write:
> Have we already forgotten the ppc reloc flamefest?  Better
> written as
>
> #define per_cpu(var, cpu)					\
>   ({ __typeof__(&(var)) __ptr;					\
>      __asm__ ("" : "=g"(__ptr)					\
> 	      : "0"((void *)&(var) + per_cpu_offset(cpu)));	\
>      *__ptr; })

"better".  Believe me, I was fully aware, but I refuse to write such
crap unless *proven* to be required.

> > +/* Created by linker magic */
> > +extern char __per_cpu_start, __per_cpu_end;
> [...]
> > +	per_cpu_size = ((&__per_cpu_end - &__per_cpu_start) + PAGE_SIZE-1)
> 
> Will fail on targets (e.g. alpha and mips) that have a notion of a
> "small data area" that can be addressed with special relocs.
> 
> Better written as
> 
>   extern char __per_cpu_start[], __per_cpu_end[];
>   per_cpu_size = (__per_cpu_end - __per_cpu_start) ...

I agree that this is much better.  But do not understand what small
relocs have to do with simple address arithmetic?  You've always been
right before: what am I missing?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
