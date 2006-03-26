Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWCZJx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWCZJx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 04:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWCZJx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 04:53:28 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:1459 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S1751196AbWCZJx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 04:53:27 -0500
Date: Sun, 26 Mar 2006 10:52:59 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
cc: Bill Huey <billh@gnuppy.monkey.org>, <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 00/10] PI-futex: -V1
In-Reply-To: <20060326074535.GA9969@elte.hu>
Message-ID: <Pine.LNX.4.44L0.0603261045230.32389-100000@lifa03.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Mar 2006, Ingo Molnar wrote:

>
> * Bill Huey <billh@gnuppy.monkey.org> wrote:
>
> > You'll need to do priority ceiling emulation as well. [...]
>
> i mentioned it further down in the text - PRIO_PROTECT support (which is
> priority ceiling) is planned for pthread mutexes. It needs no further
> kernel changes, it's a pure userspace thing.
>

Wouldn't this always include a call to sched_setscheduler() even for the
fast path? And it would also involve assigning a priority to all locks up
front.

There are only 2 good reasons to choose this, as far as I can see. One is
that it is more deterministic: The "fast path" is almost as slow as the slow
path. So you will not be surprised by a sudden increase CPU use because
timing is moved slightly. This is on the other hand something which can
happen with PI.
On UP there is usually no congestion with this mechanism if you avoid blocking
when you have a lock as the task holding the lock will have higher
priority than any other task interested in the lock.

Esben


> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

