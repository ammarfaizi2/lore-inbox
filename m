Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbULNDxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbULNDxl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 22:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbULNDxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 22:53:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32967 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261292AbULNDxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 22:53:38 -0500
Date: Mon, 13 Dec 2004 19:53:31 -0800
Message-Id: <200412140353.iBE3rVwH008027@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: akpm@osdl.org, torvalds@osdl.org
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/7 (introduction)] cpu-timers and friends
X-Shopping-List: (1) Parasitic pancakes
   (2) Resilient Ripe 'n' Sweet wine
   (3) Tolerant symbolical wine
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is to introduce the coming seven messages.  These relate to
process/thread CPU-time clocks for POSIX timers and some related fixes for
proper POSIX semantics in multithreaded programs (under NPTL).  

These patches were made against a recent current tree, plus my stoprace-fix
signals patch.  That patch follow-on and the group_exit cleanup are already
in 2.6.10-rc3-mm1, but these patches were made against a Linus tree with
just the stoprace-fix patch.  (That fix is necessary for some of these
changes to be safe, while the group_exit cleanup is just a non-bug cleanup.)
If you need these patches remade against -mm or some other given tree
state, please let me know.  I'm happy to do whatever makes it easiest to
get them into the tree ASAP.

Note that the first patch changes an ill-advised new user-kernel ABI that
has been introduced since 2.6.9; I really think we should not let the
existing clockid_t encoding change get out in 2.6.10.  I hope this patch
(and ideally all the rest) can go into 2.6.10, but reverting the earlier
patch so that we have no new clockid_t values at all would be better than
letting the existing code for CPU clocks make it into 2.6.10, IMHO.

These can also be found in http://people.redhat.com/roland/kernel-patches/
Not all of the changes are strict dependencies, but these patches will need
to be applied in the order of posting, which is:

linux-2.6.10rc3-cpuclocks.patch
linux-2.6.10rc2-timer-signal-deadlock-fix.patch
linux-2.6.10rc3-cputimers.patch
linux-2.6.10rc3-process-itimer-real.patch
linux-2.6.10rc3-process-itimer-cpu.patch
linux-2.6.10rc3-process-sigxcpu.patch
linux-2.6.10rc3-timer-cleanup.patch

In http://people.redhat.com/roland/glibc/ you can find a glibc patch to
enable using the new clock_* and timer_* kernel support.  This includes
some test programs.  I've tested the kernel code using these programs, on a
2-CPU x86 machine.  There shouldn't be anything machine-dependent about the
code, but architectures vary on how good the time they implement for
`sched_clock' is; on some, it's nothing but the same jiffies-based count
you see via getrusage.


Thanks,
Roland
