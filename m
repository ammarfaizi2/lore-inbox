Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289876AbSA2UkN>; Tue, 29 Jan 2002 15:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289872AbSA2UkJ>; Tue, 29 Jan 2002 15:40:09 -0500
Received: from [212.84.215.194] ([212.84.215.194]:50699 "EHLO reactor.hyte.de")
	by vger.kernel.org with ESMTP id <S289871AbSA2Ujv>;
	Tue, 29 Jan 2002 15:39:51 -0500
Date: Tue, 29 Jan 2002 20:40:03 +0100 (CET)
From: Joachim Steiger <roh@hyte.de>
To: linux-sound@vger.kernel.org
cc: linux-kernel@vger.kernel.org, paulus@au.ibm.com, mj@suse.cz
Subject: ibm notebook RS/6000 860 sound/vga/trackpoint problems
Message-ID: <Pine.LNX.4.21.0201291944130.13563-100000@reactor.hyte.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
i hope somebody can give me an advice how to fix my sound support
this is a ppc based prep machine with some pc and some ppc-ingredients
i get this messages while playing sound:

Sound: DMA (output) timed out - IRQ/DRQ config error?
the sound is skipping and choking and it plays 'too fast'
i also tested other samplerates, but without luck.

i configured the modules from the printout i recieved via enabling the
printout of prep-residential information at boot time via editing
kernelsource:

ISA Device, Slot 0, LogicalDev 0: IBM000E, MultimediaController,
AudioController, GeneralAudio
  Packets describing allocated resources:                                           
IRQ Mask 0x0400, high edge sensitive
    Variable (16 decoded bits) I/O port
      from 0x0830 to 0x0830, alignment 1, 4 ports
    DMA channel mask 0x40, info 0x52
    DMA channel mask 0x80, info 0x52
  No packets describing possible resources.
  No packets describing compatible resources.

module-load-message:
ad1848/cs4248 codec driver Copyright (C) by Hannu Savolainen 1993-1996
<Crystal audio controller (CS4231A)> at 0x830 irq 10 dma 6,7

im using the module cs4232 from 2.4.7-pre6 from bitkeeper-tree
i load the module with this parameters:
cs4232 io=0x830 irq=10 dma=6 dma2=7
with other settings loading it fails

the mixer works somehow... but i only could test it with line-in andand
the build-in microphone.

i've done some little modifications for enabling isa on ppc (it is
disabled for ppc wrongly? by default) to get pcmcia working for my
wireless lan card and it now works like a charm. i used complete
pcmcia_utils for this since i can't get the kernel-pcmcia to work
i also filed in the correct values for io,irq and dma in prep_setup.c for
my soundchip but it didn't help

i get hard lockups when using the trackpoint while accessing the
harddisc... could this also be a irq-problem? i have no lockups when
disabling gpm and just using the keyboard.
when this happens the harddisk cannot be accessed any more somehow and i
have to cold-reboot.
console-switching is also not possible in this case and sysrq-kes don't
work in this case... they do fine else.

the textconsole has also some kind of endian-problem:
all text written to a virtual console which is not the currently active
one is written endian-swapped (looks funny)

i also modified a define in prep_pci.c:
#define CAROLINA_IRQ_EDGE_MASK_LO   0x00  /* IRQ's 0-7  */
//#define CAROLINA_IRQ_EDGE_MASK_HI   0xA4  /* IRQ's 8-15 [10,13,15] */
#define CAROLINA_IRQ_EDGE_MASK_HI   0xA0  /* IRQ's 8-15 [10,13,15] */
i found this information in documentation for similar rs6k-machines but i
don't know if this affected something.

since i can only boot one kernel (for prep it is dd'ing a special headered
kernel on a partition with type 0x41 on the harddisk) i have to test all
this things with care.

but somehow this thingie is a nice playground since is isn't fully
supported yet :) (only aix is capable of running elsewere imho)
but it seems linux is the only os able to use wavelan-pcmcia cards on this
hardware

regards,
	roh

ps: if somebody needs more informations, just mail me.

=====
dmesg:

