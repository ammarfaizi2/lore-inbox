Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263687AbUGFI0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbUGFI0N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 04:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUGFI0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 04:26:13 -0400
Received: from mail.thomasrepro.com ([216.99.241.149]:60422 "EHLO
	thomasrepro.com") by vger.kernel.org with ESMTP id S263687AbUGFIZc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 04:25:32 -0400
In-Reply-To: <200407060914.29830.vda@port.imtp.ilyichevsk.odessa.ua>
References: <A6974D8E5F98D511BB910002A50A6647615FF248@hdsmsx403.hd.intel.com> <1089080891.15653.430.camel@dhcppc4> <200407060914.29830.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <01F2769B-CF26-11D8-BFEC-000A956E7DA6@thomasrepro.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
From: Andrew Feldhacker <afeldhacker@thomasrepro.com>
Subject: Re: 2.6 series kernels on HP Netserver LH4 - kernel panic on boot
Date: Tue, 6 Jul 2004 01:25:15 -0700
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jul 5, 2004, at 11:14 PM, Denis Vlasenko wrote:

> On Tuesday 06 July 2004 05:28, Len Brown wrote:
>> On Mon, 2004-06-28 at 18:51, Andrew Feldhacker wrote:
>>> 2.6 series kernels on HP Netserver LH4 - kernel panic on boot
>>>
>>>
>>> In attempting to migrate to the 2.6 series Linux kernel on my HP
>>> Netserver LH4, I've run into a kernel panic on boot.  This happens
>>> nearly immediately upon booting to the kernel, and so quickly that I
>>> can't make out anything other than the truncated (transcribed) dump
>>> appended below.
>>>
>>> 2.4.x kernels work without a hitch on this system (I was trying to
>>> move
>>> from 2.4.26 to 2.6.6 or 2.6.7 -- both of which produce the same
>>> problem.).  I've also searched around a bit online, and found a 
>>> couple
>>> other mentions of what seem to be the same problem, however, there
>>> were
>>> no replies to go along with them.
>>>
>>> The dump below is from a vanilla 2.6.7 kernel:
>>>
>>> ----- top of screen -----
>>>         00000000 c02db078 c01bb853 f7feddb0 c02db078 00000000 
>>> 00000001
>>> f7ea3400
>>>         00000000 00000000 00000000 c01bbaf8 f7feb158 f7ea3400 
>>> 00000001
>>> 00000207
>>> Call Trace:
>>>    [<c02056e2>] class_device_add+0x112/0x130
>>>    [<c0205343>] class_device_create_file+0x23/0x30
>>>    [<c01bb853>] pci_alloc_child_bus+0x93/0xe0
>>>    [<c01bbaf8>] pci_scan_bridge+0x208/0x250
>>>    [<c01bc1da>] pci_scan_child_bus+0xaa/0xb0
>>>    [<c01bc354>] pci_scan_bus_parented+0x144/0x170
>>>    [<c0221f3e>] pcibios_scan_root+0x5e/0x70
>>>    [<c01d9b35>] acpi_pci_root_add+0x16d/0x1cd
>>>    [<c01db6aa>] acpi_bus_driver_init+0x2c/0x8a
>>>    [<c01dba24>] acpi_bus_find_driver+0x83/0xdd
>>>    [<c01dbed6>] acpi_bus_add+0x128/0x155
>>>    [<c01dc00e>] acpi_bus_scan+0x10b/0x159
>>>    [<c0359b5f>] acpi_scan_init+0x4e/0x6f
>>>    [<c03449ab>] do_initcalls+0x2b/0xc0
>>>    [<c0132bb5>] init_workqueues+0x15/0x2c
>>>    [<c0100564>] init+0x104/0x270
>>>    [<c0100460>] init+0x0/0x270
>>>    [<c01042c5>] kernel_thread_helper+0x5/0x10
>>>
>>> Code: 0b 47 0c 8d 48 6c f0 ff 48 6c 0f 88 9f 01 00 00 8b 45 00 89
>>>    <0>Kernel panic: Attempted to kill init!
>>>
>>>
>>> Any help on this would be much appreciated, and I would be more than
>>> happy to provide any additional information which may be needed.
>>
>> any chance of getting a serial console "debug" capture?
>
> If setting up serial console is problematic, simply set vga=
> boot parameter to largest working resolution, to get the most
> of the panic.
>
>> would be interesting to try "acpi=off" and "pci=noacpi",
>> to see if ACPI is involved, but the trace above suggests
>> that the problem may lie in the common PCI code.
> -- 
> vda
>

Sorry -- I really should've thought of all that before, eh?

Anyway, here it is:

Linux version 2.6.7 (root@borealis) (gcc version 3.3.4 (Debian)) #1 SMP 
Fri Jun
25 02:26:24 MST 2004
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e8800 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
  BIOS-e820: 000000003fff0000 - 000000003ffffc00 (ACPI data)
  BIOS-e820: 000000003ffffc00 - 0000000040000000 (ACPI NVS)
  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000fffe8800 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f6e10
On node 0 totalpages: 262128
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 225280 pages, LIFO batch:16
   HighMem zone: 32752 pages, LIFO batch:7
DMI 2.1 present.
ACPI: RSDP (v000 PTLTD                                     ) @ 
0x000f6da0
ACPI: RSDT (v001 PTLTD  HWPC204  0x00000001  LTP 0x00000000) @ 
0x3fff9b04
ACPI: FADT (v001 HP     LH 4     0x00000002 PTL  0x00000002) @ 
0x3ffffb13
ACPI: MADT (v001 PTLTD    APIC   0x00000001  LTP 0x00000001) @ 
0x3ffffb87
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x00000001  LTP 0x00000001) @ 
0x3ffffbd9
ACPI: DSDT (v001     HP     LH 4 0x00000001 MSFT 0x0100000a) @ 
0x00000000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:7 APIC version 17
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x01] enabled)
Processor #1 6:7 APIC version 17
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/md0 ro console=ttyS0,9600
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 550.201 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 1036384k/1048512k available (1632k kernel code, 11224k 
reserved, 677k da
ta, 168k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor 
mode... Ok.
Calibrating delay loop... 1085.44 BogoMIPS
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Katmai) stepping 03
per-CPU timeslice cutoff: 5850.23 usecs.
task migration cache decay timeout: 6 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1097.72 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Katmai) stepping 03
Total of 2 processors activated (2183.16 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 549.0972 MHz.
..... host bus clock speed is 99.0994 MHz.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdab2, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Searching for i450NX host bridges on 0000:00:10.0
Unable to handle kernel NULL pointer dereference at virtual address 
0000000c
  printing eip:
c01a10ab
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in:
CPU:    1
EIP:    0060:[<c01a10ab>]    Not tainted
EFLAGS: 00010296   (2.6.7)
EIP is at sysfs_add_file+0x1b/0xb0
eax: 00000000   ebx: f7fedd78   ecx: c03135c8   edx: f7feddb8
esi: f7fedd38   edi: 00000000   ebp: c02db078   esp: f7f9de18
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=f7f9c000 task=f7f9f670)
Stack: f7fede00 c02056e2 f7feddb8 f7fedd78 f7fedd38 f7feb158 00000001 
c0205343
        00000000 c02db078 c01bb853 f7feddb0 c02db078 00000000 00000001 
