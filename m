Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264272AbUFNVFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbUFNVFy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 17:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbUFNVFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 17:05:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12558 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264272AbUFNVFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 17:05:52 -0400
Date: Mon, 14 Jun 2004 22:05:49 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/5] kbuild: default kernel image
Message-ID: <20040614220549.L14403@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040614204405.GB15243@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040614204405.GB15243@mars.ravnborg.org>; from sam@ravnborg.org on Mon, Jun 14, 2004 at 10:44:05PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 10:44:05PM +0200, Sam Ravnborg wrote:
> #   When compiling the kernel the user no longer needs to look up the
> #   selected kernel imgae in either the $(ARCH) makefile or in 'make help'.
> #   The more natural choice is to select the kernel image during kernel
> #   the configuration.

I'm slightly scared of this.  Historically, there's already pressure
from boot loader people on ARM to include random file formats to suit
their own boot loaders.

In the first place, ARM had Image and zImage and that was it.  It was
well defined.  Then people decided that gzipped Image would be nice
and they'd merge the zlib code into their boot loader.  I think there's
even some people who use gzipped zImage...!

Then ARMboot came along and we eventually ended up with uboot-style
wrappings to support uboot / ARMboot, which require an external program
to be installed on the host system called "mkimage" (which, incidentally
is an incredibly bad choice of name.)

People also came up with the idea of using the ELF file directly and
having the boot loader parse the ELF file.  I wouldn't put it past
someone to want gzipped ELF as well.

There's also srec to support serially downloaded images as well.

So, in total, we have boot loaders which want:

  - Image
  - zImage
  - gzipped Image
  - gzipped zImage
  - uboot
  - ELF
  - srec

Basically this is somewhere I don't want to go.  My position is that
if boot loaders want to have their own proprietary formats, they
should do whatever manipulation to the kernel image is necessary as
a post processing step themselves from one of the two standard kernel
formats - Image or zImage.

However, the problem of offering users all these options is that their
first question will be "huh, which one of these 7 do I want?" rather
than everyone knowing that they need the kernel build to produce either
an Image or zImage and the boot loader documentation telling them what
to do with it next.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
