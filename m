Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWJISq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWJISq7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 14:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbWJISq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 14:46:59 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:45002 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932236AbWJISq6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 14:46:58 -0400
Date: Mon, 9 Oct 2006 11:46:48 -0700
From: Sukadev Bhattiprolu <sukadev@us.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Martin Bligh <mbligh@mbligh.org>, Badari Pulavarty <pbadari@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: Panic in pci_call_probe from 2.6.18-mm2 and 2.6.18-mm3
Message-ID: <20061009184648.GA21207@us.ibm.com>
References: <4528A26F.9000804@mbligh.org> <1160414389.17103.7.camel@dyn9047017100.beaverton.ibm.com> <452A85D8.70806@mbligh.org> <452A881E.40706@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <452A881E.40706@pobox.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Jeff Garzik [jgarzik@pobox.com] wrote:
| Martin Bligh wrote:
| >Badari Pulavarty wrote:
| >>On Sun, 2006-10-08 at 00:02 -0700, Martin J. Bligh wrote:
| >>
| >>>Not sure if you've seen this already ... catching up on test results.
| >>>
| >>>This was on NUMA-Q, on both -mm2 and -mm3. -mm1 didn't suffer from this
| >>>problem.
| >>>
| >>>Full logs:
| >>>
| >>>mm2 - http://test.kernel.org/abat/50727/debug/console.log
| >>>mm3 - http://test.kernel.org/abat/51442/debug/console.log
| >>>
| >>>config - http://test.kernel.org/abat/51442/build/dotconfig
| >>>
| >>>I'm guessing from the 00000004 that the pcibus_to_node(dev->bus)
| >>>is failing because bus->sysdata is NULL. The disassembly and
| >>>structure offsets seem to line up for that.
| >>>
| >>>#define pcibus_to_node(bus) (
| >>>    (struct pci_sysdata *)((bus)->sysdata))->node
| >>>
| >>>struct pci_sysdata {
| >>>        int             domain;         /* PCI domain */
| >>>        int             node;           /* NUMA node */
| >>>};
| >>>
| >>
| >>
| >>Martin,
| >>
| >>Jeff moved "node" to a proper field in sysdata, instead
| >>of overloading sysdata itself. I think this is causing the
| >>problem. I guess we could end up with sysdata = NULL in some
| >>cases ? Since you are the NUMA-Q expert, where does sysdata gets set 
| >>for NUMA-Q ? :)
| >>
| >>-mm2 changed:
| >>
| >>#define pcibus_to_node(bus) ((long) (bus)->sysdata)
| >>
| >>to
| >>#define pcibus_to_node(bus) ((struct pci_sysdata *)((bus)->sysdata))-
| >>
| >>>node
| >
| >Buggered if I know, that's some strange pci thing ;-)
| >
| >But can we revert whatever patch that was until it gets fixed, please?
| 
| It needs to get fixed, otherwise whose buses of PCI devices disappear on 
| some machines.
| 
| Can you turn on PCI debugging?
| 
| 	Jeff

I turned on CONFIG_PCI_DEBUG. already had CONFIG_KERNEL_DEBUG and
CONFIG_DEBUG_INFO. Booted with "debug" parameter.

Here are the last few messages. Complete dmesg attached.

Let me know if there are other config tokens or boot options that may
provide more info.

Suka
---

