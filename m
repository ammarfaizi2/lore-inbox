Return-Path: <linux-kernel-owner+w=401wt.eu-S932225AbXADBA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbXADBA7 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 20:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbXADBA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 20:00:59 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:41088
	"EHLO gnuppy.monkey.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932225AbXADBA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 20:00:58 -0500
Date: Wed, 3 Jan 2007 17:00:49 -0800
To: "Chen, Tim C" <tim.c.chen@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH] lock stat for -rt 2.6.20-rc2-rt2.2.lock_stat.patch
Message-ID: <20070104010049.GA31943@gnuppy.monkey.org>
References: <20070104002909.GA31682@gnuppy.monkey.org> <9D2C22909C6E774EBFB8B5583AE5291C01A4FBBA@fmsmsx414.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D2C22909C6E774EBFB8B5583AE5291C01A4FBBA@fmsmsx414.amr.corp.intel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 04:46:37PM -0800, Chen, Tim C wrote:
> Bill Huey (hui) wrote:
> > Can you sort the output ("sort -n" what ever..) and post it without
> > the zeroed entries ?
> > 
> > I'm curious about how that statistical spike compares to the rest of
> > the system activity. I'm sure that'll get the attention of Peter as
> > well and maybe he'll do something about it ? :)
... 
> @contention events = 247149
> @failure_events = 146
> @lookup_failed_scope = 175
> @lookup_failed_static = 43
> @static_found = 16
> [1, 113, 77 -- 32768, 0]            {tcp_init, net/ipv4/tcp.c, 2426}
> [2, 759, 182 -- 1, 0]           	{lock_kernel, -, 0}
> [13, 0, 7 -- 4, 0]              	{kmem_cache_free, -, 0}
> [25, 3564, 9278 -- 1, 0]            {lock_timer_base, -, 0}
> [56, 9528, 24552 -- 3, 0]           {init_timers_cpu, kernel/timer.c, 1842}
> [471, 52845, 17682 -- 10448, 0]     {sock_lock_init, net/core/sock.c, 817}
> [32251, 9024, 242 -- 256, 0]        {init, kernel/futex.c, 2781}
> [173724, 11899638, 9886960 -- 11194, 0]         {mm_init, kernel/fork.c, 369}

Thanks, the numbers look a bit weird in that the first column should
have a bigger number of events than that second column since it is a
special case subset. Looking at the lock_stat_note() code should show
that to be the case. Did you make a change to the output ?

I can't tell which are "steal", actively running or overall contention
stats against the lock from your output.

Thanks

bill