f7ea3400
        00000000 00000000 00000000 c01bbaf8 f7feb158 f7ea3400 00000001 
00000207
Call Trace:
  [<c02056e2>] class_device_add+0x112/0x130
  [<c0205343>] class_device_create_file+0x23/0x30
  [<c01bb853>] pci_alloc_child_bus+0x93/0xe0
  [<c01bbaf8>] pci_scan_bridge+0x208/0x250
  [<c01bc1da>] pci_scan_child_bus+0xaa/0xb0
  [<c01bc354>] pci_scan_bus_parented+0x144/0x170
  [<c0221f3e>] pcibios_scan_root+0x5e/0x70
  [<c01d9b35>] acpi_pci_root_add+0x16d/0x1cd
  [<c01db6aa>] acpi_bus_driver_init+0x2c/0x8a
  [<c01dba24>] acpi_bus_find_driver+0x83/0xdd
  [<c01dbed6>] acpi_bus_add+0x128/0x155
  [<c01dc00e>] acpi_bus_scan+0x10b/0x159
  [<c0359b5f>] acpi_scan_init+0x4e/0x6f
  [<c03449ab>] do_initcalls+0x2b/0xc0
  [<c0132bb5>] init_workqueues+0x15/0x2c
  [<c0100564>] init+0x104/0x270
  [<c0100460>] init+0x0/0x270
  [<c01042c5>] kernel_thread_helper+0x5/0x10

