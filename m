Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267291AbUHDGHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267291AbUHDGHc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 02:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267292AbUHDGHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 02:07:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:27328 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267291AbUHDGGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 02:06:52 -0400
Date: Wed, 4 Aug 2004 08:06:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: "Barry K. Nathan" <barryn@pobox.com>,
       Steve Snyder <swsnyder@insightbb.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HIGHMEM4G config for 1GB RAM on desktop?
Message-ID: <20040804060625.GE10340@suse.de>
References: <200408021602.34320.swsnyder@insightbb.com> <20040802220521.GA2179@ip68-4-98-123.oc.oc.cox.net> <20040803133034.GM23504@suse.de> <410FA145.70701@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410FA145.70701@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04 2004, Con Kolivas wrote:
> Jens Axboe wrote:
> >On Mon, Aug 02 2004, Barry K. Nathan wrote:
> >
> >>On Mon, Aug 02, 2004 at 04:02:34PM -0500, Steve Snyder wrote:
> >>
> >>>There seems to be a controversy about the use of the CONFIG_HIGHMEM4G  
> >>>kernel configuration.  After reading many posts on the subject, I still 
> >>>don't know which setting is best for me.
> 
> No idea what the performance hit is of highmem these days - it seems 
> insignificant compared to 2.4 so I've had it enabled for 1Gb ram.
> 
> >There's also the option of moving the mapping only slightly, so that all
> >of the 1G fits in low memory. That's the best option for 1G desktop
> >machines, imho. Changing PAGE_OFFSET from 0xc0000000 to 0xb0000000 would
> >probably be enough.
> >
> >Then you can have your cake and eat it too.
> 
> Something like this attached patch? Seems to work nicely. Thanks!
> 
> Cheers,
> Con

> Index: linux-2.6.8-rc2-mm2/arch/i386/kernel/vmlinux.lds.S
> ===================================================================
> --- linux-2.6.8-rc2-mm2.orig/arch/i386/kernel/vmlinux.lds.S	2004-05-23 12:54:46.000000000 +1000
> +++ linux-2.6.8-rc2-mm2/arch/i386/kernel/vmlinux.lds.S	2004-08-04 00:20:02.219462913 +1000
> @@ -11,7 +11,7 @@
>  jiffies = jiffies_64;
>  SECTIONS
>  {
> -  . = 0xC0000000 + 0x100000;
> +  . = 0xB0000000 + 0x100000;
>    /* read-only */
>    _text = .;			/* Text and read-only data */
>    .text : {
> Index: linux-2.6.8-rc2-mm2/include/asm-i386/page.h
> ===================================================================
> --- linux-2.6.8-rc2-mm2.orig/include/asm-i386/page.h	2004-08-03 01:29:28.000000000 +1000
> +++ linux-2.6.8-rc2-mm2/include/asm-i386/page.h	2004-08-03 23:58:16.000000000 +1000
> @@ -123,9 +123,9 @@
>  #endif /* __ASSEMBLY__ */
>  
>  #ifdef __ASSEMBLY__
> -#define __PAGE_OFFSET		(0xC0000000)
> +#define __PAGE_OFFSET		(0xB0000000)
>  #else
> -#define __PAGE_OFFSET		(0xC0000000UL)
> +#define __PAGE_OFFSET		(0xB0000000UL)
>  #endif

Yup precisely. I agree that there probably isn't a whole lot of
performance hit on a 1GB, it just seems silly that we need highmem on
such a standard memory configuration these days. Especially when just
moving the offset slightly removes that need.

-- 
Jens Axboe

