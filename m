Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVEQRFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVEQRFN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 13:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVEQREl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 13:04:41 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:29200 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261920AbVEQREF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 13:04:05 -0400
Date: Tue, 17 May 2005 18:04:05 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kirill Korotaev <dev@sw.ru>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watchdog config option (was: Re: [PATCH] NMI lockup
 and AltSysRq-P dumping calltraces on _all_ cpus via NMI IPI)
In-Reply-To: <Pine.LNX.4.58.0505170928220.18337@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61L.0505171747540.17529@blysk.ds.pg.gda.pl>
References: <42822B5F.8040901@sw.ru> <768860000.1116282855@flay>
 <42899797.2090702@sw.ru> <Pine.LNX.4.58.0505170844550.18337@ppc970.osdl.org>
 <Pine.LNX.4.61L.0505171656300.17529@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.58.0505170928220.18337@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2005, Linus Torvalds wrote:

> >  Mostly or perhaps even exclusively due to BIOS bugs -- you know, that 
> > piece of hidden firmware that runs in the SMM under our feet and fiddles 
> > randomly with hardware we can do nothing about.
> 
> I'd love to just blame the BIOS, but we've definitely had our own share of
> bugs too. NMI makes all the fast system call etc stuff much more
> "exciting", and we've several times had code that does actually disable
> interrupts for a long time - which may be exceedingly impolite, but then
> the NMI watchdog makes it a fatal error rather than something that is just
> a nuisanse.

 Well, this is actually not a problem with the watchdog itself.  And I'd 
rather say it's doing us a favour (and a great job) finding these buggy 
bits of code that keep interrupts off CPUs. ;-)

 Otherwise NMIs should be completely transparent.  Well, yeah, that's 
theory -- for this to be the case we'd have to use a task gate which is 
rather time consuming and using an interrupt gate means we need to take 
some explicit care elsewhere indeed.

 OTOH, we can always get an NMI from the chipset in response e.g. to a bus 
error of some kind (unfortunately it's often impossible to reroute these 
errors to a more useful interrupt, like an MCE), so we need to be prepared 
for one at any time.  But these errors are expected to be rare, so it's 
hard to test their effects, unlike these of the watchdog.

> Of course, our own bugs we can fix (and hopefully we have done so - many
> people _do_ obviously use the NMI watchdog as-is), so yes, in that sense 
> BIOS (and hardware) bugs end up being a special case.

 The problem with the SMM as currently used by BIOSes is unfortunately the 
design, not any particular implementation.

  Maciej
