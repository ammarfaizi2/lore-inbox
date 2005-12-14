Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbVLNWY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbVLNWY0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbVLNWY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:24:26 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17423 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965030AbVLNWYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:24:13 -0500
Date: Wed, 14 Dec 2005 23:24:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix the EMBEDDED menu
Message-ID: <20051214222413.GG23349@stusta.de>
References: <20051214191006.GC23349@stusta.de> <20051214140531.7614152d.akpm@osdl.org> <20051214221702.GH7124@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214221702.GH7124@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 10:17:03PM +0000, Russell King wrote:
> On Wed, Dec 14, 2005 at 02:05:31PM -0800, Andrew Morton wrote:
> > Adrian Bunk <bunk@stusta.de> wrote:
> > >
> > > Hi Linus,
> > > 
> > > your patch to allow CC_OPTIMIZE_FOR_SIZE even for EMBEDDED=n has broken 
> > > the EMBEDDED menu.
> > 
> > It looks like that patch needs to be reverted or altered anyway.  sparc64
> > machines are failing all over the place, possibly due to newly-exposed
> > compiler bugs.
> > 
> > Whether it's the compiler or it's genuine kernel bugs, the same problems
> > are likely to bite other architectures.
> 
> I believe there are instances where ARM fails if CC_OPTIMIZE_FOR_SIZE
> is not set.  Luckily we have assertions in the generated assembly to
> flag these as assembly errors when they happen, rather than silently
> continuing to build.
> 
> Maybe CC_OPTIMIZE_FOR_SIZE should be:
> 
> 	bool "..." if BROKEN || (!ARM && !SPARC64)
> 
> ? 8)
> 
> Note also that the help text:
> 
>           WARNING: some versions of gcc may generate incorrect code with this
>           option.  If problems are observed, a gcc upgrade may be needed.
> 
> is reversed for the situation we have with ARM.  Hence, I propose we
> change this to something like:
> 
> 	  WARNING: some versions of gcc may generate incorrect code if this
> 	  option is changed form the platform default.  If problems are
> 	  observed, either a gcc upgrade may be needed or alternatively
> 	  the platform default should be selected (=y for ARM and Sparc64,
> 	  n for others.)

The patch

  [2.6 patch] offer CC_OPTIMIZE_FOR_SIZE only if EXPERIMENTAL

I sent a few minutes ago should handle this:
It allows changing the platform default only if EXPERIMENTAL is enabled.

> Russell King

cu
Adrian

BTW: The second platform defaulting to CC_OPTIMIZE_FOR_SIZE is H8300,
     not SPARC64.
-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

