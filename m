Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269125AbUIRErj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269125AbUIRErj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 00:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269130AbUIRErj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 00:47:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:10929 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269125AbUIRErf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 00:47:35 -0400
Subject: Re: Radeon: do not blank screen during suspend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: ajoshi@shell.unixbox.com,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20040915112652.GA21386@elf.ucw.cz>
References: <20040915112652.GA21386@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1095482822.3574.24.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 18 Sep 2004 14:47:02 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 21:26, Pavel Machek wrote:
> Hi!
> 
> This stops ugly flashing from radeon during suspend/resume, please
> apply,

Shoud be fine.

BTW. What is the status with Patrick merge of pmdisk & swsusp ? Has it
been merged at all ? (No time to check at the moment). I still hope I'll
find some time to do real work on it (& cleanup the ppc support that I
had working experimentally at OLS) sooner or later...

Ben.
							Pavel
> 
> --- clean-mm/drivers/video/aty/radeon_pm.c	2004-08-24 09:03:18.000000000 +0200
> +++ linux-mm/drivers/video/aty/radeon_pm.c	2004-09-15 13:00:51.000000000 +0200
> @@ -871,7 +871,8 @@
>  	agp_enable(0);
>  #endif
>  
> -	fb_set_suspend(info, 1);
> +	if (system_state != SYSTEM_SNAPSHOT)
> +		fb_set_suspend(info, 1);
>  
>  	if (!(info->flags & FBINFO_HWACCEL_DISABLED)) {
>  		/* Make sure engine is reset */
> @@ -880,12 +881,14 @@
>  		radeon_engine_idle();
>  	}
>  
> -	/* Blank display and LCD */
> -	radeonfb_blank(VESA_POWERDOWN, info);
> -
> -	/* Sleep */
> -	rinfo->asleep = 1;
> -	rinfo->lock_blank = 1;
> +	if (system_state != SYSTEM_SNAPSHOT) {
> +		/* Blank display and LCD */
> +		radeonfb_blank(VESA_POWERDOWN, info);
> +
> +		/* Sleep */
> +		rinfo->asleep = 1;
> +		rinfo->lock_blank = 1;
> +	}
>  
>  	/* Suspend the chip to D2 state when supported
>  	 */
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

