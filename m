Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUEOJJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUEOJJP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 05:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUEOJJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 05:09:15 -0400
Received: from colin2.muc.de ([193.149.48.15]:18952 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261347AbUEOJJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 05:09:13 -0400
Date: 15 May 2004 11:09:11 +0200
Date: Sat, 15 May 2004 11:09:11 +0200
From: Andi Kleen <ak@muc.de>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Andi Kleen <ak@muc.de>, Mikael Pettersson <mikpe@csd.uu.se>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][3/7] perfctr-2.7.2 for 2.6.6-mm2: x86_64
Message-ID: <20040515090911.GA21406@colin2.muc.de>
References: <1VLRr-38z-19@gated-at.bofh.it> <m3oeorvy58.fsf@averell.firstfloor.org> <1084599456.4895.103.camel@obsidian.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084599456.4895.103.camel@obsidian.pathscale.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 10:37:36PM -0700, Bryan O'Sullivan wrote:
> On Fri, 2004-05-14 at 08:14, Andi Kleen wrote:
> 
> > Before merging all that I would definitely recommend some generic
> > module to allocate performance counters. IBM had a patch for this
> > long ago, and it is even more needed now.
> 
> That's currently handled in user space, by PAPI (which sits on top of
> perfctr).  One reason *not* to do it in the kernel is the bloat it would

That's clearly the wrong place to do it.

> entail; just look at the horrendous mess that is the P4 performance
> counter event selector.

There is no way around that - there are kernel users (like the
nmi watchdog or oprofile) and kernel users cannot be made dependent 
on user space modules. Also I think managing of hardware resources is the 
primary task of a kernel, nothing that should be delegated to user 
space.

The netburst mess can be probably abstracted just into more counters.
The kernel doesn't need to know everything about them, just roughly
how many independent counters there are.

> 
> > Why do you check for K8 C stepping? I don't see any code that
> > does anything special with that.
> 
> The reason it's interesting at all is that it's the first K8 stepping
> that introduces new performance counter unit masks.  The kernel driver
> already passes its notion of what the CPU type is up to userspace. 
> (Clearly, userspace could figure this out, since it's just parsing the
> cpuid instruction.)
> 
> It also checks the CPU type in a few places internally; it just doesn't
> happen to care internally about K8 stepping C.  Thoroughness?

Why does the library caring about that not just read /proc/cpuinfo
to find out?

I sense pointless duplication of mechanism.

-Andi