Code: 8b 47 0c 8d 48 6c f0 ff 48 6c 0f 88 9f 01 00 00 8b 45 00 89
  <0>Kernel panic: Attempted to kill init!


----


It panics with both 'acpi=off' and 'pci=noacpi', but I've included 
those as well, along with the outputs from lspci and cpuinfo:


  Linux version 2.6.7 (root@borealis) (gcc version 3.3.4 (Debian)) #1 
SMP Fri Jun
  25 02:26:24 MST 2004
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e8800 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
  BIOS-e820: 000000003fff0000 - 000000003ffffc00 (ACPI data)
  BIOS-e820: 000000003ffffc00 - 0000000040000000 (ACPI NVS)
  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000fffe8800 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f6e10
On node 0 totalpages: 262128
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 225280 pages, LIFO batch:16
   HighMem zone: 32752 pages, LIFO batch:7
DMI 2.1 present.
Intel MultiProcessor Specification v1.4
     Virtual Wire compatibility mode.
OEM ID: HP       Product ID: LH 4         APIC at: 0xFEE00000
Processor #1 6:7 APIC version 17
Processor #0 6:7 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Built 1 zonelists
Kernel command line: root=/dev/md0 ro console=ttyS0,9600 acpi=off
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 550.168 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 1036384k/1048512k available (1632k kernel code, 11224k 
reserved, 677k da
ta, 168k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor 
mode... Ok.
Calibrating delay loop... 1081.34 BogoMIPS
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Katmai) stepping 03
per-CPU timeslice cutoff: 5850.23 usecs.
task migration cache decay timeout: 6 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1097.72 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Katmai) stepping 03
Total of 2 processors activated (2179.07 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
testing the IO APIC.......................
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 549.0973 MHz.
..... host bus clock speed is 99.0995 MHz.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdab2, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f6e20
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9dee, dseg 0x400
pnp: 00:02: ioport range 0xc00-0xc08 has been reserved
pnp: 00:02: ioport range 0xca8-0xcab has been reserved
pnp: 00:0b: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0b: ioport range 0x8000-0x803f has been reserved
pnp: 00:0b: ioport range 0x1040-0x104f has been reserved
PnPBIOS: 19 nodes reported by PnP BIOS; 19 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Searching for i450NX host bridges on 0000:00:10.0
Unable to handle kernel NULL pointer dereference at virtual address 
0000000c
  printing eip:
c01a10ab
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in:
CPU:    1
EIP:    0060:[<c01a10ab>]    Not tainted
EFLAGS: 00010282   (2.6.7)
EIP is at sysfs_add_file+0x1b/0xb0
eax: 00000000   ebx: f7fedd78   ecx: c03135c8   edx: f7feddb8
esi: f7fedd38   edi: 00000000   ebp: c02db078   esp: f7f9ded0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=f7f9c000 task=f7f9f670)
Stack: f7fede00 c02056e2 f7feddb8 f7fedd78 f7fedd38 f7feb158 00000001 
c0205343
        00000000 c02db078 c01bb853 f7feddb0 c02db078 00000000 00000001 
f7e82800
        00000000 00000000 00000000 c01bbaf8 f7feb158 f7e82800 00000001 
00000207
Call Trace:
  [<c02056e2>] class_device_add+0x112/0x130
  [<c0205343>] class_device_create_file+0x23/0x30
  [<c01bb853>] pci_alloc_child_bus+0x93/0xe0
  [<c01bbaf8>] pci_scan_bridge+0x208/0x250
  [<c01bc1da>] pci_scan_child_bus+0xaa/0xb0
  [<c01bc354>] pci_scan_bus_parented+0x144/0x170
  [<c0221f3e>] pcibios_scan_root+0x5e/0x70
  [<c035eb68>] pci_legacy_init+0x38/0x60
  [<c03449ab>] do_initcalls+0x2b/0xc0
  [<c0132bb5>] init_workqueues+0x15/0x2c
  [<c0100564>] init+0x104/0x270
  [<c0100460>] init+0x0/0x270
  [<c01042c5>] kernel_thread_helper+0x5/0x10

