Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276985AbRJCVRz>; Wed, 3 Oct 2001 17:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276987AbRJCVRq>; Wed, 3 Oct 2001 17:17:46 -0400
Received: from lsd.nurk.org ([208.8.184.53]:63873 "HELO lsd.nurk.org")
	by vger.kernel.org with SMTP id <S276985AbRJCVRc>;
	Wed, 3 Oct 2001 17:17:32 -0400
Date: Wed, 3 Oct 2001 14:18:04 -0700 (PDT)
From: Sean Swallow <sean@swallow.org>
To: <linux-kernel@vger.kernel.org>
Subject: PDC20268 UDMA troubles
Message-ID: <Pine.LNX.4.33.0110031030070.4720-100000@lsd.nurk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

List,

I have a Tyan Tiger MP 2460 motherboard with a 3c59x ethernet card, a
PDC20267, and a PDC20268; kernel versions 2.4.9 and 2.4.10. I have tried
both PCI and a AGP video cards, with the same results.

I can not get all four chains to do UDMA5 at the same time. This is output
from dmesg (notice the messages from the PDC20268):

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
AMD7411: IDE controller on PCI bus 00 dev 39
PCI: Enabling device 00:07.1 (0000 -> 0001)
AMD7411: chipset revision 1
AMD7411: not 100% native mode: will probe irqs later
AMD74xx: AMD-766 ViperPlus (rev 01) IDE UDMA100 controller on pci00:07.1
AMD7411: neither IDE port enabled (BIOS)
PDC20267: IDE controller on PCI bus 00 dev 40
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x1080-0x1087, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x1088-0x108f, BIOS settings: hdg:pio, hdh:pio
PDC20268: IDE controller on PCI bus 00 dev 50
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
PDC20268: (U)DMA Burst Bit DISABLED Primary MASTER Mode Secondary MASTER
Mode.
PDC20268: FORCING BURST BIT 0x50 -> 0x51 INACTIVE
    ide4: BM-DMA at 0x10d0-0x10d7, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x10d8-0x10df, BIOS settings: hdk:pio, hdl:pio
hde: IC35L040AVER07-0, ATA DISK drive
hdg: IC35L040AVER07-0, ATA DISK drive
hdi: IC35L040AVER07-0, ATA DISK drive
hdk: IC35L040AVER07-0, ATA DISK drive
ide2 at 0x10f8-0x10ff,0x10f2 on irq 10
ide3 at 0x10e8-0x10ef,0x10e6 on irq 10
ide4 at 0x1410-0x1417,0x140a on irq 11
ide5 at 0x1400-0x1407,0x10f6 on irq 11
hde: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63,
UDMA(100)
hdg: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63,
UDMA(100)
hdi: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, (U)DMA
hdk: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, (U)DMA


When I cat /proc/ide/pdc202xx the PDC20268 dosen't show up:

[root@term-3 ide]# cat pdc202xx

                                PDC20267 Chipset.
------------------------------- General Status ---------------------------------
Burst Mode                           : enabled
Host Mode                            : Normal
Bus Clocking                         : 66 External
IO pad select                        : 10 mA
Status Polling Period                : 0
Interrupt Check Status Polling Delay : 0
--------------- Primary Channel ---------------- Secondary Channel-------------
                enabled                          enabled
66 Clocking     enabled                          enabled
           Mode PCI                         Mode PCI
                FIFO Empty                       FIFO Empty
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1------
DMA enabled:    yes              no              yes               no
DMA Mode:       UDMA 4           NOTSET          UDMA 4            NOTSET
PIO Mode:       PIO 4            NOTSET           PIO 4            NOTSET


/proc seems to think that it's at UDMA 4, but hdparm says it's at UDMA 5:

[root@term-3 ide]# hdparm -i /dev/hde

/dev/hde:

 Model=IC35L040AVER07-0, FwRev=ER4OA44A, SerialNo=SXTTX1P6830
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=80418240
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5

[root@term-3 ide]# hdparm -i /dev/hdg

/dev/hdg:

 Model=IC35L040AVER07-0, FwRev=ER4OA44A, SerialNo=SXTTX1N6238
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=80418240
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5

[root@term-3 ide]# hdparm -i /dev/hdi

/dev/hdi:

 Model=IC35L040AVER07-0, FwRev=ER4OA44A, SerialNo=SXTTX1P6030
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=80418240
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 *mdma2 udma0 udma1 udma2 udma3 udma4 udma5

[root@term-3 ide]# hdparm -i /dev/hdk

/dev/hdk:

 Model=IC35L040AVER07-0, FwRev=ER4OA44A, SerialNo=SXTTX1N8537
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=80418240
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 *mdma2 udma0 udma1 udma2 udma3 udma4 udma5


[root@term-3 /root]# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
03c0-03df : vga+
0cf8-0cff : PCI conf1
1000-107f : 3Com Corporation 3c905C-TX [Fast Etherlink]
  1000-107f : 00:0c.0
1080-10bf : Promise Technology, Inc. 20267
  1080-1087 : ide2
  1088-108f : ide3
  1090-10bf : PDC20267
10d0-10df : Promise Technology, Inc. 20268
  10d0-10d7 : ide4
  10d8-10df : ide5
10e0-10e3 : PCI device 1022:700c (Advanced Micro Devices [AMD])
10e4-10e7 : Promise Technology, Inc. 20267
  10e6-10e6 : ide3
10e8-10ef : Promise Technology, Inc. 20267
  10e8-10ef : ide3
10f0-10f3 : Promise Technology, Inc. 20267
  10f2-10f2 : ide2
10f4-10f7 : Promise Technology, Inc. 20268
  10f6-10f6 : ide5
10f8-10ff : Promise Technology, Inc. 20267
  10f8-10ff : ide2
1400-1407 : Promise Technology, Inc. 20268
  1400-1407 : ide5
1408-140b : Promise Technology, Inc. 20268
  140a-140a : ide4
1410-1417 : Promise Technology, Inc. 20268
  1410-1417 : ide4
2000-2fff : PCI Bus #01
  2000-20ff : ATI Technologies Inc Rage XL AGP
f000-f00f : Advanced Micro Devices [AMD] AMD-765 [Viper] IDE


I've tried with and without "CONFIG_PDC202XX_BURST".

I tried setting ide4=ata66 and ide5=ata66 but that had no effect.

I also tried replacing the PDC20267 with another PDC20268 and using the
onboard AMD viper with one PDC20268, and still get the same result; 2
chains on the first detected promise card get UDMA, and no other chains
will. =(

Does anyone have any ideas?

thank you,

-- 
Sean J. Swallow
pgp (6.5.2) keyfile @ https://nurk.org/keyfile.txt


