Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966446AbWKNXCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966446AbWKNXCH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 18:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966447AbWKNXCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 18:02:06 -0500
Received: from SpacedOut.fries.net ([67.64.210.234]:12949 "EHLO
	SpacedOut.fries.net") by vger.kernel.org with ESMTP id S966436AbWKNXCB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 18:02:01 -0500
Date: Tue, 14 Nov 2006 17:01:58 -0600
From: David Fries <david@fries.net>
To: linux-kernel@vger.kernel.org
Subject: dead? irq nforce chipset
Message-ID: <20061114230158.GA3655@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm having some interrupt problems on a Dell XPS 600.  It is running
Fedora Core 3, with a 2.6.18.2 kernel.org kernel.  It is a dual
Pentium D 3 GHz CPU.  It will behave like the interrupts are not
longer being generated.  If irqbalance is running /proc/interrupts
will show that interrupt no longer incremented when that device is
having problems.  If irqblance isn't running it seems like
/proc/interrupts is still incrementing, but the device isn't getting
them.  I've attached dmesg and lspci.

I've seen SATA errors, USB system completely not responding, and other
issues that could be explained by irq problems.  After some
accumulative observation it is better (runs longer) without running
irqbalance and so with the SATA IRQ I ran in /proc/irq/209 which is
the SATA interrupt while I had bonnie++ running (fresh boot, not in
X),

while true ; do echo 2 > smp_affinity; sleep .001 ; echo 1 > smp_affinity ; sleep .001 ; done

Very shortly I was getting the following SATA errors which the system
did not recover from.

ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: (BMDMA stat 0x24)
ata1.00: tag 0 cmd 0xca Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.00: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.00: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)

I've also seen this in the past.
ata1: command 0xca timeout, stat 0x50 host_stat 0x24
ata1: status=0x50 { DriveReady SeekComplete }
sda: Current: sense key: No Sense
    Additional sense: No additional sense information
Info fld=0x6726

I copied this error from the USB system,

ohci-hcd 000:00:0b.0: IRQ INTR_SF loosage
ohci-hcd 000:00:0b.0: IRQ INTR_SF loosage
ohci-hcd 000:00:0b.0: bad entry 364d6041

Any ideas?  Anyone else seeing any problems?

-- 
David Fries <david@fries.net>
http://fries.net/~david/ (PGP encryption key available)

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.txt"

lspci
00:00.0 Host bridge: nVidia Corporation: Unknown device 0071 (rev a3)
00:00.1 RAM memory: nVidia Corporation: Unknown device 007f (rev a1)
00:00.2 RAM memory: nVidia Corporation: Unknown device 0075 (rev a1)
00:00.3 RAM memory: nVidia Corporation: Unknown device 006f (rev a1)
00:00.4 RAM memory: nVidia Corporation: Unknown device 00b4 (rev a1)
00:01.0 RAM memory: nVidia Corporation: Unknown device 0076 (rev a1)
00:01.1 RAM memory: nVidia Corporation: Unknown device 0078 (rev a1)
00:01.2 RAM memory: nVidia Corporation: Unknown device 0079 (rev a1)
00:01.3 RAM memory: nVidia Corporation: Unknown device 007a (rev a1)
00:01.4 RAM memory: nVidia Corporation: Unknown device 007b (rev a1)
00:01.5 RAM memory: nVidia Corporation: Unknown device 007c (rev a1)
00:01.6 RAM memory: nVidia Corporation: Unknown device 007d (rev a1)
00:02.0 PCI bridge: nVidia Corporation: Unknown device 007e (rev a2)
00:04.0 PCI bridge: nVidia Corporation: Unknown device 007e (rev a2)
00:09.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a4)
00:0a.0 ISA bridge: nVidia Corporation: Unknown device 0050 (rev a4)
00:0a.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
00:0b.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
00:0b.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a4)
00:0f.0 IDE interface: nVidia Corporation CK804 IDE (rev f3)
00:10.0 RAID bus controller: nVidia Corporation CK804 Serial ATA Controller (rev f3)
00:11.0 RAID bus controller: nVidia Corporation CK804 Serial ATA Controller (rev f4)
00:12.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
00:13.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
00:17.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0292 (rev a1)
03:03.0 Multimedia audio controller: Creative Labs: Unknown device 0005
03:04.0 Multimedia video controller: NEC Corporation: Unknown device 013a (rev 0c)
03:05.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
03:05.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
03:0a.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)