peed 33333000 Hz, 0 slot(s)
    Bridge address translation, positive decoding:
      Processor  Bus        Size       Conversion Translation
      0xc0000000 0x00000000 0x3f000000 Bus Memory direct
    Bridge address translation, positive decoding:
      Processor  Bus        Size       Conversion Translation
      0x80000000 0x00000000 0x00010000 Bus I/O direct
    Bridge address translation, positive decoding:
      Processor  Bus        Size       Conversion Translation
      0x81000000 0x01000000 0x3e800000 Bus I/O direct
    Bridge address translation, positive decoding:
      Processor  Bus        Size       Conversion Translation
      0x00000000 0x80000000 0x80000000 DMA direct
  No packets describing possible resources.
  No packets describing compatible resources.
PCI Device, Bus 0, DevFunc 0x58: PNP0A00, BridgeController, ISABridge, GeneralISABridge
  Packets describing allocated resources:
    Chip identification: IBM8100
    Fixed (10 decoded bits) I/O port from 398 to 399
    Variable (16 decoded bits) I/O port
      from 0x0800 to 0x0800, alignment 1, 48 ports
    Variable (16 decoded bits) I/O port
      from 0x0834 to 0x0834, alignment 1, 76 ports
    Variable (16 decoded bits) I/O port
      from 0x0880 to 0x0880, alignment 1, 128 ports
    Variable (16 decoded bits) I/O port
      from 0x0066 to 0x0066, alignment 1, 2 ports
    Variable (16 decoded bits) I/O port
      from 0x0078 to 0x0078, alignment 1, 5 ports
    Variable (16 decoded bits) I/O port
      from 0x0d00 to 0x0d00, alignment 1, 2 ports
    Variable (16 decoded bits) I/O port
      from 0x00b2 to 0x00b2, alignment 1, 2 ports
    Bus speed 8333250 Hz, 0 slot(s)
    Bridge address translation, subtractive decoding:
      Processor  Bus        Size       Conversion Translation
      0xc0000000 0x00000000 0x01000000 Bus Memory direct
    Bridge address translation, subtractive decoding:
      Processor  Bus        Size       Conversion Translation
      0x80000000 0x00000000 0x00010000 Bus I/O direct
    ISA interrupts routed to 8259
      lines 0(IRQ0) 1(IRQ1) 2(IRQ2) 3(IRQ3) 4(IRQ4) 5(IRQ5) 6(IRQ6) 7(IRQ7) 8(IRQ8) 9(IRQ9) 10(IRQ10) 11(IRQ11) 12(IRQ12) 13(IRQ13) 14(IRQ14) 15(IRQ15)
  No packets describing possible resources.
  No packets describing compatible resources.
ISA Device, Slot 0, LogicalDev 0: PNP0E00, BridgeController, PCMCIABridge, GeneralPCMCIABridge
  Packets describing allocated resources:
    Variable (16 decoded bits) I/O port
      from 0x03e0 to 0x03e0, alignment 1, 2 ports
    Variable (16 decoded bits) I/O port
      from 0x08ac to 0x08ac, alignment 1, 2 ports
    Bus speed 8333250 Hz, 2 slot(s)
  Packets describing possible resources:
    IRQ Mask 0x42b8, high edge sensitive
    IRQ Mask 0x42b8, high edge sensitive
    IRQ Mask 0x42b8, high edge sensitive
  No packets describing compatible resources.
ISA Device, Slot 0, LogicalDev 0: IBM000E, MultimediaController, AudioController, GeneralAudio
  Packets describing allocated resources:
    IRQ Mask 0x0400, high edge sensitive
    Variable (16 decoded bits) I/O port
      from 0x0830 to 0x0830, alignment 1, 4 ports
    DMA channel mask 0x40, info 0x52
    DMA channel mask 0x80, info 0x52
  No packets describing possible resources.
  No packets describing compatible resources.
ISA Device, Slot 0, LogicalDev 0: PNP0700, MassStorageDevice, FloppyController, NS398_Floppy
  Packets describing allocated resources:
    IRQ Mask 0x0040, high edge sensitive
    Fixed (10 decoded bits) I/O port from 3f0 to 3f5
    Fixed (10 decoded bits) I/O port from 3f7 to 3f7
    DMA channel mask 0x04, info 0x68
    Large vendor item type 0x01
      Data (hex): 01 05 00 05
  No packets describing possible resources.
  No packets describing compatible resources.
ISA Device, Slot 0, LogicalDev 0: IBM001C, CommunicationsDevice, ATCompatibleParallelPort, NS398ParPort
  Packets describing allocated resources:
    IRQ Mask 0x0080, high edge sensitive
    Fixed (10 decoded bits) I/O port from 3bc to 3be
  Packets describing possible resources:
    DMA channel mask 0x2b, info 0x68
