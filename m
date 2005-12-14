Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbVLNKrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbVLNKrW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 05:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbVLNKrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 05:47:21 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14094 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932329AbVLNKrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 05:47:21 -0500
Date: Wed, 14 Dec 2005 10:46:57 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, mingo@elte.hu, dhowells@redhat.com, torvalds@osdl.org,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051214104657.GA30957@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, ak@suse.de, mingo@elte.hu,
	dhowells@redhat.com, torvalds@osdl.org, hch@infradead.org,
	arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org> <20051213084926.GN23384@wotan.suse.de> <20051213010126.0832356d.akpm@osdl.org> <20051213010233.50fce969.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213010233.50fce969.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 01:02:33AM -0800, Andrew Morton wrote:
> diff -puN arch/arm/kernel/asm-offsets.c~remove-gcc2-checks arch/arm/kernel/asm-offsets.c
> --- devel/arch/arm/kernel/asm-offsets.c~remove-gcc2-checks	2005-12-13 00:51:14.000000000 -0800
> +++ devel-akpm/arch/arm/kernel/asm-offsets.c	2005-12-13 00:53:27.000000000 -0800
> @@ -23,18 +23,13 @@
>  #error Sorry, your compiler targets APCS-26 but this kernel requires APCS-32
>  #endif
>  /*
> - * GCC 2.95.1, 2.95.2: ignores register clobber list in asm().
>   * GCC 3.0, 3.1: general bad code generation.
>   * GCC 3.2.0: incorrect function argument offset calculation.
>   * GCC 3.2.x: miscompiles NEW_AUX_ENT in fs/binfmt_elf.c
>   *            (http://gcc.gnu.org/PR8896) and incorrect structure
>   *	      initialisation in fs/jffs2/erase.c
>   */
> -#if __GNUC__ < 2 || \
> -   (__GNUC__ == 2 && __GNUC_MINOR__ < 95) || \
> -   (__GNUC__ == 2 && __GNUC_MINOR__ == 95 && __GNUC_PATCHLEVEL__ != 0 && \
> -					     __GNUC_PATCHLEVEL__ < 3) || \
> -   (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
> +#if __GNUC__ < 2 || (__GNUC__ == 3 && __GNUC_MINOR__ < 3)

Shouldn't this be:

+#if __GNUC__ < 3 || (__GNUC__ == 3 && __GNUC_MINOR__ < 3)

?

>  #error Your compiler is too buggy; it is known to miscompile kernels.
>  #error    Known good compilers: 2.95.3, 2.95.4, 2.96, 3.3

And this should also have the 2.95 and 2.96 stuff edited out.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
