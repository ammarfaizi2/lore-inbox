Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161202AbWJXUc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161202AbWJXUc1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 16:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161114AbWJXUc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 16:32:27 -0400
Received: from math.ut.ee ([193.40.36.2]:37836 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1161216AbWJXUcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 16:32:25 -0400
Date: Tue, 24 Oct 2006 23:32:23 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: v4l compat ioctls broken
Message-ID: <Pine.SOC.4.61.0610242302110.11950@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running 32-bit userspace and recently switched to 64-bit kernel on 
Athlon64. Most things work fine but I can not watch TV with a bttv card 
that worked with 32-bit kernel. I discovered the problem with 2.6.19-rc* 
but it appears also in 2.6.18.


This is failed tvtime start + xawtv from 2.6.18:

compat_ioctl32: v4l2 ioctl VIDIOC_QUERYCAP, dir=r- (0x80585600)
ioctl32(xawtv:2802): Unknown cmd fd(4) cmd(80585600){00} arg(080b72f0) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_G_FREQUENCY, dir=rw (0xc02c5638)
ioctl32(xawtv:2802): Unknown cmd fd(4) cmd(c02c5638){00} arg(ffbe7348) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_FREQUENCY, dir=-w (0x402c5639)
ioctl32(xawtv:2802): Unknown cmd fd(4) cmd(402c5639){00} arg(ffbe7230) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_FREQUENCY, dir=-w (0x402c5639)
ioctl32(xawtv:2802): Unknown cmd fd(4) cmd(402c5639){00} arg(ffbe6db0) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_FREQUENCY, dir=-w (0x402c5639)
ioctl32(xawtv:2802): Unknown cmd fd(4) cmd(402c5639){00} arg(ffbe6db0) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_FREQUENCY, dir=-w (0x402c5639)
ioctl32(xawtv:2802): Unknown cmd fd(4) cmd(402c5639){00} arg(ffbe6db0) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_FREQUENCY, dir=-w (0x402c5639)
ioctl32(xawtv:2802): Unknown cmd fd(4) cmd(402c5639){00} arg(ffbe6db0) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_FREQUENCY, dir=-w (0x402c5639)
ioctl32(xawtv:2802): Unknown cmd fd(4) cmd(402c5639){00} arg(ffbe6db0) on /dev/video0

And this is tvtime from 2.6.19-rc3:

compat_ioctl32: v4l2 ioctl VIDIOC_S_FREQUENCY, dir=-w (0x402c5639)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(402c5639){00} arg(ffcbed8c) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbedb8) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbedb8) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbedb8) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbedb8) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_G_FREQUENCY, dir=rw (0xc02c5638)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c02c5638){00} arg(ffcbf018) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_FREQUENCY, dir=-w (0x402c5639)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(402c5639){00} arg(ffcbeedc) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_G_FREQUENCY, dir=rw (0xc02c5638)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c02c5638){00} arg(ffcbf018) on /dev/video0


Full dmesg:

Linux version 2.6.19-rc3-AMD64-dirty (mroos@vaarikas) (gcc version 4.1.2 20061020 (prerelease) (Debian 4.1.1-17)) #248 PREEMPT Tue Oct 24 23:22:12 EEST 2006
Command line: root=/dev/sda1 ro nmi_watchdog=1
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000007ffb0000 (usable)
  BIOS-e820: 000000007ffb0000 - 000000007ffc0000 (ACPI data)
  BIOS-e820: 000000007ffc0000 - 000000007fff0000 (ACPI NVS)
  BIOS-e820: 000000007fff0000 - 0000000080000000 (reserved)
  BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 524208) 1 entries of 256 used
end_pfn_map = 1048576
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000f9be0
ACPI: RSDT (v001 A M I  OEMRSDT  0x01000627 MSFT 0x00000097) @ 0x000000007ffb0000
ACPI: FADT (v002 A M I  OEMFACP  0x01000627 MSFT 0x00000097) @ 0x000000007ffb0200
ACPI: MADT (v001 A M I  OEMAPIC  0x01000627 MSFT 0x00000097) @ 0x000000007ffb0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x01000627 MSFT 0x00000097) @ 0x000000007ffc0040
ACPI: DSDT (v001  939M2 939M2160 0x00000160 INTL 0x02002026) @ 0x0000000000000000
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 524208) 1 entries of 256 used
Zone PFN ranges:
   DMA             0 ->     4096
   DMA32        4096 ->  1048576
   Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
     0:        0 ->      159
     0:      256 ->   524208
