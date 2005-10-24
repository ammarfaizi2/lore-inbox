Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbVJXTkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbVJXTkA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 15:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVJXTkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 15:40:00 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.123]:31641 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S1751241AbVJXTj7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 15:39:59 -0400
Subject: Re: 2.6.14-rc4-rt7
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, Mark Knecht <markknecht@gmail.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Steven Rostedt <rostedt@goodmis.org>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU, William Weston <weston@lysdexia.org>
In-Reply-To: <1130182121.4983.7.camel@cmn3.stanford.edu>
References: <1129599029.10429.1.camel@cmn3.stanford.edu>
	 <20051018072844.GB21915@elte.hu>
	 <1129669474.5929.8.camel@cmn3.stanford.edu>
	 <Pine.LNX.4.58.0510181423200.19498@echo.lysdexia.org>
	 <20051019111943.GA31410@elte.hu>
	 <1129835571.14374.11.camel@cmn3.stanford.edu>
	 <20051020191620.GA21367@elte.hu>
	 <1129852531.5227.4.camel@cmn3.stanford.edu> <20051021080504.GA5088@elte.hu>
	 <1129937138.5001.4.camel@cmn3.stanford.edu>
	 <20051022035851.GC12751@elte.hu>
	 <1130182121.4983.7.camel@cmn3.stanford.edu>
Content-Type: text/plain
Date: Mon, 24 Oct 2005 12:38:37 -0700
Message-Id: <1130182717.4637.2.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-24 at 12:28 -0700, Fernando Lopez-Lezcano wrote:
> On Sat, 2005-10-22 at 05:58 +0200, Ingo Molnar wrote: 
> > * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> > 
> > > Here's one with rc5-rt3:
> 
> rc5-rt5, _without_ HIGH_RES_TIMERS. 

Same warnings when booting into the UP kernel, so far no hang but I have
not been logged in for long:

pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: CPU0 (power states: C1[C1])
isapnp: Scanning for PnP cards...
Time: tsc clocksource has been installed.
WARNING: non-monotonic time!
... time warped from 452930691 to 440940768.
udev/33[CPU#0]: BUG in ktime_get at kernel/ktimers.c:103
 [<c012147c>] __WARN_ON+0x5c/0xa0 (8)
 [<c0138105>] ktime_get+0xe5/0x160 (48)
 [<c013848e>] enqueue_ktimer+0x2e/0x330 (64)
 [<c018389f>] dput+0xef/0x220 (4)
 [<c01388fa>] internal_restart_ktimer+0x9a/0x130 (80)
 [<c03509a7>] schedule_ktimer+0x47/0xc0 (44)
 [<c0350a48>] schedule_ktimer_interruptible+0x28/0x50 (20)
 [<c0138f90>] __ktimer_nanosleep+0x40/0xe0 (24)
 [<c017510a>] vfs_lstat+0x1a/0x50 (12)
 [<c013906b>] ktimer_nanosleep+0x3b/0x50 (36)
 [<c0350b50>] nanosleep_restart_mono+0x0/0x30 (8)
 [<c0138dc0>] ktimer_wake_up+0x0/0x10 (64)
 [<c013911c>] sys_nanosleep+0x4c/0x50 (32)
 [<c01031fd>] syscall_call+0x7/0xb (16)
WARNING: non-monotonic time!
... time warped from 452930691 to 441930456.
softirq-timer/0/3[CPU#0]: BUG in ktime_get at kernel/ktimers.c:103
 [<c012147c>] __WARN_ON+0x5c/0xa0 (8)
 [<c0138105>] ktime_get+0xe5/0x160 (48)
 [<c0138cbd>] ktimer_run_queues+0x1d/0x120 (64)
 [<c0129ad7>] run_timer_softirq+0xc7/0x3d0 (48)
 [<c034fd35>] schedule+0x85/0x100 (12)
 [<c0125c27>] ksoftirqd+0xc7/0x130 (28)
 [<c0125b60>] ksoftirqd+0x0/0x130 (32)
 [<c0134a18>] kthread+0x98/0xa0 (8)
 [<c0134980>] kthread+0x0/0xa0 (12)
 [<c01013c5>] kernel_thread_helper+0x5/0x10 (12)
WARNING: non-monotonic time!
... time warped from 452930691 to 442929843.
softirq-timer/0/3[CPU#0]: BUG in ktime_get at kernel/ktimers.c:103
 [<c012147c>] __WARN_ON+0x5c/0xa0 (8)
 [<c0138105>] ktime_get+0xe5/0x160 (48)
 [<c0138cbd>] ktimer_run_queues+0x1d/0x120 (64)
 [<c011c21c>] __wake_up+0x3c/0x70 (16)
 [<c0129ad7>] run_timer_softirq+0xc7/0x3d0 (32)
 [<c034fd35>] schedule+0x85/0x100 (12)
 [<c0125c27>] ksoftirqd+0xc7/0x130 (28)
 [<c0125b60>] ksoftirqd+0x0/0x130 (32)
 [<c0134a18>] kthread+0x98/0xa0 (8)
 [<c0134980>] kthread+0x0/0xa0 (12)
 [<c01013c5>] kernel_thread_helper+0x5/0x10 (12)
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones

And this when starting Hydrogen for the first time (the next startup is
fine):

hydrogen:4610 userspace BUG: scheduling in user-atomic context!
 [<c034fd9a>] schedule+0xea/0x100 (8)
 [<c034ff74>] wait_for_completion+0xa4/0xe0 (28)
 [<c011c150>] default_wake_function+0x0/0x20 (12)
 [<c0177951>] coredump_wait+0xa1/0x100 (28)
 [<c01ec60c>] copy_from_user+0x4c/0xc0 (8)
 [<c0177aaa>] do_coredump+0xfa/0x270 (108)
 [<c015456d>] kmem_cache_free+0x4d/0xb0 (40)
 [<c012aab5>] __dequeue_signal+0xf5/0x1c0 (24)
 [<c012aba3>] dequeue_signal+0x23/0xe0 (32)
 [<c012ca58>] get_signal_to_deliver+0x298/0x310 (20)
 [<c0351ee0>] do_page_fault+0x0/0x590 (24)
 [<c0102f80>] do_signal+0x70/0x180 (8)
 [<c014f495>] free_pages_bulk+0x225/0x2a0 (28)
 [<c0129493>] try_to_del_timer_sync+0x43/0x50 (12)
 [<c0147735>] audit_filter_syscall+0x45/0xe0 (4)
 [<c014834b>] audit_syscall_exit+0x4b/0x400 (36)
 [<c035219d>] do_page_fault+0x2bd/0x590 (40)
 [<c0351ee0>] do_page_fault+0x0/0x590 (48)
 [<c01030b5>] do_notify_resume+0x25/0x34 (8)
 [<c0103294>] work_notifysig+0x13/0x1b (8)

No other BUG messages that I can see.
-- Fernando


