Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319044AbSHWSxk>; Fri, 23 Aug 2002 14:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319068AbSHWSxk>; Fri, 23 Aug 2002 14:53:40 -0400
Received: from mx10.airmail.net ([209.196.77.107]:16396 "EHLO mx10.airmail.net")
	by vger.kernel.org with ESMTP id <S319044AbSHWSxi>;
	Fri, 23 Aug 2002 14:53:38 -0400
Date: Fri, 23 Aug 2002 13:57:04 -0500
From: Art Haas <ahaas@neosoft.com>
To: linux-kernel@vger.kernel.org
Subject: Slower IDE performance with latest -ac kernels
Message-ID: <20020823185704.GA1128@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I'd mailed in a day or two ago a report about a problem with
the 2.4.20-pre2-ac5 kernel. In that message there I'd said
that the drives were running slower, but I had no numbers to
back that up. Now I do. I just tried out the latest -ac kernel,
and used my hdc drive to do some simple testing.

# hdparm -I /dev/hdc
/dev/hdc:

ATA device, with non-removable media
	Model Number:       FUJITSU MPD3084AT                       
	Serial Number:      05043987
	Firmware Revision:  DD-03-47
Standards:
	Supported: 4 3 2 1 
	Likely used: 4
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:   16514064
	device size with M = 1024*1024:        8063 MBytes
	device size with M = 1000*1000:        8455 MBytes (8 GB)
Capabilities:
	LBA, IORDY(cannot be disabled)
	Buffer size: 512.0kB	bytes avail on r/w long: 4	Queue depth: 1
	Standby timer values: spec'd by Vendor
	R/W multiple sector transfer: Max = 16	Current = 8
	Advanced power management level: unknown setting (0x0000)
	DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
		READ BUFFER cmd
		WRITE BUFFER cmd
		Host Protected Area feature set
	   *	Look-ahead
		Write cache
		Power Management feature set
		Security Mode feature set
	   *	SMART feature set
		Advanced Power Management feature set
Security: 
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
	24min for SECURITY ERASE UNIT. 

Using kernel 2.4.20-pre4-ac1 ...

# hdparm /dev/hdc
/dev/hdc:
 multcount    =  8 (on)
 IO_support   =  3 (32-bit w/sync)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1027/255/63, sectors = 16514064, start = 0

# cat /proc/ide/hdc/settings
name			value		min		max		mode
----			-----		---		---		----
acoustic                0               0               254             rw
address                 0               0               2               rw
bios_cyl                1027            0               65535           rw
bios_head               255             0               255             rw
bios_sect               63              0               63              rw
breada_readahead        8               0               255             rw
bswap                   0               0               1               r
current_speed           0               0               70              rw
failures                0               0               65535           rw
file_readahead          124             0               16384           rw
init_speed              0               0               70              rw
io_32bit                3               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
max_kb_per_request      128             1               255             rw
multcount               8               0               16              rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  2               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               0               0               1               rw
using_dma               0               0               1               rw
wcache                  0               0               1               rw

# hdparm -tT /dev/hdc

/dev/hdc:
 Timing buffer-cache reads:   128 MB in  2.81 seconds = 45.55 MB/sec
 Timing buffered disk reads:  64 MB in 59.40 seconds =  1.08 MB/sec


Using kernel 2.4.20-pre2-ac2 ...

# hdparm /dev/hdc
/dev/hdc:
 multcount    =  8 (on)
 IO_support   =  3 (32-bit w/sync)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1027/255/63, sectors = 16514064, start = 0

# cat /prod/ide/hdc/settings
name			value		min		max		mode
----			-----		---		---		----
acoustic                0               0               254             rw
address                 0               0               2               rw
bios_cyl                1027            0               65535           rw
bios_head               255             0               255             rw
bios_sect               63              0               63              rw
breada_readahead        8               0               255             rw
bswap                   0               0               1               r
current_speed           0               0               70              rw
failures                0               0               65535           rw
file_readahead          124             0               16384           rw
ide_scsi                0               0               1               rw
init_speed              0               0               70              rw
io_32bit                3               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
max_kb_per_request      128             1               255             rw
multcount               8               0               16              rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  2               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               0               0               1               rw
using_dma               0               0               1               rw
wcache                  0               0               1               rw

# hdparm -tT /dev/hdc

/dev/hdc:
 Timing buffer-cache reads:   128 MB in  2.89 seconds = 44.29 MB/sec
 Timing buffered disk reads:  64 MB in  7.06 seconds =  9.07 MB/sec

The disk reads are significantly faster under the older kernel, which
I'm using right now.

I tried the suggestion Andre Hedrick posted ...

# echo max_kb_per_request:256 > /proc/ide/hdc/settings

... and it made no difference. In fact, the max_kb_per_request
line didn't change at all. The value is larger than the "max"
column value, but his mail said that 255 wasn't correct. ?????

I can't use DMA on either drive on this machine, as it doesn't
work. I've never found the magic BIOS bits to see what can be
set to activate that feature, so using the 'hdparm -d1' command
won't work here. I've also been burned once using hdparm, so
I'm hesistant to try flags the man page says can cause problems,
such as the irq unmasking option '-u'.

Here's a little more info that might be useful ...

# lspci -vv

00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1531 [Aladdin IV] (rev b3)
	Subsystem: Acer Laboratories Inc. [ALi] M1531 [Aladdin IV]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32

00:02.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev b4)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 0

00:05.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01) (prog-if 00 [VGA])
	Subsystem: S3 Inc. ViRGE/DX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at ebff0000 [disabled] [size=64K]

00:0b.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 20) (prog-if fa)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 14
	Region 0: [virtual] I/O ports at 01f0
	Region 1: [virtual] I/O ports at 03f4
	Region 2: [virtual] I/O ports at 0170
	Region 3: [virtual] I/O ports at 0374
	Region 4: I/O ports at ffa0 [size=16]

Art Haas
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
