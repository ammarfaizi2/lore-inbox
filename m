Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132765AbRDURd6>; Sat, 21 Apr 2001 13:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132769AbRDURdj>; Sat, 21 Apr 2001 13:33:39 -0400
Received: from diup-184-214.inter.net.il ([213.8.184.214]:52997 "EHLO
	callisto.yi.org") by vger.kernel.org with ESMTP id <S132765AbRDURd1>;
	Sat, 21 Apr 2001 13:33:27 -0400
Date: Sat, 21 Apr 2001 20:33:05 +0300 (IDT)
From: Dan Aloni <karrde@callisto.yi.org>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@image.dk>
Subject: Re: cdrom driver dependency problem (and a workaround patch)
In-Reply-To: <20010421134412.O682@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.32.0104212032310.28315-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Apr 2001, Ingo Oeser wrote:

> > In order to get my kernel to boot, I've made the following temporary
> > workaround patch. I'd be glad to hear about other ways of solving this.
>
> The link order is wrong. So why not changing the link order then?

I remember doing what the patch below does.
It didn't help.

Did you try this patch?

> --- Makefile.orig       Sat Apr 21 12:34:34 2001
> +++ Makefile    Sat Apr 21 12:35:12 2001
> @@ -149,15 +149,15 @@
>  DRIVERS-$(CONFIG_WAN) += drivers/net/wan/wan.o
>  DRIVERS-$(CONFIG_ARCNET) += drivers/net/arcnet/arcnetdrv.o
>  DRIVERS-$(CONFIG_ATM) += drivers/atm/atm.o
> -DRIVERS-$(CONFIG_IDE) += drivers/ide/idedriver.o
> -DRIVERS-$(CONFIG_SCSI) += drivers/scsi/scsidrv.o
> -DRIVERS-$(CONFIG_FUSION_BOOT) += drivers/message/fusion/fusion.o
> -DRIVERS-$(CONFIG_IEEE1394) += drivers/ieee1394/ieee1394drv.o
>
>  ifneq ($(CONFIG_CD_NO_IDESCSI)$(CONFIG_BLK_DEV_IDECD)$(CONFIG_BLK_DEV_SR)$(CONFIG_PARIDE_PCD),)
>  DRIVERS-y += drivers/cdrom/driver.o
>  endif
>
> +DRIVERS-$(CONFIG_IDE) += drivers/ide/idedriver.o
> +DRIVERS-$(CONFIG_SCSI) += drivers/scsi/scsidrv.o
> +DRIVERS-$(CONFIG_FUSION_BOOT) += drivers/message/fusion/fusion.o
> +DRIVERS-$(CONFIG_IEEE1394) += drivers/ieee1394/ieee1394drv.o
>  DRIVERS-$(CONFIG_SOUND) += drivers/sound/sounddrivers.o
>  DRIVERS-$(CONFIG_PCI) += drivers/pci/driver.o
>  DRIVERS-$(CONFIG_MTD) += drivers/mtd/mtdlink.o
>
>
> Would be my idea of solving this issue.
>
> Regards
>
> Ingo Oeser
> --
> 10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
>          <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--
Dan Aloni
dax@karrde.org

