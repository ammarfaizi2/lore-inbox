Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266658AbUBQWDE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 17:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266653AbUBQWCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 17:02:54 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:36993 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S266628AbUBQWCj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 17:02:39 -0500
Date: Tue, 17 Feb 2004 15:02:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][0/6] A different KGDB stub
Message-ID: <20040217220236.GA16881@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew.  The following is my next attempt at a different KGDB stub
for your tree (and then hopefully into kernel.org).  This is against
2.6.3-rc4 + bk-netdev-rc3 (from your tree), and nothing else.  This has
been tested on PPC32 (KGDB=y/n) and i386 (KGDB=y and allmodconfig) and
not at all on x86_64 (no time to build a toolchain yet).  Since the last
time, I've done the following:
- SysRq-G is always part of SYSRQ && KGDB.
- choice for I/O (8250 serial, kgdboe and PPC 'simple' serial, for now).
- On x86_64 / PPC32, we don't bother with CHK_DEBUGGER, but instead
  always use the arch provided debugger hooks.

Thre are 6 different patches:
core.patch: All of the non-arch specific bits, that aren't drivers.
8250.patch: The i/o driver for KGDB, via a standard PC uart.
kgdboe.patch: The i/o driver for KGDB, via netpoll.
i386.patch: The i386-specific code, tested.
ppc32.patch: The ppc32-specific code, tested.
x86_64.patch: The x86_64-specific bits, untested.

One last note.  For some reason, kgdboe isn't working for me right now.
But it doesn't look like it's something specific to the kgdboe driver
(Dropping in the -mm one and changing names to match still shows it, and
the serial driver is solid) so I'm not sure if it's anything other than
my bad luck today.  So if nothing else, if someone else could give this
a shot and let me know if it works for them...

-- 
Tom Rini
http://gate.crashing.org/~trini/
