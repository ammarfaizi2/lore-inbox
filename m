Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbUBHRHW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 12:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbUBHRHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 12:07:22 -0500
Received: from pop.gmx.de ([213.165.64.20]:44676 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263880AbUBHRHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 12:07:04 -0500
X-Authenticated: #11437207
Date: Sun, 8 Feb 2004 19:10:40 +0100
From: Tim Blechmann <TimBlechmann@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: pcmcia-cs-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net,
       Thomas Charbonnel <thomas@undata.org>
Subject: 02 micro 6933 cardbus controller creates problem with the
 hammerfall dsp driver
Message-Id: <20040208191040.191bcd24@laptop>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

this is my first posting to the kernel list, that's why i don't know, if
i'm right here ... if not, please drop me a line and tell me who i
should ask...

i'm experiencing problems with the O2 micro 6933 card when trying to use
the hammerfall dsp sound device. i'm using the yenta socket driver (the
O2 micro 6933 should be 100% compatible to the yenta socket)

i met thomas charbonnel, who maintains the alsa driver of the hdsp, and
concerning him, it seems to be a problem of the dma mapping in the
cardbus-pci bridge ... the alsa driver is working fine, until it starts
dma (to output sounds) ... (thomas, please correct me if i'm saying
something completely stupid, i'm a musician, not a kernel hacker)


my dmesg output is:
Linux version 2.4.24-ck1 (root@laptop) (gcc version 3.2.3 20030422
(Gentoo Linux 1.4 3.2.3-r3, propolice)) #1 Sat Jan 17 15:45:42 CET 2004
BIOS-provided physical RAM map: BIOS-e820: 0000000000000000 -
000000000009f000 (usable) BIOS-e820: 000000000009f000 - 00000000000a0000
(reserved) BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fef0000 (usable)
 BIOS-e820: 000000001fef0000 - 000000001feff000 (ACPI data)
 BIOS-e820: 000000001feff000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 000000001ff00000 - 000000001ff80000 (usable)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130944
zone(0): 4096 pages.
zone(1): 126848 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda1 pci=noacpi
Initializing CPU#0
Detected 2491.964 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4967.62 BogoMIPS
Memory: 514268k/523776k available (2442k kernel code, 9056k reserved,
585k data, 116k init, 0k highmem) Dentry cache hash table entries: 65536
(order: 7, 524288 bytes) Inode cache hash table entries: 32768 (order:
6, 262144 bytes) Mount cache hash table entries: 512 (order: 0, 4096
bytes) Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After generic, caps: bfebf9ff 00000000 00000000 00000000
CPU:             Common caps: bfebf9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 2.50GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd9a0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
PCI: Using IRQ router PIIX/ICH [8086/2440] at 00:1f.0
PCI: Found IRQ 5 for device 02:00.0
PCI: Sharing IRQ 5 with 01:00.0
PCI: Found IRQ 11 for device 02:00.1
PCI: Sharing IRQ 11 with 00:1f.3
PCI: Sharing IRQ 11 with 00:1f.5
PCI: Sharing IRQ 11 with 00:1f.6
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
SGI XFS snapshot-2.4.23-2003-12-01_00:33_UTC with ACLs, realtime, no
debug enabled SGI XFS Quota Management subsystem
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.10e
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Equalizer1996: $Revision: 1.2.1 $ $Date: 1996/09/22 13:52:00 $ Simon
Janes (simon@ncm.com) Uniform Multi-Platform E-IDE driver Revision:
7.00beta4-2.4 ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 5
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1808-0x180f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK3018GAP, ATA DISK drive
blk: queue c043c3c0, I/O limit 4095Mb (mask 0xffffffff)
hdc: DW-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 58605120 sectors (30006 MB), CHS=3648/255/63, UDMA(100)
hdc: attached ide-cdrom driver.
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 1658kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
rme96xx: version 0.8 time 15:47:41 Jan 17 2004
rme96xx: reserving 1 dsp device(s)
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 5 for device 02:00.0
PCI: Sharing IRQ 5 with 01:00.0
PCI: Found IRQ 11 for device 02:00.1
PCI: Sharing IRQ 11 with 00:1f.3
PCI: Sharing IRQ 11 with 00:1f.5
PCI: Sharing IRQ 11 with 00:1f.6
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
Yenta IRQ list 0698, PCI irq5
Socket status: 30000006
Yenta IRQ list 0698, PCI irq11
Socket status: 30000820
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,1)) ...
for (ide0(3,1))
ide0(3,1):Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 116k freed
Adding Swap: 522104k swap-space (priority -1)
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,3)) ...
for (ide0(3,3))
ide0(3,3):Using r5 hash to sort names
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others PCI: Found IRQ 11 for device 02:08.0
eth0: Intel Corp. 82801BA/BAM/CA/CAM Ethernet Controller,
00:02:3F:B3:32:38, IRQ 11.  Board assembly 000000-000, Physical
connectors present: RJ45  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled PCI: Found IRQ 11 for device 00:1f.6
PCI: Sharing IRQ 11 with 00:1f.3
PCI: Sharing IRQ 11 with 00:1f.5
PCI: Sharing IRQ 11 with 02:00.1
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 5 for device 00:1f.2
PCI: Setting latency timer of device 00:1f.2 to 64
uhci.c: USB UHCI at I/O 0x1820, IRQ 5
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 11 for device 00:1f.4
PCI: Setting latency timer of device 00:1f.4 to 64
uhci.c: USB UHCI at I/O 0x1840, IRQ 11
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
inserting floppy driver for 2.4.24-ck1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RME Hammerfall-DSP: no cards found
cs: cb_alloc(bus 7): vendor 0x10ee, device 0x3fc5
PCI: Enabling device 07:00.0 (0080 -> 0082)
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:663: Hammerfall-DSP: no
Digiface or Multiface connected! ALSA
../../alsa-kernel/pci/rme9652/hdsp.c:5052: card initialization pending :
waiting for firmware ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:807: wait
for FIFO status <= 0 failed after 30 iterations ALSA
../../alsa-kernel/pci/rme9652/hdsp.c:4711: initializing firmware upload
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:678: loading firmware ALSA
../../alsa-kernel/pci/rme9652/hdsp.c:716: finished firmware loading


