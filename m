Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWFSUFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWFSUFe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWFSUFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:05:34 -0400
Received: from mail.timesys.com ([65.117.135.102]:10893 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP id S964875AbWFSUFd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:05:33 -0400
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and
	dynamic  HZ
From: Thomas Gleixner <tglx@timesys.com>
Reply-To: tglx@timesys.com
To: Con Kolivas <kernel@kolivas.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>
In-Reply-To: <200606200003.26008.kernel@kolivas.org>
References: <1150643426.27073.17.camel@localhost.localdomain>
	 <200606191521.05508.kernel@kolivas.org> <20060619122606.GA19451@elte.hu>
	 <200606200003.26008.kernel@kolivas.org>
Content-Type: text/plain
Date: Mon, 19 Jun 2006 22:06:51 +0200
Message-Id: <1150747611.29299.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con,

On Tue, 2006-06-20 at 00:03 +1000, Con Kolivas wrote:
> Dominik donated a lot of code to use the dynticks infrastructure to actually 
> implement the power savings. Just skipping ticks seemed to make very little 
> power difference unless we also used the knowledge from next timer interrupt 
> to know how long we are going to be idle and choose C state transitions 
> accordingly. Each patch is documented at length in the split out
> 
> C-States-1_bm_activity_improvements.patch
> C-States-2_bm_activity_handling_improvement.patch
> C-States-3_accounting_of_sleep_times.patch
> C-States-4_dyn-ticks_tweaks.patch
> 
> http://ck.kolivas.org/patches/dyn-ticks/split-out/

Thanks for pointing that out. We'll look into those tomorrow.

> hrtimer_restart_sched_tick() could use
> struct hrtimer *sched_timer = &cpu_base->sched_timer;
> 
> clockevents_init_next_event() and clockevents_set_next_event() could use
> struct clock_event *nextevt = sources->nextevt;
> 
> > > [...] Also if set_next_event is separated from struct clock_event, the
> > > whole struct looks like a suitable candidate for __read_mostly.
> >
> > You mean ->event_handler()? We can make all clockevent instantiations
> > __read_mostly right now - all of the fields of clock_event are static,
> > even ->event_handler() will change at most once per bootup [when we
> > switch from low-res into high-res mode].

Thanks for the review. 

	tglx


