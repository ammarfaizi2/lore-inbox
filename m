Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTENNda (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 09:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbTENNd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 09:33:29 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:15800 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP id S262121AbTENNd0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 09:33:26 -0400
Date: Wed, 14 May 2003 15:46:00 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: mikpe@csd.uu.se
Cc: linux-laptop@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69+bk: oops in apmd after waking up from suspend mode
Message-ID: <20030514134600.GA16533@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
References: <20030514094813.GA14904@Synopsys.COM> <16066.16102.618836.204556@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16066.16102.618836.204556@gargle.gargle.HOWL>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mikpe@csd.uu.se, Wed, May 14, 2003 15:04:38 +0200:
> > I have an old Compaq Armada 1592DT. The thing goes automagically into
> > suspend mode after being forgotten for a while. And there is this button
> > to wake it up (the blue one, above the keyboard).
> > 
> > Last time i tried to wake it up it produced the attached oops.
> > "Unknown key"s are probable the blue button.
> > After printing out the oops, the system went back into suspend.
> > 
> > Suspending devices
> > Suspending device c03219ac
> > Unable to handle kernel NULL pointer dereference at virtual address 00000090
...
> > EIP is at fix_processor_context+0x5f/0x100
...
> > Call Trace:
> >  [<c0114529>] restore_processor_state+0x69/0x80
> >  [<c01135c8>] suspend+0x138/0x200
> >  [<c0113845>] check_events+0xf5/0x230
> >  [<c0113aa4>] apm_mainloop+0x94/0xb0
> >  [<c0117950>] default_wake_function+0x0/0x20
> >  [<c0117950>] default_wake_function+0x0/0x20
> >  [<c01141a0>] apm+0x0/0x280
> >  [<c0114262>] apm+0xc2/0x280
> >  [<c0107255>] kernel_thread_helper+0x5/0x10
> 
> Since 2.5.69-bk8 or so, apm.c will invoke restore_processor_state()
> at resume-time. This is needed to reinitialise the SYSENTER MSRs
> used by 2.5's new system call mechanism.

and it supposed to go oops?

>  >  <6>note: kapmd[4] exited with preempt_count 2
> This I don't like. I'm not convinced the resume path is preempt-safe.
> Please try again, either with CONFIG_PREEMPT disabled, or with a
> preempt_disable() / preempt_enable() pair around apm.c's suspend code,
> like in the patch below. (Untested, you may need to stick an #include
> <preempt.h> somewhere in apm.c to make it compile.)

It changed things a bit. preempt_count is 3 now.
Oops didn't change.

The system still works, afaict. Didn't notice any ill effects.

-alex
