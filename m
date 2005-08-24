Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbVHXTMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbVHXTMn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 15:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbVHXTMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 15:12:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14978 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1751418AbVHXTMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 15:12:42 -0400
Date: Wed, 24 Aug 2005 20:15:44 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Paul Jackson <pj@sgi.com>
Cc: paulus@samba.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.13-rc7
Message-ID: <20050824191544.GM9322@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org> <20050824064342.GH9322@parcelfarce.linux.theplanet.co.uk> <20050824114351.4e9b49bb.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824114351.4e9b49bb.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 11:43:51AM -0700, Paul Jackson wrote:
> Al Viro wrote:
> > ... breaks ppc64 since there we have node_to_cpumask() done as inlined
> > function, not a macro.  So we get __first_cpu(&node_to_cpumask(...),...),
> > with obvious consequences.
> 
> I sent a patch for this a few hours ago, thanks to Paul Mackerras's report:
> 
>   [PATCH 2.6.13-rc6] cpu_exclusive sched domains build fix
> 
> It just makes a local copy of the cpumask_t in a local variable on the stack.
> 
> I'm still a couple of hours from actually verifying that ppc64 builds with
> this - due to unrelated confusions on my end.  Perhaps you or Mackerras will
> report in first, to verify if this patch works as advertised.

It does, no (build) regressions.  BTW, tree is not far from allmodconfig
buildable on a bunch of targets now - yesterday pile of fixes was about
half of the set needed for that.  Most of the remaining stuff is for
m68k (and applies both to Linus' tree and m68k CVS); I'll send that today
and if Geert ACKs them, we will be _very_ close to having 2.6.13 build
out of the box on the following set:
alpha, amd64, arm (RPC and versatile being tracked), i386, ia64, m32r,
m68k (!SUN3), ppc (6xx, 44x, chestnut being tracked), ppc64, sparc,
sparc64, s390, s390x, uml-i386, uml-amd64.

All of these - with allmodconfig, alpha, amd64 and i386 being tracked
separately as SMP and UP.  Missing targets:
	frv: need newer toolchain on build box
	mips, parisc: need out-of-tree patches
	v850, m68knommu: gcc gives ICE on attempt to build cross-toolchain
	h8300: binutils in FC4 doesn't know what to do with that target,
have not tried that on sarge yet.
	sh, sh64: need kernel headers that would make glibc happy enough
to build libc headers for that puppy; I don't have them
	cris, xtensa: haven't looked into those
	arm26: needs gcc3 since gcc4 had dropped that target; I might take
a look into that on a sarge-based build box someday.

sun3 is seriously broken and I doubt that we'll see any takers for testing
2.6 on those anyway ;-)

A bunch of arm and ppc subarchitectures are not covered yet - I can add those
to build setup, just give me a list in order of preference.  Or ask me how
to set up a cross-build farm of your own...
