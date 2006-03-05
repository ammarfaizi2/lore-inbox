Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWCETqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWCETqX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 14:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWCETqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 14:46:23 -0500
Received: from tim.rpsys.net ([194.106.48.114]:46316 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750713AbWCETqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 14:46:22 -0500
Subject: Re: [patch] fix hardcoded values in collie frontlight
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20060305142859.GA21173@elf.ucw.cz>
References: <20060305142859.GA21173@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 05 Mar 2006 19:46:04 +0000
Message-Id: <1141587964.6521.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-05 at 15:28 +0100, Pavel Machek wrote: 
> In frontlight support, we should really use values from flash-ROM
> instead of hardcoding our own.
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> diff --git a/drivers/video/backlight/locomolcd.c b/drivers/video/backlight/locomolcd.c
> index ada6e75..2bcff84 100644
> --- a/drivers/video/backlight/locomolcd.c
> +++ b/drivers/video/backlight/locomolcd.c
> @@ -27,7 +28,7 @@
>  #include <asm/arch/poodle.h>
>  #endif
>  
> -extern void (*sa1100fb_lcd_power)(int on);
> +#include "../../../arch/arm/mach-sa1100/generic.h"

This would be neater if that was in some more accessible header in
asm/arch. I'm not sure which header that would be though. Russell?

> @@ -93,11 +94,13 @@ void locomolcd_power(int on)
>  	}
>  
>  	/* read comadj */
> +	if (comadj == -1) {
>  #ifdef CONFIG_MACH_POODLE
> -	comadj = 118;
> +		comadj = 118;
>  #else
> -	comadj = 128;
> +		comadj = 128;
>  #endif
> +	}

Perhaps use machine_is_poodle() and machine_is_collie() here?

I agree with the changes in principle though.

Richard

