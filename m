Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWCFRKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWCFRKX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 12:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbWCFRKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 12:10:23 -0500
Received: from tim.rpsys.net ([194.106.48.114]:36767 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750884AbWCFRKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 12:10:22 -0500
Subject: Re: [patch] fix hardcoded values in collie frontlight
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>, Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060306115728.GB28908@elf.ucw.cz>
References: <20060305142859.GA21173@elf.ucw.cz>
	 <1141587964.6521.55.camel@localhost.localdomain>
	 <20060306115728.GB28908@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 17:10:03 +0000
Message-Id: <1141665004.6524.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-06 at 12:57 +0100, Pavel Machek wrote:
> In frontlight support, we should really use values from flash-ROM
> instead of hardcoding our own. Cleanup includes.
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
> 
> --- a/drivers/video/backlight/locomolcd.c
> +++ b/drivers/video/backlight/locomolcd.c
> @@ -20,14 +20,10 @@
>  
>  #include <asm/hardware/locomo.h>
>  #include <asm/irq.h>
> +#include <asm/mach/sharpsl_param.h>
> +#include <asm/mach-types.h>
>  
> -#ifdef CONFIG_SA1100_COLLIE
> -#include <asm/arch/collie.h>
> -#else
> -#include <asm/arch/poodle.h>
> -#endif
> -
> -extern void (*sa1100fb_lcd_power)(int on);
> +#include "../../../arch/arm/mach-sa1100/generic.h"
>  
>  static struct locomo_dev *locomolcd_dev;
>  
> @@ -82,7 +78,7 @@ static void locomolcd_off(int comadj)
>  
>  void locomolcd_power(int on)
>  {
> -	int comadj = 118;
> +	int comadj = sharpsl_param.comadj;
>  	unsigned long flags;
>  
>  	local_irq_save(flags);
> @@ -93,11 +89,12 @@ void locomolcd_power(int on)
>  	}
>  
>  	/* read comadj */
> -#ifdef CONFIG_MACH_POODLE
> -	comadj = 118;
> -#else
> -	comadj = 128;
> -#endif
> +	if (comadj == -1) {
> +		if (machine_is_poodle())
> +			comadj = 118;
> +		if (machine_is_collie())
> +			comadj = 128;
> +	}
>  
>  	if (on)
>  		locomolcd_on(comadj);
> 
> 

