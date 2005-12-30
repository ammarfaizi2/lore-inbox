Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbVL3XyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbVL3XyK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 18:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbVL3XyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 18:54:09 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:50185 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964920AbVL3XyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 18:54:08 -0500
Date: Sat, 31 Dec 2005 00:54:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       torvalds@osdl.org, arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051230235407.GC3811@stusta.de>
References: <20051228114637.GA3003@elte.hu> <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051230221222.GJ3356@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051230221222.GJ3356@waste.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 04:12:22PM -0600, Matt Mackall wrote:
> On Wed, Dec 28, 2005 at 08:11:50PM -0800, Andrew Morton wrote:
> > If no-forced-inlining makes the kernel smaller then we probably have (yet
> > more) incorrect inlining.  We should hunt those down and fix them.  We did
> > quite a lot of this in 2.5.x/2.6.early.  Didn't someone have a script which
> > would identify which functions are a candidate for uninlining?
> 
> It was a combination of a tool I wrote for -tiny, which added
> deprecation warnings to inlines along with a post-processing tool to
> count instantiations, nestings, etc., and a post-post-processing tool
> written by Denis Vlasenko that guessed at the space usage.
> 
> We cleaned up most of the obvious offenders quite a while ago, but
> there's quite a long tail on the usage distribution. It's simply not
> worth the trouble to go through the far half of the distribution one
> by one to figure out whether inlining makes sense.

The "figure out" task is easy:

There has to be a _very_ good reason for not deleting an inline in a .c 
file.

inline's in header files are a different topic, but in their case an 
explicit review would be better since the correct solution is in such 
cases often to move the code to a .c file (this might even result in 
additional space savings).

> So I'm in favor of changing our inlining philosophy moving forward.
> The world has changed since we started physically marking functions
> inline. When we started, basically all arches gained advantage from
> heavy inlining due to favorable CPU to memory speed ratios. And the
> compiler's automatic inlining was quite primitive. Now most (but not
> all!) arches heavily favor out of line code except in fairly critical
> locations and the compiler has gotten (just recently) quite a bit
> smarter with its inlining.
> 
> So we should really go back to using inline as a hint for 90%+ of
> candidate functions (using always.. and no.. for the rest), and using
> our compile-time size and arch information to fine-tune the compiler's
> decisions as to which hints to take.

I still don't understand why gcc needs any "inline" hints at all except 
in the cases where we want to force gcc to inline a function.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

