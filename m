Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271336AbTHDAMN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 20:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271337AbTHDAMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 20:12:13 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:50104 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S271336AbTHDAMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 20:12:08 -0400
Date: Mon, 4 Aug 2003 02:11:44 +0200 (MEST)
Message-Id: <200308040011.h740BiPQ002895@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.6.0-pre3 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.6.0-pre3 of perfctr, the Linux/x86 performance
monitoring counters driver, is now available at the usual
place: http://www.csd.uu.se/~mikpe/linux/perfctr/

In addition to 2.6.0-pre3 there is also a 2.6.0-pre3+marshal
release available as a patch on top of 2.6.0-pre3.
2.6.0-pre3+marshal includes the new user/kernel structure
passing mechanism I've been working on over the last month.
This mechanism provides us with two benefits:
- Allows x86 API extensions, including extending the various
  API structures, without breaking binary compatibility.
- Allows the x86-64 driver to handle x86 binaries. This
  has been validated by running x86 binaries for the 'self'
  and 'perfex' example programs on x86-64.

Although I believe the new parameter passing code is suitable
for merging now, I'm releasing it separately for review first.

There will be one more ABI change soon to handle the "cpumask_t"
changes in some 2.6 kernel trees. That will be fun, NOT.

Version 2.6.0-pre3, 2003-08-03
- Replaced 'long' by 'int' in the API structures to eliminate
  unnecessary ABI incompatibilities between x86 and x86-64.
- Simplified global-mode perfctrs API: the write-control and
  read-state commands now operate on a single CPU instead of on
  a set of CPUs. Added a new start command to start the counters.
- Added thin library wrappers for per-process perfctr kernel calls.
  Cleaned up examples/perfex and the library itself.
- Removed the requirement that CCCR.ACTIVE_THREAD == 3 on P4.
- Extended cascading should now work on Pentium 4 Model 2 processors.
- Fixed a bug where the perfctr module's refcount could be zero with
  code still running in the module. This could race with rmmod in
  preemptive kernels, and in theory also in SMP kernels.

/ Mikael Pettersson
