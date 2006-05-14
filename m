Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWENFsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWENFsT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 01:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWENFsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 01:48:19 -0400
Received: from mail.gmx.de ([213.165.64.20]:57570 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751041AbWENFsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 01:48:19 -0400
X-Authenticated: #14349625
Subject: Re: rt20 scheduling latency testcase and failure data
From: Mike Galbraith <efault@gmx.de>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: Lee Revell <rlrevell@joe-job.com>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <1147578414.7738.11.camel@homer>
References: <200605121924.53917.dvhltc@us.ibm.com>
	 <200605131106.16864.dvhltc@us.ibm.com> <1147544472.6535.294.camel@mindpipe>
	 <200605131601.31880.dvhltc@us.ibm.com>  <1147578414.7738.11.camel@homer>
Content-Type: text/plain
Date: Sun, 14 May 2006 07:48:38 +0200
Message-Id: <1147585718.9372.15.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-14 at 05:47 +0200, Mike Galbraith wrote:
> On Sat, 2006-05-13 at 16:01 -0700, Darren Hart wrote:
> > On Saturday 13 May 2006 11:21, Lee Revell wrote:
> > > On Sat, 2006-05-13 at 11:06 -0700, Darren Hart wrote:
> > > >      1 [softirq-timer/0]
> > >
> > > What happens if you set the softirq-timer threads to 99?
> > >
> > 
> > After setting all 4 softirq-timer threads to prio 99 I seemed to get only 2 
> > failures in 100 runs.
> 
> If you disable printf + fflush in iterations loop, problem goes away?

P.S.

I think it probably will, because...

sched_latency [ea53a0b0]D 00000001     0  8261   7858                8260 (NOTLB)
e29a0e70 e29a0e58 00000008 00000001 df6158e0 00000000 623266f4 0000017d 
       b23d45c4 efd53870 dfcb8dc0 efd53870 00000000 000011e6 ea53a1e8 ea53a0b0 
       efdf0d30 b2454560 623e5018 0000017d 00000001 efdf0d30 00000100 00000000 
Call Trace:
 [<b1038454>] __rt_mutex_adjust_prio+0x1f/0x24 (112)
 [<b1038ad8>] task_blocks_on_rt_mutex+0x1b6/0x1c9 (16)
 [<b13bfeb1>] schedule+0x34/0x10b (24)
 [<b13c0963>] rt_mutex_slowlock+0xc7/0x258 (28)
 [<b13c0bb6>] rt_mutex_lock+0x3f/0x43 (100)
 [<b1039075>] rt_down+0x12/0x32 (20)
 [<b13c14a7>] lock_kernel+0x1d/0x23 (16)
 [<b1228246>] tty_write+0x119/0x21b (12)
 [<b122b758>] write_chan+0x0/0x338 (24)
 [<b10352bd>] hrtimer_wakeup+0x0/0x1c (20)
 [<b10671f0>] vfs_write+0xc1/0x19b (24)
 [<b1067bfa>] sys_write+0x4b/0x74 (40)
 [<b1002eeb>] sysenter_past_esp+0x54/0x75 (40)

...generated via SysRq-T, induces...

PERIOD MISSED!
     scheduled delta:     4964 us
        actual delta:     4974 us
             latency:       10 us
---------------------------------------
      previous start:  1750012 us
                 now: 13122245 us
     scheduled start:  1755000 us
next scheduled start is in the past!


