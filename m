Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbTJXWCp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 18:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbTJXWCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 18:02:45 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:13249 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S262674AbTJXWB1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 18:01:27 -0400
Date: Fri, 24 Oct 2003 15:01:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: nico-kernel@schottelius.org, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: 3c59x problem with 2.4.6-test[34]
Message-ID: <20031024220112.GA972@ip68-0-152-218.tc.ph.cox.net>
References: <20030907212348.GA836@ip68-0-152-218.tc.ph.cox.net> <20030929151827.GB862@ip68-0-152-218.tc.ph.cox.net> <20031015183505.GA963@ip68-0-152-218.tc.ph.cox.net> <20031017235325.GA957@ip68-0-152-218.tc.ph.cox.net> <20031018122708.GA401@schottelius.org> <20031018041448.6362faee.akpm@osdl.org> <20031024193402.GA985@ip68-0-152-218.tc.ph.cox.net> <20031024124356.212fc590.akpm@osdl.org> <20031024195243.GB985@ip68-0-152-218.tc.ph.cox.net> <20031024132403.2d574e3f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031024132403.2d574e3f.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 24, 2003 at 01:24:03PM -0700, Andrew Morton wrote:
> Tom Rini <trini@kernel.crashing.org> wrote:
> >
> > On Fri, Oct 24, 2003 at 12:43:56PM -0700, Andrew Morton wrote:
> > > Tom Rini <trini@kernel.crashing.org> wrote:
> > > >
> > > > Okay.  First an odd part.  When the card does not work, I didn't get
> > > >  anything in the syslog with debug=7, but I did get plenty when it works.
> > > 
> > > Well that's a big hint.  If no debug output comes out then the driver
> > > simply isn't being executed.  You'll need to investigate and report on this
> > > further.  Make sure that you've set `dmesg -n 7' of course...

I didn't think of that, oops.  Here's a dmesg from a failing attempt
(-test8):
Linux version 2.6.0-test8 (root@Bill-The-Cat) (gcc version 3.3.2 20030908 (Debian prerelease)) #1 SMP Fri Oct 17 16:33:30 MST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000020000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
512MB LOWMEM available.
found SMP MP-table at 000fb670
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 131072
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126976 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI disabled because your bios is from 95 and too old
You can enable it with acpi=force
ACPI: Unable to locate RSDP
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: 440LX        APIC at: 0xFEE00000
Processor #0 6:5 APIC version 17
Processor #1 6:5 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Building zonelist for node : 0
Kernel command line: root=/dev/sda2 ro video=1280x1024-8@85 single
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 333.031 MHz processor.
Console: colour VGA+ 80x25
Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
in_atomic():1, irqs_disabled():1
Call Trace:
 [<c011cf18>] __might_sleep+0x88/0x96
 [<c011fcd9>] acquire_console_sem+0x39/0x60
 [<c011fee5>] register_console+0x85/0x1b0
 [<c0345e72>] con_init+0x202/0x240
 [<c0105000>] _stext+0x0/0x50
 [<c03452e3>] console_init+0x33/0x40
 [<c0334851>] start_kernel+0xd1/0x170
 [<c03344a0>] unknown_bootoption+0x0/0x120

Memory: 515612k/524288k available (1558k kernel code, 7928k reserved, 686k data, 152k init, 0k highmem)
Debug: sleeping function called from invalid context at mm/slab.c:1857
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c011cf18>] __might_sleep+0x88/0x96
 [<c0140748>] kmem_cache_alloc+0x78/0x80
 [<c0105000>] _stext+0x0/0x50
 [<c013f7cb>] kmem_cache_create+0x7b/0x540
 [<c034024a>] mem_init+0x17a/0x200
 [<c0105000>] _stext+0x0/0x50
 [<c0342879>] kmem_cache_init+0x129/0x300
 [<c0334861>] start_kernel+0xe1/0x170
 [<c03344a0>] unknown_bootoption+0x0/0x120

