Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319441AbSH2WRe>; Thu, 29 Aug 2002 18:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319435AbSH2WQy>; Thu, 29 Aug 2002 18:16:54 -0400
Received: from [195.39.17.254] ([195.39.17.254]:16768 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319438AbSH2WNZ>;
	Thu, 29 Aug 2002 18:13:25 -0400
Date: Wed, 28 Aug 2002 12:11:30 +0000
From: Pavel Machek <pavel@suse.cz>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH 1 / ...] i386 dynamic fixup/self modifying code
Message-ID: <20020828121129.A35@toy.ucw.cz>
References: <1030506106.1489.27.camel@ldb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <1030506106.1489.27.camel@ldb>; from ldb@ldb.ods.org on Wed, Aug 28, 2002 at 05:41:46AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch implements a system that modifies the kernel code at runtime
> depending on CPU features and SMPness.

Nice!

> This patch requires the is_smp() patch I posted earlier and also
> requires the new CPU selection code and the code that actually uses
> both.
> This code already exists, but needs a few adjustments so it may not
> arrive immediately.
> 
> The code is invoked in the following ways:
>         * Undefined exception handler: this is used to replace
>           unsupported instructions with supported ones. Used for invlpg
>           -> flushall, prefetchnta -> prefetch -> nop, *fence -> lock
>           addl 0, (%esp), movntq -> movq
>         * Int3 handler: this is used when a 1 byte opcode is desired.
>           This is controlled by a config option so that debuggers and
>           kprobe won't break. Used for lock/nop and APIC write

Why not do *everything* using int3 handler? It should simplify your code.

Hooking on 'unknown instruction' should not be really neccessary if you
replace all invlpgs (etc) with 0xcc...
								Pavel 
> Unfortunately with this patch executing invalid code will cause the
> processor to enter an infinite exception loop rather than panic. Fixing
> this is not trivial for SMP+preempt so it's not done at the moment.

Using 0xcc for everything should fix that, right?

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

