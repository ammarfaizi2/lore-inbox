Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVBWV07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVBWV07 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 16:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVBWV07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 16:26:59 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35849 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261601AbVBWV0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 16:26:00 -0500
Date: Wed, 23 Feb 2005 22:25:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4.30-pre1] preliminary fixes for gcc-4.0
Message-ID: <20050223212559.GC3432@stusta.de>
References: <16907.32186.211277.994120@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16907.32186.211277.994120@alkaid.it.uu.se>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 04:28:58PM +0100, Mikael Pettersson wrote:
> Here is a preliminary set of patches to allow gcc-4.0 (20050130)
> to compile the 2.4.30-pre1 kernel. I make no claim that the patches
> are complete, but they have been tested successfully on i386 (multiple
> boxes), x86-64, and ppc32.
> 
> The changes fall into these categories:
>...
> - Add -Wno-pointer-sign to silence lots of compiler warnings.
>...
> /Mikael
>...
> --- linux-2.4.30-pre1/arch/i386/Makefile	2004-11-17 18:36:41.000000000 +0100
> +++ linux-2.4.30-pre1.gcc4-fixes-v5/arch/i386/Makefile	2005-02-10 14:35:01.000000000 +0100
> @@ -98,6 +98,9 @@ endif
>  # due to the lack of sharing of stacklots.
>  CFLAGS += $(call check_gcc,-fno-unit-at-a-time,)
>  
> +# disable pointer signedness warnings in gcc 4.0
> +CFLAGS += $(call check_gcc,-Wno-pointer-sign,)
> +
>  HEAD := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
>  
>  SUBDIRS += arch/i386/kernel arch/i386/mm arch/i386/lib
> diff -rupN linux-2.4.30-pre1/arch/ppc/Makefile linux-2.4.30-pre1.gcc4-fixes-v5/arch/ppc/Makefile
> --- linux-2.4.30-pre1/arch/ppc/Makefile	2004-04-14 20:22:20.000000000 +0200
> +++ linux-2.4.30-pre1.gcc4-fixes-v5/arch/ppc/Makefile	2005-02-10 14:35:01.000000000 +0100
> @@ -25,6 +25,11 @@ CFLAGS		:= $(CFLAGS) -I$(TOPDIR)/arch/$(
>  HOSTCFLAGS	+= -I$(TOPDIR)/arch/$(ARCH)
>  CPP		= $(CC) -E $(CFLAGS)
>  
> +check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
> +
> +# disable pointer signedness warnings in gcc 4.0
> +CFLAGS += $(call check_gcc,-Wno-pointer-sign,)
> +
>  ifdef CONFIG_4xx
>  CFLAGS := $(CFLAGS) -Wa,-m405
>  endif
>...
> --- linux-2.4.30-pre1/arch/x86_64/Makefile	2004-04-14 20:22:20.000000000 +0200
> +++ linux-2.4.30-pre1.gcc4-fixes-v5/arch/x86_64/Makefile	2005-02-10 14:35:01.000000000 +0100
> @@ -56,6 +56,9 @@ endif
>  # this is needed right now for the 32bit ioctl code
>  CFLAGS += $(call check_gcc,-fno-unit-at-a-time,)
>  
> +# disable pointer signedness warnings in gcc 4.0
> +CFLAGS += $(call check_gcc,-Wno-pointer-sign,)
> +
>  ifdef CONFIG_MK8
>  CFLAGS += $(call check_gcc,-march=k8,)
>  endif
>...

Shouldn't the first part of these three patches (adding 
-Wno-pointer-sign to the main Makefile be enough)?

That's also how it's handled in 2.6 .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

