Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264456AbSIQSe2>; Tue, 17 Sep 2002 14:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264471AbSIQSe2>; Tue, 17 Sep 2002 14:34:28 -0400
Received: from mx1.elte.hu ([157.181.1.137]:8578 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S264456AbSIQSe2>;
	Tue, 17 Sep 2002 14:34:28 -0400
Date: Tue, 17 Sep 2002 20:46:29 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG(): sched.c: Line 944
In-Reply-To: <1032287273.4593.31.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0209172039380.13829-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 17 Sep 2002, Robert Love wrote:

> [...] How can this in_atomic() test _ever_ catch a preemption bug?  We
> cannot enter the scheduler off kernel preemption unless
> preempt_count==0.  This is a test to catch bugs in other parts of the
> kernel, e.g. where code explicitly calls schedule() while holding a
> lock.

you are right, i was confusing this with the older check for disabled
interrupt in preempt_schedule() [which i'd still find useful].

The smp_processor_id() test catches true preemption bugs. So does
preempt_count() underflow detection.

i do agree with Alan - there can be nothing bad in trying to fix all that
non-preempt-aware code right now, before it becomes too late.

	Ingo

