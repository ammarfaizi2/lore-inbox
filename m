Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422858AbWJYAVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422858AbWJYAVr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 20:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422859AbWJYAVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 20:21:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:58157 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422858AbWJYAVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 20:21:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:thread-index:x-mimeole:message-id;
        b=KCXVUngUexiUsyDUVyZhFdIPUb8Wmzhq0reC91m+f+ESfgvmO58tKOea39A/w/oyfCV9204537ft1X7grPHKYiQ9MZiVKG35C99dfAo/LFHqWA7pzXJ0trxzqru3Drmen7MUCKeeZ4GLMRdFsIMn9HsQ6tRapn6GX8JQrdyOmRo=
From: "Michael" <michael.sallaway@gmail.com>
To: "'Sergio Monteiro Basto'" <sergio@sergiomb.no-ip.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: Oops when doing disk heavy disk I/O
Date: Wed, 25 Oct 2006 10:21:30 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <1161710801.1242.6.camel@localhost.localdomain>
Thread-Index: Acb3lNgiPNwgvRr2S+W4H06nZq2blAANgY0Q
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Message-ID: <453eae16.5da1afe7.3681.ffffb56e@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Sergio Monteiro Basto [mailto:sergio@sergiomb.no-ip.org] 
> Sent: Wednesday, 25 October 2006 3:27 AM
> 
> Hi, 
> please boot with "report_lost_ticks" like
> http://marc.theaimsgroup.com/?l=linux-kernel&m=115545986619977&w=2
> and see if you have 
> time.c: Lost n timer tick(s)!
> 
> and 
> cat /sys/devices/system/clocksource/clocksource0/
> 
> cat /sys/devices/system/clocksource/clocksource0/current_clocksource
> 
> 

Hi,

Yep, seems to be losing some ticks -- I'm not sure what that means, but is
it bad? :-)

[ root @ barbossa : ~ ] # dmesg | grep tick
Command line: root=/dev/md1 ro report_lost_ticks
Kernel command line: root=/dev/md1 ro report_lost_ticks
time.c: Lost 1 timer tick(s)! rip release_console_sem+0x196/0x20c)
time.c: Lost 12 timer tick(s)! rip setup_boot_APIC_clock+0x11f/0x121)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x4a/0xc4)

(I've put a full dmesg below).

Also, for the clocksource:

[ root @ barbossa : ~ ] # ls /sys/devices/system/clocksource/clocksource0/
available_clocksource  current_clocksource

[ root @ barbossa : ~ ] # cat /sys/devices/system/clocksource/clocksource0/
cat: /sys/devices/system/clocksource/clocksource0/: Is a directory

[ root @ barbossa : ~ ] # cat
/sys/devices/system/clocksource/clocksource0/available_clocksource
jiffies

[ root @ barbossa : ~ ] # cat
/sys/devices/system/clocksource/clocksource0/current_clocksource
jiffies


Thanks for your help.

Cheers,
Michael


Full dmesg:

[ root @ barbossa : ~ ] # dmesg
Linux version 2.6.19-rc3 (root@barbossa) (gcc version 4.1.2 20061007
(prerelease) (Debian 4.1.1-16)) #1 SMP Tue Oct 24 22:23:07 EST 2006
Command line: root=/dev/md1 ro report_lost_ticks
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fee0000 (usable)
 BIOS-e820: 000000007fee0000 - 000000007fee3000 (ACPI NVS)
 BIOS-e820: 000000007fee3000 - 000000007fef0000 (ACPI data)
 BIOS-e820: 000000007fef0000 - 000000007ff00000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 524000) 1 entries of 256 used
end_pfn_map = 1048576
DMI 2.4 present.
ACPI: RSDP (v002 Nvidia                                ) @
0x00000000000f7760
ACPI: XSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x000000007fee30c0
ACPI: FADT (v003 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x000000007feec380
ACPI: HPET (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000098) @
0x000000007feec580
ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x000000007feec600
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x000000007feec4c0
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @
0x0000000000000000
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 524000) 1 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   524000
On node 0 totalpages: 523903
  DMA zone: 56 pages used for memmap
  DMA zone: 1737 pages reserved
  DMA zone: 2206 pages, LIFO batch:0
  DMA32 zone: 7108 pages used for memmap
  DMA32 zone: 512796 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x10de8201 base: 0xfefff000
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000f0000
Nosave address range: 00000000000f0000 - 0000000000100000
Allocating PCI resources starting at 80000000 (gap: 7ff00000:70100000)
PERCPU: Allocating 33408 bytes of per cpu data
Built 1 zonelists.  Total pages: 515002
Kernel command line: root=/dev/md1 ro report_lost_ticks
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
time.c: Lost 1 timer tick(s)! rip release_console_sem+0x196/0x20c)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Checking aperture...
CPU 0: aperture @ c8f4000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Memory: 2045020k/2096000k available (4241k kernel code, 50228k reserved,
1733k data, 272k init)
Calibrating delay using timer specific routine.. 4022.98 BogoMIPS
(lpj=8045974)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
SMP alternatives: switching to UP code
Freeing SMP alternatives: 48k freed
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12559460
Detected 12.559 MHz APIC timer.
time.c: Lost 12 timer tick(s)! rip setup_boot_APIC_clock+0x11f/0x121)
Brought up 1 CPUs
testing NMI watchdog ... OK.
time.c: Using 25.000000 MHz WALL HPET GTOD HPET/TSC timer.
time.c: Detected 2009.511 MHz processor.
checking if image is initramfs... it is
Freeing initrd memory: 3210k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:07.0
PCI: Transparent bridge - 0000:00:06.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK6] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK7] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK8] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LP2P] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LAZA] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LPMU] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LFID] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSA2] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC6] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC7] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC8] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APMU] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AAZA] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [ASA2] (IRQs 20 21 22 23) *0, disabled.
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
PCI-DMA: Disabling IOMMU.
PCI: Bridge: 0000:00:06.0
  IO window: d000-dfff
  MEM window: fc800000-fd7fffff
  PREFETCH window: 80000000-800fffff
