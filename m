Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316288AbSELAEX>; Sat, 11 May 2002 20:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316289AbSELAEW>; Sat, 11 May 2002 20:04:22 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:49157 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316288AbSELAEV>; Sat, 11 May 2002 20:04:21 -0400
Date: Sun, 12 May 2002 01:01:21 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit jiffies, a better solution take 2
Message-ID: <20020512010121.A23946@flint.arm.linux.org.uk>
In-Reply-To: <20020511191118.F1574@flint.arm.linux.org.uk> <15591.1021160328@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2002 at 09:38:48AM +1000, Keith Owens wrote:
> Any reason that you are using sed and not cpp like the other
> architectures?

Only historical and a hatred of cpp's "# line file" stuff, and the fact
that ARM needs to use sed elsewhere in the build to get around broken
GCC %c0 stuff.

I think we could actually get rid of the preprocessing of the linker
files - see ld's defsym argument.

> The use and name of linker scripts varies across architectures, some
> use cpp, some use sed, some do not pre-process at all.  This makes it
> awkward for repositories and dont-diff lists, they need special rules
> for every architecture.  In kbuild 2.5 I am trying to standardize on
> arch/$(ARCH)/vmlinux.lds.S which is always pre-processed by cpp to
> vmlinux.lds.i which is used to link vmlinux.

Eww, so I can't use "find . -name '*.[cS]'" to find all the C source and
assembly source with kbuild 2.5 because we've got pollution of the .S
extension?

> Using .S -> .i has three benefits.  The file name and the code for
> converting the file is standardized.  Dont-diff lists exclude *.[oais]
> files, no need for special cases for each architecture.

I'm not a fan of dont-diff stuff myself - I'd rather ensure a clean
source tree and then diff rather than diffing a dirty built tree.
dont-diff stuff needs to be maintained and extended as stuff changes
in the kernel tree, and lets face it, no amount of extension pollution
will prevent it from being updated over time.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
