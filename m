Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbUEOT0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbUEOT0n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 15:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264677AbUEOT0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 15:26:43 -0400
Received: from colin2.muc.de ([193.149.48.15]:15369 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262132AbUEOT0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 15:26:41 -0400
Date: 15 May 2004 21:26:40 +0200
Date: Sat, 15 May 2004 21:26:40 +0200
From: Andi Kleen <ak@muc.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: ak@muc.de, bos@serpentine.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][3/7] perfctr-2.7.2 for 2.6.6-mm2: x86_64
Message-ID: <20040515192640.GB5748@colin2.muc.de>
References: <200405151444.i4FEiDkK001433@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405151444.i4FEiDkK001433@harpo.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2004 at 04:44:13PM +0200, Mikael Pettersson wrote:
> On Sat, 15 May 2004 11:09:11 +0200, Andi Kleen wrote:
> >> entail; just look at the horrendous mess that is the P4 performance
> >> counter event selector.
> >
> >There is no way around that - there are kernel users (like the
> >nmi watchdog or oprofile) and kernel users cannot be made dependent 
> >on user space modules.
> 
> The NMI watchdog uses a simple static mapping. No problem there.

So how do you prevent your user applications from overwriting
the single perfctr the watchdog uses?

I actually wrote some monitoring applications that changed perfctrs
from user space in the past (using /dev/msr), but I always wanted
to get rid of the adhoc hacks I had to do to detect interaction with the 
watchdog and replace them with a real mechanism.

> User-space needs to know about it anyway. For instance, unless
> you understand the HW constraints, you may try to enable mutually
> exclusive events. Some events may be unconstrained, but you need
> to know about the constrained ones before you assign the
> unconstrained ones. And user-space must know the mapping anyway
> for the RDPMC instruction.

Sure, but it could still ask the kernel if it's available, no?

> 
> The kernel, in the case of both perfctr and oprofile, needs to be
> informed of the mapping, but it has no real reason to compute it
> itself -- especially not on a complex machine like the P4.

It needs some way to veto a mapping when the counter is already
used for something.

> We don't put an abstract floating-point module in the kernel,
> charging it with choosing x87, 3dnow!, or sse code, and
> performing register allocation, do we?

Bad analogy.  The kernel switches the FP state and each process
has its own and does not impact any other processes.

It would be needed if the kernel used e.g. XMM0 for something
without hiding it from the user (like the NMI watchdog does), but 
that's not the case.

-AndI
