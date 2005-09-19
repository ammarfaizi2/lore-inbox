Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbVISHIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbVISHIy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 03:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVISHIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 03:08:54 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:59082 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932344AbVISHIx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 03:08:53 -0400
Date: Mon, 19 Sep 2005 12:37:24 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>
Subject: Re: PATCH: Fix race in cpu_down (hotplug cpu)
Message-ID: <20050919070724.GA9937@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <59D45D057E9702469E5775CBB56411F171F7E0@pdsmsx406> <20050919051024.GA8653@in.ibm.com> <1127107887.3958.9.camel@linux-hp.sh.intel.com> <20050919055715.GE8653@in.ibm.com> <1127110271.9696.97.camel@localhost> <20050919062336.GA9466@in.ibm.com> <1127111830.4087.3.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127111830.4087.3.camel@linux-hp.sh.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 02:37:09PM +0800, Shaohua Li wrote:
> > -			if (need_resched())
> > +			if (need_resched() || cpu_is_offline(cpu))
> >  				break;
> if the breakpoint is here, you will still have trouble.

[snip]

> Why default_idle should be fine? it can be preempted before the
> 'local_irq_disable' check. 
> Even with Nigel's patch, there is a very
> small window at safe_halt (after 'sti' but before 'hlt').

Good point. Sounds like the patch that Nick has for disabling premption
while it is idle may be a cure for these problems.

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
