Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBWODR>; Fri, 23 Feb 2001 09:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129065AbRBWODH>; Fri, 23 Feb 2001 09:03:07 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:25612 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S129051AbRBWODD>;
	Fri, 23 Feb 2001 09:03:03 -0500
Date: Fri, 23 Feb 2001 15:02:37 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: weird /proc/ide/hdx/settings
To: linux-kernel@vger.kernel.org
Message-id: <3A966D7D.550A631B@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running kernel 2.4.2 :

cat /proc/ide/hdc/settings

name                    value           min             max             mode
----                    -----           ---             ---             ----
bios_cyl                89355           0               65535           rw
bios_head               16              0               255             rw
bios_sect               63              0               63              rw
breada_readahead        4               0               127             rw
bswap                   0               0               1               r
current_speed           69              0               69              rw
file_readahead          0               0               2097151         rw
ide_scsi                0               0               1               rw
init_speed              12              0               69              rw
io_32bit                1               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_kb_per_request      128             1               127             rw
multcount               0               0               8               rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  2               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               1               0               1               rw
using_dma      
--------------------%X---------------

max_kb_per_request  has value 128 , but max is 127 !?

max for multcount is 8 , but my drive supports 16 sectors. ( see hdparm output below )
If I set multcount to 8 sectors ( hdparm -m 8 /dev/hdc ) 
then /proc/ide/hdc/settings will show :
multcount               4               0               8               rw

The values are divided by 2. Why ?


hdparm -i /dev/hdc  :

/dev/hdc:

 Model=IBM-DTLA-307045, FwRev=TX6OA60A, SerialNo=YMEYMML9342
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=90069840
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 

IDE interface is VIA xxx686b ( ATA-100 )
IDE driver is VIA IDE v4.3

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
