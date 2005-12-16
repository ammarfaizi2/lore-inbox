Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbVLPSaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbVLPSaM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 13:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVLPSaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 13:30:12 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:28636 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751326AbVLPSaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 13:30:09 -0500
Message-Id: <200512161828.jBGISe4k003326@laptop11.inf.utfsm.cl>
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] more updates for the gcc >= 3.2 requirement 
In-Reply-To: Message from Adrian Bunk <bunk@stusta.de> 
   of "Thu, 15 Dec 2005 22:24:52 BST." <20051215212452.GS23349@stusta.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Fri, 16 Dec 2005 15:28:40 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Fri, 16 Dec 2005 15:28:41 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
> This patch contains some documentation updates and removes some code 
> paths for gcc < 3.2.

[...]

> --- linux-2.6.15-rc5-mm3-full/arch/arm/kernel/asm-offsets.c.old	2005-12-15 13:34:55.000000000 +0100
> +++ linux-2.6.15-rc5-mm3-full/arch/arm/kernel/asm-offsets.c	2005-12-15 13:35:11.000000000 +0100
> @@ -27,11 +27,11 @@
>   * GCC 3.2.0: incorrect function argument offset calculation.
>   * GCC 3.2.x: miscompiles NEW_AUX_ENT in fs/binfmt_elf.c
>   *            (http://gcc.gnu.org/PR8896) and incorrect structure
>   *	      initialisation in fs/jffs2/erase.c
>   */
> -#if __GNUC__ < 3 || (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
> +#if (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
>  #error Your compiler is too buggy; it is known to miscompile kernels.
>  #error    Known good compilers: 3.3
>  #endif

Better leave the original, in case some clown comes along with an ancient
compiler.

[...]

> --- linux-2.6.15-rc5-mm3-full/include/asm-ia64/spinlock.h.old	2005-12-15 13:38:00.000000000 +0100
> +++ linux-2.6.15-rc5-mm3-full/include/asm-ia64/spinlock.h	2005-12-15 13:38:07.000000000 +0100
> @@ -32,11 +32,11 @@
>  static inline void
>  __raw_spin_lock_flags (raw_spinlock_t *lock, unsigned long flags)
>  {
>  	register volatile unsigned int *ptr asm ("r31") = &lock->lock;
>  
> -#if __GNUC__ < 3 || (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
> +#if (__GNUC__ == 3 && __GNUC_MINOR__ < 3)

Ditto.

[...]

> --- linux-2.6.15-rc5-mm3-full/include/asm-sparc64/system.h.old	2005-12-15 13:40:55.000000000 +0100
> +++ linux-2.6.15-rc5-mm3-full/include/asm-sparc64/system.h	2005-12-15 13:41:03.000000000 +0100
> @@ -191,15 +191,11 @@
>  	 * the output value of 'last'.  'next' is not referenced again
>  	 * past the invocation of switch_to in the scheduler, so we need
>  	 * not preserve it's value.  Hairy, but it lets us remove 2 loads
>  	 * and 2 stores in this critical code path.  -DaveM
>  	 */
> -#if __GNUC__ >= 3
>  #define EXTRA_CLOBBER ,"%l1"
> -#else
> -#define EXTRA_CLOBBER
> -#endif

If EXTRA_CLOBBER is now constant, you can get rid of it completely.

[...]

> --- linux-2.6.15-rc5-mm3-full/include/linux/byteorder/swabb.h.old	2005-12-15 13:41:52.000000000 +0100
> +++ linux-2.6.15-rc5-mm3-full/include/linux/byteorder/swabb.h	2005-12-15 13:42:00.000000000 +0100
> @@ -75,11 +75,11 @@
>  
>  
>  /*
>   * Allow constant folding
>   */
> -#if defined(__GNUC__) && (__GNUC__ >= 2) && defined(__OPTIMIZE__)
> +#if defined(__GNUC__) && defined(__OPTIMIZE__)

AFAIU, now __GNUC__ should be defined always. Even with intel's compiler
for compatibility, I'd assume. Perhaps we can get rid of it?

Nice job!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
