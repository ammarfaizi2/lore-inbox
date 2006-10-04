Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161546AbWJDSPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161546AbWJDSPd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161933AbWJDSPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:15:33 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:21267 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1161932AbWJDSPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:15:31 -0400
Message-ID: <4523FA41.90805@tuxrocks.com>
Date: Wed, 04 Oct 2006 13:15:29 -0500
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Keyboard Stuttering
Content-Type: multipart/mixed;
 boundary="------------090806000803040406090803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090806000803040406090803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm experiencing some severe keyboard stuttering on my laptop.  The 
problem is particularly bad in X, and I believe it also occurs at the 
console, though I'm having a difficult time verifying that.  The problem 
  shows up as repeated characters (not regular key-repeat-related), and 
sometimes dropped key presses.

I'm running the 2.6.18 x86_64 kernel on a Core 2 Duo.

When I get the extra characters, each one shows under interrupt 1 for 
i8042 in /proc/interrupts, even when only one should show:
            CPU0       CPU1
   0:    4228511    4430136    IO-APIC-edge  timer
   1:       3666       3713    IO-APIC-edge  i8042
   8:          0          0    IO-APIC-edge  rtc
   9:          2          0   IO-APIC-level  acpi
  12:      89035      77993    IO-APIC-edge  i8042
  14:      19246       6894    IO-APIC-edge  libata
  15:      34998      22732    IO-APIC-edge  ide1
  17:       8456          0   IO-APIC-level  eth0
  18:          2          0   IO-APIC-level  ohci1394
  19:       4558       3872   IO-APIC-level  HDA Intel, uhci_hcd:usb3
  20:         23          0   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2
  21:          0          0   IO-APIC-level  uhci_hcd:usb4
  22:          0          0   IO-APIC-level  uhci_hcd:usb5
NMI:       1121        815
LOC:    8658522    8658062
ERR:          0

I have found that "nolapic" will make the keyboard work correctly (using 
XT-PIC), but obviously that has other negative side-effects (such as 
only one processor, etc.).  I've attached a dmesg of boot with a broken 
keyboard (without nolapic).

Has anyone experienced this problem before?  Is there a fix for this
keyboard stuttering?

TThhhaannkss,

Frrannk

--------------090806000803040406090803
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.6.18 (root@george.sorensonfamily.com) (gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)) #3 SMP PREEMPT Wed Sep 27 13:50:31 CDT 2006
Command line: ro root=/dev/VolGroup00/RootVol vga=794 apic=verbose
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fed3400 (usable)
 BIOS-e820: 000000007fed3400 - 0000000080000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0007000 (reserved)
 BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
DMI 2.4 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x00000000000fc1b0
ACPI: RSDT (v001 DELL    M07     0x27d6071d ASL  0x00000061) @ 0x000000007fed39cd
ACPI: FADT (v001 DELL    M07     0x27d6071d ASL  0x00000061) @ 0x000000007fed4800
ACPI: MADT (v001 DELL    M07     0x27d6071d ASL  0x00000047) @ 0x000000007fed5000
ACPI: MCFG (v016 DELL    M07     0x27d6071d ASL  0x00000061) @ 0x000000007fed4fc0
ACPI: BOOT (v001 DELL    M07     0x27d6071d ASL  0x00000061) @ 0x000000007fed4bc0
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20050624) @ 0x000000007fed3a05
ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 INTL 0x20050624) @ 0x0000000000000000
No NUMA configuration found
Faking a node at 0000000000000000-000000007fed3000
Bootmem setup node 0 0000000000000000-000000007fed3000
No mptable found.
On node 0 totalpages: 515695
  DMA zone: 3927 pages, LIFO batch:0
  DMA32 zone: 511768 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