On node 0 totalpages: 524111
   DMA zone: 56 pages used for memmap
   DMA zone: 1062 pages reserved
   DMA zone: 2881 pages, LIFO batch:0
   DMA32 zone: 7110 pages used for memmap
   DMA32 zone: 513002 pages, LIFO batch:31
   Normal zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x02] address[0xfec10000] gsi_base[24])
IOAPIC[1]: apic_id 2, address 0xfec10000, GSI 24-39
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000e8000
Nosave address range: 00000000000e8000 - 0000000000100000
Allocating PCI resources starting at 88000000 (gap: 80000000:7f7c0000)
Built 1 zonelists.  Total pages: 515883
Kernel command line: root=/dev/sda1 ro nmi_watchdog=1
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 1800.102 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Checking aperture...
CPU 0: aperture @ d0000000 size 256 MB
Memory: 2059744k/2096832k available (2154k kernel code, 36316k reserved, 1494k data, 184k init)
Calibrating delay using timer specific routine.. 3602.52 BogoMIPS (lpj=7205047)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 02
ACPI: Core revision 20060707
activating NMI Watchdog ... done.
Using local APIC timer interrupts.
result 12500714
Detected 12.500 MHz APIC timer.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-083f claimed by ali7101 ACPI
Boot video device is 0000:04:00.0
PCI: Transparent bridge - 0000:00:06.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HTT_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEB1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEB2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEB3._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
ACPI: PCI Interrupt Link [LNKP] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 17 devices
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 0 of device 0000:00:04.0
agpgart: Detected AGP bridge 20
Setting up ULi AGP.
agpgart: AGP aperture is 256M @ 0xd0000000
PCI-DMA: Disabling IOMMU.
pnp: 00:0f: ioport range 0x290-0x29f has been reserved
PCI: Bridge: 0000:00:01.0
   IO window: disabled.
   MEM window: fd600000-fd6fffff
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
   IO window: disabled.
   MEM window: fd700000-fd7fffff
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:03.0
   IO window: c000-cfff
   MEM window: fd800000-fd8fffff
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:05.0
   IO window: disabled.
   MEM window: fd900000-fe9fffff
   PREFETCH window: bbe00000-bfdfffff
PCI: Bridge: 0000:00:06.0
   IO window: d000-dfff
   MEM window: fea00000-feafffff
   PREFETCH window: bfe00000-bfefffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 29 (level, low) -> IRQ 29
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 34 (level, low) -> IRQ 34
PCI: Setting latency timer of device 0000:00:02.0 to 64
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 39 (level, low) -> IRQ 39
PCI: Setting latency timer of device 0000:00:03.0 to 64
PCI: Setting latency timer of device 0000:00:05.0 to 64
PCI: Setting latency timer of device 0000:00:06.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Total HugeTLB memory allocated, 0
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
PCI: Setting latency timer of device 0000:00:02.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:02.0:pcie00]
PCI: Setting latency timer of device 0000:00:03.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:03.0:pcie00]
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Getting cpuindex for acpiid 0x2
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.1 20051102
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:0e: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PPP generic driver version 2.4.2
libata version 2.00 loaded.
ahci 0000:03:00.0: version 2.0
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 35 (level, low) -> IRQ 35
PCI: Setting latency timer of device 0000:03:00.0 to 64
ahci 0000:03:00.0: AHCI 0001.0000 32 slots 1 ports 3 Gbps 0x1 impl SATA mode
ahci 0000:03:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
ata1: SATA max UDMA/133 cmd 0xFFFFC20000004100 ctl 0x0 bmdma 0x0 irq 35
scsi0 : ahci
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
  sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S3 S4 S5)
