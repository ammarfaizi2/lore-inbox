Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbTIOAYQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 20:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbTIOAYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 20:24:16 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:42765 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262418AbTIOAYK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 20:24:10 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Date: 15 Sep 2003 00:15:09 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bk30ad$fra$1@gatekeeper.tmr.com>
References: <1063393505.3371.207.camel@workshop.saharacpt.lan> <20030912213016.47a4e5de.ak@suse.de>
X-Trace: gatekeeper.tmr.com 1063584909 16234 192.168.12.62 (15 Sep 2003 00:15:09 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030912213016.47a4e5de.ak@suse.de>,
Andi Kleen  <ak@suse.de> wrote:
| On Fri, 12 Sep 2003 21:05:06 +0200
| Martin Schlemmer <azarah@gentoo.org> wrote:
| 
| > I have long wondered if everything in arch/i386/kernel/cpu/ is
| > really linked in (meaning with no #ifdef as it now looks to be
| > at a quick peek), or if it was just easier to link them all,
| > but have non generic stuff (amd/cyrix/whatever specific code)
| > filtered by ifdef's.
| 
| It is (in MTRR drivers etc.), but the resulting overhead is small.
| 
| Currently I even link in Intel and Cyrix specific MTRR drivers on x86-64
| just to keep the common code common and clean.
| 
| Really, when you want to save code size you should look elsewhere. All the 
| CPU support code is pretty lean and in many cases is __init code anyways
| (= is discarded after boot time) 

If you want lean code you should look everywhere. I agree that init code
is free, and that there are worse offenders. But adding additional bloat
that the people who actually builds a kernel properly to fit their
hardware can't eliminate without patching, then perhaps that shouldn't
happen.

I'm not at all against having an option in the menu to "eliminate code
to support non-targeted processors." That could remove the code you so
want to have in so you don't have to build a properly configured kernel
for each machine.

How does "#if !defined(NO_BLOAT) || WANT_ARCH_IN_QUESTION feel for a
good thing to surround many parts of the kernel.

| 
| I can offer my old bloat-o-meter tool (ftp://ftp.firstfloor.org/pub/ak/perl/bloat-o-meter)
| It is great to look for bloat. Just run it with a 2.4 kernel and 2.6 kernel and compare
| the results. Then look at the top 50 bloat increasers. I bet with you that 
| you won't find anything touched in this thread among them.

The term "grandfathered" comes to mind, you are proposing to add new
bloat, and you justify that so you don't have to build a properly
configures kernel for each hardware configuration. I don't think anyone
will argue that all such code should be found and treated in the near
future, but if we did have a flag to prevent eggregious support for
non-selected hardware, I bet the embedded guys would contribute patches
over time to clean things up. And shouldn't 2.6 better than 2.4, instead
of "not much worse?"
| 
| I suspect for example if you just worked on making sysfs optional you would
| save a lot more.

As long as you don't have to add new code to support the functionality
in another way. The advantage is that if you can remove it you can
probably also make it modular, and that might be a nice thing during
development of embedded systems. Somewhat smaller but available?
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