Calibrating delay loop... 655.36 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0183fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0183fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 0183fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium II (Deschutes) stepping 02
per-CPU timeslice cutoff: 1461.97 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 663.55 BogoMIPS
CPU:     After generic identify, caps: 0183fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0183fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 0183fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium II (Deschutes) stepping 02
Total of 2 processors activated (1318.91 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-10, 2-11, 2-15, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
number of MP IRQ sources: 17.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    71
 0d 001 01  0    0    0   0   0    1    1    79
 0e 001 01  0    0    0   0   0    1    1    81
 0f 000 00  1    0    0   0   0    0    0    00
 10 001 01  1    1    0   1   0    1    1    89
 11 001 01  1    1    0   1   0    1    1    91
 12 001 01  1    1    0   1   0    1    1    99
 13 001 01  1    1    0   1   0    1    1    A1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:19
IRQ10 -> 0:18
IRQ11 -> 0:16
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:17
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 332.0997 MHz.
..... host bus clock speed is 66.0599 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb91, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
matroxfb: Matrox G400 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 1280x1024x8bpp (virtual: 1280x65536)
matroxfb: framebuffer at 0xDA000000, mapped to 0xe0805000, size 16777216
fb0: MATROX frame buffer device
fb0: initializing hardware
Starting balanced_irq
ikconfig 0.7 with /proc/config*
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
Console: switching to colour frame buffer device 160x64
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20262: IDE controller at PCI slot 0000:00:0f.0
PDC20262: chipset revision 1
PDC20262: ROM enabled at 0xfeb50000
PDC20262: 100% native mode on irq 10
PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide0: BM-DMA at 0xee80-0xee87, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xee88-0xee8f, BIOS settings: hdc:pio, hdd:pio
hda: IC35L060AVER07-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0xeff0-0xeff7,0xefe6 on irq 10
hda: max request size: 128KiB
hda: 120103200 sectors (61492 MB) w/1916KiB Cache, CHS=65535/16/63, UDMA(66)
 hda: hda1
sym0: <895> rev 0x1 at pci 0000:00:0d.0 irq 10
sym0: Tekram NVRAM, ID 7, Fast-40, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18b
  Vendor: IBM       Model: DNES-309170W      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym0:0:0: tagged command queuing enabled, command queue depth 16.
sym0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 31)
sym0:0:0:phase change 2-3 12@1fdc5f60 resid=11.
sym0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 30)
  Vendor: CONNER    Model: CTT8000-S         Rev: 1.07
  Type:   Sequential-Access                  ANSI SCSI revision: 02
  Vendor: GENERIC   Model: CRD-BP4           Rev: 4.27
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-ROM PX-40TS    Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Console: switching to colour frame buffer device 160x64
matroxfb_crtc2: secondary head of fb0 was registered as fb1
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
NET: Registered protocol family 1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 152k freed
Adding 131048k swap on /dev/sda7.  Priority:-1 extents:1
EXT3 FS on sda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 9, io base 0000ef80
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
hub 1-0:1.0: new USB device on port 1, assigned address 2
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
hub 1-0:1.0: new USB device on port 2, assigned address 3
PCI: Enabling device 0000:00:0e.0 (0000 -> 0003)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
0000:00:0e.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xe480. Vers LK1.1.19
PCI: Setting latency timer of device 0000:00:0e.0 to 64
 ff:ff:ff:ff:ff:ff, IRQ 9
  product code ffff rev ffff.15 date 15-31-127
Full duplex capable
  Internal config register is ffffffff, transceivers 0xffff.
  1024K word-wide RAM 3:5 Rx:Tx split, autoselect/<invalid transceiver> interface.
  ***WARNING*** No MII transceivers found!
  Enabling bus-master transmits and early receives.
0000:00:0e.0: scatter/gather enabled. h/w checksums enabled
hub 1-1:1.0: new USB device on port 4, assigned address 4
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Optical] on usb-0000:00:07.2-1.4
eth0:  Filling in the Rx ring.
eth0: using NWAY device table, not 15
eth0: Initial media type Autonegotiate.
vortex_up(): writing 0xff8fffff to InternalConfig
eth0: MII #24 status ffff, link partner capability ffff, info1 ffff, setting full-duplex.
eth0: vortex_up() InternalConfig ff8fffff.
eth0: command 0x5800 did not complete! Status=0xffff
eth0: command 0x2804 did not complete! Status=0xffff
eth0: vortex_up() irq 9 media status ffff.
eth0: Media selection timer tick happened, Autonegotiate.
dev->watchdog_timeo=5000
eth0: MII transceiver has status ffff.
eth0: Media selection timer finished, Autonegotiate.
NET: Registered protocol family 17
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 0.
eth0: command 0x3002 did not complete! Status=0xffff
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 1.
eth0: command 0x3002 did not complete! Status=0xffff
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 2.
eth0: command 0x3002 did not complete! Status=0xffff
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 3.
eth0: command 0x3002 did not complete! Status=0xffff
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 4.
eth0: command 0x3002 did not complete! Status=0xffff
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 5.
eth0: command 0x3002 did not complete! Status=0xffff
eth0: Media selection timer tick happened, Autonegotiate.
dev->watchdog_timeo=5000
eth0: MII transceiver has status ffff.
eth0: Media selection timer finished, Autonegotiate.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 6.
eth0: command 0x3002 did not complete! Status=0xffff
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 7.
eth0: command 0x3002 did not complete! Status=0xffff
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 8.
eth0: command 0x3002 did not complete! Status=0xffff
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 9.
eth0: command 0x3002 did not complete! Status=0xffff
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 10.
eth0: command 0x3002 did not complete! Status=0xffff
eth0: vortex_close() status ffff, Tx status ff.
eth0: vortex close stats: rx_nocopy 0 rx_copy 0 tx_queued 0 Rx pre-checksummed 0.
Linux Tulip driver version 1.1.13 (May 11, 2002)
tulip0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth1: Lite-On 82c168 PNIC rev 32 at 0xe2828e00, 00:A0:CC:D2:49:2F, IRQ 11.
eth1: Setting full-duplex based on MII#1 link partner capability of 41e1.
nfs warning: mount version older than kernel
Real Time Clock Driver v1.12
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
microcode: CPU1 updated from revision 0x14 to 0x2a, date = 05121999 
microcode: CPU0 updated from revision 0x14 to 0x2a, date = 05121999 

