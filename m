Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbSJCUG0>; Thu, 3 Oct 2002 16:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261356AbSJCUG0>; Thu, 3 Oct 2002 16:06:26 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:56847
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S261354AbSJCUGY>; Thu, 3 Oct 2002 16:06:24 -0400
Date: Thu, 3 Oct 2002 13:09:52 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Bernd Schubert <bernd.schubert@tc.pci.uni-heidelberg.de>
cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE subsystem issues with 2.4.18/19
In-Reply-To: <200210032034.02875.bernd-schubert@web.de>
Message-ID: <Pine.LNX.4.10.10210031307410.10557-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If it is "empirically" derived and reproduceble, I like it.
Especially when the theory people actually do it the empirical way.
(noting your sig)


On Thu, 3 Oct 2002, Bernd Schubert wrote:

> On Friday 04 October 2002 14:01, Dexter Filmore wrote:
> > Got a motherboard with VIA VT8233 Southbridge (a MSI K7T266 Pro2),
> > Slackware 8.1 with a standard kernel (tried .18 as well as .19) patched
> > with SGI XFS support, two atapi drives attached with /dev/hdc is Pioneer115
> > DVD and /dev/hdd is a Traxdata 24x-writer, both running in scsi emulation.
> > Got VIA-support compiled in.
> >
> > Everythings runs fine: reading DVD, reading CD, writing CD.
> > *Apart from*: CD ripping. When trying to read audio CDs, the system locks
> > up, can't reproduce the exact error msgs right now, need a running system
> > atm. If you like, I'll post them later on.
> >
> > Tried cdparanoia 9.8-III, cdda2wav - nothing works.
> >
> > I contacted Vojtech Pavlik, the author of the via82xxx.c code who advised
> > me to ask Alan Cox or Andre Hedrick about this, so I thought best write to
> > this list.
> > Are there any workarounds/patches/voodoo magic for this problem?
> >
> > Dex
> 
> 
> Hi, 
> 
> I don't know if it is related to this, but there seems to be general bug in 
> the cdrom-ide driver to get the exact size of a CD.
> When reading a CD-image using dd, my system also locks up until I eject the CD 
> with the cdrom-drive-eject button.
> 
> I've already send the following patch to Jens Axboe, but so far he hasn't 
> answered yet:
> 
> diff -rbBu linux-2.4.19/drivers/ide/ide-cd.c 
> linux-2.4.19_mod/drivers/ide/ide-cd.c
> --- linux-2.4.19/drivers/ide/ide-cd.c   Sat Aug  3 02:39:44 2002
> +++ linux-2.4.19_mod/drivers/ide/ide-cd.c       Mon Sep 30 13:43:35 2002
> @@ -1903,7 +1903,7 @@
> 
>         stat = cdrom_queue_packet_command(drive, &pc);
>         if (stat == 0)
> -               *capacity = 1 + be32_to_cpu(capbuf.lba);
> +               *capacity = be32_to_cpu(capbuf.lba) - 1;
> 
>         return stat;
>  }
> 
> 
> Please note that I got the correct value of *capacity empirically, since I 
> compered several values of the IDE-drive with the ones of my scsi drive. 
> 
> Since I don't understand the cdrom_read_capacity() function (would be nice if 
> someone could explain me, where "capbuf.lba" gets its values and 
> what be32_to_cpu() does), I'm not 100% sure that the patch is correct.
> 
> 
> Bernd
> 
> -- 
> Bernd Schubert
> Physikalisch Chemisches Institut
> Abt. Theoretische Chemie
> INF 229, 69120 Heidelberg
> Tel.: 06221/54-5210
> e-mail: 	bernd (dot) schubert (at) pci (dot) uni-heidelberg (dot) de 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

