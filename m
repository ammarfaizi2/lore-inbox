Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbWARA1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWARA1A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWARA07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:26:59 -0500
Received: from mx.laposte.net ([81.255.54.11]:64752 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S964943AbWARA05 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:26:57 -0500
Date: Wed, 18 Jan 2006 01:26:50 +0100
Message-Id: <IT9IKQ$70E030BE260E9BEBE1B764A2EC1FF505@laposte.net>
Subject: 2.6.15: no more interrupt load balancing
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
From: "emmanuel\.fuste" <emmanuel.fuste@laposte.net>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
X-XaM3-API-Version: 4.1 (B103)
X-SenderIP: 127.0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

2.6.13 was Nok,
2.6.14 was Ok,
2.6.15 Nok :
efuste@rafale:~$ cat /proc/interrupts 
           CPU0       CPU1       
  0:    1046433        211    IO-APIC-edge  timer
  1:       2778          9    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  3:         17          0    IO-APIC-edge  serial
  5:          0          0    IO-APIC-edge  SoundBlaster
  7:          1          2    IO-APIC-edge  parport0
  8:          4          0    IO-APIC-edge  rtc
 12:     116647          3    IO-APIC-edge  i8042
 17:     170055          0   IO-APIC-level  eth0
 19:     216141          1   IO-APIC-level  aic7xxx, uhci_hcd:usb1
NMI:          0          0 
LOC:    1046486    1046485 
ERR:          0
MIS:          0

boot log:

Linux version 2.6.15 (Version: manu.1) (root@excalibur) (gcc
version 4.0.3 20060104 (prerelease) (Debian 4.0.2-6)) #3 SMP
Thu Jan 12 15:22:26 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000020000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
512MB LOWMEM available.
found SMP MP-table at 000f6960
On node 0 totalpages: 131072
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 126976 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.0 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 5:4 APIC version 16
Processor #1 5:4 APIC version 16
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Allocating PCI resources starting at 30000000 (gap:
20000000:dec00000)
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=Linux ro root=802
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
CPU 0 irqstacks, hard=c02f0000 soft=c02ee000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 232.699 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515484k/524288k available (1312k kernel code, 8304k
reserved, 475k data, 160k init, 0k highmem)
Checking if this processor honours the WP bit even in
supervisor mode... Ok.
Calibrating delay using timer specific routine.. 466.34
BogoMIPS (lpj=932696)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 008003bf 00000000 00000000
00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 008003bf 00000000 00000000
00000000 00000000 00000000 00000000
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After all inits, caps: 008003bf 00000000 00000000
00000000 00000000 00000000 00000000
mtrr: v2.0 (20020519)
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium MMX stepping 03
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c02f1000 soft=c02ef000
Initializing CPU#1
Calibrating delay using timer specific routine.. 465.40
BogoMIPS (lpj=930806)
CPU: After generic identify, caps: 008003bf 00000000 00000000
00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 008003bf 00000000 00000000
00000000 00000000 00000000 00000000
CPU: After all inits, caps: 008003bf 00000000 00000000
00000000 00000000 00000000 00000000
CPU1: Intel Pentium MMX stepping 03
Total of 2 processors activated (931.75 BogoMIPS).
ExtINT not setup in hardware but reported by MP table
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
checking if image is initramfs... it is
Freeing initrd memory: 1121k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0440, last bus=0
PCI: Using configuration type 1
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fcec0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xcef0, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:0a.0
PCI: Using IRQ router PIIX/ICH [8086/7000] at 0000:00:01.0
PCI->APIC IRQ transform: 0000:00:01.2[D] -> IRQ 19
PCI->APIC IRQ transform: 0000:00:0a.0[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:00:0b.0[A] -> IRQ 17
PCI->APIC IRQ transform: 0000:00:0c.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:0d.0[A] -> IRQ 19
audit: initializing netlink socket (disabled)
audit(1137539311.901:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
PIIX3: Enabling ISA and USB passive release and delayed
transaction.
PIIX3: Enabling north bridge retry enable bit.
82439HX: Enabling north bridge delayed transaction.
Good PIIX3 revision: ISA DMA hang workarounds not need.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PNP: PS/2 Controller [PNP0303,PNP0f13] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ
sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:02: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:03: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024
blocksize
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576
bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
Starting balanced_irq
Using IPI Shortcut mode
Freeing unused kernel memory: 160k freed
mice: PS/2 mouse device common for all mice
SCSI subsystem initialized
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: IBM       Model: DMVS18V           Rev: 02B0
  Type:   Direct-Access                      ANSI SCSI
revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 8
 target0:0:0: Beginning Domain Validation
 target0:0:0: wide asynchronous.
 target0:0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31)
 target0:0:0: Domain Validation skipping write tests
 target0:0:0: Ending Domain Validation
  Vendor: YAMAHA    Model: CRW6416S          Rev: 1.0d
  Type:   CD-ROM                             ANSI SCSI
revision: 02
 target0:0:3: Beginning Domain Validation
 target0:0:3: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
 target0:0:3: Domain Validation skipping write tests
 target0:0:3: Ending Domain Validation
  Vendor: TOSHIBA   Model: CD-ROM XM-3501TA  Rev: 1875
  Type:   CD-ROM                             ANSI SCSI
revision: 02
 target0:0:4: Beginning Domain Validation
 target0:0:4: Domain Validation skipping write tests
 target0:0:4: Ending Domain Validation
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
pcnet32.c:v1.31c 01.Nov.2005 tsbogend@alpha.franken.de
PCI: Setting latency timer of device 0000:00:0b.0 to 64
pcnet32: PCnet/PCI 79C970 at 0xe000, 10 00 5a 5b 55 97
assigned IRQ 17.
eth0: registered as PCnet/PCI 79C970
pcnet32: 1 cards_found.
USB Universal Host Controller Interface driver v2.3
uhci_hcd 0000:00:01.2: UHCI Host Controller
uhci_hcd 0000:00:01.2: new USB bus registered, assigned bus
number 1
uhci_hcd 0000:00:01.2: irq 19, io base 0x0000e400
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override
with idebus=xx
PIIX3: IDE controller at PCI slot 0000:00:01.1
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xe800-0xe807, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xe808-0xe80f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
Probing IDE interface ide1...
Floppy drive(s): fd0 is 2.88M AMI BIOS, fd1 is 1.44M
input: PC Speaker as /class/input/input1
Real Time Clock Driver v1.12
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3
[PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
FDC 0 is a post-1991 82077
input: ImExPS/2 Generic Explorer Mouse as /class/input/input2
sr0: scsi3-mmc drive: 6x/6x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:3:0: Attached scsi CD-ROM sr0
sr1: scsi-1 drive
sr 0:0:4:0: Attached scsi CD-ROM sr1
sd 0:0:0:0: Attached scsi generic sg0 type 0
sr 0:0:3:0: Attached scsi generic sg1 type 5
sr 0:0:4:0: Attached scsi generic sg2 type 5
EXT3 FS on sda2, internal journal
RocketPort device driver module, version 2.09, 12-June-2003
RocketPort ISA card #0 found at 0x180 - 1 AIOPs 
Installing RocketPort ISA, creating /dev/ttyR0 - 7
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
NET: Registered protocol family 24
Probing IDE interface ide0...
Probing IDE interface ide1...
irda_init()
NET: Registered protocol family 23
IrCOMM protocol (Dag Brattli)
device-mapper: 4.4.0-ioctl (2005-01-12) initialised:
dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with writeback data mode.
Adding 522072k swap on /dev/sda1.  Priority:-1 extents:1
across:522072k
NET: Registered protocol family 15
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
lp0: using parport0 (interrupt-driven).
eth0: no IPv6 routers present
cdrom: This disc doesn't have any tracks I recognize!
sirdev_get_instance - ttyS1
irtty_open - ttyS1: irda line discipline opened
irda_register_dongle : registering dongle "Tekram IR-210B" (0).
irlap_change_speed(), setting speed to 9600
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and
petero2@telia.com
cdrom: This disc doesn't have any tracks I recognize!
pktcdvd: writer pktcdvd0 mapped to sr0
pktcdvd: pkt_get_last_written failed
ircomm_tty_attach_cable()
ircomm_tty_ias_register()
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
[drm:drm_fill_in_dev] *ERROR* Cannot initialize the agpgart
module.
DRM: Fill_in_dev failed.

Thanks,
Emmanuel.


Accédez au courrier électronique de La Poste : www.laposte.net ; 
3615 LAPOSTENET (0,34 €/mn) ; tél : 08 92 68 13 50 (0,34€/mn)



