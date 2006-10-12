Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWJLSuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWJLSuJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbWJLSuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:50:09 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:54678 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751010AbWJLSuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:50:07 -0400
Date: Thu, 12 Oct 2006 20:42:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] rt-mutex: fixup rt-mutex debug code
Message-ID: <20061012184244.GA27879@elte.hu>
References: <1160658511.2006.120.camel@taijtu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160658511.2006.120.camel@taijtu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> BUG: warning at kernel/rtmutex-debug.c:125/rt_mutex_debug_task_free() (Not tainted)
>  [<c04051e3>] show_trace_log_lvl+0x58/0x16a
>  [<c04057f0>] show_trace+0xd/0x10
>  [<c0405900>] dump_stack+0x19/0x1b
>  [<c043f03d>] rt_mutex_debug_task_free+0x35/0x6a
>  [<c04224c0>] free_task+0x15/0x24
>  [<c042378c>] copy_process+0x12bd/0x1324
>  [<c0423835>] do_fork+0x42/0x113
>  [<c04021dd>] sys_fork+0x19/0x1b
>  [<c0403fb7>] syscall_call+0x7/0xb
> 
> In copy_process(), dup_task_struct() also duplicates the ->pi_lock, 
> ->pi_waiters and ->pi_blocked_on members. rt_mutex_debug_task_free() 
> called from free_task() validates these members. However free_task() 
> can be invoked before these members are reset for the new task.
> 
> Move the initialization code before the first bail that can hit 
> free_task().
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

thanks for tracking this one down!

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
