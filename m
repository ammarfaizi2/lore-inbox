Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbUE1KWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbUE1KWg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 06:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUE1KWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 06:22:36 -0400
Received: from wasp.conceptual.net.au ([203.190.192.17]:26788 "EHLO
	wasp.net.au") by vger.kernel.org with ESMTP id S261998AbUE1KV7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 06:21:59 -0400
Message-ID: <40B712CC.60303@wasp.net.au>
Date: Fri, 28 May 2004 14:22:04 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_wasp.net.au-3272-1085739716-0001-2"
To: Brad Campbell <brad@wasp.net.au>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: libata Promise driver regression 2.6.5->2.6.6 (now 2.6.7-rc1-bk4)
References: <A6974D8E5F98D511BB910002A50A6647615FB7A9@hdsmsx403.hd.intel.com> <1084820518.12349.347.camel@dhcppc4> <40A90EE2.3040507@wasp.net.au> <40A91410.5040408@pobox.com> <40AA3844.9010403@wasp.net.au> <40AA4585.4060301@pobox.com> <40AB5E81.4050301@wasp.net.au>
In-Reply-To: <40AB5E81.4050301@wasp.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_wasp.net.au-3272-1085739716-0001-2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Brad Campbell wrote:
> Jeff Garzik wrote:
> 
>> Interesting.
>>
>> Well since it's not global behavior, but isolated to one port or card, 
>> I still worry about non-libata things:
>> 1) is a SATA cable bad, or not plugged in well?  I'm finding that it's 
>> easier to screw up SATA cabling than PATA.  It's more-convenient 
>> design is also less rugged.
> 
> 
> Nup, all seated fine and working perfectly well (and I mean raid-5 
> across all 10 disks and spraying
> data at maximum PCI speed for 8 hours at a time well) with 2.6.5, and 
> they are Supermicro cables
> SATA cables with a pair of 5 bay Supermicro Hotswap bays so the quality 
> is pretty good.
> 
>> 2) is a PCI slot bad, or not busmastering like it should?  have you 
>> tried moving the card to another PCI slot?

Ok, I have now reproduced this on another system. (New SATA cable and Drive)
I took all three cards and plugged them into another system, as I don't have another 3 cards to spare!
It is 100% reproducible if any drive is plugged into the last card to get initialised. I am testing 
it now with three cards and 1 SATA hard disk.

If I plug the drive into any of the ports on the first 2 cards, it boots and all is happy. If a 
drive is plugged into the last card it locks on bootup as before.

As before, a Vanilla 2.6.5 works perfectly.

This is the same set of cards, however I have shuffled them around and into different slots to try 
and isolate the fault to a card. Unfortunately they all work perfectly under Vanilla 2.6.5 and it's 
always the last initialised card that causes the problem, no matter what slot/irq/physical card it is.

I'm happy to do some more testing as I now have both systems in bits.

Both machines are VIA KT600 chips, I have a Gigabyte GA-7VT600 and an ASUS A7V600. I have removed 
most of the other cards and have played with these Promise controllers in both of them. The problem 
follows the kernel. 2.6.5 works perfectly on both machines. 2.6.5 with the patch you sent me to 
update libata locks the same way on both machines.

I have tried with acpi=off, noacpi, apic=off, noapic and all combinations of. The problem still 
persists.

I have attached 3 serial console boot outputs, one where the drive was plugged into each card.

Anything else I can do?

Regards,
Brad

--=_wasp.net.au-3272-1085739716-0001-2
Content-Type: text/plain; name="dmesg-1.log"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-1.log"

