Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261496AbTCTOsi>; Thu, 20 Mar 2003 09:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261499AbTCTOsh>; Thu, 20 Mar 2003 09:48:37 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:43514 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261496AbTCTOse>; Thu, 20 Mar 2003 09:48:34 -0500
Date: Thu, 20 Mar 2003 15:59:28 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Greg Ungerer <gerg@snapgear.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.56: undefined reference to `_ebss' from drivers/mtd/maps/uclinux.c
Message-ID: <20030320145927.GF11659@fs.tum.de>
References: <20030112095559.GT21826@fs.tum.de> <3E226969.5080406@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E226969.5080406@snapgear.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 05:23:21PM +1000, Greg Ungerer wrote:
> Hi Adrian,
> 
> Adrian Bunk wrote:
> >trying to compile 2.5.56 with CONFIG_MTD_UCLINUX fails on i386 with
> >  undefined reference to `_ebss'
> >at the final linking.
> >
> >It seems _ebss is only defined on the architectures m68knommu and v850?
> 
> Hmm, currently that is correct. There doesn't appear to be a
> "standard" symbol name applied to the immediate end of the bss
> section. Different architectures are using different names:
> 
>   _ebss        -- m68knommu, v850
>   __bss_stop   -- i386, alpha, ppc, s390
>   __bss_end    -- x86_64
>   _end         -- mips, parisc, sparc, (actually most have this)
> 
> Actually it looks like _end is probably closer, it seems to
> almost always fall strait after the bss, on just about every
> architecture that has it.
> 
> Come to think of it _end is probably more appropriate anyway.
> Since that code is trying to find the location of something
> concatenated to the end of the kernel image.


This problem (undefined reference to `_ebss') is still present in 
2.5.65.

It might not be a solution for the whole issue, but is it intentionally
that it's possible to enable CONFIG_MTD_UCLINUX on non-uClinux 
architectures or should an appropriate dependency be added to the 
Kconfig file?


> Regards
> Greg

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

