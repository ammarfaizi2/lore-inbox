Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262730AbSJOGyd>; Tue, 15 Oct 2002 02:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263173AbSJOGxU>; Tue, 15 Oct 2002 02:53:20 -0400
Received: from [195.39.17.254] ([195.39.17.254]:2820 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S263137AbSJOGxH>;
	Tue, 15 Oct 2002 02:53:07 -0400
Date: Sat, 12 Oct 2002 01:06:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, viro@math.psu.edu,
       andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] IDE driver model update
Message-ID: <20021012010631.A162@elf.ucw.cz>
References: <Pine.LNX.4.44.0210071220020.16276-100000@cherise.pdx.osdl.net> <Pine.LNX.4.44.0210071231180.16276-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210071231180.16276-100000@cherise.pdx.osdl.net>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> ChangeSet@1.696.19.2, 2002-10-07 10:27:16-07:00, mochel@osdl.org
>   IDE: register ide driver for all ide drives; not just for disk drives. 
>   
>   This adds
>   	struct device_driver	gen_driver;
>   
>   to ide_driver_t, which is filled in with necessary fields when an ide
>   driver calls ide_register_driver(). That then registers the driver with
>   the driver model core. 
>   
>   As a result, this gives us the following output in driverfs:
>   
>   # tree -d /sys/bus/ide/drivers/
>   /sys/bus/ide/drivers/
>   |-- ide-cdrom
>   `-- ide-disk
>   
>   The suspend/resume callbacks in ide-disk.c have been temporarily
>   disabled until the ide core implements generic methods which forward
>   the calls to the drive drivers. 
> 
> diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
> --- a/drivers/ide/ide-disk.c	Mon Oct  7 12:19:14 2002
> +++ b/drivers/ide/ide-disk.c	Mon Oct  7 12:19:14 2002
> @@ -1550,14 +1550,6 @@
>  /* This is just a hook for the overall driver tree.
>   */
>  
> -static struct device_driver idedisk_devdrv = {
> -	.bus = &ide_bus_type,
> -	.name = "IDE disk driver",
> -
> -	.suspend = idedisk_suspend,
> -	.resume = idedisk_resume,
> -};
> -

Here you killed the only reference to idedisk_suspend, yet
idedisk_suspend/idedisk_resume is needed if you don't want to eat
data.
							Pavel
-- 
When do you have heart between your knees?
