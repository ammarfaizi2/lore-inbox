Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbVF2EaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVF2EaU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 00:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVF2EaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 00:30:19 -0400
Received: from iron.pdx.net ([207.149.241.18]:15053 "EHLO iron.pdx.net")
	by vger.kernel.org with ESMTP id S262265AbVF2EWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 00:22:31 -0400
Subject: Re: ASUS K8N-DL Beta BIOS AKA PROBLEM: Devices behind PCI
	Express-to-PCI bridge not mapped
From: Sean Bruno <sean.bruno@dsl-only.net>
To: linux-kernel@vger.kernel.org
Cc: kevin.mullins@asusts.com, JASON_RILEY@asusts.com, karim@opersys.com,
       Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Peter Buckingham <peter@pantasys.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, dave.jones@redhat.com
In-Reply-To: <42C1FD7F.2060003@opersys.com>
References: <1119996349.3484.40.camel@oscar.metro1.com>
	 <42C1FD7F.2060003@opersys.com>
Content-Type: multipart/mixed; boundary="=-bj9gQsnHOjsaZ8C0vWNP"
Date: Tue, 28 Jun 2005 21:22:22 -0700
Message-Id: <1120018942.6936.20.camel@home-lap>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bj9gQsnHOjsaZ8C0vWNP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-06-28 at 21:46 -0400, Karim Yaghmour wrote:
> Sean Bruno wrote:
> > Not sure if this will help, but ASUS just released a BIOS update for
> > those of us struggling with the Dual-Opteron Mobo, K8N-DL.
> 
> Apart from the flashy start screen, same problems for me:
> - No Ethernet
> - No USB
> - Still no operational secondary IDE..
> 
> :(
> 
> Karim


There is a definite change of behavior from the 1003 BIOS release
however.  I no longer see the "Failed to allocate mem resource" errors
which seemed to be relevant to my issues.  However, the USB, Sound,
Ethernet controllers still seem unusable.  

I have attached my dmesg output, dmidecode and lspci output for someone
on the list to interpret.

I am not sure which bits are hanging me up thus far, but I have noted
that "lsusb" and "lshw" hang if I have anything attached to the USB
bus(like a memory stick).  If there is nothing on the USB bus when I
reboot under 2.6.12-git10, I can run lsusb and lshw without issue.

What is even more odd, if I insert my little USB flash disk into a USB
socket, lsusb shows that something is connected as far as the HUB is
concerened(indicated by Port 9 changing state to "Connected"):

before insertion:
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0100 power
   Port 3: 0000.0100 power
   Port 4: 0000.0100 power
   Port 5: 0000.0100 power
   Port 6: 0000.0100 power
   Port 7: 0000.0100 power
   Port 8: 0000.0100 power
   Port 9: 0000.0100 power
   Port 10: 0000.0100 power

after insertion:
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0100 power
   Port 3: 0000.0100 power
   Port 4: 0000.0100 power
   Port 5: 0000.0100 power
   Port 6: 0000.0100 power
   Port 7: 0000.0100 power
   Port 8: 0000.0100 power
   Port 9: 0001.0000 C_CONNECT
   Port 10: 0000.0100 power

So something definitely has gotten better.  

I tried Ivan Kokshaysky's patch from:
http://lkml.org/lkml/2005/6/10/86

This doesn't seem to have a negative effect, but doesn't really have a
positive effect either.

I have added Dave Jones to this thread as he happens to have several
tickets on the Red Hat bugzilla that I opened on these issues.

I have also added two of the fine folks over at Asus who have listened
to me patiently on the phone and gave me the new BIOS to test out today.

Thank you all who have put up with me "whining" on the list, I am really
enjoying the challenge that this new machine has given me.

Sean

--=-bj9gQsnHOjsaZ8C0vWNP
Content-Disposition: attachment; filename=dmesg.out
Content-Type: text/plain; name=dmesg.out; charset=UTF-8
Content-Transfer-Encoding: 7bit

Bootdata ok (command line is ro root=/dev/VolGroup00/LogVol00 rhgb apic=debug acpi=verbose)
Linux version 2.6.12-git10 (root@home-desk) (gcc version 4.0.0 20050519 (Red Hat 4.0.0-8)) #2 SMP Tue Jun 28 13:24:51 PDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e400 (usable)
 BIOS-e820: 000000000009e400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
 BIOS-e820: 00000000bfff0000 - 00000000bfff3000 (ACPI NVS)
 BIOS-e820: 00000000bfff3000 - 00000000c0000000 (ACPI data)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 00000001c0000000 (usable)
ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7650
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff30c0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 0x00000000bfff9680
ACPI: SRAT (v001 AMD    HAMMER   0x00000001 AMD  0x00000001) @ 0x00000000bfff9880
ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff99c0
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff9580
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 1 -> APIC 1 -> Node 1
SRAT: Node 0 PXM 0 0-9ffff
SRAT: Node 0 PXM 0 0-bfffffff
SRAT: Node 0 PXM 0 0-13fffffff
SRAT: Node 1 PXM 1 140000000-1bfffffff
node 1 shift 24 addr 140000000 conflict 0
Bootmem setup node 0 0000000000000000-000000013fffffff
Bootmem setup node 1 0000000140000000-00000001bfffffff
On node 0 totalpages: 1310719
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 1306623 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 524287
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 524287 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
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
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at c0000000 (gap: c0000000:20000000)
Checking aperture...
CPU 0: aperture @ 8000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000
Built 2 zonelists
Kernel command line: ro root=/dev/VolGroup00/LogVol00 rhgb apic=debug acpi=verbose
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2010.317 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Memory: 6105096k/7340032k available (2421k kernel code, 0k reserved, 1295k data, 224k init)
Calibrating delay using timer specific routine.. 4024.92 BogoMIPS (lpj=8049856)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
enabled ExtINT on CPU#0
ENABLING IO-APIC IRQs
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 4-0, 4-16, 4-17, 4-18, 4-19, 4-20, 4-21, 4-22, 4-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
timer doesn't work through the IO-APIC - disabling NMI Watchdog!
...trying to set up timer as Virtual Wire IRQ...Uhhuh. NMI received for unknown reason 3d.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
 failed.
...trying to set up timer as ExtINT IRQ... works.
Using local APIC timer interrupts.
Detected 12.564 MHz APIC timer.
Booting processor 1/1 rip 6000 rsp ffff8101bff89f58
Initializing CPU#1
masked ExtINT on CPU#1
Calibrating delay using timer specific routine.. 2010.46 BogoMIPS (lpj=4020939)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
AMD Opteron(tm) Processor 246 stepping 0a
CPU 1: Syncing TSC to CPU 0.
Brought up 2 CPUs
CPU 1: synchronized TSC with CPU 0 (last diff 17 cycles, maxerr 519 cycles)
Disabling vsyscall due to use of PM timer
time.c: Using PM based timekeeping.
testing NMI watchdog ... CPU#0: NMI appears to be stuck (11->11)!
checking if image is initramfs... it is
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.LNK0] in namespace, AE_NOT_FOUND
search_node ffff810142857280 start_node ffff810142857280 return_node 0000000000000000
    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.APC0] in namespace, AE_NOT_FOUND
