Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317660AbSFLHSL>; Wed, 12 Jun 2002 03:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317661AbSFLHSK>; Wed, 12 Jun 2002 03:18:10 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:7623 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317656AbSFLHSI>; Wed, 12 Jun 2002 03:18:08 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support 
Cc: akpm@zip.com.au, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        k-suganuma@mvj.biglobe.ne.jp
In-Reply-To: Your message of "Tue, 11 Jun 2002 02:10:43 MST."
             <20020611.021043.04190747.davem@redhat.com> 
Date: Wed, 12 Jun 2002 16:58:23 +1000
Message-Id: <E17I25H-0002hf-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020611.021043.04190747.davem@redhat.com> you write:
>    From: Rusty Russell <rusty@rustcorp.com.au>
>    Date: Tue, 11 Jun 2002 19:09:44 +1000
> 
>    In message <3D05A9E8.FF0DA223@zip.com.au> you write:
>    > and slowdown:
>    
>    ARGH!  STOP IT!  I realize it's 'leet to be continually worrying about
>    possible microoptimizations, but I challenge you to *measure* the
>    slowdown between:
> 
> Regardless, his space arguments still hold.

	You can allocate based on cpu_possible(cpu) (which is in the
next patch) if you like, but I think you're better off fixing the
existing NR_CPUS bloat as well, and keeping all the code simple.

> I don't like having everyone eat the overhead that hotplugging cpus
> seem to entail.

	But there's an important difference between something which is
simple and unoptimized, and something which is unoptimizable.

> And remember, it's the anal "every microoptimization at all costs"
> people that keep the kernel sane and from running out of control bloat
> wise.

But it also gave us crap like net/ipv4/route.c:ip_rt_acct_read() 8(

I know *you* benchmark and read the asm during optimization, but it's
quite clear that others are so scared of "bloat" criticism that they
optimize without measuring the straightforward case *first*.

Remember, to be cool:
	1) Use bitops and memory barriers not spinlocks,
	2) Use inlines everywhere,
	3) Use likely()/unlikely() on every branch
	4) Use prefetch() everywhere,
	5) Use gotos to minimize the path length
	6) __set_current_state() not set_current_state()
	7) Pass in current as a function param

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
