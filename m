Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261509AbSJIIeA>; Wed, 9 Oct 2002 04:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261510AbSJIIeA>; Wed, 9 Oct 2002 04:34:00 -0400
Received: from n1x6.imsa.edu ([143.195.1.6]:31425 "EHLO mail.imsa.edu")
	by vger.kernel.org with ESMTP id <S261509AbSJIId7>;
	Wed, 9 Oct 2002 04:33:59 -0400
Date: Wed, 9 Oct 2002 03:39:42 -0500
From: Maciej Babinski <maciej@imsa.edu>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.41 oops on reboot
Message-ID: <20021009033942.A5419@imsa.edu>
References: <20021008192623.A1314@imsa.edu> <Pine.LNX.4.44.0210081734060.16276-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210081734060.16276-100000@cherise.pdx.osdl.net>; from mochel@osdl.org on Tue, Oct 08, 2002 at 05:35:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch alone doesn't fix it, but the big one does. Thanks!
												-Maciej

On Tue, Oct 08, 2002 at 05:35:17PM -0700, Patrick Mochel wrote:
> This has been reported a couple of times, and I posted a patch yesterday 
> that should fix this. Could you try this (must more narrow-focused) patch 
> and let me know if it fixes the problem?
> 
> Thanks
> 
> 	-pat
> 
> ChangeSet@1.696.19.1, 2002-10-07 09:52:31-07:00, mochel@osdl.org
>   IDE: only register drives that are present with the driver core.
> 
> diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
> --- a/drivers/ide/ide-probe.c	Mon Oct  7 12:19:16 2002
> +++ b/drivers/ide/ide-probe.c	Mon Oct  7 12:19:16 2002
> @@ -986,8 +986,8 @@
>  			 "%s","IDE Drive");
>  		disk->disk_dev.parent = &hwif->gendev;
>  		disk->disk_dev.bus = &ide_bus_type;
> -		device_register(&disk->disk_dev);
> -
> +		if (hwif->drives[unit].present)
> +			device_register(&disk->disk_dev);
>  		hwif->drives[unit].disk = disk;
>  	}
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
