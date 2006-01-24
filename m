Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWAXVzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWAXVzA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 16:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWAXVzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 16:55:00 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:58412 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750760AbWAXVy6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 16:54:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bwPb+CgcwDIb09jRXHp408zMPSofQ/CPLeJfaPB+kLpN/4UP98gSG0gHBDc8FNRiSv7aVnv7rTfiQO5LXOqpiuibHhmtFBGd5PE07X1+UywpB77eeCqUQ3VThY6L1F8lOGgXyIc+QRv0eNgTVHyilBON0syCqb2Y6JP+TxnOdHQ=
Message-ID: <d4b6d3ea0601241354k75dbc1cdr83b69efd30a40259@mail.gmail.com>
Date: Tue, 24 Jan 2006 13:54:57 -0800
From: Michael Madore <michael.madore@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: nForce Pro 2200 losing ticks
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am receiving the following error message on an nForce Pro 2200 based system:

Losing some ticks... checking if CPU frequency changed.

Booting the system with report_lost_ticks gives a continuous stream of:

time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip default_idle+0x2a/0x52)
time.c: Lost 1 timer tick(s)! rip default_idle+0x2a/0x52)
time.c: Lost 1 timer tick(s)! rip default_idle+0x2a/0x52)
time.c: Lost 1 timer tick(s)! rip default_idle+0x2a/0x52)
time.c: Lost 1 timer tick(s)! rip default_idle+0x2a/0x52)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x39/0x9b)
time.c: Lost 1 timer tick(s)! rip default_idle+0x2a/0x52)

The kernel was originally 2.6.9-22.ELsmp.  However 2.6.16-rc1 gives
the same results.

I have tried both the onboard sata_nv and an addon sata_sil
controller.  Disabling the onboard ethernet does not help either.

Since this is an Opteron platform I initially thought it might be
related to the unsynced TSC issue.  However booting with idle=poll
does not help.  As a matter of fact booting with a uniprocessor kernel
doesn't help either.  I have attached my boot log and kernel config in
case it is helpful.  Let me know if I can provide any more information
or testing.

Thanks

Mike

# cat /proc/cpuinfo

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 33
model name	: Dual Core AMD Opteron(tm) Processor 280
stepping	: 2
cpu MHz		: 2400.016
cache size	: 1024 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm
3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips	: 4805.32
TLB size	: 1024 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 33
model name	: Dual Core AMD Opteron(tm) Processor 280
stepping	: 2
cpu MHz		: 2400.016
cache size	: 1024 KB
physical id	: 0
siblings	: 2
core id		: 1
cpu cores	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm
3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips	: 4800.35
TLB size	: 1024 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor	: 2
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 33
model name	: Dual Core AMD Opteron(tm) Processor 280
stepping	: 2
cpu MHz		: 2400.016
cache size	: 1024 KB
physical id	: 1
siblings	: 2
core id		: 0
cpu cores	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm
3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips	: 4800.35
TLB size	: 1024 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor	: 3
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 33
model name	: Dual Core AMD Opteron(tm) Processor 280
stepping	: 2
cpu MHz		: 2400.016
cache size	: 1024 KB
physical id	: 1
siblings	: 2
core id		: 1
cpu cores	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm
3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips	: 4800.47
TLB size	: 1024 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

# lspci
00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3)
00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97
Audio Controller (rev a2)
00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3)
00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3)
00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
00:19.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
00:19.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
00:19.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
00:19.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
01:00.0 VGA compatible controller: nVidia Corporation: Unknown device
0092 (rev a1)
03:02.0 Mass storage controller: Silicon Image, Inc. SiI 3112
[SATALink/SATARaid] Serial ATA Controller (rev 01)
80:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
80:01.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
80:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3)
80:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3)
80:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
80:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
80:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)

# lsmod
Module                  Size  Used by
ipv6                  263552  12
sunrpc                158280  1
ext3                  129936  2
jbd                    60072  1 ext3
sata_sil               10884  3
libata                 60568  1 sata_sil
sd_mod                 17920  4
scsi_mod              146800  2 libata,sd_mod

