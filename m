Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262984AbVCXCIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbVCXCIf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 21:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262985AbVCXCIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 21:08:35 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:65413 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S262984AbVCXCDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 21:03:33 -0500
Message-ID: <42421FF2.7050501@candelatech.com>
Date: Wed, 23 Mar 2005 18:03:30 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: PCI interrupt problem: e1000 & Super-Micro X6DVA motherboard
Content-Type: multipart/mixed;
 boundary="------------080905060405030905030507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080905060405030905030507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I'm having a strange problem.  I have an X6DVA motherboard
with dual 2.8Ghz emt-64 processors, 1GB of RAM, SATA HD, etc.

I have two 4-port e1000 NICs in the system, on a riser card.  There
are also 2 built-in e1000s and an e100 in the 32-bit slot of the PCI
riser.

Regardless of which way order I put the 4-port NICs in, eth3 does
not get it's IRQ set up right.  (eth3 follows the physical position,
not the NICs, so I get the same failure on either NIC).

The problem seems to be that no interrupts are ever delivered for
this interface, and 'ethtool -t eth3' fails the interrupt test with value '4'.
When trying to send/receive traffic, I get TX watchdog timeouts.  The other
interfaces seem to work just fine.

I tried kernel 2.6.11 which uses irq 26, and 2.6.10-1.770_FC2smp, which
maps the irq to 209 or something like that.  Distribution is FC2, x86.
Kernel is compiled for x86-SMP as well.

I suspect that this may be a hardware issue of some sort, but if anyone
has any suggestions as to how to debug this further, please do let
me know.  I'm attaching the lspci and dmesg output in case that helps.

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


