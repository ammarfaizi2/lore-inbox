Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbVISHG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbVISHG3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 03:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVISHG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 03:06:29 -0400
Received: from fmr19.intel.com ([134.134.136.18]:64748 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932177AbVISHG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 03:06:28 -0400
Subject: Re: PATCH: Fix race in cpu_down (hotplug cpu)
From: Shaohua Li <shaohua.li@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: vatsa@in.ibm.com, Nigel Cunningham <ncunningham@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1127111784.5272.10.camel@npiggin-nld.site>
References: <59D45D057E9702469E5775CBB56411F171F7E0@pdsmsx406>
	 <20050919051024.GA8653@in.ibm.com>
	 <1127107887.3958.9.camel@linux-hp.sh.intel.com>
	 <20050919055715.GE8653@in.ibm.com> <1127110271.9696.97.camel@localhost>
	 <20050919062336.GA9466@in.ibm.com>
	 <1127111830.4087.3.camel@linux-hp.sh.intel.com>
	 <1127111784.5272.10.camel@npiggin-nld.site>
Content-Type: text/plain
Date: Mon, 19 Sep 2005 15:12:10 +0800
Message-Id: <1127113930.4087.6.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 16:36 +1000, Nick Piggin wrote:
> On Mon, 2005-09-19 at 14:37 +0800, Shaohua Li wrote:
> > On Mon, 2005-09-19 at 11:53 +0530, Srivatsa Vaddagiri wrote:
> 
> > > default_idle should be fine as it is. IOW it should not cause __cpu_die to 
> > > timeout.
> > Why default_idle should be fine? it can be preempted before the
> > 'local_irq_disable' check. Even with Nigel's patch, there is a very
> > small window at safe_halt (after 'sti' but before 'hlt').
> > 
> 
> Ah, actually I have a patch which makes all CPU idle threads
> run with preempt disabled and only enable preempt when scheduling.
> Would that help?
It should solve the issue to me. Should we take care of the latency?
acpi_processor_idle might execute for a long time.

Thanks,
Shaohua

