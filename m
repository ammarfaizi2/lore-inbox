Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbVISFZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbVISFZb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 01:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbVISFZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 01:25:31 -0400
Received: from fmr17.intel.com ([134.134.136.16]:12416 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932312AbVISFZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 01:25:30 -0400
Subject: Re: PATCH: Fix race in cpu_down (hotplug cpu)
From: Shaohua Li <shaohua.li@intel.com>
To: vatsa@in.ibm.com
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050919051024.GA8653@in.ibm.com>
References: <59D45D057E9702469E5775CBB56411F171F7E0@pdsmsx406>
	 <20050919051024.GA8653@in.ibm.com>
Content-Type: text/plain
Date: Mon, 19 Sep 2005 13:31:27 +0800
Message-Id: <1127107887.3958.9.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 10:40 +0530, Srivatsa Vaddagiri wrote:
> On Mon, Sep 19, 2005 at 12:48:38PM +0800, Li, Shaohua wrote:
> > I guess Nigel's point is cpu_idle is preempted before take_cpu_down. If
> > the preempt occurs after the cpu_is_offline check, when the cpu (after
> 
> How can that happen? Idle task is running at max priority (MAX_RT_PRIO-1)
> and with SCHED_FIFO policy at this point. If that is indeed happening,
> then we need to modify sched_idle_next not to allow that.
A CPU is idle and then is preempted and starting offline CPU. After
calling stop_machine_run, the CPU goes into idle and it will resume last
idle loop. If the CPU is broken at specific point, then the CPU will
continue executing previous idle and have no chance to call play_dead.
Am I missing anything? Nigel's patch seems can fix the situation for
mwait_idle and poll_idle but can't fix for default_idle in i386 to me.

Thanks,
Shaohua

