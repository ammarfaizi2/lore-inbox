Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751706AbWDCLf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbWDCLf2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 07:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751720AbWDCLf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 07:35:28 -0400
Received: from aun.it.uu.se ([130.238.12.36]:38568 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751706AbWDCLf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 07:35:27 -0400
Date: Mon, 3 Apr 2006 13:35:01 +0200 (MEST)
Message-Id: <200604031135.k33BZ10b028599@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: [RESEND][2.6.15] New ATA error messages on upgrade to 2.6.15
Cc: edmudama@gmail.com, hahn@physics.mcmaster.ca, hancockr@shaw.ca,
       jujutama@comcast.net, linux-kernel@vger.kernel.org, mrmacman_g4@mac.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2006 10:29:36 +0100, Alan Cox wrote:
> On Llu, 2006-04-03 at 11:07 +0200, Mikael Pettersson wrote:
> > 20269 PCI controller card. The 20269+cable+disk does udma5
> > just fine in a PC, but throws a few BadCRCs at bootup on
> > the PowerMac, resets and drops to udma4, and then things work
> > OK for me, but I don't stress it very much (no RAID).
> 
> Interesting. 
> 
> > Since the card's bios doesn't get run at powerup, I always
> > suspected that the driver fails to initialize some timing thing.
> 
> The BIOS does various bits of PCI bus setup on some systems including
> latency setting. That might be relevant, especially latency to get
> bursting.
> 
> > Another possibility is the "data coherency" issue in some
> > G4 CPUs which requires mappings of memory shared with other
> > agents to use some additional magic in the page table.
> 
> 
> The CRC is computed between the controller as the bits get fired over
> the cable and drive so it shouldn't be caused by any weird bus timings.
> 
> More info would be useful although it may be a while before I can look
> at it

Here's the bootup dmesg log, hdparm -i /dev/hde, and lspci -vvvx output
for the machine in question. Let me know if you need anything else.

/Mikael

Total memory = 768MB; using 2048kB for hash table (at cfe00000)
Linux version 2.6.16 (mikpe@eisbock) (gcc version 4.1.0) #1 Mon Mar 20 11:41:36 CET 2006
Found a Heathrow mac-io controller, rev: 1, mapped at 0xfdf80000
PowerMac motherboard: PowerMac G3 (Gossamer)
Found Grackle (MPC106) PCI host bridge at 0x80000000. Firmware bus number: 0->0
nvram: OF partition at 0x1800
nvram: XP partition at 0x1300
nvram: NR partition at 0x1400
Top of RAM: 0x30000000, Total RAM: 0x30000000
Memory hole size: 0MB
On node 0 totalpages: 196608
  DMA zone: 196608 pages, LIFO batch:31
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
Built 1 zonelists
Kernel command line: root=/dev/hde5
irq: Found primary Apple PIC /pci/mac-io for 64 irqs
irq: System has 64 possible interrupts
PID hash table entries: 4096 (order: 12, 65536 bytes)
GMT Delta read from XPRAM: 60 minutes, DST: off
time_init: decrementer frequency = 16.708516 MHz
time_init: processor frequency   = 66.820000 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 771840k/786432k available (1960k kernel code, 14340k reserved, 224k data, 94k bss, 152k init)
Calibrating delay loop... 33.38 BogoMIPS (lpj=166912)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 2 of device 0000:00:12.0
PCI: Cannot allocate resource region 1 of device 0000:00:12.0
PCI: Enabling device 0000:00:0d.0 (0116 -> 0117)
PCI: Enabling device 0000:00:0e.0 (0004 -> 0007)
Registering pmac pic with sysfs...
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
PCI: Enabling device 0000:00:12.0 (0086 -> 0087)
atyfb: using auxiliary register aperture
atyfb: 3D RAGE II+ (Mach64 GT) [0x4754 rev 0x9a]
atyfb: 2M SGRAM (1:1), 14.31818 MHz XTAL, 200 MHz PLL, 67 Mhz MCLK, 67 MHz XCLK
atyfb: monitor sense=73f, mode 6
Console: switching to colour frame buffer device 80x30
atyfb: fb0: ATY Mach64 frame buffer device on PCI
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
fd0: SWIM3 floppy controller 
MacIO PCI driver attached to Heathrow chipset
input: Macintosh mouse button emulation as /class/input/input0
Macintosh CUDA driver v0.5 for Unified ADB.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20269: IDE controller at PCI slot 0000:00:0e.0
PDC20269: chipset revision 2
PDC20269: ROM enabled at 0x81804000
PDC20269: 100% native mode on irq 24
    ide2: BM-DMA at 0x0880-0x0887, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x0888-0x088f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
adb: starting probe task...
adb devices: [2]: 2 5 [3]: 3 1
ADB keyboard at 2, handler set to 3
Detected ADB keyboard, type ISO, swapping keys.
input: ADB keyboard as /class/input/input1
ADB mouse at 3, handler set to 2
input: ADB mouse as /class/input/input2
adb: finished probe task...
hde: IBM-DTLA-307030, ATA DISK drive
ide2 at 0x8c0-0x8c7,0x8b2 on irq 24
Probing IDE interface ide3...
ide0: Found Apple Heathrow ATA controller, bus ID 0, irq 13
Probing IDE interface ide0...
hda: MATSHITA CR-585, ATAPI CD/DVD-ROM drive
hda: Enabling MultiWord DMA 1
ide0 at 0xf1008000-0xf1008007,0xf1008160 on irq 13
ide1: Found Apple Heathrow ATA controller, bus ID 1, irq 14
Probing IDE interface ide1...
hde: max request size: 128KiB
hde: 60036480 sectors (30738 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
hde: cache flushes not supported
 hde:hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
PDC202XX: Primary channel reset.
ide2: reset: success
 hde1 hde2 hde3 hde4 < hde5 hde6 hde7 >
sym0: <875> rev 0x4 at pci 0000:00:0d.0 irq 23
sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.2.2
  Vendor: IBM       Model: DDRS-34560W       Rev: S71D
  Type:   Direct-Access                      ANSI SCSI revision: 02
 target0:0:0: tagged command queuing enabled, command queue depth 16.
 target0:0:0: Beginning Domain Validation
 target0:0:0: asynchronous
 target0:0:0: wide asynchronous
 target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 15)
 target0:0:0: Domain Validation skipping write tests
 target0:0:0: Ending Domain Validation
SCSI device sda: 8925000 512-byte hdwr sectors (4570 MB)
sda: Write Protect is off
sda: Mode Sense: e5 00 00 08
SCSI device sda: drive cache: write back
SCSI device sda: 8925000 512-byte hdwr sectors (4570 MB)
sda: Write Protect is off
sda: Mode Sense: e5 00 00 08
SCSI device sda: drive cache: write back
 sda: [mac] sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8 sda9
sd 0:0:0:0: Attached scsi disk sda
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 152k init
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Enabling device 0000:00:0f.0 (0014 -> 0017)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media 10baseT (#0) described by a 21142 Serial PHY (2) block.
tulip0:  Index #1 - Media 10baseT-FDX (#4) described by a 21142 Serial PHY (2) block.
tulip0:  Index #2 - Media 100baseTx (#3) described by a 21143 SYM PHY (4) block.
tulip0:  Index #3 - Media 100baseTx-FDX (#5) described by a 21143 SYM PHY (4) block.
tulip0:  Index #4 - Media 100baseTx (#3) described by a 21143 reset method (5) block.
eth0: Digital DS21143 Tulip rev 48 at fd731800, 00:00:C5:50:F9:51, IRQ 25.
EXT3 FS on hde5, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1048816k swap on /dev/hde2.  Priority:-1 extents:1 across:1048816k
NET: Registered protocol family 17

/dev/hde:

 Model=IBM-DTLA-307030, FwRev=TX4OA6AA, SerialNo=YKEYKTTY645
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=60036480
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 *udma4 udma5 
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1: 

 * signifies the current active mode

00:00.0 Host bridge: Motorola MPC106 [Grackle] (rev 40)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort+ <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0, Cache Line Size 08
00: 57 10 02 00 06 00 80 28 40 00 00 06 08 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0d.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 255 (4250ns min, 16000ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 23
	Region 0: I/O ports at fe000400 [size=256]
	Region 1: Memory at 0000000081801000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at 0000000081802000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 0000000081880000 [disabled] [size=256K]
00: 00 10 0f 00 17 01 00 02 04 00 00 01 08 ff 00 00
10: 01 04 00 00 00 10 80 81 00 20 80 81 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 88 81 00 00 00 00 00 00 00 00 17 01 11 40

00:0e.0 Unknown mass storage controller: Promise Technology, Inc. 20269 (rev 02) (prog-if 85)
	Subsystem: Promise Technology, Inc. Ultra133TX2
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 4500ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 24
	Region 0: I/O ports at fe0008c0 [size=8]
	Region 1: I/O ports at fe0008b0 [size=4]
	Region 2: I/O ports at fe0008a0 [size=8]
	Region 3: I/O ports at fe000890 [size=4]
	Region 4: I/O ports at fe000880 [size=16]
	Region 5: Memory at 0000000081808000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at 0000000081804000 [size=16K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 5a 10 69 4d 07 00 30 04 02 85 80 01 08 20 00 00
10: c1 08 00 00 b1 08 00 00 a1 08 00 00 91 08 00 00
20: 81 08 00 00 00 80 80 81 00 00 00 00 5a 10 68 4d
30: 01 40 80 81 60 00 00 00 00 00 00 00 18 01 04 12

00:0f.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 30)
	Subsystem: Standard Microsystems Corp [SMC]: Unknown device 2401
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5000ns min, 10000ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 25
	Region 0: I/O ports at fe000800 [size=128]
	Region 1: Memory at 0000000081800000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 0000000081840000 [disabled] [size=256K]
00: 11 10 19 00 17 00 80 02 30 00 00 02 08 20 00 00
10: 01 08 00 00 00 00 80 81 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 07 00 00 00 b8 10 01 24
30: 00 00 84 81 00 00 00 00 00 00 00 00 19 01 14 28

00:10.0 Class ff00: Apple Computer Inc. Heathrow Mac I/O (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size 08
	Region 0: Memory at 00000000f3000000 (32-bit, non-prefetchable) [size=512K]
00: 6b 10 10 00 16 00 00 02 01 00 00 ff 08 20 00 00
10: 00 00 00 f3 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:12.0 VGA compatible controller: ATI Technologies Inc 3D Rage I/II 215GT [Mach64 GT] (rev 9a) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), Cache Line Size 08
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at 0000000082000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at fe001000 [size=256]
	Region 2: Memory at 0000000080000000 (32-bit, non-prefetchable) [size=4K]
00: 02 10 54 47 87 00 80 02 9a 00 00 03 08 20 00 00
10: 00 00 00 82 01 10 00 00 00 00 00 80 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 16 01 08 00

