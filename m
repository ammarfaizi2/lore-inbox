Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267091AbTGKXqt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 19:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267096AbTGKXqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 19:46:49 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:29072 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267091AbTGKXqh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 19:46:37 -0400
Date: Sat, 12 Jul 2003 02:00:55 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Steven Cole <elenstev@mesatop.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.75-bk update help texts for PDC202 (was [PATCH]
 Update COnfigure.help for PDC202 options)
In-Reply-To: <1057956592.1728.11.camel@spc9.esa.lanl.gov>
Message-ID: <Pine.SOL.4.30.0307120136340.29667-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 Jul 2003, Steven Cole wrote:

> On Fri, 2003-07-11 at 13:39, Ruth Ivimey-Cook wrote:
> > Folks,
> >
> > I have updated the help for the Promise controller cards to match the code
> > and provide a bit more information.
> >
> > Enjoy.
> >
> > Ruth
>
> Thanks Ruth.
>
> I've taken your work and formatted it for the drivers/ide/Kconfig file
> in 2.5. Here's the patch.
>
> This was made against the current 2.5 tree.
>
> Steven
>
> --- 2.5-linux/drivers/ide/Kconfig.orig	Fri Jul 11 13:44:02 2003
> +++ 2.5-linux/drivers/ide/Kconfig	Fri Jul 11 14:07:34 2003
> @@ -682,9 +682,33 @@
>  config BLK_DEV_PDC202XX_OLD
>  	tristate "PROMISE PDC202{46|62|65|67} support"
>  	depends on BLK_DEV_IDEDMA_PCI
> +	help
> +	  Promise Ultra 33 [PDC20246]
> +	  Promise Ultra 66 [PDC20262]
> +	  Promise FastTrak 66 [PDC20263]
> +	  Promise MB Ultra 100 [PDC20265]
> +	  Promise Ultra 100 [PDC20267]

This is probably okay.

> +	  This driver adds up to 4 more EIDE devices sharing a single
> +	  interrupt. This device is a bootable PCI UDMA controller. Since

I've seen this "up to 4 more EIDE devices sharing a single
interrupt" also in comments for HighPoint controllers...

I think all such comments are bogus.

> +	  multiple cards can be installed and there are BIOS ROM problems that
> +	  happen if the BIOS revisions of all installed cards (max of three) do
> +	  not match, the driver attempts to do dynamic tuning of the chipset
> +	  at boot-time for max speed.  Ultra33 BIOS 1.25 or newer is required
> +	  for more than one card. This card may require that you say Y to
> +	  "Special UDMA Feature" to force UDMA mode for connected UDMA capable
> +	  disk drives.

I think this comment is highly specific to Ultra33 cards...

Also if you use this driver and choose to override BIOS you can probably
use as much cards as you want (currently driver limits it to 5,
but this is easy to change).

There is already confusion here, please don't make it worse ;-).

> +
> +	  If you say Y here, you need to say Y to "Use DMA by default when
> +	  available" as well.
> +
> +	  Please read the comments at the top of
> +	  <file:drivers/ide/pci/pdc202xx_old.c>.
> +
> +	  If unsure, say N.
>
>  config PDC202XX_BURST
> -	bool "Special UDMA Feature"
> +	bool "Override-Enable UDMA for Promise Controllers"
>  	depends on BLK_DEV_PDC202XX_OLD=y && CONFI_BLK_DEV_IDEDMA_PCI
>  	---help---
>  	  This option causes the pdc202xx driver to enable UDMA modes on the
> @@ -703,13 +727,47 @@
>  config BLK_DEV_PDC202XX_NEW
>  	tristate "PROMISE PDC202{68|69|70|71|75|76|77} support"
>  	depends on BLK_DEV_IDEDMA_PCI
> +	help
> +	  Promise Ultra 100 TX2 [PDC20268]
> +	  Promise Ultra 133 PTX2 [PDC20269]
> +	  Promise FastTrak LP/TX2/TX4 [PDC20270]
> +	  Promise FastTrak TX2000 [PDC20271]
> +	  Promise MB Ultra 133 [PDC20275]
> +	  Promise MB FastTrak 133 [PDC20276]
> +	  Promise FastTrak 133 [PDC20277]

This is probably okay.

> +
> +	  This driver adds up to 4 more EIDE devices sharing a single
> +	  interrupt. This device is a bootable PCI UDMA controller. Since
> +	  multiple cards can be installed and there are BIOS ROM problems that
> +	  happen if the BIOS revisions of all installed cards (max of five) do
> +	  not match, the driver attempts to do dynamic tuning of the chipset
> +	  at boot-time for max speed.  Ultra33 BIOS 1.25 or newer is required
> +	  for more than one card.

Ultra33? This is driver for new Promise controllers.

> +	  If you say Y here, you need to say Y to "Use DMA by default when
> +	  available" as well.
> +
> +	  If unsure, say N.
>
>  # FIXME - probably wants to be one for old and for new
>  config PDC202XX_FORCE
> -	bool "Special FastTrak Feature"
> +	bool "Use FastTrak RAID capable device as plain IDE controller"
>  	depends on BLK_DEV_PDC202XX_NEW=y
>  	help
> -	  For FastTrak enable overriding BIOS.
> +	  Setting this option causes the kernel to use your Promise IDE disk
> +	  controller as an ordinary IDE controller, rather than as a FastTrak
> +	  RAID controller. RAID is a system for using multiple physical disks
> +	  as one virtual disk.
> +
> +	  You need to say Y here if you have a PDC20276 IDE interface but either
> +	  you do not have a RAID disk array, or you wish to use the Linux
> +	  internal RAID software (/dev/mdX).
> +
> +	  You need to say N here if you wish to use your Promise controller to
> +	  control a FastTrak RAID disk array, and you you must also say Y to
> +	  CONFIG_BLK_DEV_ATARAID_PDC.
> +
> +	  If unsure, say Y.

Please read recent "IDE/Promise 20276 FastTrack RAID..." thread.
Also ataraid driver is not ported to 2.5 yet.

>  config BLK_DEV_RZ1000
>  	tristate "RZ1000 chipset bugfix/support"

--
Bartlomiej
Linux 2.5 IDE Maintainer

