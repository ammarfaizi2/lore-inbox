Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263211AbSIPWVc>; Mon, 16 Sep 2002 18:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263212AbSIPWVb>; Mon, 16 Sep 2002 18:21:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:523 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263211AbSIPWV3>; Mon, 16 Sep 2002 18:21:29 -0400
Date: Mon, 16 Sep 2002 15:26:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG(): sched.c: Line 944
In-Reply-To: <1032214552.1203.55.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0209161524500.1451-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 Sep 2002, Robert Love wrote:
> 
> But, ugh, more fun: we preempt_disable() in do_exit().  Every exiting
> task hits the test.  My syslog is huge.
> 
> At least for now, can we please revert the check to in_interrupt() ?

I really think the test is correct, and if we revert it now, we certainly 
won't be able to re-introduce it later when we're closer to 2.6.

So if the in_atomic() change is enough to fix everything but do_exit(), 
then how about just making do_exit() use PREEMPT_ACTIVE instead?

		Linus

