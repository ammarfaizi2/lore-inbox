Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267199AbSLKQN3>; Wed, 11 Dec 2002 11:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267201AbSLKQN3>; Wed, 11 Dec 2002 11:13:29 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:34231 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S267199AbSLKQN2>;
	Wed, 11 Dec 2002 11:13:28 -0500
Date: Wed, 11 Dec 2002 17:21:14 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200212111621.RAA16124@harpo.it.uu.se>
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.4.3 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perfctr-2.4.3 is now available at the usual place:
http://www.csd.uu.se/~mikpe/linux/perfctr/

Users of hyper-threaded Pentium 4s (Xeons) are strongly
recommended to upgrade to this release. Older releases
may silently malfunction due to the resource conflicts
mentioned in the CHANGES extract below.

Version 2.4.3, 2002-12-11
- Support for hyper-threaded Pentium 4s added. In a HT P4, the
  two logical processors share the performance counter state.
  HT P4s are therefore _asymmetric_ multi-processors, and the
  driver enforces CPU affinity masks on users of per-process
  performance counters to avoid resource conflicts. (Users are
  restricted to logical processor #0 in each physical CPU.)
  Limitations:
  * The kernel mechanism for updating a process' CPU affinity
    mask uses no or very weak locking, which makes certain race
    conditions possible that can break the driver's CPU affinity
    mask restrictions. For now, users should NOT use the
    sched_setaffinity() system call on processes using per-process
    performance counters.
  * Global-mode performance counters don't work on HT P4s due to
    limitations in the API. This will be fixed in perfctr-2.5.
  * 2.2 kernels don't have CPU affinity masks, and therefore can't
    support HT P4s.

/ Mikael Pettersson
