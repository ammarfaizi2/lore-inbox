Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265893AbTGLPEP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 11:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265901AbTGLPEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 11:04:15 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:12221 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265893AbTGLPEH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 11:04:07 -0400
Date: Sat, 12 Jul 2003 17:18:26 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
cc: Steven Cole <elenstev@mesatop.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.75-bk update help texts for PDC202 (was [PATCH]
 Update COnfigure.help for PDC202 options)
In-Reply-To: <200307120210.05332.ruth@ivimey.org>
Message-ID: <Pine.SOL.4.30.0307121706520.19333-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 12 Jul 2003, Ruth Ivimey-Cook wrote:

> On Saturday 12 Jul 2003 1:00 am, Bartlomiej Zolnierkiewicz wrote:
> > > +	  Promise Ultra 33 [PDC20246]
> > > +	  Promise Ultra 66 [PDC20262]
> > > +	  Promise FastTrak 66 [PDC20263]
> > > +	  Promise MB Ultra 100 [PDC20265]
> > > +	  Promise Ultra 100 [PDC20267]
> >
> > This is probably okay.
>
> The device names are taken from the driver source and where possible confirmed
> from the Promise web site (looking in BIOS files).

Great.

> > > +	  This driver adds up to 4 more EIDE devices sharing a single
> > > +	  interrupt. This device is a bootable PCI UDMA controller. Since
> >
> > I've seen this "up to 4 more EIDE devices sharing a single
> > interrupt" also in comments for HighPoint controllers...
> > I think all such comments are bogus.
>
> In this case I kept the old comments, as I wasn't sure that they were
> incorrect. I will have a go at rehashing this paragraph.
>
> > > +	  "Special UDMA Feature" to force UDMA mode for connected UDMA capable
> > > +	  disk drives.
> > I think this comment is highly specific to Ultra33 cards...
>
> It is true that I have never needed it for either of the Ultra 100's I have,
> although having it enabled didn't seem to hurt.
>
> > Also if you use this driver and choose to override BIOS you can probably
> > use as much cards as you want (currently driver limits it to 5,
> > but this is easy to change).
> > There is already confusion here, please don't make it worse ;-).
>
> As above, this is duplicated from the original help. So I'm not making things
> worse. That said I am hoping to make things better.
>
> I will change it to make it clearer that the statements about Ultra33 are
> specific to Ultra33.
> Are you telling me that I should change it to be unlimied # cards?

No, just remove it.

> > This is probably okay.
>  > +	  at boot-time for max speed.  Ultra33 BIOS 1.25 or newer is required
> > > +	  for more than one card.
> >
> > Ultra33? This is driver for new Promise controllers.
>
> OOps... will fix.
>
> > Please read recent "IDE/Promise 20276 FastTrack RAID..." thread.
> > Also ataraid driver is not ported to 2.5 yet.
>
> I will: I hadn't noticed it.  [ looks ] So there is another patch for the
> (ugh!) 'special feature' -- do you want me to:
>
>  - integrate that patch with mine & resubmit

Please do.

>  - take input from that patch into mine & resubmit
>  - go away :-(

:-)

> Does ataraid work well on 2.4? I have never used it as I have preferred the
> user-space tools available for Linux-raid. On 2.5 KConfig as ataraid doesn't

I do not know. Hint: search lkml archive for bugreports :-).

> work I guess the right thing is to always configure as non-raid, so not
> requiring a user-question and therefore no help.

Promise binary drivers can be used in 2.5.

> I have updated my Configure.help patch in ways that I hope address your
> concerns above. I can see from Steven Drake's patch that I should also modify

You don't. This patch looks (almost?) exactly as previous one.

> Config.in: should we continue I will do that & send a patch for it.
>
> If we come to consensus on this patch I will update Steven's KConfig one also.

You can always split your patch to get non-controversial parts accepted
first.  I will also try to correct this patch when I have some time.

Thanks,
--
Bartlomiej

