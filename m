Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130575AbRCEBPu>; Sun, 4 Mar 2001 20:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130579AbRCEBPj>; Sun, 4 Mar 2001 20:15:39 -0500
Received: from [209.53.18.145] ([209.53.18.145]:42368 "EHLO
	continuum.localnet.cm.nu") by vger.kernel.org with ESMTP
	id <S130575AbRCEBPb>; Sun, 4 Mar 2001 20:15:31 -0500
Date: Sun, 4 Mar 2001 17:15:28 -0800
From: Shane Wegner <shane@cm.nu>
To: linux-kernel@vger.kernel.org
Subject: IDE trouble under 2.2.19pre16 with Hedrick's IDE patch
Message-ID: <20010304171528.A4966@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Organization: Continuum Systems, Vancouver, Canada
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Whenever I write a substantial amount of data (200mb) to
disk, I get these messages.  The disks lock for about 10
seconds and then come back for about 10 seconds again. 
This continues until the data is successfully written.

ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hde: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hde: DMA disabled
hde: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hde: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hde: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hde: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hde: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hde: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }

Does anyone happen to know what I can do to fix this?  It
happens on Linux 2.4.2 as well.  It's an HPT370 controler
on-board.  Here is the relevant information.

HPT370: IDE controller on PCI bus 00 dev 70
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:DMA,
hdf:pio
    ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:DMA,
hdh:pio
hde: Maxtor 92720U8, ATA DISK drive
hdg: Maxtor 96147U8, ATA DISK drive
ide2 at 0xdc00-0xdc07,0xe002 on irq 10
ide3 at 0xe400-0xe407,0xe802 on irq 10
hde: Maxtor 92720U8, 25965MB w/2048kB Cache,
CHS=52755/16/63, UDMA(66)
hdg: Maxtor 96147U8, 58623MB w/2048kB Cache,
CHS=119108/16/63, UDMA(66)


continuum:~# cat /proc/ide/hpt366

                                HPT370 Chipset.
--------------- Primary Channel ---------------- Secondary
Channel -------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0
---------- drive1 ------
DMA enabled:    yes              no              yes
no
UDMA
DMA
PIO
continuum:~# cat /proc/ide/hde/settings
name                    value           min             max
mode
----                    -----           ---             ---
----
bios_cyl                52755           0
65535           rw
bios_head               16              0               255
rw
bios_sect               63              0               63
rw
breada_readahead        4               0               127
rw
bswap                   0               0               1
r
current_speed           68              0               69
rw
file_readahead          124             0
2097151         rw
ide_scsi                0               0               1
rw
init_speed              68              0               69
rw
io_32bit                1               0               3
rw
keepsettings            1               0               1
rw
lun                     0               0               7
rw
max_kb_per_request      64              1               127
rw
multcount               8               0               8
rw
nice1                   1               0               1
rw
nowerr                  0               0               1
rw
number                  0               0               3
rw
pio_mode                write-only      0               255
w
slow                    0               0               1
rw
unmaskirq               1               0               1
rw
using_dma               1               0               1
rw

-- 
Shane Wegner: shane@cm.nu
              http://www.cm.nu/~shane/
PGP:          1024D/FFE3035D
              A0ED DAC4 77EC D674 5487
              5B5C 4F89 9A4E FFE3 035D