search_node ffff810142857180 start_node ffff810142857180 return_node 0000000000000000
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:09.0
Boot video device is 0000:04:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.APC0] in namespace, AE_NOT_FOUND
search_node ffff810142857180 start_node ffff810142857180 return_node 0000000000000000
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0._PRT] (Node ffff810142857140), AE_NOT_FOUND
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
IOAPIC[0]: Set PCI routing entry (4-8 -> 0x69 -> IRQ 8 Mode:0 Active:0)
IOAPIC[0]: Set PCI routing entry (4-13 -> 0x91 -> IRQ 13 Mode:0 Active:0)
IOAPIC[0]: Set PCI routing entry (4-6 -> 0x59 -> IRQ 6 Mode:0 Active:0)
IOAPIC[0]: Set PCI routing entry (4-4 -> 0x49 -> IRQ 4 Mode:0 Active:0)
IOAPIC[0]: Set PCI routing entry (4-7 -> 0x61 -> IRQ 7 Mode:0 Active:0)
IOAPIC[0]: Set PCI routing entry (4-12 -> 0x89 -> IRQ 12 Mode:0 Active:0)
IOAPIC[0]: Set PCI routing entry (4-1 -> 0x39 -> IRQ 1 Mode:0 Active:0)
IOAPIC[0]: Set PCI routing entry (4-10 -> 0x79 -> IRQ 10 Mode:0 Active:0)
pnp: PnP ACPI: found 15 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
number of MP IRQ sources: 15.
number of IO-APIC #4 registers: 24.
testing the IO APIC.......................

IO APIC #4......
.... register #00: 00000000
.......    : physical APIC id: 00
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  1    0    0   0   0    1    1    39
 02 003 03  1    0    0   0   0    0    0    00
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  1    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  1    0    0   0   0    1    1    59
 07 003 03  1    0    0   0   0    1    1    61
 08 003 03  1    0    0   0   0    1    1    69
 09 003 03  0    1    0   0   0    1    1    71
 0a 003 03  1    0    0   0   0    1    1    79
 0b 003 03  0    0    0   0   0    1    1    81
 0c 003 03  1    0    0   0   0    1    1    89
 0d 003 03  1    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
Using vector-based indexing
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
PCI: Bridge: 0000:00:09.0
  IO window: d000-dfff
  MEM window: fe600000-fe8fffff
  PREFETCH window: fe900000-fe9fffff
PCI: Bridge: 0000:00:0c.0
  IO window: c000-cfff
  MEM window: fe500000-fe5fffff
  PREFETCH window: fe400000-fe4fffff
PCI: Bridge: 0000:00:0d.0
  IO window: b000-bfff
  MEM window: fe300000-fe3fffff
  PREFETCH window: fe200000-fe2fffff
PCI: Bridge: 0000:00:0e.0
  IO window: a000-afff
  MEM window: fb000000-fdffffff
  PREFETCH window: d0000000-dfffffff
PCI: Setting latency timer of device 0000:00:09.0 to 64
PCI: Setting latency timer of device 0000:00:0c.0 to 64
PCI: Setting latency timer of device 0000:00:0d.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 8000000 size 65536 KB
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
pnp: 00:00: ioport range 0x4000-0x407f could not be reserved
pnp: 00:00: ioport range 0x4080-0x40ff has been reserved
pnp: 00:00: ioport range 0x4400-0x447f has been reserved
pnp: 00:00: ioport range 0x4480-0x44ff could not be reserved
pnp: 00:00: ioport range 0x4800-0x487f has been reserved
pnp: 00:00: ioport range 0x4880-0x48ff has been reserved
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1119991771.764:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
PCI: Setting latency timer of device 0000:00:0c.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
PCI: Setting latency timer of device 0000:00:0d.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
NFORCE-CK804: chipset revision 242
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
    ide0: BM-DMA at 0xfa00-0xfa07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfa08-0xfa0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: Pioneer DVD-ROM ATAPIModel DVD-105S 013, ATAPI CD/DVD-ROM drive
