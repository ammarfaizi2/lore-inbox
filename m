Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVEQQa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVEQQa7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 12:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVEQQa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 12:30:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:6833 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261522AbVEQQaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 12:30:52 -0400
Date: Tue, 17 May 2005 09:32:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
cc: Kirill Korotaev <dev@sw.ru>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watchdog config option (was: Re: [PATCH] NMI lockup
 and AltSysRq-P dumping calltraces on _all_ cpus via NMI IPI)
In-Reply-To: <Pine.LNX.4.61L.0505171656300.17529@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.58.0505170928220.18337@ppc970.osdl.org>
References: <42822B5F.8040901@sw.ru> <768860000.1116282855@flay>
 <42899797.2090702@sw.ru> <Pine.LNX.4.58.0505170844550.18337@ppc970.osdl.org>
 <Pine.LNX.4.61L.0505171656300.17529@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 May 2005, Maciej W. Rozycki wrote:
>
> On Tue, 17 May 2005, Linus Torvalds wrote:
> > 
> > I really don't want NMI watchdogs enabled by default. It's historically 
> > been _very_ fragile on some systems. Whether that has been due to harware 
> > or sw bugs, I dunno, but it's definitely been problematic.
> 
>  Mostly or perhaps even exclusively due to BIOS bugs -- you know, that 
> piece of hidden firmware that runs in the SMM under our feet and fiddles 
> randomly with hardware we can do nothing about.

I'd love to just blame the BIOS, but we've definitely had our own share of
bugs too. NMI makes all the fast system call etc stuff much more
"exciting", and we've several times had code that does actually disable
interrupts for a long time - which may be exceedingly impolite, but then
the NMI watchdog makes it a fatal error rather than something that is just
a nuisanse.

Of course, our own bugs we can fix (and hopefully we have done so - many
people _do_ obviously use the NMI watchdog as-is), so yes, in that sense 
BIOS (and hardware) bugs end up being a special case.

		Linus
