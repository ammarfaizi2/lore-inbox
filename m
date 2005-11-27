Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbVK0QkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVK0QkN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 11:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbVK0QkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 11:40:12 -0500
Received: from fsmlabs.com ([168.103.115.128]:50080 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751095AbVK0QkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 11:40:11 -0500
X-ASG-Debug-ID: 1133109604-366-74-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Sun, 27 Nov 2005 08:45:47 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Raj, Ashok" <ashok.raj@intel.com>,
       Stephen Hemminger <shemminger@osdl.org>
X-ASG-Orig-Subj: Re: [PATCH] i386/x86_64: Don't IPI to offline cpus on shutdown
Subject: Re: [PATCH] i386/x86_64: Don't IPI to offline cpus on shutdown
In-Reply-To: <m1wtiufa9z.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.61.0511270836120.20046@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0511270115020.20046@montezuma.fsmlabs.com>
 <20051127135833.GH20775@brahms.suse.de> <m1wtiufa9z.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.5625
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Nov 2005, Eric W. Biederman wrote:

> Andi Kleen <ak@suse.de> writes:
> 
> > On Sun, Nov 27, 2005 at 02:05:45AM -0800, Zwane Mwaikambo wrote:
> >> http://bugzilla.kernel.org/show_bug.cgi?id=5203
> >> 
> >> There is a small race during SMP shutdown between the processor issuing 
> >> the shutdown and the other processors clearing themselves off the 
> >> cpu_online_map as they do this without using the normal cpu offline 
> >> synchronisation. To avoid this we should wait for all the other processors 
> >> to clear their corresponding bits and then proceed. This way we can safely 
> >> make the cpu_online test in smp_send_reschedule, it's safe during normal 
> >> runtime as smp_send_reschedule is called with a lock held / preemption 
> >> disabled.
> >
> > Looking at the backtrace in the bug - how can sys_reboot call do_exit???
> > I would say the problem is in whatever causes that. It shouldn't 
> > do that. sys_reboot shouldn't schedule, it's that simple.
> > Your patch is just papering over that real bug.
> 
> sys_reboot in the case of halt (after everything else is done)
> has directly called do_exit for years.
> 
> There are some very subtle interactions there.  The one
> I always remember (having found it the hard way) is that
> interrupts must be left on so ctrl-alt-del still works.
> 
> This do_exit may be something similar, although I can't
> think of how it could be useful.

I wondered the same thing, perhaps i am papering over the bug, what 
exactly is do_exit doing there?
