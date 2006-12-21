Return-Path: <linux-kernel-owner+w=401wt.eu-S964793AbWLULJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWLULJT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 06:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWLULJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 06:09:18 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:33030 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964793AbWLULJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 06:09:18 -0500
Date: Thu, 21 Dec 2006 13:09:14 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] x86_64: fix boot hang caused by CALGARY_IOMMU_ENABLED_BY_DEFAULT
Message-ID: <20061221110914.GY30145@rhun.ibm.com>
References: <20061220102846.GA17139@elte.hu> <20061220113052.GA30145@rhun.ibm.com> <20061220162338.GC11804@elte.hu> <20061220180953.GM30145@rhun.ibm.com> <20061221103702.GA19451@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221103702.GA19451@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 11:37:02AM +0100, Ingo Molnar wrote:

> I think in the future it would be better to annotate the introduction of 
> new, widely used codepaths via KERN_DEBUG printouts, something along the 
> lines of:
> 
> 	printk(KERN_DEBUG "calgary: running new EBDA code.\n");
> 	...
> 	printk(KERN_DEBUG "calgary: done.\n");
> 
> That way "debug ignore_loglevel console=tty" bootopions would have 
> uncovered the source of this hang. Just like i can use the 
> initcall_debug boot option to figure out where the bootup hangs.
> 
> but i still /strongly/ disagree with your attitude that mainline is 
> 'experimental' and hence there's nothing to see here, move over.

We can agree to disagree about how "experimental" mainline should
be. The bottom line is that the patch that broke your boot was the
"obviously correct" thing to do, and even if mainline was "rock
stable", whatever that means, we still would've put it in because it
fixed boot on a different set of machines... Basically we have to
query the BIOS for Calgary register window and bus setup informationn,
what we had before was a brittle hack (replicate what the BIOS did to
get the same values) that eventually broke when the BIOS - surprise,
surprise - did something differently. Of course that doesn't mean the
bug you ran into shouldn't have been caught earlier.

> > > The other problem is that the changelog entry says that it's off by 
> > > default, while in reality the new option switched this code on for 
> > > my box, and broke it.
> > 
> > Sorry about that (both the wrong changelog entry and the fact that it 
> > broke your box).
> 
> there's really no need to apologize, i probably broke your box a few 
> orders of magnitude more times than you broke mine ;)

You got that right :-) but still, I should've caught the potential
infinite loop with bad BIOS inputs when reviewing the patch. For that
I do apologize.

> Nevertheless my point is that we /have/ to be more supportive of
> early adopter distro kernels (Dave Jones says that the same bug has
> hit Fedora rawhide too), and have to be doubly careful about
> anything that goes into code that is run by /everyone/. Especially
> if it's in a hard to debug place like early bootup code.

No argument about this.

> This incident i think shows that bisection and testing in -mm doesnt
> always cut it (bisection-testing is quite laborous with a large
> distro kernel), and i think we could do more technological measures
> in this area to lower the bar of entry for users to help us narrow
> down such bugs. Such as a KERN_DEBUG policy for annotating new code
> in the bootup path.

Agreed.

Cheers,
Muli
