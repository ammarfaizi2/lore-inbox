Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbTLHCW6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 21:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265303AbTLHCW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 21:22:58 -0500
Received: from d57-130-238.home.cgocable.net ([24.57.130.238]:24449 "EHLO
	cormack.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S265285AbTLHCW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 21:22:56 -0500
Date: Sun, 7 Dec 2003 21:24:27 -0500
From: Gordon Cormack <gvcormac@uwaterloo.ca>
To: linux-kernel@vger.kernel.org
Subject: 2.6.test11 bug
Message-ID: <20031208022427.GA12859@cormack.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have read the FAQ but I'm confused about how to report a 2.6
kernel bug, or who to report it to.

Here it is in a nutshell.

--- kernel ---

Linux xxx20.uwaterloo.ca 2.6.0-test11 #2 SMP Thu Nov 27 14:46:01 EST 2003 i686 athlon i386 GNU/Linux

---- log ----

Dec  6 13:16:01 flax20 kernel: Bad page state at free_hot_cold_page
Dec  6 13:16:01 flax20 kernel: flags:0x02000114 mapping:00000000 mapped:1 count:0
Dec  6 13:16:01 flax20 kernel: Backtrace:
Dec  6 13:16:01 flax20 kernel: Call Trace:
Dec  6 13:16:01 flax20 kernel:  [<c013f98d>] bad_page+0x5d/0x90
Dec  6 13:16:01 flax20 kernel:  [<c0140041>] free_hot_cold_page+0x61/0xf0
Dec  6 13:16:01 flax20 kernel:  [<c014063c>] __pagevec_free+0x1c/0x30
Dec  6 13:16:01 flax20 kernel:  [<c014527f>] release_pages+0x11f/0x140
Dec  6 13:16:01 flax20 kernel:  [<c01544a6>] free_pages_and_swap_cache+0x56/0x90
Dec  6 13:16:01 flax20 kernel:  [<c014cf60>] unmap_region+0x150/0x160
Dec  6 13:16:01 flax20 kernel:  [<c014d28f>] do_munmap+0x11f/0x170
Dec  6 13:16:01 flax20 kernel:  [<c014d325>] sys_munmap+0x45/0x70
Dec  6 13:16:01 flax20 kernel:  [<c010adcf>] syscall_call+0x7/0xb
Dec  6 13:16:01 flax20 kernel:
Dec  6 13:16:01 flax20 kernel: Trying to fix it up, but a reboot is needed
Dec  6 16:31:14 flax20 syslogd 1.4.1: restart.

--- comments ---

The problem has occurred only once on one of 13 dual-processor machines.
The one that crashed was one (of seven) with dual AMD 1900+, 2GB RAM,
and 4 ATA hard drives.  None of the other machines have crashed in the
9 days since I installed the kernel.

It appears to be related to high memory pressure but I can't reproduce
it with simple programs.  The machines run text search software that is
both CPU and IO intensive.

---

I'm not a developer but I am running a pretty significant load on these
machines and am prepared to do instrumentation/investigation in order to
diagnose the problem.

As an aside, all versions of the 2.4 kernel are brought to their knees
in this application ("kswapd problems" hit full force and none of the
suggested patches worked).  Even with the occasional crash, 2.6.test11 is
way better.

-- 
Gordon V. Cormack     CS Dept, University of Waterloo, Canada N2L 3G1
gvcormack@uwaterloo.ca            http://cormack.uwaterloo.ca/cormack
