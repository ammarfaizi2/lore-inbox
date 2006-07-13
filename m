Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030421AbWGMWHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030421AbWGMWHe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 18:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030423AbWGMWHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 18:07:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36325 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030421AbWGMWHd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 18:07:33 -0400
Date: Thu, 13 Jul 2006 18:07:22 -0400
From: Dave Jones <davej@redhat.com>
To: john stultz <johnstul@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 18rc1 soft lockup
Message-ID: <20060713220722.GA3371@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	john stultz <johnstul@us.ibm.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060711190346.GK5362@redhat.com> <1152645227.760.9.camel@cog.beaverton.ibm.com> <20060711191658.GM5362@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711191658.GM5362@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 03:16:58PM -0400, Dave Jones wrote:
 > On Tue, Jul 11, 2006 at 12:13:47PM -0700, john stultz wrote:
 >  > On Tue, 2006-07-11 at 15:03 -0400, Dave Jones wrote:
 >  > > Just saw this during boot of a HT P4 box.
 >  > > 
 >  > > BUG: soft lockup detected on CPU#0!
 >  > >  [<c04051af>] show_trace_log_lvl+0x54/0xfd
 >  > >  [<c0405766>] show_trace+0xd/0x10
 >  > >  [<c0405885>] dump_stack+0x19/0x1b
 >  > >  [<c0450ec7>] softlockup_tick+0xa5/0xb9
 >  > >  [<c042d496>] run_local_timers+0x12/0x14
 >  > >  [<c042d81b>] update_process_times+0x3c/0x61
 >  > >  [<c04179e0>] smp_apic_timer_interrupt+0x6d/0x75
 >  > >  [<c0404ada>] apic_timer_interrupt+0x2a/0x30
 >  > 
 >  > That's clocksource_adjust/lost tick bug. Roman's fix landed in Linus'
 >  > -git yesterday.
 > 
 > Ah, that was actually a .18rc1-git3 tree. I notice a git4 just appeared,
 > I'll try and reproduce with that.

Just when I thought it had gotten fixed..
2.6.18rc1-git6 this time on x86-64..

BUG: soft lockup detected on CPU#3!

Call Trace:
 [<ffffffff80270865>] show_trace+0xaa/0x23d
 [<ffffffff80270a0d>] dump_stack+0x15/0x17
 [<ffffffff802c44e6>] softlockup_tick+0xd5/0xea
 [<ffffffff80250bea>] run_local_timers+0x13/0x15
 [<ffffffff8029cc1d>] update_process_times+0x4c/0x79
 [<ffffffff8027bfeb>] smp_local_timer_interrupt+0x2b/0x50
 [<ffffffff8027c766>] smp_apic_timer_interrupt+0x58/0x62
 [<ffffffff802628ae>] apic_timer_interrupt+0x6a/0x70

		Dave


-- 
http://www.codemonkey.org.uk
