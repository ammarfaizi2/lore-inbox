Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267349AbSKPURU>; Sat, 16 Nov 2002 15:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267350AbSKPURU>; Sat, 16 Nov 2002 15:17:20 -0500
Received: from smtp.netcabo.pt ([212.113.174.9]:23729 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id <S267349AbSKPURP>;
	Sat, 16 Nov 2002 15:17:15 -0500
Message-ID: <3DD6A86C.9090301@netcabo.pt>
Date: Sat, 16 Nov 2002 20:19:56 +0000
From: Miguel S Filipe <m3thos@netcabo.pt>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20021101
X-Accept-Language: en-us, en, pt
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Disk Performance Issues [AMD Viper plus IDE chipset problems. (wrong
 udma "autodetection")]
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070308080900010204050508"
X-OriginalArrivalTime: 16 Nov 2002 20:22:08.0737 (UTC) FILETIME=[D6800D10:01C28DAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070308080900010204050508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello there,

  I'm sending this email about a problem with udma settings
in a TigerMP motherboard, wich supports UDMA 100.
  I've send it to my distribution mailing list, and several others, to no
avail, so, has a last resort I send it now to the Linux ML.
  I'm using pure vanilla linux-2.4.19, and I tried all possible configs
settings that I though that could affect this problem.

  Notice also, that before sending this I really probed around the
internet, and found some emails in the linux ML relating to this
problem. however, they were all pretty old(one year old), and all
problem reports related to this stopped long time ago, after some
patches from Patrick Vojtech, wich led me to think that recente kernel
versions had this problem fixed.
  Following this thread:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0109.3/1003.html i've
found a patch, tried to aply but failed, the patch was:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0109.3/att-1176/01-viper-vojtech.diff
  I'm not experienced enough to adapt the patch for 2.4.19 (the author
says it was made against 2.4.10).
  I've also read one e-mail related to IDE performance on the Tyan Tiger
mobo, URL:http://lists.insecure.org/linux-kernel/2001/Dec/0544.html


  I *do* have the proper cables.
  The funny thing is that ONCE.. and only ONCE.. when I was trying to
solve this problem I WAS able to solve it.. and benchmarked the
disk...hdparm -t /dev/hda gave me 40.0MB/S, after enabling DMA.
Also I have tweaked with the bios settings with no luck.

  The problem looks like the kernel on boot detects the disks has UDMA33
all the time, although one does UDMA 100 and the other one UDMA 66. My
drive's performance are lousy, and I know they are capable of much more,
hda is a Seagate Barracuda IV 7200rpm 2mb cache (40Gbs)
URL:
http://www.seagate.com/cda/products/discsales/marketing/detail/0,1081,384,00.html
hdc is a Seagate "ST-36421A (U4 6421, Ultra ATA/66)
URL: http://www.seagate.com/cgi-bin/view.cgi?/at/st36421a.txt


   I though that my best luck was to ask if you guys, since i'm quite a
stubburn, i won't give up on this easilly, i've tried practically
everything, diferent kernel branches, bios settings, removed all extra
devices from the cables...etc
In case of being a kernel miss configuration problem.. I send attached
my kernel config file.

- If any important information is missing please warn me so I can
provide what's needed.

here's some info from hdparm, and following there's a cut from dmesg:

[191p] quark : ~ $ /sbin/hdparm -c3 -d1 -m16 -X68 /dev/hda

/dev/hda:
~ setting 32-bit IO_support flag to 3
~ setting multcount to 16
~ setting using_dma to 1 (on)
~ setting xfermode to 68 (UltraDMA mode4)
~ multcount    = 16 (on)
~ IO_support   =  3 (32-bit w/sync)
~ using_dma    =  1 (on)
[156p] quark : ~ $ /sbin/hdparm -c3 -d1 -m16 -X66 /dev/hdd

/dev/hdd:
~ setting 32-bit IO_support flag to 3
~ setting multcount to 16
~ setting using_dma to 1 (on)
~ setting xfermode to 66 (UltraDMA mode2)
~ multcount    = 16 (on)
~ IO_support   =  3 (32-bit w/sync)
~ using_dma    =  1 (on)
[156p] quark : ~ $ hdparm -t /dev/hda

/dev/hda:
~ Timing buffered disk reads:  64 MB in  3.91 seconds = 16.37 MB/sec
[156p] quark : ~ $ hdparm -t /dev/hdd

/dev/hdd:
~ Timing buffered disk reads:  64 MB in  4.05 seconds = 15.80 MB/sec
--(quark)-(pts0)-(16:00/04-Oct-02)--
--(m3thos#:~)-- sudo hdparm -t /dev/hda

- --(quark)-(pts0)-(13:55/10-Nov-02)--
- --(m3thos#:~)-- sudo hdparm -i /dev/hda

/dev/hda:

~ Model=ST340016A, FwRev=3.05, SerialNo=3HS0403R
~ Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
~ RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
~ BuffType=unknown, BuffSize=2048kB, MaxMultSect=16, MultSect=16
~ CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=78165360
~ IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
~ PIO modes:  pio0 pio1 pio2 pio3 pio4
~ DMA modes:  mdma0 mdma1 mdma2
~ UDMA modes: udma0 udma1 *udma2
~ AdvancedPM=no WriteCache=enabled
~ Drive conforms to: device does not report version:  1 2 3 4 5

- --(quark)-(pts0)-(14:11/10-Nov-02)--
- --(m3thos#:~)-- sudo hdparm -i /dev/hdd

/dev/hdd:

~ Model=ST36421A, FwRev=8.01, SerialNo=6BE072C1
~ Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
~ RawCHS=13330/15/63, TrkSize=0, SectSize=0, ECCbytes=4
~ BuffType=unknown, BuffSize=256kB, MaxMultSect=16, MultSect=16
~ CurCHS=13330/15/63, CurSects=12596850, LBA=yes, LBAsects=12596850
~ IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
~ PIO modes:  pio0 pio1 pio2 pio3 pio4
~ DMA modes:  mdma0 mdma1 mdma2
~ UDMA modes: udma0 udma1 *udma2 udma3 udma4
~ AdvancedPM=no WriteCache=enabled
~ Drive conforms to: device does not report version:  1 2 3 4

- -(quark)-(pts0)-(14:11/10-Nov-02)--
- --(m3thos#:~)-- sudo hdparm -I /dev/hda

/dev/hda:

ATA device, with non-removable media
~        Model Number:       ST340016A
~        Serial Number:      3HS0403R
~        Firmware Revision:  3.05
Standards:
~        Supported: 5 4 3 2
~        Likely used: 6
Configuration:
~        Logical         max     current
~        cylinders       16383   16383
~        heads           16      16
~        sectors/track   63      63
~        --
~        CHS current addressable sectors:   16514064
~        LBA    user addressable sectors:   78165360
~        device size with M = 1024*1024:       38166 MBytes
~        device size with M = 1000*1000:       40020 MBytes (40 GB)
Capabilities:
~        LBA, IORDY(can be disabled)
~        bytes avail on r/w long: 4      Queue depth: 1
~        Standby timer values: spec'd by Standard
~        R/W multiple sector transfer: Max = 16  Current = 16
~        Recommended acoustic management value: 128, current value: 128
~        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5
~             Cycle time: min=120ns recommended=120ns
~        PIO: pio0 pio1 pio2 pio3 pio4
~             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
~        Enabled Supported:
~           *    READ BUFFER cmd
~           *    WRITE BUFFER cmd
~           *    Host Protected Area feature set
~           *    Look-ahead
~           *    Write cache
~           *    Power Management feature set
~                Security Mode feature set
~           *    SMART feature set
~                Device Configuration Overlay feature set
~           *    Automatic Acoustic Management feature set
~                SET MAX security extension
~           *    DOWNLOAD MICROCODE cmd
Security:
~        Master password revision code = 65534
~                supported
~        not     enabled
~        not     locked
~        not     frozen
~        not     expired: security count
~        not     supported: enhanced erase
HW reset results:
~        CBLID- below Vih
~        Device num = 1
Checksum: correct

- --(quark)-(pts0)-(14:11/10-Nov-02)--
- --(m3thos#:~)-- sudo hdparm -I /dev/hdd

/dev/hdd:

ATA device, with non-removable media
~        Model Number:       ST36421A
~        Serial Number:      6BE072C1
~        Firmware Revision:  8.01
Standards:
~        Supported: 4 3 2 1
~        Likely used: 5
Configuration:
~        Logical         max     current
~        cylinders       13330   13330
~        heads           15      15
~        sectors/track   63      63
~        --
~        CHS current addressable sectors:   12596850
~        LBA    user addressable sectors:   12596850
~        device size with M = 1024*1024:        6150 MBytes
~        device size with M = 1000*1000:        6449 MBytes (6 GB)
Capabilities:
~        LBA, IORDY(can be disabled)
~        Buffer size: 256.0kB    bytes avail on r/w long: 4      Queue
depth: 1
~        Standby timer values: spec'd by Standard
~        R/W multiple sector transfer: Max = 16  Current = 16
~        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4
~             Cycle time: min=120ns recommended=120ns
~        PIO: pio0 pio1 pio2 pio3 pio4
~             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
~        Enabled Supported:
~           *    READ BUFFER cmd
~           *    WRITE BUFFER cmd
~           *    Host Protected Area feature set
~           *    Look-ahead
~           *    Write cache
~           *    Power Management feature set
~           *    Security Mode feature set
~                SMART feature set
~           *    DOWNLOAD MICROCODE cmd
Security:
~                supported
~        not     enabled
~        not     locked
~        not     frozen
~        not     expired: security count
~        not     supported: enhanced erase
HW reset results:
~        CBLID- above Vih
~        Device num = 1



dmesg gives this:
--cut--
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7411: IDE controller on PCI bus 00 dev 39
AMD7411: chipset revision 1
AMD7411: not 100% native mode: will probe irqs later
AMD7411: disabling single-word DMA support (revision < C4)
      ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
      ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:DMA
hda: ST340016A, ATA DISK drive
hdb: TOSHIBA CD-ROM XM-6602B, ATAPI CD/DVD-ROM drive
hdc: PCRW804, ATAPI CD/DVD-ROM drive
hdd: ST36421A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, UDMA(33)
hdd: 12596850 sectors (6450 MB) w/256KiB Cache, CHS=13330/15/63, UDMA(33)
hdb: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
--cut--



Thanx in Advance,
help me out!

Miguel Sousa Filipe



--------------070308080900010204050508
Content-Type: application/gzip;
 name="config-2.4.19-vanilla.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config-2.4.19-vanilla.gz"

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

--------------070308080900010204050508--

