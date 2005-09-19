Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbVISF5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVISF5l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 01:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbVISF5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 01:57:41 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:20983 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932259AbVISF5k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 01:57:40 -0400
Date: Mon, 19 Sep 2005 11:27:15 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>
Subject: Re: PATCH: Fix race in cpu_down (hotplug cpu)
Message-ID: <20050919055715.GE8653@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <59D45D057E9702469E5775CBB56411F171F7E0@pdsmsx406> <20050919051024.GA8653@in.ibm.com> <1127107887.3958.9.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127107887.3958.9.camel@linux-hp.sh.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 01:31:27PM +0800, Shaohua Li wrote:
> A CPU is idle and then is preempted and starting offline CPU. After
> calling stop_machine_run, the CPU goes into idle and it will resume last
> idle loop. If the CPU is broken at specific point, then the CPU will
> continue executing previous idle and have no chance to call play_dead.

Ok, that makes sense. Nigel, could you confirm which idle routine you are 
using?

> Am I missing anything? Nigel's patch seems can fix the situation for
> mwait_idle and poll_idle but can't fix for default_idle in i386 to me.

I would say the right fix here is for poll_idle and mwait_idle (& similar
other idle routines) to monitor 'cpu_offline' flag in addition to need_resched 
flag, rather than what Nigel has suggested. 

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
