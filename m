Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263847AbUFNUEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbUFNUEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 16:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbUFNUEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 16:04:44 -0400
Received: from babbage.uvt.nl ([137.56.247.14]:38497 "EHLO babbage.uvt.nl")
	by vger.kernel.org with ESMTP id S263847AbUFNUEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 16:04:35 -0400
Message-Id: <200406142004.i5EK4N9E014550@babbage.uvt.nl>
From: "Koen Klaassen" <K.B.Klaassen@uvt.nl>
To: <linux-kernel@vger.kernel.org>
Subject: no mtrr for main memory on AMD 6-2 cxt
Date: Mon, 14 Jun 2004 22:04:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRSSamYGcPeBEitTGCY4AWyJu692Q==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Spam-Flag: No
X-Spam-Cookie: 2a67631ee8fac5616cea59b05121209f4eb17279
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
I am running a 2.4.26 kernel on a AMD k6-2 model 8 stepping 12 on a Via MVP3
chipset, with 64mb memory. The problem is that even though the AMD mtrr
initializes, no entries for main memory show up in /proc/mtrr. Dmesg,
/proc/cpuinfo and /proc/mtrr are provided below.
 
When I run X, it creates (two) write combining mtrrs just fine. Using bash I
can delete these registers, and create them anew, but I cannot create any
write-back mtrr for main memory. Judging from all mtrr posts this main
memory mtrr is something one wants to have. I know there's only two mtrr's
for this processor, yet even without X running there's no regular write-back
mtrr set up at boot, and neither can I create it.
 
I know there used to be a problem with older kernels for setting up
write-allocation with buggy bioses. However with a small module that reads
the AMD whcr register I have found that WA is enabled and set-up correctly
for 64MB without a 15-16mb memory hole. WHCR=04010000 see AMD doc #21326F/0
for more info, so I figure that isn't it. Also MTRR support is working it
seems, judging from the write-combining entries and the kernel-messages.
 
There are three things remaining that I can think of, all related to cache
not being enabled (might all very well be bogus, bear with me here):
 
1.    A model 8 AMD does not have internal L2 cache, and if that is required
for a main memory write-back entry, there's nothing amiss at all, apart from
my knowledge of cache, mtrr, memory etc... @;o)
 
2.    My MVP3 chipset's manual states it has direct-mapped L2 write-back
cache. Maybe the bios is set up incorrectly or just buggy, but god knows I
have tried a lot of BIOS tweaking. Anyways, it might lie in here.
 
3.    Now I read somewhere, that some k6-2 cores are actually k6-3s with
some cache disabled because it was buggy, or something like that? If my
problem lies in this it was a real bad buy because I have already had to set
CPU speed from 500 to 450 to avoid SIG11 problems during kernel
compilations, but I haven't had a single problem with that since I did that.
 
Hope this post is not inappropriate, but I googled all of the internet
twice, this community included. If more info is needed, just let me know.
Please CC me: k.b.klaassen@uvt.nl
 
Thanks in advance & kind regards, 
 
Koen
 
PS: is it normal to get count=2 for the write-combining entry? I have a
voodoo3 2000 pci card with 16MB memory, but mapping makes the mtrr 32MB big.
 
 
Linux version 2.4.26 (root@lara) (gcc version 3.3.3 (Debian 20040422)) #1
Sun Jun 6 11:27:50 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000003ff0000 (usable)
 BIOS-e820: 0000000003ff0000 - 0000000003ff3000 (ACPI NVS)
 BIOS-e820: 0000000003ff3000 - 0000000004000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