I was also able to break 2.4, but only by going from 2.6 (working or not
on that boot) then to 2.4.  Here's what the dmesg looks like then:
Linux version 2.4.22 (root@opus) (gcc version 3.3.2 20030908 (Debian prerelease)) #1 SMP Sun Sep 28 10:02:55 MST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000020000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
512MB LOWMEM available.
found SMP MP-table at 000fb670
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 131072
zone(0): 4096 pages.
zone(1): 126976 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: 440LX        APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
Processors: 2
Kernel command line: root=/dev/sda2 ro video=1280x1024-8@85 single
Initializing CPU#0
Detected 333.057 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 665.19 BogoMIPS
Memory: 515924k/524288k available (1260k kernel code, 7976k reserved, 492k data, 112k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
CPU0: Intel Pentium II (Deschutes) stepping 02
per-CPU timeslice cutoff: 1461.97 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 665.19 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
CPU1: Intel Pentium II (Deschutes) stepping 02
Total of 2 processors activated (1330.38 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-10, 2-11, 2-15, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
number of MP IRQ sources: 17.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 003 03  0    0    0   0   0    1    1    31
 01 003 03  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    71
 0d 003 03  0    0    0   0   0    1    1    79
 0e 003 03  0    0    0   0   0    1    1    81
 0f 000 00  1    0    0   0   0    0    0    00
 10 003 03  1    1    0   1   0    1    1    89
 11 003 03  1    1    0   1   0    1    1    91
 12 003 03  1    1    0   1   0    1    1    99
 13 003 03  1    1    0   1   0    1    1    A1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:19
IRQ10 -> 0:18
IRQ11 -> 0:16
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:17
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 333.0739 MHz.
..... host bus clock speed is 66.6145 MHz.
cpu: 0, clocks: 666145, slice: 222048
CPU0<T0:666144,T1:444096,D:0,S:222048,C:666145>
cpu: 1, clocks: 666145, slice: 222048
CPU1<T0:666144,T1:222048,D:0,S:222048,C:666145>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfdb91, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
matroxfb: Matrox G400 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 1280x1024x8bpp (virtual: 1280x13104)
matroxfb: framebuffer at 0xDA000000, mapped to 0xe0805000, size 16777216
Console: switching to colour frame buffer device 160x64
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20262: IDE controller at PCI slot 00:0f.0
PDC20262: chipset revision 1
PDC20262: not 100% native mode: will probe irqs later
PDC20262: ROM enabled at 0xfeb50000
PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide0: BM-DMA at 0xee80-0xee87, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xee88-0xee8f, BIOS settings: hdc:pio, hdd:pio
hda: IC35L060AVER07-0, ATA DISK drive
blk: queue c0320fe0, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0xeff0-0xeff7,0xefe6 on irq 10
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(66)
Partition check:
 hda: hda1
SCSI subsystem driver Revision: 1.00
sym.0.13.0: setting PCI_COMMAND_PARITY...
sym0: <895> rev 0x1 on pci bus 0 device 13 function 0 irq 10
sym0: Tekram NVRAM, ID 7, Fast-40, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.17a
blk: queue dfe87e18, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: IBM       Model: DNES-309170W      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue dfe87c18, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: CONNER    Model: CTT8000-S         Rev: 1.07
  Type:   Sequential-Access                  ANSI SCSI revision: 02
blk: queue dfe87a18, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: GENERIC   Model: CRD-BP4           Rev: 4.27
  Type:   CD-ROM                             ANSI SCSI revision: 02
blk: queue dfe87818, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: PLEXTOR   Model: CD-ROM PX-40TS    Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
blk: queue dfe87618, I/O limit 4095Mb (mask 0xffffffff)
sym0:0:0: tagged command queuing enabled, command queue depth 16.
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
sym0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 31)
sym0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 30)
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 112k freed
Adding Swap: 131048k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,2), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
uhci.c: USB UHCI at I/O 0xef80, IRQ 9
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
hub.c: new USB device 00:07.2-1, assigned address 2
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: new USB device 00:07.2-2, assigned address 3
usb.c: USB device 3 (vend/prod 0x4b8/0x5) is not claimed by any active driver.
PCI: Enabling device 00:0e.0 (0000 -> 0003)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:0e.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xe480. Vers LK1.1.18-ac
PCI: Setting latency timer of device 00:0e.0 to 64
 ff:ff:ff:ff:ff:ff, IRQ 9
  product code ffff rev ffff.15 date 15-31-127