Start dependent function:
    IRQ Mask 0x0080, high edge sensitive
    Fixed (10 decoded bits) I/O port from 3bc to 3be
Start dependent function:
    IRQ Mask 0x0080, high edge sensitive
    Fixed (10 decoded bits) I/O port from 378 to 37f
Start dependent function:
    IRQ Mask 0x0020, high edge sensitive
    Fixed (10 decoded bits) I/O port from 378 to 37f
Start dependent function:
    IRQ Mask 0x0020, high edge sensitive
    Fixed (10 decoded bits) I/O port from 278 to 27f
End dependent function
  Packets describing compatible resources:
    Type 0x2.2x28, size=5
PCI Device, Bus 0, DevFunc 0x60: IBM000F, MassStorageDevice, SCSIController, GeneralSCSI
  Packets describing allocated resources:
    SCSI buses: 1, id(s): 7
  No packets describing possible resources.
  No packets describing compatible resources.
ISA Device, Slot 0, LogicalDev 0: PNP0501, CommunicationsDevice, RS232Device, NS398SerPort
  Packets describing allocated resources:
    IRQ Mask 0x0010, high edge sensitive
    Fixed (10 decoded bits) I/O port from 3f8 to 3ff
  Packets describing possible resources:
Start dependent function:
    IRQ Mask 0x0010, high edge sensitive
    Fixed (10 decoded bits) I/O port from 3f8 to 3ff
Start dependent function:
    IRQ Mask 0x0008, high edge sensitive
    Fixed (10 decoded bits) I/O port from 2f8 to 2ff
Start dependent function:
    IRQ Mask 0x0010, high edge sensitive
    Fixed (10 decoded bits) I/O port from 220 to 227
Start dependent function:
    IRQ Mask 0x0010, high edge sensitive
    Fixed (10 decoded bits) I/O port from 2e8 to 2ef
Start dependent function:
    IRQ Mask 0x0010, high edge sensitive
    Fixed (10 decoded bits) I/O port from 338 to 33f
Start dependent function:
    IRQ Mask 0x0010, high edge sensitive
    Fixed (10 decoded bits) I/O port from 3e8 to 3ef
Start dependent function:
    IRQ Mask 0x0008, high edge sensitive
    Fixed (10 decoded bits) I/O port from 2e8 to 2ef
Start dependent function:
    IRQ Mask 0x0008, high edge sensitive
    Fixed (10 decoded bits) I/O port from 238 to 23f
Start dependent function:
    IRQ Mask 0x0008, high edge sensitive
    Fixed (10 decoded bits) I/O port from 2e0 to 2e7
Start dependent function:
    IRQ Mask 0x0008, high edge sensitive
    Fixed (10 decoded bits) I/O port from 228 to 22f
End dependent function
  No packets describing compatible resources.
ISA Device, Slot 0, LogicalDev 0: PNP0100, SystemPeripheral, SystemTimer, ISA_Timer
  Packets describing allocated resources:
    IRQ Mask 0x0001, high edge sensitive
    Variable (16 decoded bits) I/O port
      from 0x0040 to 0x0040, alignment 1, 4 ports
    Variable (16 decoded bits) I/O port
      from 0x0061 to 0x0061, alignment 1, 1 ports
    Chip identification: IBM8F10
  No packets describing possible resources.
  No packets describing compatible resources.
ISA Device, Slot 0, LogicalDev 0: PNP0303, InputDevice, KeyboardController, interface 0
  Packets describing allocated resources:
    IRQ Mask 0x0002, high edge sensitive
    Variable (16 decoded bits) I/O port
      from 0x0060 to 0x0060, alignment 1, 1 ports
    Variable (16 decoded bits) I/O port
      from 0x0064 to 0x0064, alignment 1, 1 ports
  No packets describing possible resources.
  No packets describing compatible resources.
ISA Device, Slot 0, LogicalDev 0: PNP0F03, InputDevice, MouseController, interface 0
  Packets describing allocated resources:
    IRQ Mask 0x1000, high edge sensitive
    Variable (16 decoded bits) I/O port
      from 0x0060 to 0x0060, alignment 1, 1 ports
    Variable (16 decoded bits) I/O port
      from 0x0064 to 0x0064, alignment 1, 1 ports
  No packets describing possible resources.
  No packets describing compatible resources.
