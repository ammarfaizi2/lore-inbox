Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129162AbRBQBTU>; Fri, 16 Feb 2001 20:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129617AbRBQBS7>; Fri, 16 Feb 2001 20:18:59 -0500
Received: from daikokuya.demon.co.uk ([158.152.184.26]:2820 "EHLO
	monkey.daikokuya.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129162AbRBQBS6>; Fri, 16 Feb 2001 20:18:58 -0500
Date: Sat, 17 Feb 2001 01:18:54 +0000
To: linux-kernel@vger.kernel.org
Subject: IBM-DTLA-307045 very slow under 2.2.x
Message-ID: <20010217011854.B719@daikokuya.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
From: Neil Booth <neil@daikokuya.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a SOYO "SY-5EMA+ Super 7" motherboard, with a K6-2 processor.
The 45 Gig IBM drive hangs the BIOS if I let it autodetect it, so I
turn off autodetection for IDE2 primary where it sits.  This is probably
not relevant.

My problem is that "hdparm -tT dev/hdc" gives atrocious
performance:-

/dev/hdc:
 Timing buffered disk reads:  64 MB in 22.81 seconds =  2.81 MB/sec

with approximately 25% CPU usage.  By contrast, for /dev/hda it
gives:-

/dev/hda:
 Timing buffered disk reads:  64 MB in 11.49 seconds =  5.57 MB/sec

with 100% CPU, which is still poor, but somewhat better.  The relevant
part of my dmesg is

VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: not 100% native mode: will probe irqs later
ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALL CR13.0A, ATA DISK drive
hdb: CD-ROM 40X/AKU, ATAPI CDROM drive
hdc: IBM-DTLA-307045, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: QUANTUM FIREBALL CR13.0A, 12416MB w/418kB Cache, CHS=1582/255/63
hdc: IBM-DTLA-307045, 43979MB w/1916kB Cache, CHS=5606/255/63
hdb: ATAPI 40X CD-ROM drive, 128kB Cache

hdparm -i /dev/hdc gives:-

Model=IBM-DTLA-307045, FwRev=TX6OA50C, SerialNo=YM0YML23878
Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=90069840
IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
PIO modes: pio0 pio1 pio2 pio3 pio4 
DMA modes: mdma0 mdma1 *mdma2 udma0 udma1 udma2 udma3 udma4 udma5 

Trying to set the DMA mode with -X34 and -d1 seems to have no effect.

Is this normal, or am I doing something wrong?

Thanks,

Neil.