mapped APIC to ffffffffff5fd000 (        fee00000)
mapped IOAPIC to ffffffffff5fc000 (00000000fec00000)
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 0000000000100000
Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PERCPU: Allocating 32384 bytes of per cpu data
Built 1 zonelists.  Total pages: 515695
Kernel command line: ro root=/dev/VolGroup00/RootVol vga=794 apic=verbose
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Checking aperture...
Memory: 2052396k/2095948k available (3179k kernel code, 43164k reserved, 1443k data, 248k init)
Calibrating delay using timer specific routine.. 4330.61 BogoMIPS (lpj=2165305)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 0/0 -> Node 0
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM2)
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
enabled ExtINT on CPU#0
ESR value after enabling vector: 00000000, after 00000040
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Using local APIC timer interrupts.
result 10403067
Detected 10.403 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
masked ExtINT on CPU#1
Calibrating delay using timer specific routine.. 4326.95 BogoMIPS (lpj=2163475)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM2)
Intel(R) Core(TM)2 CPU         T7400  @ 2.16GHz stepping 06
Brought up 2 CPUs
testing NMI watchdog ... OK.
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 2163.840 MHz processor.
migration_cost=26
checking if image is initramfs... it is
Freeing initrd memory: 1608k freed
PM: Adding info for No Bus:platform
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at e0000000
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
PM: Adding info for acpi:acpi
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PM: Adding info for No Bus:pci0000:00
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:1b.0
PM: Adding info for pci:0000:00:1c.0
PM: Adding info for pci:0000:00:1c.1
PM: Adding info for pci:0000:00:1c.3
PM: Adding info for pci:0000:00:1d.0
PM: Adding info for pci:0000:00:1d.1
PM: Adding info for pci:0000:00:1d.2
PM: Adding info for pci:0000:00:1d.3
PM: Adding info for pci:0000:00:1d.7
PM: Adding info for pci:0000:00:1e.0
PM: Adding info for pci:0000:00:1f.0
PM: Adding info for pci:0000:00:1f.2
PM: Adding info for pci:0000:00:1f.3
PM: Adding info for pci:0000:01:00.0
PM: Adding info for pci:0000:0c:00.0
PM: Adding info for pci:0000:03:00.0
PM: Adding info for pci:0000:03:01.0
PM: Adding info for pci:0000:03:01.1
PM: Adding info for pci:0000:03:01.2
PM: Adding info for pci:0000:03:01.3
PM: Adding info for pci:0000:03:01.4
ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 11) *4
ACPI: PCI Interrupt Link [LNKB] (IRQs *5 7)
ACPI: PCI Interrupt Link [LNKC] (IRQs *9 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 11) *3
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
PM: Adding info for No Bus:pnp0
PM: Adding info for pnp:00:00
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
IOAPIC[0]: Set PCI routing entry (2-12 -> 0x89 -> IRQ 12 Mode:0 Active:0)
PM: Adding info for pnp:00:04
IOAPIC[0]: Set PCI routing entry (2-1 -> 0x39 -> IRQ 1 Mode:0 Active:0)
PM: Adding info for pnp:00:05
IOAPIC[0]: Set PCI routing entry (2-8 -> 0x69 -> IRQ 8 Mode:0 Active:0)
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
PM: Adding info for pnp:00:08
PM: Adding info for pnp:00:09
IOAPIC[0]: Set PCI routing entry (2-13 -> 0x91 -> IRQ 13 Mode:0 Active:0)
PM: Adding info for pnp:00:0a
pnp: PnP ACPI: found 11 devices
Intel 82802 RNG detected
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 00000000
.......    : physical APIC id: 00
.... register #01: 00170020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0020
.... register #02: 00170020
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    39
 02 000 00  0    0    0   0   0    0    0    31
 03 000 00  0    0    0   0   0    0    0    41
 04 000 00  0    0    0   0   0    0    0    49
 05 000 00  0    0    0   0   0    0    0    51
 06 000 00  0    0    0   0   0    0    0    59
 07 000 00  0    0    0   0   0    0    0    61
 08 000 00  1    0    0   0   0    0    0    69
 09 000 00  0    1    0   0   0    0    0    71
 0a 000 00  0    0    0   0   0    0    0    79
 0b 000 00  0    0    0   0   0    0    0    81
 0c 000 00  1    0    0   0   0    0    0    89
 0d 000 00  1    0    0   0   0    0    0    91
 0e 000 00  0    0    0   0   0    0    0    99
 0f 000 00  0    0    0   0   0    0    0    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Bluetooth: Core ver 2.10
