Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUG0Mo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUG0Mo6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 08:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265198AbUG0Mo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 08:44:58 -0400
Received: from styx.suse.cz ([82.119.242.94]:56706 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S265196AbUG0Moz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 08:44:55 -0400
Date: Tue, 27 Jul 2004 14:46:39 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.de>,
       linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] reenable pc speaker driver for ppc and ppc64
Message-ID: <20040727124639.GI20613@ucw.cz>
References: <20040723164953.GB3836@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040723164953.GB3836@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 06:49:53PM +0200, Olaf Hering wrote:
> 
> The ppc PReP and CHRP boards have PC speaker hardware. A recent patch
> disabled that for many archs, also for ppc. But the driver works fine
> here. An asm header was missing, I just copied another version.
> 
> Signed-off-by: Olaf Hering <olh@suse.de>

Thanks, applied.

> 
> diff -purN linux-2.6.7/drivers/input/misc/Kconfig linux-2.6.8-rc2/drivers/input/misc/Kconfig
> --- linux-2.6.7/drivers/input/misc/Kconfig	2004-07-23 18:30:34.845608638 +0200
> +++ linux-2.6.8-rc2/drivers/input/misc/Kconfig	2004-07-23 17:45:16.519034884 +0200
> @@ -14,7 +14,7 @@ config INPUT_MISC
>  
>  config INPUT_PCSPKR
>  	tristate "PC Speaker support"
> -	depends on (ALPHA || X86 || X86_64 || MIPS) && INPUT && INPUT_MISC
> +	depends on (ALPHA || X86 || X86_64 || MIPS || PPC_PREP || PPC_CHRP || PPC_PSERIES) && INPUT && INPUT_MISC
>  	help
>  	  Say Y here if you want the standard PC Speaker to be used for
>  	  bells and whistles.
> diff -purN linux-2.6.7/include/asm-ppc/8253pit.h linux-2.6.8-rc2/include/asm-ppc/8253pit.h
> --- linux-2.6.7/include/asm-ppc/8253pit.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.8-rc2/include/asm-ppc/8253pit.h	2004-07-23 17:11:19.069707446 +0200
> @@ -0,0 +1,10 @@
> +/*
> + * 8253/8254 Programmable Interval Timer
> + */
> +
> +#ifndef _8253PIT_H
> +#define _8253PIT_H
> +
> +#define PIT_TICK_RATE 	1193182UL
> +
> +#endif
> diff -purN linux-2.6.7/include/asm-ppc64/8253pit.h linux-2.6.8-rc2/include/asm-ppc64/8253pit.h
> --- linux-2.6.7/include/asm-ppc64/8253pit.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.8-rc2/include/asm-ppc64/8253pit.h	2004-07-23 17:45:23.459974244 +0200
> @@ -0,0 +1,10 @@
> +/*
> + * 8253/8254 Programmable Interval Timer
> + */
> +
> +#ifndef _8253PIT_H
> +#define _8253PIT_H
> +
> +#define PIT_TICK_RATE 	1193182UL
> +
> +#endif
> 
> -- 
> USB is for mice, FireWire is for men!
> 
> sUse lINUX ag, nÜRNBERG
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
