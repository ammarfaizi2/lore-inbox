Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbVISGLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbVISGLP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 02:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbVISGLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 02:11:15 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:11967 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932326AbVISGLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 02:11:14 -0400
Subject: Re: PATCH: Fix race in cpu_down (hotplug cpu)
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: vatsa@in.ibm.com
Cc: Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050919055715.GE8653@in.ibm.com>
References: <59D45D057E9702469E5775CBB56411F171F7E0@pdsmsx406>
	 <20050919051024.GA8653@in.ibm.com>
	 <1127107887.3958.9.camel@linux-hp.sh.intel.com>
	 <20050919055715.GE8653@in.ibm.com>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1127110271.9696.97.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 19 Sep 2005 16:11:11 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-09-19 at 15:57, Srivatsa Vaddagiri wrote:
> On Mon, Sep 19, 2005 at 01:31:27PM +0800, Shaohua Li wrote:
> > A CPU is idle and then is preempted and starting offline CPU. After
> > calling stop_machine_run, the CPU goes into idle and it will resume last
> > idle loop. If the CPU is broken at specific point, then the CPU will
> > continue executing previous idle and have no chance to call play_dead.
> 
> Ok, that makes sense. Nigel, could you confirm which idle routine you are 
> using?

>From dmesg:

monitor/mwait feature present.
using mwait in idle threads.

> > Am I missing anything? Nigel's patch seems can fix the situation for
> > mwait_idle and poll_idle but can't fix for default_idle in i386 to me.
> 
> I would say the right fix here is for poll_idle and mwait_idle (& similar
> other idle routines) to monitor 'cpu_offline' flag in addition to need_resched 
> flag, rather than what Nigel has suggested. 

Ok, but what about default_idle?

Regards,

Nigel