PM: Adding info for platform:bluetooth
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
PCI-GART: No AMD northbridge found.
pnp: 00:02: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:02: ioport range 0x1000-0x1005 could not be reserved
pnp: 00:02: ioport range 0x1008-0x100f could not be reserved
pnp: 00:03: ioport range 0xf400-0xf4fe has been reserved
pnp: 00:03: ioport range 0x1006-0x1007 has been reserved
pnp: 00:03: ioport range 0x100a-0x1059 could not be reserved
pnp: 00:03: ioport range 0x1060-0x107f has been reserved
pnp: 00:03: ioport range 0x1080-0x10bf has been reserved
pnp: 00:03: ioport range 0x10c0-0x10df has been reserved
pnp: 00:08: ioport range 0xc80-0xcff could not be reserved
pnp: 00:08: ioport range 0x910-0x91f has been reserved
pnp: 00:08: ioport range 0x920-0x92f has been reserved
pnp: 00:08: ioport range 0xcb0-0xcbf has been reserved
pnp: 00:08: ioport range 0x930-0x97f has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: e000-efff
  MEM window: dd000000-dfefffff
  PREFETCH window: c0000000-cfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: disabled.
  MEM window: dcf00000-dcffffff
  PREFETCH window: d0000000-d00fffff
PCI: Bridge: 0000:00:1c.3
  IO window: d000-dfff
  MEM window: dcc00000-dcefffff
  PREFETCH window: d0100000-d03fffff
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: dcb00000-dcbfffff
  PREFETCH window: disabled.
