Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267783AbUIOXV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267783AbUIOXV2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 19:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267772AbUIOXTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 19:19:55 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:54178 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S267725AbUIOXRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 19:17:12 -0400
Date: Thu, 16 Sep 2004 01:16:59 +0200
From: "Oliver M. Bolzer" <oliver@fakeroot.net>
To: linux-kernel@vger.kernel.org
Subject: qla2xxx: frequent total lockups (2.6.8, 2.6.9-rc{1-mm5,2})
Message-ID: <20040915231657.GA2005@magi.fakeroot.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm currently setting up a new Dual Opteron box (Tyan Transport
GX28) equipped with a QLogic QLA2340 fibre channel HBA.

As soon as there is I/O load on the HBA, I start seeing

qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000

messages every few seconds, eventually leading to complete system lockups after
several minutes up to several hours, due to kernel NULL pointer dereferences
in qla2x00_cmd_timeout().

I've tested and reproduced the error on the following kernels, all
compiled for x86_64.
2.6.8.1
2.6.9-rc1-mm5 (with dma_fixups patch posted by Andrew Vasquez on 13.9)
2.6.9-rc2 

Attached are a complete 2.6.9-rc1-mm5 log from boot to crash as well as
two 2.6.9-rc2 crash dumps with only the post-boot messages.

The .config used and the complete logs can be found at
http://www.cip.ifi.lmu.de/~bolzer/tmp/qla-problem/

Without any I/O on the HBA (nothing mounted), I have yet to capture a 
crash, but the driver still ocasionally reports 
qla2300 0000:01:03.0: cmd_timeout: LOST command state = 0x6

Any help would be greatly appreciated. If there are any tests I could 
run, just let me know.

Bootdata ok (command line is root=/dev/sda3 ro console=ttyS0,115200n8 console=tty0 )
Linux version 2.6.9-rc1-mm5 (root@bruellwuerfel) (gcc version 3.3.4 (Debian 1:3.3.4-6sarge1.2.0.1.pure64)) #8 SMP Wed Sep 15 13:14:15 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
 BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
