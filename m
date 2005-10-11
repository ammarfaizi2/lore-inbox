Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbVJKVJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbVJKVJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 17:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbVJKVJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 17:09:59 -0400
Received: from bos-gate6.raytheon.com ([199.46.198.237]:12172 "EHLO
	bos-gate6.raytheon.com") by vger.kernel.org with ESMTP
	id S1751321AbVJKVJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 17:09:58 -0400
Message-ID: <434C29D9.8000603@raytheon.com>
Date: Tue, 11 Oct 2005 14:08:41 -0700
From: Robert Crocombe <rwcrocombe@raytheon.com>
Organization: Raytheon Missile Systems -- Tucson, AZ, U.S.
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: dtor_core@ameritech.net
Subject: Re: PS/2 Keyboard under 2.6.x
References: <434B121A.3000705@raytheon.com> <434B3C82.5080409@m1k.net>	 <5bdc1c8b0510102148l7faae4c7ke0ce4137b175dfcb@mail.gmail.com>	 <200510110042.13325.dtor_core@ameritech.net>	 <434C21F4.7090806@raytheon.com> <d120d5000510111353paf02994ta3bd815428f228d2@mail.gmail.com>
In-Reply-To: <d120d5000510111353paf02994ta3bd815428f228d2@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------070104000506030208090007"
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070104000506030208090007
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

Dmitry Torokhov wrote:
> On 10/11/05, Robert Crocombe <rwcrocombe@raytheon.com> wrote:
> 
>>Dmitry Torokhov wrote:
>>
>>>It is "usb-handoff", not "usb=handoff". It instructs BIOS to disable USB
>>>Legacy emulation mode which turns USB keyboard/mouse into emulated PS/2
>>>devices...
>>
>>No effect.
>>
> 
> 
> What about "i8042.noacpi"? Could you please send me your dmesg?

(Added LKML back in... Oops)

Using i8042.noacpi made the machine sad:

RIP: 0010:[<ffffffff802e5d48>] <ffffffff802e5d48>{scsi_run_queue+24}
RSP: 0018:ffff810081babe18  EFLAGS: 00010296
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000034
RDX: 0000000000000001 RSI: ffffffff8026eee0 RDI: ffff810002d78e88
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: 0000000000000000 R11: ffffffff802e7f90 R12: 0000000000000202
R13: 0000000000000001 R14: ffff810002d78e88 R15: ffff810002d78e88
FS:  0000000000000000(0000) GS:ffffffff804be980(0000) knlGS:0000000000000000

CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00000000000001d5 CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffff81000806c000, task ffff810008068100)
Stack: ffffffff8026eee0 0000000000000202 0000000000000001 ffff810002d54ac0
        0000000000000000 0000000000000202 0000000000000001 ffff810002d78e88
        0000000000000000 ffffffff802e6141
Call Trace: <IRQ> <ffffffff8026eee0>{kobject_release+0} 
<ffffffff802e6141>{scsi_end_request+209}
        <ffffffff802e660f>{scsi_io_completion+1183} 
<ffffffff802e6dd9>{scsi_device_unbusy+105}
        <ffffffff802e024a>{scsi_softirq+378} 
<ffffffff8013b0e4>{__do_softirq+100}
        <ffffffff8010f0fb>{call_softirq+31} 
<ffffffff801105ec>{do_softirq+44}
        <ffffffff8013adc8>{irq_exit+72} <ffffffff801108b4>{do_IRQ+52}
        <ffffffff8010e354>{ret_from_intr+0}  <EOI> 
<ffffffff80380aed>{preempt_schedule_irq+93}
        <ffffffff8010e482>{retint_kernel+38} 
<ffffffff8010c632>{default_idle+34}
        <ffffffff8010c68f>{cpu_idle+79} 
<ffffffff804d54bc>{start_secondary+956}

Code: 80 bb d5 01 00 00 00 48 8b 2b 0f 89 d3 00 00 00 4c 8b a3 d8
RIP <ffffffff802e5d48>{scsi_run_queue+24} RSP <ffff810081babe18>
CR2: 00000000000001d5
  <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

dmesg is attached.

-- 
Robert Crocombe
rwcrocombe@raytheon.com

