Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293737AbSB1UJt>; Thu, 28 Feb 2002 15:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293714AbSB1UIc>; Thu, 28 Feb 2002 15:08:32 -0500
Received: from WAVELETS.MIT.EDU ([18.58.2.230]:19116 "EHLO wavelets.mit.edu")
	by vger.kernel.org with ESMTP id <S293718AbSB1UGm>;
	Thu, 28 Feb 2002 15:06:42 -0500
Subject: Re: Yet another disk transfer speed problem
From: Bharath Krishnan <bharath@mit.edu>
To: Joseph Malicki <jmalicki@starbak.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <006401c1c091$d721ec00$5a5b903f@h90>
In-Reply-To: <1014914087.3274.22.camel@wavelets.mit.edu> 
	<006401c1c091$d721ec00$5a5b903f@h90>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 (1.0.2-0.7x) 
Date: 28 Feb 2002 15:06:41 -0500
Message-Id: <1014926801.3274.40.camel@wavelets.mit.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would expect the disk which acts slower(maxtor) to be atleast as fast
as the other one (ibm).

reasons:

1. Both are 7200RPM
2. The slower one(maxtor hdg) is one of the newer ata133 disks while
that faster one  is ata100(ibm hde). I would expect atleast equal
performance from both.


Thanks,

-bharath




On Thu, 2002-02-28 at 14:55, Joseph Malicki wrote:
> Have you considered that perhaps one of your drives is just faster than the
> other?
> This happens.
> 
> -joe
> 
> ----- Original Message -----
> From: "Bharath Krishnan" <bharath@mit.edu>
> To: <linux-kernel@vger.kernel.org>
> Sent: Thursday, February 28, 2002 11:34 AM
> Subject: Yet another disk transfer speed problem
> 
> 
> > Hello!
> >
> > Please CC: me on replies,
> >
> > Problem: ata disk on secondary controller of PDC20265
> > gives sub-par performance.
> >
> > both disks have c3 and d1 set along with X69.
> >
> > hdparm -tT /dev/hdg:
> > /dev/hdg:
> >  Timing buffer-cache reads:   128 MB in  0.77 seconds =166.23 MB/sec
> >  Timing buffered disk reads:  64 MB in  3.81 seconds = 16.80 MB/sec
> >
> > compared to
> > hdparm -tT /dev/hde:
> > /dev/hde:
> >  Timing buffer-cache reads:   128 MB in  0.73 seconds =175.34 MB/sec
> >  Timing buffered disk reads:  64 MB in  1.82 seconds = 35.16 MB/sec
> >
> >
> > Setup:
> > kernel: 2.4.17
> > pdc20265 controller on asus a7v motherboard.
> > kernel config options:
> > CONFIG_BLK_DEV_PDC202XX=y
> > CONFIG_PDC202XX_BURST=y
> > # CONFIG_PDC202XX_FORCE is not set
> > # CONFIG_BLK_DEV_ATARAID_PDC is not set
> >
> > similar behavior with redhat 7.2 updated kernel 2.4.9-21
> >
> > hde: IBM-DTLA-307015, ATA DISK drive
> > hdg: MAXTOR 6L040J2, ATA DISK drive
> >
> > Interesting stuff from dmesg:
> > ide2: BM-DMA at 0x8000-0x8007, BIOS settings: hde:DMA, hdf:pio
> > ide3: BM-DMA at 0x8008-0x800f, BIOS settings: hdg:DMA, hdh:pio
> >
> > cat /proc/ide/ide2/config
> > pci bus 00 device 88 vid 105a did 0d30 channel 0
> > 5a 10 30 0d 07 00 10 02 02 00 80 01 00 20 00 00
> > 01 94 00 00 01 90 00 00 01 88 00 00 01 84 00 00
> > 01 80 00 00 00 00 00 d4 00 00 00 00 5a 10 33 4d
> > 00 00 00 00 58 00 00 00 00 00 00 00 0a 01 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > be 33 00 00 00 00 00 00 01 00 01 00 00 00 00 00
> > f1 24 41 00 c4 f3 4f 00 f1 24 41 00 c4 f3 4f 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >
> > cat /proc/ide/ide3/config
> > pci bus 00 device 88 vid 105a did 0d30 channel 1
> > 5a 10 30 0d 07 00 10 02 02 00 80 01 00 20 00 00
> > 01 94 00 00 01 90 00 00 01 88 00 00 01 84 00 00
> > 01 80 00 00 00 00 00 d4 00 00 00 00 5a 10 33 4d
> > 00 00 00 00 58 00 00 00 00 00 00 00 0a 01 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > be 33 00 00 00 00 00 00 01 00 01 00 00 00 00 00
> > f1 24 41 00 c4 f3 4f 00 f1 24 41 00 c4 f3 4f 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >
> > hdparm -i
> > /dev/hde
> > Model=IBM-DTLA-307015, FwRev=TX2OA50C, SerialNo=YF0YFFX4393
> >  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
> >  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
> >  BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=16
> >  CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=30003120
> >  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
> >  PIO modes: pio0 pio1 pio2 pio3 pio4
> >  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
> >  AdvancedPM=yes: disabled (255)
> >  Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-2 ATA-3 ATA-4
> > ATA-5
> >
> > /dev/hdg
> > Model=MAXTOR 6L040J2, FwRev=A93.0300, SerialNo=662125114610
> >  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
> >  RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
> >  BuffType=DualPortCache, BuffSize=1820kB, MaxMultSect=16, MultSect=16
> >  CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=78177792
> >  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
> >  PIO modes: pio0 pio1 pio2 pio3 pio4
> >  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6
> >  AdvancedPM=no
> >  Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-1 ATA-2 ATA-3
> > ATA-4 ATA-5
> >
> > cat /proc/ide/pdc202xx
> >                                PDC20265 Chipset.
> > ------------------------------- General Status
> > ---------------------------------Burst Mode                           :
> > enabled
> > Host Mode                            : Normal
> > Bus Clocking                         : 33 PCI Internal
> > IO pad select                        : 10 mA
> > Status Polling Period                : 8
> > Interrupt Check Status Polling Delay : 11
> > --------------- Primary Channel ---------------- Secondary Channel ----
> >                 enabled                          enabled
> > 66 Clocking     enabled                          enabled
> >            Mode PCI                         Mode PCI
> >                 FIFO Empty                       FIFO Empty
> > --------------- drive0 --------- drive1 -------- drive0 ----------
> > drive1 -DMA enabled:    yes              no
> > yes               no
> > DMA Mode:       UDMA 4           NOTSET          UDMA 4
> > NOTSET
> > PIO Mode:       PIO 4            NOTSET           PIO 4
> > NOTSET
> >
> >
> > What is going on? I do have ata100 cables.
> >
> > Thanks,
> >
> > -bharath
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 

