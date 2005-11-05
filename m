Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVKEREP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVKEREP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 12:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbVKEREP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 12:04:15 -0500
Received: from outbound04.telus.net ([199.185.220.223]:21377 "EHLO
	priv-edtnes51.telusplanet.net") by vger.kernel.org with ESMTP
	id S1750731AbVKEREP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 12:04:15 -0500
From: Andi Kleen <ak@suse.de>
To: Andrea Arcangeli <andrea@cpushare.com>
Subject: Re: disable tsc with seccomp
Date: Sat, 5 Nov 2005 18:04:08 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20051105134727.GF18861@opteron.random> <200511051712.09280.ak@suse.de> <20051105163134.GC14064@opteron.random>
In-Reply-To: <20051105163134.GC14064@opteron.random>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511051804.08306.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 November 2005 17:31, Andrea Arcangeli wrote:
> On Sat, Nov 05, 2005 at 05:12:09PM +0100, Andi Kleen wrote:
> > It is normally on on all x86-64 systems.
>
> Can the performance counters be disabled for seccomp only right?

Yes, there is a bit to disable reading performance counters in ring 3.

But I promise you to complain about a patch to add setting it in the context 
switch too :)

> > I definitely don't want any code like this in the context switch. It is
> > critical and I don't want to pollute fast paths with stuff like this
> > that nobody needs.
>
> 287 registered CPUShare users will appreciate to compute more securely
> thanks to this feature (about 10 up at any given time), and once I start
> allowing transactions I hope much more users will need this (it's not
> finished yet).

I don't believe they need it - the side channel attack is too theoretical for 
their use case.

> We have in the kernel lots of features that slowdown a bit and that
> benefit only a part of the userbase. Even kmap only benefits people with
>
> >1G of ram. Even the security_* api in the syscalls only benefit a part
>
> of the userbase. There are infinite other examples. The point is that
> none of this is measurable, 

LSM was actually quite measurable on some systems, the indirect 
calls really hurt on IA64 on some of the network benchmarks.

> _especially_ this one in the context switch, 
> context switches aren't as frequent as syscalls! It's only two
> cachelines at every context switch, and they might be hot

If they're not hot for some reason (e.g. cache pig in userspace) you're 
talking about 1000+ cycles.

> Plus Andrew would have never allowed it to go in, if this could have
> impacted performance, you also should know this can't slowdown anything
> and you're just talking about theory.

The person talking about theory is you in my opinion with this basically
theoretical attack.

> Of course if 1000 other people also adds their feature to the context
> switch then it might become measurable, but this is the first time we
> had to change the context switch to add more security on per-task basis,

Better to stamp out any such attempts in the roots.

-Andi