# dmesg
Bootdata ok (command line is ro root=LABEL=/ report_lost_ticks numa=on)
Linux version 2.6.16-rc1 (root@test) (gcc version 3.4.4 20050721 (Red
Hat 3.4.4-2)) #1 SMP Tue Jan 24 06:52:29 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000b9fd0000 (usable)
  BIOS-e820: 00000000b9fd0000 - 00000000b9fde000 (ACPI data)
  BIOS-e820: 00000000b9fde000 - 00000000ba000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000200000000 (usable)
ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000f8830
ACPI: XSDT (v001 A M I  OEMXSDT  0x12000521 MSFT 0x00000097) @
0x00000000b9fd0100
ACPI: FADT (v003 A M I  OEMFACP  0x12000521 MSFT 0x00000097) @
0x00000000b9fd0290
ACPI: MADT (v001 A M I  OEMAPIC  0x12000521 MSFT 0x00000097) @
0x00000000b9fd0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x12000521 MSFT 0x00000097) @
0x00000000b9fde040
ACPI: SRAT (v001 A M I  OEMSRAT  0x12000521 MSFT 0x00000097) @
0x00000000b9fd5be0
ACPI: DSDT (v001  1ACAI 1ACAI003 0x00000003 INTL 0x02002026) @
0x0000000000000000
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 0 -> APIC 1 -> Node 0
SRAT: PXM 1 -> APIC 2 -> Node 1
SRAT: PXM 1 -> APIC 3 -> Node 1
SRAT: Node 0 PXM 0 100000-ba000000
SRAT: Node 1 PXM 1 100000000-200000000
SRAT: Node 0 PXM 0 100000-100000000
SRAT: Node 0 PXM 0 0-100000000
NUMA: Using 32 for the hash shift.
Bootmem setup node 0 0000000000000000-0000000100000000
Bootmem setup node 1 0000000100000000-0000000200000000
On node 0 totalpages: 744318
  DMA zone: 2926 pages, LIFO batch:0
  DMA32 zone: 741392 pages, LIFO batch:31
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
On node 1 totalpages: 1032192
  DMA zone: 0 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 1032192 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
Processor #2 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
Processor #3 15:1 APIC version 16
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x05] address[0xdfefc000] gsi_base[24])
IOAPIC[1]: apic_id 5, version 17, address 0xdfefc000, GSI 24-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at c0000000 (gap: ba000000:44c00000)
Checking aperture...
CPU 0: aperture @ 8000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000
Built 2 zonelists
Kernel command line: ro root=LABEL=/ report_lost_ticks numa=on
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2400.016 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
PCI-DMA: Disabling IOMMU.
WARNING more than 4GB of memory but IOMMU not compiled in.
WARNING 32bit PCI may malfunction.
You might want to enable CONFIG_GART_IOMMU
Memory: 7026668k/8388608k available (2192k kernel code, 214480k
reserved, 928k data, 240k init)
Calibrating delay using timer specific routine.. 4805.32 BogoMIPS (lpj=9610656)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
Using local APIC timer interrupts.
Detected 12.500 MHz APIC timer.
time.c: Lost 10 timer tick(s)! rip setup_boot_APIC_clock+0xdb/0xde)
Booting processor 1/4 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4800.35 BogoMIPS (lpj=9600702)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
Dual Core AMD Opteron(tm) Processor 280 stepping 02
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 621 cycles)
Booting processor 2/4 APIC 0x2
Initializing CPU#2
Calibrating delay using timer specific routine.. 4800.35 BogoMIPS (lpj=9600708)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2(2) -> Node 1 -> Core 0
Dual Core AMD Opteron(tm) Processor 280 stepping 02
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff 1 cycles, maxerr 1155 cycles)
Booting processor 3/4 APIC 0x3
Initializing CPU#3
Calibrating delay using timer specific routine.. 4800.47 BogoMIPS (lpj=9600941)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3(2) -> Node 1 -> Core 1
Dual Core AMD Opteron(tm) Processor 280 stepping 02
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff 4 cycles, maxerr 1155 cycles)
Brought up 4 CPUs
Disabling vsyscall due to use of PM timer
time.c: Using PM based timekeeping.
testing NMI watchdog ... <4>time.c: Lost 80 timer tick(s)! rip
nmi_cpu_busy+0x5/0xa)
OK.
migration_cost=263,346
checking if image is initramfs... it is
Freeing initrd memory: 919k freed
DMI 2.3 present.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:09.0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Root Bridge [PCIB] (0000:80)
PCI: Probing PCI hardware (bus 80)
ACPI: PCI Interrupt Routing Table [\_SB_.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19) *9
ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19) *9
ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19) *10
ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 19) *9
ACPI: PCI Interrupt Link [LNKE] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22) *9
ACPI: PCI Interrupt Link [LUS1] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22) *9
ACPI: PCI Interrupt Link [LKLN] (IRQs 20 21 22) *11
ACPI: PCI Interrupt Link [LAUI] (IRQs 20 21 22) *9
ACPI: PCI Interrupt Link [LKMO] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LKSM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22) *9
ACPI: PCI Interrupt Link [LTIE] (IRQs 20 21 22) *5
ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22) *14
ACPI: PCI Interrupt Link [LN2A] (IRQs 40 41 42 43) *0, disabled.
ACPI: PCI Interrupt Link [LN2B] (IRQs 40 41 42 43) *0, disabled.
ACPI: PCI Interrupt Link [LN2C] (IRQs 40 41 42 43) *0, disabled.
ACPI: PCI Interrupt Link [LN2D] (IRQs 40 41 42 43) *0, disabled.
ACPI: PCI Interrupt Link [LK2N] (IRQs 44 45 46 47) *0, disabled.
ACPI: PCI Interrupt Link [LT3D] (IRQs 44 45 46 47) *0, disabled.
ACPI: PCI Interrupt Link [LT2E] (IRQs 44 45 46 47) *0, disabled.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 8000000 size 65536 KB
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
PCI-DMA: using GART IOMMU.
PCI: Bridge: 0000:00:09.0
  IO window: 7000-8fff
  MEM window: bfa00000-bfbfffff
  PREFETCH window: dfd00000-dfdfffff
