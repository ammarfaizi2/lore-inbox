Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136725AbRATGts>; Sat, 20 Jan 2001 01:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137169AbRATGti>; Sat, 20 Jan 2001 01:49:38 -0500
Received: from mtiwmhc24.worldnet.att.net ([204.127.131.49]:60545 "EHLO
	mtiwmhc24.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S136725AbRATGt0>; Sat, 20 Jan 2001 01:49:26 -0500
Message-ID: <3A69361F.EBBE76AA@att.net>
Date: Sat, 20 Jan 2001 01:54:23 -0500
From: Michael Lindner <mikel@att.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Maas <dmaas@dcine.com>, linux-kernel@vger.kernel.org,
        Chris Wedgwood <cw@f00f.org>
Subject: Re: PROBLEM: select() on TCP socket sleeps for 1 tick even if data   
 available
In-Reply-To: <fa.nc2eokv.1dj8r80@ifi.uio.no> <fa.dcei62v.1s5scos@ifi.uio.no> <015e01c082ac$4bf9c5e0$0701a8c0@morph>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Maas wrote:
> 
> > OK, if this is the case, how do I alter the scheduling class?
> 
> man sched_setscheduler
> 
> Set SCHED_FIFO or SCHED_RR; you'll need to be root to do this AFAIK.
> 
> I do agree though, Linux's scheduler (for SCHED_OTHER processes) is much
> less "ruthless" than, say, the NT scheduler. It's based on slowly-decaying
> priorities; unlike in other systems, a high-priority process won't
> necessarily pre-empt a low-priority process immediately after waking up.
> 
> Another, less drastic thing to try is simply to increase the number of timer
> interrupts per second (and thus the frequency at which scheduling decisions
> are made) - see "#define HZ" in include/asm/param.h (you'll need to
> recompile the kernel and all modules after changing it). The default for
> Intel systems is 100, but I routinely tweak it to 1000. You could probably
> go even higher without ill effects.

Kernel mods are less drastic than a system call? :^)

Reading the documentation for sched_setscheduler, it's unclear whether
it would even suffice - it seems to deal with preempting other
processes. I am not trying to get into the run queue ahead of other
processes, the machine is sitting there IDLE and my process is still not
getting to run for a full clock tick.

You know, there's one other possibility, and that's if the data that is
being sent isn't actually arriving until the next clock tick, which
means the delay is in the appearance of sent data, not in select().
Given that the two processes are on the same machine, I would expect a
send() on a TCP socket to deliver the data to its destination faster
than that, however.

--
Mike Lindner
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
