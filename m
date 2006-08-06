Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbWHFC4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWHFC4H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 22:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWHFC4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 22:56:07 -0400
Received: from ozlabs.org ([203.10.76.45]:4532 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751497AbWHFC4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 22:56:06 -0400
Subject: Re: [PATCH] Turn rdmsr, rdtsc into inline functions, clarify names
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060806023824.GA41762@muc.de>
References: <1154771262.28257.38.camel@localhost.localdomain>
	 <20060806023824.GA41762@muc.de>
Content-Type: text/plain
Date: Sun, 06 Aug 2006 12:56:03 +1000
Message-Id: <1154832963.29151.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-06 at 04:38 +0200, Andi Kleen wrote:
> On Sat, Aug 05, 2006 at 07:47:41PM +1000, Rusty Russell wrote:
> > [Andi, sorry, x86_64 part untested, so sending straight to you]
> > 
> > rdmsr and rdtsc are macros, altering their arguments directly.  An
> > inline function would offer decent typechecking, but needs to take
> > pointer args.  The comment notes that gcc produces better code with
> 
> I think I prefer the macro variant actually. Sorry. It just looks
> better without the &s.

Hi Andi,

	Please reconsider.  This isn't about being pretty, it's about not
having hidden side-effects, and having typechecking.

> We don't care very much about the code quality here because
> rdmsr/wrmsr are always very slow in microcode anyways and tend
> to synchronize the CPUs.

Agreed, but comment about it above the macros made me wary, so I checked
it.  No significant code difference with gcc >= 4.0, at least.

> If you feel a need to clean up I would suggest you convert more
> users over to the ll variants which take a single 64bit value
> instead of two 32bit ones.

You mean the l and ll variants?  The 64 bit variants are rdmsrl and
rdtscll, not to be confused with rdtscl, which returns the lower 32
bits.  This confusion caused the x86_64 bug in gameport.c which the
patch comment mentioned (at least, seems to be a bug to me).

See why I want to fix these names?

So if you would prefer u64 rdtsc64(), u32 rdtsc_low(), u64 rdmsr64(int
msr), u32 rdmsr_low(int msr), I can convert everyone to that, although
it's a more invasive change...

Thanks,
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

