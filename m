Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274537AbRJAEVY>; Mon, 1 Oct 2001 00:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274539AbRJAEVO>; Mon, 1 Oct 2001 00:21:14 -0400
Received: from maynard.mail.mindspring.net ([207.69.200.243]:22039 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274537AbRJAEVE>; Mon, 1 Oct 2001 00:21:04 -0400
Subject: [PATCH] (Updated) Preemptible Kernel
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.29.08.08 (Preview Release)
Date: 01 Oct 2001 00:21:44 -0400
Message-Id: <1001910106.888.12.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated patches for 2.4.10, 2.4.11-pre1, and 2.4.10-ac1 are at
http://tech9.net/rml/linux

Note that the 2.4.10 patch is updated over previous patches.

It's been awhile, because a lot has changed.  Please give this a good
once (and twice) -over.  For those of you using preempt-stats, I suggest
not keeping that patch compiled in during regular use and certainly not
during any benchmarking.

What's New:

Most notably, George Anzinger of MontaVista rewrote how we keep track of
whether a task is preempted or not.  The "preempt bit" has been moved
from a task's status flag to the preempt_count (per-task_struct)
variable.  The resulting code is cleaner and simpler, and as a bonus the
race with ptrace and signals (and any undetected similar problems) has
been fixed, so we don't need explicit fixes.

I also renamed our namespace, cleaning things up, and trying to stick to
a prefix of "preempt."  Most important, ctx_sw_on and ctx_sw_off are now
preempt_enable and preempt_disable.

The ChangeLog since the last official release:

20010928
- have spin_lock_prefetch prefetch the preempt_count, too,
  since its incremented on each spin_lock
- some more ifdef and namespace cleanups

20010925
- modify our handling of the "preemption bit": move from the
  task's status to the preempt_count
- the above removes the risk of race in ptrace and SIGSTOP
  signal handling, so we can back out those fixes.
- rearrange our namespace.  most notably, ctx_sw_on/off
  is now preempt_enable/disable.
- cleanup some defines

20010923
- fix strace race: make ptrace preempt safe
- fix job control race: make SIGSTOP signal preempt
  safe
- fix adfs compile bug: add sched.h include to
  fs/adfs/map.c

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

