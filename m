Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVCOCV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVCOCV4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 21:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbVCOCV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 21:21:56 -0500
Received: from gate.crashing.org ([63.228.1.57]:3741 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262202AbVCOCVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 21:21:48 -0500
Subject: Re: [swsusp/ppc] Re: What's going on here ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: rjw@sisk.pl, hugang@soulinfo.com, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <20050315010700.GA1357@elf.ucw.cz>
References: <1110847432.5863.57.camel@gaston>
	 <20050315010700.GA1357@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 13:19:46 +1100
Message-Id: <1110853186.5863.70.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> rjw and hugang did (pretty neccessary) changes to base swsusp (pagedir
> table -> pagedir linklist), that unfortunately needed update to all
> the assembly parts. It was series 1/3 update core, i386 and x86-64,
> 2/3 update ppc, 3/3 introduce initramfs.
> 
> This is the offending patch I believe (but the version that was merged
> was From: me, without code changes).
> 
> I realized that patch does more than changing from table to linklist,
> but it looked mostly okay, so I forwarded it. Sorry.

It does more than that ... it _adds_ swsusp to ppc ! swsusp wasn't in
mainline at all for ppc because I consider it not ready. And even the
asm change should go through me anyway since i wrote that code and I'm
not sure they know all the possible "issues" with that code.

> So, what to do now?
> 
> a) just revert it
> 
> or
> 
> b) revert pmac_setup.c and via-pmu parts and Kconfig part
> 
> or
> 
> c) just disable Kconfig part and fix it up with incremental patches

I'll decide later today. I may well keep it and do the cleanup I had in
mind on top of this, which means merging the pmac suspend-to-ram with
the common infrastructure. But that will need some changes & hooks to
the core swsusp.

Ben.


