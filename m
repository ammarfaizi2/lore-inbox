Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbTIGSjn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 14:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbTIGSjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 14:39:43 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:44183 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261230AbTIGSjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 14:39:36 -0400
Date: Sun, 7 Sep 2003 20:38:57 +0200 (MEST)
From: peter_daum@t-online.de (Peter Daum)
Reply-To: Peter Daum <gator@cs.tu-berlin.de>
To: Adrian Bunk <bunk@fs.tum.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22 with CONFIG_M686: networking broken
In-Reply-To: <20030907151422.GX14436@fs.tum.de>
Message-ID: <Pine.LNX.4.30.0309072019040.8020-100000@swamp.bayern.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Seen: false
X-ID: XNaY6mZEgek4qk+746mpjCdwR7E6REcrus1lLhWv08IiF6J4DViFrS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

Your patch did the trick!
(Since this looks like a pretty general issue, I guess, that
means that there were some more problems besides the
networking-stuff that I stumbled across?)

Thanks a bunch,
                         Peter

On Sun, 7 Sep 2003, Adrian Bunk wrote:

> On Wed, Sep 03, 2003 at 01:08:08PM +0200, Peter Daum wrote:

> > It seems, like kernel version 2.4.22 introduced some weird bug,
> > that causes all kinds of network malfunctions, when the kernel is
> > compiled with "CONFIG_M686".
> >...
> could you check whether the patch below fixes your problems?
...
> --- linux-2.4.23-pre3-full/arch/i386/config.in.old	2003-09-07 17:10:31.000000000 +0200
> +++ linux-2.4.23-pre3-full/arch/i386/config.in	2003-09-07 17:11:47.000000000 +0200
> @@ -51,7 +51,7 @@
>  if [ "$CONFIG_M386" = "y" ]; then
>     define_bool CONFIG_X86_CMPXCHG n
>     define_bool CONFIG_X86_XADD n
> -   define_int  CONFIG_X86_L1_CACHE_SHIFT 4
> +   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
>     define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
>     define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
>     define_bool CONFIG_X86_PPRO_FENCE y
> @@ -67,21 +67,21 @@
>     define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
>  fi
>  if [ "$CONFIG_M486" = "y" ]; then
> -   define_int  CONFIG_X86_L1_CACHE_SHIFT 4
> +   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
>     define_bool CONFIG_X86_USE_STRING_486 y
>     define_bool CONFIG_X86_ALIGNMENT_16 y
>     define_bool CONFIG_X86_PPRO_FENCE y
>     define_bool CONFIG_X86_F00F_WORKS_OK n
>  fi
>  if [ "$CONFIG_M586" = "y" ]; then
> -   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
> +   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
>     define_bool CONFIG_X86_USE_STRING_486 y
>     define_bool CONFIG_X86_ALIGNMENT_16 y
>     define_bool CONFIG_X86_PPRO_FENCE y
>     define_bool CONFIG_X86_F00F_WORKS_OK n
>  fi
>  if [ "$CONFIG_M586TSC" = "y" ]; then
> -   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
> +   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
>     define_bool CONFIG_X86_USE_STRING_486 y
>     define_bool CONFIG_X86_ALIGNMENT_16 y
>     define_bool CONFIG_X86_HAS_TSC y
> @@ -89,7 +89,7 @@
>     define_bool CONFIG_X86_F00F_WORKS_OK n
>  fi
>  if [ "$CONFIG_M586MMX" = "y" ]; then
> -   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
> +   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
>     define_bool CONFIG_X86_USE_STRING_486 y
>     define_bool CONFIG_X86_ALIGNMENT_16 y
>     define_bool CONFIG_X86_HAS_TSC y
> @@ -98,7 +98,7 @@
>     define_bool CONFIG_X86_F00F_WORKS_OK n
>  fi
>  if [ "$CONFIG_M686" = "y" ]; then
> -   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
> +   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
>     define_bool CONFIG_X86_HAS_TSC y
>     define_bool CONFIG_X86_GOOD_APIC y
>     bool 'PGE extensions (not for Cyrix/Transmeta)' CONFIG_X86_PGE
> @@ -107,7 +107,7 @@
>     define_bool CONFIG_X86_F00F_WORKS_OK y
>  fi
>  if [ "$CONFIG_MPENTIUMIII" = "y" ]; then
> -   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
> +   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
>     define_bool CONFIG_X86_HAS_TSC y
>     define_bool CONFIG_X86_GOOD_APIC y
>     define_bool CONFIG_X86_PGE y
> @@ -123,7 +123,7 @@
>     define_bool CONFIG_X86_F00F_WORKS_OK y
>  fi
>  if [ "$CONFIG_MK6" = "y" ]; then
> -   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
> +   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
>     define_bool CONFIG_X86_ALIGNMENT_16 y
>     define_bool CONFIG_X86_HAS_TSC y
>     define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
> @@ -134,7 +134,7 @@
>     define_bool CONFIG_MK7 y
>  fi
>  if [ "$CONFIG_MK7" = "y" ]; then
> -   define_int  CONFIG_X86_L1_CACHE_SHIFT 6
> +   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
>     define_bool CONFIG_X86_HAS_TSC y
>     define_bool CONFIG_X86_GOOD_APIC y
>     define_bool CONFIG_X86_USE_3DNOW y
> @@ -143,13 +143,13 @@
>     define_bool CONFIG_X86_F00F_WORKS_OK y
>  fi
>  if [ "$CONFIG_MELAN" = "y" ]; then
> -   define_int  CONFIG_X86_L1_CACHE_SHIFT 4
> +   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
>     define_bool CONFIG_X86_USE_STRING_486 y
>     define_bool CONFIG_X86_ALIGNMENT_16 y
>     define_bool CONFIG_X86_F00F_WORKS_OK y
>  fi
>  if [ "$CONFIG_MCYRIXIII" = "y" ]; then
> -   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
> +   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
>     define_bool CONFIG_X86_HAS_TSC y
>     define_bool CONFIG_X86_ALIGNMENT_16 y
>     define_bool CONFIG_X86_USE_3DNOW y
> @@ -157,26 +157,26 @@
>     define_bool CONFIG_X86_F00F_WORKS_OK y
>  fi
>  if [ "$CONFIG_MVIAC3_2" = "y" ]; then
> -   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
> +   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
>     define_bool CONFIG_X86_HAS_TSC y
>     define_bool CONFIG_X86_ALIGNMENT_16 y
>     define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
>     define_bool CONFIG_X86_F00F_WORKS_OK y
>  fi
>  if [ "$CONFIG_MCRUSOE" = "y" ]; then
> -   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
> +   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
>     define_bool CONFIG_X86_HAS_TSC y
>     define_bool CONFIG_X86_F00F_WORKS_OK y
>  fi
>  if [ "$CONFIG_MWINCHIPC6" = "y" ]; then
> -   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
> +   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
>     define_bool CONFIG_X86_ALIGNMENT_16 y
>     define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
>     define_bool CONFIG_X86_OOSTORE y
>     define_bool CONFIG_X86_F00F_WORKS_OK y
>  fi
>  if [ "$CONFIG_MWINCHIP2" = "y" ]; then
> -   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
> +   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
>     define_bool CONFIG_X86_ALIGNMENT_16 y
>     define_bool CONFIG_X86_HAS_TSC y
>     define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
> @@ -184,7 +184,7 @@
>     define_bool CONFIG_X86_F00F_WORKS_OK y
>  fi
>  if [ "$CONFIG_MWINCHIP3D" = "y" ]; then
> -   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
> +   define_int  CONFIG_X86_L1_CACHE_SHIFT 7
>     define_bool CONFIG_X86_ALIGNMENT_16 y
>     define_bool CONFIG_X86_HAS_TSC y
>     define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
>

