Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316712AbSGXDO1>; Tue, 23 Jul 2002 23:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316797AbSGXDO1>; Tue, 23 Jul 2002 23:14:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3078 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316712AbSGXDO0>; Tue, 23 Jul 2002 23:14:26 -0400
Date: Tue, 23 Jul 2002 20:18:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
       george anzinger <george@mvista.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] irqlock patch -G3. [was Re: odd memory corruption
 in2.5.27?]
In-Reply-To: <3D3E1B66.F17D8B9E@zip.com.au>
Message-ID: <Pine.LNX.4.44.0207232016410.6943-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Jul 2002, Andrew Morton wrote:
>
> And yet here we have a case where a spin_unlock() will
> go and turn on local interrupts.  Only with CONFIG_PREEMPT,
> and even then, extremely rarely.

I think that's just a bug, the same way it was a bug that preemtion would
sometimes set tsk->state to TASK_RUNNING.

I think Robert already sent a fix: make "preempt_schedule()" refuse to
schedule if local interrupts are disabled.

That, together with making it a warning (so that we can _fix_ places that
have unbalanced irq/spinlock behaviour) shoul dbe fine. Eventually, if we
think all places are fixed, we can remove the test from
preempt_schedule().

		Linus

