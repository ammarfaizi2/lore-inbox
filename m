Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265301AbUALBrW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 20:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265842AbUALBrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 20:47:22 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:40662 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265301AbUALBrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 20:47:19 -0500
Date: Mon, 12 Jan 2004 02:47:16 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Mario ''Jorge'' Di Nitto" <jorge78@inwind.it>
Cc: linux-kernel@vger.kernel.org, Sung-Ching Lin <sclin@sis.com.tw>
Subject: Re: 2.4.24 doesn't compile clearly...
Message-ID: <20040112014716.GF9677@fs.tum.de>
References: <200401111315.40950.jorge78@inwind.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401111315.40950.jorge78@inwind.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 01:15:40PM +0100, Mario ''Jorge'' Di Nitto wrote:

> Hi to all.

Hi Mario,

> I've download 2.4.24 and I patched it with ck1 and lm_sensor 2.8.2.
> Make dep is ok,  but make bzImage gives:
> 
> ld -m elf_i386 -T /usr/src/linux-2.4.24/arch/i386/vmlinux.lds -e stext 
> arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
> init/version.o init/do_mounts.o \
>         --start-group \
>         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o 
> fs/fs.o ipc/ipc.o \
>          drivers/acpi/acpi.o drivers/char/char.o drivers/block/block.o 
> drivers/misc/misc.o drivers/net/net.o drivers/char/agp/agp.o 
> drivers/char/drm/drm.o drivers/atm/atm.o drivers/ide/idedriver.o 
> drivers/scsi/scsidrv.o drivers/ieee1394/ieee1394drv.o drivers/cdrom/driver.o 
> drivers/pci/driver.o drivers/pcmcia/pcmcia.o drivers/net/pcmcia/pcmcia_net.o 
> drivers/pnp/pnp.o drivers/video/video.o drivers/usb/usbdrv.o 
> drivers/media/media.o drivers/input/inputdrv.o drivers/message/i2o/i2o.o 
> drivers/i2c/i2c.o drivers/sensors/sensor.o \
>         net/network.o \
>         /usr/src/linux-2.4.24/arch/i386/lib/lib.a /usr/src/linux-2.4.24/lib/lib.a /usr/src/linux-2.4.24/arch/i386/lib/lib.a 
> \
>         --end-group \
>         -o vmlinux
> drivers/char/drm/drm.o(.text+0x768e): In function `sis_fb_alloc':
> : undefined reference to `sis_malloc'
> drivers/char/drm/drm.o(.text+0x773f): In function `sis_fb_alloc':
> : undefined reference to `sis_free'
> drivers/char/drm/drm.o(.text+0x77a0): In function `sis_fb_free':
> : undefined reference to `sis_free'
> drivers/char/drm/drm.o(.text+0x7bef): In function `sis_final_context':
> : undefined reference to `sis_free'
> make: *** [vmlinux] Error 1
> 
> if I set sisfb as module.
> 
> D998:/usr/src/linux# grep -i sis .config
>...
> CONFIG_DRM_SIS=y
> CONFIG_FB_SIS=m
>...
> However, if I compile sisfb statically all works fine...

this is a well-known bug.

Workaround:
Either set CONFIG_DRM_SIS=m or CONFIG_FB_SIS=y .

> TIA,
> 				Jorge
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