lspci -nv
00:00.0 Class 0600: 10de:0071 (rev a3)
        Flags: bus master, 66Mhz, fast devsel, latency 0
        Capabilities: [40] HyperTransport: Host or Secondary Interface

00:00.1 Class 0500: 10de:007f (rev a1)
        Flags: 66Mhz, fast devsel

00:00.2 Class 0500: 10de:0075 (rev a1)
        Flags: 66Mhz, fast devsel

00:00.3 Class 0500: 10de:006f (rev a1)
        Flags: 66Mhz, fast devsel

00:00.4 Class 0500: 10de:00b4 (rev a1)
        Flags: bus master, 66Mhz, fast devsel, latency 0

00:01.0 Class 0500: 10de:0076 (rev a1)
        Flags: 66Mhz, fast devsel

00:01.1 Class 0500: 10de:0078 (rev a1)
        Flags: 66Mhz, fast devsel

00:01.2 Class 0500: 10de:0079 (rev a1)
        Flags: 66Mhz, fast devsel

00:01.3 Class 0500: 10de:007a (rev a1)
        Flags: 66Mhz, fast devsel

00:01.4 Class 0500: 10de:007b (rev a1)
        Flags: 66Mhz, fast devsel

00:01.5 Class 0500: 10de:007c (rev a1)
        Flags: 66Mhz, fast devsel

00:01.6 Class 0500: 10de:007d (rev a1)
        Flags: 66Mhz, fast devsel

00:02.0 Class 0604: 10de:007e (rev a2)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: dd000000-dfefffff
        Prefetchable memory behind bridge: 00000000c0000000-00000000cff00000
        Capabilities: [40] Power Management version 2
        Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
        Capabilities: [80] Express Root Port (Slot+) IRQ 0
        Capabilities: [100] Virtual Channel

00:04.0 Class 0604: 10de:007e (rev a2)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        Capabilities: [40] Power Management version 2
        Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
        Capabilities: [80] Express Root Port (Slot+) IRQ 0
        Capabilities: [100] Virtual Channel

00:09.0 Class 0580: 10de:005e (rev a4)
        Subsystem: 1028:0000
        Flags: bus master, 66Mhz, fast devsel, latency 0
        Capabilities: [44] HyperTransport: Slave or Primary Interface
        Capabilities: [e0] HyperTransport: MSI Mapping

00:0a.0 Class 0601: 10de:0050 (rev a4)
        Subsystem: 1028:01c3
        Flags: bus master, 66Mhz, fast devsel, latency 0

00:0a.1 Class 0c05: 10de:0052 (rev a2)
        Subsystem: 1028:01c3
        Flags: 66Mhz, fast devsel, IRQ 10
        I/O ports at ece0 [size=32]
        I/O ports at 5000 [size=64]
        I/O ports at 5100 [size=64]
        Capabilities: [44] Power Management version 2

00:0b.0 Class 0c03: 10de:005a (rev a2) (prog-if 10)
        Subsystem: 1028:01c3
        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 209
        Memory at dfffc000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

00:0b.1 Class 0c03: 10de:005b (rev a4) (prog-if 20)
        Subsystem: 1028:01c3
        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 50
        Memory at dfffbf00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [44] Debug port
        Capabilities: [80] Power Management version 2

00:0f.0 Class 0101: 10de:0053 (rev f3) (prog-if 8a [Master SecP PriP])
        Subsystem: 10de:cb84
        Flags: bus master, 66Mhz, fast devsel, latency 0
        I/O ports at ecd0 [size=16]
        Capabilities: [44] Power Management version 2

