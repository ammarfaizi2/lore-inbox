Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWIGGa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWIGGa6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 02:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWIGGa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 02:30:58 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:56338 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750721AbWIGGa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 02:30:56 -0400
Date: Thu, 7 Sep 2006 07:30:49 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>,
       linux-arch@vger.kernel.org
Subject: Re: [2.6 patch] re-add -ffreestanding
Message-ID: <20060907063049.GA15029@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, Andi Kleen <ak@suse.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Roman Zippel <zippel@linux-m68k.org>, linux-arch@vger.kernel.org
References: <20060830175727.GI18276@stusta.de> <200608302013.58122.ak@suse.de> <20060830183905.GB31594@flint.arm.linux.org.uk> <20060906223748.GC12157@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906223748.GC12157@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 12:37:48AM +0200, Adrian Bunk wrote:
> On Wed, Aug 30, 2006 at 07:39:05PM +0100, Russell King wrote:
> > Looking at the effect of -ffreestanding on ARM, it appears that on one
> > hand, the overall image size is reduced by 0.016% but we end up with worse
> > code - eg, strlen() of the same string in the same function evaluated
> > multiple times vs once without -ffreestanding.
> > 
> > The difference probably comes down to the lack of __attribute__((pure))
> > on our string functions in linux/string.h.
> > 
> > If we are going to go for -ffreestanding, we need to fix linux/string.h
> > in that respect _first_.
> 
> We are talking about reverting the patch that removed -ffreestanding, 
> and that broke at least two architectures although it wrongly claimed 
> it would have been a safe patch.

Wrong.  Your patch unconditionally adds it for _ALL_ architectures.
Below is the extract which you posted which supports this fact.

For the elimination of any doubt, I do _NOT_ want this patch merged as
is.  Take that as the _third_ architecture maintainer who has NACK'd
your patch (as you should've taken my first objection as that and
apparantly didn't.)

... and maybe you should copy linux-arch with architecture-wide changes
so that all architecture maintainers are aware of what you're trying to
do?

--- linux-2.6.18-rc4-mm3/Makefile.old   2006-08-30 16:59:31.000000000 +0200
+++ linux-2.6.18-rc4-mm3/Makefile       2006-08-30 17:02:42.000000000 +0200
@@ -308,7 +308,7 @@
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)

 CFLAGS          := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
-                   -fno-strict-aliasing -fno-common
+                   -fno-strict-aliasing -fno-common -ffreestanding
 AFLAGS          := -D__ASSEMBLY__

 # Read KERNELRELEASE from include/config/kernel.release (if it exists)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
