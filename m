Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbUKUT4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbUKUT4W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 14:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUKUT4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 14:56:21 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63236 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261803AbUKUT4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 14:56:18 -0500
Date: Sun, 21 Nov 2004 20:56:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Nicolas Pitre <nico@cam.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org
Subject: Re: [patch] 2.6.10-rc2-mm2: MTD_XIP dependencies
Message-ID: <20041121195617.GB13254@stusta.de>
References: <20041118021538.5764d58c.akpm@osdl.org> <20041118154110.GE4943@stusta.de> <1100793112.8191.7315.camel@hades.cambridge.redhat.com> <Pine.LNX.4.61.0411181132440.12260@xanadu.home> <20041118213232.GG4943@stusta.de> <Pine.LNX.4.61.0411181727010.12260@xanadu.home> <20041118232527.GI4943@stusta.de> <Pine.LNX.4.61.0411182041130.12260@xanadu.home> <20041119133500.GF22981@stusta.de> <Pine.LNX.4.61.0411191130190.3732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411191130190.3732@xanadu.home>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 11:35:26AM -0500, Nicolas Pitre wrote:
> On Fri, 19 Nov 2004, Adrian Bunk wrote:
> 
> >...
> > The Kconfig file should express all dependencies of a driver.
> > If a driver doesn't compile, it should not be selectable - and not 
> > #error at compile time.
> 
> Absolutely!

Good that we agree.  :-)

> So please would you just ask Andrew to apply the following patch and be 
> happy?  Thank you.

A slightly improved patch is below.

> --- ./drivers/mtd/chips/Kconfig.orig	Fri Nov 19 11:25:45 2004
> +++ ./drivers/mtd/chips/Kconfig	Fri Nov 19 11:28:08 2004
> @@ -274,8 +274,7 @@
>  
>  config MTD_XIP
>  	bool "XIP aware MTD support"
> -	depends on !SMP && MTD_CFI_INTELEXT && EXPERIMENTAL
> -	default y if XIP_KERNEL
> +	depends on XIP_KERNEL && !SMP && MTD_CFI_INTELEXT && EXPERIMENTAL
>  	help
>  	  This allows MTD support to work with flash memory which is also
>  	  used for XIP purposes.  If you're not sure what this is all about
> 
> 
> Nicolas


cu
Adrian

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/drivers/mtd/chips/Kconfig.old	2004-11-18 16:35:40.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/mtd/chips/Kconfig	2004-11-21 20:54:43.000000000 +0100
@@ -274,8 +274,8 @@
 
 config MTD_XIP
 	bool "XIP aware MTD support"
-	depends on !SMP && MTD_CFI_INTELEXT && EXPERIMENTAL
-	default y if XIP_KERNEL
+	depends on XIP_KERNEL && !SMP && MTD_CFI_INTELEXT && EXPERIMENTAL && (ARCH_SA1100 || ARCH_PXA || BROKEN)
+	default y
 	help
 	  This allows MTD support to work with flash memory which is also
 	  used for XIP purposes.  If you're not sure what this is all about

