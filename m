Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284642AbRLDAVN>; Mon, 3 Dec 2001 19:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284632AbRLDAOT>; Mon, 3 Dec 2001 19:14:19 -0500
Received: from 39.159.252.64.snet.net ([64.252.159.39]:2944 "EHLO
	stinkfoot.org") by vger.kernel.org with ESMTP id <S285189AbRLCV2R>;
	Mon, 3 Dec 2001 16:28:17 -0500
Message-ID: <3C0BF1C2.5070407@stinkfoot.org>
Date: Mon, 03 Dec 2001 16:42:26 -0500
From: Ethan <Ethan@stinkfoot.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011125
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PPC kernel fails when IDE built as modules
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just thought I'd drop a note that recent kernel builds (2.4.17-pre1,2) 
on PPC fail when IDE is built as modules.

-Ethan


ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic 
arch/ppc/kernel/head.o init/main.o init/version.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o 
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o 
drivers/net/net.o drivers/media/media.o drivers/scsi/scsidrv.o 
drivers/cdrom/driver.o drivers/pci/driver.o 
drivers/macintosh/macintosh.o drivers/video/video.o drivers/usb/usbdrv.o 
drivers/input/inputdrv.o \
        net/network.o \
        /usr/src/linux-bk/lib/lib.a \
        --end-group \
        -o vmlinux
arch/ppc/kernel/kernel.o: In function `pmac_init':
arch/ppc/kernel/kernel.o(.text.init+0x2cfa): undefined reference to 
`pmac_ide_init_hwif_ports'
arch/ppc/kernel/kernel.o(.text.init+0x2cfe): undefined reference to 
`pmac_ide_get_base'
arch/ppc/kernel/kernel.o(.text.init+0x2d12): undefined reference to 
`pmac_ide_init_hwif_ports'
arch/ppc/kernel/kernel.o(.text.init+0x2d16): undefined reference to 
`pmac_ide_get_base'
arch/ppc/kernel/kernel.o: In function `pmac_ide_check_region':
arch/ppc/kernel/kernel.o(.text.pmac+0x930): undefined reference to 
`pmac_ide_check_base'
arch/ppc/kernel/kernel.o(.text.pmac+0x930): relocation truncated to fit: 
R_PPC_REL24 pmac_ide_check_base
arch/ppc/kernel/kernel.o: In function `pmac_ide_request_region':
arch/ppc/kernel/kernel.o(.text.pmac+0x988): undefined reference to 
`pmac_ide_check_base'
arch/ppc/kernel/kernel.o(.text.pmac+0x988): relocation truncated to fit: 
R_PPC_REL24 pmac_ide_check_base
arch/ppc/kernel/kernel.o: In function `pmac_ide_release_region':
arch/ppc/kernel/kernel.o(.text.pmac+0x9d8): undefined reference to 
`pmac_ide_check_base'
arch/ppc/kernel/kernel.o(.text.pmac+0x9d8): relocation truncated to fit: 
R_PPC_REL24 pmac_ide_check_base
make: *** [vmlinux] Error 1