PCI: Bridge: 0000:00:0a.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0b.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0d.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0e.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0f.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:06.0 to 64
PCI: Setting latency timer of device 0000:00:0a.0 to 64
PCI: Setting latency timer of device 0000:00:0b.0 to 64
PCI: Setting latency timer of device 0000:00:0c.0 to 64
PCI: Setting latency timer of device 0000:00:0d.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
PCI: Setting latency timer of device 0000:00:0f.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1161771160.632:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
fuse init (API version 7.7)
JFS: nTxBlock = 8192, nTxLock = 65536
SGI XFS with ACLs, security attributes, realtime, large block/inode numbers,
no debug enabled
SGI XFS Quota Management subsystem
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x4a/0xc4)
PCI: Setting latency timer of device 0000:00:0a.0 to 64
pcie_portdrv_probe->Dev[0376:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0a.0:pcie00]
PCI: Setting latency timer of device 0000:00:0b.0 to 64
pcie_portdrv_probe->Dev[0374:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0b.0:pcie00]
PCI: Setting latency timer of device 0000:00:0c.0 to 64
pcie_portdrv_probe->Dev[0374:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0c.0:pcie00]
PCI: Setting latency timer of device 0000:00:0d.0 to 64
pcie_portdrv_probe->Dev[0378:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0d.0:pcie00]
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[0375:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0e.0:pcie00]
PCI: Setting latency timer of device 0000:00:0f.0 to 64
pcie_portdrv_probe->Dev[0377:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0f.0:pcie00]
vga16fb: initializing
vga16fb: mapped to 0xffff8100000a0000
fb0: VGA16 VGA frame buffer device
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Fan [FAN] (on)
ACPI: Getting cpuindex for acpiid 0x1
ACPI: Thermal Zone [THRM] (40 C)
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
loop: loaded (max 8 devices)
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.57.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APCH] -> GSI 23 (level, low) ->
IRQ 23
PCI: Setting latency timer of device 0000:00:08.0 to 64
forcedeth: using HIGHDMA
eth0: forcedeth.c: subsystem: 01043:8239 bound to 0000:00:08.0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-MCP55: IDE controller at PCI slot 0000:00:04.0
NFORCE-MCP55: chipset revision 161
NFORCE-MCP55: not 100% native mode: will probe irqs later
NFORCE-MCP55: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE-MCP55: 0000:00:04.0 (rev a1) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
Probing IDE interface ide0...
hda: IC35L040AVVN07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 80418240 sectors (41174 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC3] -> GSI 18 (level, low) ->
IRQ 18
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 29160B Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

usbmon: debugfs is not available
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 22 (level, low) ->
IRQ 22
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: irq 22, io mem 0xfe02e000
ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
116x: driver isp116x-hcd, 03 Nov 2005
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 21 (level, low) ->
IRQ 21
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 21, io mem 0xfe02f000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
USB Universal Host Controller Interface driver v3.0
sl811: driver sl811-hcd, 19 May 2005
usbcore: registered new interface driver cdc_acm
drivers/usb/class/cdc-acm.c: v0.25:USB Abstract Control Model driver for USB
modems and ISDN adapters
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
I2O subsystem v1.325
i2o: max drivers = 8
I2O Configuration OSM v1.323
I2O Bus Adapter OSM v1.317
I2O Block Device OSM v1.325
I2O SCSI Peripheral OSM v1.316
I2O ProcFS OSM v1.316
i2c /dev entries driver
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x1c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x1c40
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid10 personality registered for level 10
raid6: int64x1   1847 MB/s
raid6: int64x2   2357 MB/s
raid6: int64x4   2379 MB/s
raid6: int64x8   1679 MB/s
raid6: sse2x1    2697 MB/s
raid6: sse2x2    3699 MB/s
raid6: sse2x4    3815 MB/s
raid6: using algorithm sse2x4 (3815 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: generic_sse
   generic_sse:  6186.000 MB/sec
raid5: using function: generic_sse (6186.000 MB/sec)
md: multipath personality registered for level -4
md: faulty personality registered for level -5
device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised:
dm-devel@redhat.com
device-mapper: multipath: version 1.0.5 loaded
device-mapper: multipath round-robin: version 1.0.0 loaded
device-mapper: multipath emc: version 0.0.3 loaded
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 312 bytes per conntrack
ctnetlink v0.90: registering with nfnetlink.
ip_conntrack_pptp version 3.1 loaded
ip_nat_pptp version 3.0 loaded
ip_tables: (C) 2000-2006 Netfilter Core Team
ClusterIP Version 0.8 loaded successfully
arp_tables: (C) 2002 David S. Miller
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ip6_tables: (C) 2000-2006 Netfilter Core Team
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
NET: Registered protocol family 8
NET: Registered protocol family 20
Freeing unused kernel memory: 272k freed
md: md0 stopped.
md: bind<hda1>
raid1: raid set md0 active with 1 out of 2 mirrors
md: md1 stopped.
md: bind<hda2>
raid1: raid set md1 active with 1 out of 2 mirrors
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
(fs/jbd/recovery.c, 255): journal_recover: JBD: recovery, exit status 0,
recovered transactions 15992 to 16718
(fs/jbd/recovery.c, 257): journal_recover: JBD: Replayed 6324 and revoked
1/4 blocks
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1052248k swap on /dev/hda3.  Priority:-1 extents:1 across:1052248k
EXT3 FS on md1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: no IPv6 routers present











