Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVE3UOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVE3UOa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 16:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVE3UO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 16:14:29 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:51981 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261742AbVE3UN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 16:13:59 -0400
Date: Mon, 30 May 2005 22:13:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 patch] document that gcc 4 is not supported
Message-ID: <20050530201355.GN10441@stusta.de>
References: <20050530192835.GK10441@stusta.de> <17051.28464.67012.631845@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17051.28464.67012.631845@alkaid.it.uu.se>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 09:53:20PM +0200, Mikael Pettersson wrote:
> Adrian Bunk writes:
>  > gcc 4 is not supported for compiling kernel 2.4, and I don't see any 
>  > compelling reason why kernel 2.4 should ever be adapted to gcc 4.
> ...
>  > --- linux-2.4.31-rc1-full/init/main.c.old	2005-05-30 21:20:00.000000000 +0200
>  > +++ linux-2.4.31-rc1-full/init/main.c	2005-05-30 21:21:19.000000000 +0200
>  > @@ -84,6 +84,13 @@
>  >  #error Sorry, your GCC is too old. It builds incorrect kernels.
>  >  #endif
>  >  
>  > +/*
>  > + * gcc >= 4 is not supported by kernel 2.4
>  > + */
>  > +#if __GNUC__ > 3
>  > +#error Sorry, your GCC is too recent for kernel 2.4
>  > +#endif
>  > +
>  >  extern char _stext, _etext;
>  >  extern char *linux_banner;
>  >  
> 
> This is redundant. Any attempt to compile vanilla 2.4 with gcc4
> will fail with compilation errors. (And except for one issue on
> x86-64 which actually was a kernel bug, those are the only known
> issues with using gcc4 for 2.4.)

Without this patch, your screen is flooded with warnings and errors when 
accidentially trying to compile kernel 2.4 with gcc 4.

With this patch, the same happens, but the last lines contain the 
explanation
  #error Sorry, your GCC is too recent for kernel 2.4

> OTOH, for those of us that do use gcc4, this just gets in the way
> and forces the gcc4 fixes kit for 2.4 to be even larger.
>...

If someone makes a patch to fix all issues with gcc 4, adding the 
removal of this #error should be the most trivial part of the patch.

> /Mikael

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

