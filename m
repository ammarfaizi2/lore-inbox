Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265024AbRGSShr>; Thu, 19 Jul 2001 14:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265133AbRGSShh>; Thu, 19 Jul 2001 14:37:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5131 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265024AbRGSShW>;
	Thu, 19 Jul 2001 14:37:22 -0400
Date: Thu, 19 Jul 2001 19:37:23 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: bitops.h ifdef __KERNEL__ cleanup.
Message-ID: <20010719193723.I5024@flint.arm.linux.org.uk>
In-Reply-To: <917E9842025@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <917E9842025@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Thu, Jul 19, 2001 at 07:21:48PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, Jul 19, 2001 at 07:21:48PM +0000, Petr Vandrovec wrote:
> Maybe because of I do not know ARM assembler? If you do not want
> kernel headers to be used in apps, just move them from asm and linux
> into msa and xunil. Then you can simple remove all #ifdef __KERNEL__
> from them...

Why should the kernel change to please a problem minority in user space
who shouldn't be including kernel headers in the first place?

> It will still work. Only resulting binary will be slower. That's what
> autoconf is for. If ncpfs does not compile for you, better to contact
> me directly, as I'm ncpfs maintainer...

No.  The binary _will_ not do what you expect - these functions are
not atomic in user space on all architecture types.  Yes they may work,
but not with the atomic side effects.  You won't get this from a simple
autoconf test.

I'll give you credit though - you're at least checking that they appear
to exist; I have come across many programs which rely on them existing,
and do not check that they exist.

It is these that David and myself wish to target, and this along with
the general rule of "Never include kernel headers in user code", it
seems to be the most appropriate solution.

Now, there is a nice clean solution to your problem - bug the glibc
people to provide equivalents in their library, hopefully as inline
asm in the systems header files.  Systems which need to do extra stuff
can then have them implemented in the C library.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

