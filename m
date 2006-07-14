Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161135AbWGNACm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161135AbWGNACm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 20:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161139AbWGNACm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 20:02:42 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:36777 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161135AbWGNACl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 20:02:41 -0400
Subject: Re: 18rc1 soft lockup
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0607140058400.12900@scrub.home>
References: <20060711190346.GK5362@redhat.com>
	 <1152645227.760.9.camel@cog.beaverton.ibm.com>
	 <20060711191658.GM5362@redhat.com>  <20060713220722.GA3371@redhat.com>
	 <1152828943.6845.107.camel@localhost>
	 <Pine.LNX.4.64.0607140058400.12900@scrub.home>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 17:02:38 -0700
Message-Id: <1152835358.6845.119.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 01:05 +0200, Roman Zippel wrote:
> Hi,
> 
> On Thu, 13 Jul 2006, john stultz wrote:
> 
> > > Just when I thought it had gotten fixed..
> > > 2.6.18rc1-git6 this time on x86-64..
> > > 
> > > BUG: soft lockup detected on CPU#3!
> > > 
> > > Call Trace:
> > >  [<ffffffff80270865>] show_trace+0xaa/0x23d
> > >  [<ffffffff80270a0d>] dump_stack+0x15/0x17
> > >  [<ffffffff802c44e6>] softlockup_tick+0xd5/0xea
> > >  [<ffffffff80250bea>] run_local_timers+0x13/0x15
> > >  [<ffffffff8029cc1d>] update_process_times+0x4c/0x79
> > >  [<ffffffff8027bfeb>] smp_local_timer_interrupt+0x2b/0x50
> > >  [<ffffffff8027c766>] smp_apic_timer_interrupt+0x58/0x62
> > >  [<ffffffff802628ae>] apic_timer_interrupt+0x6a/0x70
> > 
> > Hmmm.. grumble. Was this on bootup, or after some time period?
> > 
> > I'm looking into it.
> 
> I don't quite understand how this is clock related, soft lockup uses 
> jiffies and there is nothing clock related in the trace???

Hmmm. Well, its easy to check:

Dave, could you comment out the "clocksource_adjust(...)" line in
kernel/timer.c::update_wall_time() just to check if its the same issue?

thanks
-john


