Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264252AbSIQPWC>; Tue, 17 Sep 2002 11:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264263AbSIQPWB>; Tue, 17 Sep 2002 11:22:01 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44293 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264252AbSIQPWB>; Tue, 17 Sep 2002 11:22:01 -0400
Date: Tue, 17 Sep 2002 08:27:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG(): sched.c: Line 944
In-Reply-To: <1032253191.4592.15.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0209170823130.3942-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 17 Sep 2002, Robert Love wrote:
> 
> Now, remind me why this is all worth it...

I really think we need this to have a stable system. Alan still thinks 
preempt is unstable, and this helps counter some of that - by adding 
sanity checks that all the counters are doing the right thing.

Also, it's one more reason to support preemption in the first place.  
Having lower latency is all fine, but not everybody cares and clearly
preemption adds its own overhead. Having the preemption infrastructure add
its own set of help (ie helping find not only preempt-related bugs, but
spinlock bugs too) makes preempt all the more useful.

In particular, with preempt we can add atomicity debugging to "put_user()"  
and friends, to verify that nobody tries to do user-mode accesses when
they aren't allowed to - another use for "in_atomic()". But that's 
requires a functioning in_atomic() that isn't too limited to be generally 
used..

		Linus

