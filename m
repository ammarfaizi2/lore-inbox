Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130006AbRAKNeE>; Thu, 11 Jan 2001 08:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130036AbRAKNdz>; Thu, 11 Jan 2001 08:33:55 -0500
Received: from Earth.nistix.com ([209.140.42.210]:17792 "EHLO Earth.nistix.com")
	by vger.kernel.org with ESMTP id <S130006AbRAKNdr>;
	Thu, 11 Jan 2001 08:33:47 -0500
Message-ID: <3A5DB638.1050809@nistix.com>
Date: Thu, 11 Jan 2001 07:33:44 -0600
From: James Brents <James@nistix.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; m18) Gecko/20010110
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE DMA problems on 2.4.0 with vt82c686a driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Since this looks like either a chipset, drive, or driver problem, I am 
submitting this.
I have recently started using DMA mode on my harddisk. However, I 
occasionally (not often/constant, but sometimes) get CRC errors:
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

After reading some archives in linux-kernel, I tried changing some 
options. Then I changed out the 40 pin, 80 wire cable with a new one. 
The errors still occasionally happened, so I then checked out the 
included floppy disk with the drive and used the utilities and saw that 
it was set for a maximum capability of ATA/100, so i changed it to 
ATA/66, but no change in results. I've since changed it back to ATA/100 
capabilities. Running without DMA mode never gives any errors what so 
ever. Running with DMA mode gives me over 30 more MB/sec, so I would 
really like to use it...

My main concern that I havnt beem able to find an answer for on any 
archives or documentation, Can this cause file system corruption in any way?

The hardware is a VP_IDE: VIA vt82c686a IDE UDMA66 (VIA KT133 chipset on 
an Abit KT7 board)
The drive is a Western Digital Caviare 7200rpm 40gig hard drive.
I have support for my chipset compiled in as well

Kernel: 2.4.0

[root@Earth root]$ hdparm -i /dev/hda

/dev/hda:

  Model=WDC WD400BB-00AUA1, FwRev=18.20D18, SerialNo=WD-WMA6R2018028
  Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
  RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
  BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
  CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=78165360
  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes: pio0 pio1 pio2 pio3 pio4
  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 udma5

[root@Earth root]# hdparm -I /dev/hda

/dev/hda:

  Model=DW CDW04B0-B00UA1A                      , FwRev=812.D081, 
SerialNo=DWW-AMR6028120
  Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
  RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
  BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
  CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=78165360
  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}

[root@Earth root]# hdparm /dev/hda

/dev/hda:
  multcount    =  0 (off)
  I/O support  =  0 (default 16-bit)
  unmaskirq    =  0 (off)
  using_dma    =  1 (on)
  keepsettings =  0 (off)
  nowerr       =  0 (off)
  readonly     =  0 (off)
  readahead    =  8 (on)
  geometry     = 4865/255/63, sectors = 78165360, start = 0

  PIO modes: pio0 pio1 pio2 pio3 pio4
  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 udma5


VP_IDE: VIA vt82c686a IDE UDMA66 controller on pci0:7.1
     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=38166/64/32, UDMA(66)


If any other information is needed, I will be more than happy to supply 
it. Any help/information will be greatly appreciated.
Thank you.

--
James Brents
James@nistix.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