PCI: Bridge: 0000:00:0d.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0e.0
  IO window: 6000-6fff
  MEM window: bb900000-bf9fffff
  PREFETCH window: bfd00000-dfcfffff
PCI: Setting latency timer of device 0000:00:09.0 to 64
PCI: Setting latency timer of device 0000:00:0d.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
PCI: Bridge: 0000:80:0d.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:80:0e.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:80:0d.0 to 64
PCI: Setting latency timer of device 0000:80:0e.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1138105715.704:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.1 20051102
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
NFORCE-CK804: chipset revision 242
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
    ide0: BM-DMA at 0x3000-0x3007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x3008-0x300f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: SONY DVD RW DW-Q30A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide0...
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbmon: debugfs is not available
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 4 AMD Athlon 64 / Opteron processors (version 1.60.0)
powernow-k8: MP systems not supported by PSB BIOS structure
powernow-k8: MP systems not supported by PSB BIOS structure
powernow-k8: MP systems not supported by PSB BIOS structure
powernow-k8: MP systems not supported by PSB BIOS structure
Freeing unused kernel memory: 240k freed
SCSI subsystem initialized
libata version 1.20 loaded.
sata_sil 0000:03:02.0: version 0.9
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 19
GSI 16 sharing vector 0xB1 and IRQ 16
ACPI: PCI Interrupt 0000:03:02.0[A] -> Link [LNKD] -> GSI 19 (level,
low) -> IRQ 177
ata1: SATA max UDMA/100 cmd 0xFFFFC20000004C80 ctl 0xFFFFC20000004C8A
bmdma 0xFFFFC20000004C00 irq 177
ata2: SATA max UDMA/100 cmd 0xFFFFC20000004CC0 ctl 0xFFFFC20000004CCA
bmdma 0xFFFFC20000004C08 irq 177
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata1: dev 0 ATA-7, max UDMA/133, 586072368 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: SATA link down (SStatus 0)
scsi1 : sata_sil
  Vendor: ATA       Model: ST3300831AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
input: PS/2 Generic Mouse as /class/input/input1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
sata_nv 0000:00:07.0: version 0.8
ACPI: PCI Interrupt Link [LTID] enabled at IRQ 22
GSI 17 sharing vector 0xB9 and IRQ 17
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LTID] -> GSI 22 (level,
low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata3: SATA max UDMA/133 cmd 0xC800 ctl 0xC402 bmdma 0xB800 irq 185
ata4: SATA max UDMA/133 cmd 0xC000 ctl 0xBC02 bmdma 0xB808 irq 185
ata3: SATA link down (SStatus 0)
scsi2 : sata_nv
ata4: SATA link down (SStatus 0)
scsi3 : sata_nv
ACPI: PCI Interrupt Link [LTIE] enabled at IRQ 21
GSI 18 sharing vector 0xC1 and IRQ 18
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LTIE] -> GSI 21 (level,
low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata5: SATA max UDMA/133 cmd 0xB400 ctl 0xB002 bmdma 0xA400 irq 193
ata6: SATA max UDMA/133 cmd 0xAC00 ctl 0xA802 bmdma 0xA408 irq 193
ata5: SATA link down (SStatus 0)
scsi4 : sata_nv
ata6: SATA link down (SStatus 0)
scsi5 : sata_nv
ACPI: PCI Interrupt Link [LT3D] enabled at IRQ 47
GSI 19 sharing vector 0xC9 and IRQ 19
ACPI: PCI Interrupt 0000:80:07.0[A] -> Link [LT3D] -> GSI 47 (level,
low) -> IRQ 201
PCI: Setting latency timer of device 0000:80:07.0 to 64
ata7: SATA max UDMA/133 cmd 0xF800 ctl 0xF402 bmdma 0xE800 irq 201
ata8: SATA max UDMA/133 cmd 0xF000 ctl 0xEC02 bmdma 0xE808 irq 201
ata7: SATA link down (SStatus 0)
scsi6 : sata_nv
ata8: SATA link down (SStatus 0)
scsi7 : sata_nv
ACPI: PCI Interrupt Link [LT2E] enabled at IRQ 46
GSI 20 sharing vector 0xD1 and IRQ 20
ACPI: PCI Interrupt 0000:80:08.0[A] -> Link [LT2E] -> GSI 46 (level,
low) -> IRQ 209
PCI: Setting latency timer of device 0000:80:08.0 to 64
ata9: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xD400 irq 209
ata10: SATA max UDMA/133 cmd 0xDC00 ctl 0xD802 bmdma 0xD408 irq 209
ata9: SATA link down (SStatus 0)
scsi8 : sata_nv
ata10: SATA link down (SStatus 0)
scsi9 : sata_nv
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.49.
ACPI: PCI Interrupt Link [LKLN] enabled at IRQ 20
GSI 21 sharing vector 0xD9 and IRQ 21
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LKLN] -> GSI 20 (level,
low) -> IRQ 217
PCI: Setting latency timer of device 0000:00:0a.0 to 64
eth0: forcedeth.c: subsystem: 015d9:1011 bound to 0000:00:0a.0
ACPI: PCI Interrupt Link [LK2N] enabled at IRQ 45
GSI 22 sharing vector 0xE1 and IRQ 22
ACPI: PCI Interrupt 0000:80:0a.0[A] -> Link [LK2N] -> GSI 45 (level,
low) -> IRQ 225
PCI: Setting latency timer of device 0000:80:0a.0 to 64
eth1: forcedeth.c: subsystem: 015d9:1011 bound to 0000:80:0a.0
ACPI: PCI Interrupt Link [LAUI] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LAUI] -> GSI 22 (level,
low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:04.0 to 64
intel8x0_measure_ac97_clock: measured 56859 usecs
intel8x0: clocking to 46921
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUS2] -> GSI 21 (level,
low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: irq 193, io mem 0xbfce0000
ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LUS0] -> GSI 20 (level,
low) -> IRQ 217
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 217, io mem 0xbfcfb000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
EXT3 FS on sda3, internal journal
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
device-mapper: dm-multipath version 1.0.4 loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2040244k swap on /dev/sda2.  Priority:-1 extents:1 across:2040244k
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
lp0: console ready
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
hald[3508]: segfault at 0000000000000000 rip 000000353146fd20 rsp
00007ffffff4d258 error 4
eth0: no IPv6 routers present
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
Losing some ticks... checking if CPU frequency changed.
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x45/0xca)