PCI Device, Bus 0, DevFunc 0x70: PNP0909, DisplayController, SVGAController, GeneralSVGA
  Packets describing allocated resources:
    IRQ Mask 0x8000, low level sensitive
    I/O address (32 bits), at 0x3b4 size 0x2 bytes
    I/O address (32 bits), at 0x3ba size 0x1 bytes
    I/O address (32 bits), at 0x3c0 size 0xb bytes
    I/O address (32 bits), at 0x3cc size 0x1 bytes
    I/O address (32 bits), at 0x3ce size 0x2 bytes
    I/O address (32 bits), at 0x3d4 size 0x2 bytes
    I/O address (32 bits), at 0x3da size 0x1 bytes
    I/O address (32 bits), at 0x42e8 size 0x2 bytes
    I/O address (32 bits), at 0x4ae8 size 0x2 bytes
    I/O address (32 bits), at 0x82e8 size 0x2 bytes
    I/O address (32 bits), at 0x86e8 size 0x2 bytes
    I/O address (32 bits), at 0x8ae8 size 0x2 bytes
    I/O address (32 bits), at 0x8ee8 size 0x2 bytes
    I/O address (32 bits), at 0x92e8 size 0x2 bytes
    I/O address (32 bits), at 0x96e8 size 0x2 bytes
    I/O address (32 bits), at 0x9ae8 size 0x2 bytes
    I/O address (32 bits), at 0x9ee8 size 0x2 bytes
    I/O address (32 bits), at 0xa2e8 size 0x4 bytes
    I/O address (32 bits), at 0xa6e8 size 0x4 bytes
    I/O address (32 bits), at 0xaae8 size 0x4 bytes
    I/O address (32 bits), at 0xaee8 size 0x4 bytes
    I/O address (32 bits), at 0xb2e8 size 0x4 bytes
    I/O address (32 bits), at 0xb6e8 size 0x2 bytes
    I/O address (32 bits), at 0xbae8 size 0x2 bytes
    I/O address (32 bits), at 0xbee8 size 0x2 bytes
    I/O address (32 bits), at 0xe2e8 size 0x4 bytes
    Memory address (32 bits), at 0x4000000 size 0x200000 bytes
    Large vendor item type 0x04
      Data (hex): 01 fa 00 04 00 03 00 04 00 00 00 c4 00 00 00 00 00 00 20 00 00 00 00 00
  No packets describing possible resources.
  No packets describing compatible resources.
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sda5
time_init: decrementer frequency = 16.665500 MHz
Console: colour VGA+ 80x25
Calibrating delay loop... 111.00 BogoMIPS
Memory: 61372k available (1964k kernel code, 788k data, 252k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
IBM ID: 000000ff
Setting PCI interrupts for a "IBM 850/860 Portable"
Relocating PCI address 20000000 -> 1000000
PCI: Cannot allocate resource region 0 of PCI bridge 0
  got res[c0000000:c00000ff] for resource 1 of Symbios Logic Inc. (formerly NCR) 53c810
  got res[c4000000:c7ffffff] for resource 0 of S3 Inc. 86cM65 [Aurora64V+]
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
devfs: v0.106 (20010617) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
udf: registering filesystem
parport0: PC-style at 0x3bc [PCSPP(,...)]
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-algo-bit.o: i2c bit algorithm module
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
lp0: using parport0 (polling).
lp0: console ready
block: queued sectors max/low 40658kB/13552kB, 128 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
CSLIP: code copyright 1989 Regents of the University of California.
SLIP linefill/keepalive option.
loop: loaded (max 8 devices)
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
Registered PPPoX v0.5
Registered PPPoE v0.6.5
SCSI subsystem driver Revision: 1.00
PCI: Enabling device 00:0c.0 (0000 -> 0003)
ncr53c8xx: at PCI bus 0, device 12, function 0
ncr53c8xx: setting PCI_COMMAND_MASTER...(fix-up)
ncr53c8xx: 53c810 detected 
ncr53c810-0: rev 0x2 on pci bus 0 device 12 function 0 irq 13
ncr53c810-0: ID 7, Fast-10, Parity Checking
scsi0 : ncr53c8xx-3.4.3b-20010512
  Vendor: IBM       Model: CDRM00204     !G  Rev: 1.0F
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: IBM       Model: DPRS-21215    !   Rev: S80A
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
ncr53c810-0-<6,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 8)
SCSI device sda: 2376864 512-byte hdwr sectors (1217 MB)
Partition check:
 /dev/scsi/host0/bus0/target6/lun0: p1 p2 p3 < p5 p6 p7 p8 >
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
ncr53c810-0-<3,*>: FAST-5 SCSI 4.0 MB/s (250 ns, offset 8)
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
Macintosh non-volatile memory driver v1.0
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 252k init 20k pmac 4k chrp 4k openfirmware
Adding Swap: 124864k swap-space (priority -1)
ad1848/cs4248 codec driver Copyright (C) by Hannu Savolainen 1993-1996
<Crystal audio controller (CS4231A)> at 0x830 irq 10 dma 6,7
Linux PCMCIA Card Services 3.1.27
  kernel build: 2.4.7-pre6 #23 Tue Jul 17 01:20:17 CEST 2001
  options:  [pci]
