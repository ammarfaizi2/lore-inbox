Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283372AbRK2SPF>; Thu, 29 Nov 2001 13:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283373AbRK2SO5>; Thu, 29 Nov 2001 13:14:57 -0500
Received: from [212.18.232.186] ([212.18.232.186]:34576 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S283372AbRK2SOl>; Thu, 29 Nov 2001 13:14:41 -0500
Date: Thu, 29 Nov 2001 18:12:27 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: randall@uph.com
Cc: Balbir Singh <balbir_soni@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch: Fix serial module use count (2.4.16 _and_ 2.5)
Message-ID: <20011129181227.I6214@flint.arm.linux.org.uk>
In-Reply-To: <20011129160637.50471.qmail@web13606.mail.yahoo.com> <200111291803.fATI37q08404@sword.damocles.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111291803.fATI37q08404@sword.damocles.com>; from randall@sword.damocles.com on Thu, Nov 29, 2001 at 12:03:07PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2001 at 12:03:07PM -0600, Jeff Randall wrote:
> All of the other UNIX variants I've dealth with behave that way.
> However, you cannot just make that change without having some means
> of identifying that behavior change because all of the linux
> serial drivers have been written to assume that their close()
> will be called even after their open() has failed.

It's not only serial drivers, its everything that is a tty driver.
I believe that auditing and fixing that lot in 2.4 just isn't going
to happen - it's supposed to be a stable kernel after all.

> I'm not opposed to such a change in behavior, but at least be
> sure that it's somehow identifiable (kernel version, a define
> set in a header, etc) so that the 3rd party drivers have a means
> to identify the change.

eg, #if KERNEL_VERSION >= LINUX_VERSION(2,5,0)

> Redhat 7.1 included that behavior change in the kernel they shipped
> and it caused no end of problems for those of us that were doing
> serial drivers since there was no way to easily identify that the
> patch had been included.

The change which adds the MOD_DEC_USE_COUNT stuff is bogus, and it
shouldn't have been made.  (I'm assuming this is what you're talking
about).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

