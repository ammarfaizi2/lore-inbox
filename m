Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264504AbSIQSpc>; Tue, 17 Sep 2002 14:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264506AbSIQSpc>; Tue, 17 Sep 2002 14:45:32 -0400
Received: from mx1.elte.hu ([157.181.1.137]:9091 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S264504AbSIQSp2>;
	Tue, 17 Sep 2002 14:45:28 -0400
Date: Tue, 17 Sep 2002 20:57:31 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG(): sched.c: Line 944
In-Reply-To: <1032288442.5149.98.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0209172055550.13829-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 17 Sep 2002, Robert Love wrote:

> OK so do we want to do (a):
> 
> (moved down to after the preempt_disable() and release_kernel_lock())
> 
> if (likely(current->state != TASK_ZOMBIE)
> 	if (unlikely((preempt_count() & ~PREEMPT_ACTIVE) != 1))
> 		...
> 
> or go with (b) where we split schedule() into schedule(),
> exit_schedule(), and do_schedule().

i'd do (a). current->state is to be used anyway, and the default-untaken
first branch should be cheap. Plus by moving things down the splitup of
the function would create more code duplication than necessery i think.

	Ingo