Code: 8b 47 0c 8d 48 6c f0 ff 48 6c 0f 88 9f 01 00 00 8b 45 00 89
  <0>Kernel panic: Attempted to kill init!


----


  Linux version 2.6.7 (root@borealis) (gcc version 3.3.4 (Debian)) #1 
SMP Fri Jun
  25 02:26:24 MST 2004
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e8800 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
  BIOS-e820: 000000003fff0000 - 000000003ffffc00 (ACPI data)
  BIOS-e820: 000000003ffffc00 - 0000000040000000 (ACPI NVS)
  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000fffe8800 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f6e10
On node 0 totalpages: 262128
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 225280 pages, LIFO batch:16
   HighMem zone: 32752 pages, LIFO batch:7
DMI 2.1 present.
ACPI: RSDP (v000 PTLTD                                     ) @ 
0x000f6da0
ACPI: RSDT (v001 PTLTD  HWPC204  0x00000001  LTP 0x00000000) @ 
0x3fff9b04
ACPI: FADT (v001 HP     LH 4     0x00000002 PTL  0x00000002) @ 
0x3ffffb13
ACPI: MADT (v001 PTLTD    APIC   0x00000001  LTP 0x00000001) @ 
0x3ffffb87
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x00000001  LTP 0x00000001) @ 
0x3ffffbd9
ACPI: DSDT (v001     HP     LH 4 0x00000001 MSFT 0x0100000a) @ 
0x00000000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:7 APIC version 17
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x01] enabled)
Processor #1 6:7 APIC version 17
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
     Virtual Wire compatibility mode.
OEM ID: HP       Product ID: LH 4         APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Built 1 zonelists
Kernel command line: root=/dev/md0 ro console=ttyS0,9600 pci=noacpi
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 550.290 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 1036384k/1048512k available (1632k kernel code, 11224k 
reserved, 677k da
ta, 168k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor 
mode... Ok.
Calibrating delay loop... 1081.34 BogoMIPS
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Katmai) stepping 03
per-CPU timeslice cutoff: 5850.23 usecs.
task migration cache decay timeout: 6 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1097.72 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Katmai) stepping 03
Total of 2 processors activated (2179.07 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
testing the IO APIC.......................
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 549.0932 MHz.
..... host bus clock speed is 99.0987 MHz.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdab2, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f6e20
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9dee, dseg 0x400
pnp: 00:02: ioport range 0xc00-0xc08 has been reserved
pnp: 00:02: ioport range 0xca8-0xcab has been reserved
pnp: 00:0b: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0b: ioport range 0x8000-0x803f has been reserved
pnp: 00:0b: ioport range 0x1040-0x104f has been reserved
PnPBIOS: 19 nodes reported by PnP BIOS; 19 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Searching for i450NX host bridges on 0000:00:10.0
Unable to handle kernel NULL pointer dereference at virtual address 
0000000c
  printing eip:
c01a10ab
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in:
CPU:    1
EIP:    0060:[<c01a10ab>]    Not tainted
EFLAGS: 00010282   (2.6.7)
EIP is at sysfs_add_file+0x1b/0xb0
eax: 00000000   ebx: f7fedc78   ecx: c03135c8   edx: f7fedcb8
esi: f7fedc38   edi: 00000000   ebp: c02db078   esp: f7f9ded0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=f7f9c000 task=f7f9f670)
Stack: f7fedd00 c02056e2 f7fedcb8 f7fedc78 f7fedc38 f7fede38 00000001 
c0205343
        00000000 c02db078 c01bb853 f7fedcb0 c02db078 00000000 00000001 
f7df2c00
        00000000 00000000 00000000 c01bbaf8 f7fede38 f7df2c00 00000001 