.config
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.16-rc1
# Tue Jan 24 06:48:28 2006
#
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
# CONFIG_IKCONFIG is not set
# CONFIG_CPUSETS is not set
CONFIG_INITRAMFS_SOURCE=""
CONFIG_UID16=y
CONFIG_VM86=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_EXTRA_PASS=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_SLAB=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set
CONFIG_OBSOLETE_INTERMODULE=m

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Block layer
#
CONFIG_LBD=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VSMP is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_L1_CACHE_BYTES=128
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_HT=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_SCHED_SMT=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_BKL=y
CONFIG_NUMA=y
CONFIG_K8_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
# CONFIG_NUMA_EMU is not set
CONFIG_ARCH_DISCONTIGMEM_ENABLE=y
CONFIG_ARCH_DISCONTIGMEM_DEFAULT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_DISCONTIGMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_DISCONTIGMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_NEED_MULTIPLE_NODES=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MIGRATION=y
CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
CONFIG_NR_CPUS=8
# CONFIG_HOTPLUG_CPU is not set
CONFIG_HPET_TIMER=y
CONFIG_X86_PM_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_GART_IOMMU=y
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x100000
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_ISA_DMA_API=y
CONFIG_GENERIC_PENDING_IRQ=y

#
# Power management options
#
CONFIG_PM=y
CONFIG_PM_LEGACY=y
# CONFIG_PM_DEBUG is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=y
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_ASUS=m
# CONFIG_ACPI_IBM is not set
CONFIG_ACPI_TOSHIBA=m
CONFIG_ACPI_BLACKLIST_YEAR=2001
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_CONTAINER is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set

#
# CPUFreq processor drivers
#
CONFIG_X86_POWERNOW_K8=y
CONFIG_X86_POWERNOW_K8_ACPI=y
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
CONFIG_X86_ACPI_CPUFREQ=y

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_SPEEDSTEP_LIB is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_UNORDERED_IO is not set
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_LEGACY_PROC=y
# CONFIG_PCI_DEBUG is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_FAKE is not set
CONFIG_HOTPLUG_PCI_ACPI=m
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=m
# CONFIG_HOTPLUG_PCI_SHPC_POLL_EVENT_MODE is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_ASK_IP_FIB_HASH=y
# CONFIG_IP_FIB_TRIE is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_MULTIPATH=y
# CONFIG_IP_ROUTE_MULTIPATH_CACHED is not set
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y

#
# IP: Virtual Server Configuration
#
CONFIG_IP_VS=m
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_TUNNEL=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_BRIDGE_NETFILTER=y

#
# Core Netfilter Configuration
#
# CONFIG_NETFILTER_NETLINK is not set
# CONFIG_NETFILTER_XTABLES is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_CT_ACCT=y
# CONFIG_IP_NF_CONNTRACK_MARK is not set
# CONFIG_IP_NF_CONNTRACK_EVENTS is not set
CONFIG_IP_NF_CT_PROTO_SCTP=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
# CONFIG_IP_NF_NETBIOS_NS is not set
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
# CONFIG_IP_NF_PPTP is not set
CONFIG_IP_NF_QUEUE=m

#
# IPv6: Netfilter Configuration (EXPERIMENTAL)
#
# CONFIG_IP6_NF_QUEUE is not set

#
# Bridge: Netfilter Configuration
#
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
# CONFIG_BRIDGE_EBT_ULOG is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=y
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_BRIDGE=m
CONFIG_VLAN_8021Q=m
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set

