Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbULEQrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbULEQrG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 11:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbULEQrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 11:47:06 -0500
Received: from wl-193.226.227-253-szolnok.dunaweb.hu ([193.226.227.253]:36482
	"EHLO szolnok.dunaweb.hu") by vger.kernel.org with ESMTP
	id S261313AbULEQpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 11:45:01 -0500
Message-ID: <41B33B4A.5040104@freemail.hu>
Date: Sun, 05 Dec 2004 17:46:02 +0100
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; hu; rv:1.7.3) Gecko/20041020
X-Accept-Language: hu, en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: CD-ROM problem on x86-64
References: <41A84875.2030505@freemail.hu> <20041129175851.0b7ed213.akpm@osdl.org>
In-Reply-To: <20041129175851.0b7ed213.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------080600020901000002080807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080600020901000002080807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Andrew Morton írta:
> Zoltan Boszormenyi <zboszor@freemail.hu> wrote:
> 
>>Hi,
>>
>>I get sometimes these kind of errors reading continously from CDs:
>>
>>Nov 26 13:38:09 wl-193 kernel: hda: dma_timer_expiry: dma status == 0x24
>>Nov 26 13:38:19 wl-193 kernel: hda: DMA interrupt recovery
>>Nov 26 13:38:19 wl-193 kernel: hda: lost interrupt
>>
>>and
>>
>>Nov 26 16:16:50 wl-193 kernel: hdc: DMA interrupt recovery
>>Nov 26 16:16:50 wl-193 kernel: hdc: lost interrupt
>>
>>This happens when I use Xine playing AVIs from CDs.
>>When it happens, it happens frequently, like once in every 5-10 minutes.
>>When I play an SVCD then it's less frequent than on data CDs,
>>like once in 30 minutes.
>>
>>Drive is:
>>
>>hdc: LITE-ON COMBO LTC-48161H, ATAPI CD/DVD-ROM drive
>>
>>I haven't seen these kind of errors on my previous FC1/i386 system with
>>2.6.x kernels, I installed FC3/x86-64 recently. The original and the
>>second errata kernel both show this errors.
>>
>>I also don't get this error on my harddisk.
> 
> 
> Could we see the full boot log please?  (ie: the dmesg output)

Finally, I got a little time to try other kernels than the
official Fedora erratas. I compiled 2.6.10-rc3, applied the
time-sliced-cfq-#2 io scheduler patch from Jens Axboe and updated
the linuxconsole.sf.net multiconsole patch to work with 2.6.10-rc3,
I depend on this functionality on my machine, my wife works on the
machine or our children watch some cartoon or play games, etc, while
I hack... :-)

I attached the full boot log for both kernel-2.6.9-1.681 (also
customized with the multiconsole patch) and 2.6.10-rc3.
The uptime is now more than 2 hours with the new kernel, so far
I haven't experienced similar problem with it. I played an AVI
off the harddisk and recompiled the xorg-x11 src.rpm at the same
time to create I/O stress. No problem with /dev/hda.

What I miss are my removable devices. How to convince HAL daemon
to keep /media/floppy and /media/cdrecorder? Or which patches should
I apply from the Fedora kernel src.rpm? I created /mnt/cdrom and
tried mounting /dev/hdc there (as root) but the mount hung...
The kernel-2.6.9-1.681 Fedora kernel is basically 2.6.9-ac10, is there
something in there what is not in 2.6.10-rc3 and a relevant fix to this?
I am still on FC3/x86-64...

Best regards,
Zoltán Böszörményi

--------------080600020901000002080807
Content-Type: text/plain;
 name="dmesg-FC3-acpi-off.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-FC3-acpi-off.log"

