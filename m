Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313715AbSDZRPB>; Fri, 26 Apr 2002 13:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313824AbSDZRPA>; Fri, 26 Apr 2002 13:15:00 -0400
Received: from [195.39.17.254] ([195.39.17.254]:38544 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S313715AbSDZRO7>;
	Fri, 26 Apr 2002 13:14:59 -0400
Date: Fri, 26 Apr 2002 18:09:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.10 IDE 42
Message-ID: <20020426160911.GE3783@elf.ucw.cz>
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net> <3CC7E358.8050905@evision-ventures.com> <20020425172508.GK3542@suse.de> <20020425173439.GM3542@suse.de> <aa9qtb$d8a$1@penguin.transmeta.com> <3CC904AA.7020706@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> @@ -783,16 +771,23 @@
>  	if (stat & BUSY_STAT)
>  		printk("Busy ");
>  	else {
> -		if (stat & READY_STAT)	printk("DriveReady ");
> -		if (stat & WRERR_STAT)	printk("DeviceFault ");
> -		if (stat & SEEK_STAT)	printk("SeekComplete ");
> -		if (stat & DRQ_STAT)	printk("DataRequest ");
> -		if (stat & ECC_STAT)	printk("CorrectedError ");
> -		if (stat & INDEX_STAT)	printk("Index ");
> -		if (stat & ERR_STAT)	printk("Error ");
> +		if (stat & READY_STAT)
> +			printk("DriveReady ");
> +		if (stat & WRERR_STAT)
> +			printk("DeviceFault ");
> +		if (stat & SEEK_STAT)
> +			printk("SeekComplete ");
> +		if (stat & DRQ_STAT)
> +			printk("DataRequest ");
> +		if (stat & ECC_STAT)
> +			printk("CorrectedError ");
> +		if (stat & INDEX_STAT)
> +			printk("Index ");
> +		if (stat & ERR_STAT)
> +			printk("Error ");
>  	}
>  	printk("}");
> -#endif	/* FANCY_STATUS_DUMPS */
> +#endif
>  	printk("\n");
>  	if ((stat & (BUSY_STAT|ERR_STAT)) == ERR_STAT) {
>  		err = GET_ERR();

I believe this is actually making it *less* readable.

> @@ -839,7 +834,7 @@
>  					printk(", sector=%ld", HWGROUP(drive)->rq->sector);
>  			}
>  		}
> -#endif	/* FANCY_STATUS_DUMPS */
> +#endif
>  		printk("\n");
>  	}
>  	__restore_flags (flags);	/* local CPU only */

Here to. Comment after endif is good thing; you don't have to add it
but you should certainly not kill it.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