Linux version 2.6.7-rc1-bk4 (brad@srv) (gcc version 3.3.3 (Debian 20040401)) #5 Thu May 27 17:55:39 GST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f4d10
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 GBT                                       ) @ 0x000f6680
ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x1fff3000
ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x1fff3040
ACPI: MADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x1fff7380
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/nfs video=matroxfb:xres:1024,yres:768,pixclock:15386,left:160,right:24,upper:29,lower:3,hslen:132,vslen:6,depth:8 nfsroot=192.168.2.82:/nfsroot ip=192.168.2.81:192.168.2.82::255.255.255.0:tv init=/bin/sh console=ttyS0,38400n8 console=tty0 BOOT_I
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2086.802 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 515672k/524224k available (1989k kernel code, 7788k reserved, 1131k data, 148k init, 0k highmem)
Checking if this processor honours the WP bit eiven in supervise... Ok.
Calibrating delay loop... 4112.38 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2800+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2086.0199 MHz.
..... host bus clock speed is 333.0791 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfa0f0, last bus=1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 *14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 14 *15)
ACPI: PCI Interrupt Link [ALKA] (IRQs 20) *0
ACPI: PCI Interrupt Link [ALKB] (IRQs 21) *0
ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *0
ACPI: PCI Interrupt Link [ALKD] (IRQs 23) *0
SCSI subsystem initialized
ACPI: PCI Interrupt Link [ALKB] BIOS reported IRQ 0, using IRQ 21
ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 21
ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ 0, using IRQ 20
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
ACPI: PCI Interrupt Link [ALKC] BIOS reported IRQ 0, using IRQ 22
ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 22
ACPI: PCI Interrupt Link [ALKD] BIOS reported IRQ 0, using IRQ 23
ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 23
testing the IO APIC.......................
.................................... done.
PCI: Using ACPI for IRQ routing
Machine check exception polling timer started.
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
PCI: Via IRQ fixup for 0000:00:10.0, from 10 to 5
PCI: Via IRQ fixup for 0000:00:10.1, from 10 to 5
PCI: Via IRQ fixup for 0000:00:10.2, from 14 to 5
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Reset done....................................................................................................................................................................................................;
Clear Reset.........................................................................................................................................................................................................................................................................................................................................................................................................;
pci_cor : reg = 0x0 - FFFB772C - FFFB7538
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ata1: SATA max UDMA/133 cmd 0xE080A200 ctl 0xE080A238 bmdma 0x0 irq 18
ata2: SATA max UDMA/133 cmd 0xE080A280 ctl 0xE080A2B8 bmdma 0x0 irq 18
ata3: SATA max UDMA/133 cmd 0xE080A300 ctl 0xE080A338 bmdma 0x0 irq 18
ata4: SATA max UDMA/133 cmd 0xE080A380 ctl 0xE080A3B8 bmdma 0x0 irq 18
ata1: no device found (phy stat 00000000)
scsi0 : sata_promise
ata2: no device found (phy stat 00000000)
scsi1 : sata_promise
ata3: no device found (phy stat 00000000)
scsi2 : sata_promise
ata4: no device found (phy stat 00000000)
scsi3 : sata_promise
Using anticipatory io scheduler
ata5: SATA max UDMA/133 cmd 0xE080C200 ctl 0xE080C238 bmdma 0x0 irq 19
ata6: SATA max UDMA/133 cmd 0xE080C280 ctl 0xE080C2B8 bmdma 0x0 irq 19
ata7: SATA max UDMA/133 cmd 0xE080C300 ctl 0xE080C338 bmdma 0x0 irq 19
ata8: SATA max UDMA/133 cmd 0xE080C380 ctl 0xE080C3B8 bmdma 0x0 irq 19
ata5: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata5: dev 0 configured for UDMA/133
scsi4 : sata_promise
ata6: no device found (phy stat 00000000)
scsi5 : sata_promise
ata7: no device found (phy stat 00000000)
scsi6 : sata_promise
ata8: no device found (phy stat 00000000)
scsi7 : sata_promise
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata9: SATA max UDMA/133 cmd 0xE080E200 ctl 0xE080E238 bmdma 0x0 irq 16
ata10: SATA max UDMA/133 cmd 0xE080E280 ctl 0xE080E2B8 bmdma 0x0 irq 16
ata11: SATA max UDMA/133 cmd 0xE080E300 ctl 0xE080E338 bmdma 0x0 irq 16
ata12: SATA max UDMA/133 cmd 0xE080E380 ctl 0xE080E3B8 bmdma 0x0 irq 16
ata9: no device found (phy stat 00000000)
scsi8 : sata_promise
ata10: no device found (phy stat 00000000)
scsi9 : sata_promise
ata11: no device found (phy stat 00000000)
scsi10 : sata_promise
ata12: no device found (phy stat 00000000)
scsi11 : sata_promise
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host4/bus0/target0/lun0: p1
Attached scsi disk sda at scsi4, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi4, channel 0, id 0, lun 0,  type 0
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
i2c /dev entries driver
md: raid0 personality registered as nr 2
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  2276.000 MB/sec
   8regs_prefetch:  2876.000 MB/sec
   32regs    :  1752.000 MB/sec
   32regs_prefetch:  2108.000 MB/sec
   pIII_sse  :  5612.000 MB/sec
   pII_mmx   :  5592.000 MB/sec
   p5_mmx    :  7428.000 MB/sec