#
# TIPC Configuration (EXPERIMENTAL)
#
# CONFIG_TIPC is not set
CONFIG_NET_DIVERT=y
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CLK_JIFFIES=y
# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
# CONFIG_NET_SCH_CLK_CPU is not set

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_INGRESS=m

#
# Classification
#
CONFIG_NET_CLS=y
# CONFIG_NET_CLS_BASIC is not set
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
# CONFIG_CLS_U32_MARK is not set
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
# CONFIG_NET_EMATCH is not set
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_CLS_POLICE=y
CONFIG_NET_CLS_IND=y
CONFIG_NET_ESTIMATOR=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIBCM203X=m
# CONFIG_BT_HCIBPA10X is not set
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_IEEE80211=m
# CONFIG_IEEE80211_DEBUG is not set
# CONFIG_IEEE80211_CRYPT_WEP is not set
# CONFIG_IEEE80211_CRYPT_CCMP is not set
CONFIG_IEEE80211_CRYPT_TKIP=m

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=m
# CONFIG_MTD_DEBUG is not set
CONFIG_MTD_CONCAT=m
CONFIG_MTD_PARTITIONS=y
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
CONFIG_MTD_CMDLINE_PARTS=y

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=m
CONFIG_MTD_BLOCK=m
CONFIG_MTD_BLOCK_RO=m
CONFIG_FTL=m
CONFIG_NFTL=m
CONFIG_NFTL_RW=y
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_CFI_AMDSTD_RETRY=3
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m
# CONFIG_MTD_OBSOLETE_CHIPS is not set

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_PNC2000 is not set
CONFIG_MTD_SC520CDP=m
CONFIG_MTD_NETSC520=m
# CONFIG_MTD_TS5500 is not set
# CONFIG_MTD_SBC_GXX is not set
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=m
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
# CONFIG_MTD_DILNETPC is not set
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
# CONFIG_MTD_BLKMTD is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOC2000 is not set
# CONFIG_MTD_DOC2001 is not set
# CONFIG_MTD_DOC2001PLUS is not set

#
# NAND Flash Device Drivers
#
CONFIG_MTD_NAND=m
# CONFIG_MTD_NAND_VERIFY_WRITE is not set
CONFIG_MTD_NAND_IDS=m
# CONFIG_MTD_NAND_DISKONCHIP is not set
# CONFIG_MTD_NAND_NANDSIM is not set

#
# OneNAND Flash Device Drivers
#
# CONFIG_MTD_ONENAND is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_NOT_PC=y
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_PARIDE is not set
CONFIG_BLK_CPQ_DA=m
CONFIG_BLK_CPQ_CISS_DA=m
CONFIG_CISS_SCSI_TAPE=y
CONFIG_BLK_DEV_DAC960=m
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_SX8=m
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_BLK_DEV_INITRD=y
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_ATIIXP=y
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_TRIFLEX=y
CONFIG_BLK_DEV_CY82C693=y
CONFIG_BLK_DEV_CS5520=y
CONFIG_BLK_DEV_CS5530=y
CONFIG_BLK_DEV_HPT34X=y
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=y
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=y
# CONFIG_PDC202XX_BURST is not set
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_PDC202XX_FORCE=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BLK_DEV_SIIMAGE=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
# CONFIG_SCSI_SAS_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
CONFIG_BLK_DEV_3W_XXXX_RAID=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=4
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
CONFIG_SCSI_AIC7XXX_OLD=m
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_ENABLE_RD_STRM is not set
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_SATA=m
CONFIG_SCSI_SATA_AHCI=m
CONFIG_SCSI_SATA_SVW=m
CONFIG_SCSI_ATA_PIIX=m
# CONFIG_SCSI_SATA_MV is not set
CONFIG_SCSI_SATA_NV=m
# CONFIG_SCSI_PDC_ADMA is not set
# CONFIG_SCSI_SATA_QSTOR is not set
CONFIG_SCSI_SATA_PROMISE=m
CONFIG_SCSI_SATA_SX4=m
CONFIG_SCSI_SATA_SIL=m
# CONFIG_SCSI_SATA_SIL24 is not set
CONFIG_SCSI_SATA_SIS=m
# CONFIG_SCSI_SATA_ULI is not set
CONFIG_SCSI_SATA_VIA=m
CONFIG_SCSI_SATA_VITESSE=m
CONFIG_SCSI_SATA_INTEL_COMBINED=y
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
CONFIG_SCSI_GDTH=m
CONFIG_SCSI_IPS=m
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_FC is not set
CONFIG_SCSI_QLOGIC_1280=m
# CONFIG_SCSI_QLA_FC is not set
CONFIG_SCSI_LPFC=m
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID5=m
CONFIG_MD_RAID6=m
CONFIG_MD_MULTIPATH=m
# CONFIG_MD_FAULTY is not set
CONFIG_BLK_DEV_DM=m
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_MIRROR=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_EMC=m

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_LCT_NOTIFY_ON_CHANGES=y
CONFIG_I2O_EXT_ADAPTEC=y
CONFIG_I2O_EXT_ADAPTEC_DMA64=y
CONFIG_I2O_CONFIG=m
CONFIG_I2O_CONFIG_OLD_IOCTL=y
# CONFIG_I2O_BUS is not set
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
# CONFIG_PHYLIB is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
CONFIG_HAPPYMEAL=m
CONFIG_SUNGEM=m
# CONFIG_CASSINI is not set
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_TYPHOON=m

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
# CONFIG_ULI526X is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
CONFIG_AMD8111_ETH=m
CONFIG_AMD8111E_NAPI=y
CONFIG_ADAPTEC_STARFIRE=m
CONFIG_ADAPTEC_STARFIRE_NAPI=y
CONFIG_B44=m
CONFIG_FORCEDETH=m
# CONFIG_DGRS is not set
CONFIG_EEPRO100=m
CONFIG_E100=m
CONFIG_FEALNX=m
CONFIG_NATSEMI=m
CONFIG_NE2K_PCI=m
CONFIG_8139CP=m
CONFIG_8139TOO=m
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_SIS900=m
CONFIG_EPIC100=m
# CONFIG_SUNDANCE is not set
CONFIG_VIA_RHINE=m
CONFIG_VIA_RHINE_MMIO=y
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
CONFIG_ACENIC=m
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_DL2K=m
CONFIG_E1000=m
CONFIG_E1000_NAPI=y
CONFIG_NS83820=m
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_R8169=m
CONFIG_R8169_NAPI=y
# CONFIG_R8169_VLAN is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_SK98LIN=m
CONFIG_VIA_VELOCITY=m
CONFIG_TIGON3=m
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
CONFIG_IXGB=m
CONFIG_IXGB_NAPI=y
CONFIG_S2IO=m
CONFIG_S2IO_NAPI=y

#
# Token Ring devices
#
CONFIG_TR=y
CONFIG_IBMOL=m
CONFIG_3C359=m
CONFIG_TMS380TR=m
CONFIG_TMSPCI=m
CONFIG_ABYSS=m

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set

#
# Wireless 802.11b ISA/PCI cards support
#
CONFIG_IPW2100=m
# CONFIG_IPW2100_MONITOR is not set
# CONFIG_IPW2100_DEBUG is not set
CONFIG_IPW2200=m
# CONFIG_IPW2200_DEBUG is not set
# CONFIG_AIRO is not set
CONFIG_HERMES=m
CONFIG_PLX_HERMES=m
CONFIG_TMD_HERMES=m
# CONFIG_NORTEL_HERMES is not set
CONFIG_PCI_HERMES=m
CONFIG_ATMEL=m
CONFIG_PCI_ATMEL=m

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
CONFIG_PRISM54=m
# CONFIG_HOSTAP is not set
CONFIG_NET_WIRELESS=y

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# ATM drivers
#
# CONFIG_ATM_DUMMY is not set
CONFIG_ATM_TCP=m
CONFIG_ATM_LANAI=m
CONFIG_ATM_ENI=m
# CONFIG_ATM_ENI_DEBUG is not set
# CONFIG_ATM_ENI_TUNE_BURST is not set
CONFIG_ATM_FIRESTREAM=m
# CONFIG_ATM_ZATM is not set
CONFIG_ATM_IDT77252=m
# CONFIG_ATM_IDT77252_DEBUG is not set
# CONFIG_ATM_IDT77252_RCV_ALL is not set
CONFIG_ATM_IDT77252_USE_SUNI=y
CONFIG_ATM_AMBASSADOR=m
# CONFIG_ATM_AMBASSADOR_DEBUG is not set
CONFIG_ATM_HORIZON=m
# CONFIG_ATM_HORIZON_DEBUG is not set
CONFIG_ATM_FORE200E_MAYBE=m
# CONFIG_ATM_FORE200E_PCA is not set
CONFIG_ATM_HE=m
# CONFIG_ATM_HE_USE_SUNI is not set
CONFIG_FDDI=y
# CONFIG_DEFXX is not set
# CONFIG_SKFP is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
# CONFIG_PPP_BSDCOMP is not set
# CONFIG_PPP_MPPE is not set
CONFIG_PPPOE=m
CONFIG_PPPOATM=m
# CONFIG_SLIP is not set
CONFIG_NET_FC=y
# CONFIG_SHAPER is not set
CONFIG_NETCONSOLE=m
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_RX is not set
CONFIG_NETPOLL_TRAP=y
CONFIG_NET_POLL_CONTROLLER=y

#
# ISDN subsystem
#
CONFIG_ISDN=m

#
# Old ISDN4Linux
#
CONFIG_ISDN_I4L=m
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_IPPP_FILTER=y
# CONFIG_ISDN_PPP_BSDCOMP is not set
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y

#
# ISDN feature submodules
#
# CONFIG_ISDN_DIVERSION is not set

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
CONFIG_ISDN_DRV_HISAX=m

#
# D-channel protocol features
#
CONFIG_HISAX_EURO=y
CONFIG_DE_AOC=y
CONFIG_HISAX_NO_SENDCOMPLETE=y
CONFIG_HISAX_NO_LLC=y
CONFIG_HISAX_NO_KEYPAD=y
CONFIG_HISAX_1TR6=y
CONFIG_HISAX_NI1=y
CONFIG_HISAX_MAX_CARDS=8

#
# HiSax supported cards
#
CONFIG_HISAX_16_3=y
CONFIG_HISAX_TELESPCI=y
CONFIG_HISAX_S0BOX=y
CONFIG_HISAX_FRITZPCI=y
CONFIG_HISAX_AVM_A1_PCMCIA=y
CONFIG_HISAX_ELSA=y
CONFIG_HISAX_DIEHLDIVA=y
CONFIG_HISAX_SEDLBAUER=y
CONFIG_HISAX_NETJET=y
CONFIG_HISAX_NETJET_U=y
CONFIG_HISAX_NICCY=y
CONFIG_HISAX_BKM_A4T=y
CONFIG_HISAX_SCT_QUADRO=y
CONFIG_HISAX_GAZEL=y
CONFIG_HISAX_HFC_PCI=y
CONFIG_HISAX_W6692=y
CONFIG_HISAX_HFC_SX=y
CONFIG_HISAX_ENTERNOW_PCI=y
# CONFIG_HISAX_DEBUG is not set

#
# HiSax PCMCIA card service modules
#

#
# HiSax sub driver modules
#
CONFIG_HISAX_ST5481=m
CONFIG_HISAX_HFCUSB=m
# CONFIG_HISAX_HFC4S8S is not set
CONFIG_HISAX_FRITZ_PCIPNP=m
CONFIG_HISAX_HDLC=y

#
# Active cards
#

#
# CAPI subsystem
#
CONFIG_ISDN_CAPI=m
CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON=y
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_CAPIFS_BOOL=y
CONFIG_ISDN_CAPI_CAPIFS=m
CONFIG_ISDN_CAPI_CAPIDRV=m

#
# CAPI hardware drivers
#

#
# Active AVM cards
#
CONFIG_CAPI_AVM=y
# CONFIG_ISDN_DRV_AVMB1_B1PCI is not set
# CONFIG_ISDN_DRV_AVMB1_B1PCMCIA is not set
# CONFIG_ISDN_DRV_AVMB1_T1PCI is not set
# CONFIG_ISDN_DRV_AVMB1_C4 is not set

#
# Active Eicon DIVA Server cards
#
# CONFIG_CAPI_EICON is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_VSXXXAA=m
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
# CONFIG_JOYSTICK_JOYDUMP is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_GUNZE=m
# CONFIG_TOUCHSCREEN_ELO is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_UINPUT=m

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_COMPUTONE is not set
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_DIGIEPCA is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_ISI is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
CONFIG_N_HDLC=m
# CONFIG_SPECIALIX is not set
# CONFIG_SX is not set
CONFIG_STALDRV=y

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_RSA=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
# CONFIG_TIPAR is not set

#
# IPMI
#
CONFIG_IPMI_HANDLER=m
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=m
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
CONFIG_SC520_WDT=m
CONFIG_EUROTECH_WDT=m
CONFIG_IB700_WDT=m
# CONFIG_IBMASR is not set
CONFIG_WAFER_WDT=m
# CONFIG_I6300ESB_WDT is not set
CONFIG_I8XX_TCO=m
CONFIG_SC1200_WDT=m
# CONFIG_60XX_WDT is not set
# CONFIG_SBC8360_WDT is not set
CONFIG_CPU5_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
# CONFIG_W83977F_WDT is not set
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m
CONFIG_WDT_501_PCI=y

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_HW_RANDOM=m
# CONFIG_NVRAM is not set
CONFIG_RTC=y
CONFIG_DTLK=m
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
# CONFIG_AGP_INTEL is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_MGA=m
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=m

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
# CONFIG_I2C_AMD756_S4882 is not set
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=m
CONFIG_I2C_I810=m
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_ISA=m
CONFIG_I2C_NFORCE2=m
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
CONFIG_I2C_PROSAVAGE=m
CONFIG_I2C_SAVAGE4=m
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
# CONFIG_I2C_STUB is not set
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_VOODOO3=m
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_PCF8574=m
# CONFIG_SENSORS_PCA9539 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_SENSORS_RTC8564=m
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_RTC_X1205_I2C is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_FSCHER=m
# CONFIG_SENSORS_FSCPOS is not set
CONFIG_SENSORS_GL518SM=m
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=m
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_MAX1619=m
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_SMSC47M1=m
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_VIA686A=m
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83781D=m
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83627HF=m
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia Capabilities Port drivers
#

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#

#
# Video Adapters
#
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5246A is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_CX88 is not set
# CONFIG_VIDEO_EM28XX is not set
CONFIG_VIDEO_OVCAMCHIP=m
# CONFIG_VIDEO_AUDIO_DECODER is not set
# CONFIG_VIDEO_DECODER is not set

