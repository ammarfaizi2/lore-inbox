Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280258AbRKEGvA>; Mon, 5 Nov 2001 01:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280267AbRKEGuv>; Mon, 5 Nov 2001 01:50:51 -0500
Received: from conn.mc.mpls.visi.com ([208.42.156.2]:65215 "EHLO
	conn.mc.mpls.visi.com") by vger.kernel.org with ESMTP
	id <S280258AbRKEGue>; Mon, 5 Nov 2001 01:50:34 -0500
Date: Mon, 5 Nov 2001 00:50:33 -0600
From: Ryan Hayle <hackel@walkingfish.com>
To: linux-kernel@vger.kernel.org
Subject: Poor IDE performance with VIA MVP3
Message-ID: <20011105005033.A10060@isis.visi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a VIA MVP3 (VT82C586B) controller on my motherboard, and am
experiencing extremely poor performance with a Maxtor 20G
(52049U4) drive.  It is an UDMA66-capable drive, but I'm only attempting
to use UDMA33 (with an 80-pin cable, as recommended).

The drive is detected and works just fine, with no errors reported,
however the acces is painfully slow.  hdparm -t varries from 970 K/sec to
2.5 M/sec. (See below)

The drive is attached by itself to the first IDE channel.  On the second I
have a Maxtor 6.8G (90680D4) and a CDROM.  hdparm -t on the second drive
typically gives 8-9 M/sec.  I manually set this drive with hdparm -X34
(mdma2), otherwise it generates errors.

I have tried Linux 2.2.19, 2.4.12, and now 2.4.13, and all exhibit this
same behavior.  I was originally running with a 40-pin cable, and switched
it to the 80 to see if it might help, but it had no effect.  As some
background information, I was originally running linux off of the second
6G drive, and opted to move it onto the 20G because it got better
performance.  Once I did this, however, the drive started performing
slowly like this, regardless of whether I'm booting to it or the 6G
drive.

Does this sound like it's just a hardware problem?  Has anyone experienced
anything similar to this?  Any advice would be greatly apreciated.

Thanks,
Ryan Hayle
Please CC replies...

Some relevent bits of info below...

>From dmesg:
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 52049U4, ATA DISK drive
hdc: Maxtor 90680D4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 40020624 sectors (20491 MB) w/2048KiB Cache, CHS=2491/255/63,
UDMA(33)
hdc: 13281408 sectors (6800 MB) w/256KiB Cache, CHS=13176/16/63, UDMA(33)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
 /dev/ide/host0/bus1/target0/lun0: p1 p2 p3


hdparm -it /dev/hda /dev/hdc

/dev/hda:

 Model=Maxtor 52049U4, FwRev=DA6207V0, SerialNo=K40GTYJC
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=40020624
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4
 Timing buffered disk reads:  64 MB in 45.08 seconds =  1.42 MB/sec

/dev/hdc:

 Model=Maxtor 90680D4, FwRev=PAS23B15, SerialNo=V40667NA
 Config={ Fixed }
 RawCHS=13176/16/63, TrkSize=0, SectSize=0, ECCbytes=29
 BuffType=DualPortCache, BuffSize=256kB, MaxMultSect=16, MultSect=16
 CurCHS=13176/16/63, CurSects=13281408, LBA=yes, LBAsects=13281408
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 *mdma2 udma0 udma1 udma2
 Timing buffered disk reads:  64 MB in  7.37 seconds =  8.68 MB/sec



/proc/ide/via
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.29
South Bridge:                       VIA vt82c586b
Revision:                           ISA 0x47 IDE 0x6
Highest DMA rate:                   UDMA33
BM-DMA base:                        0xe000
PCI clock:                          33MHz
Master Read  Cycle IRDY:            1ws
Master Write Cycle IRDY:            1ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       DMA       DMA       DMA
Address Setup:       30ns     120ns      30ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns     330ns
Data Recovery:       30ns     270ns      30ns     270ns
Cycle Time:          60ns     600ns     120ns     600ns
Transfer Rate:   33.0MB/s   3.3MB/s  16.5MB/s   3.3MB/s


/proc/pci:
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT82C597 [Apollo VP3] (rev 4).
      Master Capable.  Latency=16.
      Prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=4.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 71).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=64.
      I/O at 0xe000 [0xe00f].
  Bus  0, device   7, function  3:
    Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 16).
      IRQ 9.
  Bus  0, device   8, function  0:
    VGA compatible controller: nVidia Corporation Riva TnT 128 [NV04] (rev 3).
      IRQ 11.
      Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xe4000000 [0xe4ffffff].
      Prefetchable 32 bit memory at 0xe5000000 [0xe5ffffff].
  Bus  0, device   9, function  0:
    Multimedia video controller: Brooktree Corporation Bt848 TV with DMA push (rev 17).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=16.Max Lat=40.
      Prefetchable 32 bit memory at 0xe8001000 [0xe8001fff].
  Bus  0, device  11, function  0:
    Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 0).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=10.Max Lat=10.
      I/O at 0xe800 [0xe87f].
      Non-prefetchable 32 bit memory at 0xe8000000 [0xe800007f].


