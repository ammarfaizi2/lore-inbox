Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKUHCq>; Tue, 21 Nov 2000 02:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129208AbQKUHCh>; Tue, 21 Nov 2000 02:02:37 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:18952 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129091AbQKUHCa>; Tue, 21 Nov 2000 02:02:30 -0500
Date: Tue, 21 Nov 2000 00:32:09 -0600
To: Chip Salzenberg <chip@valinux.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.2.18pre21: DRM update
Message-ID: <20001121003209.D2918@wire.cadcamlab.org>
In-Reply-To: <20001117201603.A3439@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001117201603.A3439@valinux.com>; from chip@valinux.com on Fri, Nov 17, 2000 at 08:16:03PM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Chip Salzenberg]
> --- drivers/char/Makefile.prev
> +++ drivers/char/Makefile	Fri Nov 17 13:30:04 2000
> @@ -12,5 +12,5 @@
>  SUB_DIRS     := 
>  MOD_SUB_DIRS := $(SUB_DIRS)
> -ALL_SUB_DIRS := $(SUB_DIRS) rio ftape joystick drm agp
> +ALL_SUB_DIRS := $(SUB_DIRS) rio ftape joystick
>  
>  #
> @@ -395,4 +395,16 @@
>  endif
>  
> +ifeq ($(CONFIG_DRM),y)
> +O_OBJS += drm/drm.o
> +ALL_SUB_DIRS += drm
> +MOD_SUB_DIRS += drm

The bits about ALL_SUB_DIRS are trivially wrong.  You should define it
unconditionally -- that way the user doesn't have to 'make dep' after
every 'make *config'.

Not a very important point, granted.


>  #ifndef __HAVE_ARCH_CMPXCHG
>  				/* Include this here so that driver can be
>                                     used with older kernels. */
> +#if defined(__alpha__)

This section ought to be in include/asm-{alpha,i386}/system.h like in
2.4 (and like sparc64 in 2.2).  Then again, perhaps in 2.2 it is best
to let sleeping dogs lie.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
