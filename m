Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264472AbSIQSmb>; Tue, 17 Sep 2002 14:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264486AbSIQSmb>; Tue, 17 Sep 2002 14:42:31 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:46090
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264472AbSIQSm2>; Tue, 17 Sep 2002 14:42:28 -0400
Subject: Re: [PATCH] BUG(): sched.c: Line 944
From: Robert Love <rml@tech9.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209171826160.6719-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0209171826160.6719-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Sep 2002 14:47:22 -0400
Message-Id: <1032288442.5149.98.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-17 at 12:26, Ingo Molnar wrote:

> On Tue, 17 Sep 2002, Linus Torvalds wrote:
> 
> > On the other hand, we do have other ways to test the preempt count
> > inside the scheduler. In particular, we might just move the
> > "in_atomic()" check a few lines downwards, at which point we've released
> > the kernel lock and explicitly disabled preemption, so at that point the
> > test should be even simpler with fewer conditionals..
> 
> indeed ...

OK so do we want to do (a):

(moved down to after the preempt_disable() and release_kernel_lock())

if (likely(current->state != TASK_ZOMBIE)
	if (unlikely((preempt_count() & ~PREEMPT_ACTIVE) != 1))
		...

or go with (b) where we split schedule() into schedule(),
exit_schedule(), and do_schedule().

	Robert Love