--------------070104000506030208090007
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="my_dmesg"
Content-Disposition: inline;
 filename="my_dmesg"

Bootdata ok (command line is root=/dev/sda1 ro console=ttyS1,115800n8 console=tty0 )
Linux version 2.6.14-rc3_local_00 (rcrocomb@hydra) (gcc version 4.0.1 (Debian 4.0.1-2)) #2 SMP PREEMPT Tue Oct 4 18:06:14 MST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009b400 (usable)
 BIOS-e820: 000000000009b400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ca000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000fbf70000 (usable)
 BIOS-e820: 00000000fbf70000 - 00000000fbf76000 (ACPI data)
 BIOS-e820: 00000000fbf76000 - 00000000fbf80000 (ACPI NVS)
 BIOS-e820: 00000000fbf80000 - 00000000fc000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000200000000 (usable)
ACPI: RSDP (v002 PTLTD                                 ) @ 0x00000000000f6a70
ACPI: XSDT (v001 PTLTD  	 XSDT   0x06040000  LTP 0x00000000) @ 0x00000000fbf72d33
ACPI: FADT (v003 AMD    HAMMER   0x06040000 PTEC 0x000f4240) @ 0x00000000fbf72e8f
ACPI: SRAT (v001 AMD    HAMMER   0x06040000 AMD  0x00000001) @ 0x00000000fbf757fc
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x00000000fbf75934
ACPI: HPET (v001 AMD    HAMMER   0x06040000 PTEC 0x00000000) @ 0x00000000fbf75dac
ACPI: SSDT (v001 AMD-K8 AMD-ACPI 0x06040000  AMD 0x00000001) @ 0x00000000fbf75de4
ACPI: SSDT (v001 AMD-K8 AMD-ACPI 0x06040000  AMD 0x00000001) @ 0x00000000fbf75e81
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x00000000fbf75f1e
ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040000 PTL  0x00000001) @ 0x00000000fbf75fb0
ACPI: DSDT (v001 AMD-K8  AMDACPI 0x06040000 MSFT 0x0100000e) @ 0x0000000000000000
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 1 -> APIC 1 -> Node 1
SRAT: PXM 2 -> APIC 2 -> Node 2
SRAT: PXM 3 -> APIC 3 -> Node 3
SRAT: Node 0 PXM 0 0-9ffff
SRAT: Node 0 PXM 0 0-7fffffff
SRAT: Node 1 PXM 1 80000000-fbffffff
SRAT: Node 2 PXM 2 100000000-17fffffff
SRAT: Node 3 PXM 3 180000000-1ffffffff
Using 22 for the hash shift. Max adder is 1ffffffff 
Bootmem setup node 0 0000000000000000-000000007fffffff
Bootmem setup node 1 0000000080000000-00000000fbffffff
Bootmem setup node 2 0000000100000000-000000017fffffff
Bootmem setup node 3 0000000180000000-00000001ffffffff
On node 0 totalpages: 524186
  DMA zone: 3995 pages, LIFO batch:1
  Normal zone: 520191 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 507760
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 507760 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
On node 2 totalpages: 524287
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 524287 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
On node 3 totalpages: 524287
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 524287 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
ACPI: PM-Timer IO Port: 0xc008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Processor #2 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Processor #3 15:5 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x05] address[0xfc000000] gsi_base[24])
IOAPIC[1]: apic_id 5, version 17, address 0xfc000000, GSI 24-27
ACPI: IOAPIC (id[0x06] address[0xfc001000] gsi_base[28])
IOAPIC[2]: apic_id 6, version 17, address 0xfc001000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x102282a0 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at fc400000 (gap: fc000000:2c00000)
Checking aperture...
CPU 0: aperture @ 0 size 256 MB
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 4000000
Built 4 zonelists
Kernel command line: root=/dev/sda1 ro console=ttyS1,115800n8 console=tty0 
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 14.318180 MHz HPET timer.
time.c: Detected 2606.398 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Memory: 8125816k/8388608k available (2581k kernel code, 196276k reserved, 895k data, 220k init)
Calibrating delay using timer specific routine.. 5217.85 BogoMIPS (lpj=2608927)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
Using local APIC timer interrupts.
Detected 12.530 MHz APIC timer.
softlockup thread 0 started up.
Booting processor 1/4 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 5211.86 BogoMIPS (lpj=2605932)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(1) -> Node 1 -> Core 0
AMD Opteron(tm) Processor 852 stepping 01
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -128 cycles, maxerr 926 cycles)
softlockup thread 1 started up.
Booting processor 2/4 APIC 0x2
Initializing CPU#2
Calibrating delay using timer specific routine.. 5211.91 BogoMIPS (lpj=2605956)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2(1) -> Node 2 -> Core 0
AMD Opteron(tm) Processor 852 stepping 01
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff -128 cycles, maxerr 927 cycles)
softlockup thread 2 started up.
Booting processor 3/4 APIC 0x3
Initializing CPU#3
Calibrating delay using timer specific routine.. 5211.28 BogoMIPS (lpj=2605644)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3(1) -> Node 3 -> Core 0
AMD Opteron(tm) Processor 852 stepping 01
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff -169 cycles, maxerr 1590 cycles)
Brought up 4 CPUs
softlockup thread 3 started up.
time.c: Using HPET based timekeeping.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:06.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *5 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 *10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 10 *11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.TP2P._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.G0PA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.G0PB._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: ACPI device : hid PNP0200
pnp: ACPI device : hid PNP0B00
pnp: ACPI device : hid PNP0800
pnp: ACPI device : hid PNP0C04
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0C01
pnp: ACPI device : hid PNP0F13
pnp: ACPI device : hid PNP0303
pnp: ACPI device : hid PNP0A05
pnp: ACPI device : hid PNP0501
pnp: ACPI device : hid PNP0501
pnp: ACPI device : hid PNP0700
pnp: ACPI device : hid PNP0400
pnp: PnP ACPI: found 13 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 69ns tick, 3 32-bit timers
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 4000000 size 65536 KB
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:04' and the driver 'system'
pnp: 00:04: ioport range 0x4d0-0x4d1 has been reserved
pnp: match found with the PnP device '00:05' and the driver 'system'
PCI: Bridge: 0000:00:06.0
  IO window: 2000-2fff
  MEM window: fc100000-fdffffff
  PREFETCH window: fe100000-fe1fffff
