Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbUKSQh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUKSQh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 11:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbUKSQh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 11:37:28 -0500
Received: from [24.200.48.166] ([24.200.48.166]:16107 "EHLO xanadu.home")
	by vger.kernel.org with ESMTP id S261443AbUKSQgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 11:36:51 -0500
Date: Fri, 19 Nov 2004 11:35:26 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Adrian Bunk <bunk@stusta.de>
cc: David Woodhouse <dwmw2@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org
Subject: Re: [patch] 2.6.10-rc2-mm2: MTD_XIP dependencies
In-Reply-To: <20041119133500.GF22981@stusta.de>
Message-ID: <Pine.LNX.4.61.0411191130190.3732@xanadu.home>
References: <20041118021538.5764d58c.akpm@osdl.org> <20041118154110.GE4943@stusta.de>
 <1100793112.8191.7315.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.61.0411181132440.12260@xanadu.home> <20041118213232.GG4943@stusta.de>
 <Pine.LNX.4.61.0411181727010.12260@xanadu.home> <20041118232527.GI4943@stusta.de>
 <Pine.LNX.4.61.0411182041130.12260@xanadu.home> <20041119133500.GF22981@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2004, Adrian Bunk wrote:

> On Thu, Nov 18, 2004 at 08:58:26PM -0500, Nicolas Pitre wrote:
> > On Fri, 19 Nov 2004, Adrian Bunk wrote:
> > 
> > > The #error should either go or be the same than the Kconfig dependency.
> > 
> > And on what basis?  This just doesn't make sense.
> > 
> > CONFIG_MTD_XIP is there to be compatible with kernels which are made 
> > XIP.  This currently means _all_ ARM flavours the kernel currently 
> > supports.  Yet there is only SA11x0 and PXA2xx which have proper MTD_XIP 
> > primitives ence the #error.
> > 
> > My position is therefore that the CONFIG_MTD_XIP should depend on 
> > CONFIG_XIP_KERNEL since this is what it is for, and the #error stay as 
> > is.  If ever you make x86 kernel XIPable you'll need to add the missing 
> > bits guarded by the #error anyway.
> > 
> > And no, allyesconfig makes little sense on ARM as it has been discussed 
> > on lkml before.
> 
> I'm not talking about allyesconfig.
> 
> The Kconfig file should express all dependencies of a driver.
> If a driver doesn't compile, it should not be selectable - and not 
> #error at compile time.

Absolutely!

So please would you just ask Andrew to apply the following patch and be 
happy?  Thank you.

--- ./drivers/mtd/chips/Kconfig.orig	Fri Nov 19 11:25:45 2004
+++ ./drivers/mtd/chips/Kconfig	Fri Nov 19 11:28:08 2004
@@ -274,8 +274,7 @@
 
 config MTD_XIP
 	bool "XIP aware MTD support"
-	depends on !SMP && MTD_CFI_INTELEXT && EXPERIMENTAL
-	default y if XIP_KERNEL
+	depends on XIP_KERNEL && !SMP && MTD_CFI_INTELEXT && EXPERIMENTAL
 	help
 	  This allows MTD support to work with flash memory which is also
 	  used for XIP purposes.  If you're not sure what this is all about


Nicolas
