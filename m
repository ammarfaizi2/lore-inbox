Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263326AbSIPXKL>; Mon, 16 Sep 2002 19:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263327AbSIPXKL>; Mon, 16 Sep 2002 19:10:11 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:3077
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263326AbSIPXKK>; Mon, 16 Sep 2002 19:10:10 -0400
Subject: Re: [PATCH] BUG(): sched.c: Line 944
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209161524500.1451-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0209161524500.1451-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Sep 2002 19:15:09 -0400
Message-Id: <1032218110.1203.63.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-16 at 18:26, Linus Torvalds wrote:

> On 16 Sep 2002, Robert Love wrote:
> > 
> > At least for now, can we please revert the check to in_interrupt() ?
> 
> I really think the test is correct, and if we revert it now, we certainly 
> won't be able to re-introduce it later when we're closer to 2.6.
> 
> So if the in_atomic() change is enough to fix everything but do_exit(), 
> then how about just making do_exit() use PREEMPT_ACTIVE instead?

Nope.  If PREEMPT_ACTIVE is set, schedule() assumes the task is being
preempted and skips certain logic e.g. deactivate_task() (this is the
same code that lets us safely preempt a TASK_ZOMBIE).

Result is death before init even executes.

Ugh...

	Robert Love