hdd: Polaroid BurnMAX48, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide0...
hdc: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.38
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard on isa0060/serio0
IP: routing cache hash table of 32768 buckets, 512Kbytes
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.40.2)
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0xe (1200 mV)
cpu_init done, current fid 0xc, vid 0x2
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0xe (1200 mV)
cpu_init done, current fid 0x2, vid 0xe
Freeing unused kernel memory: 224k freed
SCSI subsystem initialized
libata version 1.11 loaded.
sata_sil version 0.9
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
IOAPIC[0]: Set PCI routing entry (4-17 -> 0xc9 -> IRQ 16 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:01:09.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 201
ata1: SATA max UDMA/100 cmd 0xFFFFC20000004080 ctl 0xFFFFC2000000408A bmdma 0xFFFFC20000004000 irq 201
ata2: SATA max UDMA/100 cmd 0xFFFFC200000040C0 ctl 0xFFFFC200000040CA bmdma 0xFFFFC20000004008 irq 201
ata3: SATA max UDMA/100 cmd 0xFFFFC20000004280 ctl 0xFFFFC2000000428A bmdma 0xFFFFC20000004200 irq 201
ata4: SATA max UDMA/100 cmd 0xFFFFC200000042C0 ctl 0xFFFFC200000042CA bmdma 0xFFFFC20000004208 irq 201
logips2pp: Detected unknown logitech mouse model 62
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3e01 87:4003 88:20ff
ata1: dev 0 ATA, max UDMA7, 312581808 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c68 86:3c01 87:4003 88:20ff
ata2: dev 0 ATA, max UDMA7, 312581808 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
ata3: no device found (phy stat 00000000)
scsi2 : sata_sil
ata4: no device found (phy stat 00000000)
scsi3 : sata_sil
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
sata_nv version 0.6
ACPI: PCI Interrupt 0000:00:07.0[A]: no GSI - using IRQ 5
IOAPIC[0]: Set PCI routing entry (4-5 -> 0xd1 -> IRQ 17 Mode:1 Active:1)
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata5: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xF500 irq 5
ata6: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xF508 irq 5
ata5: no device found (phy stat 00000000)
scsi4 : sata_nv
ata6: no device found (phy stat 00000000)
scsi5 : sata_nv
ACPI: PCI Interrupt 0000:00:08.0[A]: no GSI - using IRQ 11
IOAPIC[0]: Set PCI routing entry (4-11 -> 0xd9 -> IRQ 18 Mode:1 Active:1)
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata7: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xF000 irq 11
ata8: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xF008 irq 11
ata7: no device found (phy stat 00000000)
scsi6 : sata_nv
ata8: no device found (phy stat 00000000)
scsi7 : sata_nv
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
cdrom: open failed.
cdrom: open failed.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
tg3.c:v3.32 (June 24, 2005)
ACPI: PCI Interrupt 0000:02:00.0[A]: no GSI - using IRQ 5
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: Tigon3 [partno(BCM95751) rev 4101 PHY(5750)] (PCIX:100MHz:32-bit) 10/100/1000BaseT Ethernet 00:11:d8:d3:08:05
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth0: dma_rwctrl[76180000]
e100: Intel(R) PRO/100 Network Driver, 3.4.8-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
IOAPIC[0]: Set PCI routing entry (4-18 -> 0xe1 -> IRQ 19 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:01:06.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 225
e100: eth1: e100_probe: addr 0xfe8ff000, irq 225, MAC addr 00:03:47:96:ED:4E
ACPI: PCI Interrupt 0000:00:04.0[A]: no GSI - using IRQ 3
IOAPIC[0]: Set PCI routing entry (4-3 -> 0xe9 -> IRQ 20 Mode:1 Active:1)
PCI: Setting latency timer of device 0000:00:04.0 to 64
intel8x0_measure_ac97_clock: measured 50892 usecs
intel8x0: clocking to 46827
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
ACPI: PCI Interrupt 0000:00:02.1[B]: no GSI - using IRQ 11
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: debug port 1
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: irq 11, io mem 0xfeb00000
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: park 0
ehci_hcd 0000:00:02.1: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:00:02.0[A]: no GSI - using IRQ 5
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 5, io mem 0xfeaff000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
ieee1394: Initialized config rom entry `ip1394'
usb 2-9: new full speed USB device using ohci_hcd and address 2
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
IOAPIC[0]: Set PCI routing entry (4-16 -> 0x32 -> IRQ 21 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 50
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[50]  MMIO=[fe8fe000-fe8fe7ff]  Max Packet=[2048]
ohci_hcd 0000:00:02.0: Unlink after no-IRQ?  Controller is probably using the wrong IRQ.
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011d80000277ca6]
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff80454000(lo)
IPv6 over IPv4 tunneling driver
ACPI: Power Button (FF) [PWRF]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2031608k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1
e100: eth1: e100_watchdog: link up, 100Mbps, full-duplex
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
lp0: console ready
eth1: no IPv6 routers present

--=-bj9gQsnHOjsaZ8C0vWNP
Content-Disposition: attachment; filename=lspci_new.out
Content-Type: text/plain; name=lspci_new.out; charset=UTF-8
Content-Transfer-Encoding: 7bit

00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 8162
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [44] HyperTransport: Slave or Primary Interface
		Command: BaseUnitID=0 UnitCnt=15 MastHost- DefDir- DUL-
		Link Control 0: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Revision ID: 1.03
		Link Frequency 0: 1.0GHz
		Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 0: 200MHz+ 300MHz+ 400MHz+ 500MHz+ 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
		Link Frequency 1: 200MHz
		Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Error Handling: PFlE+ OFlE+ PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
		Prefetchable memory behind bridge Upper: 00-00
		Bus Number: 00
	Capabilities: [e0] HyperTransport: MSI Mapping

00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 8162
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 8162
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at ff00 [size=32]
	Region 4: I/O ports at 4c00 [size=64]
	Region 5: I/O ports at 4c40 [size=64]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 8162
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 8162
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at feb00000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] Debug port
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio Controller (rev a2)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 8174
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at fc00 [size=256]
	Region 1: I/O ports at fb00 [size=256]
	Region 2: Memory at feafd000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2) (prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 8162
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at fa00 [size=16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3) (prog-if 85 [Master SecO PriO])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 8162
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 09f0 [size=8]
	Region 1: I/O ports at 0bf0 [size=4]
	Region 2: I/O ports at 0970 [size=8]
	Region 3: I/O ports at 0b70 [size=4]
	Region 4: I/O ports at f500 [size=16]
	Region 5: Memory at feafc000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3) (prog-if 85 [Master SecO PriO])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 8162
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 09e0 [size=8]
	Region 1: I/O ports at 0be0 [size=4]
	Region 2: I/O ports at 0960 [size=8]
	Region 3: I/O ports at 0b60 [size=4]
	Region 4: I/O ports at f000 [size=16]
	Region 5: Memory at feafb000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=128
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fe600000-fe8fffff
	Prefetchable memory behind bridge: fe900000-fe9fffff
	Secondary status: 66Mhz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR+
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 08
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fe500000-fe5fffff
	Prefetchable memory behind bridge: 00000000fe400000-00000000fe400000
	Secondary status: 66Mhz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
		Address: 00000000fee01004  Data: 40b1
	Capabilities: [58] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 <4us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 2
		Link: Latency L0s <512ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 4, PowerLimit 10.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-

00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 08
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: fe300000-fe3fffff
	Prefetchable memory behind bridge: 00000000fe200000-00000000fe200000
	Secondary status: 66Mhz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
		Address: 00000000fee01004  Data: 40b9
	Capabilities: [58] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 <4us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 1
		Link: Latency L0s <512ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 2, PowerLimit 10.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-

00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 08
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: fb000000-fdffffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000dff00000
	Secondary status: 66Mhz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
		Address: 00000000fee01004  Data: 40c1
	Capabilities: [58] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 <4us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s, Port 0
		Link: Latency L0s <512ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 1, PowerLimit 75.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] HyperTransport: Host or Secondary Interface
	!!! Possibly incomplete decoding
		Command: WarmRst+ DblEnd-
		Link Control: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0
		Link Config: MLWI=16bit MLWO=16bit LWI=N/C LWO=N/C
		Revision ID: 1.02
	Capabilities: [a0] HyperTransport: Host or Secondary Interface
	!!! Possibly incomplete decoding
		Command: WarmRst+ DblEnd-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
		Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
		Revision ID: 1.02
	Capabilities: [c0] HyperTransport: Host or Secondary Interface
	!!! Possibly incomplete decoding
		Command: WarmRst+ DblEnd-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
		Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
		Revision ID: 1.02

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] HyperTransport: Host or Secondary Interface
	!!! Possibly incomplete decoding
		Command: WarmRst+ DblEnd-
		Link Control: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0
		Link Config: MLWI=16bit MLWO=16bit LWI=N/C LWO=N/C
		Revision ID: 1.02
	Capabilities: [a0] HyperTransport: Host or Secondary Interface
	!!! Possibly incomplete decoding
		Command: WarmRst+ DblEnd-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
		Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
		Revision ID: 1.02
	Capabilities: [c0] HyperTransport: Host or Secondary Interface
	!!! Possibly incomplete decoding
		Command: WarmRst+ DblEnd-
		Link Control: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0
		Link Config: MLWI=16bit MLWO=16bit LWI=N/C LWO=N/C
		Revision ID: 1.02

00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

01:06.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corporation EtherExpress PRO/100+ Server Adapter (PILA8470B)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 225
	Region 0: Memory at fe8ff000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at df00 [size=64]
	Region 2: Memory at fe700000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at fe900000 [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:08.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 815b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 50
	Region 0: Memory at fe8fe000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at fe8f8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

01:09.0 RAID bus controller: Silicon Image, Inc. SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 8136
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size 08
	Interrupt: pin A routed to IRQ 201
	Region 0: I/O ports at de00 [size=8]
	Region 1: I/O ports at dd00 [size=4]
	Region 2: I/O ports at dc00 [size=8]
	Region 3: I/O ports at db00 [size=4]
	Region 4: I/O ports at da00 [size=16]
	Region 5: Memory at fe8fd000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at fe600000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751 Gigabit Ethernet PCI Express (rev 11)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 814b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at fe5f0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: 0e5c013020084008  Data: 0000
	Capabilities: [d0] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <4us, L1 unlimited
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 0
		Link: Latency L0s <4us, L1 <64us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1

04:00.0 VGA compatible controller: nVidia Corporation NV44 [GeForce 6200 TurboCache] (rev a1) (prog-if 00 [VGA])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 81ae
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fb000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at fc000000 (64-bit, non-prefetchable) [size=16M]
	Expansion ROM at fd000000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 <4us
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 128 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x16


--=-bj9gQsnHOjsaZ8C0vWNP
Content-Disposition: attachment; filename=dmidecode.out
Content-Type: text/plain; name=dmidecode.out; charset=UTF-8
Content-Transfer-Encoding: 7bit

# dmidecode 2.6
SMBIOS 2.3 present.
56 structures occupying 1770 bytes.
Table at 0x000F0000.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information
		Vendor: Phoenix Technologies, LTD
		Version: ASUS K8N-DL ACPI BIOS Revision 1004.007
		Release Date: 06/28/2005
		Address: 0xE0000
		Runtime Size: 128 kB
		ROM Size: 512 kB
		Characteristics:
			PCI is supported
			PNP is supported
			APM is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			Boot from CD is supported
			Selectable boot is supported
			BIOS ROM is socketed
			EDD is supported
			5.25"/360 KB floppy services are supported (int 13h)
			5.25"/1.2 MB floppy services are supported (int 13h)
			3.5"/720 KB floppy services are supported (int 13h)
			3.5"/2.88 MB floppy services are supported (int 13h)
			Print screen service is supported (int 5h)
			8042 keyboard services are supported (int 9h)
			Serial services are supported (int 14h)
			Printer services are supported (int 17h)
			CGA/mono video services are supported (int 10h)
			ACPI is supported
			USB legacy is supported
			LS-120 boot is supported
			ATAPI Zip drive boot is supported
			BIOS boot specification is supported
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer: System manufacturer
		Product Name: System Product Name
		Version: System Version
		Serial Number: System Serial Number
		UUID: 50ECB49C-06A4-D911-B7D5-E9686682C17E
		Wake-up Type: Power Switch
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: ASUSTek Computer INC.
		Product Name: K8N-DL
		Version: 1.XX    
		Serial Number: 123456789000
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information
		Manufacturer: Chassis Manufacture
		Type: Tower
		Lock: Not Present
		Version: Chassis Version
		Serial Number: EVAL          
		Asset Tag: 123456789000
		Boot-up State: Safe
		Power Supply State: Safe
		Thermal State: Safe
		Security Status: None
		OEM Information: 0x00000001
Handle 0x0004
	DMI type 4, 35 bytes.
	Processor Information
		Socket Designation: Socket 940
		Type: Central Processor
		Family: Opteron
		Manufacturer: AMD
		ID: 5A 0F 00 00 FF FB 8B 07
		Signature: Extended Family 0, Model 5, Stepping A
		Flags:
			FPU (Floating-point unit on-chip)
			VME (Virtual mode extension)
			DE (Debugging extension)
			PSE (Page size extension)
			TSC (Time stamp counter)
			MSR (Model specific registers)
			PAE (Physical address extension)
			MCE (Machine check exception)
			CX8 (CMPXCHG8 instruction supported)
			APIC (On-chip APIC hardware supported)
			SEP (Fast system call)
			MTRR (Memory type range registers)
			PGE (Page global enable)
			MCA (Machine check architecture)
			CMOV (Conditional move instruction supported)
			PAT (Page attribute table)
			PSE-36 (36-bit page size extension)
			CLFSH (CLFLUSH instruction supported)
			MMX (MMX technology supported)
			FXSR (Fast floating-point save and restore)
			SSE (Streaming SIMD extensions)
			SSE2 (Streaming SIMD extensions 2)
		Version: AMD Opteron(tm) Processor 246
		Voltage: 1.5 V
		External Clock: 200 MHz
		Max Speed: 3700 MHz
		Current Speed: 2000 MHz
		Status: Populated, Enabled
		Upgrade: Socket 940
		L1 Cache Handle: 0x000D
		L2 Cache Handle: 0x000F
		L3 Cache Handle: Not Provided
		Serial Number:  
		Asset Tag:  
		Part Number:  
Handle 0x0005
	DMI type 4, 35 bytes.
	Processor Information
		Socket Designation: Socket 940
		Type: Central Processor
		Family: Opteron
		Manufacturer: AMD
		ID: 5A 0F 00 00 FF FB 8B 07
		Signature: Extended Family 0, Model 5, Stepping A
		Flags:
			FPU (Floating-point unit on-chip)
			VME (Virtual mode extension)
			DE (Debugging extension)
			PSE (Page size extension)
			TSC (Time stamp counter)
			MSR (Model specific registers)
			PAE (Physical address extension)
			MCE (Machine check exception)
			CX8 (CMPXCHG8 instruction supported)
			APIC (On-chip APIC hardware supported)
			SEP (Fast system call)
			MTRR (Memory type range registers)
			PGE (Page global enable)
			MCA (Machine check architecture)
			CMOV (Conditional move instruction supported)
			PAT (Page attribute table)
			PSE-36 (36-bit page size extension)
			CLFSH (CLFLUSH instruction supported)
			MMX (MMX technology supported)
			FXSR (Fast floating-point save and restore)
			SSE (Streaming SIMD extensions)
			SSE2 (Streaming SIMD extensions 2)
		Version: AMD Opteron(tm) Processor 246
		Voltage: 1.5 V
		External Clock: 200 MHz
		Max Speed: 3700 MHz
		Current Speed: 2000 MHz
		Status: Populated, Enabled
		Upgrade: Socket 940
		L1 Cache Handle: 0x000E
		L2 Cache Handle: 0x0010
		L3 Cache Handle: Not Provided
		Serial Number:  
		Asset Tag:  
		Part Number:  
Handle 0x0006
	DMI type 5, 28 bytes.
	Memory Controller Information
		Error Detecting Method: 64-bit ECC
		Error Correcting Capabilities:
			None
		Supported Interleave: One-way Interleave
		Current Interleave: One-way Interleave
		Maximum Memory Module Size: 4096 MB
		Maximum Total Memory Size: 24576 MB
		Supported Speeds:
			70 ns
			60 ns
			50 ns
		Supported Memory Types:
			Standard
			SDRAM
		Memory Module Voltage: 2.9 V
		Associated Memory Slots: 6
			0x0007
			0x0008
			0x0009
			0x000A
			0x000B
			0x000C
		Enabled Error Correcting Capabilities: None
Handle 0x0007
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: A0
		Bank Connections: 0 1
		Current Speed: 70 ns
		Type: DIMM
		Installed Size: 1024 MB (Double-bank Connection)
		Enabled Size: 1024 MB (Double-bank Connection)
		Error Status: OK
Handle 0x0008
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: A1
		Bank Connections: 2 3
		Current Speed: 70 ns
		Type: DIMM
		Installed Size: 1024 MB (Double-bank Connection)
		Enabled Size: 1024 MB (Double-bank Connection)
		Error Status: OK
Handle 0x0009
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: A2
		Bank Connections: 4 5
		Current Speed: 70 ns
		Type: DIMM
		Installed Size: 1024 MB (Double-bank Connection)
		Enabled Size: 1024 MB (Double-bank Connection)
		Error Status: OK
Handle 0x000A
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: A3
		Bank Connections: 6 7
		Current Speed: 70 ns
		Type: DIMM
		Installed Size: 1024 MB (Double-bank Connection)
		Enabled Size: 1024 MB (Double-bank Connection)
		Error Status: OK
Handle 0x000B
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: A4
		Bank Connections: 8 9
		Current Speed: 70 ns
		Type: DIMM
		Installed Size: 1024 MB (Double-bank Connection)
		Enabled Size: 1024 MB (Double-bank Connection)
		Error Status: OK
Handle 0x000C
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: A5
		Bank Connections: 10 11
		Current Speed: 70 ns
		Type: DIMM
		Installed Size: 1024 MB (Double-bank Connection)
		Enabled Size: 1024 MB (Double-bank Connection)
		Error Status: OK
Handle 0x000D
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L1 Cache
		Configuration: Enabled, Not Socketed, Level 1
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 128 KB
		Maximum Size: 128 KB
		Supported SRAM Types:
			Synchronous
		Installed SRAM Type: Synchronous
		Speed: Unknown
		Error Correction Type: Single-bit ECC
		System Type: Data
		Associativity: 4-way Set-associative
Handle 0x000E
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L1 Cache
		Configuration: Enabled, Not Socketed, Level 1
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 128 KB
		Maximum Size: 128 KB
		Supported SRAM Types:
			Synchronous
		Installed SRAM Type: Synchronous
		Speed: Unknown
		Error Correction Type: Single-bit ECC
		System Type: Data
		Associativity: 4-way Set-associative
Handle 0x000F
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L2 Cache
		Configuration: Enabled, Not Socketed, Level 2
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 1024 KB
		Maximum Size: 1024 KB
		Supported SRAM Types:
			Synchronous
		Installed SRAM Type: Synchronous
		Speed: Unknown
		Error Correction Type: Single-bit ECC
		System Type: Unified
		Associativity: 4-way Set-associative
Handle 0x0010
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L2 Cache
		Configuration: Enabled, Not Socketed, Level 2
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 1024 KB
		Maximum Size: 1024 KB
		Supported SRAM Types:
			Synchronous
		Installed SRAM Type: Synchronous
		Speed: Unknown
		Error Correction Type: Single-bit ECC
		System Type: Unified
		Associativity: 4-way Set-associative
Handle 0x0011
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: PRIMARY IDE
		Internal Connector Type: On Board IDE
		External Reference Designator: Not Specified
		External Connector Type: None
		Port Type: Other
Handle 0x0012
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: SECONDARY IDE
		Internal Connector Type: On Board IDE
		External Reference Designator: Not Specified
		External Connector Type: None
		Port Type: Other
Handle 0x0013
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: FDD
		Internal Connector Type: On Board Floppy
		External Reference Designator: Not Specified
		External Connector Type: None
		Port Type: 8251 FIFO Compatible
Handle 0x0014
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: COM1
		Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
		External Reference Designator:  
		External Connector Type: DB-9 male
		Port Type: Serial Port 16450 Compatible
Handle 0x0015
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: COM2
		Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
		External Reference Designator:  
		External Connector Type: DB-9 male
		Port Type: Serial Port 16450 Compatible
Handle 0x0016
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: LPT1
		Internal Connector Type: DB-25 female
		External Reference Designator:  
		External Connector Type: DB-25 female
		Port Type: Parallel Port ECP/EPP
Handle 0x0017
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: PS/2 Keyboard
		Internal Connector Type: PS/2
		External Reference Designator:  
		External Connector Type: PS/2
		Port Type: Keyboard Port
Handle 0x0018
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: PS/2 Mouse
		Internal Connector Type: PS/2
		External Reference Designator:  
		External Connector Type: PS/2
		Port Type: Mouse Port
Handle 0x0019
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: USB1
		External Connector Type: Other
		Port Type: USB
Handle 0x001A
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: USB2
		External Connector Type: Other
		Port Type: USB
Handle 0x001B
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: USB3
		External Connector Type: Other
		Port Type: USB
Handle 0x001C
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: USB4
		External Connector Type: Other
		Port Type: USB
Handle 0x001D
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: USB5
		External Connector Type: Other
		Port Type: USB
Handle 0x001E
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: USB6
		External Connector Type: Other
		Port Type: USB
Handle 0x001F
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: USB7
		External Connector Type: Other
		Port Type: USB
Handle 0x0020
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: USB8
		External Connector Type: Other
		Port Type: USB
Handle 0x0021
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: USB9
		External Connector Type: Other
		Port Type: USB
Handle 0x0022
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: USB10
		External Connector Type: Other
		Port Type: USB
Handle 0x0023
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCIEX1_1
		Type: <OUT OF SPEC><OUT OF SPEC>
		Current Usage: Available
		Length: Other
		Characteristics:
			5.0 V is provided
			PME signal is supported
Handle 0x0024
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCIEX16_1
		Type: <OUT OF SPEC><OUT OF SPEC>
		Current Usage: In Use
		Length: Other
		Characteristics:
			5.0 V is provided
			PME signal is supported
Handle 0x0025
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI1
		Type: 32-bit PCI
		Current Usage: Available
		Length: Short
		ID: 3
		Characteristics:
			5.0 V is provided
			PME signal is supported
Handle 0x0026
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI2
		Type: 32-bit PCI
		Current Usage: In Use
		Length: Short
		ID: 4
		Characteristics:
			5.0 V is provided
			PME signal is supported
Handle 0x0027
	DMI type 13, 22 bytes.
	BIOS Language Information
		Installable Languages: 3
			n|US|iso8859-1
			n|US|iso8859-1
			r|CA|iso8859-1
		Currently Installed Language: n|US|iso8859-1
Handle 0x0028
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: System Memory
		Error Correction Type: None
		Maximum Capacity: 24 GB
		Error Information Handle: Not Provided
		Number Of Devices: 6
Handle 0x0029
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0028
		Error Information Handle: Not Provided
		Total Width: 72 bits
		Data Width: 64 bits
		Size: 1024 MB
		Form Factor: DIMM
		Set: None
		Locator: A0
		Bank Locator: Bank0/1
		Type: Unknown
		Type Detail: None
		Speed: Unknown
		Manufacturer: None
		Serial Number: None
		Asset Tag: None
		Part Number: None
Handle 0x002A
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0028
		Error Information Handle: Not Provided
		Total Width: 72 bits
		Data Width: 64 bits
		Size: 1024 MB
		Form Factor: DIMM
		Set: None
		Locator: A1
		Bank Locator: Bank2/3
		Type: Unknown
		Type Detail: None
		Speed: Unknown
		Manufacturer: None
		Serial Number: None
		Asset Tag: None
		Part Number: None
Handle 0x002B
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0028
		Error Information Handle: Not Provided
		Total Width: 72 bits
		Data Width: 64 bits
		Size: 1024 MB
		Form Factor: DIMM
		Set: None
		Locator: A2
		Bank Locator: Bank4/5
		Type: Unknown
		Type Detail: None
		Speed: Unknown
		Manufacturer: None
		Serial Number: None
		Asset Tag: None
		Part Number: None
Handle 0x002C
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0028
		Error Information Handle: Not Provided
		Total Width: 72 bits
		Data Width: 64 bits
		Size: 1024 MB
		Form Factor: DIMM
		Set: None
		Locator: A3
		Bank Locator: Bank6/7
		Type: Unknown
		Type Detail: None
		Speed: Unknown
		Manufacturer: None
		Serial Number: None
		Asset Tag: None
		Part Number: None
Handle 0x002D
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0028
		Error Information Handle: Not Provided
		Total Width: 72 bits
		Data Width: 64 bits
		Size: 1024 MB
		Form Factor: DIMM
		Set: None
		Locator: A4
		Bank Locator: Bank8/9
		Type: Unknown
		Type Detail: None
		Speed: Unknown
		Manufacturer: None
		Serial Number: None
		Asset Tag: None
		Part Number: None
Handle 0x002E
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0028
		Error Information Handle: Not Provided
		Total Width: 72 bits
		Data Width: 64 bits
		Size: 1024 MB
		Form Factor: DIMM
		Set: None
		Locator: A5
		Bank Locator: Bank10/11
		Type: Unknown
		Type Detail: None
		Speed: Unknown
		Manufacturer: None
		Serial Number: None
		Asset Tag: None
		Part Number: None
Handle 0x002F
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0017FFFFFFF
		Range Size: 6 GB
		Physical Array Handle: 0x0028
		Partition Width: 0
Handle 0x0030
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0003FFFFFFF
		Range Size: 1 GB
		Physical Device Handle: 0x0029
		Memory Array Mapped Address Handle: 0x002F
		Partition Row Position: 1
Handle 0x0031
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00040000000
		Ending Address: 0x0007FFFFFFF
		Range Size: 1 GB
		Physical Device Handle: 0x002A
		Memory Array Mapped Address Handle: 0x002F
		Partition Row Position: 1
Handle 0x0032
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00080000000
		Ending Address: 0x000BFFFFFFF
		Range Size: 1 GB
		Physical Device Handle: 0x002B
		Memory Array Mapped Address Handle: 0x002F
		Partition Row Position: 1
Handle 0x0033
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x000C0000000
		Ending Address: 0x000FFFFFFFF
		Range Size: 1 GB
		Physical Device Handle: 0x002C
		Memory Array Mapped Address Handle: 0x002F
		Partition Row Position: 1
Handle 0x0034
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00100000000
		Ending Address: 0x0013FFFFFFF
		Range Size: 1 GB
		Physical Device Handle: 0x002D
		Memory Array Mapped Address Handle: 0x002F
		Partition Row Position: 1
Handle 0x0035
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00140000000
		Ending Address: 0x0017FFFFFFF
		Range Size: 1 GB
		Physical Device Handle: 0x002E
		Memory Array Mapped Address Handle: 0x002F
		Partition Row Position: 1
Handle 0x0036
	DMI type 32, 11 bytes.
	System Boot Information
		Status: No errors detected
Handle 0x0037
	DMI type 127, 4 bytes.
	End Of Table

--=-bj9gQsnHOjsaZ8C0vWNP
Content-Disposition: attachment; filename=lshw.log
Content-Type: text/x-log; name=lshw.log; charset=UTF-8
Content-Transfer-Encoding: 7bit

home-lap
    description: Portable Computer
    product: Latitude D800
    vendor: Dell Computer Corporation
    serial: 1PC2B41
    width: 32 bits
    capabilities: smbios-2.3 dmi-2.3
    configuration: boot=normal chassis=docking uuid=44454C4C-5000-1043-8032-B1C04F423431
  *-core
       description: Motherboard
       vendor: Dell Computer Corporation
       physical id: 0
       serial: .1PC2B41.              .
       slot: PCI1
     *-firmware
          description: BIOS
          vendor: Dell Computer Corporation
          physical id: 0
          version: A11 (09/03/2004)
          size: 64KB
          capacity: 448KB
          capabilities: isa pci pcmcia pnp apm upgrade shadowing cdboot bootselect int13floppy720 int5printscreen int9keyboard int14serial int17printer int10video acpi usb agp smartbattery biosbootspecification netboot
     *-cpu
          description: CPU
          product: Intel(R) Pentium(R) M processor 1600MHz
          vendor: Intel Corp.
          physical id: 400
          bus info: cpu@0
          version: 6.9.5
          slot: Microprocessor
          size: 600MHz
          capacity: 1700MHz
          width: 32 bits
          clock: 133MHz
          capabilities: fpu fpu_exception wp vme de pse tsc msr mce cx8 mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 tm pbe est tm2 cpufreq
        *-cache:0
             description: L1 cache
             physical id: 700
             size: 8KB
             capacity: 8KB
             capabilities: internal write-back data
        *-cache:1
             description: L2 cache
             physical id: 701
             size: 1MB
             capacity: 1MB
             clock: 66MHz (15ns)
             capabilities: pipeline-burst internal varies unified
     *-memory
          description: System Memory
          physical id: 1000
          slot: System board or motherboard
          size: 512MB
          capacity: 1GB
        *-bank:0
             description: DIMM DDR Synchronous 266 MHz (3.8 ns)
             physical id: 0
             slot: DIMM_A
             size: 256MB
             width: 64 bits
             clock: 266MHz (3.7594ns)
        *-bank:1
             description: DIMM DDR Synchronous 266 MHz (3.8 ns)
             physical id: 1
             slot: DIMM_B
             size: 256MB
             width: 64 bits
             clock: 266MHz (3.7594ns)
     *-pci
          description: Host bridge
          product: 82855PM Processor to I/O Controller
          vendor: Intel Corporation
          physical id: e8000000
          bus info: pci@00:00.0
          version: 03
          width: 32 bits
          clock: 33MHz
          resources: iomemory:e8000000-efffffff
        *-pci:0
             description: PCI bridge
             product: 82855PM Processor to AGP Controller
             vendor: Intel Corporation
             physical id: 1
             bus info: pci@00:01.0
             version: 03
             width: 32 bits
             clock: 66MHz
             capabilities: pci normal_decode bus_master
           *-display
                description: VGA compatible controller
                product: NV28 [GeForce4 Ti 4200 Go AGP 8x]
                vendor: nVidia Corporation
                physical id: 0
                bus info: pci@01:00.0
                version: a1
                size: 64MB
                width: 32 bits
                clock: 66MHz
                capabilities: vga bus_master vga_palette cap_list
                configuration: driver=nvidia
                resources: iomemory:fc000000-fcffffff iomemory:f0000000-f3ffffff irq:11
        *-usb:0
             description: USB Controller
             product: 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
             vendor: Intel Corporation
             physical id: 1d
             bus info: pci@00:1d.0
             version: 01
             width: 32 bits
             clock: 33MHz
             capabilities: uhci bus_master
             configuration: driver=uhci_hcd
             resources: ioport:bf80-bf9f irq:11
           *-usbhost
                product: UHCI Host Controller
                vendor: Linux 2.6.11-1.1369_FC4 uhci_hcd
                physical id: 1
                bus info: usb@2
                logical name: usb2
                version: 2.06
                capabilities: usb-1.10
                configuration: driver=hub maxpower=0mA slots=2 speed=12.0MB/s
        *-usb:1
             description: USB Controller
             product: 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
             vendor: Intel Corporation
             physical id: 1d.1
             bus info: pci@00:1d.1
             version: 01
             width: 32 bits
             clock: 33MHz
             capabilities: uhci bus_master
             configuration: driver=uhci_hcd
             resources: ioport:bf40-bf5f irq:11
           *-usbhost
                product: UHCI Host Controller
                vendor: Linux 2.6.11-1.1369_FC4 uhci_hcd
                physical id: 1
                bus info: usb@3
                logical name: usb3
                version: 2.06
                capabilities: usb-1.10
                configuration: driver=hub maxpower=0mA slots=2 speed=12.0MB/s
        *-usb:2
             description: USB Controller
             product: 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
             vendor: Intel Corporation
             physical id: 1d.2
             bus info: pci@00:1d.2
             version: 01
             width: 32 bits
             clock: 33MHz
             capabilities: uhci bus_master
             configuration: driver=uhci_hcd
             resources: ioport:bf20-bf3f irq:11
           *-usbhost
                product: UHCI Host Controller
                vendor: Linux 2.6.11-1.1369_FC4 uhci_hcd
                physical id: 1
                bus info: usb@4
                logical name: usb4
                version: 2.06
                capabilities: usb-1.10
                configuration: driver=hub maxpower=0mA slots=2 speed=12.0MB/s
        *-usb:3
             description: USB Controller
             product: 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller
             vendor: Intel Corporation
             physical id: 1d.7
             bus info: pci@00:1d.7
             version: 01
             width: 32 bits
             clock: 33MHz
             capabilities: ehci bus_master cap_list
             configuration: driver=ehci_hcd
             resources: iomemory:f4fffc00-f4ffffff irq:11
           *-usbhost
                product: EHCI Host Controller
                vendor: Linux 2.6.11-1.1369_FC4 ehci_hcd
                physical id: 1
                bus info: usb@1
                logical name: usb1
                version: 2.06
                capabilities: usb-2.00
                configuration: driver=hub maxpower=0mA slots=6 speed=480.0MB/s
              *-usb
                   description: USB hub
                   vendor: Dell Computer Corp.
                   physical id: 6
                   bus info: usb@1:6
                   version: 10.00
                   capabilities: usb-2.00
                   configuration: driver=hub maxpower=100mA slots=4 speed=480.0MB/s
        *-pci:1
             description: PCI bridge
             product: 82801 Mobile PCI Bridge
             vendor: Intel Corporation
             physical id: 1e
             bus info: pci@00:1e.0
             version: 81
             width: 32 bits
             clock: 33MHz
             capabilities: pci normal_decode bus_master
           *-network
                description: Ethernet interface
                product: NetXtreme BCM5705M Gigabit Ethernet
                vendor: Broadcom Corporation
                physical id: 0
                bus info: pci@02:00.0
                logical name: eth0
                version: 01
                serial: 00:0f:1f:0d:95:44
                size: 100MB/s
                capacity: 1GB/s
                width: 64 bits
                clock: 66MHz
                capabilities: bus_master cap_list ethernet physical mii 10bt 10bt-fd 100bt 100bt-fd 1000bt 1000bt-fd autonegociation
                configuration: autonegociation=on broadcast=yes driver=tg3 driverversion=3.29 duplex=full ip=192.168.0.101 link=yes multicast=yes port=twisted pair speed=100MB/s
                resources: iomemory:faff0000-faffffff irq:11
           *-pcmcia:0
                description: CardBus bridge
                product: PCI7510 PC card Cardbus Controller
                vendor: Texas Instruments
                physical id: 1
                bus info: pci@02:01.0
                version: 01
                width: 32 bits
                clock: 33MHz
                capabilities: pcmcia bus_master cap_list
                configuration: driver=yenta_cardbus
                resources: iomemory:20001000-20001fff irq:11
           *-pcmcia:1
                description: CardBus bridge
                product: PCI7510,7610 PC card Cardbus Controller
                vendor: Texas Instruments
                physical id: 1.1
                bus info: pci@02:01.1
                version: 01
                width: 32 bits
                clock: 33MHz
                capabilities: pcmcia bus_master cap_list
                configuration: driver=yenta_cardbus
                resources: iomemory:20002000-20002fff irq:11
           *-firewire
                description: FireWire (IEEE 1394)
                product: PCI7410,7510,7610 OHCI-Lynx Controller
                vendor: Texas Instruments
                physical id: 1.2
                bus info: pci@02:01.2
                version: 00
                width: 32 bits
                clock: 33MHz
                capabilities: ohci bus_master cap_list
                configuration: driver=ohci1394
                resources: iomemory:fafef800-fafeffff iomemory:fafe8000-fafebfff irq:11
           *-system UNCLAIMED
                description: System peripheral
                product: PCI7410,7510,7610 PCI Firmware Loading Function
                vendor: Texas Instruments
                physical id: 1.3
                bus info: pci@02:01.3
                version: 00
                width: 32 bits
                clock: 33MHz
                capabilities: cap_list
                resources: ioport:ecf8-ecff
        *-isa UNCLAIMED
             description: ISA bridge
             product: 82801DBM (ICH4-M) LPC Interface Bridge
             vendor: Intel Corporation
             physical id: 1f
             bus info: pci@00:1f.0
             version: 01
             width: 32 bits
             clock: 33MHz
             capabilities: isa bus_master
        *-ide
             description: IDE interface
             product: 82801DBM (ICH4-M) IDE Controller
             vendor: Intel Corporation
             physical id: 1f.1
             bus info: pci@00:1f.1
             version: 01
             width: 32 bits
             clock: 33MHz
             capabilities: ide bus_master
             configuration: driver=PIIX_IDE
             resources: ioport:bfa0-bfaf iomemory:20000000-200003ff irq:11
           *-ide:0
                description: IDE Channel
                physical id: 0
                bus info: ide@0
                logical name: ide0
                clock: 33MHz
              *-disk
                   description: ATA Disk
                   product: HTS548060M9AT00
                   vendor: Hitachi
                   physical id: 0
                   bus info: ide@0.0
                   logical name: /dev/hda
                   version: MGBOA53A
                   serial: MRLB24L4GEXA0B
                   size: 55GB
                   capacity: 55GB
                   capabilities: ata dma lba iordy smart security pm apm
                   configuration: apm=off mode=udma5 smart=on
           *-ide:1
                description: IDE Channel
                physical id: 1
                bus info: ide@1
                logical name: ide1
                clock: 33MHz
              *-cdrom
                   description: DVD reader
                   product: SAMSUNG CDRW/DVD SN-324F
                   physical id: 0
                   bus info: ide@1.0
                   logical name: /dev/hdc
                   version: U203
                   capabilities: packet atapi cdrom removable nonmagnetic dma lba iordy audio cd-r cd-rw dvd
                   configuration: mode=udma2
        *-multimedia
             description: Multimedia audio controller
             product: 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller
             vendor: Intel Corporation
             physical id: 1f.5
             bus info: pci@00:1f.5
             version: 01
             width: 32 bits
             clock: 33MHz
             capabilities: bus_master cap_list
             configuration: driver=Intel ICH
             resources: ioport:b800-b8ff ioport:bc40-bc7f iomemory:f4fff800-f4fff9ff iomemory:f4fff400-f4fff4ff irq:5
  *-battery
       product: DELL 0002P69
       vendor: Sanyo
       physical id: 1
       slot: Sys. Battery Bay
       capacity: 72000mWh
       configuration: voltage=11.1V

--=-bj9gQsnHOjsaZ8C0vWNP
Content-Disposition: attachment; filename=lsusb.out
Content-Type: text/plain; name=lsusb.out; charset=UTF-8
Content-Transfer-Encoding: 7bit


Bus 002 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.12-git10 ohci_hcd
  iProduct                2 OHCI Host Controller
  iSerial                 1 0000:00:02.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
Hub Descriptor:
  bLength              11
  bDescriptorType      41
  nNbrPorts            10
  wHubCharacteristic 0x0002
    No power switching (usb 1.0)
    Ganged overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00 0x20
  PortPwrCtrlMask    0x47  0x55 
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0100 power
   Port 3: 0000.0100 power
   Port 4: 0000.0100 power
   Port 5: 0000.0100 power
   Port 6: 0000.0100 power
   Port 7: 0000.0100 power
   Port 8: 0000.0100 power
   Port 9: 0000.0100 power
   Port 10: 0000.0100 power

Bus 001 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.12-git10 ehci_hcd
  iProduct                2 EHCI Host Controller
  iSerial                 1 0000:00:02.1
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval              12
Hub Descriptor:
  bLength              11
  bDescriptorType      41
  nNbrPorts            10
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
    TT think time 8 FS bits
  bPwrOn2PwrGood       10 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00 0x80
  PortPwrCtrlMask    0x57  0x55 
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0100 power
   Port 3: 0000.0100 power
   Port 4: 0000.0100 power
   Port 5: 0000.0100 power
   Port 6: 0000.0100 power
   Port 7: 0000.0100 power
   Port 8: 0000.0100 power
   Port 9: 0000.0100 power
   Port 10: 0000.0100 power

--=-bj9gQsnHOjsaZ8C0vWNP--

