Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265255AbUEZGPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbUEZGPJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 02:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265312AbUEZGPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 02:15:09 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:13783 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265255AbUEZGPD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 02:15:03 -0400
Date: Wed, 26 May 2004 11:46:13 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: torvalds@osdl.org
Cc: Ashok Raj <ashok.raj@intel.com>, nickpiggin@yahoo.com.au,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [CPU Hotplug PATCH] Restore Idle task's priority during CPU_DEAD notification
Message-ID: <20040526061613.GA18314@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <A28EFEDC5416054BA1026D892753E9AF059A50EC@orsmsx404.amr.corp.intel.com> <1085537205.2639.61.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085537205.2639.61.camel@bach>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
	Patch below (against 2.6.7-rc1) fixes a CPU Hotplug problem wherein
idle task's "->prio" value is not restored to MAX_PRIO during CPU_DEAD 
handling. Without this patch, once a CPU is offlined and then later onlined, it 
becomes "more or less" useless (does not run any task other than its idle task!)
Please apply.


---

 linux-2.6.7-rc1-vatsa/kernel/sched.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN kernel/sched.c~restore_idle_prio kernel/sched.c
--- linux-2.6.7-rc1/kernel/sched.c~restore_idle_prio	2004-05-25 17:04:19.000000000 +0530
+++ linux-2.6.7-rc1-vatsa/kernel/sched.c	2004-05-25 17:04:34.000000000 +0530
@@ -3569,6 +3569,7 @@ static int migration_call(struct notifie
 		rq = task_rq_lock(rq->idle, &flags);
 		deactivate_task(rq->idle, rq);
 		__setscheduler(rq->idle, SCHED_NORMAL, MAX_PRIO);
+		rq->idle->prio = MAX_PRIO;
 		task_rq_unlock(rq, &flags);
  		BUG_ON(rq->nr_running != 0);
 

_
On Wed, May 26, 2004 at 12:06:46PM +1000, Rusty Russell wrote:
> On Wed, 2004-05-26 at 02:35, Raj, Ashok wrote:
> > Thanks Vatsa...
> > 
> > It seems to work right now....
> 
> It seems obviously correct and harmless to me.  As it also fixes a
> problem, I'd say this should go to Linus & Andrew ASAP.
> 
> Thanks!
> Rusty.
> -- 
> Anyone who quotes me in their signature is an idiot -- Rusty Russell
> 

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