00:10.0 Class 0104: 10de:0054 (rev f3) (prog-if 85)
        Subsystem: 1028:01c3
        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 209
        I/O ports at fe00 [size=8]
        I/O ports at fe10 [size=4]
        I/O ports at fe20 [size=8]
        I/O ports at fe30 [size=4]
        I/O ports at fea0 [size=16]
        Memory at dfffd000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

00:11.0 Class 0104: 10de:0055 (rev f4) (prog-if 85)
        Subsystem: 1028:01c3
        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 217
        I/O ports at fe40 [size=8]
        I/O ports at fe50 [size=4]
        I/O ports at fe60 [size=8]
        I/O ports at fe70 [size=4]
        I/O ports at feb0 [size=16]
        Memory at dfffe000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

00:12.0 Class 0604: 10de:005c (rev a2) (prog-if 01)
        Flags: bus master, 66Mhz, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: d8000000-dcffffff
        Prefetchable memory behind bridge: d0000000-d00fffff

00:13.0 Class 0680: 10de:0057 (rev a3)
        Subsystem: 1028:01c3
        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 225
        Memory at dffff000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at ecc8 [size=8]
        Capabilities: [44] Power Management version 2

00:17.0 Class 0604: 10de:005d (rev a3)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
        Capabilities: [40] Power Management version 2
        Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
        Capabilities: [58] HyperTransport: MSI Mapping
        Capabilities: [80] Express Root Port (Slot+) IRQ 0
        Capabilities: [100] Virtual Channel

01:00.0 Class 0300: 10de:0292 (rev a1)
        Subsystem: 10de:0370
        Flags: fast devsel, IRQ 11
        Memory at dd000000 (32-bit, non-prefetchable) [size=16M]
        Memory at c0000000 (64-bit, prefetchable) [size=256M]
        Memory at de000000 (64-bit, non-prefetchable) [size=16M]
        I/O ports at dc80 [size=128]
        Expansion ROM at dfe00000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
        Capabilities: [78] Express Endpoint IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [128] Power Budgeting

03:03.0 Class 0401: 1102:0005
        Subsystem: 1102:1003
        Flags: bus master, medium devsel, latency 64, IRQ 10
        I/O ports at cce0 [size=32]
        Memory at dce00000 (64-bit, non-prefetchable) [size=2M]
        Memory at d8000000 (64-bit, non-prefetchable) [size=64M]
        Capabilities: [40] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-

03:04.0 Class 0400: 1033:013a (rev 0c)
        Subsystem: 1809:001b
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at dcdfa000 (32-bit, non-prefetchable) [size=8K]
        Memory at dcdf9600 (32-bit, non-prefetchable) [size=512]
        Capabilities: [40] Power Management version 2

03:05.0 Class 0400: 109e:036e (rev 11)
        Subsystem: 0070:13eb
        Flags: bus master, medium devsel, latency 64, IRQ 233
        Memory at d0001000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2

03:05.1 Class 0480: 109e:0878 (rev 11)
        Subsystem: 0070:13eb
        Flags: medium devsel, IRQ 233
        Memory at d0000000 (32-bit, prefetchable) [disabled] [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2

03:0a.0 Class 0c00: 104c:8023 (prog-if 10)
        Subsystem: 1028:01c3
        Flags: bus master, medium devsel, latency 64, IRQ 58
        Memory at dcdf9800 (32-bit, non-prefetchable) [size=2K]
        Memory at dcdfc000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.txt"

CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000e4bd 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) D CPU 3.00GHz stepping 04
Total of 2 processors activated (11973.71 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=0 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=1685
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:12.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKJ] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKK] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKL] (IRQs *3 4 5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKM] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKN] (IRQs *3 4 5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKO] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKP] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [APCA] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APCB] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APCC] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APCD] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCN] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCO] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 9 devices
Generic PHY: Registered new driver
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:01: ioport range 0x800-0x87f has been reserved
pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
pnp: 00:01: ioport range 0x4080-0x40ff has been reserved
PCI: Bridge: 0000:00:02.0
  IO window: d000-dfff
  MEM window: dd000000-dfefffff
  PREFETCH window: c0000000-cfffffff
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:12.0
  IO window: c000-cfff
  MEM window: d8000000-dcffffff
  PREFETCH window: d0000000-d00fffff
