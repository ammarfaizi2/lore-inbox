Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbWHFDQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbWHFDQp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 23:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWHFDQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 23:16:45 -0400
Received: from colin.muc.de ([193.149.48.1]:46341 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751506AbWHFDQo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 23:16:44 -0400
Date: 6 Aug 2006 05:16:43 +0200
Date: Sun, 6 Aug 2006 05:16:43 +0200
From: Andi Kleen <ak@muc.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dmitry.torokhov@gmail.com
Subject: Re: [PATCH] Turn rdmsr, rdtsc into inline functions, clarify names
Message-ID: <20060806031643.GA43490@muc.de>
References: <1154771262.28257.38.camel@localhost.localdomain> <20060806023824.GA41762@muc.de> <1154832963.29151.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154832963.29151.21.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Please reconsider.  This isn't about being pretty, it's about not
> having hidden side-effects,

I wouldn't call it hidden, it's well defined in the architecture.

> and having typechecking.

The existing code will already reject any non integer and I don't
see a particular need to be more strict than that.

> > If you feel a need to clean up I would suggest you convert more
> > users over to the ll variants which take a single 64bit value
> > instead of two 32bit ones.
> 
> You mean the l and ll variants?  The 64 bit variants are rdmsrl and
> rdtscll, not to be confused with rdtscl, which returns the lower 32
> bits.  This confusion caused the x86_64 bug in gameport.c 

Why does gameport access MSRs or TSCs? That sounds like a bug in itself.

<looking at the code> 

This whole thing is broken, e.g. on a preemptive kernel when the
code can switch CPUs 

Dmitry, I would suggest to convert it over to do_gettimeofday and remove
all the architecture ifdefs.

Or maybe just remove it completely.  Who cares about the speed of a gameport 
anyways? And why can't they measure it in user space? 

> See why I want to fix these names?

No.

> So if you would prefer u64 rdtsc64(), u32 rdtsc_low(), u64 rdmsr64(int
> msr), u32 rdmsr_low(int msr), I can convert everyone to that, although
> it's a more invasive change...

I think things are most fine right now, except that I think most users
of high low should be converted to work directly on 64bit quantities.

-Andi
