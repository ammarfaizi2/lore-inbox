Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290721AbSA3XBK>; Wed, 30 Jan 2002 18:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290732AbSA3XA5>; Wed, 30 Jan 2002 18:00:57 -0500
Received: from [202.135.142.194] ([202.135.142.194]:62735 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S290728AbSA3XAR>; Wed, 30 Jan 2002 18:00:17 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] per-cpu areas for 2.5.3-pre6 
In-Reply-To: Your message of "Wed, 30 Jan 2002 13:43:09 MDT."
             <Pine.LNX.4.44.0201301259520.11802-100000@waste.org> 
Date: Thu, 31 Jan 2002 10:00:51 +1100
Message-Id: <E16W3il-0004QF-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0201301259520.11802-100000@waste.org> you write:
> I still think that tracking per_cpu_offset in task struct to eventually
> replace current->processor is a win. Basically everyone except Sparc goes
> through current anyway for smp_processor_id and Sparc caches current in a
> register. Please elucidate your reference to "arch-specific tradeoffs".

Placing useful information in the task struct is a hack.  A useful
hack on the register-starved x86, of course.  PPC64 will probably use
a register, too.

BTW, apologies for my previous accusations of not reading the
thread. Your reply predated mine by 12 hours:
	http://www.ozlabs.org/~rusty/Stupidity.html#9

> Also, it'd be nice to unmap the original copy of the area or at least
> poison it to catch silent references to var without going through
> this_cpu, which will probably prove very hard to find. If there were a way
> to do this at the C source level and catch such things at compile time,
> that'd be even better, but I can't see a way to do it without grotty
> macros.

My first cut did this, with a macro:

DECLARE_PER_CPU(int x);

This allows you to munge x into x__per_cpu, to catch "bare"
references.  But I decided against it for two reasons: firstly
__per_cpu_data is nicer, and secondly my proc/sys rewrite can handle
per-cpu data easily if the name is valid.

In practice, grep should be sufficient.

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