raid5: using function: pIII_sse (5612.000 MB/sec)
raid6: int32x1    839 MB/s
raid6: int32x2   1136 MB/s
raid6: int32x4    730 MB/s
raid6: int32x8    660 MB/s
raid6: mmxx1     1734 MB/s
raid6: mmxx2     3136 MB/s
raid6: sse1x1    1648 MB/s
raid6: sse1x2    2726 MB/s
raid6: using algorithm sse1x2 (2726 MB/s)
md: raid6 personality registered as nr 8
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
VFS: Cannot open root device "nfs" or unknown-block(0,255)
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on unknown-block(0,255)
 <6>SysRq : Resetting


Linux version 2.6.7-rc1-bk4 (brad@srv) (gcc version 3.3.3 (Debian 20040401)) #5 Thu May 27 17:55:39 GST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f4d10
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 GBT                                       ) @ 0x000f6680
ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x1fff3000
ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x1fff3040
ACPI: MADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x1fff7380
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/nfs video=matroxfb:xres:1024,yres:768,pixclock:15386,left:160,right:24,upper:29,lower:3,hslen:132,vslen:6,depth:8 nfsroot=192.168.2.82:/nfsroot ip=192.168.2.81:192.168.2.82::255.255.255.0:tv init=/bin/sh console=ttyS0,38400n8 console=tty0 BOOT_I
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2086.802 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 515672k/524224k available (1989k kernel code, 7788k reserved, 1131k data, 148k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4112.38 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2800+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2086.0199 MHz.
..... host bus clock speed is 333.0791 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfa0f0, last bus=1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 *14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 14 *15)
ACPI: PCI Interrupt Link [ALKA] (IRQs 20) *0
ACPI: PCI Interrupt Link [ALKB] (IRQs 21) *0
ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *0
ACPI: PCI Interrupt Link [ALKD] (IRQs 23) *0
SCSI subsystem initialized
ACPI: PCI Interrupt Link [ALKB] BIOS reported IRQ 0, using IRQ 21
ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 21
ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ 0, using IRQ 20
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
ACPI: PCI Interrupt Link [ALKC] BIOS reported IRQ 0, using IRQ 22
ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 22
ACPI: PCI Interrupt Link [ALKD] BIOS reported IRQ 0, using IRQ 23
ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 23
testing the IO APIC.......................
.................................... done.
PCI: Using ACPI for IRQ routing
Machine check exception polling timer started.
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
PCI: Via IRQ fixup for 0000:00:10.0, from 10 to 5
PCI: Via IRQ fixup for 0000:00:10.1, from 10 to 5
PCI: Via IRQ fixup for 0000:00:10.2, from 14 to 5
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Reset done....................................................................................................................................................................................................;
Clear Reset........................................................................................................................................................................................................................................................................................................................................................................................................;
pci_cor : reg = 0x0 - FFFB7AD9 - FFFB78E5
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ata1: SATA max UDMA/133 cmd 0xE080A200 ctl 0xE080A238 bmdma 0x0 irq 18
ata2: SATA max UDMA/133 cmd 0xE080A280 ctl 0xE080A2B8 bmdma 0x0 irq 18
ata3: SATA max UDMA/133 cmd 0xE080A300 ctl 0xE080A338 bmdma 0x0 irq 18
ata4: SATA max UDMA/133 cmd 0xE080A380 ctl 0xE080A3B8 bmdma 0x0 irq 18
ata1: no device found (phy stat 00000000)
scsi0 : sata_promise
ata2: no device found (phy stat 00000000)
scsi1 : sata_promise
ata3: no device found (phy stat 00000000)
scsi2 : sata_promise
ata4: no device found (phy stat 00000000)
scsi3 : sata_promise
Using anticipatory io scheduler
ata5: SATA max UDMA/133 cmd 0xE080C200 ctl 0xE080C238 bmdma 0x0 irq 19
ata6: SATA max UDMA/133 cmd 0xE080C280 ctl 0xE080C2B8 bmdma 0x0 irq 19
ata7: SATA max UDMA/133 cmd 0xE080C300 ctl 0xE080C338 bmdma 0x0 irq 19
ata8: SATA max UDMA/133 cmd 0xE080C380 ctl 0xE080C3B8 bmdma 0x0 irq 19
ata5: no device found (phy stat 00000000)
scsi4 : sata_promise
ata6: no device found (phy stat 00000000)
scsi5 : sata_promise
ata7: no device found (phy stat 00000000)
scsi6 : sata_promise
ata8: no device found (phy stat 00000000)
scsi7 : sata_promise
ata9: SATA max UDMA/133 cmd 0xE080E200 ctl 0xE080E238 bmdma 0x0 irq 16
ata10: SATA max UDMA/133 cmd 0xE080E280 ctl 0xE080E2B8 bmdma 0x0 irq 16
ata11: SATA max UDMA/133 cmd 0xE080E300 ctl 0xE080E338 bmdma 0x0 irq 16
ata12: SATA max UDMA/133 cmd 0xE080E380 ctl 0xE080E3B8 bmdma 0x0 irq 16
ata9: no device found (phy stat 00000000)
scsi8 : sata_promise
ata10: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata10: dev 0 configured for UDMA/133
scsi9 : sata_promise
ata11: no device found (phy stat 00000000)
scsi10 : sata_promise
ata12: no device found (phy stat 00000000)
scsi11 : sata_promise
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host9/bus0/target0/lun0:
 