the lspci -vv output:
0000:00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host
Bridge (rev 04)	Subsystem: Acer Incorporated [ALI]: Unknown device 0019
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-	Latency: 0
	Region 0: Memory at ec000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

0000:00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP
Bridge (rev 04) (prog-if 00 [Normal decode])	Control: I/O+ Mem+ BusMaster+
SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-	Status: Cap-
66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
	Latency: 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: e8000000-e80fffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 05)
(prog-if 00 [Normal decode])	Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-	Status: Cap- 66Mhz- UDF-
FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-	Latency:
0	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: e8100000-e81fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-	Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05)
(prog-if 80 [Master])	Subsystem: Acer Incorporated [ALI]: Unknown device 0019
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-	Latency: 0
	Region 4: I/O ports at 1800 [size=16]

0000:00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev
05) (prog-if 00 [UHCI])	Subsystem: Acer Incorporated [ALI]: Unknown
device 0019	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-	Status: Cap- 66Mhz- UDF- FastB2B+
ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-	Latency:
0	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at 1820 [size=32]

0000:00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0019
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-	Interrupt: pin B
routed to IRQ 11	Region 4: I/O ports at 1810 [size=16]

0000:00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev
05) (prog-if 00 [UHCI])	Subsystem: Acer Incorporated [ALI]: Unknown
device 0019	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-	Status: Cap- 66Mhz- UDF- FastB2B+
ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-	Latency:
0	Interrupt: pin C routed to IRQ 11
	Region 4: I/O ports at 1840 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97
Audio (rev 05)	Subsystem: Acer Incorporated [ALI]: Unknown device 0019
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-	Interrupt: pin B
routed to IRQ 11	Region 0: I/O ports at 1c00 [size=256]
	Region 1: I/O ports at 1880 [size=64]

0000:00:1f.6 Modem: Intel Corp. Intel 537 [82801BA/BAM AC'97 Modem] (rev
05) (prog-if 00 [Generic])	Subsystem: Acer Incorporated [ALI]: Unknown
device 0019	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-	Status: Cap- 66Mhz- UDF- FastB2B+
ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Interrupt: pin B routed to IRQ 11	Region 0: I/O ports at 2400 [size=256]
	Region 1: I/O ports at 2000 [size=128]

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon
Mobility M6 LY (prog-if 00 [VGA])	Subsystem: Acer Incorporated [ALI]:
Unknown device 0019	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping+ SERR+ FastB2B+	Status: Cap+ 66Mhz+ UDF-
FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 66 (2000ns min), cache line size 08	Interrupt: pin A routed
to IRQ 5	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at e8000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

0000:02:00.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller
(rev 01)	Subsystem: Acer Incorporated [ALI]: Unknown device 0019
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-	Latency: 168
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at 20000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 20400000-207ff000 (prefetchable)
	Memory window 1: 20800000-20bff000
	I/O window 0: 00004400-000044ff
	I/O window 1: 00004800-000048ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:02:00.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller
(rev 01)	Subsystem: Acer Incorporated [ALI]: Unknown device 0019
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-	Latency: 168
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 20001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 20c00000-20fff000 (prefetchable)
	Memory window 1: 21000000-213ff000
	I/O window 0: 00004c00-00004cff
	I/O window 1: 00005000-000050ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

0000:02:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM
Ethernet Controller (rev 03)	Subsystem: Acer Incorporated [ALI]:
Unknown device 0019	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+
VGASnoop- ParErr- Stepping- SERR+ FastB2B-	Status: Cap+ 66Mhz- UDF-
FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 66 (2000ns min, 14000ns max), cache line size 08	Interrupt: pin A
routed to IRQ 11	Region 0: Memory at e8100000 (32-bit, non-prefetchable)
[size=4K]	Region 1: I/O ports at 4000 [size=64]
	Capabilities: <available only to root>

0000:07:00.0 Multimedia audio controller: Xilinx Corporation RME
Hammerfall DSP (rev 0a)	Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-	Status: Cap- 66Mhz- UDF-
FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 255	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 21000000 (32-bit, non-prefetchable) [size=64K]

if there is any system file missing, that is crucial to trace this bug,
please let me know ... anyway, i'm not a kernel hacker, but i'm willing
to test everything that a kernel guru wants me to test...

thanks for your time...

 Tim                          mailto:TimBlechmann@gmx.de
                              ICQ: 96771783
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac

