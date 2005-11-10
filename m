Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbVKJQjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbVKJQjN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 11:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbVKJQjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 11:39:13 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:36824 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750709AbVKJQjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 11:39:12 -0500
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Tom Rini <trini@kernel.crashing.org>, lkml <linux-kernel@vger.kernel.org>
Message-Id: <20051110163906.20950.45704.sendpatchset@localhost.localdomain>
Subject: [PATCH,RFC 2.6.14 00/15] KGDB Support
Date: Thu, 10 Nov 2005 11:38:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Using a different script that doesn't do individual patch CC's, but should
  send to lkml this time ]

I'm once again submitting the KGDB found at
http://sourceforge.net/projects/kgdb for inclusion in the kernel.  Right now,
I'm mainly asking for comments again.  This series is against 2.6.14, and that
means it will fail, probably voilently, against 2.6.15-rc1 when it comes out
due to the PowerPC merge (aside, Paul, I'll take care of merging the old kgdb
;)), but I'd still like to get this into Andrew's tree at somepoint during
2.6.15 for future inclusion in Linus' tree, and will take back up tracking the
-rc releases at least.

This version of KGDB is designed so that as much code as possible is done in
a core file shared by all architectures, and with I/O (ie
8250 serial, custom uart, ethernet) being common when possible and modular.
The rough splitup of this is that 95% of the interaction with KGDB is done in
files common to all implementations with a small set of architecture specific
things (setjmp/longjmp, actually formatting registers for GDB, single
stepping).

Much of how to use this version (it is slightly different from George
Anzinger's version) is written up in DocBook and viewable that way.  I've
tried to do this in as clean a way as possible (notifier when possible for
example) so that it's as minimally instrusive as possible.  But, in order to
allow for KGDB to be used very early on (some folks argue this is critical,
some argue it's not) there's a few hooks so we can know if pidhash_init has
been run, or to try and have KGDB break in as soon as possible, if it can't
right then (such as on x86_64 where we're still trying to deal with early
per-cpu things so we can work early).

Comments?  Thanks!

-- 
Tom