PCI: Bridge: 0000:00:0a.0
  IO window: disabled.
  MEM window: fe000000-fe0fffff
  PREFETCH window: fe200000-fe2fffff
PCI: Bridge: 0000:00:0b.0
  IO window: disabled.
  MEM window: fe400000-fe4fffff
  PREFETCH window: fe300000-fe3fffff
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1129064575.173:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: MSI quirk detected. pci_msi_quirk set.
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 0) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:09' and the driver 'serial'
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: match found with the PnP device '00:0a' and the driver 'serial'
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
megaraid cmm: 2.20.2.6 (Release Date: Mon Mar 7 00:01:03 EST 2005)
megaraid: 2.20.4.6 (Release Date: Mon Mar 07 12:27:22 EST 2005)
megaraid: probe new device 0x1000:0x1960:0x1000:0x0520: bus 3:slot 3:func 0
ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 28 (level, low) -> IRQ 169
megaraid: fw version:[1L19] bios version:[1.04]
scsi0 : LSI Logic MegaRAID driver
scsi[0]: scanning scsi channel 0 [Phy 0] for non-raid devices
scsi[0]: scanning scsi channel 1 [virtual] for logical drives
  Vendor: MegaRAID  Model: LD0 RAID5 72202R  Rev: 1L19
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 1171869696 512-byte hdwr sectors (599997 MB)
sda: asking for cache data failed
sda: assuming drive cache: write through
SCSI device sda: 1171869696 512-byte hdwr sectors (599997 MB)
sda: asking for cache data failed
sda: assuming drive cache: write through
 sda: sda1 sda4 < sda5 sda6 sda7 sda8 >
Attached scsi disk sda at scsi0, channel 1, id 0, lun 0
usbmon: debugfs is not available
mice: PS/2 mouse device common for all mice
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid10 personality registered as nr 9
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: generic_sse
   generic_sse:  7864.000 MB/sec