Full duplex capable
  Internal config register is ffffffff, transceivers 0xffff.
  1024K word-wide RAM 3:5 Rx:Tx split, autoselect/<invalid transceiver> interface.
  Enabling bus-master transmits and early receives.
00:0e.0: scatter/gather enabled. h/w checksums enabled
hub.c: new USB device 00:07.2-1.4, assigned address 4
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Optical] on usb1:4.0
eth0:  Filling in the Rx ring.
eth0: using NWAY device table, not 15
eth0: Initial media type Autonegotiate.
vortex_up(): writing 0xff8fffff to InternalConfig
eth0: MII #0 status ffff, link partner capability ffff, info1 ffff, setting full-duplex.
eth0: vortex_up() InternalConfig ff8fffff.
eth0: command 0x5800 did not complete! Status=0xffff
eth0: command 0x2804 did not complete! Status=0xffff
eth0: vortex_up() irq 9 media status ffff.
eth0: Media selection timer tick happened, Autonegotiate.
dev->watchdog_timeo=500
eth0: MII transceiver has status ffff.
eth0: Media selection timer finished, Autonegotiate.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 0.
eth0: command 0x3002 did not complete! Status=0xffff
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 1.
eth0: command 0x3002 did not complete! Status=0xffff
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 2.
eth0: command 0x3002 did not complete! Status=0xffff
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 3.
eth0: command 0x3002 did not complete! Status=0xffff
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 4.
eth0: command 0x3002 did not complete! Status=0xffff
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 5.
eth0: command 0x3002 did not complete! Status=0xffff
eth0: Media selection timer tick happened, Autonegotiate.
dev->watchdog_timeo=500
eth0: MII transceiver has status ffff.
eth0: Media selection timer finished, Autonegotiate.
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 6.
eth0: command 0x3002 did not complete! Status=0xffff
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 7.
eth0: command 0x3002 did not complete! Status=0xffff
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 8.
eth0: command 0x3002 did not complete! Status=0xffff
boomerang_start_xmit()
eth0: Trying to send a packet, Tx index 9.
eth0: command 0x3002 did not complete! Status=0xffff
eth0: vortex_close() status ffff, Tx status ff.
eth0: vortex close stats: rx_nocopy 0 rx_copy 0 tx_queued 0 Rx pre-checksummed 0.
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
tulip0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth1: Lite-On 82c168 PNIC rev 32 at 0xe2868e00, 00:A0:CC:D2:49:2F, IRQ 11.
eth1: Setting full-duplex based on MII#1 link partner capability of 41e1.
Real Time Clock Driver v1.10e
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
microcode: CPU0 updated from revision 20 to 42, date=05121999
microcode: CPU1 updated from revision 20 to 42, date=05121999
microcode: freed 4096 bytes

> > >From the original message, something is happening:
> > Sep  6 18:13:57 opus kernel: 0000:00:0e.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xe480. Vers LK1.1.19
> > Sep  6 18:13:57 opus vmunix:   ***WARNING*** No MII transceivers found!
> > 
> 
> Oh, OK, I didn't look at your initial message closely enough.
> 
> Every register is coming up with 0xff, so the NIC isn't powered up.  There
> have been a couple of reports of this.
> 
> I don't know why this has changed from 2.4.  Suggest you try disabling (or
> enabling) ACPI, and see if there are any BIOS settings which might affect
> this.

ACPI is off (kernel) on this machine (and the table too old for the
kernel to attempt to use it, even with acpi=force).   I didn't see
anything in the BIOS for this either (I was thinking _maybe_ it had
to do with ACPI Aware OS = y, but turning that off didn't help.

-- 
Tom Rini
http://gate.crashing.org/~trini/
