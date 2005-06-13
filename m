Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVFMSkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVFMSkB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 14:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVFMSkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 14:40:00 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:39100 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261192AbVFMShi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 14:37:38 -0400
X-ORBL: [67.117.73.34]
Date: Mon, 13 Jun 2005 11:37:16 -0700
From: Tony Lindgren <tony@atomide.com>
To: Andi Kleen <ak@muc.de>
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick for x86 version 050609-2
Message-ID: <20050613183716.GH8020@atomide.com>
References: <88056F38E9E48644A0F562A38C64FB6004EBD10C@scsmsx403.amr.corp.intel.com> <20050609014033.GA30827@atomide.com> <20050610043018.GE18103@atomide.com> <20050613170941.GA1043@in.ibm.com> <m1k6kyb0px.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1k6kyb0px.fsf@muc.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen <ak@muc.de> [050613 10:57]:
> Srivatsa Vaddagiri <vatsa@in.ibm.com> writes:
> >
> > 2. reprogram_apic_timer seems to reprogram the count-down
> >    APIC timer (APIC_TMICT) with an integral number of apic_timer_val.
> >    How accurate will this be? Shouldnt this take into account
> >    that we may not be reprogramming the timer on exactly "jiffy"
> >    boundary?
> 
> All PIT based reprogramming schemes will lose time.

Not true if the timesource is different from interrupt source.

Consider PM timer for timesource, and PIT for interrupt source. Reprogamming
PIT should not affect PM timer. Time is always updated from PM timer.

> Only with HPET you can do better (but even there it is difficult to
> do properly) 
> 
> > 3. Is there any strong reason why you reprogram timers only when
> >    _all_ CPUs are idle?
> 
> There is none imho - my x86-64 no idle tick patch doesn't do it.
>
> Actually there is a small reason - RCU currently does not get 
> updated by a fully idle CPU and can stall other CPUs. But that is in 
> practice not too big an issue yet because so many subsystems
> cause ticks now and then, so the CPUs tend to wake up often
> enough to not stall the rest of the system too badly.

I guess it should be safe to reprogram timer even if other CPUs are not
idle, assuming the busy CPUs reprogramming timer will also wake up the idle
CPUs.

There's one thing that should be considered though; Reprogamming
timers should be avoided if the system is busy as it causes
performance issues. Especially reprogramming PIT.

Andi, where's your latest x86-64 patch BTW? I'd like to try it out
on my laptop :)

Tony