00000207
Call Trace:
  [<c02056e2>] class_device_add+0x112/0x130
  [<c0205343>] class_device_create_file+0x23/0x30
  [<c01bb853>] pci_alloc_child_bus+0x93/0xe0
  [<c01bbaf8>] pci_scan_bridge+0x208/0x250
  [<c01bc1da>] pci_scan_child_bus+0xaa/0xb0
  [<c01bc354>] pci_scan_bus_parented+0x144/0x170
  [<c0221f3e>] pcibios_scan_root+0x5e/0x70
  [<c035eb68>] pci_legacy_init+0x38/0x60
  [<c03449ab>] do_initcalls+0x2b/0xc0
  [<c0132bb5>] init_workqueues+0x15/0x2c
  [<c0100564>] init+0x104/0x270
  [<c0100460>] init+0x0/0x270
  [<c01042c5>] kernel_thread_helper+0x5/0x10

Code: 8b 47 0c 8d 48 6c f0 ff 48 6c 0f 88 9f 01 00 00 8b 45 00 89
  <0>Kernel panic: Attempted to kill init!


And here's the output of 'lspci', and contents of /proc/cpuinfo that 
didn't make it the first go-round:

borealis:~# lspci -vvv
0000:00:02.0 PCI bridge: Intel Corp. 80960RP [i960 RP 
Microprocessor/Bridge] (rev 05) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, Cache Line Size: 0x08 (32 bytes)
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=248
         I/O behind bridge: 0000a000-0000afff
         Memory behind bridge: fa100000-fa1fffff
         Prefetchable memory behind bridge: fff00000-000fffff
         BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:02.1 Memory controller: Intel Corp. 80960RP [i960RP 
Microprocessor] (rev 05)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 17
         Region 0: Memory at fa300000 (32-bit, prefetchable) [size=4K]

0000:00:03.0 PCI bridge: Digital Equipment Corporation DECchip 21152 
(rev 03) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, Cache Line Size: 0x08 (32 bytes)
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=68
         I/O behind bridge: 0000b000-0000bfff
         Memory behind bridge: fa200000-fa2fffff
         Prefetchable memory behind bridge: 
00000000fff00000-0000000000000000
         BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                 Bridge: PM- B3+

0000:00:04.0 Ethernet controller: Broadcom Corporation NetXtreme 
BCM5701 Gigabit Ethernet (rev 15)
         Subsystem: 3Com Corporation 3C996B-T 1000Base-T
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (16000ns min)
         Interrupt: pin A routed to IRQ 16
         Region 0: Memory at fa000000 (64-bit, non-prefetchable) 
[size=64K]
         Capabilities: [40] PCI-X non-bridge device.
                 Command: DPERE- ERO- RBC=0 OST=0
                 Status: Bus=255 Dev=31 Func=1 64bit+ 133MHz+ SCD- USC-, 
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
         Capabilities: [48] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [50] Vital Product Data
         Capabilities: [58] Message Signalled Interrupts: 64bit+ 
Queue=0/3 Enable-
                 Address: ce7bb75103b0ef20  Data: 3140

0000:00:05.0 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A 
U160/m (rev 01)
         Subsystem: Adaptec AHA-3960D U160/m
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 72 (10000ns min, 6250ns max), Cache Line Size: 0x08 
(32 bytes)
         Interrupt: pin A routed to IRQ 17
         BIST result: 00
         Region 0: I/O ports at 9000 [disabled] [size=256]
         Region 1: Memory at fa018000 (64-bit, non-prefetchable) 
[size=4K]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:05.1 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A 
U160/m (rev 01)
         Subsystem: Adaptec AHA-3960D U160/m
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 72 (10000ns min, 6250ns max), Cache Line Size: 0x08 
(32 bytes)
         Interrupt: pin B routed to IRQ 18
         BIST result: 00
         Region 0: I/O ports at 9400 [disabled] [size=256]
         Region 1: Memory at fa019000 (64-bit, non-prefetchable) 
[size=4K]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:06.0 System peripheral: Hewlett-Packard Company NetServer Smart 
IRQ Router (rev a0)
         Subsystem: Hewlett-Packard Company: Unknown device 0001
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Region 0: Memory at fa010000 (32-bit, non-prefetchable) 
[size=32K]

