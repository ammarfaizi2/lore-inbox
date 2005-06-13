Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVFMRzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVFMRzo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 13:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVFMRzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 13:55:43 -0400
Received: from one.firstfloor.org ([213.235.205.2]:32741 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261163AbVFMRzj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 13:55:39 -0400
To: vatsa@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick for x86 version 050609-2
References: <88056F38E9E48644A0F562A38C64FB6004EBD10C@scsmsx403.amr.corp.intel.com>
	<20050609014033.GA30827@atomide.com>
	<20050610043018.GE18103@atomide.com>
	<20050613170941.GA1043@in.ibm.com>
From: Andi Kleen <ak@muc.de>
Date: Mon, 13 Jun 2005 19:55:38 +0200
In-Reply-To: <20050613170941.GA1043@in.ibm.com> (Srivatsa Vaddagiri's
 message of "Mon, 13 Jun 2005 22:39:41 +0530")
Message-ID: <m1k6kyb0px.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri <vatsa@in.ibm.com> writes:
>
> 2. reprogram_apic_timer seems to reprogram the count-down
>    APIC timer (APIC_TMICT) with an integral number of apic_timer_val.
>    How accurate will this be? Shouldnt this take into account
>    that we may not be reprogramming the timer on exactly "jiffy"
>    boundary?

All PIT based reprogramming schemes will lose time.

Only with HPET you can do better (but even there it is difficult to
do properly) 

> 3. Is there any strong reason why you reprogram timers only when
>    _all_ CPUs are idle?

There is none imho - my x86-64 no idle tick patch doesn't do it.

Actually there is a small reason - RCU currently does not get 
updated by a fully idle CPU and can stall other CPUs. But that is in 
practice not too big an issue yet because so many subsystems
cause ticks now and then, so the CPUs tend to wake up often
enough to not stall the rest of the system too badly.


-Andi