No mptable found.
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfebff000] gsi_base[24])
IOAPIC[1]: Assigned apic_id 3
IOAPIC[1]: apic_id 3, version 17, address 0xfebff000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xfebfe000] gsi_base[28])
IOAPIC[2]: Assigned apic_id 4
IOAPIC[2]: apic_id 4, version 17, address 0xfebfe000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ feb8000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/sda3 ro console=ttyS0,115200n8 console=tty0 
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1992.389 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 2054800k/2097088k available (3722k kernel code, 41684k reserved, 1736k data, 204k init)
Security Scaffold v1.0.0 initialized
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
There is already a security framework initialized, register_security failed.
Failure registering Root Plug module with the kernel
selinux_register_security:  There is already a secondary security module registered.
Failure registering Root Plug  module with primary security module.
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU0: AMD Opteron(tm) Processor 246 stepping 0a
per-CPU timeslice cutoff: 1023.83 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 rip 6000 rsp 1007ff35f58
Initializing CPU#1
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
AMD Opteron(tm) Processor 246 stepping 0a
Total of 2 processors activated (7897.08 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
Detected 12.452 MHz APIC timer.
checking TSC synchronization across 2 CPUs: passed.
time.c: Using PIT/TSC based timekeeping.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
SCSI subsystem initialized
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
testing the IO APIC.......................



Using vector-based indexing
.................................... done.
PCI-DMA: Disabling IOMMU.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1095260855.721:0): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
shpchp: HPC vendor_id 1022 device_id 7460 ss_vid 0 ss_did 0
shpchp: shpc_init: cannot reserve MMIO region
shpchp: HPC vendor_id 1022 device_id 7450 ss_vid 0 ss_did 0
shpchp: shpc_init: cannot reserve MMIO region
shpchp: HPC vendor_id 1022 device_id 7450 ss_vid 0 ss_did 0
shpchp: shpc_init: cannot reserve MMIO region
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU1] (supports C1, 8 throttling states)
ACPI: Processor [CPU2] (supports C1)
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
hw_random: AMD768 system management I/O registers at 0x5000.
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.100 (c) Dave Jones
ipmi message handler version v33
ipmi device interface version v33
IPMI System Interface driver version v33, KCS version v33, SMIC version v33, BT version v33
ipmi_si: Trying "kcs" at I/O port 0xca2
ipmi_si: Trying "smic" at I/O port 0xca9
ipmi_si: Trying "bt" at I/O port 0xe4
ipmi_si: Unable to find any System Interface(s)
IPMI Watchdog: driver version v33
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
i8042: ACPI  [PS2K] at I/O 0x60, 0x64, irq 1
i8042: ACPI  [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
loop: loaded (max 8 devices)
Compaq SMART2 Driver (v 2.6.0)
Using anticipatory io scheduler
nbd: registered device at major 43
tg3.c:v3.9 (August 30, 2004)
ACPI: PCI interrupt 0000:02:09.0[A] -> GSI 24 (level, low) -> IRQ 169
eth0: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:2b:36:2a
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
ACPI: PCI interrupt 0000:02:09.1[B] -> GSI 25 (level, low) -> IRQ 177
eth1: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:2b:36:2b
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:DMA
hdd: SAMSUNG CDRW/DVD SN-324F, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdd: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI interrupt 0000:03:05.0[A] -> GSI 17 (level, low) -> IRQ 185
ata1: SATA max UDMA/100 cmd 0xFFFFFF0000004C80 ctl 0xFFFFFF0000004C8A bmdma 0xFFFFFF0000004C00 irq 185
ata2: SATA max UDMA/100 cmd 0xFFFFFF0000004CC0 ctl 0xFFFFFF0000004CCA bmdma 0xFFFFFF0000004C08 irq 185
ata3: SATA max UDMA/100 cmd 0xFFFFFF0000004E80 ctl 0xFFFFFF0000004E8A bmdma 0xFFFFFF0000004E00 irq 185
ata4: SATA max UDMA/100 cmd 0xFFFFFF0000004EC0 ctl 0xFFFFFF0000004ECA bmdma 0xFFFFFF0000004E08 irq 185
ata1: no device found (phy stat 00000000)
scsi0 : sata_sil
ata2: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
ata3: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48
ata3: dev 0 configured for UDMA/100
scsi2 : sata_sil
ata4: no device found (phy stat 00000000)
scsi3 : sata_sil
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
st: Version 20040403, fixed bufsize 32768, s/g segs 256
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi2, channel 0, id 0, lun 0,  type 0
ACPI: PCI interrupt 0000:03:00.0[D] -> GSI 19 (level, low) -> IRQ 193
ohci_hcd 0000:03:00.0: Advanced Micro Devices [AMD] AMD-8111 USB
ohci_hcd 0000:03:00.0: irq 193, pci mem 0xfeafc000
ohci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:03:00.0: init err
ohci_hcd 0000:03:00.0: can't start
ohci_hcd 0000:03:00.0: init error -16
ohci_hcd 0000:03:00.0: remove, state 0
ohci_hcd 0000:03:00.0: USB bus 1 deregistered
ohci_hcd: probe of 0000:03:00.0 failed with error -16
ACPI: PCI interrupt 0000:03:00.1[D] -> GSI 19 (level, low) -> IRQ 193
ohci_hcd 0000:03:00.1: Advanced Micro Devices [AMD] AMD-8111 USB (#2)
ohci_hcd 0000:03:00.1: irq 193, pci mem 0xfeafd000
ohci_hcd 0000:03:00.1: new USB bus registered, assigned bus number 1
ohci_hcd 0000:03:00.1: init err
ohci_hcd 0000:03:00.1: can't start
ohci_hcd 0000:03:00.1: init error -16
ohci_hcd 0000:03:00.1: remove, state 0
ohci_hcd 0000:03:00.1: USB bus 1 deregistered
ohci_hcd: probe of 0000:03:00.1 failed with error -16
USB Universal Host Controller Interface driver v2.2
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
input: PC Speaker
i2c /dev entries driver
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: generic_sse
   generic_sse:  6060.000 MB/sec
raid5: using function: generic_sse (6060.000 MB/sec)
raid6: int64x1   1667 MB/s
raid6: int64x2   2484 MB/s
raid6: int64x4   2617 MB/s
raid6: int64x8   1722 MB/s
raid6: sse2x1     664 MB/s
raid6: sse2x2    1347 MB/s
raid6: sse2x4    2371 MB/s
raid6: using algorithm sse2x4 (2371 MB/s)
md: raid6 personality registered as nr 8
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
u32 classifier
    Perfomance counters on
    OLD policer on 
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
IPv4 over IPv4 tunneling driver
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 312 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 17
NET: Registered protocol family 15
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
ACPI: (supports S0 S1 S4 S5)
ACPI wakeup devices: 
PCI1 USB0 USB1 PS2K PS2M UAR1 UAR2 GOLA GLAN GOLB SMBC AC97 MODM PWRB 
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 204k freed
Adding 1951888k swap on /dev/sda2.  Priority:-1 extents:1
EXT3 FS on sda3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
QLogic Fibre Channel HBA Driver (ffffffffa0000000)
ACPI: PCI interrupt 0000:01:03.0[A] -> GSI 28 (level, low) -> IRQ 201
qla2300 0000:01:03.0: Found an ISP2312, irq 201, iobase 0xffffff0000006000
qla2300 0000:01:03.0: Configuring PCI space...
qla2300 0000:01:03.0: Configure NVRAM parameters...
qla2300 0000:01:03.0: Verifying loaded RISC code...
qla2300 0000:01:03.0: Waiting for LIP to complete...
qla2300 0000:01:03.0: LOOP UP detected (2 Gbps).
qla2300 0000:01:03.0: Topology - (F_Port), Host Loop address 0xffff
scsi4 : qla2xxx
qla2300 0000:01:03.0: 
 QLogic Fibre Channel HBA Driver: 8.00.00b21-k
  QLogic QLA2340 - 
  ISP2312: PCI-X (133 MHz) @ 0000:01:03.0 hdma+, host#=4, fw=3.03.02 IPX
  Vendor: IFT       Model: A16F-S1211        Rev: 341B
  Type:   Direct-Access                      ANSI SCSI revision: 03
qla2300 0000:01:03.0: scsi(4:0:0:0): Enabled tagged queuing, queue depth 32.
SCSI device sdc: 2927173632 512-byte hdwr sectors (1498713 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1
Attached scsi disk sdc at scsi4, channel 0, id 0, lun 0
Attached scsi generic sg2 at scsi4, channel 0, id 0, lun 0,  type 0
  Vendor: IFT       Model: A16F-S1211        Rev: 341B
  Type:   Direct-Access                      ANSI SCSI revision: 03
qla2300 0000:01:03.0: scsi(4:0:0:1): Enabled tagged queuing, queue depth 32.
SCSI device sdd: 2927173632 512-byte hdwr sectors (1498713 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1
Attached scsi disk sdd at scsi4, channel 0, id 0, lun 1
Attached scsi generic sg3 at scsi4, channel 0, id 0, lun 1,  type 0
  Vendor: QUALSTAR  Model: RLS-8236          Rev: 004C
  Type:   Medium Changer                     ANSI SCSI revision: 02
Attached scsi generic sg4 at scsi4, channel 0, id 1, lun 0,  type 8
  Vendor: IBM       Model: ULTRIUM-TD2       Rev: 38D0
  Type:   Sequential-Access                  ANSI SCSI revision: 03
Attached scsi tape st0 at scsi4, channel 0, id 1, lun 1
st0: try direct i/o: yes (alignment 512 B), max page reachable by HBA 4503599627370495
Attached scsi generic sg5 at scsi4, channel 0, id 1, lun 1,  type 1
  Vendor: IBM       Model: ULTRIUM-TD2       Rev: 38D0
  Type:   Sequential-Access                  ANSI SCSI revision: 03
Attached scsi tape st1 at scsi4, channel 0, id 1, lun 2
st1: try direct i/o: yes (alignment 512 B), max page reachable by HBA 4503599627370495
Attached scsi generic sg6 at scsi4, channel 0, id 1, lun 2,  type 1
  Vendor: Qualstar  Model: VFS212            Rev: T522
  Type:   Processor                          ANSI SCSI revision: 03
Disabled Privacy Extensions on device ffffffff805e23a0(lo)
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc1, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
[snip. 17x repeated]
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
qla2300 0000:01:03.0: cmd_timeout: LOST command state = 0x6
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
[snip. ~80x repeated]
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip __do_softirq+0x54/0xf0
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
[snip. over 100x repeated]
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP: 
<ffffffffa0004cf9>{:qla2xxx:qla2x00_cmd_timeout+25}
PML4 78efa067 PGD 78f31067 PMD 0 
Oops: 0000 [1] SMP 
CPU 0 
Modules linked in: qla2300 qla2xxx
Pid: 3258, comm: ssh Not tainted 2.6.9-rc1-mm5
RIP: 0010:[<ffffffffa0004cf9>] <ffffffffa0004cf9>{:qla2xxx:qla2x00_cmd_timeout+25}
RSP: 0000:ffffffff806589c8  EFLAGS: 00010292
RAX: 00000100722022a0 RBX: 0000010072202280 RCX: ffffffff80658a18
RDX: ffffffff80658a18 RSI: 0000010002c21468 RDI: 0000010072202280
RBP: 0000010072202280 R08: 000000000041c0cf R09: 0000000000cf0000
R10: 0000000000000450 R11: 00000000000000ad R12: 00000100032b03c8
R13: 0000000000000000 R14: 000000000000000a R15: 0000000000000000
FS:  0000002a968f5380(0000) GS:ffffffff806f1280(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 0000000000101000 CR4: 00000000000006e0
Process ssh (pid: 3258, threadinfo 0000010078e1e000, task 000001007de83030)
Stack: 0000010072202280 ffffffffffffffc9 ffffffffa0004ce2 0000010002c209a0 
       0000010072202280 ffffffffa0004ce0 ffffffff80658a18 000000000000000a 
       0000000000000000 ffffffff80140540 
Call Trace:<IRQ> <ffffffffa0004ce2>{:qla2xxx:qla2x00_cmd_timeout+2} 
       <ffffffffa0004ce0>{:qla2xxx:qla2x00_cmd_timeout+0} 
       <ffffffff80140540>{run_timer_softirq+384} <ffffffff803d55c9>{net_tx_action+121} 
       <ffffffff8013c131>{__do_softirq+113} <ffffffff8013c1e5>{do_softirq+53} 
       <ffffffff80110563>{apic_timer_interrupt+99}  <EOI> <ffffffff8010fd1a>{system_call+126} 
       

Code: 49 8b 45 08 48 8b 38 48 8b 43 78 48 8d af c8 03 00 00 4c 8b 
RIP <ffffffffa0004cf9>{:qla2xxx:qla2x00_cmd_timeout+25} RSP <ffffffff806589c8>
CR2: 0000000000000008
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!


============ post-boot messages from 2.6.9-rc2 (1)==========
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc1, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
[snip. 11x repeated]
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
Unable to handle kernel NULL pointer dereference at 00000000000001c8 RIP: 
<ffffffffa0004e9a>{:qla2xxx:qla2x00_cmd_timeout+682}
PML4 7f58e067 PGD 7eda8067 PMD 0 
Oops: 0000 [1] SMP 
CPU 0 
Modules linked in: qla2300 qla2xxx
Pid: 0, comm: swapper Not tainted 2.6.9-rc2
RIP: 0010:[<ffffffffa0004e9a>] <ffffffffa0004e9a>{:qla2xxx:qla2x00_cmd_timeout+682}
RSP: 0000:ffffffff8065cac8  EFLAGS: 00010096
RAX: 0000000000000296 RBX: 0000010000a7d7c0 RCX: 0000010000a7d7e0
RDX: ffffffff8065cb18 RSI: 0000000000000296 RDI: 0000000000000000
RBP: 000001003fbb03b0 R08: 0000000000000008 R09: 0000000000000001
R10: 000000000000003c R11: ffffffff80666a40 R12: 000001003fbb0330
R13: 0000000000000296 R14: 0000000000000296 R15: 0000000000000000
FS:  0000002a968f5380(0000) GS:ffffffff806f9180(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00000000000001c8 CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffffffff806fc000, task ffffffff8055c040)
Stack: 0000000000000296 000001003fbb2470 0000000001e10a60 0000010000a7d7c0 
       0000010001e10b60 ffffffffa0004bf0 ffffffff8065cb18 000000000000000a 
       0000000000000000 ffffffff801409d8 
Call Trace:<IRQ> <ffffffffa0004bf0>{:qla2xxx:qla2x00_cmd_timeout+0} 
       <ffffffff801409d8>{run_timer_softirq+344} <ffffffff8013c671>{__do_softirq+113} 
       <ffffffff8010df60>{default_idle+0} <ffffffff8013c725>{do_softirq+53} 
       <ffffffff801105a3>{apic_timer_interrupt+99}  <EOI> <ffffffff8010df84>{default_idle+36} 
       <ffffffff8010e00a>{cpu_idle+26} <ffffffff806ff839>{start_kernel+393} 
       

Code: 48 8b 87 c8 01 00 00 49 3b 9c c4 00 01 00 00 75 23 f6 43 65 
RIP <ffffffffa0004e9a>{:qla2xxx:qla2x00_cmd_timeout+682} RSP <ffffffff8065cac8>
CR2: 00000000000001c8
 NMI Watchdog detected LOCKUP on CPU0, registers:
CPU 0 
Modules linked in: qla2300 qla2xxx
Pid: 0, comm: swapper Not tainted 2.6.9-rc2
RIP: 0010:[<ffffffff804991e9>] <ffffffff804991e9>{.text.lock.spinlock+34}
RSP: 0000:ffffffff8065c7a0  EFLAGS: 00000086
RAX: 0000000000000001 RBX: ffffff000003e000 RCX: 00000000000000d1
RDX: ffffffff8065c838 RSI: 000001003fbb0330 RDI: 000001003fbb03b0
RBP: 000001003fbb0330 R08: 0000000000000000 R09: 0000000000000720
R10: 00000000ffffffff R11: 0000000000000000 R12: 0000000000000032
R13: 000001003fbb03b0 R14: 0000000000000000 R15: ffffffff8065c838
FS:  0000002a968f5380(0000) GS:ffffffff806f9180(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00000000000001c8 CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffffffff806fc000, task ffffffff8055c040)
Stack: 0000000000000086 ffffffffa000c151 ffffffff8065ca18 0000010001f63640 
       ffffffff8065c838 00000000000000d1 0000000000000001 0000000000003440 
       ffffffff8065c838 ffffffff80112b2c 
Call Trace:<IRQ> <ffffffffa000c151>{:qla2xxx:qla2x00_intr_handler+81} 
       <ffffffff80112b2c>{handle_IRQ_event+44} <ffffffff80137fbd>{printk+141} 
       <ffffffff80112dac>{do_IRQ+204} <ffffffff80110301>{ret_from_intr+0} 
       <ffffffff801114d8>{oops_end+40} <ffffffff801114d1>{oops_end+33} 
       <ffffffff80122bfb>{do_page_fault+939} <ffffffff80340a60>{scsi_delete_timer+16} 
       <ffffffffa0005259>{:qla2xxx:qla2x00_done+777} <ffffffffa000c2fa>{:qla2xxx:qla2x00_intr_handler+506} 
       <ffffffff80112b2c>{handle_IRQ_event+44} <ffffffff801106f5>{error_exit+0} 
       <ffffffffa0004e9a>{:qla2xxx:qla2x00_cmd_timeout+682} 
       <ffffffffa0004e93>{:qla2xxx:qla2x00_cmd_timeout+675} 
       <ffffffffa0004bf0>{:qla2xxx:qla2x00_cmd_timeout+0} 
       <ffffffff801409d8>{run_timer_softirq+344} <ffffffff8013c671>{__do_softirq+113} 
       <ffffffff8010df60>{default_idle+0} <ffffffff8013c725>{do_softirq+53} 
       <ffffffff801105a3>{apic_timer_interrupt+99}  <EOI> <ffffffff8010df84>{default_idle+36} 
       <ffffffff8010e00a>{cpu_idle+26} <ffffffff806ff839>{start_kernel+393} 
       

Code: 80 3f 00 7e f9 e9 e6 fd ff ff f3 90 80 3f 00 7e f9 e9 f2 fd 
console shuts up ...

============ post-boot messages from 2.6.9-rc2 (1)==========
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc1, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
[snip. 11x repeated]
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
qla_cmd_timeout: State indicates it is with ISP, But not in active array
qla2300 0000:01:03.0: qla2xxx_eh_abort scsi(4:0:0:0): cmd_timeout_in_sec=0x0.
qla2300 0000:01:03.0: qla2xxx_eh_abort Exiting: status=Failed
qla2300 0000:01:03.0: scsi(4:0:0:0): DEVICE RESET ISSUED.
qla2300 0000:01:03.0: scsi(4:0:0:0): DEVICE RESET SUCCEEDED.
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
[snip. 25x repeated]
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
qla2300 0000:01:03.0: qla2xxx_eh_abort scsi(4:0:0:0): cmd_timeout_in_sec=0x0.
qla2300 0000:01:03.0: qla2xxx_eh_abort Exiting: status=Failed
qla2300 0000:01:03.0: scsi(4:0:0:0): DEVICE RESET ISSUED.
qla2300 0000:01:03.0: scsi(4:0:0:0): DEVICE RESET SUCCEEDED.
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
[snip. 31x repeated]
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
qla2300 0000:01:03.0: cmd_timeout: LOST command state = 0x6
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
[snip. 37x repeated]
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip __do_softirq+0x54/0xf0
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
[snip. 27x repeated]
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
qla2300 0000:01:03.0: qla2xxx_eh_abort scsi(4:0:3:0): cmd_timeout_in_sec=0x0.
qla2300 0000:01:03.0: qla2xxx_eh_abort Exiting: status=Failed
qla2300 0000:01:03.0: scsi(4:0:3:0): DEVICE RESET ISSUED.
qla2300 0000:01:03.0: scsi(4:0:3:0): DEVICE RESET SUCCEEDED.
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
qla2300 0000:01:03.0: qla2xxx_eh_abort scsi(4:0:0:0): cmd_timeout_in_sec=0x0.
qla2300 0000:01:03.0: qla2xxx_eh_abort Exiting: status=Failed
qla2300 0000:01:03.0: scsi(4:0:0:0): DEVICE RESET ISSUED.
qla2300 0000:01:03.0: scsi(4:0:0:0): DEVICE RESET SUCCEEDED.
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
[snip. 239x repeated]
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
qla2300 0000:01:03.0: cmd_timeout: LOST command state = 0x6
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
[snip. 321x repeated]
qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP: 
<ffffffffa0004c09>{:qla2xxx:qla2x00_cmd_timeout+25}
PML4 113f4067 PGD 36ce9067 PMD 0 
Oops: 0000 [1] SMP 
CPU 0 
Modules linked in: qla2300 qla2xxx
Pid: 3634, comm: rsync Not tainted 2.6.9-rc2
RIP: 0010:[<ffffffffa0004c09>] <ffffffffa0004c09>{:qla2xxx:qla2x00_cmd_timeout+25}
RSP: 0018:ffffffff8065cac8  EFLAGS: 00010292
RAX: ffffffff8065cb18 RBX: 0000010054ee77c0 RCX: 0000010054ee77e0
RDX: ffffffff8065cb18 RSI: 0000010001e111e8 RDI: 0000010054ee77c0
RBP: 0000010001e10b60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000010001f98320 R11: 0000010001f97280 R12: 000001003ed08330
R13: 0000000000000000 R14: 000000000000000a R15: 0000000000000000
FS:  0000002a968f5380(0000) GS:ffffffff806f9180(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 0000000000101000 CR4: 00000000000006e0
Process rsync (pid: 3634, threadinfo 0000010016bd0000, task 000001000753f7c0)
Stack: 0000010054ee77c0 ffffffffffffffd1 ffffffffa0004bf2 0000010054ee77c0 
       0000010001e10b60 ffffffffa0004bf0 ffffffff8065cb18 000000000000000a 
       0000000000000000 ffffffff801409d8 
Call Trace:<IRQ> <ffffffffa0004bf2>{:qla2xxx:qla2x00_cmd_timeout+2} 
       <ffffffffa0004bf0>{:qla2xxx:qla2x00_cmd_timeout+0} 
       <ffffffff801409d8>{run_timer_softirq+344} <ffffffff8013c671>{__do_softirq+113} 
       <ffffffff8013c725>{do_softirq+53} <ffffffff801105a3>{apic_timer_interrupt+99} 
        <EOI> <ffffffff802553a8>{selinux_file_permission+296} 
       <ffffffff801780c1>{vfs_read+209} <ffffffff801780b1>{vfs_read+193} 
       <ffffffff80178383>{sys_read+83} <ffffffff8010fd5a>{system_call+126} 
       

Code: 49 8b 45 08 48 8b 38 48 8b 43 78 48 8d af 30 03 00 00 4c 8b 
RIP <ffffffffa0004c09>{:qla2xxx:qla2x00_cmd_timeout+25} RSP <ffffffff8065cac8>
CR2: 0000000000000008
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

-- 
	Oliver M. Bolzer

GPG (PGP) Fingerprint = 621B 52F6 2AC1 36DB 8761  018F 8786 87AD EF50 D1FF
