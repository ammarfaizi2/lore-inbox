Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267542AbRGSLtI>; Thu, 19 Jul 2001 07:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267541AbRGSLs6>; Thu, 19 Jul 2001 07:48:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52489 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267542AbRGSLso>;
	Thu, 19 Jul 2001 07:48:44 -0400
Date: Thu, 19 Jul 2001 12:48:42 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: bitops.h ifdef __KERNEL__ cleanup.
Message-ID: <20010719124842.F5024@flint.arm.linux.org.uk>
In-Reply-To: <911753F4952@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <911753F4952@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Thu, Jul 19, 2001 at 12:54:43PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, Jul 19, 2001 at 12:54:43PM +0000, Petr Vandrovec wrote:
> Please do not do this. At least ncpfs checks for usability of these
> ops from its configure script, and if they are not available/usable, 
> it reverts to pthread mutex based implementation, which is slower 
> dozen of times. Same applies for atomic_* functions.

Both of the above mentioned functions can only be guaranteed to act
as per their atomic description if used from kernel space on some
architectures.

I've hit this problem many times, and its not going away, because "it
works on x86".

In fact, the places I came across when it was causing me problems were
places that were just using it as a "oh, someone else has coded a function
to set a bit in the kernel, we'll use that instead of coding it in portable
C" type thing - the application was single threaded, and was altering a
private internal data structure.

Sloppy.

> I think that you should complain to userspace authors who do not
> check for bitops existence and not force other to distrbute 8+ versions
> of bitops.h with their application, together with infrastructure for
> selecting correct version...

I totally disagree here.  We already say "user space should not include
kernel headers".  Why should bitops.h be any different?  Why should atomic.h
be any different?  They contain architecture specific code, yes, which
may not work in user space.

Oh, and thanks for pointing out ncpfs breaks - I hope the authors will
fix up their sloppy coding before Davids patch makes it into the kernel.
;)

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

