Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbTH2HSZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 03:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264462AbTH2HSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 03:18:25 -0400
Received: from 7.Red-80-37-235.pooles.rima-tde.net ([80.37.235.7]:25986 "EHLO
	pau.newtral.org") by vger.kernel.org with ESMTP id S264461AbTH2HSU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 03:18:20 -0400
Date: Fri, 29 Aug 2003 09:18:16 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
Subject: No DMA in 2.6.0test4
Message-ID: <Pine.LNX.4.44.0308290916430.2339-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm having serious trouble dealing with:
* 80Gb Seagate Barracuda disc (Model Number ST380011A, Firmware Revision 3.04)
* on an Intel 82801AA IDE controller
* 2.6.0test4

When booting, it disables DMA. With RH stock kernels it did not even boot.
It's currently running wiht latest 2.6.0test4

If someone can enlighten me on how to boot with DMA enabled maybe I'd 
achieve a better performance than this (best result in several tries):
# hdparm -tT /dev/hda
/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.79 seconds =162.46 MB/sec
 Timing buffered disk reads:  64 MB in 14.33 seconds =  4.46 MB/sec

These are the relevant parametres to me.

------------------------------------------------------------
# hdparm -I /dev/hda

/dev/hda:

ATA device, with non-removable media
	Model Number:       ST380011A                               
	Serial Number:      3JV07K8W            
	Firmware Revision:  3.04    
Standards:
	Used: ATA/ATAPI-6 T13 1410D revision 2 
	Supported: 6 5 4 3 
Configuration:
	Logical		max	current
	cylinders	16383	65535
	heads		16	1
	sectors/track	63	63
	--
	CHS current addressable sectors:    4128705
	LBA    user addressable sectors:  156301488
	LBA48  user addressable sectors:  156301488
	device size with M = 1024*1024:       76319 MBytes
	device size with M = 1000*1000:       80026 MBytes (80 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	bytes avail on r/w long: 4	Queue depth: 1
	Standby timer values: spec'd by Standard
	R/W multiple sector transfer: Max = 16	Current = 16
	Recommended acoustic management value: 128, current value: 0
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 udma5 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	FLUSH CACHE EXT command
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
	   *	48-bit Address feature set 
		SET MAX security extension
	   *	DOWNLOAD MICROCODE cmd
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
HW reset results:
	CBLID- above Vih
	Device num = 0 determined by the jumper
Checksum: correct
------------------------------------------------------------

# lspci
00:00.0 Host bridge: Intel Corp. 82820 820 (Camino) Chipset Host Bridge (MCH) (rev 04)
00:01.0 PCI bridge: Intel Corp. 82820 820 (Camino) Chipset AGP Bridge (rev 04)
00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02)
00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02)
00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02)
00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation RIVA TNT2 Model 64 
(rev 15)02:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M 
[Tornado] (rev 78)
 ------------------------------------------------------------

# lsmod
Module                  Size  Used by
nfsd                  164160  8 
exportfs                6528  1 nfsd
lockd                  65008  2 nfsd
sunrpc                133188  2 nfsd,lockd
iptable_filter          2944  0 
ip_tables              18576  1 iptable_filter
autofs                 16128  0 
3c59x                  34600  0 

------------------------------------------------------------

# hdparm -i /dev/hda

/dev/hda:

 Model=ST380011A, FwRev=3.04, SerialNo=3JV07K8W
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=156301488
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 *udma4 udma5 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2:  1 2 3 4 5 6
------------------------------------------------------------

# cat /proc/ide/hda/settings 
name			value		min		max		mode
----			-----		---		---		----
acoustic                0               0               254             rw
address                 1               0               2               rw
bios_cyl                16383           0               65535           rw
bios_head               255             0               255             rw
bios_sect               63              0               63              rw
bswap                   0               0               1               r
current_speed           68              0               70              rw
failures                0               0               65535           rw
init_speed              68              0               70              rw
io_32bit                3               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
multcount               16              0               16              rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  0               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               1               0               1               rw
using_dma               0               0               1               rw
wcache                  0               0               1               rw

------------------------------------------------------------
And part of the boot messages:
# uname -a
Linux fileserver 2.6.0-test4 #4 Mon Aug 25 16:09:30 CEST 2003 i686 i686 i386 GNU/Linux

ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
ICH: IDE controller at PCI slot 0000:00:1f.1
ICH: chipset revision 2
ICH: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: ST380011A, ATA DISK drive
PM: Adding info for No Bus:ide0
Using anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
hdc: CRD-8482B, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide1
hdc: Disabling (U)DMA for CRD-8482B
ide1 at 0x170-0x177,0x376 on irq 15
PM: Adding info for ide:1.0
hda: max request size: 1024KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63, 
UDMA(66)
 hda:<4>hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest 
}

 hda1 hda2
hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest 
}



Pau


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