PCI: Bridge: 0000:00:17.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:12.0 to 64
PCI: Setting latency timer of device 0000:00:17.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 9, 2621440 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Simple Boot Flag at 0x7a set to 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: disabled - APM is not SMP safe.
audit: initializing netlink socket (disabled)
audit(1163484416.691:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
PCI: Linking AER extended capability on 0000:00:17.0
PCI: Setting latency timer of device 0000:00:02.0 to 64
pcie_portdrv_probe->Dev[007e:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:02.0:pcie00]
Allocate Port Service[0000:00:02.0:pcie03]
PCI: Setting latency timer of device 0000:00:04.0 to 64
pcie_portdrv_probe->Dev[007e:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:04.0:pcie00]
Allocate Port Service[0000:00:04.0:pcie03]
PCI: Setting latency timer of device 0000:00:17.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:17.0:pcie00]
Allocate Port Service[0000:00:17.0:pcie03]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Getting cpuindex for acpiid 0x3
ACPI: Getting cpuindex for acpiid 0x4
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Marvell 88E1101: Registered new driver
Davicom DM9161E: Registered new driver
Davicom DM9131: Registered new driver
Cicada Cis8204: Registered new driver
Cicada Cis8201: Registered new driver
LXT970: Registered new driver
LXT971: Registered new driver
QS6612: Registered new driver
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:0f.0
NFORCE-CK804: chipset revision 243
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: 0000:00:0f.0 (rev f3) UDMA133 controller
    ide0: BM-DMA at 0xecd0-0xecd7, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: Optiarc DVD+/-RW ND-3570A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
