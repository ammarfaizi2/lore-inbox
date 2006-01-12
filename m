Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWALEEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWALEEV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 23:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWALEEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 23:04:21 -0500
Received: from tornado.reub.net ([202.89.145.182]:24801 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1751262AbWALEEU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 23:04:20 -0500
Message-ID: <43C5D537.7020800@reub.net>
Date: Thu, 12 Jan 2006 17:04:07 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060110)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.15-mm3
References: <20060111042135.24faf878.akpm@osdl.org>
In-Reply-To: <20060111042135.24faf878.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/01/2006 1:21 a.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm3/
> 
> - New config options (VMSPLIT_*) to permit non-standard user/kernel
>   splitting on x86.  Needs testing please.
> 
> - Lots of updates to the USB, PCI, driver and I2C trees.  This is usually a
>   worry.
> 
> - Multiblock allocation speedup for ext3.  This is only used by direct-IO at
>   present.
> 
> - Reminder: -mm kernel commit activity can be reviewed by subscribing to the
>   mm-commits mailing list.
> 
>   echo "subscribe mm-commits" | mail marordomo@vger.kernel.org
> 
> - If you hit a bug in -mm and it's not obvious which patch caused it, it is
>   most valuable if you can perform a bisection search to identify which patch
>   introduced the bug.  Instructions for this process are at
> 
> 	http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
> 
>   But beware that this process takes some time (around ten rebuilds and
>   reboots), so consider reporting the bug first and if we cannot immediately
>   identify the faulty patch, then perform the bisection search.

I'm not sure if this is new to -mm3, but it's the first time I have seen it.

The sequence of events leading up to this was to reboot the machine, it came up 
and crashed:

Call Trace:
  [<c0103c5d>] show_stack+0x9b/0xc0
  [<c0103de4>] show_registers+0x162/0x1e7
  [<c0103f8f>] die+0x126/0x231
  [<c01140db>] do_page_fault+0x271/0x5b9
  [<c01037df>] error_code+0x4f/0x54
  [<c023cabd>] class_device_del+0xa3/0x156
  [<c023cb7b>] class_device_unregister+0xb/0x15
  [<c0255dbf>] scsi_remove_host+0xb4/0xef

See the previous bug report about this one that I just posted in it's original 
thread.  I had to reset the box to clear that one.

After rebooting, now a new problem:

Linux version 2.6.15-mm3 (root@tornado.reub.net) (gcc version 4.1.0 20060106 
(Red Hat 4.1.0-0.14)) #4 SMP Thu Jan 12 16:26:28 NZDT 2006
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
ACPI: PM-Timer IO Port: 0x408
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
Detected 2800.156 MHz processor.
Built 1 zonelists
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
Kernel command line: ro root=/dev/md0 panic=60 console=ttyS0,57600
CPU 0 irqstacks, hard=c040a000 soft=c0408000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1033552k/1046716k available (2161k kernel code, 12500k reserved, 713k 
data, 204k init, 129212k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5607.77 BogoMIPS (lpj=11215558)
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
CPU 1 irqstacks, hard=c040b000 soft=c0409000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5600.66 BogoMIPS (lpj=11201332)
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 04
Total of 2 processors activated (11208.44 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=144
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
ACPI: Subsystem revision 20051216
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
PCI: Enabling device 0000:00:1c.1 (0106 -> 0107)
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 185
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 193
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Initializing Cryptographic API
io scheduler noop registered<6>Time: tsc clocksource has been installed.

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
Real Time Clock Driver v1.12ac
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
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 193
ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq led slum part
ata1: SATA max UDMA/133 cmd 0xF8804D00 ctl 0x0 bmdma 0x0 irq 50
ata2: SATA max UDMA/133 cmd 0xF8804D80 ctl 0x0 bmdma 0x0 irq 50
ata3: SATA max UDMA/133 cmd 0xF8804E00 ctl 0x0 bmdma 0x0 irq 50
ata4: SATA max UDMA/133 cmd 0xF8804E80 ctl 0x0 bmdma 0x0 irq 50
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1 is slow to respond, please be patient
ata1 failed to respond (30 secs)
scsi0 : ahci
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2 is slow to respond, please be patient
ata2 failed to respond (30 secs)
scsi1 : ahci
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3 is slow to respond, please be patient
ata3 failed to respond (30 secs)
scsi2 : ahci
ata4: SATA link down (SStatus 0)
scsi3 : ahci
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 58
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 58, io mem 0xff4ff800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
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
irq 193: nobody cared (try booting with the "irqpoll" option)
  [<c01041d9>] dump_stack+0x17/0x19
  [<c0139f47>] __report_bad_irq+0x27/0x83
  [<c013a021>] note_interrupt+0x7e/0x21d
  [<c0139af4>] __do_IRQ+0xd3/0xef
  [<c0105038>] do_IRQ+0x3d/0x57
  =======================
  [<c0103686>] common_interrupt+0x1a/0x20
  [<c0101bc4>] cpu_idle+0x63/0x78
  [<c0100615>] rest_init+0x23/0x2e
  [<c03d070f>] start_kernel+0x2ca/0x34b
  [<c0100210>] 0xc0100210
handlers:
[<c027017e>] (usb_hcd_irq+0x0/0x56)
Disabling IRQ #193
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
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
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
md: ... autorun DONE.
ReiserFS: md0: warning: sh-2006: read_super_block: bread failed (dev md0, block 
2, size 4096)
ReiserFS: md0: warning: sh-2006: read_super_block: bread failed (dev md0, block 
16, size 4096)
EXT3-fs: unable to read superblock
EXT2-fs: unable to read superblock
isofs_fill_super: bread failed, dev=md0, iso_blknum=16, block=32
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(9,0)

Then cold booted/power cycled again, and it came up OK (and it's still up).

I reported a bug in November about SATA timing out in a similar fashion when 
booted on an SMP kernel but with 'nosmp' on the kernel command line, it had 
similar symptoms FWIW, and may or may not be something related.

Reuben


