Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271005AbRIXVHq>; Mon, 24 Sep 2001 17:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269693AbRIXVH2>; Mon, 24 Sep 2001 17:07:28 -0400
Received: from ip162.hinxr3.ras.tele.dk ([195.249.202.162]:29312 "EHLO
	stationaer.tossebo") by vger.kernel.org with ESMTP
	id <S269593AbRIXVHU>; Mon, 24 Sep 2001 17:07:20 -0400
Message-ID: <3BAF9F3D.8010405@cfxweb.net>
Date: Mon, 24 Sep 2001 23:01:49 +0200
From: Jack =?ISO-8859-1?Q?J=F8rgensen?= <super_cow@cfxweb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4+) Gecko/20010918
X-Accept-Language: da, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: super_cow@cfxweb.net
Subject: CD-ROM and HDD problems with the VIA chipset driver, MB Asus A7M266
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm having some problems using the following setup:

SCSI emulation on my CD-rom's (SCSI emulation, SCSI support, SCSI cdrom 
support and SCSI generic driver)
The CD-rom's are (on ide1):
    PLEXTOR CD-R PX-W1610A (master)
    CREATIVE DVD-ROM DVD6240E (slave)
I also have two hdd's (on ide0):
    IBM DeskStar 60GXP 40GB (master)
    Seagate ST315320A (slave)

My motherboard is the Asus A7M266 (with the Via VT82C686B south-bridge)

The kernel is 2.4.2

Now, if I don't include via chipset support, my hdd's run at ATA100 
(IBM) and ATA66 (Seagate).
If i include the via chipset, they both run at ATA33, which I can't change.

When not using the via chipset support, my Plextor drive won't mount 
cd's (the creative cd-rom works fine in both modes) though it still 
burns fine.

/var/log/messages include:
    ide-scsi: The scsi wants to send us more data than expected - 
discarding data
    68 times

and right after:
    can't determine CD-Format.

when i try to mount



If I include the via chipset support, the cd mounts with Plextor, but 
the hdd's (as already stated) runs slower (about 10MB/s)

Also, the information in /proc/ide/via:
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.20
South Bridge:                       VIA vt82c686b
Revision:                           ISA 0x40 IDE 0x6
BM-DMA base:                        0xd800
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                  no
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA      UDMA      UDMA      UDMA
Address Setup:       30ns      30ns      30ns      30ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns      90ns      90ns      90ns
Data Recovery:       30ns      30ns      30ns      30ns
Cycle Time:          60ns      60ns      90ns      90ns
Transfer Rate:   33.3MB/s  33.3MB/s  22.2MB/s  22.2MB/s

Dosen't fit with the cables I use - they are both 80 pins (and the BIOS 
acknowledges this)

hdparm -i /dev/hd[ab] (when using the via chipset support):
/dev/hda:

 Model=IC35L040AVER07-0, FwRev=ER4OA44A, SerialNo=SXPTX0K2690
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=80418240
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5

/dev/hdb:

 Model=ST315320A, FwRev=3.12, SerialNo=3CW035CJ
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=29888820
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4

I tried using the via kernel parameter to hardcode the UDMA 
transfer-rates but nothing happend.

(I'm not subscribed to this list, so if anybody answers would they 
please CC the reply to me)
Kind regards Jack Jørgensen.

----
This is a signature virus!
Copy this into you're ~/.signature file to help it spread



