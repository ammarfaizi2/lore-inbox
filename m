Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267883AbUGaAIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267883AbUGaAIW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 20:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267882AbUGaAIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 20:08:22 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16081 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267880AbUGaAIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 20:08:15 -0400
Date: Sat, 31 Jul 2004 02:07:54 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: adaplas@pol.net
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] [I810FB]: i810fb fixes
Message-ID: <20040731000754.GF2746@fs.tum.de>
References: <200407290955.29735.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407290955.29735.adaplas@hotpop.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 10:04:32AM +0800, Antonino A. Daplas wrote:

>...
> --- linux-2.6.8-rc2-mm1-orig/drivers/video/Kconfig	2004-07-28 19:51:13.000000000 +0000
> +++ linux-2.6.8-rc2-mm1/drivers/video/Kconfig	2004-07-29 00:35:04.115437224 +0000
> @@ -457,7 +457,9 @@ config FB_RIVA_DEBUG
>  
>  config FB_I810
>  	tristate "Intel 810/815 support (EXPERIMENTAL)"
> -	depends on FB && AGP && AGP_INTEL && EXPERIMENTAL && PCI	
> +	depends on FB && EXPERIMENTAL && PCI	
> +	select AGP
> +	select AGP_INTEL
>  	help
>  	  This driver supports the on-board graphics built in to the Intel 810 
>            and 815 chipsets.  Say Y if you have and plan to use such a board.
>...

This is wrong.

If you select something, you have to ensure that the dependencies of 
what you select are fulfilled.

Since AGP_INTEL depends on X86 && !X86_64 , you must add this to the 
dependencies of FB_I810 if it selects AGP_INTEL.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