Intel PCIC probe: 
  Intel i82365sl B step rev 00 ISA-to-PCMCIA at port 0x3e0 ofs 0x00
    host opts [0]: none
    host opts [1]: none
    PCI irq 15 seems to be wedged!
    PCI irq 9 seems to be wedged!
    PCI irq 11 seems to be wedged!
    PCI irq 14 seems to be wedged!
    ISA irqs (scanned) = 3,4,5,7 polling interval = 1000 ms
cs: memory probe 0x0d0000-0x0dffff: clean.
wvlan_cs: WaveLAN/IEEE PCMCIA driver v1.0.6
wvlan_cs: (c) Andreas Neuhaus <andy@fasta.fh-dortmund.de>
cs: IO port probe 0x0100-0x04ff: excluding 0x398-0x39f 0x3c0-0x3e7 0x3f0-0x3ff 0x408-0x40f 0x418-0x43f 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x03a0-0x03bf: clean.
cs: IO port probe 0x03e8-0x03ef: clean.
cs: IO port probe 0x0400-0x0407: clean.
cs: IO port probe 0x0410-0x0417: clean.
cs: IO port probe 0x0440-0x047f: clean.
cs: IO port probe 0x0490-0x04cf: clean.
cs: IO port probe 0x04d8-0x04ff: clean.
cs: IO port probe 0x0800-0x08ff: excluding 0x808-0x80f 0x838-0x83f 0x880-0x88f 0x8a0-0x8af
cs: IO port probe 0x0810-0x0837: clean.
cs: IO port probe 0x0840-0x087f: clean.
cs: IO port probe 0x0890-0x089f: clean.
cs: IO port probe 0x08b0-0x08ff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
cs: IO port probe 0x0c00-0x0cff: excluding 0xcf8-0xcff
wvlan_cs: index 0x01: Vcc 5.0, irq 3, io 0x0100-0x013f
wvlan_cs: Registered netdevice eth0
wvlan_cs: MAC address on eth0 is 00 02 2d 02 91 73 
wvlan_cs: Found firmware 0x70034 (vendor 1) - Firmware capabilities : 1-2-1-1-1
wvlan_cs: MAC address on eth0 is 00 02 2d 02 91 73 
wvlan_cs: Found firmware 0x70034 (vendor 1) - Firmware capabilities : 1-2-1-1-1
eth0: no IPv6 routers present
Sound: DMA (output) timed out - IRQ/DRQ config error?
Sound: DMA (output) timed out - IRQ/DRQ config error?

-----
lspci -v -v -v

00:00.0 Host bridge: Motorola MPC105 [Eagle] (rev 24)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0

00:0b.0 Non-VGA unclassified device: Intel Corp. 82378IB [SIO ISA Bridge] (rev 43)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:0c.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c810 (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Interrupt: pin A routed to IRQ 13
	Region 0: I/O ports at 1000000 [size=256]
	Region 1: [virtual] Memory at c0000000 (32-bit, non-prefetchable) [size=256]

00:0e.0 VGA compatible controller: S3 Inc. 86cM65 [Aurora64V+] (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at c4000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at c00c0000 [disabled] [size=64K]

00:0f.0 Class ff80: IBM: Unknown device 001c (rev 02)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: I/O ports at 4100 [disabled] [size=4]


