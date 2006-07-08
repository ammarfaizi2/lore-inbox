Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbWGHUJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbWGHUJL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 16:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030310AbWGHUJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 16:09:11 -0400
Received: from khc.piap.pl ([195.187.100.11]:1241 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S964966AbWGHUJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 16:09:10 -0400
To: Chase Venters <chase.venters@clientec.com>
Cc: "linux-os \\\\(Dick Johnson\\\\)" <linux-os@analogic.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
References: <20060705114630.GA3134@elte.hu>
	<Pine.LNX.4.64.0607071635130.23767@turbotaz.ourhouse>
	<m3wtaoe7rk.fsf@defiant.localdomain>
	<200607080841.38235.chase.venters@clientec.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 08 Jul 2006 22:09:05 +0200
In-Reply-To: <200607080841.38235.chase.venters@clientec.com> (Chase Venters's message of "Sat, 8 Jul 2006 08:41:14 -0500")
Message-ID: <m38xn3j1um.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase Venters <chase.venters@clientec.com> writes:

> You're mincing my words. The reason "memory" is on the clobber list is
> because 
> a lock is supposed to synchronize all memory accesses up to that point. It's 
> a fence / a barrier, because if the compiler re-orders your loads/stores 
> across the lock, you're in trouble. That's exactly what I was pointing out.

Sure, but a barrier alone isn't enough. You have to use assembler and
it's beyond scope of C volatile.

> A volatile cast lets you prevent the compiler from always treating the 
> variable as volatile.

Yes, if that's what you really want.

>> If the "volatile" is used the wrong way (which is probably true for most
>> cases), then volatile cast and barrier() will be wrong as well. You need
>> locks or atomic access, meaningful on hardware level.
>
> No. Linus already described what some example invalid uses of "volatile"
> are. 
> One example is the very one this whole thread is about - using 'volatile' on 
> the declaration of the spinlock counter. That usage is _wrong_, and
> barrier() 
> would not be.

That's a special case, because you want to invalidate all variables,
but you still need locking. I.e., barrier() alone doesn't buy you
anything WRT to hardware.

> Volatile originally existed to tell the compiler a variable could change at 
> will. Because of reordering, it's almost never sufficient with our modern 
> compilers and CPUs. That's precisely where barrier() (and/or its hardware 
> equivalents) help in places where 'volatile' is wrong.

How does barrier() help here? Some example, maybe?
What do you consider a barrier() hardware equivalent?
Don't you think you're mixing compiler optimization and operation of
the hardware?

> Your statement is 
> additionally wrong because one use-case of memory barriers is to safely
> write 
> lock-free code.

You can't safely write lock-free code in C, if you have to deal
with hardware or SMP. C don't know about hardware.
-- 
Krzysztof Halasa