GSI 16 sharing vector 0xA9 and IRQ 16
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
GSI 17 sharing vector 0xB1 and IRQ 17
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.1 to 64
GSI 18 sharing vector 0xB9 and IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb9 -> IRQ 18 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.3 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Simple Boot Flag at 0x79 set to 0x1
audit: initializing netlink socket (disabled)
audit(1159984368.501:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
fuse init (API version 7.7)
SELinux:  Registering netfilter hooks
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
PM: Adding info for pci_express:0000:00:01.0:pcie00
Allocate Port Service[0000:00:01.0:pcie03]
PM: Adding info for pci_express:0000:00:01.0:pcie03
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
PM: Adding info for pci_express:0000:00:1c.0:pcie00
Allocate Port Service[0000:00:1c.0:pcie02]
PM: Adding info for pci_express:0000:00:1c.0:pcie02
Allocate Port Service[0000:00:1c.0:pcie03]
PM: Adding info for pci_express:0000:00:1c.0:pcie03
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
PM: Adding info for pci_express:0000:00:1c.1:pcie00
Allocate Port Service[0000:00:1c.1:pcie02]
PM: Adding info for pci_express:0000:00:1c.1:pcie02
Allocate Port Service[0000:00:1c.1:pcie03]
PM: Adding info for pci_express:0000:00:1c.1:pcie03
PCI: Setting latency timer of device 0000:00:1c.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.3:pcie00]
PM: Adding info for pci_express:0000:00:1c.3:pcie00
Allocate Port Service[0000:00:1c.3:pcie02]
PM: Adding info for pci_express:0000:00:1c.3:pcie02
Allocate Port Service[0000:00:1c.3:pcie03]
PM: Adding info for pci_express:0000:00:1c.3:pcie03
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: HPC vendor_id 8086 device_id 27d0 ss_vid 0 ss_did 0
Evaluate _OSC Set fails. Status = 0x0005
Evaluate _OSC Set fails. Status = 0x0005
pciehp: Cannot get control of hotplug hardware for pci 0000:00:1c.0
pciehp: HPC vendor_id 8086 device_id 27d2 ss_vid 0 ss_did 0
Evaluate _OSC Set fails. Status = 0x0005
Evaluate _OSC Set fails. Status = 0x0005
pciehp: Cannot get control of hotplug hardware for pci 0000:00:1c.1
pciehp: HPC vendor_id 8086 device_id 27d6 ss_vid 0 ss_did 0
Evaluate _OSC Set fails. Status = 0x0005
Evaluate _OSC Set fails. Status = 0x0005
pciehp: Cannot get control of hotplug hardware for pci 0000:00:1c.3
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
PM: Adding info for platform:vesafb.0
vesafb: framebuffer at 0xc0000000, mapped to 0xffffc20010100000, using 5120k, total 262144k
vesafb: mode is 1280x1024x16, linelength=2560, pages=1
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [VID2] (multi-head: yes  rom: no  post: no)
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Ist] [20060707]
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Cst] [20060707]
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Ist] [20060707]
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Cst] [20060707]
ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Thermal Zone [THM] (51 C)
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 945GM Chipset.
agpgart: AGP aperture is 256M @ 0x0
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
PM: Adding info for platform:serial8250
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
b44.c:v1.01 (Jun 16, 2006)
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 17 (level, low) -> IRQ 17
eth0: Broadcom 4400 10/100BaseT Ethernet 00:15:c5:4b:5e:8f
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0: I/O resource 0x1F0-0x1F7 not free.
ide0: ports already in use, skipping probe
Probing IDE interface ide1...
hdc: TSSTcorp DVD+/-RW TS-L632D, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide1
ide1 at 0x170-0x177,0x376 on irq 15
PM: Adding info for ide:1.0
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
libata version 2.00 loaded.
ata_piix 0000:00:1f.2: version 2.00ac6
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 17
ata: 0x170 IDE port busy
ata: conflict with ide1
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
ata2: DUMMY
scsi0 : ata_piix
PM: Adding info for No Bus:host0
ata1.00: ATA-7, max UDMA/100, 192426570 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 8
ata1.00: configured for UDMA/100
scsi1 : ata_piix
PM: Adding info for No Bus:host1
PM: Adding info for No Bus:target0:0:0
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS72101 MCZO PQ: 0 ANSI: 5
PM: Adding info for scsi:0:0:0:0
SCSI device sda: 192426570 512-byte hdwr sectors (98522 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 192426570 512-byte hdwr sectors (98522 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
Losing some ticks... checking if CPU frequency changed.
PM: Adding info for platform:i8042
serio: i8042 AUX port at 0x60,0x64 irq 12
PM: Adding info for serio:serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
PM: Adding info for serio:serio1
mice: PS/2 mouse device common for all mice
md: multipath personality registered for level -4
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
device-mapper: multipath: version 1.0.4 loaded
device-mapper: multipath round-robin: version 1.0.0 loaded
device-mapper: multipath emc: version 0.0.3 loaded
Bluetooth: Virtual HCI driver ver 1.2
Bluetooth: Broadcom Blutonium firmware driver ver 1.0
usbcore: registered new driver bcm203x
Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22 13:55:50 2006 UTC).
input: AT Translated Set 2 keyboard as /class/input/input0
GSI 19 sharing vector 0xC1 and IRQ 19
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 21 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ALSA device list:
  #0: HDA Intel at 0xdfffc000 irq 19
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.5
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: BNEP filters: protocol multicast
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ieee80211_crypt: registered algorithm 'NULL'
ieee80211_crypt: registered algorithm 'WEP'
ieee80211_crypt: registered algorithm 'CCMP'
ieee80211_crypt: registered algorithm 'TKIP'
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 248k freed
Write protecting the kernel read-only data: 657k
Synaptics Touchpad, model: 1, fw: 6.2, id: 0xfa0b1, caps: 0xa04713/0x200000
input: SynPS/2 Synaptics TouchPad as /class/input/input1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
security:  3 users, 6 roles, 1481 types, 152 bools, 1 sens, 256 cats
security:  58 classes, 43474 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev dm-0, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev cpuset, type cpuset), not configured for labeling
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1159984372.091:2): policy loaded auid=4294967295
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
GSI 20 sharing vector 0xC9 and IRQ 20
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xc9 -> IRQ 20 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 20, io mem 0xffa80000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
PM: Adding info for usb:usb1
PM: Adding info for No Bus:usbdev1.1_ep00
usb usb1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
PM: Adding info for No Bus:usbdev1.1_ep81
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 17
PM: Adding info for No Bus:i2c-0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 20, io base 0x0000bf80
PM: Adding info for usb:usb2
PM: Adding info for No Bus:usbdev2.1_ep00
usb usb2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-0:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
bcm43xx driver
PM: Adding info for No Bus:usbdev2.1_ep81
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 21 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000bf60
PM: Adding info for usb:usb3
PM: Adding info for No Bus:usbdev3.1_ep00
usb usb3: configuration #1 chosen from 1 choice
PM: Adding info for usb:3-0:1.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev3.1_ep81
GSI 21 sharing vector 0xD1 and IRQ 21
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd1 -> IRQ 21 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 22 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 21, io base 0x0000bf40
PM: Adding info for usb:usb4
PM: Adding info for No Bus:usbdev4.1_ep00
usb usb4: configuration #1 chosen from 1 choice
PM: Adding info for usb:4-0:1.0
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-1: new high speed USB device using ehci_hcd and address 2
ieee1394: Initialized config rom entry `ip1394'
PM: Adding info for No Bus:usbdev4.1_ep81
GSI 22 sharing vector 0xD9 and IRQ 22
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xd9 -> IRQ 22 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 23 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 22, io base 0x0000bf20
PM: Adding info for usb:usb5
PM: Adding info for No Bus:usbdev5.1_ep00
usb usb5: configuration #1 chosen from 1 choice
PM: Adding info for usb:5-0:1.0
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
PM: Adding info for usb:1-1
PM: Adding info for No Bus:usbdev1.2_ep00
usb 1-1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-1:1.0
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
PM: Adding info for No Bus:usbdev1.2_ep81
PM: Adding info for No Bus:usbdev5.1_ep81
ACPI: PCI Interrupt 0000:0c:00.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:0c:00.0 to 64
bcm43xx: Chip ID 0x4321, rev 0x1
bcm43xx: Number of cores: 5
bcm43xx: Core 0: ID 0x800, rev 0x12, vendor 0x4243, enabled
bcm43xx: Core 1: ID 0x812, rev 0xb, vendor 0x4243, disabled
bcm43xx: Unsupported 80211 core revision 11
bcm43xx: Core 2: ID 0x820, rev 0x2, vendor 0x4243, enabled
bcm43xx: Core 3: ID 0x804, rev 0xd, vendor 0x4243, enabled
bcm43xx: Multiple PCI cores found.
bcm43xx: Core 4: ID 0x817, rev 0x4, vendor 0x4243, disabled
bcm43xx: WARNING: Invalid SPROM checksum (0x01, expected: 0xFF)
bcm43xx: Detected PHY: Version: 5, Type 4, Revision 1
bcm43xx: Error: Unknown PHY Type 4
ACPI: PCI Interrupt 0000:03:01.0[A] -> GSI 19 (level, low) -> IRQ 18
PM: Adding info for ieee1394:fw-host0
kobject_add failed for usbdev1.2_ep81 with -EEXIST, don't try to register things with the same name in the same directory.

Call Trace:
BUG: using smp_processor_id() in preemptible [00000001] code: khubd/163
caller is dump_trace+0x22/0x297

Call Trace:
 [<ffffffff8113ab30>] debug_smp_processor_id+0xb4/0xc4
 [<ffffffff8100afe2>] dump_trace+0x22/0x297
 [<ffffffff8100b293>] show_trace+0x3c/0x52
 [<ffffffff8100b2be>] dump_stack+0x15/0x17
 [<ffffffff81135138>] kobject_put+0x19/0x1b
 [<ffffffff811355cf>] kobject_add+0x180/0x1ae
 [<ffffffff811ad25e>] device_add+0xad/0x4db
 [<ffffffff81045ecb>] init_waitqueue_head+0x1f/0x30
 [<ffffffff811ad6a5>] device_register+0x19/0x1e
 [<ffffffff8120f94e>] usb_create_ep_files+0x13a/0x1a0
 [<ffffffff8120f3b1>] usb_create_sysfs_intf_files+0x86/0xa3
 [<ffffffff8120cb1c>] usb_set_configuration+0x3c5/0x40e
 [<ffffffff81208077>] usb_new_device+0x277/0x2da
 [<ffffffff81209263>] hub_thread+0x76c/0xb75
 [<ffffffff8131547a>] _spin_unlock_irq+0x14/0x2e
 [<ffffffff81045c43>] autoremove_wake_function+0x0/0x38
 [<ffffffff8131544a>] _spin_unlock_irqrestore+0x1d/0x39
 [<ffffffff81208af7>] hub_thread+0x0/0xb75
 [<ffffffff81045b1e>] kthread+0xd8/0x10e
 [<ffffffff8102e2a7>] schedule_tail+0x46/0xaf
 [<ffffffff8100aaf8>] child_rip+0xa/0x12
 [<ffffffff81045a46>] kthread+0x0/0x10e
 [<ffffffff8100aaee>] child_rip+0x0/0x12

 [<ffffffff81135138>] kobject_put+0x19/0x1b
 [<ffffffff811355cf>] kobject_add+0x180/0x1ae
 [<ffffffff811ad25e>] device_add+0xad/0x4db
 [<ffffffff81045ecb>] init_waitqueue_head+0x1f/0x30
 [<ffffffff811ad6a5>] device_register+0x19/0x1e
 [<ffffffff8120f94e>] usb_create_ep_files+0x13a/0x1a0
 [<ffffffff8120f3b1>] usb_create_sysfs_intf_files+0x86/0xa3
 [<ffffffff8120cb1c>] usb_set_configuration+0x3c5/0x40e
 [<ffffffff81208077>] usb_new_device+0x277/0x2da
 [<ffffffff81209263>] hub_thread+0x76c/0xb75
 [<ffffffff8131547a>] _spin_unlock_irq+0x14/0x2e
 [<ffffffff81045c43>] autoremove_wake_function+0x0/0x38
 [<ffffffff8131544a>] _spin_unlock_irqrestore+0x1d/0x39
 [<ffffffff81208af7>] hub_thread+0x0/0xb75
 [<ffffffff81045b1e>] kthread+0xd8/0x10e
 [<ffffffff8102e2a7>] schedule_tail+0x46/0xaf
 [<ffffffff8100aaf8>] child_rip+0xa/0x12
 [<ffffffff81045a46>] kthread+0x0/0x10e
 [<ffffffff8100aaee>] child_rip+0x0/0x12

ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[18]  MMIO=[dcbfd800-dcbfdfff]  Max Packet=[2048]  IR/IT contexts=[4/4]
Non-volatile memory driver v1.2
Floppy drive(s): fd0 is 1.44M
PM: Adding info for ieee1394:354fc0003d716541
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[354fc0003d716541]
PM: Adding info for ieee1394:354fc0003d716541-0
floppy0: no floppy controllers found
Floppy drive(s): fd0 is 1.44M
lp: driver loaded but no devices found
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda1, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-1, type ext3), uses xattr
Adding 4194296k swap on /dev/VolGroup00/SwapVol.  Priority:-1 extents:1 across:4194296k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
floppy0: no floppy controllers found
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is off for TX and off for RX.
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts

--------------090806000803040406090803--
