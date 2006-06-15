Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031220AbWFOTs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031220AbWFOTs1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 15:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031225AbWFOTs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 15:48:27 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:54164 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1031220AbWFOTs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 15:48:26 -0400
Subject: Re: [PATCH 0/3] posix cpu timers fixes
From: john stultz <johnstul@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Roland McGrath <roland@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060615160931.GA21450@oleg>
References: <20060615160931.GA21450@oleg>
Content-Type: text/plain
Date: Thu, 15 Jun 2006 12:48:14 -0700
Message-Id: <1150400894.15267.16.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-15 at 20:09 +0400, Oleg Nesterov wrote:
> John Stultz hit run_posix_cpu_timers()->BUG_ON(tsk->exit_state), see
> 
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=115015841413687
> 
> This was fixed by
> 
> 	Commit 3de463c7d9d58f8cf3395268230cb20a4c15bffa
> 	[PATCH] posix-timers: remove false BUG_ON() from run_posix_cpu_timers()
> 	(now re-sended as [PATCH 2/3])
> 
> but it was reverted because it triggered a problem,

Again, just to be clear, I only hit the BUG_ON when using the -RT tree,
which is likely due to the fact that run_posix_cpu_timers() runs from a
kernel thread rather then interrupt context (thus tsk is not current and
you're more likely to race against an exiting task).

It may very well be the issue applies to mainline as well, but I just
want to make sure the proper caution is taken.


> With these patches applied Chris's program exits without any problems.
> 
> John, could you please try these patches while you are testing posix
> cpu timers?

I will give them a go. Some of them are already in the -rt tree, as they
were triggered early on.

thanks
-john

