Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286942AbSAYAsq>; Thu, 24 Jan 2002 19:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287563AbSAYAsh>; Thu, 24 Jan 2002 19:48:37 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:28574 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S286942AbSAYAsa>; Thu, 24 Jan 2002 19:48:30 -0500
Date: Thu, 24 Jan 2002 16:47:24 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Rasmus B?g Hansen <moffe@amagerkollegiet.dk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: ACPI trouble (Was: Re: [patch] amd athlon cooling on kt266/266a
 chipset)
In-Reply-To: <20020124184011.GA23785@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.33.0201241643490.32276-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nice job, Petr, you rock!  Your patch allows my ASUS A7V BIOS 1009 to
poweroff off under kernel 2.4.18-pre7 with ACPI.  Much easier than the big
ACPI patch against 2.4.16 from Intel.

Cheers, Wayne

On Thu, 24 Jan 2002, Petr Vandrovec wrote:

> I still have this in my tree. I have no idea who is wrong, whether
> parser or BIOS.
> 					Best regards,
> 						Petr Vandrovec
> 						vandrove@vc.cvut.cz
> 
> diff -urdN linux/drivers/acpi/hardware/hwsleep.c linux/drivers/acpi/hardware/hwsleep.c
> --- linux/drivers/acpi/hardware/hwsleep.c	Wed Oct 24 21:06:22 2001
> +++ linux/drivers/acpi/hardware/hwsleep.c	Tue Jan 22 16:17:46 2002
> @@ -152,6 +152,13 @@
>  		return status;
>  	}
>  
> +	/* Broken ACPI table on ASUS A7V... it reports type 7, but poweroff is type 2... 
> +	   sleep is type 1 while ACPI reports type 3, but as I was not able to get 
> +	   machine to wake from this state without unplugging power cord... */
> +	if (type_a == 7 && type_b == 7 && sleep_state == ACPI_STATE_S5 && !memcmp(acpi_gbl_DSDT->oem_id, "ASUS\0\0", 6)
> +			&& !memcmp(acpi_gbl_DSDT->oem_table_id, "A7V     ", 8)) {
> +		type_a = type_b = 2;
> +	}
>  	/* run the _PTS and _GTS methods */
>  
>  	MEMSET(&arg_list, 0, sizeof(arg_list));

