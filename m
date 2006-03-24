Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWCXVYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWCXVYh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 16:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWCXVYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 16:24:37 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:17888
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750890AbWCXVYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 16:24:36 -0500
From: Rob Landley <rob@landley.net>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: State of userland headers
Date: Fri, 24 Mar 2006 16:23:49 -0500
User-Agent: KMail/1.8.3
Cc: Mariusz Mazur <mmazur@kernel.pl>, llh-announce@lists.pld-linux.org,
       LKML Kernel <linux-kernel@vger.kernel.org>, dank@kegel.com,
       nkukard@lbsd.net, vmiklos@frugalware.org, rseretny@paypc.com,
       lkml@dervishd.net, jbailey@ubuntu.com, llh-discuss@lists.pld-linux.org
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com>
In-Reply-To: <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603241623.49861.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 1:51 pm, Kyle Moffett wrote:
> On Mar 23, 2006, at 12:11:26, Mariusz Mazur wrote:
> > There was a thread on lkml on this topic about a year ago. IIRC
> > I've suggested, that the best option would be to get a new set of
> > dirs somewhere inside the kernel, and gradually export the userland
> > usable stuff from the kernel headers, so to (a) achieve full
> > separation and (b) avoid duplication of definitions (meaning that
> > kernel headers would simply include the userland ones where
> > required). Linus said, that it would break stuff and so is
> > unacceptable.
>
> I seem to remember Linus saying that "breaking things is
> unacceptable", not that the project was guaranteed to break things
> (we would just need to be much more careful about it than most kernel
> patches).

The gentoo guys clean up their own headers, apparently.  I'm told they do so 
by moving around the #ifdef __KERNEL__ stuff to be in the correct places, and 
that they're currently working on a 2.6.14 or 2.6.15 version of the headers:

http://www.gentoo.org/cgi-bin/viewcvs.cgi/src/patchsets/gentoo-headers/?root=gentoo

> What that seems to indicate to me is that an in-kernel 
> version would need to do the following for userspace-accessible
> header files for a large number of kernel releases:
>
> #ifndef _LINUX_HEADER_H
> #define _LINUX_HEADER_H
> #include <kabi/header.h>
>    /* Define or typedef a bunch of __kabi_ prefixes to the old
> prefixes they used to have in the kernel header */
> #ifndef __KERNEL__
> # warning "The header file <linux/header.h> is deprecated for"
> # warning "userspace, please use <kabi/header.h> instead."
> #else
>    /* Kernel-only declarations/definitions */
> #endif

Changing the #include paths in all deployed software will basically never 
happen.  If this header package requires that, I'm not interested in it 
because I can't build existing software against it, and I don't expect anyone 
else to be.

I was thinking of possibly a parallel header set under linux-2.6.x/usr/include 
which the linux-2.6.x/include/*.h could #include to clean out their #ifndef 
__KERNEL__ stuff, and that eventually the usr/include stuff would contain 
approximately what Mazur's headers had contained.  Unfortunately, I'm under 
the impression that's not a realistic approach.

> If this were done carefully, all programs that compile against kernel
> headers could be _fixed_ in the short term (they'd go from throwing
> errors to giving a couple deprecation warnings).  In the long term,
> the extra ifdeffery could be removed and the <linux/*.h> headers for
> which a <kabi/*.h> replacement had existed for a couple versions
> could be removed.  New ABIs (including IOCTLs, new syscalls, etc)
> could be required to use <kabi/*.h> in the first place.

A program that includes kabi/* instead of linux/* won't build against older C 
libraries with older headers from older kernel versions (or older project's 
like Mazur's headers).

> 1: Ewww, bad glibc!
> 2: The symbols in kabi/*.h should probably all start with __kabi_

Any grand new incompatible thing is something I will happily ignore for as 
long as I am able to, and I'm not alone here.  Your uptake will be zero.

Rob
-- 
Never bet against the cheap plastic solution.
