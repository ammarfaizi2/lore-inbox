Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261842AbSKWQ6E>; Sat, 23 Nov 2002 11:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267034AbSKWQ6E>; Sat, 23 Nov 2002 11:58:04 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:20733 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261842AbSKWQ6D>; Sat, 23 Nov 2002 11:58:03 -0500
Date: Sat, 23 Nov 2002 18:05:06 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Gabor Z. Papp" <gzp@myhost.mynet>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc1 [SCSI] local symbols in discarded section .text.exit
Message-ID: <20021123170505.GI14886@fs.tum.de>
References: <acb.3dc624fd.65ec7@gzp1.gzp.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acb.3dc624fd.65ec7@gzp1.gzp.hu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 07:42:53AM -0000, Gabor Z. Papp wrote:

> make[1]: Leaving directory `/usr/src/linux-2.4.20-rc1-ibm/arch/i386/lib'
> ld -m elf_i386 -T /usr/src/linux-2.4.20-rc1-ibm/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
> 	--start-group \
> 	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
> 	 drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/scsi/scsidrv.o drivers/pci/driver.o drivers/video/video.o \
> 	net/network.o \
> 	/usr/src/linux-2.4.20-rc1-ibm/arch/i386/lib/lib.a /usr/src/linux-2.4.20-rc1-ibm/lib/lib.a /usr/src/linux-2.4.20-rc1-ibm/arch/i386/lib/lib.a \
> 	--end-group \
> 	-o vmlinux
> drivers/scsi/scsidrv.o(.data+0x3ad4): undefined reference to `local symbols in discarded section .text.exit'
> drivers/scsi/scsidrv.o(.data+0x3b14): undefined reference to `local symbols in discarded section .text.exit'
> drivers/scsi/scsidrv.o(.data+0x3b54): undefined reference to `local symbols in discarded section .text.exit'
> make: *** [vmlinux] Error 1
>...
> CONFIG_SCSI_IPS=y
>...

--- linux-2.4.19-full-nohotplug/drivers/scsi/ips.c.old	2002-10-04 18:49:10.000000000 +0200
+++ linux-2.4.19-full-nohotplug/drivers/scsi/ips.c	2002-10-04 18:50:02.000000000 +0200
@@ -305,21 +305,21 @@
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table,
        probe:		ips_insert_device,
-       remove:		ips_remove_device,
+       remove:		__devexit_p(ips_remove_device),
    }; 
            
    struct pci_driver ips_pci_driver_5i = {
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table_5i,
        probe:		ips_insert_device,
-       remove:		ips_remove_device,
+       remove:		__devexit_p(ips_remove_device),
    };
 
    struct pci_driver ips_pci_driver_i960 = {
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table_i960,
        probe:		ips_insert_device,
-       remove:		ips_remove_device,
+       remove:		__devexit_p(ips_remove_device),
    };
 
 #endif


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

