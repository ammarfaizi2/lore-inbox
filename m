Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270404AbTGMVU2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 17:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270413AbTGMVU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 17:20:28 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:8849 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S270404AbTGMVUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 17:20:20 -0400
Date: Sun, 13 Jul 2003 23:34:46 +0200 (MEST)
Message-Id: <200307132134.h6DLYkJC019846@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.6.0-pre2 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.6.0-pre2 of perfctr, the Linux/x86 performance
monitoring counters driver, is now available at the usual
place: http://www.csd.uu.se/~mikpe/linux/perfctr/

Although this release makes the mmap()ed counter state compatible
between x86 and x86-64, there are still several unresolved ABI
compatibility problems (not just x86 on x86-64 but also protection
for future drivers versions). I have the choice of either doing
ad-hoc solutions for each data relevant structure (info, counter sums,
counter control), or go with a generic sparse marshalling approach.
The latter has been prototyped and _will_ work, but it's a radical
departure from conventional kernel/user-space APIs.

Version 2.6.0-pre2, 2003-07-13
- Per-process perfctrs API fixes: control data is retrieved using
  new READ_CONTROL operation, mmap()ed state no longer exposes the
  control data, the SAMPLE operation is renamed to READ_SUM and
  now updates a given user-space buffer, non-write operations are
  permitted on dead perfctrs.
  Retrieving control explicitly makes the user-visible mmap()ed
  state binary compatible between x86 and x86-64. The other changes
  simplify the user-space library and allow perfex to replace raw
  mmap() accesses with higher-level operations.
- Driver cleanups, including eliminating many #ifdefs and
  removing some unnecessary P4-specific driver procedures.
- Fixes for macro redefinition warnings in the 2.4.22-pre3 kernel.
- Perfctr library RPM spec file updates from Bryan O'Sullivan.

/ Mikael Pettersson
