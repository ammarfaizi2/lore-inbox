Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267549AbUHEFf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267549AbUHEFf6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 01:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267550AbUHEFf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 01:35:58 -0400
Received: from lakermmtao12.cox.net ([68.230.240.27]:17808 "EHLO
	lakermmtao12.cox.net") by vger.kernel.org with ESMTP
	id S267549AbUHEFfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 01:35:54 -0400
Date: Wed, 4 Aug 2004 20:44:02 -0400
From: Chris Shoemaker <c.shoemaker@cox.net>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Message-ID: <20040805004402.GA6304@cox.net>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408042216.12215.gene.heskett@verizon.net> <20040804204640.64cd65fc.akpm@osdl.org> <200408050031.21366.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408050031.21366.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 12:31:21AM -0400, Gene Heskett wrote:
> On Wednesday 04 August 2004 23:46, Andrew Morton wrote:
> >Gene Heskett <gene.heskett@verizon.net> wrote:
> >>
> >>  The attachment this gentleman included specifically points to
> >>  prune_dcache().  Thats nice.  It also means I'm not alone.  See
> >> the 'prune_dcache() Oops, the saga continues' thread.
> >
> >Except he's running a 2.4 kernel.
> >
> >Is there any reason why I'm wrong in thinking that you have dodgy
> >hardware?
> 
> Well, it has, in the past week, ran memtest86-3a for 12 full passes 
> over the whole gig of ram with no errors.  This was the longest test, 
> I gave it a 2 hour, 5 pass test before I ever booted linux the first 
> time on this motherboard over 2 weeks ago now, a new Biostar 
> M7NCD-Pro, with an nforce2(3?) chipset.  I did that because I was 
> comeing from an older board whose memory had been overstressed by a 
> failing video card and I wanted to make sure this new memory, nearly 
> $210 worth of it, was good. I gave it another, probably 4 hour test 
> after the first couple of crashes, which it also passed.  And it got 
> worse as the kernel versions incremented from 2.6.7.  I can have the 
> same fault in prune_dcache() while running a 2.6.7 kernel without an 
> instant lockup, but it will eventually die, maybe half an hour later.  
> Move to 2.6.7-mm1, which has a patch to fs/dcache.c that remains 
> untouched thru 2.6.8-rc2, and those kernels, if they lock up, do it 
> totally, often with nothing in the logs at all.  That was the case 
> today, on 2.6.8-rc3, which has a new dcache.c patch in it if I read 
> the release notes correctly.
> 
> If this is dodgy hardware, give me something to take to tcwo.com when 
> I ask for an rma.  Not having M$ windows of any kind here, I frankly 
> haven't had the inclination to look at the cd's that came with the 
> board.  Should I?
> 
> Or does linux have a hardware test suite I've not heard about?

Gene,
	I sympathize with you.  Back in March and April I was seeing
oopses in prune_dcache() once every few days.  After tracing the asm
down for a few of them, I found one that looked like a 3 bit flip and
then one that looked like a single bit flip.  I memtested my RAM for
days with no failure.  I tried cpuburn.  I looped over kernel compiles.
I couldn't make it fail, but every day or two, as long as I wasn't
trying, I'd get an oops, and more than %50 were in prune_dcache.  I
believed that there was a correspondence with low memory conditions, but
I never proved this.  I _added_ a memory module (keeping everything I
had) and I compiled 2.6.7-rc3 on Jun 10th.  I haven't oopsed since.  (I
think I may also have turned off PREEMP around this time, so that's why
I suggested it earlier.)

	FWIW, I've seen no fewer than 4 independent reports that looked
suspiciously like yours and mine over the past 3 months.  Maybe we all
have bad hardware, and memtest86 just isn't stressful enough to show it.
The alternative is that there's some bug that has affected several
versions of 2.6 (and maybe 2.4) that seems to hit in low memory
conditions (e.g. as a result of a 4am cron.daily, or a large rsync).

	If you're curious, search google groups for "+oops +prune_dcache
group:linux.kernel", sort by date and look through the first 3 or 4
pages.  You'll see the same story with the same oopses over and over.
I know the few single bit flips are _probably_ bad hardware, but the more
similarities I see, the more I wonder.

	But, since my problems have completely gone away by adding more RAM, 
I haven't been motivated to track it down anymore.

	Sorry I can't be more helpful.  Good luck.

-chris
> 