0000:00:08.0 VGA compatible controller: Cirrus Logic GD 5446 (rev 45) 
(prog-if 00 [VGA])
         Subsystem: Hewlett-Packard Company: Unknown device 0001
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
         Region 1: Memory at fa01a000 (32-bit, non-prefetchable) 
[size=4K]
         Expansion ROM at <unassigned> [disabled] [size=32K]

0000:00:0f.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

0000:00:0f.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 
01) (prog-if 80 [Master])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Region 4: I/O ports at 9820 [size=16]

0000:00:0f.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 
01) (prog-if 00 [UHCI])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Interrupt: pin D routed to IRQ 19
         Region 4: I/O ports at 9800 [size=32]

0000:00:0f.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin ? routed to IRQ 9

0000:00:10.0 Host bridge: Intel Corp. 450NX - 82451NX Memory & I/O 
Controller (rev 03)
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:00:12.0 Host bridge: Intel Corp. 450NX - 82454NX/84460GX PCI 
Expander Bridge (rev 04)
         Subsystem: Intel Corp. 450NX - 82454NX/84460GX PCI Expander 
Bridge
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 72, Cache Line Size: 0x08 (32 bytes)

0000:01:06.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895 
(rev 01)
         Subsystem: Hewlett-Packard Company: Unknown device 1000
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 247 (7500ns min, 16000ns max), Cache Line Size: 0x08 
(32 bytes)
         Interrupt: pin A routed to IRQ 18
         Region 0: I/O ports at 1400 [size=256]
         Region 1: Memory at 40000000 (32-bit, non-prefetchable) 
[size=256]
         Region 2: Memory at 40001000 (32-bit, non-prefetchable) 
[size=4K]

0000:01:06.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895 
(rev 01)
         Subsystem: Hewlett-Packard Company: Unknown device 1000
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 247 (7500ns min, 16000ns max), Cache Line Size: 0x08 
(32 bytes)
         Interrupt: pin A routed to IRQ 18
         Region 0: I/O ports at a000 [size=256]
         Region 1: Memory at fa102000 (32-bit, non-prefetchable) 
[size=256]
         Region 2: Memory at fa100000 (32-bit, non-prefetchable) 
[size=4K]

0000:01:07.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895 
(rev 01)
         Subsystem: Hewlett-Packard Company: Unknown device 1000
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 247 (7500ns min, 16000ns max), Cache Line Size: 0x08 
(32 bytes)
         Interrupt: pin A routed to IRQ 18
         Region 0: I/O ports at 1800 [size=256]
         Region 1: Memory at 40000100 (32-bit, non-prefetchable) 
[size=256]
         Region 2: Memory at 40002000 (32-bit, non-prefetchable) 
[size=4K]

0000:01:07.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895 
(rev 01)
         Subsystem: Hewlett-Packard Company: Unknown device 1000
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 247 (7500ns min, 16000ns max), Cache Line Size: 0x08 
(32 bytes)
         Interrupt: pin A routed to IRQ 18
         Region 0: I/O ports at a400 [size=256]
         Region 1: Memory at fa102400 (32-bit, non-prefetchable) 
[size=256]
         Region 2: Memory at fa101000 (32-bit, non-prefetchable) 
[size=4K]

0000:02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 
Host Controller (rev 46) (prog-if 10 [OHCI])
         Subsystem: AFAVLAB Technology Inc: Unknown device 3044
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (8000ns max), Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 18
         Region 0: Memory at fa201000 (32-bit, non-prefetchable) 
[size=2K]
         Region 1: I/O ports at b400 [size=128]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:04.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / 
AIC-7881U (rev 01)
         Subsystem: Adaptec AHA-2940UW SCSI Host Adapter
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2000ns min, 2000ns max), Cache Line Size: 0x08 (32 
bytes)
         Interrupt: pin A routed to IRQ 19
         Region 0: I/O ports at b000 [disabled] [size=256]
         Region 1: Memory at fa200000 (32-bit, non-prefetchable) 
[size=4K]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-


----



borealis:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 550.052
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1097.72

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 550.052
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1097.72


----


Thanks so much for your replies; if there's anything else you might 
need, please let me know.

--Andrew Feldhacker