> --- Documentation/Configure.help.orig	2003-07-11 19:40:17.000000000 +0100
> +++ Documentation/Configure.help.pdc	2003-07-12 01:53:41.000000000 +0100
> @@ -1229,30 +1229,57 @@
>
>    If unsure, say N.
>
> -PROMISE PDC20246/PDC20262/PDC20265/PDC20267/PDC20268 support
> +PROMISE PDC20246/PDC20262/PDC20263/PDC20265/PDC20267 support
>  CONFIG_BLK_DEV_PDC202XX_OLD
> -  Promise Ultra33 or PDC20246
> -  Promise Ultra66 or PDC20262
> -  Promise Ultra100 or PDC20265/PDC20267/PDC20268
> -
> -  This driver adds up to 4 more EIDE devices sharing a single
> -  interrupt. This add-on card is a bootable PCI UDMA controller. Since
> -  multiple cards can be installed and there are BIOS ROM problems that
> -  happen if the BIOS revisions of all installed cards (three-max) do
> -  not match, the driver attempts to do dynamic tuning of the chipset
> -  at boot-time for max-speed.  Ultra33 BIOS 1.25 or newer is required
> -  for more than one card. This card may require that you say Y to
> -  "Special UDMA Feature".
> +  Promise Ultra 33 [PDC20246]
> +  Promise Ultra 66 [PDC20262]
> +  Promise FastTrak 66 [PDC20263]
> +  Promise MB Ultra 100 [PDC20265]
> +  Promise Ultra 100 [PDC20267]
> +
> +  This driver adds support for the older series of Promise EIDE disk
> +  interface devices. Each device supports up to 4 disk drives that
> +  can use UDMA disk access (33MHz for Ultra 33 up to 100MHz for Ultra
> +  100).
> +
> +  If multiple cards are installed you might have problems booting if
> +  the BIOS versions for the cards are ~different. Therefore the driver
> +  attempts to do dynamic tuning of the chipset at boot-time.
> +
> +  If you are using an Ultra 33, BIOS version 1.25 or newer is required
> +  to support more than one card and you should say Y to "Special UDMA
> +  Feature" to force UDMA mode for connected UDMA capable disk drives.
>
>    If you say Y here, you need to say Y to "Use DMA by default when
>    available" as well.
>
> -  Please read the comments at the top of
> -  <file:drivers/ide/pci/pdc202xx_old.c>.
> +  If unsure, say N.
> +
> +PROMISE PDC202{68|69|70|71|75|76|77} support
> +CONFIG_BLK_DEV_PDC202XX_NEW
> +  Promise Ultra 100 TX2 [PDC20268]
> +  Promise Ultra 133 PTX2 [PDC20269]
> +  Promise FastTrak LP/TX2/TX4 [PDC20270]
> +  Promise FastTrak TX2000 [PDC20271]
> +  Promise MB Ultra 133 [PDC20275]
> +  Promise MB FastTrak 133 [PDC20276]
> +  Promise FastTrak 133 [PDC20277]
> +
> +  This driver adds support for the older series of Promise EIDE disk
> +  interface devices. Each device supports up to 4 disk drives that
> +  can use UDMA disk access (33MHz for Ultra 33 up to 100MHz for Ultra
> +  100).
> +
> +  If multiple cards are installed you might have problems booting if
> +  the BIOS versions for the cards are different. Therefore the driver
> +  attempts to do dynamic tuning of the chipset at boot-time.
> +
> +  If you say Y here, you need to say Y to "Use DMA by default when
> +  available" as well.
>
>    If unsure, say N.
>
> -Special UDMA Feature
> +Override-Enable UDMA for Promise Controllers
>  CONFIG_PDC202XX_BURST
>    This option causes the pdc202xx driver to enable UDMA modes on the
>    PDC202xx even when the PDC202xx BIOS has not done so.
> @@ -1262,14 +1289,24 @@
>    used successfully on a PDC20265/Ultra100, allowing use of UDMA modes
>    when the PDC20265 BIOS has been disabled (for faster boot up).
>
> -  Please read the comments at the top of
> -  <file:drivers/ide/pci/pdc202xx_old.c>.
> -
>    If unsure, say N.
>
> -Special FastTrak Feature
> +Use FastTrak RAID capable device as plain IDE controller
>  CONFIG_PDC202XX_FORCE
> -  For FastTrak enable overriding BIOS.
> +  Setting this option causes the kernel to use your Promise IDE disk
> +  controller as an ordinary IDE controller, rather than as a FastTrak
> +  RAID controller. RAID is a system for using multiple physical disks
> +  as one virtual disk.
> +
> +  You need to say Y here if you have a PDC20276 IDE interface but either
> +  you do not have a RAID disk array, or you wish to use the Linux
> +  internal RAID software (/dev/mdX).
> +
> +  You need to say N here if you wish to use your Promise controller to
> +  control a FastTrak RAID disk array, and you you must also say Y to
> +  CONFIG_BLK_DEV_ATARAID_PDC.
> +
> +  If unsure, say Y.
>
>  SiS5513 chipset support
>  CONFIG_BLK_DEV_SIS5513