63MB LOWMEM available.
On node 0 totalpages: 16368
zone(0): 4096 pages.
zone(1): 12272 pages.
zone(2): 0 pages.
DMI not present.
ACPI: RSDP (v000 VIAVP3                                    ) @ 0x000f65b0
ACPI: RSDT (v001 VIAVP3 AWRDACPI 0x30302e31 AWRD 0x00000000) @ 0x03ff3000
ACPI: FADT (v001 VIAVP3 AWRDACPI 0x30302e31 AWRD 0x00000000) @ 0x03ff3040
ACPI: DSDT (v001 123456 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Kernel command line: root=/dev/hda9 ro vga=791 video=vesafb:nomtrr
Initializing CPU#0
Detected 451.032 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 897.84 BogoMIPS
Memory: 61508k/65472k available (1911k kernel code, 3576k reserved, 409k
data, 280k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002
CPU:             Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
ACPI: Subsystem revision 20040326
PCI: PCI BIOS revision 2.10 entry at 0xfb1b0, last bus=1
PCI: Using configuration type 1
ACPI: IRQ9 SCI: Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4bios S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 14 15)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
NTFS driver v1.1.22 [Flags: R/O]
SGI XFS with ACLs, no debug enabled
SGI XFS Quota Management subsystem
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
vesafb: framebuffer at 0xd6000000, mapped to 0xc4813000, size 3072k
vesafb: mode is 1024x768x16, linelength=2048, pages=9
vesafb: protected mode interface info at c000:7e6b
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10f
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PPP generic driver version 2.4.2
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 27M
agpgart: Detected Via MVP3 chipset
agpgart: AGP aperture is 64M @ 0xd0000000
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG SP1213N, ATA DISK drive
hdb: MATSHITA CR-585, ATAPI CD/DVD-ROM drive
blk: queue c03b6620, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: 234493056 sectors (120060 MB) w/8192KiB Cache, CHS=14596/255/63,
UDMA(33)
hdb: attached ide-cdrom driver.
hdb: ATAPI 24X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda3 < hda5 hda6 hda7 hda8 hda9 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
FAT: bogus logical sector size 0
FAT: bogus logical sector size 0
XFS mounting filesystem ide0(3,9)
Starting XFS recovery on filesystem: ide0(3,9) (dev: ide0(3,9))
Ending XFS recovery on filesystem: ide0(3,9) (dev: ide0(3,9))
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 280k freed
Adding Swap: 995980k swap-space (priority -1)
init_module: prism2_pci.o: 0.2.0 Loaded
init_module: dev_info is: prism2_pci
A Prism2.5 PCI device found, phymem:0xd9000000, irq:11, mem:0xc4bbd000
ppdev: user-space parallel port driver
parport0: PC-style at 0x3bc (0x7bc), irq 7, dma 3
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
parport0: faking semi-colon
parport0: Printer, HEWLETT-PACKARD DESKJET 720C
lp0: using parport0 (interrupt-driven).
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
XFS mounting filesystem ide0(3,6)
Starting XFS recovery on filesystem: ide0(3,6) (dev: ide0(3,6))
Ending XFS recovery on filesystem: ide0(3,6) (dev: ide0(3,6))
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth0: RealTek RTL-8029 found at 0xdc00, IRQ 9, 00:20:18:B8:92:7A.
es1371: version v0.32 time 12:01:32 Jun  6 2004
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x08
es1371: found es1371 rev 8 at io 0xe000 irq 9
es1371: features: joystick 0x0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (511 buckets, 4088 max) - 288 bytes per conntrack
PPP BSD Compression module registered
PPP Deflate Compression module registered
ident: nic h/w: id=0x8013 1.0.0
ident: pri f/w: id=0x15 1.1.0
ident: sta f/w: id=0x1f 1.4.2
MFI:SUP:role=0x00:id=0x01:var=0x01:b/t=1/1
CFI:SUP:role=0x00:id=0x02:var=0x02:b/t=1/1
PRI:SUP:role=0x00:id=0x03:var=0x01:b/t=4/4
STA:SUP:role=0x00:id=0x04:var=0x01:b/t=1/9
PRI-CFI:ACT:role=0x01:id=0x02:var=0x02:b/t=1/1
STA-CFI:ACT:role=0x01:id=0x02:var=0x02:b/t=1/1
STA-MFI:ACT:role=0x01:id=0x01:var=0x01:b/t=1/1
Prism2 card SN: 0123456789\x00\x00
linkstatus=CONNECTED

/proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 451.032
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow
k6_mtrr
bogomips        : 897.84

/proc/mtrr
reg00: base=0xd6000000 (3424MB), size=  32MB: write-combining, count=2



