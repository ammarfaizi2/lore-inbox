Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbVLNWRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbVLNWRM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbVLNWRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:17:12 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22793 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965021AbVLNWRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:17:11 -0500
Date: Wed, 14 Dec 2005 22:17:03 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix the EMBEDDED menu
Message-ID: <20051214221702.GH7124@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Adrian Bunk <bunk@stusta.de>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20051214191006.GC23349@stusta.de> <20051214140531.7614152d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214140531.7614152d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 02:05:31PM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > Hi Linus,
> > 
> > your patch to allow CC_OPTIMIZE_FOR_SIZE even for EMBEDDED=n has broken 
> > the EMBEDDED menu.
> 
> It looks like that patch needs to be reverted or altered anyway.  sparc64
> machines are failing all over the place, possibly due to newly-exposed
> compiler bugs.
> 
> Whether it's the compiler or it's genuine kernel bugs, the same problems
> are likely to bite other architectures.

I believe there are instances where ARM fails if CC_OPTIMIZE_FOR_SIZE
is not set.  Luckily we have assertions in the generated assembly to
flag these as assembly errors when they happen, rather than silently
continuing to build.

Maybe CC_OPTIMIZE_FOR_SIZE should be:

	bool "..." if BROKEN || (!ARM && !SPARC64)

? 8)

Note also that the help text:

          WARNING: some versions of gcc may generate incorrect code with this
          option.  If problems are observed, a gcc upgrade may be needed.

is reversed for the situation we have with ARM.  Hence, I propose we
change this to something like:

	  WARNING: some versions of gcc may generate incorrect code if this
	  option is changed form the platform default.  If problems are
	  observed, either a gcc upgrade may be needed or alternatively
	  the platform default should be selected (=y for ARM and Sparc64,
	  n for others.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
