Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWAQQnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWAQQnL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 11:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWAQQnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 11:43:11 -0500
Received: from 213-140-2-69.ip.fastwebnet.it ([213.140.2.69]:2706 "EHLO
	aa002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932136AbWAQQnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 11:43:10 -0500
Date: Tue, 17 Jan 2006 17:43:51 +0100
From: Mattia Dongili <malattia@linux.it>
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: first bisection results in -mm3 [was: Re: 2.6.15-mm2: reiser3 oops on suspend and more (bonus oops shot!)]
Message-ID: <20060117164351.GA3591@inferi.kami.home>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060111100016.GC2574@elf.ucw.cz> <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org> <20060111184027.GB4735@inferi.kami.home> <20060112220825.GA3490@inferi.kami.home> <1137108362.2890.141.camel@cog.beaverton.ibm.com> <20060114120816.GA3554@inferi.kami.home> <1137442582.27699.12.camel@cog.beaverton.ibm.com> <20060116204057.GC3639@inferi.kami.home> <1137447763.27699.27.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137447763.27699.27.camel@cog.beaverton.ibm.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.15-mm4-2 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 01:42:43PM -0800, john stultz wrote:
> On Mon, 2006-01-16 at 21:40 +0100, Mattia Dongili wrote:
[...]
> > # date
> > Mon Jan 16 21:29:26 CET 2006
> > now count with me 1..2..3..4..5
> > # date
> > Mon Jan 16 21:29:27 CET 2006
> > 
> > I'd say the time is far from being accurate.
> 
> Ok, as I thought. Although 5:1 seems a bit large for cpufreq scaling. It
> does appear that the TSC is halting. 

it's far worse than 5:1 actually I wasn't only counting to 5 :)

[...]
> > I'll be happy to test new patches if necessary (I'm running -mm4)
> 
> Below is a patch that should provide a bit more debug info. If you
> could, boot up w/ it (be sure to enable CONFIG_PARANOID_GENERIC_TIME)
> and send me your dmesg.

done, I did put it here[1] and added some comments at the end of the
file to better show what was going on.

[1]: http://oioio.altervista.org/linux/tsc_debug.html
	and also included at the end of this mail as plain text w/o
	comments

Will test the other patch now.

Oh, by the way, after I caught the above dmesg I got this:

[  556.512000] TSC: Marked unstable
[  556.512000]  [<c0103bb3>] show_trace+0x13/0x20
[  556.512000]  [<c0103bde>] dump_stack+0x1e/0x20
[  556.512000]  [<c0108b77>] mark_tsc_unstable+0x27/0x40
[  556.512000]  [<c01090fb>] time_cpufreq_notifier+0x19b/0x1b0
[  556.512000]  [<c0127e3d>] notifier_call_chain+0x2d/0x50
[  556.512000]  [<c029b551>] cpufreq_notify_transition+0xb1/0x170
[  556.512000]  [<d120f39d>] speedstep_target+0xad/0xe0 [speedstep_ich]
[  556.512000]  [<c029b1d7>] __cpufreq_driver_target+0x77/0x80
[  556.512000]  [<d11de66e>] do_dbs_timer+0x1be/0x200 [cpufreq_ondemand]
[  556.512000]  [<c012b1da>] run_workqueue+0x9a/0x140
[  556.512000]  [<c012b477>] worker_thread+0x107/0x140
[  556.512000]  [<c012eaa9>] kthread+0xd9/0xe0
[  556.512000]  [<c0101005>] kernel_thread_helper+0x5/0x10
[  556.532000] check_periodic_interval: Long interval! 135987395 ns.
[  556.532000] 		Something may be blocking interrupts.
[  563.016000] TSC: Marked unstable
[  563.016000]  [<c0103bb3>] show_trace+0x13/0x20
[  563.016000]  [<c0103bde>] dump_stack+0x1e/0x20
[  563.016000]  [<c0108b77>] mark_tsc_unstable+0x27/0x40
[  563.016000]  [<c01090fb>] time_cpufreq_notifier+0x19b/0x1b0
[  563.016000]  [<c0127e3d>] notifier_call_chain+0x2d/0x50
[  563.016000]  [<c029b5dc>] cpufreq_notify_transition+0x13c/0x170
[  563.016000]  [<d120f3c0>] speedstep_target+0xd0/0xe0 [speedstep_ich]
[  563.016000]  [<c029b1d7>] __cpufreq_driver_target+0x77/0x80
[  563.016000]  [<d11de5ee>] do_dbs_timer+0x13e/0x200 [cpufreq_ondemand]
[  563.016000]  [<c012b1da>] run_workqueue+0x9a/0x140
[  563.016000]  [<c012b477>] worker_thread+0x107/0x140
[  563.016000]  [<c012eaa9>] kthread+0xd9/0xe0
[  563.016000]  [<c0101005>] kernel_thread_helper+0x5/0x10
[  563.032000] check_periodic_interval: Long interval! 140156640 ns.
[  563.032000] 		Something may be blocking interrupts.
[  576.756000] Time: jiffies clocksource has been installed.

-- 
mattia
:wq!
