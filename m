Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267183AbTAKKnb>; Sat, 11 Jan 2003 05:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267189AbTAKKnb>; Sat, 11 Jan 2003 05:43:31 -0500
Received: from tool9.argh.org ([193.41.144.5]:63211 "EHLO toolnine.argh.org")
	by vger.kernel.org with ESMTP id <S267183AbTAKKnY>;
	Sat, 11 Jan 2003 05:43:24 -0500
Date: Sat, 11 Jan 2003 13:52:08 +0100
From: Alexander Koch <efraim@clues.de>
To: linux-kernel@vger.kernel.org
Subject: Re: getting my serial ports back? ;-)
Message-ID: <20030111125208.GA462@clues.de>
References: <20030111101241.GA3589@clues.de> <20030111094435.A14987@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20030111094435.A14987@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Russel,

On Sat, 11 January 2003 09:44:35 +0000, Russell King wrote:
> Argh.  What I suspect has happened here is:
> 
> - the serial driver probed the ports tts/0 and tts/1 at I/O 0x3f8 and
>   0x2f8, and found two UARTS there.  So it claimed IO resources at
>   these addresses.
> 
>   (please show earlier messages in the boot log to confirm this.)

I have attached the dmesg from the 2.5.55 boot.

> - PNP came along, and noticed that 0x3f8 and 0x2f8 were used, so re-
>   located the ports to 0x3e8 and 0x2e8, and told the serial driver
>   about them.
> 
> Since the serial driver knew there were ports at tts/0 and tts/1, it
> allocated tts/2 and tts/3 to the "PNP" ports.

>From reading that log explicitely, yes, PNP finds the same
ports again.

> A "get you working" fix should be to tell gpm.conf to use /dev/tts/2

Ah, this works, thanks lots!

> As for the -17 (EEXIST) error with devfs, I'd need to see the other
> serial messages earlier in the boot log to work out what's going on,
> as well as the kernel version the messages came from.

2.5.55 and 2.5.53 both have this and their log diffs not
at anything related to serial/pnp, etc.

Hope this helps a little for debug. If you need more
information please let me know.

Thanks lots,
Alexander


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.5.55"

Linux version 2.5.55 (root@seeker) (gcc version 3.2.2 20021231 (Debian prerelease)) #1 Thu Jan 9 22:53:41 CET 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ea800 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007fffc00 (ACPI data)
 BIOS-e820: 0000000007fffc00 - 0000000008000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
