Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261966AbSJDXNB>; Fri, 4 Oct 2002 19:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261971AbSJDXNA>; Fri, 4 Oct 2002 19:13:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59663 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261966AbSJDXM7>; Fri, 4 Oct 2002 19:12:59 -0400
Date: Fri, 4 Oct 2002 16:20:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@zip.com.au>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 'sticky pages' support in the VM, futex-2.5.38-C5
In-Reply-To: <20021004234706.A6683@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.44.0210041614221.2465-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Oct 2002, Jamie Lokier wrote:
> 
> I thought that futex-based locks were only reliable with PROT_SEM
> memory, for architectures that define PROT_SEM (e.g. PPC) -- because of
> the need for locking primitives to work in a cache coherent manner.

That was my initial thought, to make it portable.

It turns out that all the real uses of it want to just be able to use it 
in a less portable manner, and put futexes anywhere, and in particular in 
perfectly regular anonymous memory.

And since that works fine on all sane hardware, the point of PROT_SEM and 
special casing just wasn't really there.

Does that mean that such common futex usage won't be portable to broken
hardware? Yup. The alternative was to make things cumbersome for
_everybody_, and since 99.9% of all existing hardware is sane (and the 
remaining insane hw base tends to be going away anyway), it looks like it 
was the right decision.

So now glibc can (and does) put semaphores on the stack etc random places, 
without having to worry about it.

		Linus