--------------080905060405030905030507
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 04
Booting processor 2/6 eip 3000
Initializing CPU#2
Calibrating delay loop... 5586.94 BogoMIPS (lpj=2793472)
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000441d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000 0000441d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000080 0000441d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU2: Intel P4/Xeon Extended MCE MSRs (24) available
CPU2: Thermal monitoring enabled
CPU2: Intel(R) Xeon(TM) CPU 2.80GHz stepping 04
Booting processor 3/7 eip 3000
Initializing CPU#3
Calibrating delay loop... 5586.94 BogoMIPS (lpj=2793472)
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000441d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000 0000441d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000080 0000441d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU3: Intel P4/Xeon Extended MCE MSRs (24) available
CPU3: Thermal monitoring enabled
CPU3: Intel(R) Xeon(TM) CPU 2.80GHz stepping 04
Total of 4 processors activated (22298.62 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 4 CPUs: passed.
Brought up 4 CPUs
CPU0 attaching sched-domain:
 domain 0: span 03
  groups: 01 02
  domain 1: span 0f
   groups: 03 0c
CPU1 attaching sched-domain:
 domain 0: span 03
  groups: 02 01
  domain 1: span 0f
   groups: 03 0c
CPU2 attaching sched-domain:
 domain 0: span 0c
  groups: 04 08
  domain 1: span 0f
   groups: 0c 03
CPU3 attaching sched-domain:
 domain 0: span 0c
  groups: 08 04
  domain 1: span 0f
   groups: 0c 03
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 294k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=8
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050211
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EPA0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EPA0.PXHA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EPA0.PXHB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EPA1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0PC._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
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
pnp: 00:09: ioport range 0x200-0x207 has been reserved
pnp: 00:09: ioport range 0x295-0x296 has been reserved
pnp: 00:09: ioport range 0x330-0x331 has been reserved
pnp: 00:09: ioport range 0xb78-0xb7f has been reserved
pnp: 00:0c: ioport range 0x680-0x6ff has been reserved
apm: BIOS not found.
audit: initializing netlink socket (disabled)
audit(1111632428.145:0): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
cpci_hotplug: CompactPCI Hot Plug Core version: 0.2
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:02.0 to 64
Allocate Port Service[pcie00]
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:03.0 to 64
Allocate Port Service[pcie00]
ACPI: Processor [CPU1] (supports 8 throttling states)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0: I/O resource 0x1F0-0x1F7 not free.
ide0: ports already in use, skipping probe
Probing IDE interface ide1...
hdc: SONY CD-ROM CDU5212, ATAPI CD/DVD-ROM drive
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 40X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
ACPI wakeup devices: 
EPA0 PXHA PXHB EPA1 EPB0 EPB1 EPC0 P0P1 MC97 USB1 USB2 EUSB PS2K PS2M P0PC SLPB 
ACPI: (supports S0 S1 S4 S4bios S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
SCSI subsystem initialized
libata version 1.10 loaded.
ata_piix version 1.03
ata_piix: combined mode detected
ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
ata: 0x170 IDE port busy
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFC00 irq 14
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 160086528 sectors:
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 232k freed
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ibm_acpi: ec object not found
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: Intel Corp. 6300ESB USB Universal Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0xec00
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
EXT3 FS on sda2, internal journal
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
cdrom: open failed.
Adding 2040244k swap on /dev/sda3.  Priority:-1 extents:1
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
program scsi_unique_id is using a deprecated SCSI ioctl, please convert it to SG_IO
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
microcode: CPU2 updated from revision 0xe to 0x13, date = 07302004 
microcode: CPU0 updated from revision 0xe to 0x13, date = 07302004 
microcode: CPU1 updated from revision 0xe to 0x13, date = 07302004 
microcode: CPU3 updated from revision 0xe to 0x13, date = 07302004 
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,EPP]
Trying to free free DMA3
pnp: Device 00:07 disabled.
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ieee1394: Initialized config rom entry `ip1394'
e100: Intel(R) PRO/100 Network Driver, 3.3.6-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI interrupt 0000:08:01.0[A] -> GSI 22 (level, low) -> IRQ 22
e100: eth0: e100_probe: addr 0xfeafe000, irq 22, MAC addr 00:02:B3:5A:10:53
Intel(R) PRO/1000 Network Driver - version 5.6.10.1-k2-NAPI
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:05:04.0[A] -> GSI 24 (level, low) -> IRQ 24
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI interrupt 0000:05:04.1[B] -> GSI 25 (level, low) -> IRQ 25
e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI interrupt 0000:05:06.0[A] -> GSI 26 (level, low) -> IRQ 26
e1000: eth3: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI interrupt 0000:05:06.1[B] -> GSI 27 (level, low) -> IRQ 27
e1000: eth4: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI interrupt 0000:03:04.0[A] -> GSI 48 (level, low) -> IRQ 48
e1000: eth5: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI interrupt 0000:03:04.1[B] -> GSI 49 (level, low) -> IRQ 49
e1000: eth6: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI interrupt 0000:03:06.0[A] -> GSI 50 (level, low) -> IRQ 50
e1000: eth7: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI interrupt 0000:03:06.1[B] -> GSI 51 (level, low) -> IRQ 51
e1000: eth8: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI interrupt 0000:07:01.0[A] -> GSI 74 (level, low) -> IRQ 74
e1000: eth9: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI interrupt 0000:07:02.0[A] -> GSI 75 (level, low) -> IRQ 75
e1000: eth10: e1000_probe: Intel(R) PRO/1000 Network Connection
ip_tables: (C) 2000-2002 Netfilter core team
e100: Intel(R) PRO/100 Network Driver, 3.3.6-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI interrupt 0000:08:01.0[A] -> GSI 22 (level, low) -> IRQ 22
e100: eth0: e100_probe: addr 0xfeafe000, irq 22, MAC addr 00:02:B3:5A:10:53
ip_tables: (C) 2000-2002 Netfilter core team
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
Intel(R) PRO/1000 Network Driver - version 5.6.10.1-k2-NAPI
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:05:04.0[A] -> GSI 24 (level, low) -> IRQ 24
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI interrupt 0000:05:04.1[B] -> GSI 25 (level, low) -> IRQ 25
e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI interrupt 0000:05:06.0[A] -> GSI 26 (level, low) -> IRQ 26
e1000: eth3: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI interrupt 0000:05:06.1[B] -> GSI 27 (level, low) -> IRQ 27
e1000: eth4: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI interrupt 0000:03:04.0[A] -> GSI 48 (level, low) -> IRQ 48
e1000: eth5: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI interrupt 0000:03:04.1[B] -> GSI 49 (level, low) -> IRQ 49
e1000: eth6: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI interrupt 0000:03:06.0[A] -> GSI 50 (level, low) -> IRQ 50
e1000: eth7: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI interrupt 0000:03:06.1[B] -> GSI 51 (level, low) -> IRQ 51
e1000: eth8: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI interrupt 0000:07:01.0[A] -> GSI 74 (level, low) -> IRQ 74
e1000: eth9: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI interrupt 0000:07:02.0[A] -> GSI 75 (level, low) -> IRQ 75
e1000: eth10: e1000_probe: Intel(R) PRO/1000 Network Connection
pnp: Device 00:07 activated.
parport: PnPBIOS parport detected.
pnp: Device 00:07 disabled.
lp: driver loaded but no devices found
pktgen.c: v1.9.2 (nospin): Packet Generator for packet performance testing.
pktgen: cycles_calibrate, cycles_per_ns: 2  per_us: 2799  per_ms: 2799000
wanlink: module license 'Proprietary' taints kernel.
Initializing WanLink module, version 4.2.8
Copyright 2003-2005 Candela Technologies <support@candelatech.com>
wl_nr_cpus: 1  initial_wlp_cache: 10000  debug_lvl: 0 HZ: 1000
WanLink: cycles_calibrated, cycles_per_ns: 2  per_us: 2799  per_ms: 2799000
WanLink: Created writer thread, tid: 2961
WanLink: Created record thread[0], record_tid: 2962
WanLink: Created record thread[1], record_tid: 2963
wanlink:  Recorder thread: kwanrec_d0 (2962) starting.
wanlink:  Recorder thread: kwanrec_d1 (2963) starting.
MAC address based VLAN support Revision: 1.4 (9-04)

--------------080905060405030905030507
Content-Type: text/plain;
 name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.txt"

00:00.0 Host bridge: Intel Corp. Server Memory Controller Hub (rev 0c)
00:02.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port A0 (rev 0c)
00:03.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port A1 (rev 0c)
00:1c.0 PCI bridge: Intel Corp. 6300ESB 64-bit PCI-X Bridge (rev 02)
00:1d.0 USB Controller: Intel Corp. 6300ESB USB Universal Host Controller (rev 02)
00:1d.4 System peripheral: Intel Corp. 6300ESB Watchdog Timer (rev 02)
00:1d.5 PIC: Intel Corp. 6300ESB I/O Advanced Programmable Interrupt Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI Bridge (rev 0a)
00:1f.0 ISA bridge: Intel Corp. 6300ESB LPC Interface Controller (rev 02)
00:1f.2 IDE interface: Intel Corp. 6300ESB SATA Storage Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 6300ESB SMBus Controller (rev 02)
01:00.0 PCI bridge: Intel Corp. PCI Bridge Hub A (rev 09)
01:00.2 PCI bridge: Intel Corp. PCI Bridge Hub B (rev 09)
02:01.0 PCI bridge: IBM PCI-X to PCI-X Bridge (rev 03)
03:04.0 Ethernet controller: Intel Corp. 82546GB Gigabit Ethernet Controller (rev 03)
03:04.1 Ethernet controller: Intel Corp. 82546GB Gigabit Ethernet Controller (rev 03)
03:06.0 Ethernet controller: Intel Corp. 82546GB Gigabit Ethernet Controller (rev 03)
03:06.1 Ethernet controller: Intel Corp. 82546GB Gigabit Ethernet Controller (rev 03)
04:01.0 PCI bridge: IBM PCI-X to PCI-X Bridge (rev 02)
05:04.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (rev 01)
05:04.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (rev 01)
05:06.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (rev 01)
05:06.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (rev 01)
07:01.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet Controller
07:02.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet Controller
08:01.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 10)
08:02.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)

--------------080905060405030905030507--
