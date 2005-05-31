Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVEaKlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVEaKlO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 06:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVEaKlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 06:41:13 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:25284 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261708AbVEaKkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 06:40:46 -0400
Date: Tue, 31 May 2005 16:10:55 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Shaohua Li <shaohua.li@intel.com>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Rusty Russell <rusty@rustcorp.com.au>, ashok.raj@intel.com
Subject: Re: [PATCH]CPU hotplug breaks wake_up_new_task
Message-ID: <20050531104055.GA9908@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <1117524909.3820.11.camel@linux-hp.sh.intel.com> <20050531094045.GA9884@in.ibm.com> <429C3265.4010704@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429C3265.4010704@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 07:46:13PM +1000, Nick Piggin wrote:
> And this patch will break balance-on-fork.

Right :-)

> How about conditionally setting task_cpu if the task's current
> CPU is offline?

Something like this?

--- kernel/fork.c.org	2005-05-31 14:57:15.000000000 +0530
+++ kernel/fork.c	2005-05-31 16:06:41.000000000 +0530
@@ -1024,7 +1024,8 @@ static task_t *copy_process(unsigned lon
 	 * parent's CPU). This avoids alot of nasty races.
 	 */
 	p->cpus_allowed = current->cpus_allowed;
-	if (unlikely(!cpu_isset(task_cpu(p), p->cpus_allowed)))
+	if (unlikely(!cpu_isset(task_cpu(p), p->cpus_allowed) ||
+		     !cpu_online(task_cpu(p))))
 		set_task_cpu(p, smp_processor_id());
 
 	/*



-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
