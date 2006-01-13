Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbWAMIvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbWAMIvN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 03:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbWAMIvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 03:51:13 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:9964 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S1030324AbWAMIvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 03:51:12 -0500
Date: Fri, 13 Jan 2006 09:47:39 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Bill Huey <billh@gnuppy.monkey.org>
cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       david singleton <dsingleton@mvista.com>, <linux-kernel@vger.kernel.org>
Subject: Re: RT Mutex patch and tester [PREEMPT_RT]
In-Reply-To: <20060113080734.GA22091@gnuppy.monkey.org>
Message-ID: <Pine.LNX.4.44L0.0601130937540.9269-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 Jan 2006, Bill Huey wrote:

> On Thu, Jan 12, 2006 at 01:54:23PM +0100, Esben Nielsen wrote:
> > turnstiles? What is that?
>
> http://www.freebsd.org/cgi/cvsweb.cgi/src/sys/kern/subr_turnstile.c
>
> Please, read. Now tell me or not if that looks familiar ? :)

Yes, it reminds me of Ingo's first approach to pi locking:
Everything is done under a global spin lock. In Ingo's approach it was the
pi_lock. In turnstiles it is sched_lock, which (without looking at other
code in FreeBSD) locks the whole scheduler.

Although making the code a lot simpler, scalability is ofcourse the main
issue here. But apparently FreeBSD does have a global lock protecting the
scheduler anyway.

Otherwise it looks a lot like the rt_mutex.

Esben


>
> Moving closer an implementation is arguable, but it is something that
> should be considered somewhat since folks in both the Solaris (and
> FreeBSD) communities have given a lot more consideration to these issues.
>
> The stack allocated objects are fine for now. Priority inheritance
> chains should never get long with a fine grained kernel, so the use
> of a stack allocated object and migrating pi-ed waiters should not
> be a major real world issue in Linux yet.
>
> Folks should also consider using an adaptive spin in the __grab_lock() (sp?)
> related loops as a possible way of optimizing away the immediate blocks.
> FreeBSD actually checks the owner of a lock aacross another processor
> to see if it's actively running, "current", and will block or wait if
> it's running or not respectively. It's pretty trivial code, so it's
> not a big issue to implement. This is ignoring the CPU local storage
> issues.
>
> bill
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

