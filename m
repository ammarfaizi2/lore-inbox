Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261387AbSJZRxy>; Sat, 26 Oct 2002 13:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261388AbSJZRxy>; Sat, 26 Oct 2002 13:53:54 -0400
Received: from meel.hobby.nl ([212.72.224.15]:4371 "EHLO meel.hobby.nl")
	by vger.kernel.org with ESMTP id <S261387AbSJZRxx>;
	Sat, 26 Oct 2002 13:53:53 -0400
Date: Sat, 26 Oct 2002 16:18:30 +0200
From: Toon van der Pas <toon@vanvergehaald.nl>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 Problem Report Status
Message-ID: <20021026161830.E30058@vdpas.hobby.nl>
References: <200210231414.g9NEELVr004557@darkstar.example.net> <Pine.LNX.4.44.0210230952311.983-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210230952311.983-100000@cherise.pdx.osdl.net>; from mochel@osdl.org on Wed, Oct 23, 2002 at 10:03:51AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 10:03:51AM -0700, Patrick Mochel wrote:
> 
> ===== drivers/ide/ide.c 1.33 vs edited =====
> --- 1.33/drivers/ide/ide.c	Fri Oct 18 12:44:11 2002
> +++ edited/drivers/ide/ide.c	Wed Oct 23 09:42:27 2002
> @@ -3351,6 +3351,14 @@
>  	return 0;
>  }
>  
> +static void ide_drive_shutdown(struct device * dev)
> +{
> +	ide_drive_t * drive = container_of(dev,ide_drive_t,gendev);
> +	ide_driver_t * drive = drive->driver;

Are you sure you didn't introduce a typo here?  (missing 'r')
Maybe you meant this line to be:

+	ide_driver_t * driver = drive->driver;

> +	if (driver && driver->standby)
> +		driver->standby(drive);
> +}
> +
>  int ide_register_driver(ide_driver_t *driver)
>  {
>  	struct list_head list;
> @@ -3372,6 +3380,7 @@
>  	driver->gen_driver.name = driver->name;
>  	driver->gen_driver.bus = &ide_bus_type;
>  	driver->gen_driver.remove = ide_drive_remove;
> +	driver->gen_driver.shutdown = ide_drive_shutdown;
>  	return driver_register(&driver->gen_driver);
>  }

Regards,
Toon.
-- 
 /"\                             |
 \ /     ASCII RIBBON CAMPAIGN   |  "Who is this General Failure, and
  X        AGAINST HTML MAIL     |   what is he doing on my harddisk?"
 / \
