Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVGEMn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVGEMn0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 08:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVGEMnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 08:43:25 -0400
Received: from mailhub3.nextra.sk ([195.168.1.146]:10757 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S261811AbVGEMf4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 08:35:56 -0400
Message-ID: <42CA7EA9.1010409@rainbow-software.org>
Date: Tue, 05 Jul 2005 14:35:53 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_tic-56634-1120566955-0001-2"
To: Jens Axboe <axboe@suse.de>
CC: "=?ISO-8859-1?Q?Andr=E9_Tomt?=" <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git patches] IDE update
References: <200507042033.XAA19724@raad.intranet> <42C9C56D.7040701@tomt.net> <42CA5A84.1060005@rainbow-software.org> <20050705101414.GB18504@suse.de> <42CA5EAD.7070005@rainbow-software.org> <20050705104208.GA20620@suse.de>
In-Reply-To: <20050705104208.GA20620@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_tic-56634-1120566955-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Jens Axboe wrote:
> On Tue, Jul 05 2005, Ondrej Zary wrote:
> 
>>Jens Axboe wrote:
>>
>>>On Tue, Jul 05 2005, Ondrej Zary wrote:
>>>
>>>
>>>>André Tomt wrote:
>>>>
>>>>
>>>>>Al Boldi wrote:
>>>>>
>>>>>
>>>>>
>>>>>>Bartlomiej Zolnierkiewicz wrote: {
>>>>>>
>>>>>>
>>>>>>
>>>>>>>>>On 7/4/05, Al Boldi <a1426z@gawab.com> wrote:
>>>>>>>>>Hdparm -tT gives 38mb/s in 2.4.31
>>>>>>>>>Cat /dev/hda > /dev/null gives 2% user 33% sys 65% idle
>>>>>>>>>
>>>>>>>>>Hdparm -tT gives 28mb/s in 2.6.12
>>>>>>>>>Cat /dev/hda > /dev/null gives 2% user 25% sys 0% idle 73% IOWAIT
>>>>>
>>>>>
>>>>>The "hdparm doesn't get as high scores as in 2.4" is a old discussed to 
>>>>>death "problem" on LKML. So far nobody has been able to show it affects 
>>>>>anything  but that pretty useless quasi-benchmark.
>>>>>
>>>>
>>>>No, it's not a problem with hdparm. hdparm only shows that there is 
>>>>_really_ a problem:
>>>>
>>>>2.6.12
>>>>root@pentium:/home/rainbow# time dd if=/dev/hda of=/dev/null bs=512
>>>>count=1048576
>>>>1048576+0 records in
>>>>1048576+0 records out
>>>>
>>>>real    0m32.339s
>>>>user    0m1.500s
>>>>sys     0m14.560s
>>>>
>>>>2.4.26
>>>>root@pentium:/home/rainbow# time dd if=/dev/hda of=/dev/null bs=512
>>>>count=1048576
>>>>1048576+0 records in
>>>>1048576+0 records out
>>>>
>>>>real    0m23.858s
>>>>user    0m1.750s
>>>>sys     0m15.180s
>>>
>>>
>>>Perhaps some read-ahead bug. What happens if you use bs=128k for
>>>instance?
>>>
>>
>>Nothing - it's still the same.
>>
>>root@pentium:/home/rainbow# time dd if=/dev/hda of=/dev/null bs=128k 
>>count=4096
>>4096+0 records in
>>4096+0 records out
>>
>>real    0m32.832s
>>user    0m0.040s
>>sys     0m15.670s
> 
> 
> Can you post full dmesg of 2.4 and 2.6 kernel boot? What does hdparm
> -I/-i say for both kernels?
> 

The 2.4.26 kernel is the one from Slackware 10.0 bootable install CD.
dmesg outputs attached, hdparm -i and hdparm -I shows the same in both
kernels (compared using diff) - attached too.

-- 
Ondrej Zary


--=_tic-56634-1120566955-0001-2
Content-Type: text/plain; name="dmesg2426.txt"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg2426.txt"

Linux version 2.4.26 (root@tree) (gcc version 3.3.4) #6 Mon Jun 14 19:07:27 PDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007ff3000 (ACPI NVS)
 BIOS-e820: 0000000007ff3000 - 0000000008000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB LOWMEM available.
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone(1): 28656 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=/kernels/bare.i/bzImage initrd=initrd.img load_ramdisk=1 prompt_ramdisk=0 ramdisk_size=6464 rw root=/dev/ram SLACK_KERNEL=bare.i
Initializing CPU#0
Detected 225.001 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 448.92 BogoMIPS
Memory: 123608k/131008k available (1844k kernel code, 7012k reserved, 618k data, 120k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU:     After generic, caps: 0080a135 00000000 00000000 00000004
CPU:             Common caps: 0080a135 00000000 00000000 00000004
CPU: Cyrix M II 3x Core/Bus Clock stepping 04
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Cyrix ARR
PCI: PCI BIOS revision 2.10 entry at 0xfb020, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX/ICH [8086/7110] at 00:07.0
PCI: Device 00:3a not found by BIOS
PCI: Device 00:3b not found by BIOS
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
pty: 512 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10f
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 6464K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: WDC WD300BB-00AUA1, ATA DISK drive
blk: queue c03b3360, I/O limit 4095Mb (mask 0xffffffff)
hdd: MSI CD-RW MS-8340S, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=3649/255/63, UDMA(33)
hdd: attached ide-cdrom driver.
hdd: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda2 hda3 < hda5 hda6 hda7 >
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :   319.600 MB/sec
   32regs    :   228.800 MB/sec
   pII_mmx   :   334.800 MB/sec
   p5_mmx    :   380.800 MB/sec
raid5: using function: p5_mmx (380.800 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 1.0.8(17/11/2003)
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 2607k freed
EXT2-fs warning: checktime reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 120k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 11 for device 00:07.2
uhci.c: USB UHCI at I/O 0x6400, IRQ 11
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver usbkbd
usbkbd.c: :USB HID Boot Protocol keyboard driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.


--=_tic-56634-1120566955-0001-2
Content-Type: text/plain; name="dmesg2612.txt"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg2612.txt"

Linux version 2.6.12-pentium (root@pentium) (gcc version 3.3.5) #3 Sun Jul 3 11:27:42 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007ff3000 (ACPI NVS)
 BIOS-e820: 0000000007ff3000 - 0000000008000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB LOWMEM available.
On node 0 totalpages: 32752
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 28656 pages, LIFO batch:15
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.0 present.
ACPI: RSDP (v000 123456                                ) @ 0x000f6c40
ACPI: RSDT (v001 123456 AWRDACPI 0x00000000  0x00000000) @ 0x07ff3000
ACPI: FADT (v001 123456 AWRDACPI 0x00000000  0x00000000) @ 0x07ff3040
ACPI: DSDT (v001 123456 AWRDACPI 0x00001000 MSFT 0x01000007) @ 0x00000000
Allocating PCI resources starting at 08000000 (gap: 08000000:f7ff0000)
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=Linux2612 ro root=306 video=matroxfb:vesa:0x105,fv:85,left:192
Initializing CPU#0
PID hash table entries: 512 (order: 9, 8192 bytes)
Detected 225.009 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 125792k/131008k available (2078k kernel code, 4696k reserved, 944k data, 148k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 448.92 BogoMIPS (lpj=2244608)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0080a135 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0080a135 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After all inits, caps: 0080a135 00000000 00000000 00000004 00000000 00000000 00000000
CPU: Cyrix M II 3x Core/Bus Clock stepping 04
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0a00)
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
    ACPI-0216: *** Error: Return object type is incorrect [\_SB_.PCI0.ISA_.UAR1._PRW] (Node c1137fa0), AE_TYPE
    ACPI-0216: *** Error: Return object type is incorrect [\_SB_.PCI0.ISA_.UAR2._PRW] (Node c1137e80), AE_TYPE
    ACPI-0216: *** Error: Return object type is incorrect [\_SB_.PCI0.ISA_.LPT_._PRW] (Node c1137ca0), AE_TYPE
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:14.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: Power Resource [PFAN] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Limiting direct PCI/PCI transfers.
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:14.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
matroxfb: Matrox Mystique (PCI) detected
matroxfb: MTRR's turned on
matroxfb: 1024x768x8bpp (virtual: 1024x4096)
matroxfb: framebuffer at 0xE1000000, mapped to 0xc8880000, size 4194304
Console: switching to colour frame buffer device 128x48
fb0: MATROX frame buffer device
ACPI: Power Button (FF) [PWRF]
ACPI: Fan [FAN] (on)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THRM] (22 C)
isapnp: Scanning for PnP cards...
pnp: CMI8330 quirk - fixing interrupts and dma
isapnp: Card 'AD-CHIPS Audio Adapter'
isapnp: Card '3Com 3C509B EtherLink III'
isapnp: 2 Plug & Play cards detected total
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
lp0: using parport0 (interrupt-driven).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: WDC WD300BB-00AUA1, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdd: MSI CD-RW MS-8340S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=58168/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda2 hda3 < hda5 hda6 hda7 >
hdd: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
usbmon: debugs is not available
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:07.2: Intel Corporation 82371AB/EB/MB PIIX4 USB
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 11, io base 0x00006400
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
pnp: Device 01:01.02 activated.
gameport: NS558 PnP Gameport is pnp01:01.02/gameport0, io 0x200, speed 917kHz
mice: PS/2 mouse device common for all mice
input: PC Speaker
i2c /dev entries driver
piix4_smbus 0000:00:07.3: Found 0000:00:07.3 device
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24 10:33:39 2005 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
NET: Registered protocol family 1
NET: Registered protocol family 17
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 148k freed
kjournald starting.  Commit interval 5 seconds
Adding 128480k swap on /dev/hda7.  Priority:-1 extents:1
EXT3 FS on hda6, internal journal
eth0: 3c5x9 found at 0x300, BNC port, address  00 20 af 49 ed b0, IRQ 10.
3c509.c:1.19b 08Nov2002 becker@scyld.com
http://www.scyld.com/network/3c509.html
eth0: Setting Rx mode to 1 addresses.
EXT3 FS on loop0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
mtrr: 0xe1000000,0x800000 overlaps existing 0xe1000000,0x400000
init_special_inode: bogus i_mode (5102)


--=_tic-56634-1120566955-0001-2
Content-Type: text/plain; name="hdparmi2612.txt"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdparmi2612.txt"


/dev/hda:

 Model=WDC WD300BB-00AUA1, FwRev=18.20D18, SerialNo=WD-WMA6W1847372
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=58633344
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 *udma2 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: device does not report version: 

 * signifies the current active mode



--=_tic-56634-1120566955-0001-2
Content-Type: text/plain; name="hdparmI2612.txt"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdparmI2612.txt"


/dev/hda:

ATA device, with non-removable media
	Model Number:       WDC WD300BB-00AUA1                      
	Serial Number:      WD-WMA6W1847372
	Firmware Revision:  18.20D18
Standards:
	Supported: 5 4 3 2 
	Likely used: 6
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:   58633344
	device size with M = 1024*1024:       28629 MBytes
	device size with M = 1000*1000:       30020 MBytes (30 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	bytes avail on r/w long: 40	Queue depth: 1
	Standby timer values: spec'd by Standard, with device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Recommended acoustic management value: 128, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
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
		Automatic Acoustic Management feature set 
		SET MAX security extension
	   *	DOWNLOAD MICROCODE cmd
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


--=_tic-56634-1120566955-0001-2--