Bootdata ok (command line is ro root=LABEL=/ dumbcon=1 rhgb acpi=off quiet)
Linux version 2.6.9-1.681ruby_FC3.root (root@wl-193.226.227-37-szolnok.dunaweb.hu) (gcc version 3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #1 Wed Nov 24 20:26:05 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000cc000 - 00000000000d6000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
No mptable found.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: VIA      <6>Product ID: K8T400       <6>APIC at: 0xFEE00000
Processor #0 15:4 APIC version 17
I/O APIC #2 Version 3 at 0xFEC00000.
Processors: 1
Checking aperture...
CPU 0: aperture @ d0000000 size 128 MB
Built 1 zonelists
Kernel command line: ro root=LABEL=/ dumbcon=1 rhgb acpi=off quiet console=tty0
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 65536 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2000.107 MHz processor.
Console: Colour VGA+ 80x25 vc:1-16
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 509312k/524224k available (2408k kernel code, 14156k reserved, 1292k data, 164k init)
Calibrating delay loop... 3940.35 BogoMIPS (lpj=1970176)
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 08
Using local APIC NMI watchdog using perfctr0
Using IO-APIC 2
Using local APIC timer interrupts.
Detected 12.500 MHz APIC timer.
checking if image is initramfs... it is
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter disabled.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1106/3227] at 0000:00:11.0
PCI->APIC IRQ transform: (B0,I5,P0) -> 137
PCI->APIC IRQ transform: (B0,I5,P0) -> 137
PCI->APIC IRQ transform: (B0,I6,P0) -> 145
PCI->APIC IRQ transform: (B0,I8,P0) -> 153
PCI->APIC IRQ transform: (B0,I10,P0) -> 145
PCI->APIC IRQ transform: (B0,I11,P0) -> 137
PCI->APIC IRQ transform: (B0,I13,P0) -> 145
PCI->APIC IRQ transform: (B0,I14,P0) -> 153
PCI->APIC IRQ transform: (B0,I15,P1) -> 145
PCI->APIC IRQ transform: (B0,I15,P0) -> 145
PCI->APIC IRQ transform: (B0,I16,P0) -> 161
PCI->APIC IRQ transform: (B0,I16,P0) -> 161
PCI->APIC IRQ transform: (B0,I16,P1) -> 161
PCI->APIC IRQ transform: (B0,I16,P1) -> 161
PCI->APIC IRQ transform: (B0,I16,P2) -> 161
PCI->APIC IRQ transform: (B0,I17,P2) -> 169
PCI->APIC IRQ transform: (B1,I0,P0) -> 137
agpgart: Detected AGP bridge 0
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xd0000000
PCI-DMA: Disabling IOMMU.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1102064796.169:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key A617AC2237592777
- User ID: Red Hat, Inc. (Kernel Module GPG key)
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 1
PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 1
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 1
PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 1
PCI: Via IRQ fixup for 0000:00:11.5, from 3 to 9
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: probe of vesafb0 failed with error -6
Console: mono dummy device 80x25 vc:17-17
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 6Y120L0, ATA DISK drive
Using cfq io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: LITE-ON COMBO LTC-48161H, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
hdc: ATAPI 48X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
keyboard.c: [AT Raw Set 2 keyboard] vc:1-16
input: AT Raw Set 2 keyboard on isa0060/serio1
keyboard.c: [AT Translated Set 2 keyboard] vc:17-17
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 28Kbytes
TCP: Hash tables configured (established 32768 bind 4681)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09b)
powernow-k8: BIOS error - no PSB
Freeing unused kernel memory: 164k freed
SCSI subsystem initialized
libata version 1.02 loaded.
sata_via version 0.20
sata_via(0000:00:0f.0): routed to hard irq line 1
ata1: SATA max UDMA/133 cmd 0xD400 ctl 0xD002 bmdma 0xC400 irq 145
ata2: SATA max UDMA/133 cmd 0xCC00 ctl 0xC802 bmdma 0xC408 irq 145
ata1: no device found (phy stat 00000000)
scsi0 : sata_via
ata2: no device found (phy stat 00000000)
scsi1 : sata_via
sata_promise version 1.00
ata3: SATA max UDMA/133 cmd 0xFFFFFF0000054200 ctl 0xFFFFFF0000054238 bmdma 0x0 irq 145
ata4: SATA max UDMA/133 cmd 0xFFFFFF0000054280 ctl 0xFFFFFF00000542B8 bmdma 0x0 irq 145
ata3: no device found (phy stat 00000000)
scsi2 : sata_promise
ata4: no device found (phy stat 00000000)
scsi3 : sata_promise
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
security:  3 users, 4 roles, 305 types, 19 bools
security:  53 classes, 6688 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev hda10, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), not configured for labeling
SELinux: initialized (dev hugetlbfs, type hugetlbfs), not configured for labeling
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
inserting floppy driver for 2.6.9-1.681ruby_FC3.root
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
orinoco 0.13e (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
orinoco_pci 0.13e (Pavel Roskin <proski@gnu.org>, David Gibson <hermes@gibson.dropbear.id.au> & Jean Tourrilhes <jt@hpl.hp.com>)
orinoco_pci: Detected Orinoco/Prism2 PCI device at 0000:00:08.0, mem:0xCFBFD000 to 0xCFBFDFFF -> 0xffffff0000056000, irq:153
Reset done..............................................................................................................................................................................................................................................................;
Clear Reset............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................;
pci_cor : reg = 0x0 - FFFB9C12 - FFFB9A1E
divert: allocating divert_blk for eth0
eth0: Station identity 001f:0006:0001:0003
eth0: Looks like an Intersil firmware version 1.3.6
eth0: Ad-hoc demo mode supported
eth0: IEEE standard IBSS ad-hoc mode supported
eth0: WEP supported, 104-bit key
eth0: MAC address 00:09:5B:91:B2:E4
eth0: Station name "Prism  I"
eth0: ready
r8169 Gigabit Ethernet driver 1.2 loaded
r8169: NAPI enabled
divert: allocating divert_blk for eth1
eth1: Identified chip type is 'RTL8169s/8110s'.
eth1: RTL8169 at 0xffffff0000058f00, 00:0c:76:52:dc:54, IRQ 137
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 or dxs_support=4 option
         and report if it works on your machine.
PCI: Setting latency timer of device 0000:00:11.5 to 64
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: irq 161, pci mem ffffff0000156d00
SELinux: initialized (dev usbdevfs, type usbdevfs), uses genfs_contexts
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: irq 161, io base 000000000000b000
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: irq 161, io base 000000000000b400
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: irq 161, io base 000000000000b800
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: irq 161, io base 000000000000bc00
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[153]  MMIO=[cffee000-cffee7ff]  Max Packet=[2048]
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
usb 3-1: new low speed USB device using address 2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:10.1-1
usb 3-2: new low speed USB device using address 3
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0010dc00002c4af2]
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:10.1-2
usb 5-2: new full speed USB device using address 2
EXT3 FS on hda10, internal journal
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda1, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SGI XFS with ACLs, security attributes, large block/inode numbers, no debug enabled
SGI XFS Quota Management subsystem
XFS mounting filesystem hda2
Ending clean XFS mount for filesystem: hda2
SELinux: initialized (dev hda2, type xfs), uses xattr
XFS mounting filesystem hda5
Ending clean XFS mount for filesystem: hda5
SELinux: initialized (dev hda5, type xfs), uses xattr
XFS mounting filesystem hda7
Ending clean XFS mount for filesystem: hda7
SELinux: initialized (dev hda7, type xfs), uses xattr
XFS mounting filesystem hda11
Ending clean XFS mount for filesystem: hda11
SELinux: initialized (dev hda11, type xfs), uses xattr
XFS mounting filesystem hda6
Ending clean XFS mount for filesystem: hda6
SELinux: initialized (dev hda6, type xfs), uses xattr
XFS mounting filesystem hda9
Ending clean XFS mount for filesystem: hda9
SELinux: initialized (dev hda9, type xfs), uses xattr
XFS mounting filesystem hda8
Ending clean XFS mount for filesystem: hda8
SELinux: initialized (dev hda8, type xfs), uses xattr
SELinux: initialized (dev ramfs, type ramfs), uses genfs_contexts
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff80452a20(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
Adding 522104k swap on /dev/hda3.  Priority:-1 extents:1
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 496 bytes per conntrack
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
eth0: New link status: Connected (0001)
eth0: no IPv6 routers present
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
i2c /dev entries driver
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
lp0: console ready
vmmon: module license 'unspecified' taints kernel.
vmmon: no version for "sys_ioctl" found: kernel tainted.
/dev/vmmon: Module vmmon: registered with major=10 minor=165
/dev/vmmon: Module vmmon: initialized
/dev/vmnet: open called by PID 3421 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth1: peer interface eth1 not found, will wait for it to come up
bridge-eth1: attached
/dev/vmnet: open called by PID 3444 (vmnet-natd)
/dev/vmnet: hub 8 does not exist, allocating memory.
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 5557 (vmnet-netifup)
/dev/vmnet: hub 1 does not exist, allocating memory.
/dev/vmnet: port on hub 1 successfully opened
divert: allocating divert_blk for vmnet1
/dev/vmnet: open called by PID 5558 (vmnet-netifup)
/dev/vmnet: port on hub 8 successfully opened
divert: allocating divert_blk for vmnet8
/dev/vmnet: open called by PID 6111 (vmnet-dhcpd)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 6122 (vmnet-dhcpd)
/dev/vmnet: port on hub 1 successfully opened
[drm] Initialized radeon 1.11.0 20020828 on minor 0: 
[drm] Initialized radeon 1.11.0 20020828 on minor 1: 
vmnet1: no IPv6 routers present
vmnet8: no IPv6 routers present
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
cdrom: hdc: mrw address space DMA selected
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
SELinux: initialized (dev hdc, type iso9660), uses genfs_contexts
/dev/vmnet: open called by PID 7278 (vmware-vmx)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmmon: host clock rate change request 0 -> 19
/dev/vmmon: host clock rate change request 19 -> 0
vmmon: Had to deallocate locked 1280 pages from vm driver 0000010008e85c00
vmmon: Had to deallocate AWE 1430 pages from vm driver 0000010008e85c00
/dev/vmnet: open called by PID 7333 (vmware-vmx)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmmon: host clock rate change request 0 -> 19
/dev/vmmon: host clock rate change request 19 -> 63
/dev/vmmon: host clock rate change request 63 -> 200
/dev/vmmon: host clock rate change request 200 -> 201
/dev/vmmon: host clock rate change request 201 -> 1001
/dev/vmmon: host clock rate change request 1001 -> 201
/dev/vmmon: host clock rate change request 201 -> 1001
/dev/vmmon: host clock rate change request 1001 -> 201
/dev/vmmon: host clock rate change request 201 -> 1001
/dev/vmmon: host clock rate change request 1001 -> 201
Losing some ticks... checking if CPU frequency changed.
program eject is using a deprecated SCSI ioctl, please convert it to SG_IO
program eject is using a deprecated SCSI ioctl, please convert it to SG_IO
program eject is using a deprecated SCSI ioctl, please convert it to SG_IO
program eject is using a deprecated SCSI ioctl, please convert it to SG_IO
cdrom: hdc: mrw address space DMA selected
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
SELinux: initialized (dev hdc, type iso9660), uses genfs_contexts
cdrom: hdc: mrw address space DMA selected
cdrom: hdc: mrw address space DMA selected
cdrom: hdc: mrw address space DMA selected
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
SELinux: initialized (dev hdc, type iso9660), uses genfs_contexts
/dev/vmmon: host clock rate change request 201 -> 200
/dev/vmmon: host clock rate change request 200 -> 0
vmmon: Had to deallocate locked 29421 pages from vm driver 0000010001a67400
vmmon: Had to deallocate AWE 2729 pages from vm driver 0000010001a67400
application mozilla-bin uses obsolete OSS audio interface
warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip __do_softirq+0x41/0xa2
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hdc: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hdc: lost interrupt
java: page allocation failure. order:4, mode:0x50

Call Trace:<ffffffff80167d0a>{__alloc_pages+709} <ffffffff80167da4>{__get_free_pages+28} 
       <ffffffff8016bbb2>{kmem_getpages+31} <ffffffff8016c3aa>{cache_alloc_refill+1083} 
       <ffffffff8016beac>{__kmalloc+112} <ffffffffa022b255>{:xfs:kmem_alloc+93} 
       <ffffffffa022b30f>{:xfs:kmem_realloc+27} <ffffffffa020ca2d>{:xfs:xfs_iext_realloc+228} 
       <ffffffffa01e7d9e>{:xfs:xfs_bmap_insert_exlist+54} 
       <ffffffffa01e9044>{:xfs:xfs_bmap_add_extent+1017} <ffffffffa02128cb>{:xfs:xlog_assign_tail_lsn+16} 
       <ffffffffa022d6aa>{:xfs:pagebuf_rele+388} <ffffffffa01eff0d>{:xfs:xfs_bmbt_get_state+9} 
       <ffffffffa01ea3ef>{:xfs:xfs_bmap_do_search_extents+693} 
       <ffffffffa01ece2b>{:xfs:xfs_bmapi+5858} <ffffffffa01eff0d>{:xfs:xfs_bmbt_get_state+9} 
       <ffffffffa01ebac2>{:xfs:xfs_bmapi+889} <ffffffff80122312>{dma_map_sg+622} 
       <ffffffff802abf01>{ide_pci_register_driver+23} <ffffffffa021018f>{:xfs:xfs_iomap_write_delay+936} 
       <ffffffffa020f85e>{:xfs:xfs_iomap+614} <ffffffffa022c480>{:xfs:linvfs_get_block_core+116} 
       <ffffffff8018e9f5>{alloc_buffer_head+36} <ffffffffa022c5b6>{:xfs:linvfs_get_block+20} 
       <ffffffff8018f97c>{__block_prepare_write+341} <ffffffffa022c5a2>{:xfs:linvfs_get_block+0} 
       <ffffffff8018fbfb>{block_prepare_write+26} <ffffffff80164846>{generic_file_buffered_write+467} 
       <ffffffff8016356c>{find_get_pages_tag+179} <ffffffff8016278f>{__filemap_fdatawrite_range+101} 
       <ffffffff801ad670>{inode_update_time+147} <ffffffffa02330d7>{:xfs:xfs_write+1393} 
       <ffffffff8018a8ab>{do_sync_write+0} <ffffffffa022f708>{:xfs:linvfs_writev+216} 
       <ffffffff80135323>{autoremove_wake_function+0} <ffffffff801c2e75>{compat_do_readv_writev+447} 
       <ffffffffa02320ca>{:xfs:linvfs_getattr+40} <ffffffff8012642e>{sys32_fstat64+32} 
       <ffffffff8018a13a>{generic_file_llseek+46} <ffffffff801c2fdf>{compat_sys_writev+95} 
       <ffffffff80125dc3>{cstar_do_call+27} 
java: page allocation failure. order:4, mode:0x50

Call Trace:<ffffffff80167d0a>{__alloc_pages+709} <ffffffff80167da4>{__get_free_pages+28} 
       <ffffffff8016bbb2>{kmem_getpages+31} <ffffffff8016c3aa>{cache_alloc_refill+1083} 
       <ffffffff8016beac>{__kmalloc+112} <ffffffffa022b255>{:xfs:kmem_alloc+93} 
       <ffffffffa022b30f>{:xfs:kmem_realloc+27} <ffffffffa020ca2d>{:xfs:xfs_iext_realloc+228} 
       <ffffffffa01e7d9e>{:xfs:xfs_bmap_insert_exlist+54} 
       <ffffffffa01e9044>{:xfs:xfs_bmap_add_extent+1017} <ffffffffa02128cb>{:xfs:xlog_assign_tail_lsn+16} 
       <ffffffffa022d6aa>{:xfs:pagebuf_rele+388} <ffffffffa01eff0d>{:xfs:xfs_bmbt_get_state+9} 
       <ffffffffa01ea3ef>{:xfs:xfs_bmap_do_search_extents+693} 
       <ffffffffa01ece2b>{:xfs:xfs_bmapi+5858} <ffffffffa01eff0d>{:xfs:xfs_bmbt_get_state+9} 
       <ffffffffa01ebac2>{:xfs:xfs_bmapi+889} <ffffffff80122312>{dma_map_sg+622} 
       <ffffffff802abf01>{ide_pci_register_driver+23} <ffffffffa021018f>{:xfs:xfs_iomap_write_delay+936} 
       <ffffffffa020f85e>{:xfs:xfs_iomap+614} <ffffffffa022c480>{:xfs:linvfs_get_block_core+116} 
       <ffffffff8018e9f5>{alloc_buffer_head+36} <ffffffffa022c5b6>{:xfs:linvfs_get_block+20} 
       <ffffffff8018f97c>{__block_prepare_write+341} <ffffffffa022c5a2>{:xfs:linvfs_get_block+0} 
       <ffffffff8018fbfb>{block_prepare_write+26} <ffffffff80164846>{generic_file_buffered_write+467} 
       <ffffffff8016356c>{find_get_pages_tag+179} <ffffffff8016278f>{__filemap_fdatawrite_range+101} 
       <ffffffff801ad670>{inode_update_time+147} <ffffffffa02330d7>{:xfs:xfs_write+1393} 
       <ffffffff8018a8ab>{do_sync_write+0} <ffffffffa022f708>{:xfs:linvfs_writev+216} 
       <ffffffff80135323>{autoremove_wake_function+0} <ffffffff801c2e75>{compat_do_readv_writev+447} 
       <ffffffffa02320ca>{:xfs:linvfs_getattr+40} <ffffffff8012642e>{sys32_fstat64+32} 
       <ffffffff8018a13a>{generic_file_llseek+46} <ffffffff801c2fdf>{compat_sys_writev+95} 
       <ffffffff80125dc3>{cstar_do_call+27} 
java: page allocation failure. order:4, mode:0x50

Call Trace:<ffffffff80167d0a>{__alloc_pages+709} <ffffffff80167da4>{__get_free_pages+28} 
       <ffffffff8016bbb2>{kmem_getpages+31} <ffffffff8016c3aa>{cache_alloc_refill+1083} 
       <ffffffff8016beac>{__kmalloc+112} <ffffffffa022b255>{:xfs:kmem_alloc+93} 
       <ffffffffa022b30f>{:xfs:kmem_realloc+27} <ffffffffa020ca2d>{:xfs:xfs_iext_realloc+228} 
       <ffffffffa01e7d9e>{:xfs:xfs_bmap_insert_exlist+54} 
       <ffffffffa01e9044>{:xfs:xfs_bmap_add_extent+1017} <ffffffffa02128cb>{:xfs:xlog_assign_tail_lsn+16} 
       <ffffffffa022d6aa>{:xfs:pagebuf_rele+388} <ffffffffa01eff0d>{:xfs:xfs_bmbt_get_state+9} 
       <ffffffffa01ea3ef>{:xfs:xfs_bmap_do_search_extents+693} 
       <ffffffffa01ece2b>{:xfs:xfs_bmapi+5858} <ffffffffa01eff0d>{:xfs:xfs_bmbt_get_state+9} 
       <ffffffffa01ebac2>{:xfs:xfs_bmapi+889} <ffffffff80122312>{dma_map_sg+622} 
       <ffffffff802abf01>{ide_pci_register_driver+23} <ffffffffa021018f>{:xfs:xfs_iomap_write_delay+936} 
       <ffffffffa020f85e>{:xfs:xfs_iomap+614} <ffffffffa022c480>{:xfs:linvfs_get_block_core+116} 
       <ffffffff8018e9f5>{alloc_buffer_head+36} <ffffffffa022c5b6>{:xfs:linvfs_get_block+20} 
       <ffffffff8018f97c>{__block_prepare_write+341} <ffffffffa022c5a2>{:xfs:linvfs_get_block+0} 
       <ffffffff8018fbfb>{block_prepare_write+26} <ffffffff80164846>{generic_file_buffered_write+467} 
       <ffffffff8016356c>{find_get_pages_tag+179} <ffffffff8016278f>{__filemap_fdatawrite_range+101} 
       <ffffffff801ad670>{inode_update_time+147} <ffffffffa02330d7>{:xfs:xfs_write+1393} 
       <ffffffff8018a8ab>{do_sync_write+0} <ffffffffa022f708>{:xfs:linvfs_writev+216} 
       <ffffffff80135323>{autoremove_wake_function+0} <ffffffff801c2e75>{compat_do_readv_writev+447} 
       <ffffffffa02320ca>{:xfs:linvfs_getattr+40} <ffffffff8012642e>{sys32_fstat64+32} 
       <ffffffff8018a13a>{generic_file_llseek+46} <ffffffff801c2fdf>{compat_sys_writev+95} 
       <ffffffff80125dc3>{cstar_do_call+27} 
java: page allocation failure. order:4, mode:0x50

Call Trace:<ffffffff80167d0a>{__alloc_pages+709} <ffffffff80167da4>{__get_free_pages+28} 
       <ffffffff8016bbb2>{kmem_getpages+31} <ffffffff8016c3aa>{cache_alloc_refill+1083} 
       <ffffffff8016beac>{__kmalloc+112} <ffffffffa022b255>{:xfs:kmem_alloc+93} 
       <ffffffffa022b30f>{:xfs:kmem_realloc+27} <ffffffffa020ca2d>{:xfs:xfs_iext_realloc+228} 
       <ffffffffa01e7d9e>{:xfs:xfs_bmap_insert_exlist+54} 
       <ffffffffa01e9044>{:xfs:xfs_bmap_add_extent+1017} <ffffffffa02128cb>{:xfs:xlog_assign_tail_lsn+16} 
       <ffffffffa022d6aa>{:xfs:pagebuf_rele+388} <ffffffffa01eff0d>{:xfs:xfs_bmbt_get_state+9} 
       <ffffffffa01ea3ef>{:xfs:xfs_bmap_do_search_extents+693} 
       <ffffffffa01ece2b>{:xfs:xfs_bmapi+5858} <ffffffffa01eff0d>{:xfs:xfs_bmbt_get_state+9} 
       <ffffffffa01ebac2>{:xfs:xfs_bmapi+889} <ffffffff80122312>{dma_map_sg+622} 
       <ffffffff802abf01>{ide_pci_register_driver+23} <ffffffffa021018f>{:xfs:xfs_iomap_write_delay+936} 
       <ffffffffa020f85e>{:xfs:xfs_iomap+614} <ffffffffa022c480>{:xfs:linvfs_get_block_core+116} 
       <ffffffff8018e9f5>{alloc_buffer_head+36} <ffffffffa022c5b6>{:xfs:linvfs_get_block+20} 
       <ffffffff8018f97c>{__block_prepare_write+341} <ffffffffa022c5a2>{:xfs:linvfs_get_block+0} 
       <ffffffff8018fbfb>{block_prepare_write+26} <ffffffff80164846>{generic_file_buffered_write+467} 
       <ffffffff8016356c>{find_get_pages_tag+179} <ffffffff8016278f>{__filemap_fdatawrite_range+101} 
       <ffffffff801ad670>{inode_update_time+147} <ffffffffa02330d7>{:xfs:xfs_write+1393} 
       <ffffffff8018a8ab>{do_sync_write+0} <ffffffffa022f708>{:xfs:linvfs_writev+216} 
       <ffffffff80135323>{autoremove_wake_function+0} <ffffffff801c2e75>{compat_do_readv_writev+447} 
       <ffffffffa02320ca>{:xfs:linvfs_getattr+40} <ffffffff8012642e>{sys32_fstat64+32} 
       <ffffffff8018a13a>{generic_file_llseek+46} <ffffffff801c2fdf>{compat_sys_writev+95} 
       <ffffffff80125dc3>{cstar_do_call+27} 
java: page allocation failure. order:4, mode:0x50

Call Trace:<ffffffff80167d0a>{__alloc_pages+709} <ffffffff80167da4>{__get_free_pages+28} 
       <ffffffff8016bbb2>{kmem_getpages+31} <ffffffff8016c3aa>{cache_alloc_refill+1083} 
       <ffffffff8016beac>{__kmalloc+112} <ffffffffa022b255>{:xfs:kmem_alloc+93} 
       <ffffffffa022b30f>{:xfs:kmem_realloc+27} <ffffffffa020ca2d>{:xfs:xfs_iext_realloc+228} 
       <ffffffffa01e7d9e>{:xfs:xfs_bmap_insert_exlist+54} 
       <ffffffffa01e9044>{:xfs:xfs_bmap_add_extent+1017} <ffffffffa02128cb>{:xfs:xlog_assign_tail_lsn+16} 
       <ffffffffa022d6aa>{:xfs:pagebuf_rele+388} <ffffffffa01eff0d>{:xfs:xfs_bmbt_get_state+9} 
       <ffffffffa01ea3ef>{:xfs:xfs_bmap_do_search_extents+693} 
       <ffffffffa01ece2b>{:xfs:xfs_bmapi+5858} <ffffffffa01eff0d>{:xfs:xfs_bmbt_get_state+9} 
       <ffffffffa01ebac2>{:xfs:xfs_bmapi+889} <ffffffff80122312>{dma_map_sg+622} 
       <ffffffff802abf01>{ide_pci_register_driver+23} <ffffffffa021018f>{:xfs:xfs_iomap_write_delay+936} 
       <ffffffffa020f85e>{:xfs:xfs_iomap+614} <ffffffffa022c480>{:xfs:linvfs_get_block_core+116} 
       <ffffffff8018e9f5>{alloc_buffer_head+36} <ffffffffa022c5b6>{:xfs:linvfs_get_block+20} 
       <ffffffff8018f97c>{__block_prepare_write+341} <ffffffffa022c5a2>{:xfs:linvfs_get_block+0} 
       <ffffffff8018fbfb>{block_prepare_write+26} <ffffffff80164846>{generic_file_buffered_write+467} 
       <ffffffff8016356c>{find_get_pages_tag+179} <ffffffff8016278f>{__filemap_fdatawrite_range+101} 
       <ffffffff801ad670>{inode_update_time+147} <ffffffffa02330d7>{:xfs:xfs_write+1393} 
       <ffffffff8018a8ab>{do_sync_write+0} <ffffffffa022f708>{:xfs:linvfs_writev+216} 
       <ffffffff80135323>{autoremove_wake_function+0} <ffffffff801c2e75>{compat_do_readv_writev+447} 
       <ffffffffa02320ca>{:xfs:linvfs_getattr+40} <ffffffff8012642e>{sys32_fstat64+32} 
       <ffffffff8018a13a>{generic_file_llseek+46} <ffffffff801c2fdf>{compat_sys_writev+95} 
       <ffffffff80125dc3>{cstar_do_call+27} 
java: page allocation failure. order:4, mode:0x50

Call Trace:<ffffffff80167d0a>{__alloc_pages+709} <ffffffff80167da4>{__get_free_pages+28} 
       <ffffffff8016bbb2>{kmem_getpages+31} <ffffffff8016c3aa>{cache_alloc_refill+1083} 
       <ffffffff8016beac>{__kmalloc+112} <ffffffffa022b255>{:xfs:kmem_alloc+93} 
       <ffffffffa022b30f>{:xfs:kmem_realloc+27} <ffffffffa020ca2d>{:xfs:xfs_iext_realloc+228} 
       <ffffffffa01e7d9e>{:xfs:xfs_bmap_insert_exlist+54} 
       <ffffffffa01e9044>{:xfs:xfs_bmap_add_extent+1017} <ffffffffa02128cb>{:xfs:xlog_assign_tail_lsn+16} 
       <ffffffffa022d6aa>{:xfs:pagebuf_rele+388} <ffffffffa01eff0d>{:xfs:xfs_bmbt_get_state+9} 
       <ffffffffa01ea3ef>{:xfs:xfs_bmap_do_search_extents+693} 
       <ffffffffa01ece2b>{:xfs:xfs_bmapi+5858} <ffffffffa01eff0d>{:xfs:xfs_bmbt_get_state+9} 
       <ffffffffa01ebac2>{:xfs:xfs_bmapi+889} <ffffffff80122312>{dma_map_sg+622} 
       <ffffffff802abf01>{ide_pci_register_driver+23} <ffffffffa021018f>{:xfs:xfs_iomap_write_delay+936} 
       <ffffffffa020f85e>{:xfs:xfs_iomap+614} <ffffffffa022c480>{:xfs:linvfs_get_block_core+116} 
       <ffffffff8018e9f5>{alloc_buffer_head+36} <ffffffffa022c5b6>{:xfs:linvfs_get_block+20} 
       <ffffffff8018f97c>{__block_prepare_write+341} <ffffffffa022c5a2>{:xfs:linvfs_get_block+0} 
       <ffffffff8018fbfb>{block_prepare_write+26} <ffffffff80164846>{generic_file_buffered_write+467} 
       <ffffffff8016356c>{find_get_pages_tag+179} <ffffffff8016278f>{__filemap_fdatawrite_range+101} 
       <ffffffff801ad670>{inode_update_time+147} <ffffffffa02330d7>{:xfs:xfs_write+1393} 
       <ffffffff8018a8ab>{do_sync_write+0} <ffffffffa022f708>{:xfs:linvfs_writev+216} 
       <ffffffff80135323>{autoremove_wake_function+0} <ffffffff801c2e75>{compat_do_readv_writev+447} 
       <ffffffffa02320ca>{:xfs:linvfs_getattr+40} <ffffffff8012642e>{sys32_fstat64+32} 
       <ffffffff8018a13a>{generic_file_llseek+46} <ffffffff801c2fdf>{compat_sys_writev+95} 
       <ffffffff80125dc3>{cstar_do_call+27} 
java: page allocation failure. order:4, mode:0x50

Call Trace:<ffffffff80167d0a>{__alloc_pages+709} <ffffffff80167da4>{__get_free_pages+28} 
       <ffffffff8016bbb2>{kmem_getpages+31} <ffffffff8016c3aa>{cache_alloc_refill+1083} 
       <ffffffff8016beac>{__kmalloc+112} <ffffffffa022b255>{:xfs:kmem_alloc+93} 
       <ffffffffa022b30f>{:xfs:kmem_realloc+27} <ffffffffa020ca2d>{:xfs:xfs_iext_realloc+228} 
       <ffffffffa01e7d9e>{:xfs:xfs_bmap_insert_exlist+54} 
       <ffffffffa01e9044>{:xfs:xfs_bmap_add_extent+1017} <ffffffffa02128cb>{:xfs:xlog_assign_tail_lsn+16} 
       <ffffffffa022d6aa>{:xfs:pagebuf_rele+388} <ffffffffa01eff0d>{:xfs:xfs_bmbt_get_state+9} 
       <ffffffffa01ea3ef>{:xfs:xfs_bmap_do_search_extents+693} 
       <ffffffffa01ece2b>{:xfs:xfs_bmapi+5858} <ffffffffa01eff0d>{:xfs:xfs_bmbt_get_state+9} 
       <ffffffffa01ebac2>{:xfs:xfs_bmapi+889} <ffffffff80122312>{dma_map_sg+622} 
       <ffffffff802abf01>{ide_pci_register_driver+23} <ffffffffa021018f>{:xfs:xfs_iomap_write_delay+936} 
       <ffffffffa020f85e>{:xfs:xfs_iomap+614} <ffffffffa022c480>{:xfs:linvfs_get_block_core+116} 
       <ffffffff8018e9f5>{alloc_buffer_head+36} <ffffffffa022c5b6>{:xfs:linvfs_get_block+20} 
       <ffffffff8018f97c>{__block_prepare_write+341} <ffffffffa022c5a2>{:xfs:linvfs_get_block+0} 
       <ffffffff8018fbfb>{block_prepare_write+26} <ffffffff80164846>{generic_file_buffered_write+467} 
       <ffffffff8016356c>{find_get_pages_tag+179} <ffffffff8016278f>{__filemap_fdatawrite_range+101} 
       <ffffffff801ad670>{inode_update_time+147} <ffffffffa02330d7>{:xfs:xfs_write+1393} 
       <ffffffff8018a8ab>{do_sync_write+0} <ffffffffa022f708>{:xfs:linvfs_writev+216} 
       <ffffffff80135323>{autoremove_wake_function+0} <ffffffff801c2e75>{compat_do_readv_writev+447} 
       <ffffffffa02320ca>{:xfs:linvfs_getattr+40} <ffffffff8012642e>{sys32_fstat64+32} 
       <ffffffff8018a13a>{generic_file_llseek+46} <ffffffff801c2fdf>{compat_sys_writev+95} 
       <ffffffff80125dc3>{cstar_do_call+27} 
java: page allocation failure. order:4, mode:0x50

Call Trace:<ffffffff80167d0a>{__alloc_pages+709} <ffffffff80167da4>{__get_free_pages+28} 
       <ffffffff8016bbb2>{kmem_getpages+31} <ffffffff8016c3aa>{cache_alloc_refill+1083} 
       <ffffffff8016beac>{__kmalloc+112} <ffffffffa022b255>{:xfs:kmem_alloc+93} 
       <ffffffffa022b30f>{:xfs:kmem_realloc+27} <ffffffffa020ca2d>{:xfs:xfs_iext_realloc+228} 
       <ffffffffa01e7d9e>{:xfs:xfs_bmap_insert_exlist+54} 
       <ffffffffa01e9044>{:xfs:xfs_bmap_add_extent+1017} <ffffffffa02128cb>{:xfs:xlog_assign_tail_lsn+16} 
       <ffffffffa022d6aa>{:xfs:pagebuf_rele+388} <ffffffffa01eff0d>{:xfs:xfs_bmbt_get_state+9} 
       <ffffffffa01ea3ef>{:xfs:xfs_bmap_do_search_extents+693} 
       <ffffffffa01ece2b>{:xfs:xfs_bmapi+5858} <ffffffffa01eff0d>{:xfs:xfs_bmbt_get_state+9} 
       <ffffffffa01ebac2>{:xfs:xfs_bmapi+889} <ffffffff80122312>{dma_map_sg+622} 
       <ffffffff802abf01>{ide_pci_register_driver+23} <ffffffffa021018f>{:xfs:xfs_iomap_write_delay+936} 
       <ffffffffa020f85e>{:xfs:xfs_iomap+614} <ffffffffa022c480>{:xfs:linvfs_get_block_core+116} 
       <ffffffff8018e9f5>{alloc_buffer_head+36} <ffffffffa022c5b6>{:xfs:linvfs_get_block+20} 
       <ffffffff8018f97c>{__block_prepare_write+341} <ffffffffa022c5a2>{:xfs:linvfs_get_block+0} 
       <ffffffff8018fbfb>{block_prepare_write+26} <ffffffff80164846>{generic_file_buffered_write+467} 
       <ffffffff8016356c>{find_get_pages_tag+179} <ffffffff8016278f>{__filemap_fdatawrite_range+101} 
       <ffffffff801ad670>{inode_update_time+147} <ffffffffa02330d7>{:xfs:xfs_write+1393} 
       <ffffffff8018a8ab>{do_sync_write+0} <ffffffffa022f708>{:xfs:linvfs_writev+216} 
       <ffffffff80135323>{autoremove_wake_function+0} <ffffffff801c2e75>{compat_do_readv_writev+447} 
       <ffffffffa02320ca>{:xfs:linvfs_getattr+40} <ffffffff8012642e>{sys32_fstat64+32} 
       <ffffffff8018a13a>{generic_file_llseek+46} <ffffffff801c2fdf>{compat_sys_writev+95} 
       <ffffffff80125dc3>{cstar_do_call+27} 
java: page allocation failure. order:4, mode:0x50

Call Trace:<ffffffff80167d0a>{__alloc_pages+709} <ffffffff80167da4>{__get_free_pages+28} 
       <ffffffff8016bbb2>{kmem_getpages+31} <ffffffff8016c3aa>{cache_alloc_refill+1083} 
       <ffffffff8016beac>{__kmalloc+112} <ffffffffa022b255>{:xfs:kmem_alloc+93} 
       <ffffffffa022b30f>{:xfs:kmem_realloc+27} <ffffffffa020ca2d>{:xfs:xfs_iext_realloc+228} 
       <ffffffffa01e7d9e>{:xfs:xfs_bmap_insert_exlist+54} 
       <ffffffffa01e9044>{:xfs:xfs_bmap_add_extent+1017} <ffffffffa02128cb>{:xfs:xlog_assign_tail_lsn+16} 
       <ffffffffa022d6aa>{:xfs:pagebuf_rele+388} <ffffffffa01eff0d>{:xfs:xfs_bmbt_get_state+9} 
       <ffffffffa01ea3ef>{:xfs:xfs_bmap_do_search_extents+693} 
       <ffffffffa01ece2b>{:xfs:xfs_bmapi+5858} <ffffffffa01eff0d>{:xfs:xfs_bmbt_get_state+9} 
       <ffffffffa01ebac2>{:xfs:xfs_bmapi+889} <ffffffff80122312>{dma_map_sg+622} 
       <ffffffff802abf01>{ide_pci_register_driver+23} <ffffffffa021018f>{:xfs:xfs_iomap_write_delay+936} 
       <ffffffffa020f85e>{:xfs:xfs_iomap+614} <ffffffffa022c480>{:xfs:linvfs_get_block_core+116} 
       <ffffffff8018e9f5>{alloc_buffer_head+36} <ffffffffa022c5b6>{:xfs:linvfs_get_block+20} 
       <ffffffff8018f97c>{__block_prepare_write+341} <ffffffffa022c5a2>{:xfs:linvfs_get_block+0} 
       <ffffffff8018fbfb>{block_prepare_write+26} <ffffffff80164846>{generic_file_buffered_write+467} 
       <ffffffff8016356c>{find_get_pages_tag+179} <ffffffff8016278f>{__filemap_fdatawrite_range+101} 
       <ffffffff801ad670>{inode_update_time+147} <ffffffffa02330d7>{:xfs:xfs_write+1393} 
       <ffffffff8018a8ab>{do_sync_write+0} <ffffffffa022f708>{:xfs:linvfs_writev+216} 
       <ffffffff80135323>{autoremove_wake_function+0} <ffffffff801c2e75>{compat_do_readv_writev+447} 
       <ffffffffa02320ca>{:xfs:linvfs_getattr+40} <ffffffff8012642e>{sys32_fstat64+32} 
       <ffffffff8018a13a>{generic_file_llseek+46} <ffffffff801c2fdf>{compat_sys_writev+95} 
       <ffffffff80125dc3>{cstar_do_call+27} 
java: page allocation failure. order:4, mode:0x50

Call Trace:<ffffffff80167d0a>{__alloc_pages+709} <ffffffff80167da4>{__get_free_pages+28} 
       <ffffffff8016bbb2>{kmem_getpages+31} <ffffffff8016c3aa>{cache_alloc_refill+1083} 
       <ffffffff8016beac>{__kmalloc+112} <ffffffffa022b255>{:xfs:kmem_alloc+93} 
       <ffffffffa022b30f>{:xfs:kmem_realloc+27} <ffffffffa020ca2d>{:xfs:xfs_iext_realloc+228} 
       <ffffffffa01e7d9e>{:xfs:xfs_bmap_insert_exlist+54} 
       <ffffffffa01e9044>{:xfs:xfs_bmap_add_extent+1017} <ffffffffa02128cb>{:xfs:xlog_assign_tail_lsn+16} 
       <ffffffffa022d6aa>{:xfs:pagebuf_rele+388} <ffffffffa01eff0d>{:xfs:xfs_bmbt_get_state+9} 
       <ffffffffa01ea3ef>{:xfs:xfs_bmap_do_search_extents+693} 
       <ffffffffa01ece2b>{:xfs:xfs_bmapi+5858} <ffffffffa01eff0d>{:xfs:xfs_bmbt_get_state+9} 
       <ffffffffa01ebac2>{:xfs:xfs_bmapi+889} <ffffffff80122312>{dma_map_sg+622} 
       <ffffffff802abf01>{ide_pci_register_driver+23} <ffffffffa021018f>{:xfs:xfs_iomap_write_delay+936} 
       <ffffffffa020f85e>{:xfs:xfs_iomap+614} <ffffffffa022c480>{:xfs:linvfs_get_block_core+116} 
       <ffffffff8018e9f5>{alloc_buffer_head+36} <ffffffffa022c5b6>{:xfs:linvfs_get_block+20} 
       <ffffffff8018f97c>{__block_prepare_write+341} <ffffffffa022c5a2>{:xfs:linvfs_get_block+0} 
       <ffffffff8018fbfb>{block_prepare_write+26} <ffffffff80164846>{generic_file_buffered_write+467} 
       <ffffffff8016356c>{find_get_pages_tag+179} <ffffffff8016278f>{__filemap_fdatawrite_range+101} 
       <ffffffff801ad670>{inode_update_time+147} <ffffffffa02330d7>{:xfs:xfs_write+1393} 
       <ffffffff8018a8ab>{do_sync_write+0} <ffffffffa022f708>{:xfs:linvfs_writev+216} 
       <ffffffff80135323>{autoremove_wake_function+0} <ffffffff801c2e75>{compat_do_readv_writev+447} 
       <ffffffffa02320ca>{:xfs:linvfs_getattr+40} <ffffffff8012642e>{sys32_fstat64+32} 
       <ffffffff8018a13a>{generic_file_llseek+46} <ffffffff801c2fdf>{compat_sys_writev+95} 
       <ffffffff80125dc3>{cstar_do_call+27} 
possible deadlock in kmem_alloc (mode:0x50)
possible deadlock in kmem_alloc (mode:0x50)
possible deadlock in kmem_alloc (mode:0x50)
possible deadlock in kmem_alloc (mode:0x50)
possible deadlock in kmem_alloc (mode:0x50)
possible deadlock in kmem_alloc (mode:0x50)
hdc: lost interrupt
hdc: lost interrupt
hdc: lost interrupt
cdrom: hdc: mrw address space DMA selected
cdrom: hdc: mrw address space DMA selected
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
SELinux: initialized (dev hdc, type iso9660), uses genfs_contexts
ide-cd: cmd 0x28 timed out
hdc: DMA interrupt recovery
hdc: lost interrupt
ide-cd: cmd 0x28 timed out
hdc: DMA interrupt recovery
hdc: lost interrupt
ide-cd: cmd 0x28 timed out
hdc: DMA interrupt recovery
hdc: lost interrupt
ide-cd: cmd 0x28 timed out
hdc: DMA interrupt recovery
hdc: lost interrupt
hdc: lost interrupt
hdc: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hdc: lost interrupt
eth0: New link status: Disconnected (0002)
eth0: New link status: Association Failed (0006)
eth0: New link status: Connected (0001)
hdc: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
cdrom: hdc: mrw address space DMA selected
cdrom: hdc: mrw address space DMA selected
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
SELinux: initialized (dev hdc, type iso9660), uses genfs_contexts
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
ide-cd: cmd 0x28 timed out
hdc: DMA interrupt recovery
hdc: lost interrupt
ide-cd: cmd 0x28 timed out
hdc: DMA interrupt recovery
hdc: lost interrupt

--------------080600020901000002080807
Content-Type: text/plain;
 name="dmesg-2610rc3ruby.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2610rc3ruby.log"

Bootdata ok (command line is ro root=LABEL=/ dumbcon=1 single elevator=cfq)
Linux version 2.6.10-rc3-ruby (zozo@wl-193.226.227-37-szolnok.dunaweb.hu) (gcc version 3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #2 Sun Dec 5 13:21:42 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000cc000 - 00000000000d6000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
No mptable found.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 AMI                                   ) @ 0x00000000000fa3f0
ACPI: RSDT (v001 AMIINT VIA_K8   0x00000010 MSFT 0x00000097) @ 0x000000001fff0000
ACPI: FADT (v001 AMIINT VIA_K8   0x00000011 MSFT 0x00000097) @ 0x000000001fff0030
ACPI: MADT (v001 AMIINT VIA_K8   0x00000009 MSFT 0x00000097) @ 0x000000001fff00c0
ACPI: DSDT (v001    VIA   VIA_K8 0x00001000 MSFT 0x0100000d) @ 0x0000000000000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ d0000000 size 128 MB
Built 1 zonelists
Kernel command line: ro root=LABEL=/ dumbcon=1 single elevator=cfq console=tty0
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 65536 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2000.102 MHz processor.
Console: Colour VGA+ 80x25 vc:1-16
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 509668k/524224k available (2547k kernel code, 13796k reserved, 831k data, 176k init)
Calibrating delay loop... 3940.35 BogoMIPS (lpj=1970176)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 08
Using local APIC NMI watchdog using perfctr0
Using local APIC timer interrupts.
Detected 12.500 MHz APIC timer.
checking if image is initramfs... it is
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 9 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
agpgart: Detected AGP bridge 0
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xd0000000
PCI-DMA: Disabling IOMMU.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1102255340.225:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
seclvl: seclvl_init: seclvl: Failure registering with the kernel.
selinux_register_security:  There is already a secondary security module registered.
seclvl: seclvl_init: seclvl: Failure registering with primary security module.
seclvl: Error during initialization: rc = [-22]
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Console: mono dummy device 80x25 vc:17-17
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 169
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 6Y120L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: LITE-ON COMBO LTC-48161H, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
hdc: ATAPI 48X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
keyboard.c: [AT Raw Set 2 keyboard] vc:1-16
input: AT Raw Set 2 keyboard on isa0060/serio1
keyboard.c: [AT Translated Set 2 keyboard] vc:17-17
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 28Kbytes
TCP: Hash tables configured (established 32768 bind 4681)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09e)
powernow-k8: BIOS error - no PSB
ACPI wakeup devices: 
PCI0 UAR1 USB1 USB2 USB3 USB4 EHCI USBD  AC9  MC9 ILAN SLPB 
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 176k freed
SCSI subsystem initialized
libata version 1.10 loaded.
sata_via version 1.0
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 169
sata_via(0000:00:0f.0): routed to hard irq line 10
ata1: SATA max UDMA/133 cmd 0xD400 ctl 0xD002 bmdma 0xC400 irq 169
ata2: SATA max UDMA/133 cmd 0xCC00 ctl 0xC802 bmdma 0xC408 irq 169
ata1: no device found (phy stat 00000000)
scsi0 : sata_via
ata2: no device found (phy stat 00000000)
scsi1 : sata_via
sata_promise version 1.01
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 177
ata3: SATA max UDMA/133 cmd 0xFFFFFF000001A200 ctl 0xFFFFFF000001A238 bmdma 0x0 irq 177
ata4: SATA max UDMA/133 cmd 0xFFFFFF000001A280 ctl 0xFFFFFF000001A2B8 bmdma 0x0 irq 177
ata3: no device found (phy stat 00000000)
scsi2 : sata_promise
ata4: no device found (phy stat 00000000)
scsi3 : sata_promise
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
security:  3 users, 4 roles, 305 types, 19 bools
security:  53 classes, 6688 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev hda10, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), not configured for labeling
SELinux: initialized (dev hugetlbfs, type hugetlbfs), not configured for labeling
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
inserting floppy driver for 2.6.10-rc3-ruby
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
orinoco 0.13e (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
orinoco_pci 0.13e (Pavel Roskin <proski@gnu.org>, David Gibson <hermes@gibson.dropbear.id.au> & Jean Tourrilhes <jt@hpl.hp.com>)
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 19 (level, low) -> IRQ 185
orinoco_pci: Detected Orinoco/Prism2 PCI device at 0000:00:08.0, mem:0xCFBFD000 to 0xCFBFDFFF -> 0xffffff000001c000, irq:185
Reset done..............................................................................................................................................................................................................................................................;
Clear Reset...........................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................;
pci_cor : reg = 0x0 - FFFB9F02 - FFFB9D0E
divert: allocating divert_blk for eth0
eth0: Station identity 001f:0006:0001:0003
eth0: Looks like an Intersil firmware version 1.3.6
eth0: Ad-hoc demo mode supported
eth0: IEEE standard IBSS ad-hoc mode supported
eth0: WEP supported, 104-bit key
eth0: MAC address 00:09:5B:91:B2:E4
eth0: Station name "Prism  I"
eth0: ready
r8169 Gigabit Ethernet driver 1.2 loaded
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 16 (level, low) -> IRQ 193
r8169: NAPI enabled
divert: allocating divert_blk for eth1
eth1: Identified chip type is 'RTL8169s/8110s'.
eth1: RTL8169 at 0xffffff000001ef00, 00:0c:76:52:dc:54, IRQ 193
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 or dxs_support=4 option
         and report if it works on your machine.
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 201
PCI: Via IRQ fixup for 0000:00:11.5, from 3 to 9
PCI: Setting latency timer of device 0000:00:11.5 to 64
ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 209
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: irq 209, pci mem 0xcfffbd00
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 209
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 1
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: irq 209, io base 0xb000
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 209
PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 1
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: irq 209, io base 0xb400
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 209
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 1
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: irq 209, io base 0xb800
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 209
PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 1
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: irq 209, io base 0xbc00
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 185
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[185]  MMIO=[cffee000-cffee7ff]  Max Packet=[2048]
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
usb 3-1: new low speed USB device using uhci_hcd and address 2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:10.1-1
usb 3-2: new low speed USB device using uhci_hcd and address 3
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ibm_acpi: ec object not found
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:10.1-2
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0010dc00002c4af2]
usb 5-2: new full speed USB device using uhci_hcd and address 2
EXT3 FS on hda10, internal journal
device-mapper: 4.3.0-ioctl (2004-09-30) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda1, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SGI XFS with ACLs, security attributes, large block/inode numbers, no debug enabled
SGI XFS Quota Management subsystem
XFS mounting filesystem hda2
Starting XFS recovery on filesystem: hda2 (dev: hda2)
Ending XFS recovery on filesystem: hda2 (dev: hda2)
SELinux: initialized (dev hda2, type xfs), uses xattr
XFS mounting filesystem hda5
Ending clean XFS mount for filesystem: hda5
SELinux: initialized (dev hda5, type xfs), uses xattr
XFS mounting filesystem hda7
Starting XFS recovery on filesystem: hda7 (dev: hda7)
Ending XFS recovery on filesystem: hda7 (dev: hda7)
SELinux: initialized (dev hda7, type xfs), uses xattr
XFS mounting filesystem hda11
Starting XFS recovery on filesystem: hda11 (dev: hda11)
Ending XFS recovery on filesystem: hda11 (dev: hda11)
SELinux: initialized (dev hda11, type xfs), uses xattr
XFS mounting filesystem hda6
Starting XFS recovery on filesystem: hda6 (dev: hda6)
Ending XFS recovery on filesystem: hda6 (dev: hda6)
SELinux: initialized (dev hda6, type xfs), uses xattr
XFS mounting filesystem hda9
Starting XFS recovery on filesystem: hda9 (dev: hda9)
Ending XFS recovery on filesystem: hda9 (dev: hda9)
SELinux: initialized (dev hda9, type xfs), uses xattr
XFS mounting filesystem hda8
Starting XFS recovery on filesystem: hda8 (dev: hda8)
Ending XFS recovery on filesystem: hda8 (dev: hda8)
SELinux: initialized (dev hda8, type xfs), uses xattr
Adding 522104k swap on /dev/hda3.  Priority:-1 extents:1
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
parport_pc: Ignoring new-style parameters in presence of obsolete ones
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,EPP]
Trying to free free DMA3
pnp: Device 00:02 disabled.
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 504 bytes per conntrack
eth0: New link status: Connected (0001)
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
i2c /dev entries driver
parport_pc: Ignoring new-style parameters in presence of obsolete ones
pnp: Device 00:02 activated.
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,EPP]
lp0: using parport0 (interrupt-driven).
lp0: console ready
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff8040aa60(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
eth0: no IPv6 routers present
vmmon: module license 'unspecified' taints kernel.
/dev/vmmon: Module vmmon: registered with major=10 minor=165
/dev/vmmon: Module vmmon: initialized
/dev/vmnet: open called by PID 5010 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth1: peer interface eth1 not found, will wait for it to come up
bridge-eth1: attached
/dev/vmnet: open called by PID 5093 (vmnet-natd)
/dev/vmnet: hub 8 does not exist, allocating memory.
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 7526 (vmnet-netifup)
/dev/vmnet: port on hub 8 successfully opened
divert: allocating divert_blk for vmnet8
/dev/vmnet: open called by PID 7525 (vmnet-netifup)
/dev/vmnet: hub 1 does not exist, allocating memory.
/dev/vmnet: port on hub 1 successfully opened
divert: allocating divert_blk for vmnet1
/dev/vmnet: open called by PID 7766 (vmnet-dhcpd)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 7635 (vmnet-dhcpd)
/dev/vmnet: port on hub 1 successfully opened
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 17 (level, low) -> IRQ 177
[drm] Initialized radeon 1.11.0 20020828 on minor 0: 
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 193
[drm] Initialized radeon 1.11.0 20020828 on minor 1: 
vmnet1: no IPv6 routers present
vmnet8: no IPv6 routers present
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
/dev/vmnet: open called by PID 8847 (vmware-vmx)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmmon: host clock rate change request 0 -> 19
/dev/vmmon: host clock rate change request 19 -> 0
vmmon: Had to deallocate locked 1280 pages from vm driver 0000010010219c00
vmmon: Had to deallocate AWE 1396 pages from vm driver 0000010010219c00
/dev/vmnet: open called by PID 8917 (vmware-vmx)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmmon: host clock rate change request 0 -> 19
/dev/vmmon: host clock rate change request 19 -> 63
/dev/vmmon: host clock rate change request 63 -> 200
/dev/vmmon: host clock rate change request 200 -> 201
Losing some ticks... checking if CPU frequency changed.

--------------080600020901000002080807--
