Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVFAVmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVFAVmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVFAVjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 17:39:52 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:24078 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261174AbVFAViw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 17:38:52 -0400
Date: Wed, 1 Jun 2005 14:42:57 -0700
To: Andrea Arcangeli <andrea@suse.de>
Cc: Bill Huey <bhuey@lnxw.com>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Ingo Molnar <mingo@elte.hu>,
       Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601214257.GA28196@nietzsche.lynx.com>
References: <20050601192224.GV5413@g5.random> <Pine.OSF.4.05.10506012129460.1707-100000@da410.phys.au.dk> <20050601195905.GX5413@g5.random> <20050601201754.GA27795@nietzsche.lynx.com> <20050601203212.GZ5413@g5.random> <20050601204612.GA27934@nietzsche.lynx.com> <20050601210716.GB5413@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601210716.GB5413@g5.random>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 11:07:16PM +0200, Andrea Arcangeli wrote:
> Why don't you run grep yourself, this is only drivers/
> 
> ./usb/gadget/pxa2xx_udc.c:	local_irq_disable();
> ./usb/gadget/pxa2xx_udc.c:	local_irq_disable();
> ./video/aty/radeon_base.c:	local_irq_disable();

Which only supports my claim more that away from the core kernel issues
near the terminals of the call/lock graph. No working RTOS app is going
to be running on arbitrary hardware. Auditing of path and reworking them
is relatively easy as you must have noticed during the development of
this patch 6 months ago with the removal of semaphore abuses.

> As said even if all the above is audited, it _can_ break over time,
> while it wouldn't break with RTAI/rtlinux even if you infinite loop and
> hang in there.
 
> > Doesn't have to yet. Drivers are case by case problem as expected. Look
> > at the patch.
> 
> The "case by case" appoach is the problem, so that you plug an usb
> gadget in, and your robot breaks and damages stuff. That would never
> happen with RTAI/rtlinux. (ok, a bad driver could corrupt memory anyway,
> but introducing a latency problem is much easier than introducing a
> memory corruption)

This is a new patch that's not in the mainline and putting additional
hack code constraints preexisting code.

> > Wrong. I did a parallel implementation of this patch and I understand
> > the issues very clearly. Deterministic single kernel RT isn't new or
> > novel in the RTOS world (LynxOS, SGI IRIX, ...).
> 
> Don't change topic, you said local_irq_disable isn't smp safe in
> drivers...

For protecting data in SMP systems, yes. This is obivous and you know
this from the SMP conversion of Linux about 6+ years ago. Bad drivers
can be a pain, but it's really an incremental process at this time and
hasn't been bad to convert high latency points into piecewise sections.

I understand what you're referrng to but you have to understand that
the changes make the core kernel preemptive, which make this kind of
track where you deal with drivers on a case by case practical. Previous
to that, it was impossible because of the size of the kernel. The
current problems you mention is basically slop that should be reworked
to no hold that mask for extended periods of time.

> > Listen to what Ingo, me and others have said and read the patch. You're
> 
> Ingo just said that making local_irq_disable a "soft-cli" is planned.
> 
> > into the patch. Really, read the patch and stop asking question, spreading
> > FUD until then.
> 
> You're the one spreading FUD that preempt-RT is as good as RTAI, and
> even worse than local_irq_disable isn't used in drivers or not safe to
> use in smp.

preempt RT will be deterministic as this patch gets pounded more and
remaining latency paths are reworked. It hasn't been hard so far and the
results have been near perfect since the core kernel is, for the most
part, fully preemptive.

There are problem areas, but that's an excersize left for the readers
(of the patch) to discover and is not mentioned in this text. :)

bill

