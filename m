Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVFJTed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVFJTed (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 15:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVFJTeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 15:34:24 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:3588 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261184AbVFJTeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 15:34:07 -0400
Date: Fri, 10 Jun 2005 12:39:26 -0700
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, Lee Revell <rlrevell@joe-job.com>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050610193926.GA19568@nietzsche.lynx.com>
References: <20050608022646.GA3158@us.ibm.com> <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com> <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com> <20050610173728.GA6564@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610173728.GA6564@g5.random>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 07:37:28PM +0200, Andrea Arcangeli wrote:
> See the tg3 updates required to be safe with preempt-RT without breaking
> hard-RT as a clear example of how preempt-RT is weak:
...
> There's no apparent reason why all those changes should be required to
> get hard-RT.

Some of it is lack of displine with how various drivers do locking in
that they overload the meaning of a spin_lock, etc... to also disable
preemption and side effects with preempt_count. Making all of this formal
is a good thing since it clarifies and un-ambiguates those code paths.
It's something that should have been done in the first place and I
consider using implicit masking like that to be rather sloppy.

> Both RTAI and rtlinux _don't_ require to change all those drivers to get
> the guarantee that the kernel will get out of the way within a certain
> nanoseconds deadline interval.

They obey the same constraints on driver in those nanokernel systems also
apply to the preempt patch. There is no difference other than the regular
driver layers in that they now need to be audited, duh. All RTOSs need to
do this.

> Furthermore with the scheduler, mutex and context switch code into the
> equation, it gets more and more difficult to calculate with math the max
> latency that preempt-RT will provide, while it's almost trivial to do
> that with RTAI/rtlinux given only the nanokernel code runs before the
> hard-RT code is invoked and there are not many paths to test, so one has
> to disable the cache and just measure the few possible nanokenrel paths.
> (as usual when speaking about hard-RT I've robots in mind, and not audio
> code that will call into the alsa ioctls)
> 
> This below is the kind of stuff where I wouldn't even dream to replace
> a ruby-hard rtlinux/RTAI with a weaker metal-hard and possibly
> underperformant (cause scheduling hard-irq in userland and scheduling
> instead of spinning isn't going to be cheap in smp) preempt-RT solution:

LynxOS is a hard real time OS similar to how the preemption patch works
in that it's a single kernel system. It's gets those times regularly and
is obviously deterministic because of careful coding conventions just like
it has always been. Single kernel determinism is not new. It's only new
to you.

bill

