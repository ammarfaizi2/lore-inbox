Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbTHSTbX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbTHSTbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:31:13 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:8576 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261324AbTHST3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:29:53 -0400
Date: Tue, 19 Aug 2003 21:29:32 +0200 (MEST)
Message-Id: <200308191929.h7JJTWsQ004506@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.6.0-pre4 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.6.0-pre4 of perfctr, the Linux/x86 performance
monitoring counters driver, is now available at the usual
place: http://www.csd.uu.se/~mikpe/linux/perfctr/

There is one more driver change scheduled before 2.6.0-final:
killing a process' perfctrs if sys_sched_setaffinity() or
set_cpus_allowed() would migrate it to a forbidden CPU.
A solution has been coded, but it cannot yet generate useful
diagnostics due to unresolved synchronisation issues.

Also, I've decided to remove support for all kernels older than
2.4.15 from perfctr-2.6.0, based on their technical flaws and
general obsolescence. (An informal poll in perfctr-devel a few
weeks ago didn't lead to any complaints.)

Version 2.6.0-pre4, 2003-08-19
- Kernel/user-space API switched to a new "sparse marshalling"
  mechanism, which supports x86 application code on x86-64,
  and API struct extensions w/o breaking binary compatibility.
- Prepared the library for the future non-/proc/pid/perfctr API.
- Fixed a bug in the per-process perfctr creation code. The
  remote-control interface was racy in preemptible kernels.
- Fixed a bug in the process exit code for preemptible kernels.
- Changes to handle 2.6 kernels with the cpumask_t patch (-mm, -osdl):
  * Driver converted to use cpumask_t API, with compatibility wrapper
    for cpumask_t-free kernels.
  * API change: removed the cpus and cpus_forbidden sets from the
    perfctr_info struct, added new data type and commands for retrieving
    these sets. (cpumask_t values cannot be exported as-is since their
    sizes depend on kernel configuration, and the type definition uses
    'long' which breaks 32/64-bit binary compatibility.)
  * Updated library and example programs for the API change.
- Fixed a dependency bug in the library Makefile.
- Added support for VIA C3 Antaur/Nehemiah processors.

/ Mikael Pettersson
