Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264637AbUDVTql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264637AbUDVTql (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 15:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264643AbUDVTqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 15:46:40 -0400
Received: from mail-haw.bigfish.com ([12.129.199.61]:18068 "EHLO
	mail19-haw-R.bigfish.com") by vger.kernel.org with ESMTP
	id S264637AbUDVTpq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 15:45:46 -0400
Message-ID: <408820D7.10400@lehman.com>
Date: Thu, 22 Apr 2004 15:45:27 -0400
From: "Shantanu Goel" <Shantanu.Goel@lehman.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1)
 Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Len Brown" <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ACPI x86_64] 2.6.1-rc{1,2} hang while booting on Sun v20z
 aka Newisys 2100
References: <A6974D8E5F98D511BB910002A50A6647615F976F@hdsmsx403.hd.intel.com>
 <1082653547.16336.335.camel@dhcppc4>
In-Reply-To: <1082653547.16336.335.camel@dhcppc4>
X-WSS-ID: 6C96FF521017495-01-01
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 8BIT
X-BigFish: v
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len,

I tried your suggestions.  Please see comments and data inline below.  
This time I'm using stock 2.6.5 for all data with debug enabled.
Hope this helps in further debugging...

Thanks,
Shantanu

Len Brown wrote:

>On Thu, 2004-04-22 at 10:17, Shantanu Goel wrote:
>  
>
>>I noticed a difference in timer detection between the two kernel.
>>
>>2.4 reports:
>>
>>..TIMER: vector=0x31 pin1=2 pin2=0
>>
>>2.6.6-rc1-bk4 reports:
>>
>>..TIMER: vector=0x31 pin1=2 pin2=-1
>>    
>>
>
>This should be okay, the -1 means that there was no ExtInt entry for the
>timer in the mp_irqs[], which is what one would expect in ACPI mode.
>The mystery to me is actually whey pin2=0 in ACPI mode on RHEL,
>but since pin1 is valid, pin2 will not be used anyway.
>  
>

That's reassuring ;-)

>Curious that acpi=off doesn't boot MP, the dmesg shows MPS present...
>

This works ok though again with only one cpu coming up.  Here is the output:

Bootdata ok (command line is ro root=LABEL=/ console=ttyS0 console=tty0 
debug acpi=off)
Linux version 2.6.5-x86_64 (root@njlxlabstinger2) (gcc version 3.2.3 
20030502 (Red Hat Linux 3.2.3-24)) #2 SMP Thu Apr 22 14:50:09 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009a000 (usable)
 BIOS-e820: 000000000009a000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff70000 (usable)
 BIOS-e820: 000000007ff70000 - 000000007ff73000 (ACPI data)
 BIOS-e820: 000000007ff73000 - 000000007ff80000 (ACPI NVS)
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Scanning NUMA topology in Northbridge 24
Number of nodes 2 (10010)
Node 0 MemBase 0000000000000000 Limit 000000003fffffff
Node 1 MemBase 0000000040000000 Limit 000000007ff70000
Using node hash shift of 24
Bootmem setup node 0 0000000000000000-000000003fffffff
Bootmem setup node 1 0000000040000000-000000007ff70000
ACPI: have wakeup address 0x1004000a000
No mptable found.
No mptable found.
setting up node 0 0-3ffff
On node 0 totalpages: 262143
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 258047 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
setting up node 1 40000-7ff70
On node 1 totalpages: 262000
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 262000 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
SMP mptable: bad signature [  ]!
BIOS bug, MP table errors detected!...
... disabling SMP support. (tell your hw vendor)
Checking aperture...
CPU 0: aperture @ 0 size 32 MB
No AGP bridge found
Built 2 zonelists
Kernel command line: ro root=LABEL=/ console=ttyS0 console=tty0 debug 
acpi=off
Initializing CPU#0
PID hash table entries: 16 (order 4: 256 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1992.151 MHz processor.
Console: colour VGA+ 80x25
Memory: 2053412k/2096576k available (2198k kernel code, 0k reserved, 
1163k data, 192k init)
Calibrating delay loop... 3915.77 BogoMIPS
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an 
initrd
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
POSIX conformance testing by UNIFIX
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU0: AMD Engineering Sample 00 stepping 08
per-CPU timeslice cutoff: 1023.83 usecs.
task migration cache decay timeout: 2 msecs.
weird, boot CPU (#0) not listed by the BIOS.
SMP motherboard not detected.
Using local APIC timer interrupts.
Detected 12.450 MHz APIC timer.
time.c: Using PIT/TSC based timekeeping.
Brought up 1 CPUs
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter disabled.
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1022/746b] at 0000:00:07.3
PCI-DMA: Disabling IOMMU.
Total HugeTLB memory allocated, 0
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ÿttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
hdc: CD-224E, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
SCSI subsystem initialized
Fusion MPT base driver 3.01.01
Copyright (c) 1999-2004 LSI Logic Corporation
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
Fusion MPT SCSI Host driver 3.01.01
scsi0 : ioc0: LSI53C1030, FwRev=01030a00h, Ports=1, MaxQ=222, IRQ=10
  Vendor: SEAGATE   Model: ST336607LC        Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sda: 71687372 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 >
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 192k freed
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel

Red Hat Enterprise Linux AS release 3 (Taroon Update 1)
Kernel 2.6.5-x86_64 on an x86_64

njlxlabstinger2 login: md: stopping all md devices.

>Anyway, try acpi=ht to get your cpus back.
>  
>

This hangs.  Here is the output:

Bootdata ok (command line is ro root=LABEL=/ console=ttyS0 console=tty0 
debug acpi=ht)
Linux version 2.6.5-x86_64 (root@njlxlabstinger2) (gcc version 3.2.3 
20030502 (Red Hat Linux 3.2.3-24)) #2 SMP Thu Apr 22 14:50:09 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009a000 (usable)
 BIOS-e820: 000000000009a000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff70000 (usable)
 BIOS-e820: 000000007ff70000 - 000000007ff73000 (ACPI data)
 BIOS-e820: 000000007ff73000 - 000000007ff80000 (ACPI NVS)
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Scanning NUMA topology in Northbridge 24
Number of nodes 2 (10010)
Node 0 MemBase 0000000000000000 Limit 000000003fffffff
Node 1 MemBase 0000000040000000 Limit 000000007ff70000
Using node hash shift of 24
Bootmem setup node 0 0000000000000000-000000003fffffff
Bootmem setup node 1 0000000040000000-000000007ff70000
ACPI: have wakeup address 0x1004000a000
No mptable found.
No mptable found.
setting up node 0 0-3ffff
On node 0 totalpages: 262143
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 258047 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
setting up node 1 40000-7ff70
On node 1 totalpages: 262000
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 262000 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v002 PTLTD                                     ) @ 
0x00000000000f7d00
ACPI: XSDT (v001 PTLTD       XSDT   0x06040000  LTP 0x00000000) @ 
0x000000007ff7108b
ACPI: FADT (v003 NWS    1U2P     0x06040000 PTEC 0x000f4240) @ 
0x000000007ff72e46
ACPI: MADT (v001 PTLTD       APIC   0x06040000  LTP 0x00000000) @ 
0x000000007ff72f3a
ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040000 PTL  0x00000001) @ 
0x000000007ff72fb0
ACPI: DSDT (v001    NWS   1U2P   0x06040000 MSFT 0x0100000e) @ 
0x0000000000000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfd000000] global_irq_base[0x18])
IOAPIC[1]: Assigned apic_id 3
IOAPIC[1]: apic_id 3, version 17, address 0xfd000000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xfd001000] global_irq_base[0x1c])
IOAPIC[2]: Assigned apic_id 4
IOAPIC[2]: apic_id 4, version 17, address 0xfd001000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ 0 size 32 MB
No AGP bridge found
Built 2 zonelists
Kernel command line: ro root=LABEL=/ console=ttyS0 console=tty0 debug 
acpi=ht
Initializing CPU#0
PID hash table entries: 16 (order 4: 256 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1991.947 MHz processor.
Console: colour VGA+ 80x25
Memory: 2053412k/2096576k available (2198k kernel code, 0k reserved, 
1163k data, 192k init)
Calibrating delay loop... 3915.77 BogoMIPS
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an 
initrd
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
POSIX conformance testing by UNIFIX
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU0: AMD Engineering Sample 00 stepping 08
per-CPU timeslice cutoff: 1024.34 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 rip 6000 rsp 1004127ff58
Initializing CPU#1
Calibrating delay loop... 3981.31 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
AMD Engineering Sample 00 stepping 08
Total of 2 processors activated (7897.08 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 
2-23, 3-0, 3-1, 3-2, 3-3, 4-0, 4-1, 4-2, 4-3 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
Detected 12.449 MHz APIC timer.
checking TSC synchronization across 2 CPUs: passed.
time.c: Using PIT/TSC based timekeeping.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *5 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 5 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 *10 11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.THOR._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.Z000._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.Z002._PRT]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
00:01:00[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
00:01:00[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18 Mode:1 Active:1)
00:01:00[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
00:01:00[D] -> 2-19 -> IRQ 19
IOAPIC[1]: Set PCI routing entry (3-1 -> 0xc9 -> IRQ 25 Mode:1 Active:1)
00:02:02[A] -> 3-1 -> IRQ 25
IOAPIC[1]: Set PCI routing entry (3-2 -> 0xd1 -> IRQ 26 Mode:1 Active:1)
00:02:03[A] -> 3-2 -> IRQ 26
IOAPIC[1]: Set PCI routing entry (3-3 -> 0xd9 -> IRQ 27 Mode:1 Active:1)
00:02:04[A] -> 3-3 -> IRQ 27
IOAPIC[1]: Set PCI routing entry (3-0 -> 0xe1 -> IRQ 24 Mode:1 Active:1)
00:02:05[A] -> 3-0 -> IRQ 24
IOAPIC[2]: Set PCI routing entry (4-0 -> 0xe9 -> IRQ 28 Mode:1 Active:1)
00:03:01[A] -> 4-0 -> IRQ 28
IOAPIC[2]: Set PCI routing entry (4-1 -> 0x32 -> IRQ 29 Mode:1 Active:1)
00:03:01[B] -> 4-1 -> IRQ 29
IOAPIC[2]: Set PCI routing entry (4-2 -> 0x3a -> IRQ 30 Mode:1 Active:1)
00:03:01[C] -> 4-2 -> IRQ 30
IOAPIC[2]: Set PCI routing entry (4-3 -> 0x42 -> IRQ 31 Mode:1 Active:1)
00:03:01[D] -> 4-3 -> IRQ 31
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
number of IO-APIC #3 registers: 4.
number of IO-APIC #4 registers: 4.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    1    0   1   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   1   0    1    1    A9
 11 001 01  1    1    0   1   0    1    1    B1
 12 001 01  1    1    0   1   0    1    1    B9
 13 001 01  1    1    0   1   0    1    1    C1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #3......
.... register #00: 03000000
.......    : physical APIC id: 03
.... register #01: 00030011
.......     : max redirection entries: 0003
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  
 00 001 01  1    1    0   1   0    1    1    E1
 01 001 01  1    1    0   1   0    1    1    C9
 02 001 01  1    1    0   1   0    1    1    D1
 03 001 01  1    1    0   1   0    1    1    D9

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.... register #01: 00030011
.......     : max redirection entries: 0003
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  
 00 001 01  1    1    0   1   0    1    1    E9
 01 001 01  1    1    0   1   0    1    1    32
 02 001 01  1    1    0   1   0    1    1    3A
 03 001 01  1    1    0   1   0    1    1    42
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
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ24 -> 1:0
IRQ25 -> 1:1
IRQ26 -> 1:2
IRQ27 -> 1:3
IRQ28 -> 2:0
IRQ29 -> 2:1
IRQ30 -> 2:2
IRQ31 -> 2:3
.................................... done.
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
PCI-DMA: Disabling IOMMU.
Total HugeTLB memory allocated, 0
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ÿttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
hdc: CD-224E, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2

>More interesting would be if pci=noacpi works on 2.6.
>

This hangs as well.  Here is the output:

Bootdata ok (command line is ro root=LABEL=/ console=ttyS0 console=tty0 
debug pci=noacpi)
Linux version 2.6.5-x86_64 (root@njlxlabstinger2) (gcc version 3.2.3 
20030502 (Red Hat Linux 3.2.3-24)) #2 SMP Thu Apr 22 14:50:09 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009a000 (usable)
 BIOS-e820: 000000000009a000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff70000 (usable)
 BIOS-e820: 000000007ff70000 - 000000007ff73000 (ACPI data)
 BIOS-e820: 000000007ff73000 - 000000007ff80000 (ACPI NVS)
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Scanning NUMA topology in Northbridge 24
Number of nodes 2 (10010)
Node 0 MemBase 0000000000000000 Limit 000000003fffffff
Node 1 MemBase 0000000040000000 Limit 000000007ff70000
Using node hash shift of 24
Bootmem setup node 0 0000000000000000-000000003fffffff
Bootmem setup node 1 0000000040000000-000000007ff70000
ACPI: have wakeup address 0x1004000a000
No mptable found.
No mptable found.
setting up node 0 0-3ffff
On node 0 totalpages: 262143
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 258047 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
setting up node 1 40000-7ff70
On node 1 totalpages: 262000
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 262000 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v002 PTLTD                                     ) @ 
0x00000000000f7d00
ACPI: XSDT (v001 PTLTD       XSDT   0x06040000  LTP 0x00000000) @ 
0x000000007ff7108b
ACPI: FADT (v003 NWS    1U2P     0x06040000 PTEC 0x000f4240) @ 
0x000000007ff72e46
ACPI: MADT (v001 PTLTD       APIC   0x06040000  LTP 0x00000000) @ 
0x000000007ff72f3a
ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040000 PTL  0x00000001) @ 
0x000000007ff72fb0
ACPI: DSDT (v001    NWS   1U2P   0x06040000 MSFT 0x0100000e) @ 
0x0000000000000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
SMP mptable: bad signature [<3>BIOS bug, MP table errors detected!...
... disabling SMP support. (tell your hw vendor)
Checking aperture...
CPU 0: aperture @ 0 size 32 MB
No AGP bridge found
Built 2 zonelists
Kernel command line: ro root=LABEL=/ console=ttyS0 console=tty0 debug 
pci=noacpi
Initializing CPU#0
PID hash table entries: 16 (order 4: 256 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1992.030 MHz processor.
Console: colour VGA+ 80x25
Memory: 2053412k/2096576k available (2198k kernel code, 0k reserved, 
1163k data, 192k init)
Calibrating delay loop... 3915.77 BogoMIPS
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an 
initrd
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
POSIX conformance testing by UNIFIX
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU0: AMD Engineering Sample 00 stepping 08
per-CPU timeslice cutoff: 1023.83 usecs.
task migration cache decay timeout: 2 msecs.
SMP motherboard not detected.
Using local APIC timer interrupts.
Detected 12.450 MHz APIC timer.
time.c: Using PIT/TSC based timekeeping.
Brought up 1 CPUs
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *5 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 5 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 *10 11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.THOR._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.Z000._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.Z002._PRT]



------------------------------------------------------------------------------
This message is intended only for the personal and confidential use of the designated recipient(s) named above.  If you are not the intended recipient of this message you are hereby notified that any review, dissemination, distribution or copying of this message is strictly prohibited.  This communication is for information purposes only and should not be regarded as an offer to sell or as a solicitation of an offer to buy any financial product, an official confirmation of any transaction, or as an official statement of Lehman Brothers.  Email transmission cannot be guaranteed to be secure or error-free.  Therefore, we do not represent that this information is complete or accurate and it should not be relied upon as such.  All information is subject to change without notice.

