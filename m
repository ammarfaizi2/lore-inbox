Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWAJM3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWAJM3Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 07:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWAJM3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 07:29:16 -0500
Received: from tornado.reub.net ([202.89.145.182]:62600 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1750727AbWAJM3O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 07:29:14 -0500
Message-ID: <43C3A85A.7000003@reub.net>
Date: Wed, 11 Jan 2006 01:28:10 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060109)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2
References: <20060107052221.61d0b600.akpm@osdl.org> <43BFD8C1.9030404@reub.net> <20060107133103.530eb889.akpm@osdl.org> <43C38932.7070302@reub.net> <20060110104759.GA30546@elte.hu>
In-Reply-To: <20060110104759.GA30546@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2006 11:47 p.m., Ingo Molnar wrote:
> * Reuben Farrelly <reuben-lkml@reub.net> wrote:
> 
>>> Don't know, sorry.  But this kernel had oopsed, hadn't it?
>> This one is still present in -git6.  The symptoms are that the kernel 
>> boots up, the userspace applications start launching as the system 
>> starts to go to runlevel 3, and then the system 'blocks' on 
>> $random_service (clamd, mysql and vsftp and others).  I've left it for 
>> 5 mins and it never continued on..
>>
>> There's no oops, and nothing seems to be logged about it, I can hit 
>> enter and the console jumps to a new line, so the machine doesn't lock 
>> up hard, it seems to be getting 'stuck'.
> 
> could you please also send me a SysRq-T (showTasks) output? [which will 
> also include all the stacktraces] (Please make sure you have 
> KALLSYMS_ALL enabled.)

Ok here's the latest one, this time with KALLSYMS_ALL, CONFIG_FRAME_POINTER, 
CONFIG_DETECT_SOFTLOCKUP and the DEBUG_WARN_ON(current->state != TASK_RUNNING); 
patch from Ingo.

Linux version 2.6.15-git6 (root@tornado.reub.net) (gcc version 4.1.0 20060106 
(Red Hat 4.1.0-0.14)) #1 SMP Wed Jan 11 01:12:07 NZDT 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003fe2f800 (usable)
  BIOS-e820: 000000003fe2f800 - 000000003fe3f8e3 (ACPI NVS)
  BIOS-e820: 000000003ff2f800 - 000000003ff30000 (ACPI NVS)
  BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
  BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
  BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
  BIOS-e820: 00000000fed13000 - 00000000fed1a000 (reserved)
  BIOS-e820: 00000000fed1c000 - 00000000feda0000 (reserved)
126MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
DMI 2.3 present.
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Built 1 zonelists
Kernel command line: ro root=/dev/md0 panic=60 console=ttyS0,57600
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c043f000 soft=c043d000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2800.394 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1033336k/1046716k available (2185k kernel code, 12728k reserved, 900k 
data, 204k init, 129212k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5611.90 BogoMIPS (lpj=11223811)
Mount-cache hash table entries: 512
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 04
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c0440000 soft=c043e000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5600.73 BogoMIPS (lpj=11201467)
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 04
Total of 2 processors activated (11212.63 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: Power Resource [URP2] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
   IO window: disabled.
   MEM window: ffa00000-ffafffff
   PREFETCH window: fdf00000-fdffffff
PCI: Bridge: 0000:00:1c.0
   IO window: disabled.
   MEM window: ff600000-ff6fffff
   PREFETCH window: fdb00000-fdbfffff
PCI: Bridge: 0000:00:1c.1
   IO window: a000-afff
   MEM window: ff700000-ff7fffff
   PREFETCH window: fdc00000-fdcfffff
PCI: Bridge: 0000:00:1c.2
   IO window: disabled.
   MEM window: ff800000-ff8fffff
   PREFETCH window: fdd00000-fddfffff
PCI: Bridge: 0000:00:1c.3
   IO window: disabled.
   MEM window: ff900000-ff9fffff
   PREFETCH window: fde00000-fdefffff
PCI: Bridge: 0000:00:1e.0
   IO window: b000-bfff
   MEM window: ff500000-ff5fffff
   PREFETCH window: fe000000-fe7fffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 177
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 185
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 193
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
assign_interrupt_mode Found MSI capability
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 177
assign_interrupt_mode Found MSI capability
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 169
assign_interrupt_mode Found MSI capability
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 185
assign_interrupt_mode Found MSI capability
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 193
assign_interrupt_mode Found MSI capability
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Processor [CPU2] (supports 8 throttling states)
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ÿserial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt 0000:06:02.0[A] -> GSI 18 (level, low) -> IRQ 185
0000:06:02.0: ttyS1 at I/O 0xbc00 (irq = 185) is a 16550A
0000:06:02.0: ttyS2 at I/O 0xbc08 (irq = 185) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 17 (level, low) -> IRQ 177
sky2 v0.11 addr 0xff720000 irq 177 Yukon-EC (0xb6) rev 1
sky2 eth0: addr 00:11:11:43:05:2f
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 193
ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq led slum part
ata1: SATA max UDMA/133 cmd 0xF8804D00 ctl 0x0 bmdma 0x0 irq 193
ata2: SATA max UDMA/133 cmd 0xF8804D80 ctl 0x0 bmdma 0x0 irq 193
ata3: SATA max UDMA/133 cmd 0xF8804E00 ctl 0x0 bmdma 0x0 irq 193
ata4: SATA max UDMA/133 cmd 0xF8804E80 ctl 0x0 bmdma 0x0 irq 193
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 ATA-6, max UDMA/133, 156301488 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : ahci
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 ATA-6, max UDMA/133, 156301488 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : ahci
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 ATA-6, max UDMA/133, 156299375 sectors: LBA48
ata3: dev 0 configured for UDMA/133
scsi2 : ahci
ata4: SATA link down (SStatus 0)
scsi3 : ahci
   Vendor: ATA       Model: ST380817AS        Rev: 3.42
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: ST380817AS        Rev: 3.42
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: ST380013AS        Rev: 3.18
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 >
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
  sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 >
sd 1:0:0:0: Attached scsi disk sdb
SCSI device sdc: 156299375 512-byte hdwr sectors (80025 MB)
sdc: Write Protect is off
SCSI device sdc: drive cache: write back
SCSI device sdc: 156299375 512-byte hdwr sectors (80025 MB)
sdc: Write Protect is off
SCSI device sdc: drive cache: write back
  sdc: sdc1
sd 2:0:0:0: Attached scsi disk sdc
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 2:0:0:0: Attached scsi generic sg2 type 0
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 58
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 58, io mem 0xff4ff800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 58
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 58, io base 0x0000cc00
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 193
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 193, io base 0x0000d000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 185
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 185, io base 0x0000d400
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 169
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 169, io base 0x0000d800
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usb 5-1: new full speed USB device using uhci_hcd and address 2
usb 5-1: configuration #1 chosen from 1 choice
usb 5-2: new full speed USB device using uhci_hcd and address 3
usb 5-2: configuration #1 chosen from 1 choice
hub 5-2:1.0: USB hub found
hub 5-2:1.0: 4 ports detected
usb 5-2.1: new low speed USB device using uhci_hcd and address 4
usb 5-2.1: configuration #1 chosen from 1 choice
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
input: Belkin Components Belkin OmniView KVM Switch as /class/input/input0
input: USB HID v1.00 Keyboard [Belkin Components Belkin OmniView KVM Switch] on 
usb-0000:00:1d.3-2.1
input: Belkin Components Belkin OmniView KVM Switch as /class/input/input1
input: USB HID v1.00 Mouse [Belkin Components Belkin OmniView KVM Switch] on 
usb-0000:00:1d.3-2.1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
md: raid1 personality registered for level 1
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 9, 2621440 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
IPv4 over IPv4 tunneling driver
ip_conntrack version 2.4 (8177 buckets, 65416 max) - 212 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>. 
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Starting balanced_irq
Using IPI Shortcut mode
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb10 ...
md:  adding sdb10 ...
md: sdb7 has different UUID to sdb10
md: sdb6 has different UUID to sdb10
md: sdb5 has different UUID to sdb10
md: sdb3 has different UUID to sdb10
md: sdb2 has different UUID to sdb10
md:  adding sda10 ...
md: sda7 has different UUID to sdb10
md: sda6 has different UUID to sdb10
md: sda5 has different UUID to sdb10
md: sda3 has different UUID to sdb10
md: sda2 has different UUID to sdb10
md: created md5
md: bind<sda10>
md: bind<sdb10>
md: running: <sdb10><sda10>
raid1: raid set md5 active with 2 out of 2 mirrors
md5: bitmap initialized from disk: read 11/11 pages, set 3 bits, status: 0
created bitmap (161 pages) for device md5
md: considering sdb7 ...
md:  adding sdb7 ...
md: sdb6 has different UUID to sdb7
md: sdb5 has different UUID to sdb7
md: sdb3 has different UUID to sdb7
md: sdb2 has different UUID to sdb7
md:  adding sda7 ...
md: sda6 has different UUID to sdb7
md: sda5 has different UUID to sdb7
md: sda3 has different UUID to sdb7
md: sda2 has different UUID to sdb7
md: created md4
md: bind<sda7>
md: bind<sdb7>
md: running: <sdb7><sda7>
raid1: raid set md4 active with 2 out of 2 mirrors
md4: bitmap initialized from disk: read 4/4 pages, set 20 bits, status: 0
created bitmap (61 pages) for device md4
md: considering sdb6 ...
md:  adding sdb6 ...
md: sdb5 has different UUID to sdb6
md: sdb3 has different UUID to sdb6
md: sdb2 has different UUID to sdb6
md:  adding sda6 ...
md: sda5 has different UUID to sdb6
md: sda3 has different UUID to sdb6
md: sda2 has different UUID to sdb6
md: created md3
md: bind<sda6>
md: bind<sdb6>
md: running: <sdb6><sda6>
raid1: raid set md3 active with 2 out of 2 mirrors
md3: bitmap initialized from disk: read 1/1 pages, set 11 bits, status: 0
created bitmap (13 pages) for device md3
md: considering sdb5 ...
md:  adding sdb5 ...
md: sdb3 has different UUID to sdb5
md: sdb2 has different UUID to sdb5
md:  adding sda5 ...
md: sda3 has different UUID to sdb5
md: sda2 has different UUID to sdb5
md: created md2
md: bind<sda5>
md: bind<sdb5>
md: running: <sdb5><sda5>
raid1: raid set md2 active with 2 out of 2 mirrors
md2: bitmap initialized from disk: read 10/10 pages, set 187 bits, status: 0
created bitmap (150 pages) for device md2
md: considering sdb3 ...
md:  adding sdb3 ...
md: sdb2 has different UUID to sdb3
md:  adding sda3 ...
md: sda2 has different UUID to sdb3
md: created md1
md: bind<sda3>
md: bind<sdb3>
md: running: <sdb3><sda3>
raid1: raid set md1 active with 2 out of 2 mirrors
md1: bitmap initialized from disk: read 10/10 pages, set 5 bits, status: 0
created bitmap (150 pages) for device md1
md: considering sdb2 ...
md:  adding sdb2 ...
md:  adding sda2 ...
md: created md0
md: bind<sda2>
md: bind<sdb2>
md: running: <sdb2><sda2>
raid1: raid set md0 active with 2 out of 2 mirrors
md0: bitmap initialized from disk: read 12/12 pages, set 75 bits, status: 0
created bitmap (187 pages) for device md0
md: ... autorun DONE.
ReiserFS: md0: found reiserfs format "3.6" with standard journal
ReiserFS: md0: using ordered data mode
ReiserFS: md0: journal params: device md0, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit

age 30, max trans age 30
ReiserFS: md0: checking transaction log (md0)
ReiserFS: md0: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 204k freed
Write protecting the kernel read-only data: 341k
INIT: version 2.86 booting
                 Welcome to Fedora Core
                 Press 'I' to enter interactive startup.
Setting clock  (utc): Wed Jan 11 01:16:06 NZDT 2006 [  OK  ]
Starting udev:udevd-event[787]: udev_db_lookup_name: unable to open udev_db 
'/dev/.udev/db': No such file or directory
[  OK  ]
Setting hostname tornado.reub.net:  [  OK  ]
Checking filesystems
Checking all file systems.
[/sbin/fsck.ext3 (1) -- /boot] fsck.ext3 -a /dev/sda1
/dev/sda1 has been mounted 30 times without being checked, check forced.
/dev/sda1: 39/6024 files (28.2% non-contiguous), 12389/24064 blocks
[  OK  ]
Remounting root filesystem in read-write mode:  [  OK  ]
Mounting local filesystems:  [  OK  ]
rm: cannot remove `/var/run/dovecot/login': Is a directory
Enabling swap space:  [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
Starting sysstat:  Calling the system activity data collector (sadc):
[  OK  ]
Checking for hardware changes [  OK  ]
Flushing firewall rules: [  OK  ]
Setting chains to policy ACCEPT: nat mangle filter [  OK  ]
Unloading iptables modules: [  OK  ]
Applying iptables firewall rules: [  OK  ]
Bringing up loopback interface:  [  OK  ]
Bringing up interface eth0:  [  OK  ]
Bringing up interface gre0:  [  OK  ]
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
Starting named: [  OK  ]
Starting portmap: [  OK  ]
Starting mdmonitor: [  OK  ]
Mounting other filesystems:  [  OK  ]
Starting lm_sensors:  Starting lm_sensors: i2c_adapter i2c-0: Unrecognized 
version/stepping 0x69 Defaulting to LM85.
[  OK  ]
[  OK  ]
Starting acpi daemon: [  OK  ]
Starting hpiod: [  OK  ]
Starting hpssd: [  OK  ]
Starting cups:

<2 mins later>

SysRq : Show State

                                                sibling
   task             PC      pid father child younger older
init          S C013EA16     0     1      0     2               (NOTLB)
c1924eb8 c0383400 c1924e70 c013ea16 000200d0 3eb3674a 00000019 00000000
        000200d0 00000000 00000009 c1923b98 c1923a70 c1923550 c180f060 3eb3cee0
        00000019 0000600b c1924000 00000282 c1924ecc c1924e9c 00000282 c180fee0
Call Trace:
  [<c032051e>] schedule_timeout+0x49/0xae
  [<c016816e>] do_select+0x28b/0x2a2
  [<c0168374>] sys_select+0x1ce/0x374
  [<c0102a7b>] sysenter_past_esp+0x54/0x75
migration/0   S C1923030     0     2      1             3       (L-TLB)
c192afac 00000086 0000001f c1923030 c1b43550 c52e7915 00000009 00000000
        f741e680 00000001 00000001 c1923158 c1923030 c037da60 c1807060 c535cc9f
        00000009 00000c07 c192a000 00000292 f6e68f48 c192af90 00000292 f6e68f44
Call Trace:
  [<c01193f9>] migration_thread+0x7d/0x10b
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
ksoftirqd/0   S 00002040     0     3      1             4     2 (L-TLB)
c192cfa8 c1923c30 c037d880 00002040 c192cf44 0011523d 00000007 00000000
        00000092 00000002 0000000a c192bb98 c192ba70 c037da60 c1807060 00141c2c
        00000007 00000759 c192c000 00000246 c192ba70 c192cf8c 00000246 0000000e
Call Trace:
  [<c012151f>] ksoftirqd+0xc4/0xc6
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
watchdog/0    S 00000001     0     4      1             5     3 (L-TLB)
c192df70 00000000 00000001 00000001 0019725e aaf8bf3a 00000019 00000002
        00000000 c192df24 00000001 c192b678 c192b550 c037da60 c1807060 aaf8d6b0
        00000019 0000074f c192d000 00000282 c192df84 c192df54 00000282 c1807ee0
Call Trace:
  [<c032051e>] schedule_timeout+0x49/0xae
  [<c032059a>] schedule_timeout_interruptible+0x17/0x19
  [<c01251c5>] msleep_interruptible+0x34/0x43
  [<c013901f>] watchdog+0x42/0x67
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
migration/1   S C180F9C0     0     5      1             6     4 (L-TLB)
c192efac 00000086 00000002 c180f9c0 c03219c3 c38ae12b 00000009 00000000
        f769f700 00000000 00000001 c192b158 c192b030 f70b2a70 c180f060 c38c49b9
        00000009 00000d49 c192e000 00000000 f7c19f48 f709c030 00000753 f70b2a70
Call Trace:
  [<c01193f9>] migration_thread+0x7d/0x10b
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
ksoftirqd/1   S 0000A040     0     6      1             7     5 (L-TLB)
c1934fa8 c192b1f0 c037d880 0000a040 c1934f44 a97a01ad 00000001 00000001
        00000000 00000000 0000000a c1933b98 c1933a70 c1923550 c180f060 a981a627
        00000001 00001419 c1934000 00000246 c1933a70 c1934f8c 00000246 00000018
Call Trace:
  [<c012151f>] ksoftirqd+0xc4/0xc6
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
watchdog/1    S 00000001     0     7      1             8     6 (L-TLB)
c1935f70 00000000 00000001 00000001 001a5d72 abaf76fc 00000019 00000001
        00000000 c1935f24 00000009 c1933678 c1933550 c1923550 c180f060 abaf8725
        00000019 00000988 c1935000 00000282 c1935f84 c1935f54 00000282 c180fee0
Call Trace:
  [<c032051e>] schedule_timeout+0x49/0xae
  [<c032059a>] schedule_timeout_interruptible+0x17/0x19
  [<c01251c5>] msleep_interruptible+0x34/0x43
  [<c013901f>] watchdog+0x42/0x67
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
events/0      S C1809178     0     8      1             9     7 (L-TLB)
c1938f38 c1807ee0 00000282 c1809178 c1938ed8 7125e045 00000019 c1938ef4
        c012450e 00000000 0000000a c1933158 c1933030 c037da60 c1807060 71264f41
        00000019 0000679c c1938000 00000001 c1938f18 00000246 c19072a0 c1938f24
Call Trace:
  [<c012b1b3>] worker_thread+0x12e/0x226
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
events/1      S C1811178     0     9      1            10     8 (L-TLB)
c1951f38 c180fee0 00000282 c1811178 c1951ed8 719fad75 00000019 c1951ef4
        c012450e 00000000 0000000a c1950b98 c1950a70 c1923550 c180f060 71a004ba
        00000019 00004cad c1951000 00000001 c1951f18 00000246 c1907220 c1951f24
Call Trace:
  [<c012b1b3>] worker_thread+0x12e/0x226
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
khelper       S C193AF2C     0    10      1            11     9 (L-TLB)
c193af38 00800711 c193af20 c193af2c c0101068 97bb5059 00000009 00000000
        00000000 c193aee4 00000008 c1939b98 c1939a70 f7c7da70 c1807060 97c68368
        00000009 000026e6 c193a000 00000000 c193af18 c1923550 c19071a0 f7c7da70
Call Trace:
  [<c012b1b3>] worker_thread+0x12e/0x226
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
kthread       S 00000002     0    11      1    14     162    10 (L-TLB)
c1960f38 f7cd7550 c180f060 00000002 00000000 3569a3fc 00000008 00000000
        f769fd00 c1960f28 00000009 c1950678 c1950550 c1b7fa70 c1807060 359ad331
        00000008 00000884 c1960000 00000000 0000041a f7cc4030 c195fca0 c1b7fa70
Call Trace:
  [<c012b1b3>] worker_thread+0x12e/0x226
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
kblockd/0     S 00000000     0    14     11            15       (L-TLB)
c196af38 c196aed4 c012f3d9 00000000 c1b91fa4 cb9b3ca3 00000009 c011842d
        00000000 00000001 0000000a c1968678 c1968550 c037da60 c1807060 cb9b5a03
        00000009 0000107e c196a000 00000001 c196af18 00000246 c193db20 c196af24
Call Trace:
  [<c012b1b3>] worker_thread+0x12e/0x226
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
kblockd/1     S 00000000     0    15     11            16    14 (L-TLB)
c196bf38 c196bed4 c012f3d9 00000000 c1b91fa4 c384124c 00000009 00000001
        f741e680 00000001 0000000a c1968158 c1968030 c1b43550 c180f060 c38458bc
        00000009 000027f3 c196b000 00000000 c196bf18 f7c7da70 c193daa0 c1b43550
Call Trace:
  [<c012b1b3>] worker_thread+0x12e/0x226
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
kacpid        S C01177C5     0    16     11           108    15 (L-TLB)
c1b57f38 00000001 c1b57f10 c01177c5 00000000 01da9d16 00000000 00000000
        c18079c0 00000000 00000009 c1939678 c1939550 c1923550 c180f060 01db1be1
        00000000 000009d6 c1b57000 c03219a9 c1b57f38 00000246 c195fba0 c1b57f24
Call Trace:
  [<c012b1b3>] worker_thread+0x12e/0x226
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
khubd         S F7D52880     0   108     11           160    16 (L-TLB)
c1b44f7c 000003e8 f7d5d3a0 f7d52880 f7d52880 356556f2 00000002 c0273cee
        00000004 f7d52880 0000000a c1b43b98 c1b43a70 c037da60 c1807060 35760561
        00000002 00000bec c1b44000 00000000 00000246 c03999a8 c1b44f64 00000246
Call Trace:
  [<c0275319>] hub_thread+0xd8/0x106
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
pdflush       S 00000002     0   160     11           161   108 (L-TLB)
f7c27f88 f7c27f44 c0117c15 00000002 00000001 92dc34de 00000000 00000001
        00000000 c037dc20 00000009 f7c26b98 f7c26a70 c1950550 c1807060 92defaf4
        00000000 00000eef f7c27000 00000000 c011922d c1923550 00000003 c1950550
Call Trace:
  [<c0140e01>] __pdflush+0x81/0x199
  [<c0140f45>] pdflush+0x2c/0x32
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
pdflush       D 00000000     0   161     11           163   160 (L-TLB)
f7c28c60 c1b98fa4 f741ab18 00000000 f7c28bfc caa787fa 00000009 c012f3d9
        00000000 c1b98fa4 0000000a f7c26678 f7c26550 c1923550 c180f060 cad5c95a
        00000009 0000081e f7c28000 f741ab08 00000246 f7db0948 f7c28c48 00000246
Call Trace:
  [<c02a2f72>] md_write_start+0xbc/0x150
  [<c029a659>] make_request+0x51/0x432
  [<c01e1146>] generic_make_request+0xbe/0x13d
  [<c01e120e>] submit_bio+0x49/0xd3
  [<c015ad93>] submit_bh+0xc3/0x111
  [<c015ae60>] ll_rw_block+0x7f/0xd3
  [<c01ac41b>] flush_commit_list+0x1d3/0x503
  [<c01b0d39>] do_journal_end+0x7c3/0x912
  [<c01afce1>] journal_end_sync+0x65/0x77
  [<c019e6d2>] reiserfs_sync_fs+0x57/0x67
  [<c019e6ef>] reiserfs_write_super+0xd/0xf
  [<c015ce15>] sync_supers+0xbe/0x103
  [<c01405d8>] wb_kupdate+0x38/0x13e
  [<c0140e3a>] __pdflush+0xba/0x199
  [<c0140f45>] pdflush+0x2c/0x32
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
aio/0         S C01177C5     0   163     11           164   161 (L-TLB)
c1b8ff38 00000000 c1b8ff10 c01177c5 00000000 933ff7e0 00000000 00000001
        c180f9c0 00000000 00000009 c1b8eb98 c1b8ea70 c037da60 c1807060 9341263b
        00000000 00000c8b c1b8f000 c03219a9 c1b8ff38 00000246 c1bac6a0 c1b8ff24
Call Trace:
  [<c012b1b3>] worker_thread+0x12e/0x226
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
kswapd0       S 00000000     0   162      1           368    11 (L-TLB)
f7c29f88 f7c29f64 c01edef4 00000000 f7c2611c 933ff7e0 00000000 f7c26118
        00000286 f7c26030 00000008 f7c26158 f7c26030 c037da60 c1807060 9340eda9
        00000000 00001fe9 f7c29000 f7c29000 00000246 c0383484 f7c29f70 00000246
Call Trace:
  [<c0143dab>] kswapd+0x114/0x128
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
aio/1         S C044A3BC     0   164     11           252   163 (L-TLB)
c1b40f38 c180f9c0 00000000 c044a3bc 00000080 934134da 00000000 00000000
        00000000 00000000 00000009 c1b3d158 c1b3d030 c1923a70 c180f060 93416a14
        00000000 0000089c c1b40000 00000000 c1b40f38 c037da60 c1bac620 c1923a70
Call Trace:
  [<c012b1b3>] worker_thread+0x12e/0x226
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
kseriod       S 00000002     0   252     11           277   164 (L-TLB)
f7ceff78 c039ce48 00000000 00000002 00000001 52e70f94 00000002 f7ceff48
        00000002 c039ce48 0000000a f7ced678 f7ced550 c037da60 c1807060 52f30b80
        00000002 0002cbad f7cef000 f7ceff60 00000246 c0392cfc f7ceff60 00000246
Call Trace:
  [<c02318e1>] serio_thread+0xb1/0x109
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
ata/0         S C01177C5     0   277     11           278   252 (L-TLB)
f7cecf38 00000001 f7cecf10 c01177c5 00000000 b6ac2621 00000000 00000001
        00000000 00000000 00000009 f7ce0158 f7ce0030 c1950550 c1807060 b6acc04a
        00000000 0000107e f7cec000 00000000 f7cecf38 c1923a70 f7cb8aa0 c1950550
Call Trace:
  [<c012b1b3>] worker_thread+0x12e/0x226
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
ata/1         S C01177C5     0   278     11           280   277 (L-TLB)
f7ceef38 00000001 f7ceef10 c01177c5 00000000 b6aad46e 00000000 00000000
        00000000 00000000 00000009 f7cedb98 f7ceda70 c1923a70 c180f060 b6ad0b1a
        00000000 00000922 f7cee000 00000000 f7ceef38 c037da60 f7cb8a20 c1923a70
Call Trace:
  [<c012b1b3>] worker_thread+0x12e/0x226
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
scsi_eh_0     S C03219C3     0   280     11           281   278 (L-TLB)
f7ce1fb0 00002000 f7ce1f44 c03219c3 f7ce1fc4 566df5ed 00000001 00000002
        00000008 f7ce0b98 0000000a f7ce0b98 f7ce0a70 c037da60 c1807060 569effab
        00000001 0000065b f7ce1000 c1807060 569ee457 00000001 00000cd1 f7ce1000
Call Trace:
  [<c025e60a>] scsi_error_handler+0x48/0xa5
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
scsi_eh_1     S C03219C3     0   281     11           282   280 (L-TLB)
f7cf5fb0 00002000 f7cf5f44 c03219c3 f7cf5fc4 5724b4f1 00000001 00000002
        00000009 f7cf1678 0000000a f7cf1678 f7cf1550 c037da60 c1807060 574feb15
        00000001 00000595 f7cf5000 c1807060 574fd1f0 00000001 00000bee f7cf5000
Call Trace:
  [<c025e60a>] scsi_error_handler+0x48/0xa5
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
scsi_eh_2     S C03219C3     0   282     11           283   281 (L-TLB)
f7cf0fb0 00000040 f7cf0f44 c03219c3 f7cf0fc4 58007f47 00000001 00000002
        00000007 f7ced158 00000009 f7ced158 f7ced030 c1923550 c180f060 5800e2d9
        00000001 000005ef f7cf0000 c1807060 5800c2ad 00000001 00000c3e f7cf0000
Call Trace:
  [<c025e60a>] scsi_error_handler+0x48/0xa5
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
scsi_eh_3     S C03219C3     0   283     11           374   282 (L-TLB)
c1b3ffb0 00002140 c1b3ff44 c03219c3 c1b3ffc4 58b19b8e 00000001 00000000
        00000000 c1b3d678 00000009 c1b43158 c1b43030 c1923a70 c180f060 58b1d409
        00000001 00000495 c1b3f000 00000000 58b1b397 c037da60 00000cb1 c1923a70
Call Trace:
  [<c025e60a>] scsi_error_handler+0x48/0xa5
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
kirqd         S 0000001E     0   368      1           445   162 (L-TLB)
f7ccff88 00000000 00000000 0000001e 00000001 9e990eaa 00000019 00000000
        f75ef380 00000246 0000000a f7ccd678 f7ccd550 c037da60 c1807060 9e993bc0
        00000019 00002751 f7ccf000 00000282 f7ccff9c f7ccff6c 00000282 c1807ee0
Call Trace:
  [<c032051e>] schedule_timeout+0x49/0xae
  [<c032059a>] schedule_timeout_interruptible+0x17/0x19
  [<c0111a85>] balanced_irq+0x8a/0xc0
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
md5_raid1     S F7DB0610     0   374     11           378   283 (L-TLB)
f7ccbf3c 00000008 f7ccbed0 f7db0610 f7ccbedc 918294c8 00000019 00000002
        00000000 00000282 0000000a f7ccd158 f7ccd030 c1923550 c180f060 91bb8f46
        00000019 02204783 f7ccb000 00000282 f7ccbf50 f7ccbf20 00000282 c180fee0
Call Trace:
  [<c032051e>] schedule_timeout+0x49/0xae
  [<c02a21e5>] md_thread+0x10f/0x14f
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
md4_raid1     S F7DB0410     0   378     11           382   374 (L-TLB)
c1bc9f3c 00000008 c1bc9ed0 f7db0410 c1bc9edc 91829d5b 00000019 00000002
        00000000 00000282 0000000a c1bc7b98 c1bc7a70 f7c6f030 c1807060 918bb09d
        00000019 00d3fe93 c1bc9000 00000000 c1bc9f50 f7ccd030 00000282 f7c6f030
Call Trace:
  [<c032051e>] schedule_timeout+0x49/0xae
  [<c02a21e5>] md_thread+0x10f/0x14f
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
md3_raid1     S F7DB0010     0   382     11           386   378 (L-TLB)
f7cc7f3c 00000008 f7cc7ed0 f7db0010 f7cc7edc 8d3a119d 00000019 00000002
        00000000 00000282 0000000a c1b47b98 c1b47a70 c1923550 c180f060 8d5c6575
        00000019 00224c3b f7cc7000 00000282 f7cc7f50 f7cc7f20 00000282 c180fee0
Call Trace:
  [<c032051e>] schedule_timeout+0x49/0xae
  [<c02a21e5>] md_thread+0x10f/0x14f
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
md2_raid1     D F7227200     0   386     11           390   382 (L-TLB)
c1b91e64 f7227200 00000001 f7227200 00000000 c2dc6fe1 00000010 00000001
        00000001 00001000 0000000a c1b43678 c1b43550 c1923550 c180f060 c2dd5d38
        00000010 00007fe0 c1b91000 c015b787 00000246 f7dd6f48 c1b91e4c 00000246
Call Trace:
  [<c029d004>] md_super_wait+0xd5/0xea
  [<c02a4f93>] bitmap_unplug+0x1d8/0x1df
  [<c029b72b>] raid1d+0x7d/0x555
  [<c02a211a>] md_thread+0x44/0x14f
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
md1_raid1     S F7DD6C10     0   390     11           393   386 (L-TLB)
c1b50f3c 00000008 c1b50ed0 f7dd6c10 c1b50edc 908ef164 00000019 00000002
        00000000 00000282 0000000a c1bc7158 c1bc7030 c1bc7a70 c1807060 90b7b20a
        00000019 01d324e4 c1b50000 00000282 c1b50f50 c1b50f20 00000282 c1807ee0
Call Trace:
  [<c032051e>] schedule_timeout+0x49/0xae
  [<c02a21e5>] md_thread+0x10f/0x14f
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
md0_raid1     D C1B98E24     0   393     11           394   390 (L-TLB)
c1b98e44 c197d300 c1903800 c1b98e24 c01e1146 caa79079 00000009 f7db0800
        f7db0938 00000800 0000000a c1b8e158 c1b8e030 c037da60 c1807060 cad5fcef
        00000009 00001c8f c1b98000 c197d300 00000246 f7db0948 c1b98e2c 00000246
Call Trace:
  [<c029d004>] md_super_wait+0xd5/0xea
  [<c029ec29>] md_update_sb+0xc9/0x153
  [<c02a3a20>] md_check_recovery+0x182/0x437
  [<c029b6cd>] raid1d+0x1f/0x555
  [<c02a211a>] md_thread+0x44/0x14f
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
reiserfs/0    D C01183F2     0   394     11           395   393 (L-TLB)
f7c13d90 00000000 f7c13d24 c01183f2 f7c13d38 c2dc789f 00000010 c1b91fa4
        f7405818 f7c13d5c 0000000a c1b92158 c1b92030 c037da60 c1807060 c2dcdf7a
        00000010 00005dc5 f7c13000 c0118487 00000000 00000000 00000003 f7dd6e00
Call Trace:
  [<c032047b>] io_schedule+0x26/0x30
  [<c0157c7e>] sync_buffer+0x33/0x37
  [<c0320663>] __wait_on_bit+0x45/0x62
  [<c03206eb>] out_of_line_wait_on_bit+0x6b/0x73
  [<c0157cef>] __wait_on_buffer+0x27/0x2d
  [<c01ac0c8>] write_ordered_buffers+0x1b3/0x1fe
  [<c01ac6ac>] flush_commit_list+0x464/0x503
  [<c01afd6b>] flush_async_commits+0x78/0x7a
  [<c012b221>] worker_thread+0x19c/0x226
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
reiserfs/1    D 00000000     0   395     11                 394 (L-TLB)
f7c15e80 f7dd9c1c 00000000 00000000 c015dc50 cfa6ca71 00000009 00000000
        00000000 00000000 0000000a c1b97b98 c1b97a70 c1923550 c180f060 cfa6e216
        00000009 00000bda f7c15000 c16d0d60 c16e7720 c16ee120 c16d17e0 c16dfc00
Call Trace:
  [<c03216e7>] __down+0xae/0x116
  [<c031ef4a>] __down_failed+0xa/0x10
  [<c01b0f17>] .text.lock.journal+0x8/0x111
  [<c01afd6b>] flush_async_commits+0x78/0x7a
  [<c012b221>] worker_thread+0x19c/0x226
  [<c012ef67>] kthread+0x99/0x9d
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
udevd         S C013EA16     0   445      1          1297   368 (NOTLB)
f7614eb8 c0383400 f7614e70 c013ea16 000200d0 3a68e9e7 00000008 00000000
        000200d0 00000000 00000007 f7cc4158 f7cc4030 c037da60 c1807060 3a6a8cd6
        00000008 00014e5d f7614000 c0383400 00000000 00000246 f765fa00 f7614ea4
Call Trace:
  [<c0320544>] schedule_timeout+0x6f/0xae
  [<c016816e>] do_select+0x28b/0x2a2
  [<c0168374>] sys_select+0x1ce/0x374
  [<c0102a7b>] sysenter_past_esp+0x54/0x75
kjournald     S 00000000     0  1297      1          1357   445 (L-TLB)
f7ccaf70 00000000 00000000 00000000 f7cc9da8 0a2c2793 00000004 00000032
        c01183f2 f7ccaf2c 00000004 c1950158 c1950030 c037da60 c1807060 0a639496
        00000004 00002f9f f7cca000 00000001 00000246 f77744b4 f7ccaf58 00000246
Call Trace:
  [<c01c9985>] kjournald+0x22b/0x242
  [<c0100fe5>] kernel_thread_helper+0x5/0xb
rc            S 00000000     0  1357      1  1808    1662  1297 (NOTLB)
f7076f1c 00000044 00000003 00000000 000200d2 fa7112a3 00000008 f77fb550
        000200d2 f7076f04 00000006 f77fb678 f77fb550 c037da60 c1807060 faa06439
        00000008 00013318 f7076000 c17aa160 f7076efc 00000246 f7413e08 f7076f08
Call Trace:
  [<c011fb02>] do_wait+0x304/0x39c
  [<c011fc34>] sys_wait4+0x32/0x34
  [<c011fc5d>] sys_waitpid+0x27/0x29
  [<c0102a7b>] sysenter_past_esp+0x54/0x75
syslogd       D 00000000     0  1662      1          1665  1357 (NOTLB)
f703be84 f703be20 c012f3d9 00000000 c1b91fa4 cbd82791 00000009 c011842d
        00000000 00000001 00000009 c1bc2b98 c1bc2a70 c037da60 c1807060 cc08aca6
        00000009 00001ebd f703b000 00000003 f7dd6e00 00000000 f703beec f703be70
Call Trace:
  [<c032047b>] io_schedule+0x26/0x30
  [<c0139f45>] sync_page+0x37/0x42
  [<c0320663>] __wait_on_bit+0x45/0x62
  [<c013a516>] wait_on_page_bit+0x6a/0x72
  [<c013a0de>] wait_on_page_writeback_range+0x9b/0xf9
  [<c013a2db>] filemap_fdatawait+0x4c/0x51
  [<c0158197>] do_fsync+0x90/0xd9
  [<c01581ed>] sys_fsync+0xd/0xf
  [<c0102a7b>] sysenter_past_esp+0x54/0x75
klogd         S C0115F42     0  1665      1          1676  1662 (NOTLB)
f7583d70 c16d1640 f7583d14 c0115f42 00000246 c3471a7e 00000009 00000000
        f741e680 c1936dc0 0000000a f77fb158 f77fb030 c1bc2a70 c180f060 c36b6b1d
        00000009 0000ae86 f7583000 00000000 0000004b f7c7da70 000002a3 c1bc2a70
Call Trace:
  [<c0320544>] schedule_timeout+0x6f/0xae
  [<c0319665>] unix_wait_for_peer+0xd4/0xd8
  [<c031a004>] unix_dgram_sendmsg+0x2ef/0x4fd
  [<c02ac25f>] do_sock_write+0xa8/0xbe
  [<c02ac3c6>] sock_aio_write+0x69/0x6d
  [<c0156c5f>] do_sync_write+0xbb/0xf1
  [<c0156dd4>] vfs_write+0x13f/0x146
  [<c0156e7c>] sys_write+0x3d/0x64
  [<c0102a7b>] sysenter_past_esp+0x54/0x75
named         S 00000001     0  1676      1          1677  1665 (NOTLB)
f766df94 c01333dd f7693e8c 00000001 8005e828 cacebf41 00000007 00000001
        00000000 00000000 00000009 c1b92678 c1b92550 c037da60 c1807060 cae3fe48
        00000007 0006ff90 f766d000 bfc86fe8 00000246 c01ef0e6 bfc86fe8 f766df84
Call Trace:
  [<c0101d55>] sys_rt_sigsuspend+0xab/0xc7
  [<c0102a7b>] sysenter_past_esp+0x54/0x75
named         S 00000001     0  1677      1          1678  1676 (NOTLB)
f6827ea8 c0115f42 f76feb80 00000001 00000001 c48052ee 00000015 00000001
        f76feb80 c1b4ba70 00000009 f77dfb98 f77dfa70 c037da60 c1807060 c4814854
        00000015 0000134f f6827000 00000000 00000000 c1b55a70 00000001 c1b4ba70
Call Trace:
  [<c0320544>] schedule_timeout+0x6f/0xae
  [<c0133b00>] futex_wait+0x1dd/0x250
  [<c0133dc8>] do_futex+0x49/0x83
  [<c0133e67>] sys_futex+0x65/0xb8
  [<c0102a7b>] sysenter_past_esp+0x54/0x75
named         S C02B255C     0  1678      1          1679  1677 (NOTLB)
f6816ea8 00000000 f6816f4c c02b255c f6816f0c 266dda6f 00000019 c01ef0e6
        f6816f0c f6816f4c 00000009 c1b55b98 c1b55a70 c1923550 c180f060 267c092e
        00000019 000443a5 f6816000 f6816f0c 80105f54 80088c48 f6816f0c 00000008
Call Trace:
  [<c0320544>] schedule_timeout+0x6f/0xae
  [<c0133b00>] futex_wait+0x1dd/0x250
  [<c0133dc8>] do_futex+0x49/0x83
  [<c0133e67>] sys_futex+0x65/0xb8
  [<c0102a7b>] sysenter_past_esp+0x54/0x75
named         S F76FEB80     0  1679      1          1680  1678 (NOTLB)
f77deea8 f77dee48 c0115f58 f76feb80 00000001 c48049ed 00000015 00000001
        f76feb80 00000096 00000009 f7ccdb98 f7ccda70 c1923550 c180f060 c48113ce
        00000015 00001881 f77de000 00000282 f77deebc f77dee8c 00000282 c180fee0
Call Trace:
  [<c032051e>] schedule_timeout+0x49/0xae
  [<c0133b00>] futex_wait+0x1dd/0x250
  [<c0133dc8>] do_futex+0x49/0x83
  [<c0133e67>] sys_futex+0x65/0xb8
  [<c0102a7b>] sysenter_past_esp+0x54/0x75
named         S C013EA16     0  1680      1          1702  1679 (NOTLB)
f6ee0eb8 c0383400 f6ee0e70 c013ea16 000200d0 266de319 00000019 00000000
        000200d0 00000000 00000009 c1b4bb98 c1b4ba70 c037da60 c1807060 268b59ef
        00000019 00000fc7 f6ee0000 f688307c f6ee0ea0 00000246 f6e6a518 f6ee0ea4
Call Trace:
  [<c0320544>] schedule_timeout+0x6f/0xae
  [<c016816e>] do_select+0x28b/0x2a2
  [<c0168374>] sys_select+0x1ce/0x374
  [<c0102a7b>] sysenter_past_esp+0x54/0x75
portmap       S F755DEF0     0  1702      1          1711  1680 (NOTLB)
f755df24 00000000 c17fa920 f755def0 c0383400 1bb69555 00000008 f6efbc98
        f755ded4 00000246 00000004 f77df158 f77df030 c037da60 c1807060 1bcaafd5
        00000008 0007d1ba f755d000 f68c7000 f76d5880 f755df9c f755df18 c0167dae
Call Trace:
  [<c0320544>] schedule_timeout+0x6f/0xae
  [<c016865b>] do_poll+0x9a/0xb9
  [<c01687e3>] sys_poll+0x169/0x226
  [<c0102a7b>] sysenter_past_esp+0x54/0x75
mdadm         S 00000096     0  1711      1          1791  1702 (NOTLB)
f7618e6c f7ccd030 f7618e04 00000096 00000001 0ebe717f 00000016 32388e4c
        000000b7 00000000 00000009 f7065678 f7065550 c1923550 c180f060 0ebfc1d7
        00000016 0001480d f7618000 00000000 ffffffff 013d1f60 ffffffff ffffffff
Call Trace:
  [<c03217f2>] __down_interruptible+0xa3/0x133
  [<c031ef5a>] __down_failed_interruptible+0xa/0x10
  [<c02a3fba>] .text.lock.md+0xd7/0x11d
  [<c017427c>] seq_read+0x1d8/0x2a4
  [<c0156ae9>] vfs_read+0x89/0x144
  [<c0156e18>] sys_read+0x3d/0x64
  [<c0102a7b>] sysenter_past_esp+0x54/0x75
acpid         S 000200D0     0  1791      1          1799  1711 (NOTLB)
f7c70f24 00000002 00000000 000200d0 00000000 554c894b 00000008 000000d0
        f7c70f08 c013eaa9 00000004 f7c6f678 f7c6f550 c037da60 c1807060 555f2779
        00000008 00033e39 f7c70000 f6916000 f771d780 f7c70f9c f7c70f18 c0167dae
Call Trace:
  [<c0320544>] schedule_timeout+0x6f/0xae
  [<c016865b>] do_poll+0x9a/0xb9
  [<c01687e3>] sys_poll+0x169/0x226
  [<c0102a7b>] sysenter_past_esp+0x54/0x75
hpiod         S 00000001     0  1799      1          1804  1791 (NOTLB)
f773ae0c 00200202 c0164105 00000001 c0383404 8d42e73d 00000009 00000000
        00000000 f6923e20 00000009 f7691678 f7691550 f70b2030 c180f060 8d503e23
        00000009 00035f90 f773a000 00000000 c016d45d c037da60 0000012c f70b2030
Call Trace:
  [<c0320544>] schedule_timeout+0x6f/0xae
  [<c02d7525>] inet_csk_wait_for_connect+0xdb/0x104
  [<c02d75b4>] inet_csk_accept+0x66/0x139
  [<c02f41ad>] inet_accept+0x20/0xa2
  [<c02acdcb>] sys_accept+0x88/0x119
  [<c02ad734>] sys_socketcall+0xc1/0x254
  [<c0102a7b>] sysenter_past_esp+0x54/0x75
hpiod         S 00000000     0  1815      1                1804 (NOTLB)
f77d1cc4 00000000 00000000 00000000 00000000 8d42e73d 00000009 00000000
        00000000 00000000 00000008 f70b2158 f70b2030 f7cc4550 c180f060 8d5081a4
        00000009 00004381 f77d1000 00000000 00000000 c037da60 00000096 f7cc4550
Call Trace:
  [<c0320544>] schedule_timeout+0x6f/0xae
  [<c02aefee>] sk_wait_data+0xb3/0xec
  [<c02d9bce>] tcp_recvmsg+0x385/0x720
  [<c02af717>] sock_common_recvmsg+0x3d/0x53
  [<c02abeb0>] sock_recvmsg+0xda/0xfe
  [<c02ad117>] sys_recvfrom+0x79/0xbe
  [<c02ad192>] sys_recv+0x36/0x38
  [<c02ad7cb>] sys_socketcall+0x158/0x254
  [<c0102a7b>] sysenter_past_esp+0x54/0x75
python        S C013EA16     0  1804      1          1815  1799 (NOTLB)
f681ceb8 c0383400 f681ce70 c013ea16 000200d0 c24aa123 00000019 00000000
        000200d0 00000000 0000000a f7cd7678 f7cd7550 c037da60 c1807060 c24b07ed
        00000019 0000609e f681c000 00000282 f681cecc f681ce9c 00000282 c1807ee0
Call Trace:
  [<c032051e>] schedule_timeout+0x49/0xae
  [<c016816e>] do_select+0x28b/0x2a2
  [<c0168374>] sys_select+0x1ce/0x374
  [<c0102a7b>] sysenter_past_esp+0x54/0x75
S55cups       S 00000000     0  1808   1357  1811               (NOTLB)
f7586f1c 00000044 00000003 00000000 000200d2 fb27d0c7 00000008 f70ba030
        000200d2 f7586f04 00000003 f70ba158 f70ba030 c037da60 c1807060 fb2f2072
        00000008 0000fd6c f7586000 c17ce140 f7586efc 00000246 f7413988 f7586f08
Call Trace:
  [<c011fb02>] do_wait+0x304/0x39c
  [<c011fc34>] sys_wait4+0x32/0x34
  [<c011fc5d>] sys_waitpid+0x27/0x29
  [<c0102a7b>] sysenter_past_esp+0x54/0x75
bash          S 00000000     0  1811   1808  1812               (NOTLB)
f680ef1c c013a636 000000ac 00000000 c17f23c0 fb27c91b 00000008 f7c78550
        000200d2 f680ef2c 00000001 f7c78678 f7c78550 c1923550 c180f060 fb4f30ba
        00000008 000140c2 f680e000 c17c8aa0 00000000 00000246 f76dcb08 f680ef08
Call Trace:
  [<c011fb02>] do_wait+0x304/0x39c
  [<c011fc34>] sys_wait4+0x32/0x34
  [<c011fc5d>] sys_waitpid+0x27/0x29
  [<c0102a7b>] sysenter_past_esp+0x54/0x75
cupsd         S F70B2A70     0  1812   1811  1813               (NOTLB)
f7073f44 f7073ee0 f7073000 f70b2a70 f7073ee0 cd3cd31c 00000019 c011b664
        00000000 c17d35a0 00000009 f7c6f158 f7c6f030 c037da60 c1807060 cd3cfcfb
        00000019 00001776 f7073000 00000282 f7073f58 f7073f28 00000282 c1807ee0
Call Trace:
  [<c032051e>] schedule_timeout+0x49/0xae
  [<c032059a>] schedule_timeout_interruptible+0x17/0x19
  [<c0124ee2>] sys_nanosleep+0xcc/0x12f
  [<c0102a7b>] sysenter_past_esp+0x54/0x75
cupsd         S BFBE1C0C     0  1813   1812  1837               (NOTLB)
f6804f1c 00000000 00000000 bfbe1c0c bfbe1c0c bce98a58 00000010 f6804000
        f6804f08 f6804ee8 00000001 f70b2b98 f70b2a70 c037da60 c1807060 bcebb163
        00000010 000217ca f6804000 c03209b6 c0162893 00000246 f7d1c688 f6804f08
Call Trace:
  [<c011fb02>] do_wait+0x304/0x39c
  [<c011fc34>] sys_wait4+0x32/0x34
  [<c011fc5d>] sys_waitpid+0x27/0x29
  [<c0102a7b>] sysenter_past_esp+0x54/0x75
smb           D 00000082     0  1837   1813                     (NOTLB)
f6e68e28 f6e68de0 c02601f4 00000082 f7cbf3dc cccbd193 00000009 f7cbf3dc
        f7cf39a0 00000001 00000007 f70d9b98 f70d9a70 c037da60 c1807060 ccd313bc
        00000009 0001d758 f6e68000 00000003 f7db0800 f6e68e88 f6e68e94 f6e68e14
Call Trace:
  [<c032047b>] io_schedule+0x26/0x30
  [<c0139f45>] sync_page+0x37/0x42
  [<c0320733>] __wait_on_bit_lock+0x40/0x63
  [<c013a5f4>] __lock_page+0x64/0x6c
  [<c013b737>] filemap_nopage+0x2e5/0x3a0
  [<c0147681>] do_no_page+0x7a/0x266
  [<c014799f>] __handle_mm_fault+0xbf/0x20a
  [<c0114fbf>] do_page_fault+0x37b/0x5af
  [<c0103673>] error_code+0x4f/0x54

Showing all blocking locks in the system:
S            init:    1 [c1923a70, 116] (not blocked on mutex)
S     migration/0:    2 [c1923030,   0] (not blocked on mutex)
S     ksoftirqd/0:    3 [c192ba70, 134] (not blocked on mutex)
S      watchdog/0:    4 [c192b550,   0] (not blocked on mutex)
S     migration/1:    5 [c192b030,   0] (not blocked on mutex)
S     ksoftirqd/1:    6 [c1933a70, 134] (not blocked on mutex)
S      watchdog/1:    7 [c1933550,   0] (not blocked on mutex)
S        events/0:    8 [c1933030, 110] (not blocked on mutex)
S        events/1:    9 [c1950a70, 110] (not blocked on mutex)
S         khelper:   10 [c1939a70, 112] (not blocked on mutex)
S         kthread:   11 [c1950550, 111] (not blocked on mutex)
S       kblockd/0:   14 [c1968550, 110] (not blocked on mutex)
S       kblockd/1:   15 [c1968030, 110] (not blocked on mutex)
S          kacpid:   16 [c1939550, 111] (not blocked on mutex)
S           khubd:  108 [c1b43a70, 110] (not blocked on mutex)
S         pdflush:  160 [f7c26a70, 120] (not blocked on mutex)
D         pdflush:  161 [f7c26550, 115] (not blocked on mutex)
S           aio/0:  163 [c1b8ea70, 111] (not blocked on mutex)
S         kswapd0:  162 [f7c26030, 117] (not blocked on mutex)
S           aio/1:  164 [c1b3d030, 111] (not blocked on mutex)
S         kseriod:  252 [f7ced550, 110] (not blocked on mutex)
S           ata/0:  277 [f7ce0030, 111] (not blocked on mutex)
S           ata/1:  278 [f7ceda70, 111] (not blocked on mutex)
S       scsi_eh_0:  280 [f7ce0a70, 110] (not blocked on mutex)
S       scsi_eh_1:  281 [f7cf1550, 110] (not blocked on mutex)
S       scsi_eh_2:  282 [f7ced030, 111] (not blocked on mutex)
S       scsi_eh_3:  283 [c1b43030, 111] (not blocked on mutex)
S           kirqd:  368 [f7ccd550, 115] (not blocked on mutex)
S       md5_raid1:  374 [f7ccd030, 110] (not blocked on mutex)
S       md4_raid1:  378 [c1bc7a70, 110] (not blocked on mutex)
S       md3_raid1:  382 [c1b47a70, 110] (not blocked on mutex)
D       md2_raid1:  386 [c1b43550, 110] (not blocked on mutex)
S       md1_raid1:  390 [c1bc7030, 110] (not blocked on mutex)
D       md0_raid1:  393 [c1b8e030, 110] (not blocked on mutex)
D      reiserfs/0:  394 [c1b92030, 110] (not blocked on mutex)
D      reiserfs/1:  395 [c1b97a70, 110] (not blocked on mutex)
S           udevd:  445 [f7cc4030, 114] (not blocked on mutex)
S       kjournald: 1297 [c1950030, 121] (not blocked on mutex)
S              rc: 1357 [f77fb550, 117] (not blocked on mutex)
D         syslogd: 1662 [c1bc2a70, 116] (not blocked on mutex)
S           klogd: 1665 [f77fb030, 115] (not blocked on mutex)
S           named: 1676 [c1b92550, 116] (not blocked on mutex)
S           named: 1677 [f77dfa70, 116] (not blocked on mutex)
S           named: 1678 [c1b55a70, 116] (not blocked on mutex)
S           named: 1679 [f7ccda70, 116] (not blocked on mutex)
S           named: 1680 [c1b4ba70, 116] (not blocked on mutex)
S         portmap: 1702 [f77df030, 121] (not blocked on mutex)
S           mdadm: 1711 [f7065550, 116] (not blocked on mutex)
S           acpid: 1791 [f7c6f550, 121] (not blocked on mutex)
S           hpiod: 1799 [f7691550, 116] (not blocked on mutex)
S           hpiod: 1815 [f70b2030, 117] (not blocked on mutex)
S          python: 1804 [f7cd7550, 115] (not blocked on mutex)
S         S55cups: 1808 [f70ba030, 120] (not blocked on mutex)
S            bash: 1811 [f7c78550, 123] (not blocked on mutex)
S           cupsd: 1812 [f7c6f030, 116] (not blocked on mutex)
S           cupsd: 1813 [f70b2a70, 122] (not blocked on mutex)
D             smb: 1837 [f70d9a70, 118] (not blocked on mutex)

---------------------------
| showing all locks held: |
---------------------------

#001:             [f7dd6a58] {alloc_super}
.. held by:           pdflush:  161 [f7c26550, 115]
... acquired at:               sync_supers+0xa3/0x103

=============================================

reuben

