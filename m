Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbVI1Jz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbVI1Jz0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 05:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbVI1Jz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 05:55:26 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:51870 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750838AbVI1Jz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 05:55:26 -0400
Date: Wed, 28 Sep 2005 05:53:33 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Simon White <s_a_white@email.com>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Best Kernel Timers?
In-Reply-To: <20050928093602.DFA0B8401C@ws1-5.us4.outblaze.com>
Message-ID: <Pine.LNX.4.58.0509280547540.5529@localhost.localdomain>
References: <20050928093602.DFA0B8401C@ws1-5.us4.outblaze.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Sep 2005, Simon White wrote:

> Hi,
>
> Wondered if anyone could provide information about where to look for
> suitable kernel timers?

Have you taken a look at what is being done by Thomas Gleixner?

http://lwn.net/Articles/152363/

Also you may be interested in Ingo Molnar's RT kernel.

http://people.redhat.com/mingo/realtime-preempt/

As well as the work being done by the HRT folks.

http://sourceforge.net/projects/high-res-timers

-- Steve

>
> For a while I have been working on supporting the hardsid/catweasel
> cards on Linux (and Windows).  Although undesirable the original
> implementations required real usec delays in the OS
> (this requirement being fixed in the very latest hardware).  I know
> Linux is not realtime so the original drivers were designed to
> queue hardware writes to a realtime thread that busy waited and
> recovered as best it could from errors (on the whole this worked
> pretty well).  Also another version of the code was written to use
> rtlinux/rtai that was capable of non busy waiting.
>
> More recently with the release of the new buffering hardware the
> driver was redesigned from the realtime posix code.  Due to these
> changes the busy waiting (for the old cards) can nolonger occur
> and the delays have to happen asynchronusly notifing the realtime
> thread when the delay has expired.  The code uses the posix
> timer_set, etc calls with realtime clock with absolute delays and
> flags a semaphore when the signal occurs (works great under
> realtime systems).
>
> Now as an alternative it is again desired that a version (although
> wont perfectly work) be available to a vanilla 2.6 kernel (possibly
> 2.4) with similiar limitations as before.  Its a shame the posix
> calls appear to not be supported in kernel for drivers so I have
> wrapped the calls for semaphores/mutexs/threads to kernel
> equivalents.
>
> However I have no idea what to do for the timers.  Is there
> something suitable inkernel that would provide an async callback
> to pre-empt a realtime thread and provide better resolution than
> HZ a far amount of the time?  Or do I have to run a seperate lower
> priority busy waiting thread to wakeup the realtime one?
>
> Advice appreciated.
> Simon
>
> --
> ___________________________________________________________
> Sign-up for Ads Free at Mail.com
> http://promo.mail.com/adsfreejump.htm
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
