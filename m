Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWIGLoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWIGLoL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 07:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWIGLoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 07:44:11 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:34830 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751000AbWIGLoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 07:44:09 -0400
Date: Thu, 7 Sep 2006 12:43:58 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>,
       linux-arch@vger.kernel.org
Subject: Re: [2.6 patch] re-add -ffreestanding
Message-ID: <20060907114358.GA26551@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, Andi Kleen <ak@suse.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Roman Zippel <zippel@linux-m68k.org>, linux-arch@vger.kernel.org
References: <20060830175727.GI18276@stusta.de> <200608302013.58122.ak@suse.de> <20060830183905.GB31594@flint.arm.linux.org.uk> <20060906223748.GC12157@stusta.de> <20060907063049.GA15029@flint.arm.linux.org.uk> <20060907102740.GH25473@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060907102740.GH25473@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 12:27:40PM +0200, Adrian Bunk wrote:
> And I'm getting bashed for sendind a patch to revert it "only" to 
> linux-kernel...

You're not getting bashed - you're getting directed to the correct place
to discuss this issue.  There are some architecture maintainers who might
have some input who aren't subscribed to linux-kernel.

Incidentally, the addition of -ffreestanding was only sent to linux-kernel
in the first place back in 2004, so this actually gives those architecture
maintainers a chance to actually comment on it.  At the time, no one
commented on it - maybe it got missed?  I certainly did.

 http://marc.theaimsgroup.com/?l=linux-kernel&m=110194462121275&w=2

As far as your argument that the kernel is not a hosted environment, that's
debatable (as you're finding out).

If we decide that we want the compiler to treat our source as if it were a
hosted environment, and we provide sufficient implementation of a conforming
nature of a hosted environment then that is our perogative to do so.  That
is a decision that we are entirely free to make.  By doing so, we take on
the responsibility to provide whatever is required for a hosted environment
as opposed to the more limited functionality of a freestanding environment.

We _have_ taken on that responsibility.  We have even taken on the
responsibility to provide the compiler's internal library functions in
some cases.

The question really comes down to two points:

1. do the C standard defined library services we use in the kernel have
   the behaviour required by the C standard
2. do we provide everything that the compiler would want to use in the
   environment mode we have chosen.

The answer to both is generally yes, except when something is omitted for
a reason.  (eg, float support.)

And two final points:

- according to what I read in the gcc manual, free standing environments
  are required to provide float support.  We don't, so it could be possible
  to argue that we provide neither a freestanding nor a hosted environment,
  and, therefore, we shouldn't be using gcc at all.

- architecture maintainers should be left to decide what implementation
  option they require the kernel to be built in, since it's the architecture
  support code which provides most of the runtime environment.

> Adrian
> (who has just deleted all his cross compilers for getting rid of all 
>  these troubles)

If that's how you feel and what you've done, you seem to have disqualified
yourself from handling generic kernel changes.

I notice that you didn't respond to anything else in my message, so I can
only assume that you've accepted my reasoning and are no longer going to
push this patch.  So treat the above as the finer detailed reasoning.

I'm not anti--ffreestanding per se, but if we _are_ going to switch (back)
to that compiler mode, I want to ensure that we aren't walking backwards
from the point I _thought_ we were at.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