Linux version 2.6.7-rc1-bk4 (brad@srv) (gcc version 3.3.3 (Debian 20040401)) #5 Thu May 27 17:55:39 GST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f4d10
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 GBT                                       ) @ 0x000f6680
ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x1fff3000
ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x1fff3040
ACPI: MADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x1fff7380
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/nfs video=matroxfb:xres:1024,yres:768,pixclock:15386,left:160,right:24,upper:29,lower:3,hslen:132,vslen:6,depth:8 nfsroot=192.168.2.82:/nfsroot ip=192.168.2.81:192.168.2.82::255.255.255.0:tv init=/bin/sh console=ttyS0,38400n8 console=tty0 BOOT_I
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2086.802 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 515672k/524224k available (1989k kernel code, 7788k reserved, 1131k data, 148k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4112.38 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2800+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2086.0199 MHz.
..... host bus clock speed is 333.0792 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfa0f0, last bus=1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 *14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 11 12 14 *15)
ACPI: PCI Interrupt Link [ALKA] (IRQs 20) *0
ACPI: PCI Interrupt Link [ALKB] (IRQs 21) *0
ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *0
ACPI: PCI Interrupt Link [ALKD] (IRQs 23) *0
SCSI subsystem initialized
ACPI: PCI Interrupt Link [ALKB] BIOS reported IRQ 0, using IRQ 21
ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 21
ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ 0, using IRQ 20
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
ACPI: PCI Interrupt Link [ALKC] BIOS reported IRQ 0, using IRQ 22
ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 22
ACPI: PCI Interrupt Link [ALKD] BIOS reported IRQ 0, using IRQ 23
ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 23
testing the IO APIC.......................
.................................... done.
PCI: Using ACPI for IRQ routing
Machine check exception polling timer started.
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
PCI: Via IRQ fixup for 0000:00:10.0, from 10 to 5
PCI: Via IRQ fixup for 0000:00:10.1, from 10 to 5
PCI: Via IRQ fixup for 0000:00:10.2, from 14 to 5
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Reset done....................................................................................................................................................................................................;
Clear Reset........................................................................................................................................................................................................................................................................................................................................................................................................;
pci_cor : reg = 0x0 - FFFB75D8 - FFFB73E4
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ata1: SATA max UDMA/133 cmd 0xE080A200 ctl 0xE080A238 bmdma 0x0 irq 18
ata2: SATA max UDMA/133 cmd 0xE080A280 ctl 0xE080A2B8 bmdma 0x0 irq 18
ata3: SATA max UDMA/133 cmd 0xE080A300 ctl 0xE080A338 bmdma 0x0 irq 18
ata4: SATA max UDMA/133 cmd 0xE080A380 ctl 0xE080A3B8 bmdma 0x0 irq 18
ata1: no device found (phy stat 00000000)
scsi0 : sata_promise
ata2: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_promise
ata3: no device found (phy stat 00000000)
scsi2 : sata_promise
ata4: no device found (phy stat 00000000)
scsi3 : sata_promise
Using anticipatory io scheduler
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata5: SATA max UDMA/133 cmd 0xE080C200 ctl 0xE080C238 bmdma 0x0 irq 19
ata6: SATA max UDMA/133 cmd 0xE080C280 ctl 0xE080C2B8 bmdma 0x0 irq 19
ata7: SATA max UDMA/133 cmd 0xE080C300 ctl 0xE080C338 bmdma 0x0 irq 19
ata8: SATA max UDMA/133 cmd 0xE080C380 ctl 0xE080C3B8 bmdma 0x0 irq 19
ata5: no device found (phy stat 00000000)
scsi4 : sata_promise
ata6: no device found (phy stat 00000000)
scsi5 : sata_promise
ata7: no device found (phy stat 00000000)
scsi6 : sata_promise
ata8: no device found (phy stat 00000000)
scsi7 : sata_promise
ata9: SATA max UDMA/133 cmd 0xE080E200 ctl 0xE080E238 bmdma 0x0 irq 16
ata10: SATA max UDMA/133 cmd 0xE080E280 ctl 0xE080E2B8 bmdma 0x0 irq 16
ata11: SATA max UDMA/133 cmd 0xE080E300 ctl 0xE080E338 bmdma 0x0 irq 16
ata12: SATA max UDMA/133 cmd 0xE080E380 ctl 0xE080E3B8 bmdma 0x0 irq 16
ata9: no device found (phy stat 00000000)
scsi8 : sata_promise
ata10: no device found (phy stat 00000000)
scsi9 : sata_promise
ata11: no device found (phy stat 00000000)
scsi10 : sata_promise
ata12: no device found (phy stat 00000000)
scsi11 : sata_promise
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host1/bus0/target0/lun0: p1
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 0
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
i2c /dev entries driver
md: raid0 personality registered as nr 2
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  2280.000 MB/sec
   8regs_prefetch:  2876.000 MB/sec
   32regs    :  1752.000 MB/sec
   32regs_prefetch:  2108.000 MB/sec
   pIII_sse  :  5612.000 MB/sec
   pII_mmx   :  5592.000 MB/sec
   p5_mmx    :  7428.000 MB/sec
raid5: using function: pIII_sse (5612.000 MB/sec)
raid6: int32x1    839 MB/s
raid6: int32x2   1132 MB/s
raid6: int32x4    730 MB/s
raid6: int32x8    660 MB/s
raid6: mmxx1     1734 MB/s
raid6: mmxx2     3136 MB/s
raid6: sse1x1    1648 MB/s
raid6: sse1x2    2726 MB/s
raid6: using algorithm sse1x2 (2726 MB/s)
md: raid6 personality registered as nr 8
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
VFS: Cannot open root device "nfs" or unknown-block(0,255)
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on unknown-block(0,255)
 

--=_wasp.net.au-3272-1085739716-0001-2--
