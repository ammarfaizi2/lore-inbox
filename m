Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbVJZX6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbVJZX6V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 19:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbVJZX6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 19:58:21 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:58041 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751269AbVJZX6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 19:58:21 -0400
Subject: Re: 2.6.14-rc4-rt7
From: Steven Rostedt <rostedt@goodmis.org>
To: William Weston <weston@lysdexia.org>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, george@mvista.com,
       Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU
In-Reply-To: <Pine.LNX.4.58.0510261449310.20155@echo.lysdexia.org>
References: <1129852531.5227.4.camel@cmn3.stanford.edu>
	 <20051021080504.GA5088@elte.hu> <1129937138.5001.4.camel@cmn3.stanford.edu>
	 <20051022035851.GC12751@elte.hu>
	 <1130182121.4983.7.camel@cmn3.stanford.edu>
	 <1130182717.4637.2.camel@cmn3.stanford.edu>
	 <1130183199.27168.296.camel@cog.beaverton.ibm.com>
	 <20051025154440.GA12149@elte.hu>
	 <1130264218.27168.320.camel@cog.beaverton.ibm.com>
	 <435E91AA.7080900@mvista.com> <20051026082800.GB28660@elte.hu>
	 <435FA8BD.4050105@mvista.com> <435FBA34.5040000@mvista.com>
	 <435FEAE7.8090104@rncbc.org>
	 <Pine.LNX.4.58.0510261449310.20155@echo.lysdexia.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 26 Oct 2005 19:57:22 -0400
Message-Id: <1130371042.21118.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-26 at 15:07 -0700, William Weston wrote:
> On Wed, 26 Oct 2005, Rui Nuno Capela wrote:
> 
> > Just noticed a couple or more of this on dmesg. Maybe its old news and 
> > being discussed already. Otherwise my P4@2.53Ghz/UP laptop boots and 
> > runs without hicups on 2.6.14-rc5-rt7 (config.gz attached).
> > 
> > ... time warped from 13551912584 to 13551905960.
> > ... system time:     13488892865 .. 13488892865.
> > udevstart/1579[CPU#0]: BUG in get_monotonic_clock_ts at 
> > kernel/time/timeofday.c:
> > 262
> >   [<c0116fcb>] __WARN_ON+0x4f/0x6c (8)
> >   [<c012f8b0>] get_monotonic_clock_ts+0x27a/0x2f0 (40)
> >   [<c0141c9d>] kmem_cache_alloc+0x51/0xac (76)
> >   [<c0114826>] copy_process+0x2ff/0xeed (44)
> >   [<c0139444>] unlock_page+0x17/0x4a (12)
> >   [<c0147a8a>] do_wp_page+0x245/0x372 (20)
> >   [<c01154f5>] do_fork+0x69/0x1b5 (56)
> >   [<c02c120b>] do_page_fault+0x432/0x543 (32)
> >   [<c01017aa>] sys_clone+0x32/0x36 (72)
> >   [<c0102a9b>] sysenter_past_esp+0x54/0x75 (16)
> 
> I'm getting these with two different machines running 2.6.14-rc5-rt7 with
> Steven's ktimer_interrupt() patch from yesterday.  Did not see these with
> previous -rt kernels.  Shutting down NTP makes no difference.

Yeah, that ktimer_interrupt patch was for something completely
different. Is this happening on boot up, or is this consistently
happening?

Also, Rui, do they show up at different times or clustered together?
(William, I see your output is clustered) The reason I asked, is that
the test may produce more than one warning message for the same time
warp. Since the time used to check for the time warp is not updated if
time goes backwards, so if you call the this routine more than once
before the time warp catches back up, it will warn again.

> 
> This is from the athlon-xp/via-kt400 box (xeon smt box looks similar):
> 
> ... time warped from 945167068424 to 945167068179.
> ... system time:     945133952528 .. 945133952528.
> crond/2584[CPU#0]: BUG in get_monotonic_clock_ts at 
> kernel/time/timeofday.c:262
>  [<c011befe>] __WARN_ON+0x5e/0xa0 (8)
>  [<c013610e>] get_monotonic_clock_ts+0x24e/0x2c0 (48)
>  [<c011953d>] copy_process+0x41d/0xf10 (84)
>  [<c011600f>] activate_task+0x5f/0x70 (12)
>  [<c011a12b>] do_fork+0x6b/0x1f0 (68)
>  [<c0335285>] __schedule+0x365/0x6b0 (24)
>  [<c0107302>] do_syscall_trace+0x1d2/0x1f0 (32)
>  [<c01019b2>] sys_clone+0x32/0x40 (28)
>  [<c0102ddd>] syscall_call+0x7/0xb (16)

Is this SMP? And if so, do you get this with UP other than on boot up?

Unfortunately, all my test machines are running other tests that will
take all night to finish, so I can't look into this till tomorrow.

-- Steve


