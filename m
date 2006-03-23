Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbWCWXEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbWCWXEo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 18:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWCWXEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 18:04:44 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:43218
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932541AbWCWXEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 18:04:44 -0500
From: Rob Landley <rob@landley.net>
To: Mariusz Mazur <mmazur@kernel.pl>, llh-discuss@lists.pld-linux.org
Subject: Re: State of userland headers
Date: Thu, 23 Mar 2006 18:04:35 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl>
In-Reply-To: <200603231811.26546.mmazur@kernel.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603231804.35817.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 March 2006 12:11 pm, Mariusz Mazur wrote:

> This means that initially the llh-ng project would need to 
> start as a completely separate entity that would not require the
> original kernel headers for anything, and only later, after achieving
> some level of maturity and getting merged into the kernel, would come
> the time for removing some duplication. Of course that means that kernel
> hackers would (a) need to keep in mind that they have two places to
> update, (b) once llh-ng got merged, figure out where duplication can be
> avoided and do something about it and (c) even when that'd get done,
> still remember about double updates for places where duplication
> couldn't have been avoided.

I mentioned earlier that klibc seems like a good test case.  Make userspace 
headers that klibc can build against, and work up from there...

> I won't be loosing any sleep about it, though. Those mean kernel hackers
> never cared about us poor userland folks, so there's no reason we should
> feel sorry for them. Payback time.
>
> And now for some technical details on how I see it. I'd appreciate any
> input.
>
> First thing, is that we'd probably need to use a distributed rcs, since
> it's more flexible, and, well, distributed. Never used any, so git sounds
> as good an option, as anything else.
>
> Now, what I propose we do initially, is get a bunch of headers from current
> llh for the most popular archs and figure out how to build all the various
> *libcs against them. And of course update them to the newest kernel by the
> way.
>
> It'd probably be best if I did it. PLD has support for x86, x86_64, sparc,
> ppc and alpha, so that's what I'd take care of first. It might sound like a
> good idea to start with all available archs, but in reality we wouldn't
> even be able to test them most of the times, so it's best to stick with the 
> archs we're directly interested in.

Here at timesys I've got access to arm, mips, and ppc.  (Can't say I really 
know what I'm doing on any of them, but I'm learning.)

> just because we're waiting for one of the more exotic archs. How does
> one version such a project? Not like the old llh (x.y.z.t, where x.y.z
> corresponds to the kernel version), since not all releases would be
> always fully up to date with a given kernel. So maybe just automatic
> snapshots every day (assuming a change has been made). But if so, who's
> tree gets to be treated as the main one? (Distributed rcs, remember).
> And should we choose such a person, what is the chance he'll end up just
> like I did (a lazy schmuck that is)?
>
> Ok, I'm getting too detailed here. One thing at a time.
>
> So, waiting for any insights, counterproposals and/or declarations who's
> willing to work on old llh, llh-ng or both. Shoot away.

I'm a little confused about the goals of the project.

In order to take advantage of new kernel features, like major/minor numbers 
greater than 8 bits or DMA for cd burning, we need new kernel headers.  That 
sort of thing is why we didn't just build against 2.4 kernel headers, which 
for some reason seemed to be usable from userspace just fine.

You also don't want to run a libc built with newer headers than the kernel 
you're running on, or it'll try to use stuff that isn't there.

You're saying that the new kernel headers wouldn't be versioned using the 
kernel's release numbers.  How do we know what kernel version their feature 
set matches then?  (I'm confused.  This happens easily...)

Rob
-- 
Never bet against the cheap plastic solution.
