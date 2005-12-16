Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbVLPTB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVLPTB0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 14:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVLPTB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 14:01:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27909 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932372AbVLPTBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 14:01:25 -0500
Date: Fri, 16 Dec 2005 20:01:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [-mm patch] more updates for the gcc >= 3.2 requirement
Message-ID: <20051216190126.GF23349@stusta.de>
References: <20051215212452.GS23349@stusta.de> <200512161828.jBGISe4k003326@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512161828.jBGISe4k003326@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 03:28:40PM -0300, Horst von Brand wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> > This patch contains some documentation updates and removes some code 
> > paths for gcc < 3.2.
> 
> [...]
> 
> > --- linux-2.6.15-rc5-mm3-full/arch/arm/kernel/asm-offsets.c.old	2005-12-15 13:34:55.000000000 +0100
> > +++ linux-2.6.15-rc5-mm3-full/arch/arm/kernel/asm-offsets.c	2005-12-15 13:35:11.000000000 +0100
> > @@ -27,11 +27,11 @@
> >   * GCC 3.2.0: incorrect function argument offset calculation.
> >   * GCC 3.2.x: miscompiles NEW_AUX_ENT in fs/binfmt_elf.c
> >   *            (http://gcc.gnu.org/PR8896) and incorrect structure
> >   *	      initialisation in fs/jffs2/erase.c
> >   */
> > -#if __GNUC__ < 3 || (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
> > +#if (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
> >  #error Your compiler is too buggy; it is known to miscompile kernels.
> >  #error    Known good compilers: 3.3
> >  #endif
> 
> Better leave the original, in case some clown comes along with an ancient
> compiler.
>...

That's what the check in init/main.c is for.

> > --- linux-2.6.15-rc5-mm3-full/include/asm-sparc64/system.h.old	2005-12-15 13:40:55.000000000 +0100
> > +++ linux-2.6.15-rc5-mm3-full/include/asm-sparc64/system.h	2005-12-15 13:41:03.000000000 +0100
> > @@ -191,15 +191,11 @@
> >  	 * the output value of 'last'.  'next' is not referenced again
> >  	 * past the invocation of switch_to in the scheduler, so we need
> >  	 * not preserve it's value.  Hairy, but it lets us remove 2 loads
> >  	 * and 2 stores in this critical code path.  -DaveM
> >  	 */
> > -#if __GNUC__ >= 3
> >  #define EXTRA_CLOBBER ,"%l1"
> > -#else
> > -#define EXTRA_CLOBBER
> > -#endif
> 
> If EXTRA_CLOBBER is now constant, you can get rid of it completely.
>...

It's now a codingstyle issue, and DaveM (Cc'ed) can change it if he 
wants to.

> Nice job!

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