raid5: using function: generic_sse (7864.000 MB/sec)
raid6: int64x1   2386 MB/s
raid6: int64x2   3214 MB/s
raid6: int64x4   3183 MB/s
raid6: int64x8   2167 MB/s
raid6: sse2x1    2234 MB/s
raid6: sse2x2    4234 MB/s
raid6: sse2x4    4550 MB/s
raid6: using algorithm sse2x4 (4550 MB/s)
md: raid6 personality registered as nr 8
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.39
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 220k freed
NET: Registered protocol family 1
Adding 7823612k swap on /dev/sda7.  Priority:-1 extents:1 across:7823612k
EXT3 FS on sda1, internal journal
Real Time Clock Driver v1.12
Generic RTC Driver v1.07
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
hda: TOSHIBA ODD-DVD SD-C2712, ATAPI CD/DVD-ROM drive
Probing IDE interface ide1...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X DVD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.20
XFS mounting filesystem sda8
Ending clean XFS mount for filesystem: sda8
XFS mounting filesystem sda5
Ending clean XFS mount for filesystem: sda5
XFS mounting filesystem sda6
Ending clean XFS mount for filesystem: sda6
tg3.c:v3.41 (September 27, 2005)
ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 24 (level, low) -> IRQ 177
eth0: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)] (PCI:33MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:61:f0:af
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth0: dma_rwctrl[763f0000]
ACPI: PCI Interrupt 0000:02:09.1[B] -> GSI 25 (level, low) -> IRQ 185
eth1: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)] (PCI:33MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:61:f0:b0
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth1: dma_rwctrl[763f0000]
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:01:00.0[D] -> GSI 19 (level, low) -> IRQ 193
ohci_hcd 0000:01:00.0: OHCI Host Controller
ohci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:01:00.0: irq 193, io mem 0xfc100000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI Interrupt 0000:01:00.1[D] -> GSI 19 (level, low) -> IRQ 193
ohci_hcd 0000:01:00.1: OHCI Host Controller
ohci_hcd 0000:01:00.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:01:00.1: irq 193, io mem 0xfc101000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 17 (level, low) -> IRQ 201
PCI: Via IRQ fixup for 0000:01:03.0, from 5 to 9
uhci_hcd 0000:01:03.0: UHCI Host Controller
uhci_hcd 0000:01:03.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:01:03.0: irq 201, io base 0x00002400
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:01:03.1[B] -> GSI 16 (level, low) -> IRQ 209
PCI: Via IRQ fixup for 0000:01:03.1, from 11 to 1
uhci_hcd 0000:01:03.1: UHCI Host Controller
uhci_hcd 0000:01:03.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:01:03.1: irq 209, io base 0x00002420
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 3-1: new low speed USB device using uhci_hcd and address 2
ACPI: PCI Interrupt 0000:01:03.2[C] -> GSI 18 (level, low) -> IRQ 217
PCI: Via IRQ fixup for 0000:01:03.2, from 10 to 9
ehci_hcd 0000:01:03.2: EHCI Host Controller
ehci_hcd 0000:01:03.2: new USB bus registered, assigned bus number 5
ehci_hcd 0000:01:03.2: irq 217, io mem 0xfc103000
ehci_hcd 0000:01:03.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 4 ports detected
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
AMD8111: port 0x01f0 already claimed by ide0
    ide1: BM-DMA at 0x1028-0x102f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide1...
usb 3-1: new low speed USB device using uhci_hcd and address 3
usb 3-2: new low speed USB device using uhci_hcd and address 4
hw_random: AMD768 system management I/O registers at 0xC000.
hw_random hardware driver 1.0.0 loaded
usbcore: registered new driver hiddev
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:01:03.0-1
input: USB HID v1.10 Keyboard [Chicony Compaq Internet Keyboard] on usb-0000:01:03.0-2
input,hiddev96: USB HID v1.10 Device [Chicony Compaq Internet Keyboard] on usb-0000:01:03.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:02:02.0[A] -> GSI 26 (level, low) -> IRQ 225
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[225]  MMIO=[fe044000-fe0447ff]  Max Packet=[4096]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[08144362000001a9]
eth1394: $Rev: 1312 $ Ben Collins <bcollins@debian.org>
eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
input: PC Speaker
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
pnp: the driver 'parport_pc' has been registered
pnp: match found with the PnP device '00:0c' and the driver 'parport_pc'
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP]
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.
lp0: using parport0 (interrupt-driven).

--------------070104000506030208090007--