#
# Radio Adapters
#
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_MACMODES is not set
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
CONFIG_FB_CIRRUS=m
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=m
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
CONFIG_FB_RIVA=m
# CONFIG_FB_RIVA_I2C is not set
# CONFIG_FB_RIVA_DEBUG is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
CONFIG_FB_KYRO=m
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
CONFIG_SND_ALS4000=m
CONFIG_SND_ALI5451=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
CONFIG_SND_AZT3328=m
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
# CONFIG_SND_CA0106 is not set
CONFIG_SND_CMIPCI=m
CONFIG_SND_CS4281=m
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_EMU10K1=m
# CONFIG_SND_EMU10K1X is not set
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
CONFIG_SND_ES1938=m
CONFIG_SND_ES1968=m
CONFIG_SND_FM801=m
CONFIG_SND_FM801_TEA575X=m
# CONFIG_SND_HDA_INTEL is not set
CONFIG_SND_HDSP=m
# CONFIG_SND_HDSPM is not set
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MIXART=m
CONFIG_SND_NM256=m
# CONFIG_SND_PCXHR is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
CONFIG_SND_SONICVIBES=m
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
# CONFIG_SND_VIA82XX_MODEM is not set
CONFIG_SND_VX222=m
CONFIG_SND_YMFPCI=m

#
# USB devices
#
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_USX2Y=m

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_SUSPEND=y
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_OHCI_BIG_ENDIAN is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_OBSOLETE_OSS_USB_DRIVER is not set
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
# CONFIG_USB_STORAGE_USBAT is not set
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
CONFIG_HID_FF=y
CONFIG_HID_PID=y
CONFIG_LOGITECH_FF=y
CONFIG_THRUSTMASTER_FF=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m
# CONFIG_USB_ACECAD is not set
CONFIG_USB_KBTAB=m
CONFIG_USB_POWERMATE=m
CONFIG_USB_MTOUCH=m
# CONFIG_USB_ITMTOUCH is not set
CONFIG_USB_EGALAX=m
# CONFIG_USB_YEALINK is not set
CONFIG_USB_XPAD=m
CONFIG_USB_ATI_REMOTE=m
# CONFIG_USB_ATI_REMOTE2 is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m

#
# USB Multimedia devices
#
CONFIG_USB_DABUSB=m
CONFIG_USB_VICAM=m
CONFIG_USB_DSBR=m
CONFIG_USB_IBMCAM=m
CONFIG_USB_KONICAWC=m
CONFIG_USB_OV511=m
CONFIG_USB_SE401=m
CONFIG_USB_SN9C102=m
CONFIG_USB_STV680=m
CONFIG_USB_W9968CF=m
CONFIG_USB_PWC=m

#
# USB Network Adapters
#
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m
CONFIG_USB_NET_AX8817X=m
CONFIG_USB_NET_CDCETHER=m
# CONFIG_USB_NET_GL620A is not set
CONFIG_USB_NET_NET1080=m
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
CONFIG_USB_NET_ZAURUS=m
# CONFIG_USB_ZD1201 is not set
CONFIG_USB_MON=y

#
# USB port drivers
#
CONFIG_USB_USS720=m

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_AIRPRIME is not set
# CONFIG_USB_SERIAL_ANYDATA is not set
CONFIG_USB_SERIAL_BELKIN=m
# CONFIG_USB_SERIAL_WHITEHEAT is not set
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
# CONFIG_USB_SERIAL_CP2101 is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KEYSPAN_MPR=y
CONFIG_USB_SERIAL_KEYSPAN_USA28=y
CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
CONFIG_USB_SERIAL_KEYSPAN_USA19=y
CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_PL2303=m
# CONFIG_USB_SERIAL_HP4X is not set
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_EZUSB=y

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
# CONFIG_USB_EMI26 is not set
CONFIG_USB_AUERSWALD=m
CONFIG_USB_RIO500=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
CONFIG_USB_LED=m
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
CONFIG_USB_PHIDGETSERVO=m
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
CONFIG_USB_TEST=m

#
# USB DSL modem support
#
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
# CONFIG_USB_CXACRU is not set
# CONFIG_USB_UEAGLEATM is not set
# CONFIG_USB_XUSBATM is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# SN Devices
#

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y
CONFIG_RELAYFS_FS=y
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
# CONFIG_JFFS2_SUMMARY is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
# CONFIG_JFFS2_RUBIN is not set
CONFIG_CRAMFS=m
CONFIG_VXFS_FS=m
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_SPKM3=m
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
# CONFIG_CIFS_EXPERIMENTAL is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
# CONFIG_KARMA_PARTITION is not set
CONFIG_EFI_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Instrumentation Support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=m
CONFIG_KPROBES=y

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_FORCED_INLINING=y
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_INIT_DEBUG=y
# CONFIG_DEBUG_RODATA is not set
# CONFIG_IOMMU_DEBUG is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_DEBUG_PROC_KEYS=y
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_NETWORK_XFRM is not set
CONFIG_SECURITY_CAPABILITIES=y
# CONFIG_SECURITY_ROOTPLUG is not set
# CONFIG_SECURITY_SECLVL is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
# CONFIG_CRYPTO_AES_X86_64 is not set
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#

#
# Library routines
#
CONFIG_CRC_CCITT=m
# CONFIG_CRC16 is not set
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
