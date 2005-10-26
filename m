Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751513AbVJ0ABw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbVJ0ABw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 20:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbVJ0ABw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 20:01:52 -0400
Received: from unused.mind.net ([69.9.134.98]:6021 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S1751513AbVJ0ABv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 20:01:51 -0400
Date: Wed, 26 Oct 2005 16:54:17 -0700 (PDT)
From: William Weston <weston@lysdexia.org>
To: john stultz <johnstul@us.ibm.com>
cc: Rui Nuno Capela <rncbc@rncbc.org>, george@mvista.com,
       Ingo Molnar <mingo@elte.hu>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU
Subject: Re: 2.6.14-rc4-rt7
In-Reply-To: <1130369591.27168.358.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0510261641540.20624@echo.lysdexia.org>
References: <1129852531.5227.4.camel@cmn3.stanford.edu>  <20051021080504.GA5088@elte.hu>
 <1129937138.5001.4.camel@cmn3.stanford.edu>  <20051022035851.GC12751@elte.hu>
  <1130182121.4983.7.camel@cmn3.stanford.edu>  <1130182717.4637.2.camel@cmn3.stanford.edu>
  <1130183199.27168.296.camel@cog.beaverton.ibm.com>  <20051025154440.GA12149@elte.hu>
  <1130264218.27168.320.camel@cog.beaverton.ibm.com>  <435E91AA.7080900@mvista.com>
 <20051026082800.GB28660@elte.hu>  <435FA8BD.4050105@mvista.com>
 <435FBA34.5040000@mvista.com>  <435FEAE7.8090104@rncbc.org> 
 <Pine.LNX.4.58.0510261449310.20155@echo.lysdexia.org>
 <1130369591.27168.358.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2005, john stultz wrote:

> On Wed, 2005-10-26 at 15:07 -0700, William Weston wrote:
> > On Wed, 26 Oct 2005, Rui Nuno Capela wrote:
> > 
> > > Just noticed a couple or more of this on dmesg. Maybe its old news and 
> > > being discussed already. Otherwise my P4@2.53Ghz/UP laptop boots and 
> > > runs without hicups on 2.6.14-rc5-rt7 (config.gz attached).
> > > 
> > > ... time warped from 13551912584 to 13551905960.
> > > ... system time:     13488892865 .. 13488892865.
> > > udevstart/1579[CPU#0]: BUG in get_monotonic_clock_ts at 
> > > kernel/time/timeofday.c:
> > > 262
> > >   [<c0116fcb>] __WARN_ON+0x4f/0x6c (8)
> > >   [<c012f8b0>] get_monotonic_clock_ts+0x27a/0x2f0 (40)
> > >   [<c0141c9d>] kmem_cache_alloc+0x51/0xac (76)
> > >   [<c0114826>] copy_process+0x2ff/0xeed (44)
> > >   [<c0139444>] unlock_page+0x17/0x4a (12)
> > >   [<c0147a8a>] do_wp_page+0x245/0x372 (20)
> > >   [<c01154f5>] do_fork+0x69/0x1b5 (56)
> > >   [<c02c120b>] do_page_fault+0x432/0x543 (32)
> > >   [<c01017aa>] sys_clone+0x32/0x36 (72)
> > >   [<c0102a9b>] sysenter_past_esp+0x54/0x75 (16)
> > 
> > I'm getting these with two different machines running 2.6.14-rc5-rt7 with
> > Steven's ktimer_interrupt() patch from yesterday.  Did not see these with
> > previous -rt kernels.  Shutting down NTP makes no difference.
> > 
> > This is from the athlon-xp/via-kt400 box (xeon smt box looks similar):
> 
> I'm grabbing rt7 to try to reproduce this. Not yet sure what the cause
> could be. From Rui's dmesg the tsc clocksource was being used, I assume
> this is the case with you as well, William?

Yes, tsc is used:

Time: tsc clocksource has been installed.
Ktimers: Switched to high resolution mode CPU 0

Full dmesg and config is attached to my previous email.  I just built a 
debug -rt7 so I can grab some latency traces if need be.  Should I try 
disabling high res timers?


Cheers,
--ww
