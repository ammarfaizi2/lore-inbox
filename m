Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbTDPQFW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbTDPQFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:05:22 -0400
Received: from 217-126-36-165.uc.nombres.ttd.es ([217.126.36.165]:54220 "EHLO
	pau.intranet.ct") by vger.kernel.org with ESMTP id S264461AbTDPQFP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:05:15 -0400
Date: Wed, 16 Apr 2003 18:15:40 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.21-pre7 + Intel 82801AA IDE + 80Gb Barracuda do not work well
 together
Message-ID: <Pine.LNX.4.44.0304161759290.4806-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm having serious trouble dealing with:
* 80Gb Seagate Barracuda disc (Model Number ST380011A, Firmware Revision 3.04)
* on an Intel 82801AA IDE controller

It does not boot neither with 2.4.21-pre7 nor with any other tested kernel
(RH-8.0 updated kernels) unless I boot with ide=nodma.
With RH kernels it stalls reading the partition table.
With 2.4.21-pre7 I get and error of the dma.

I've tried idebus=66, ide0=ata66 and some tweaks with hdparm to no 
success; each time I enabled dma the system hung.

If someone can enlighten me on how to boot with DMA enabled maybe I'd 
achieve a better performance than this (best result in several tries):
# hdparm -tT /dev/hda
/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.85 seconds =150.66 MB/sec
 Timing buffered disk reads:  64 MB in 11.53 seconds =  5.55 MB/sec

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
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
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
	DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
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
00:00.0 Host bridge: Intel Corp. 82820 820 (Camino) Chipset Host Bridge 
(MCH) (rev 04)
00:01.0 PCI bridge: Intel Corp. 82820 820 (Camino) Chipset AGP Bridge (rev 04)
00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02)
00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02)
00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02)
00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation RIVA TNT2 Model 64 (rev 15)
02:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
------------------------------------------------------------

# lsmod
Module                  Size  Used by    Not tainted
nfsd                   79920   8  (autoclean)
lockd                  58064   1  (autoclean) [nfsd]
sunrpc                 79324   1  (autoclean) [nfsd lockd]
autofs                 13348   0  (autoclean) (unused)
3c59x                  30672   1 
iptable_filter          2412   0  (autoclean) (unused)
ip_tables              15224   1  [iptable_filter]
ext3                   70336   1 
jbd                    52212   1  [ext3]
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
 UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2:  1 2 3 4 5 6
------------------------------------------------------------

# cat /proc/ide/hda/settings 
name			value		min		max		mode
----			-----		---		---		----
acoustic                0               0               254             rw
address                 1               0               2               rw
address                 1               0               2               rw
bios_cyl                9729            0               65535           rw
bios_head               255             0               255             rw
bios_sect               63              0               63              rw
breada_readahead        8               0               255             rw
bswap                   0               0               1               r
current_speed           0               0               69              rw
failures                0               0               65535           rw
file_readahead          508             0               16384           rw
ide_scsi                0               0               1               rw
init_speed              0               0               69              rw
io_32bit                3               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
max_kb_per_request      128             1               255             rw
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
And part of the boot mmessages with latest RH-8.0 updated kernel:
# uname -a
Linux fileserver 2.4.18-27.8.0 #1 Fri Mar 14 06:45:49 EST 2003 i686 i686 
i386 GNU/Linux

Booting parametres: ide=nodma idebus=66 ide0=ata66

ide: Assuming 66MHz system bus speed for PIO modes
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 2
PIIX4: not 100% native mode: will probe irqs later
PIIX4: ATA-66/100 forced bit set (WARNING)!!
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: ST380011A, ATA DISK drive
hdc: CRD-8482B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c03b26c4, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c03b26c4, I/O limit 4095Mb (mask 0xffffffff)
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2

Pau