input: ImExPS/2 Generic Explorer Mouse as /class/input/input2
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 184k freed
Write protecting the kernel read-only data: 422k
sd 0:0:0:0: Attached scsi generic sg0 type 0
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
Mobile IPv6
IPv6 over IPv4 tunneling driver
loop: loaded (max 8 devices)
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
ali15x3_smbus 0000:00:07.1: ALI15X3_smb region uninitialized - upgrade BIOS or use force_addr=0xaddr
ali15x3_smbus 0000:00:07.1: ALI15X3 not detected, module not inserted.
ali1535_smbus 0000:00:07.1: ALI1535_smb region uninitialized - upgrade BIOS?
ali1535_smbus 0000:00:07.1: ALI1535 not detected, module not inserted.
8139too Fast Ethernet driver 0.9.28
ACPI: PCI Interrupt 0000:05:05.0[A] -> GSI 20 (level, low) -> IRQ 20
eth0: RealTek RTL8139 at 0xffffc20000020c00, 00:40:95:30:0b:b0, IRQ 20
eth0:  Identified 8139 chip type 'RTL-8139C'
ACPI: PCI Interrupt 0000:05:06.0[A] -> GSI 21 (level, low) -> IRQ 21
eth1: RealTek RTL8139 at 0xffffc20000022800, 00:c0:df:04:7f:9b, IRQ 21
eth1:  Identified 8139 chip type 'RTL-8139B'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Linux video capture interface: v2.00
ali1563: SMBus control = 0403
ali1563_probe: Returning 0
uli526x: ULi M5261/M5263 net driver, version 0.9.3 (2005-7-29)
ACPI: PCI Interrupt 0000:00:11.0[A] -> GSI 17 (level, low) -> IRQ 17
eth2: ULi M5263 at pci0000:00:11.0, 00:13:8f:98:2c:bd, irq 17.
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 20 (level, low) -> IRQ 20
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:13.0: irq 20, io mem 0xfebfd000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 21 (level, low) -> IRQ 21
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.1: irq 21, io mem 0xfebfc000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI Interrupt 0000:00:13.2[C] -> GSI 22 (level, low) -> IRQ 22
ohci_hcd 0000:00:13.2: OHCI Host Controller
ohci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:13.2: irq 22, io mem 0xfebfb000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
bttv: driver version 0.9.16 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
usb 1-1: new full speed USB device using ohci_hcd and address 2
ACPI: PCI Interrupt 0000:00:13.3[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:13.3: EHCI Host Controller
ehci_hcd 0000:00:13.3: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:13.3: debug port 1
ehci_hcd 0000:00:13.3: irq 23, io mem 0xfebfe800
ehci_hcd 0000:00:13.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 8 ports detected
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ALI15X3: IDE controller at PCI slot 0000:00:12.0
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 19 (level, low) -> IRQ 19
ALI15X3: chipset revision 199
ALI15X3: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: SAMSUNG SP1614N, ATA DISK drive
usb 1-1: new full speed USB device using ohci_hcd and address 3
usb 1-1: configuration #1 chosen from 1 choice
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 0 proto 2 vid 0x03F0 pid 0x7204
usbcore: registered new interface driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: _NEC DVD_RW ND-4571A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
ACPI: PCI Interrupt 0000:05:07.1[A] -> GSI 22 (level, low) -> IRQ 22
bttv: Bt8xx card found (0).
ACPI: PCI Interrupt 0000:05:07.0[A] -> GSI 22 (level, low) -> IRQ 22
bttv0: Bt878 (rev 2) at 0000:05:07.0, irq: 22, latency: 32, mmio: 0xbfeff000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: Hauppauge (bt878) [card=10,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffffdb [init]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
tveeprom 1-0050: Hauppauge model 37284, rev B121, serial# 3520921
tveeprom 1-0050: tuner model is Philips FM1216 (idx 21, type 5)
tveeprom 1-0050: TV standards PAL(B/G) (eeprom 0x04)
tveeprom 1-0050: audio processor is MSP3410D (idx 5)
tveeprom 1-0050: has radio
bttv0: Hauppauge eeprom indicates model#37284
bttv0: using tuner=5
bttv0: i2c: checking for MSP34xx @ 0x80... found
msp3400 1-0040: MSP3410D-B4 found @ 0x80 (bt878 #0 [sw])
msp3400 1-0040: MSP3410D-B4 supports nicam, mode is autodetect
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
i2c_adapter i2c-1: Client creation failed at 0x42 (-5)
bttv0: i2c: checking for TDA9887 @ 0x86... not found
tuner 1-0042: chip found @ 0x84 (bt878 #0 [sw])
tda9887 1-0042: tda988[5/6/7] found @ 0x42 (tuner)
tuner 1-0061: chip found @ 0xc2 (bt878 #0 [sw])
tuner 1-0061: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
tuner 1-0061: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL: 28636363 => 35468950 .. ok
ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 18 (level, low) -> IRQ 18
AC'97 1 does not respond - RESET
AC'97 1 access is not valid [0xffffffff], removing mixer.
Unable to initialize codec #1
intel8x0_measure_ac97_clock: measured 54300 usecs
intel8x0: clocking to 48000
hda: max request size: 512KiB
hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
hda: cache flushes supported
  hda: hda1
hdc: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Adding 3911816k swap on /dev/sda2.  Priority:-1 extents:1 across:3911816k
EXT3 FS on sda1, internal journal
device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: link down
ADDRCONF(NETDEV_UP): eth0: link is not ready
eth1: link up, 100Mbps, full-duplex, lpa 0x45E1
tun6to4: Disabled Privacy Extensions
u32 classifier
     Actions configured 
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 312 bytes per conntrack
lp0: using parport0 (interrupt-driven).
ppdev: user-space parallel port driver
Xorg: vm86 mode not supported on 64 bit kernel
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized mga 3.2.1 20051102 on minor 0
agpgart: Found an AGP 3.0 compliant device at 0000:00:04.0.
agpgart: Device is in legacy mode, falling back to 2.x
agpgart: Putting AGP V2 device at 0000:00:04.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:04:00.0 into 4x mode
[drm] Initialized card for AGP DMA.
compat_ioctl32: v4l2 ioctl VIDIOC_S_FREQUENCY, dir=-w (0x402c5639)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(402c5639){00} arg(ffcbed8c) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbedb8) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbedb8) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbedb8) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbedb8) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_G_FREQUENCY, dir=rw (0xc02c5638)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c02c5638){00} arg(ffcbf018) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_FREQUENCY, dir=-w (0x402c5639)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(402c5639){00} arg(ffcbeedc) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_G_FREQUENCY, dir=rw (0xc02c5638)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c02c5638){00} arg(ffcbf018) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_FREQUENCY, dir=-w (0x402c5639)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(402c5639){00} arg(ffcbeedc) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_G_FREQUENCY, dir=rw (0xc02c5638)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c02c5638){00} arg(ffcbf018) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_FREQUENCY, dir=-w (0x402c5639)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(402c5639){00} arg(ffcbeedc) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_G_FREQUENCY, dir=rw (0xc02c5638)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c02c5638){00} arg(ffcbf018) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_FREQUENCY, dir=-w (0x402c5639)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(402c5639){00} arg(ffcbeedc) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_G_FREQUENCY, dir=rw (0xc02c5638)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c02c5638){00} arg(ffcbf018) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_FREQUENCY, dir=-w (0x402c5639)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(402c5639){00} arg(ffcbeedc) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_G_FREQUENCY, dir=rw (0xc02c5638)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c02c5638){00} arg(ffcbf018) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_FREQUENCY, dir=-w (0x402c5639)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(402c5639){00} arg(ffcbeedc) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_G_FREQUENCY, dir=rw (0xc02c5638)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c02c5638){00} arg(ffcbf018) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_FREQUENCY, dir=-w (0x402c5639)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(402c5639){00} arg(ffcbeedc) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_S_CTRL, dir=rw (0xc008561c)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c008561c){00} arg(ffcbef08) on /dev/video0
compat_ioctl32: v4l2 ioctl VIDIOC_G_FREQUENCY, dir=rw (0xc02c5638)
ioctl32(tvtime:2742): Unknown cmd fd(4) cmd(c02c5638){00} arg(ffcbf018) on /dev/video0

-- 
Meelis Roos (mroos@linux.ee)
