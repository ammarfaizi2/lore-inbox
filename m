Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265875AbUBLACk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 19:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266099AbUBLACk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 19:02:40 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:26814 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S265875AbUBLACj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 19:02:39 -0500
Date: Wed, 11 Feb 2004 17:02:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][0/6] A different KGDB stub
Message-ID: <20040212000237.GA19676@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew.  As a reply to this message, I'm going to send you patches to
replace George's KGDB with a version that is Amit Kale's work, with a
number of additional cleanups (that I'll put in his CVS ASAP).  There
are 6 different patches:
core.patch: All of the non-arch specific bits, that aren't drivers.
8250.patch: The i/o driver for KGDB, via a standard PC uart.
kgdboe.patch: The i/o driver for KGDB, via netpoll.
i386.patch: The i386-specific code, tested.
ppc32.patch: The ppc32-specific code, tested.
x86_64.patch: The x86_64-specific bits, untested.

With this, there's a few design questions I have.  First, as I've done
things right now, a breakpoint at the first line of C code is untested.
It should work, but I have a question of how we want to handle setting
up the pointer to our i/o functions (if we have a pointer).  There's a
couple of ways that this could be solved, with pros and cons.  For
example, if we want to allow for both serial and enet to be used in the
same kernel, we could default to setting this pointer to the 8250
version, and allow for kgdb_arch_init to override (as PPC sometimes
does).  This is what I've done for now, but I don't know if I like how
it looks or not. If we don't care about allowing for > 1 i/o driver, we
can simply drop kgdb_serial as a function pointer and just call
kgdb_getDebugChar/kgdb_putDebugChar/etc.  Or someone else can suggest an
better way.

Next, what features of George's version are a must-have?  And what that
we have now, can we drop?  For example, up until I started working on
kgdboe+netpoll, I found KGBB_CONSOLE quite handy.  Now, I'm very happy
with netconsole, so I don't have a strong attachment to KGDB_CONSOLE
anymore.  But it's not much code anyhow.  And of course, what could be
done better?

-- 
Tom Rini
http://gate.crashing.org/~trini/
