Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129991AbRAaQCv>; Wed, 31 Jan 2001 11:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130162AbRAaQCl>; Wed, 31 Jan 2001 11:02:41 -0500
Received: from mail.linpro.no ([213.203.57.2]:30736 "HELO linpro.no")
	by vger.kernel.org with SMTP id <S129991AbRAaQC1>;
	Wed, 31 Jan 2001 11:02:27 -0500
To: Andre Hedrick <andre@linux-ide.org>, mlord@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: Problems with Promise IDE controller under 2.4.1
From: Ole Aamot <ole@linpro.no>
Date: 31 Jan 2001 17:02:25 +0100
Message-ID: <uk0d7d3hfqm.fsf@false.linpro.no>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We experience trouble with the Promise (PDC20265) IDE controller
and seven 75GB IBM disks on a single CPU (Pentium-III) server.

Linux 2.4.1 fails to detect correct geometry for the four last
disks (identified as hde, hdf, hdg, hdh).

[root@nngds1 /root]# cat /proc/ide/hd[abcefgh]/geometry
physical     148945/16/63
logical      9345/255/63
physical     148945/16/63
logical      9345/255/63
physical     148945/16/63
logical      9345/255/63
physical     148945/16/63
logical      148945/16/63
physical     148945/16/63
logical      148945/16/63
physical     148945/16/63
logical      148945/16/63
physical     148945/16/63
logical      148945/16/63


Output from hdparm -i /dev/hd[abcefgh]:

/dev/hda:

 Model=IBM-DTLA-307075, FwRev=TXAOA50C, SerialNo=YSDYSFAL154
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=150136560
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5

/dev/hdb:

 Model=IBM-DTLA-307075, FwRev=TXAOA50C, SerialNo=YSDYSFAR909
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=150136560
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5

/dev/hdc:

 Model=IBM-DTLA-307075, FwRev=TXAOA50C, SerialNo=YSDYSFAS836
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=150136560
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5

/dev/hde:

 Model=IBM-DTLA-307075, FwRev=TXAOA50C, SerialNo=YSDYSFAL701
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=150136560
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5

/dev/hdf:

 Model=IBM-DTLA-307075, FwRev=TXAOA50C, SerialNo=YSDYSFAR606
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=150136560
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5

/dev/hdg:

 Model=IBM-DTLA-307075, FwRev=TXAOA50C, SerialNo=YSDYSFAL151
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=150136560
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5

/dev/hdh:

 Model=IBM-DTLA-307075, FwRev=TXAOA50C, SerialNo=YSDYSFAR624
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=150136560
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5


---

Two types of disks:
(geometry of the first is correctly detected, the second isn't)

[root@nngds1 /root]# hdparm /dev/hda

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 9345/255/63, sectors = 150136560, start = 0

[root@nngds1 /root]# hdparm /dev/hde

/dev/hde:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 17873/16/63, sectors = 150136560, start = 0


The machine runs RedHat 7.0 with RHN upgrades if it means anything.

-- 
Ole Aamot                                      mailto:ole@linpro.no
LinPro AS                                      http://www.linpro.no
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
