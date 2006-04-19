Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWDSPFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWDSPFg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 11:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWDSPFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 11:05:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15630 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750839AbWDSPFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 11:05:35 -0400
Date: Wed, 19 Apr 2006 16:05:27 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dimitry Andric <dimitry@andric.com>
Cc: Ben Dooks <ben-linux-arm@fluff.org>,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: RFC: rename arch/arm/mach-s3c2410 to arch/arm/mach-s3c24xx
Message-ID: <20060419150527.GA4102@flint.arm.linux.org.uk>
Mail-Followup-To: Dimitry Andric <dimitry@andric.com>,
	Ben Dooks <ben-linux-arm@fluff.org>,
	linux-arm-kernel@lists.arm.linux.org.uk,
	linux-kernel@vger.kernel.org
References: <20060418165204.GG2516@trinity.fluff.org> <4446187C.2090603@andric.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4446187C.2090603@andric.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 01:01:16PM +0200, Dimitry Andric wrote:
> Ben Dooks wrote:
> > With the advent of the s3c2410 port adding support for
> > more of the samsung SoC product line (s3c2440, s3c2442,
> > s3c2400) there have been several requests by other people
> > to rename the (in their opinion) increasingly inaccurate
> > arch/arm/mach-s3c2410 to arch/arm/mach-s3c24xx.
> 
> Also, I've always found the dichotomy of having
> "include/asm-arm/arch-s3c2410" and "arch/arm/mach-s3c2410" rather weird.

There's a reason for this (this has actually been covered and discussed
at length in the past on the linux-arm mailing lists.)

Folk convinced me that the only thing which we should call "architecture"
is the CPU - so things like "PPC", "ARM", "i386" are architectures, and
not implementations of these (AT91RM9200, S3C2410).

The things in arch/arm/mach* are machine classes which support a variety
of machines which are all essentially similar.  Inside these directories
you have the core support for the individual machines.

However, the problem is that we can't rename include/asm-arm/arch-* to
include/asm-arm/mach-*, because we need a symlink to select the right
one.  If we renamed include/asm-arm/arch-* to include/asm-arm/mach-*,
we'd want the symlink to be called include/asm-arm/mach.

Unfortunately, we have an include/asm-arm/mach directory, so we'd end
up having to symlink include/asm-arm/mach-* to include/asm-arm/arch.
This would be even more confusing than leaving the include/asm-arm as
currently is.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