PCI: Calling quirk c024da00 for 0000:00:0a.0
PCI: Calling quirk c031ce30 for 0000:00:0a.0
PCI: Calling quirk c024da00 for 0000:00:0b.0
PCI: Calling quirk c031ce30 for 0000:00:0b.0
PCI: Calling quirk c024da00 for 0000:00:0e.0
PCI: Calling quirk c031ce30 for 0000:00:0e.0
PCI: Calling quirk c024da00 for 0000:00:0e.1
PCI: Calling quirk c031ce30 for 0000:00:0e.1
PCI: Calling quirk c024da00 for 0000:00:0e.2
PCI: Calling quirk c031ce30 for 0000:00:0e.2
PCI: Calling quirk c024da00 for 0000:00:0e.3
PCI: Calling quirk c031ce30 for 0000:00:0e.3
PCI: Calling quirk c024da00 for 0000:00:10.0
PCI: Calling quirk c031ce30 for 0000:00:10.0
PCI: Calling quirk c024da00 for 0000:00:12.0
PCI: Calling quirk c05093b0 for 0000:00:12.0
PCI: Calling quirk c031ce30 for 0000:00:12.0
PCI: Calling quirk c024da00 for 0000:00:14.0
PCI: Calling quirk c05093b0 for 0000:00:14.0
PCI: Calling quirk c031ce30 for 0000:00:14.0
PCI: Calling quirk c024da00 for 0000:01:0c.0
PCI: Calling quirk c031ce30 for 0000:01:0c.0
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 7.2.9-k2
Copyright (c) 1999-2006 Intel Corporation.
BUG: unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c024e92c
*pde = 00529001
*pte = 00000000
Oops: 0000 [#1]
SMP

last sysfs file:
Modules linked in:
CPU:    0
EIP:    0060:[<c024e92c>]    Not tainted VLI
EFLAGS: 00010286   (2.6.18-mm3 #3)
EIP is at pci_call_probe+0x1c/0xe0
eax: 00000000   ebx: dfe63c00   ecx: c10fca90   edx: c048ad60
esi: dfe63c00   edi: 0000000f   ebp: dfc3fd00   esp: c10ffe70
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, ti=c10fe000 task=c10fca90 task.ti=c10fe000)
Stack: dfe63c00 ffffffed ffffffed dfe63c00 c048b1c0 c024ea55 c048b1c0 dfe63c00
       c048ad60 c048b1c0 dfe63c00 c048b1f4 c024ea9f c048b1c0 dfe63c00 dfe63c48
       dfc3fd00 c02761f9 dfe63c48 00000286 dfff9060 000000d0 c048b1f4 dfc3fd00
Call Trace:
 [<c024ea55>] __pci_device_probe+0x65/0x80
 [<c024ea9f>] pci_device_probe+0x2f/0x50
 [<c02761f9>] really_probe+0xf9/0x100
 [<c02762e8>] driver_probe_device+0xc8/0xe0
 [<c03ae92d>] klist_next+0x5d/0xa0
 [<c02763a0>] __driver_attach+0x0/0xa0
 [<c0276430>] __driver_attach+0x90/0xa0
 [<c0275409>] bus_for_each_dev+0x69/0x80
 [<c0276465>] driver_attach+0x25/0x30
 [<c02763a0>] __driver_attach+0x0/0xa0
 [<c0275ad3>] bus_add_driver+0x73/0x140
 [<c024edc4>] __pci_register_driver+0x74/0x90
 [<c050c6f9>] tulip_init+0x29/0x30
 [<c04f2a62>] do_initcalls+0x42/0x140
 [<c01433eb>] register_irq_proc+0xab/0xd0
 [<c01003f0>] init+0x0/0x1a0
 [<c0143479>] init_irq_proc+0x39/0x50
 [<c01003f0>] init+0x0/0x1a0
 [<c0100451>] init+0x61/0x1a0
 [<c0103c0b>] kernel_thread_helper+0x7/0x1c
 =======================
Code: 74 92 eb 8e 8d 74 26 00 8d bc 27 00 00 00 00 57 56 53 83 ec 08 8b 5c 24 1c 89 e0 25 00 e0 ff ff 8b 08 8b 43 10 8b 79 5c 8b 40 44 <8b> 50 04 85 d2 78 11 0f a3 15 c0 9f 4e c0 19 c0 85 c0 0f 85 8c

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Description: dmesg-3.txt
Content-Disposition: attachment; filename="dmesg-3.txt"


BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end: 000000000009fc00 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 0000000000100000 size: 000000003ff00000 end: 0000000040000000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 00000000fec00000 size: 0000000000009000 end: 00000000fec09000 type: 2
copy_e820_map() start: 00000000ffe80000 size: 0000000000180000 end: 0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 0000000000100000 - 0000000040000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec09000 (reserved)
 BIOS-e820: 00000000ffe80000 - 0000000100000000 (reserved)
Node: 0, start_pfn: 0, end_pfn: 159
  Setting physnode_map array to node 0 for pfns:
  0
Node: 0, start_pfn: 256, end_pfn: 262144
  Setting physnode_map array to node 0 for pfns:
  256 65792 131328 196864
Node: 0, start_pfn: 0, end_pfn: 262144
  Setting physnode_map array to node 0 for pfns:
  0 65536 131072 196608
Reserving 2560 pages of KVA for lmem_map of node 0
Shrinking node 0 from 262144 pages to 259584 pages
Reserving total of 2560 pages for numa KVA remap
kva_start_pfn ~ 226816 find_max_low_pfn() ~ 229376
max_pfn = 262144
128MB HIGHMEM available.
896MB LOWMEM available.
min_low_pfn = 1385, max_low_pfn = 229376, highstart_pfn = 229376
Low memory ends at vaddr f8000000
node 0 will remap to vaddr f7600000 - f8a00000
High memory starts at vaddr f8000000
found SMP MP-table at 000f6040
Entering add_active_range(0, 0, 259584) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   262144
early_node_map[1] active PFN ranges
    0:        0 ->   259584
On node 0 totalpages: 259584
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 236 pages used for memmap
  HighMem zone: 29972 pages, LIFO batch:7
DMI not present or invalid.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: IBM NUMA Product ID: SBB          <6>Found an OEM MPC table at 1fff82a8- parsing it ...
Translation: record 0, type 1, quad 0, global 3, local 3
Translation: record 1, type 1, quad 0, global 1, local 1
Translation: record 2, type 1, quad 0, global 1, local 1
Translation: record 3, type 1, quad 0, global 1, local 1
Translation: record 4, type 3, quad 0, global 0, local 0
Translation: record 5, type 3, quad 0, global 1, local 1
Translation: record 6, type 4, quad 0, global 2, local 18
Translation: record 7, type 2, quad 0, global 13, local 14
Translation: record 8, type 2, quad 0, global 14, local 13
APIC at: 0xFEC08000
Processor #0 6:10 APIC version 17 (quad 0, apic 1)
Processor #4 6:10 APIC version 17 (quad 0, apic 8)
Processor #1 6:10 APIC version 17 (quad 0, apic 2)
Processor #2 6:10 APIC version 17 (quad 0, apic 4)
Bus #0 is PCI    (node 0)
Bus #1 is PCI    (node 0)
Bus #2 is EISA   (node 0)
I/O APIC #13 Version 17 at 0xFEC00000.
I/O APIC #14 Version 17 at 0xFEC01000.
Enabling APIC mode:  NUMA-Q.  Using 2 I/O APICs
Processors: 4
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Detected 700.054 MHz processor.
Built 1 zonelists.  Total pages: 257556
Kernel command line: root=/dev/sda1 console=ttyS0,57600 reboot=bios debug
mapped APIC to ffffd000 (fec08000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec01000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Initializing HighMem for node 0 (00038000:0003f600)
Memory: 1022216k/1048576k available (2757k kernel code, 15732k reserved, 1252k data, 216k init, 120832k highmem)
virtual kernel memory layout:
    fixmap  : 0xffe1c000 - 0xfffff000   (1932 kB)
    pkmap   : 0xffc00000 - 0xffe00000   (2048 kB)
    vmalloc : 0xf8800000 - 0xffbfe000   ( 115 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc04f2000 - 0xc0528000   ( 216 kB)
      .data : 0xc03b16ac - 0xc04eaa4c   (1252 kB)
      .text : 0xc0100000 - 0xc03b16ac   (2757 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1401.31 BogoMIPS (lpj=2802636)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0387fbff 00000000 00000000 00000000 0000000000000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 16k freed
CPU0: Intel Pentium III (Cascades) stepping 00
Leaving ESR disabled.
Mapping cpu 0 to node 0
Booting processor 1/2 eip 2000
Storing NMI vector
Initializing CPU#1
Leaving ESR disabled.
Mapping cpu 1 to node 0
Calibrating delay using timer specific routine.. 1400.08 BogoMIPS (lpj=2800175)
CPU: After generic identify, caps: 0387fbff 00000000 00000000 00000000 0000000000000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
CPU1: Intel Pentium III (Cascades) stepping 00
Booting processor 2/4 eip 2000
Storing NMI vector
Initializing CPU#2
Leaving ESR disabled.
Mapping cpu 2 to node 0
Calibrating delay using timer specific routine.. 1400.06 BogoMIPS (lpj=2800120)
CPU: After generic identify, caps: 0387fbff 00000000 00000000 00000000 0000000000000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
CPU2: Intel Pentium III (Cascades) stepping 00
Booting processor 3/8 eip 2000
Storing NMI vector
Initializing CPU#3
Leaving ESR disabled.
Mapping cpu 3 to node 0
Calibrating delay using timer specific routine.. 1400.06 BogoMIPS (lpj=2800124)
CPU: After generic identify, caps: 0387fbff 00000000 00000000 00000000 0000000000000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
CPU3: Intel Pentium III (Cascades) stepping 00
Total of 4 processors activated (5601.52 BogoMIPS).
ExtINT not setup in hardware but reported by MP table
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ... failed.
...trying to set up timer as Virtual Wire IRQ... works.
checking TSC synchronization across 4 CPUs: passed.
Brought up 4 CPUs
migration_cost=12000
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd231, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
SCSI subsystem initialized
PCI: Probing PCI hardware (bus 00)
PCI: Scanning bus 0000:00
PCI: Found 0000:00:0a.0 [1077/1020] 000100 00
PCI: Calling quirk c024db60 for 0000:00:0a.0
PCI: Calling quirk c024e240 for 0000:00:0a.0
PCI: Found 0000:00:0b.0 [1002/4750] 000300 00
PCI: Calling quirk c024db60 for 0000:00:0b.0
PCI: Calling quirk c024e240 for 0000:00:0b.0
Boot video device is 0000:00:0b.0
PCI: Found 0000:00:0e.0 [8086/7110] 000601 00
PCI: Calling quirk c024e050 for 0000:00:0e.0
PCI: Calling quirk c024db60 for 0000:00:0e.0
PCI: Calling quirk c024e240 for 0000:00:0e.0
PCI: Found 0000:00:0e.1 [8086/7111] 000101 00
PCI: Calling quirk c024e050 for 0000:00:0e.1
PCI: Calling quirk c024db60 for 0000:00:0e.1
PCI: Calling quirk c024e240 for 0000:00:0e.1
PCI: Found 0000:00:0e.2 [8086/7112] 000c03 00
PCI: Calling quirk c024e050 for 0000:00:0e.2
PCI: Calling quirk c024db60 for 0000:00:0e.2
PCI: Calling quirk c024e240 for 0000:00:0e.2
PCI: Found 0000:00:0e.3 [8086/7113] 000680 00
PCI: Calling quirk c024e050 for 0000:00:0e.3
PCI: Calling quirk c024d150 for 0000:00:0e.3
PCI quirk: region 0c00-0c3f claimed by PIIX4 ACPI
PIIX4 devres C PIO at 007c-007c
PCI: Calling quirk c024db60 for 0000:00:0e.3
PCI: Calling quirk c024e240 for 0000:00:0e.3
PCI: Found 0000:00:10.0 [8086/84ca] 000600 00
PCI: Calling quirk c024e050 for 0000:00:10.0
PCI: Calling quirk c024db60 for 0000:00:10.0
PCI: Calling quirk c024e240 for 0000:00:10.0
PCI: Calling quirk c032f670 for 0000:00:10.0
PCI: Searching for i450NX host bridges on 0000:00:10.0
PCI: Scanning bus 0000:01
PCI: Found 0000:01:0c.0 [1011/0009] 000200 00
PCI: Calling quirk c024db60 for 0000:01:0c.0
PCI: Calling quirk c024e240 for 0000:01:0c.0
PCI: Fixups for bus 0000:01
PCI: Bus scan for 0000:01 returning with max=01
PCI: Found 0000:00:12.0 [8086/84cb] 000600 00
PCI: Calling quirk c024e050 for 0000:00:12.0
PCI: Calling quirk c024db60 for 0000:00:12.0
PCI: Calling quirk c024e240 for 0000:00:12.0
PCI: Found 0000:00:14.0 [8086/84cb] 000600 00
PCI: Calling quirk c024e050 for 0000:00:14.0
PCI: Calling quirk c024db60 for 0000:00:14.0
PCI: Calling quirk c024e240 for 0000:00:14.0
PCI: Fixups for bus 0000:00
PCI: Bus scan for 0000:00 returning with max=00
PCI->APIC IRQ transform: 0000:01:0c.0[A] -> IRQ 40
PCI->APIC IRQ transform: 0000:00:0a.0[A] -> IRQ 23
PCI->APIC IRQ transform: 0000:00:0b.0[A] -> IRQ 19
  got res [50000000:5001ffff] bus [50000000:5001ffff] flags 7202 for BAR 6 of 0000:00:0b.0
  got res [50020000:5002ffff] bus [50020000:5002ffff] flags 7200 for BAR 6 of 0000:00:0a.0
  got res [1000:101f] bus [1000:101f] flags 101 for BAR 4 of 0000:00:0e.2
PCI: moved device 0000:00:0e.2 resource 4 (101) to 1000
  got res [50040000:5007ffff] bus [50040000:5007ffff] flags 7200 for BAR 6 of 0000:01:0c.0
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
JFS: nTxBlock = 7986, nTxLock = 63889
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Calling quirk c024da00 for 0000:00:0a.0
PCI: Calling quirk c031ce30 for 0000:00:0a.0
PCI: Calling quirk c024da00 for 0000:00:0b.0
PCI: Calling quirk c031ce30 for 0000:00:0b.0
PCI: Calling quirk c024da00 for 0000:00:0e.0
PCI: Calling quirk c031ce30 for 0000:00:0e.0
PCI: Calling quirk c024da00 for 0000:00:0e.1
PCI: Calling quirk c031ce30 for 0000:00:0e.1
PCI: Calling quirk c024da00 for 0000:00:0e.2
PCI: Calling quirk c031ce30 for 0000:00:0e.2
PCI: Calling quirk c024da00 for 0000:00:0e.3
PCI: Calling quirk c031ce30 for 0000:00:0e.3
PCI: Calling quirk c024da00 for 0000:00:10.0
PCI: Calling quirk c031ce30 for 0000:00:10.0
PCI: Calling quirk c024da00 for 0000:00:12.0
PCI: Calling quirk c05093b0 for 0000:00:12.0
PCI: Calling quirk c031ce30 for 0000:00:12.0
PCI: Calling quirk c024da00 for 0000:00:14.0
PCI: Calling quirk c05093b0 for 0000:00:14.0
PCI: Calling quirk c031ce30 for 0000:00:14.0
PCI: Calling quirk c024da00 for 0000:01:0c.0
PCI: Calling quirk c031ce30 for 0000:01:0c.0
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 7.2.9-k2
Copyright (c) 1999-2006 Intel Corporation.
BUG: unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c024e92c
*pde = 00529001
*pte = 00000000
Oops: 0000 [#1]
SMP
last sysfs file:
Modules linked in:
CPU:    0
EIP:    0060:[<c024e92c>]    Not tainted VLI
EFLAGS: 00010286   (2.6.18-mm3 #3)
EIP is at pci_call_probe+0x1c/0xe0
eax: 00000000   ebx: dfe63c00   ecx: c10fca90   edx: c048ad60
esi: dfe63c00   edi: 0000000f   ebp: dfc3fd00   esp: c10ffe70
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, ti=c10fe000 task=c10fca90 task.ti=c10fe000)
Stack: dfe63c00 ffffffed ffffffed dfe63c00 c048b1c0 c024ea55 c048b1c0 dfe63c00
       c048ad60 c048b1c0 dfe63c00 c048b1f4 c024ea9f c048b1c0 dfe63c00 dfe63c48
       dfc3fd00 c02761f9 dfe63c48 00000286 dfff9060 000000d0 c048b1f4 dfc3fd00
Call Trace:
 [<c024ea55>] __pci_device_probe+0x65/0x80
 [<c024ea9f>] pci_device_probe+0x2f/0x50
 [<c02761f9>] really_probe+0xf9/0x100
 [<c02762e8>] driver_probe_device+0xc8/0xe0
 [<c03ae92d>] klist_next+0x5d/0xa0
 [<c02763a0>] __driver_attach+0x0/0xa0
 [<c0276430>] __driver_attach+0x90/0xa0
 [<c0275409>] bus_for_each_dev+0x69/0x80
 [<c0276465>] driver_attach+0x25/0x30
 [<c02763a0>] __driver_attach+0x0/0xa0
 [<c0275ad3>] bus_add_driver+0x73/0x140
 [<c024edc4>] __pci_register_driver+0x74/0x90
 [<c050c6f9>] tulip_init+0x29/0x30
 [<c04f2a62>] do_initcalls+0x42/0x140
 [<c01433eb>] register_irq_proc+0xab/0xd0
 [<c01003f0>] init+0x0/0x1a0
 [<c0143479>] init_irq_proc+0x39/0x50
 [<c01003f0>] init+0x0/0x1a0
 [<c0100451>] init+0x61/0x1a0
 [<c0103c0b>] kernel_thread_helper+0x7/0x1c
 =======================
Code: 74 92 eb 8e 8d 74 26 00 8d bc 27 00 00 00 00 57 56 53 83 ec 08 8b 5c 24 1c 89 e0 25 00 e0 ff ff 8b 08 8b 43 10 8b 79 5c 8b 40 44 <8b> 50 04 85 d2 78 11 0f a3 15 c0 9f 4e c0 19 c0 85 c0 0f 85 8c
EIP: [<c024e92c>] pci_call_probe+0x1c/0xe0 SS:ESP 0068:c10ffe70
 <0>Kernel panic - not syncing: Attempted to kill init!


--wRRV7LY7NUeQGEoC--
