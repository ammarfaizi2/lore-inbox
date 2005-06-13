Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVFMS1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVFMS1g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 14:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVFMS1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 14:27:35 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:46776 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261186AbVFMS1c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 14:27:32 -0400
X-ORBL: [67.117.73.34]
Date: Mon, 13 Jun 2005 11:27:23 -0700
From: Tony Lindgren <tony@atomide.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick for x86 version 050609-2
Message-ID: <20050613182723.GG8020@atomide.com>
References: <88056F38E9E48644A0F562A38C64FB6004EBD10C@scsmsx403.amr.corp.intel.com> <20050609014033.GA30827@atomide.com> <20050610043018.GE18103@atomide.com> <20050613170941.GA1043@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050613170941.GA1043@in.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Srivatsa Vaddagiri <vatsa@in.ibm.com> [050613 10:09]:
> Hi Tony,
>         I went through the dynamic-tick patch on your website
> (patch-dynamic-tick-2.6.12-rc6-050610-1) and was having some
> questions about it:
> 
> 1. dyn_tick->skip is set to the number of ticks that have
>    to be skipped. This is set on the CPU which is the last
>    (in online_map) to go idle and is based on when that
>    CPU's next timer is set to expire.
> 
>    Other CPUs also seem to use the same interval
>    to skip ticks. Shouldnt other CPU check their nearest timer
>    rather than blindly skipping dyn_tick->skip number of ticks?

Probably, unless the wake-up of the first CPU will also wake up the
rest.

> 
> 2. reprogram_apic_timer seems to reprogram the count-down
>    APIC timer (APIC_TMICT) with an integral number of apic_timer_val.
>    How accurate will this be? Shouldnt this take into account
>    that we may not be reprogramming the timer on exactly "jiffy"
>    boundary?

The timer reprogramming functions should be converted to use usecs. We just
currently get the time in jifies from next_timer_interrupt().

> 3. Is there any strong reason why you reprogram timers only when
>    _all_ CPUs are idle?

I don't know this for sure. It seemed like the safest way to go for now.

> 4. In what aspects you think does your patch differ from VST (other
>    than not relying on HRT!)?

Dyntick uses next_timer_interrupt(), which is already part of the mainline
kernel. It also works with PIT + PM timer or TSC.

Tony