libata version 2.00 loaded.
sata_nv 0000:00:10.0: version 2.0
ACPI: PCI Interrupt Link [APCK] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [APCK] -> GSI 23 (level, low) -> IRQ 209
PCI: Setting latency timer of device 0000:00:10.0 to 64
ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 209
ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 209
scsi0 : sata_nv
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7, max UDMA/133, 312500000 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 8
ata1.00: configured for UDMA/133
scsi1 : sata_nv
ata2: SATA link down (SStatus 0 SControl 300)
  Vendor: ATA       Model: ST3160812AS       Rev: 3.AD
  Type:   Direct-Access                      ANSI SCSI revision: 05
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [APCJ] -> GSI 22 (level, low) -> IRQ 217
PCI: Setting latency timer of device 0000:00:11.0 to 64
ata3: SATA max UDMA/133 cmd 0xFE40 ctl 0xFE52 bmdma 0xFEB0 irq 217
ata4: SATA max UDMA/133 cmd 0xFE60 ctl 0xFE72 bmdma 0xFEB8 irq 217
scsi2 : sata_nv
ata3: SATA link down (SStatus 0 SControl 300)
scsi3 : sata_nv
ata4: SATA link down (SStatus 0 SControl 300)
st: Version 20050830, fixed bufsize 32768, s/g segs 256
osst :I: Tape driver with OnStream support version 0.99.4
osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
SCSI device sda: 312500000 512-byte hdwr sectors (160000 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 312500000 512-byte hdwr sectors (160000 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Time: tsc clocksource has been installed.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 248k freed
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.56.
ACPI: PCI Interrupt Link [APCM] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:13.0[A] -> Link [APCM] -> GSI 21 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:13.0 to 64
forcedeth: using HIGHDMA
eth0: forcedeth.c: subsystem: 01028:01c3 bound to 0000:00:13.0
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x5000
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5100
Linux video capture interface: v2.00
bttv: driver version 0.9.16 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI Interrupt Link [APCB] enabled at IRQ 17
ACPI: PCI Interrupt 0000:03:05.0[A] -> Link [APCB] -> GSI 17 (level, low) -> IRQ 233
bttv0: Bt878 (rev 17) at 0000:03:05.0, irq: 233, latency: 64, mmio: 0xd0001000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: Hauppauge (bt878) [card=10,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffffdb [init]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
eth0: no link during initialization.
tveeprom 2-0050: Hauppauge model 44981, rev E199, serial# 8139696
tveeprom 2-0050: tuner model is TCL 2002N 5H (idx 99, type 50)
tveeprom 2-0050: TV standards NTSC(M) (eeprom 0x08)
tveeprom 2-0050: audio processor is None (idx 0)
tveeprom 2-0050: decoder processor is BT878 (idx 14)
tveeprom 2-0050: has no radio, has IR remote
bttv0: Hauppauge eeprom indicates model#44981
bttv0: using tuner=50
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: i2c: checking for TDA9887 @ 0x86... not found
tuner 2-0061: chip found @ 0xc2 (bt878 #0 [sw])
tuner 2-0061: type set to 50 (TCL 2002N)
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
bt878: AUDIO driver version 0.0.0 loaded
bt878: Bt878 AUDIO function found (0).
ACPI: PCI Interrupt 0000:03:05.1[A] -> Link [APCB] -> GSI 17 (level, low) -> IRQ 233
bt878_probe: card id=[0x13eb0070], Unknown card.
Exiting..
ACPI: PCI interrupt for device 0000:03:05.1 disabled
bt878: probe of 0000:03:05.1 failed with error -22
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:0b.1[B] -> Link [APCH] -> GSI 20 (level, low) -> IRQ 50
PCI: Setting latency timer of device 0000:00:0b.1 to 64
ehci_hcd 0000:00:0b.1: EHCI Host Controller
ehci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:0b.1: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:0b.1
ehci_hcd 0000:00:0b.1: irq 50, io mem 0xdfffbf00
ehci_hcd 0000:00:0b.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [APCL] -> GSI 23 (level, low) -> IRQ 209
PCI: Setting latency timer of device 0000:00:0b.0 to 64
ohci_hcd 0000:00:0b.0: OHCI Host Controller
ohci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:0b.0: irq 209, io mem 0xdfffc000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
usb 2-5: new low speed USB device using ohci_hcd and address 2
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt Link [APCC] enabled at IRQ 18
ACPI: PCI Interrupt 0000:03:0a.0[A] -> Link [APCC] -> GSI 18 (level, low) -> IRQ 58
usb 2-5: configuration #1 chosen from 1 choice
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[58]  MMIO=[dcdf9800-dcdf9fff]  Max Packet=[2048]  IR/IT contexts=[4/8]
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
input: Logitech Optical USB Mouse as /class/input/input0
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:0b.0-5
usb 2-6: new low speed USB device using ohci_hcd and address 3
usb 2-6: configuration #1 chosen from 1 choice
input: Dell Dell USB Keyboard as /class/input/input1
input: USB HID v1.10 Keyboard [Dell Dell USB Keyboard] on usb-0000:00:0b.0-6
eth0: link up.
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[801400009c3e5f22]
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [VBTN]
ibm_acpi: ec object not found
EXT3 FS on sda1, internal journal
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
Adding 2040244k swap on /dev/sda2.  Priority:-1 extents:1 across:2040244k
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: unable to find recovery directory /var/lib/nfs/v4recovery
NFSD: starting 90-second grace period
eth0: no IPv6 routers present
eth0: too many iterations (6) in nv_nic_irq.
eth0: too many iterations (6) in nv_nic_irq.
eth0: too many iterations (6) in nv_nic_irq.
eth0: too many iterations (6) in nv_nic_irq.
eth0: too many iterations (6) in nv_nic_irq.

--HcAYCG3uE/tztfnV--