127MB LOWMEM available.
On node 0 totalpages: 32752
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 28656 pages, LIFO batch:6
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=edge ro root=301 root=/dev/ide/host0/bus0/target0/lun0/part1
Initializing CPU#0
PID hash table entries: 512 (order 9: 4096 bytes)
Detected 601.277 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1187.84 BogoMIPS
Memory: 126716k/131008k available (1558k kernel code, 3756k reserved, 450k data, 272k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
device class 'cpu': registering
device class cpu: adding driver system:cpu
PCI: PCI BIOS revision 2.10 entry at 0xfd9a3, last bus=1
PCI: Using configuration type 1
device class cpu: adding device CPU 0
interfaces: adding device CPU 0
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 246 entries (12 bytes)
biovec pool[1]:   4 bvecs: 246 entries (48 bytes)
biovec pool[2]:  16 bvecs: 246 entries (192 bytes)
biovec pool[3]:  64 bvecs: 246 entries (768 bytes)
biovec pool[4]: 128 bvecs: 123 entries (1536 bytes)
biovec pool[5]: 256 bvecs:  61 entries (3072 bytes)
Linux Plug and Play Support v0.93 (c) Adam Belay
pnp: the driver 'system' has been registered
pnp: Enabling Plug and Play Card Services.
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7000
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x891c, dseg 0x400
pnp: pnp: match found with the PnP device '00:00' and the driver 'system'
pnp: pnp: match found with the PnP device '00:01' and the driver 'system'
pnp: pnp: match found with the PnP device '00:0a' and the driver 'system'
pnp: 00:0a: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0a: ioport range 0x8000-0x803f has been reserved
pnp: 00:0a: ioport range 0x1040-0x104f has been reserved
pnp: pnp: match found with the PnP device '00:0b' and the driver 'system'
pnp: pnp: match found with the PnP device '00:0d' and the driver 'system'
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
SCSI subsystem driver Revision: 1.00
device class 'scsi-host': registering
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Address space collision on region 7 of bridge 00:04.3 [8000:803f]
PCI: Address space collision on region 8 of bridge 00:04.3 [1040:105f]
PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
SBF: ACPI BOOT descriptor is wrong length (39)
SBF: Simple Boot Flag extension found and enabled.
SBF: Simple boot flag value 0xff read from CMOS RAM was invalid
SBF: Setting boot flags 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Enabling SEP on CPU 0
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
tts/0 at I/O 0x3f8 (irq = 4) is a 16550A
tts/1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'serial' has been registered
pnp: pnp: match found with the PnP device '00:0f' and the driver 'serial'
pnp: the device '00:0f' has been activated
devfs_register(tts/2): could not append to parent, err: -17
tts/2 at I/O 0x3e8 (irq = 4) is a 16550A
pnp: pnp: match found with the PnP device '00:10' and the driver 'serial'
pnp: the device '00:10' has been activated
devfs_register(tts/3): could not append to parent, err: -17
tts/3 at I/O 0x2e8 (irq = 3) is a 16550A
device class 'tty': registering
pty: 256 Unix98 ptys configured
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:04.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1050-0x1057, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1058-0x105f, BIOS settings: hdc:DMA, hdd:pio
hda: ST313620A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LTN485S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: setmax LBA 26520481, native  26520480
hda: 26520480 sectors (13578 MB) w/512KiB Cache, CHS=26310/16/63, UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 >
PCI: Found IRQ 5 for device 00:12.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.26
        <Adaptec 19160B Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

device class 'input': registering
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
Initializing IPsec netlink socket
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 272k freed
Adding 128480k swap on /dev/ide/host0/bus0/target0/lun0/part6.  Priority:-1 extents:1
PCI: Found IRQ 11 for device 00:0e.0
PCI: Sharing IRQ 11 with 00:04.2
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0e.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1080. Vers LK1.1.18
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
PCI: Found IRQ 10 for device 00:10.0
PCI: Sharing IRQ 10 with 00:06.0
eth1: RealTek RTL-8029 found at 0x1020, IRQ 10, 52:54:00:EC:31:2D.
register interface 'mouse' with class 'input'
mice: PS/2 mouse device common for all mice
input: PC Speaker
Linux agpgart interface v0.100 (c) Dave Jones
[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0x00000000, data=0x0
Call Trace: [<c0120de1>]  [<c01210ca>]  [<c885fc30>]  [<c88647d5>]  [<c881a23d>]  [<c8869598>]  [<c8873120>]  [<c012c423>]  [<c0109523>] 
pnp: the driver 'parport_pc' has been registered
pnp: pnp: match found with the PnP device '00:11' and the driver 'parport_pc'
pnp: the device '00:11' has been activated
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
Module parport cannot be unloaded due to unsafe usage in include/linux/module.h:420
Module parport_pc cannot be unloaded due to unsafe usage in include/linux/module.h:420
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
hdc: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
IPv6 v0.8 for NET4.0
Module ipv6 cannot be unloaded due to unsafe usage in include/linux/module.h:420
IPv6 over IPv4 tunneling driver
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
ttyS0: LSR safety check engaged!
ttyS0: LSR safety check engaged!
ttyS0: LSR safety check engaged!
ttyS1: LSR safety check engaged!
ttyS1: LSR safety check engaged!
ttyS1: LSR safety check engaged!
Module ppp_async cannot be unloaded due to unsafe usage in include/linux/module.h:420
soundcore: Unknown symbol errno
snd: Unknown symbol register_sound_special
soundcore: Unknown symbol errno
snd: Unknown symbol register_sound_special
soundcore: Unknown symbol errno
snd: Unknown symbol register_sound_special
PPP BSD Compression module registered
Module bsd_comp cannot be unloaded due to unsafe usage in include/linux/module.h:420
PPP Deflate Compression module registered
Module ppp_deflate cannot be unloaded due to unsafe usage in include/linux/module.h:420
ttyS0: LSR safety check engaged!
ttyS0: LSR safety check engaged!
eth0: no IPv6 routers present
eth1: no IPv6 routers present

--qMm9M+Fa2AknHoGS--
