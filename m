Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268877AbUJTSHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268877AbUJTSHK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 14:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268937AbUJTSG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 14:06:58 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:58761 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S268877AbUJTRtG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:49:06 -0400
Message-ID: <4176A50C.9050303@ru.mvista.com>
Date: Wed, 20 Oct 2004 21:49:00 +0400
From: Alexander Batyrshin <abatyrshin@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu>
In-Reply-To: <20041020094508.GA29080@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------040005050903030201040608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040005050903030201040608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Ingo Molnar wrote:
> i have released the -U8 Real-Time Preemption patch:
> 
>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U8
> 

used i386/defconfig

1. at boot
[...skip...]
hda: 78242976 sectors (40060 MB) w/2048KiB Cache, CHS=16383/255/63, 
UDMA(100)
  hda: hda1 hda2 hda3 hda4 < hda5 >
BUG: semaphore recursion deadlock detected!
.. current task khpsbpkt/723 is already holding c04610c0.
00001f23 00001f2f c04e8de9 00000086 00000009 00000000 c011b552 00000020
        00000400 c03b3efa dfdc9f70 dfdc9f50 0000000c dfdc78f0 c011b430 
c03b3efa
        dfdc9f70 c01052a5 c03b3efa c03b3efa 00000000 dfdc78f0 dfdc78f0 
c01fd364
Call Trace:
  [<c012caa4>] __kernel_text_address+0x2e/0x37 (24)
  [<c01051c9>] show_trace+0x4e/0xcc (12)
  [<c01052c9>] show_stack+0x82/0x97 (36)
  [<c01fd364>] __rwsem_deadlock+0xd9/0x135 (24)
  [<c039e2a0>] down_write_interruptible+0xe6/0x202 (48)
  [<c029dd80>] hpsbpkt_thread+0x2b/0x86 (48)
  [<c029dd55>] hpsbpkt_thread+0x0/0x86 (12)
  [<c01024d1>] kernel_thread_helper+0x5/0xb (4)
preempt count: 00000003
. 3-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: _spin_lock+0x19/0x6d / (0x0)
.. entry 3: print_traces+0x17/0x50 / (0x0)
[...skip...]

2.
if execute
``for i in `seq 1 9999`; do nohup bash >/dev/null 2>&1 & done'',
then you'll get something like:
[...skip...]
Warning: dev (pts0) tty->count(16) != #fd's(8) in tty_open
Warning: dev (pts0) tty->count(16) != #fd's(11) in tty_open
Warning: dev (pts0) tty->count(17) != #fd's(13) in tty_open
Warning: dev (pts0) tty->count(18) != #fd's(16) in tty_open
Warning: dev (pts0) tty->count(18) != #fd's(16) in tty_open
Warning: dev (pts0) tty->count(18) != #fd's(16) in tty_open
Warning: dev (pts0) tty->count(19) != #fd's(16) in tty_open
Warning: dev (pts0) tty->count(19) != #fd's(16) in release_dev
Warning: dev (pts0) tty->count(18) != #fd's(16) in tty_open
Warning: dev (pts0) tty->count(18) != #fd's(16) in tty_open
Warning: dev (pts0) tty->count(19) != #fd's(17) in tty_open
Warning: dev (pts0) tty->count(19) != #fd's(17) in release_dev
Warning: dev (pts0) tty->count(18) != #fd's(17) in tty_open
Warning: dev (pts0) tty->count(18) != #fd's(17) in tty_open
Warning: dev (pts0) tty->count(19) != #fd's(17) in release_dev
Warning: dev (pts0) tty->count(17) != #fd's(18) in release_dev
Warning: dev (pts0) tty->count(16) != #fd's(19) in release_dev
Warning: dev (pts0) tty->count(15) != #fd's(18) in release_dev
Warning: dev (pts0) tty->count(14) != #fd's(18) in release_dev
Warning: dev (pts0) tty->count(14) != #fd's(18) in release_dev
Warning: dev (pts0) tty->count(13) != #fd's(18) in tty_open
Warning: dev (pts0) tty->count(14) != #fd's(19) in release_dev
Warning: dev (pts0) tty->count(13) != #fd's(18) in release_dev
Warning: dev (pts0) tty->count(13) != #fd's(17) in release_dev
Warning: dev (pts0) tty->count(12) != #fd's(18) in tty_open
Warning: dev (pts0) tty->count(12) != #fd's(18) in release_dev
Warning: dev (pts0) tty->count(12) != #fd's(18) in release_dev
Warning: dev (pts0) tty->count(28) != #fd's(16) in tty_open
Warning: dev (pts0) tty->count(528) != #fd's(13) in tty_open
Warning: dev (pts0) tty->count(528) != #fd's(13) in release_dev
Warning: dev (pts0) tty->count(527) != #fd's(12) in tty_open
Warning: dev (pts0) tty->count(528) != #fd's(12) in release_dev
Warning: dev (pts0) tty->count(538) != #fd's(28) in release_dev
Warning: dev (pts0) tty->count(537) != #fd's(528) in tty_open
Warning: dev (pts0) tty->count(537) != #fd's(527) in release_dev
Warning: dev (pts0) tty->count(536) != #fd's(527) in tty_open
Warning: dev (pts0) tty->count(536) != #fd's(527) in tty_open
Warning: dev (pts0) tty->count(536) != #fd's(527) in release_dev
Warning: dev (pts0) tty->count(535) != #fd's(527) in tty_open
Warning: dev (pts0) tty->count(535) != #fd's(530) in tty_open
[...skip...]
Warning: dev (pts0) tty->count(11) != #fd's(71) in release_dev
Warning: dev (pts0) tty->count(10) != #fd's(71) in release_dev
Warning: dev (pts0) tty->count(9) != #fd's(71) in release_dev
Warning: dev (pts0) tty->count(8) != #fd's(71) in release_dev
Warning: dev (pts0) tty->count(7) != #fd's(71) in release_dev
Warning: dev (pts0) tty->count(6) != #fd's(71) in release_dev
Warning: dev (pts0) tty->count(5) != #fd's(71) in release_dev
Warning: dev (pts0) tty->count(4) != #fd's(71) in release_dev
Warning: dev (pts0) tty->count(3) != #fd's(71) in release_dev
eggcups: page allocation failure. order:1, mode:0x20
  [<c01439d8>] __alloc_pages+0x228/0x3ff (8)
  [<c0143bce>] __get_free_pages+0x1f/0x3b (68)
  [<c014719c>] kmem_getpages+0x25/0xe0 (8)
[...skip...]

I'v tested it against linux-2.6.9-rc4-mm1 => all was ok

See full logs in attachments

  -bash

--------------040005050903030201040608
Content-Type: text/plain;
 name="U8-smp1-0.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="U8-smp1-0.txt"

Linux version 2.6.9-rc4-mm1-RT-U8 (bash@devnull.rtsoft) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #3 SMP Wed Oct 20 16:26:38 MSD 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff30000 (usable)
 BIOS-e820: 000000001ff30000 - 000000001ff40000 (ACPI data)
 BIOS-e820: 000000001ff40000 - 000000001fff0000 (ACPI NVS)
 BIOS-e820: 000000001fff0000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000ff780
DMI 2.3 present.
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: ASUSTeK  Product ID: P4P800SE     APIC at: 0xFEE00000
I/O APIC #13 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hda2 console=ttyS0,57600
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2798.899 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 512196k/523456k available (2687k kernel code, 10700k reserved, 1089k data, 184k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 03
per-CPU timeslice cutoff: 2926.33 usecs.
task migration cache decay timeout: 3 msecs.
Booting processor 1/1 eip 2000
Initializing CPU#1
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 03
Total of 2 processors activated (11108.35 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
checking TSC synchronization across 2 CPUs: passed.
ksoftirqd started up.
Brought up 2 CPUs
ksoftirqd started up.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 0000:00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P2) -> 18
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P3) -> 23
PCI->APIC IRQ transform: (B0,I31,P0) -> 18
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI->APIC IRQ transform: (B2,I5,P0) -> 22
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1098277485.061:0): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 865 Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xf8000000
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
elevator: using anticipatory as default io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG SP0411N, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 1024KiB
hda: 78242976 sectors (40060 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 >
BUG: semaphore recursion deadlock detected!
.. current task khpsbpkt/723 is already holding c04610c0.
00001f23 00001f2f c04e8de9 00000086 00000009 00000000 c011b552 00000020 
       00000400 c03b3efa dfdc9f70 dfdc9f50 0000000c dfdc78f0 c011b430 c03b3efa 
       dfdc9f70 c01052a5 c03b3efa c03b3efa 00000000 dfdc78f0 dfdc78f0 c01fd364 
Call Trace:
 [<c012caa4>] __kernel_text_address+0x2e/0x37 (24)
 [<c01051c9>] show_trace+0x4e/0xcc (12)
 [<c01052c9>] show_stack+0x82/0x97 (36)
 [<c01fd364>] __rwsem_deadlock+0xd9/0x135 (24)
 [<c039e2a0>] down_write_interruptible+0xe6/0x202 (48)
 [<c029dd80>] hpsbpkt_thread+0x2b/0x86 (48)
 [<c029dd55>] hpsbpkt_thread+0x0/0x86 (12)
 [<c01024d1>] kernel_thread_helper+0x5/0xb (4)
preempt count: 00000003
. 3-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: _spin_lock+0x19/0x6d / (0x0)
.. entry 3: print_traces+0x17/0x50 / (0x0)

------------[ cut here ]------------
kernel BUG at lib/rwsem-generic.c:498!
invalid operand: 0000 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    1
EIP:    0060:[<c039e2b7>]    Not tainted VLI
EFLAGS: 00010002   (2.6.9-rc4-mm1-RT-U8) 
EIP is at down_write_interruptible+0xfd/0x202
eax: 00000001   ebx: c04610c0   ecx: dfdc8000   edx: 00000001
esi: dfdc78f0   edi: c04610c4   ebp: dfdc9fc0   esp: dfdc9fb4
ds: 007b   es: 007b   ss: 0068   preempt: 00000003
Process khpsbpkt (pid: 723, threadinfo=dfdc8000 task=dfdc78f0)
Stack: c04610c0 000001d6 c04610c0 c04610cc c04610cc dfdc78f0 00000002 dfdc8000 
       00000000 00000000 00000000 c029dd80 c03cd95b ffffffff c029dd55 c01024d1 
       00000000 00000000 00000000 
Call Trace:
 [<c029dd80>] hpsbpkt_thread+0x2b/0x86 (48)
 [<c029dd55>] hpsbpkt_thread+0x0/0x86 (12)
 [<c01024d1>] kernel_thread_helper+0x5/0xb (4)
preempt count: 00000004
. 4-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: _spin_lock+0x19/0x6d / (0x0)
.. entry 3: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 4: print_traces+0x17/0x50 / (0x0)

Code: 44 24 0c 89 68 04 89 2a 89 54 24 10 89 1c 24 e8 eb ef e5 ff 85 c0 74 1b a1 2c e0 41 c0 85 c0 74 12 c7 05 2c e0 41 c0 00 00 00 00 <0f> 0b f2 01 cf 73 3c c0 89 9e 1c 06 00 00 9c 58 c1 e8 09 83 f0 
 <3>BUG: scheduling while atomic: khpsbpkt/0x04000002/723
ieee1394: raw1394: /dev/raw1394 device initialized
ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem 0xfebffc00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:1d.0: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
caller is cond_resched+0x5e/0x7f
 [<c039d128>] __sched_text_start+0x6e0/0x730 (8)
 [<c039daa9>] cond_resched+0x5e/0x7f (8)
 [<c0105aff>] do_invalid_op+0x0/0xf7 (56)
 [<c0105aff>] do_invalid_op+0x0/0xf7<7>PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0xef00
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
 (16)
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 0xef20
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3
 [<c039daa9>] cond_resched+0x5e/0x7f<7>PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 0xef40
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.3: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4
 (8)
 [<c039dee7>]<7>PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: irq 16, io base 0xef80
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
 down_read+0x33/0x18a (16)
 [<c0110963>] smp_apic_timer_interrupt+0x6d/0xe2 (12)
 [<c039e92b>] _spin_unlock_irq+0x18/0x2e (8)
 [<c0105aff>] do_invalid_op+0x0/0xf7 (16)
 [<c011bab5>] profile_task_exit+0x15/0x3e (4)
 [<c011dab4>] do_exit+0x18/0x3b1 (20)
 [<c011007b>] flush_tlb_all+0x26/0x65 (12)
 [<c0105aff>] do_invalid_op+0x0/0xf7 (16)
 [<c0105700>] do_divide_error+0x0/0x117 (8)
 [<c039e2b7>] down_write_interruptible+0xfd/0x202 (40)
 [<c01142ca>] fixup_exception+0x16/0x34 (8)
 [<c0105bf4>] do_invalid_op+0xf5/0xf7 (12)
 [<c039e2b7>] down_write_interruptible+0xfd/0x202 (60)
 [<c011b644>] release_console_sem+0x78/0xb7 (28)
 [<c011b552>] vprintk+0x11e/0x15b (28)
 [<c01052c9>] show_stack+0x82/0x97 (56)
 [<c0104f21>] error_code+0x2d/0x38 (12)
 [<c039e2b7>] down_write_interruptible+0xfd/0x202 (52)
 [<c029dd80>] hpsbpkt_thread+0x2b/0x86 (56)
 [<c029dd55>] hpsbpkt_thread+0x0/0x86<6>input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
 (12)
 [<c01024d1>] kernel_thread_helper+0x5/0xb (4)
preempt count: 04000003
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
. 3-level deep critical section nesting:
PCI: Setting latency timer of device 0000:00:1f.5 to 64
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: _spin_lock+0x19/0x6d / (0x0)
.. entry 3: print_traces+0x17/0x50 / (0x0)

note: khpsbpkt[723] exited with preempt_count 2
BUG: scheduling while atomic: khpsbpkt/0x04000002/723
caller is cond_resched+0x5e/0x7f
 [<c039d128>] __sched_text_start+0x6e0/0x730 (8)
 [<c039daa9>] cond_resched+0x5e/0x7f (8)
 [<c01202d4>] __do_softirq+0x36/0x88 (36)
 [<c039daa9>] cond_resched+0x5e/0x7f (44)
 [<c039e068>] down_write+0x2a/0x17c (16)
 [<c011d22e>] exit_notify+0x28/0x896 (40)
 [<c011b552>] vprintk+0x11e/0x15b (24)
 [<c011dd81>] do_exit+0x2e5/0x3b1 (44)
 [<c0105aff>] do_invalid_op+0x0/0xf7 (28)
 [<c0105700>] do_divide_error+0x0/0x117 (8)
 [<c039e2b7>] down_write_interruptible+0xfd/0x202 (40)
 [<c01142ca>] fixup_exception+0x16/0x34 (8)
 [<c0105bf4>] do_invalid_op+0xf5/0xf7 (12)
 [<c039e2b7>] down_write_interruptible+0xfd/0x202 (60)
 [<c011b644>] release_console_sem+0x78/0xb7 (28)
 [<c011b552>] vprintk+0x11e/0x15b (28)
 [<c01052c9>] show_stack+0x82/0x97 (56)
 [<c0104f21>] error_code+0x2d/0x38 (12)
 [<c039e2b7>] down_write_interruptible+0xfd/0x202 (52)
 [<c029dd80>] hpsbpkt_thread+0x2b/0x86 (56)
 [<c029dd55>] hpsbpkt_thread+0x0/0x86 (12)
 [<c01024d1>] kernel_thread_helper+0x5/0xb (4)
preempt count: 04000003
. 3-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: _spin_lock+0x19/0x6d / (0x0)
.. entry 3: print_traces+0x17/0x50 / (0x0)

BUG: scheduling while atomic: khpsbpkt/0x00000002/723
caller is do_exit+0x2ee/0x3b1
 [<c039d128>] __sched_text_start+0x6e0/0x730 (8)
 [<c011dd8a>] do_exit+0x2ee/0x3b1 (8)
 [<c011d486>] exit_notify+0x280/0x896 (12)
 [<c011dd8a>] do_exit+0x2ee/0x3b1 (68)
 [<c0105aff>] do_invalid_op+0x0/0xf7 (28)
 [<c0105700>] do_divide_error+0x0/0x117 (8)
 [<c039e2b7>] down_write_interruptible+0xfd/0x202 (40)
 [<c01142ca>] fixup_exception+0x16/0x34 (8)
 [<c0105bf4>] do_invalid_op+0xf5/0xf7 (12)
 [<c039e2b7>] down_write_interruptible+0xfd/0x202 (60)
 [<c011b644>] release_console_sem+0x78/0xb7<6>intel8x0_measure_ac97_clock: measured 50107 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel ICH5 with AD1985 at 0xfebff800, irq 17
oprofile: using NMI interrupt.
 (28)
 [<c011b552>] vprintk+0x11e/0x15b<6>NET: Registered protocol family 2
 (28)
 [<c01052c9>] show_stack+0x82/0x97 (56)
 [<c0104f21>] error_code+0x2d/0x38 (12)
 [<c039e2b7>] down_write_interruptible+0xfd/0x202 (52)
 [<c029dd80>] hpsbpkt_thread+0x2b/0x86 (56)
 [<c029dd55>] hpsbpkt_thread+0x0/0x86 (12)
 [<c01024d1>] kernel_thread_helper+0x5/0xb (4)
preempt count: 00000003
. 3-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: _spin_lock+0x19/0x6d / (0x0)
.. entry 3: print_traces+0x17/0x50 / (0x0)

------------[ cut here ]------------
kernel BUG at kernel/sched.c:2768!
invalid operand: 0000 [#2]
PREEMPT SMP 
Modules linked in:
CPU:    1
EIP:    0060:[<c039d094>]    Not tainted VLI
EFLAGS: 00010002   (2.6.9-rc4-mm1-RT-U8) 
EIP is at __sched_text_start+0x64c/0x730
eax: 00000001   ebx: dfdc8000   ecx: dfdc78f0   edx: c14340bc
esi: dfdc78f0   edi: dfdc7a60   ebp: dfdc9e58   esp: dfdc9e08
ds: 007b   es: 007b   ss: 0068   preempt: 00000005
Process khpsbpkt (pid: 723, threadinfo=dfdc8000 task=dfdc78f0)
Stack: dfdc78f0 c1433820 00000002 000002d3 c011d486 c04a6d00 00000011 00000286 
       00000033 dfdc7950 dfdc7994 c1433820 0f5d9fc7 77b2f71c 00000001 dfdc78f0 
       dfdc7a5c c165c780 dfdc78f0 dfdc7db8 dfdc9fc0 c011dd8a dfdc78f0 00000000 
Call Trace:
 [<c011d486>] exit_notify+0x280/0x896 (20)
 [<c011dd8a>] do_exit+0x2ee/0x3b1 (68)
 [<c0105aff>] do_invalid_op+0x0/0xf7 (28)
 [<c0105700>] do_divide_error+0x0/0x117 (8)
 [<c039e2b7>] down_write_interruptible+0xfd/0x202 (40)
 [<c01142ca>] fixup_exception+0x16/0x34 (8)
 [<c0105bf4>] do_invalid_op+0xf5/0xf7 (12)
 [<c039e2b7>] down_write_interruptible+0xfd/0x202 (60)
 [<c011b644>] release_console_sem+0x78/0xb7 (28)
 [<c011b552>] vprintk+0x11e/0x15b (28)
 [<c01052c9>] show_stack+0x82/0x97 (56)
 [<c0104f21>] error_code+0x2d/0x38 (12)
 [<c039e2b7>] down_write_interruptible+0xfd/0x202 (52)
 [<c029dd80>] hpsbpkt_thread+0x2b/0x86 (56)
 [<c029dd55>] hpsbpkt_thread+0x0/0x86 (12)
 [<c01024d1>] kernel_thread_helper+0x5/0xb (4)
preempt count: 00000006
. 6-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: _spin_lock+0x19/0x6d / (0x0)
.. entry 3: __sched_text_start+0x36/0x730 / (0x0)
.. entry 4: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 5: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 6: print_traces+0x17/0x50 / (0x0)

Code: 8b 45 dc 8b 50 08 eb c7 8b 01 85 c0 75 1d 8b 7d ec c7 07 20 00 00 00 89 3c 24 8b 45 dc 89 44 24 04 e8 5b 7b d7 ff e9 fe fa ff ff <0f> 0b d0 0a 82 5c 3b c0 eb d9 8b 7d ec c7 07 00 00 00 00 e9 d9 
 <3>BUG: scheduling while atomic: khpsbpkt/0x04000004/723
caller is cond_resched+0x5e/0x7f
 [<c039d128>] __sched_text_start+0x6e0/0x730 (8)
 [<c039daa9>] cond_resched+0x5e/0x7f (8)
 [<c0116664>] scheduler_tick+0x183/0x517 (28)
 [<c0105aff>] do_invalid_op+0x0/0xf7 (28)
 [<c0105aff>] do_invalid_op+0x0/0xf7 (16)
 [<c039daa9>] cond_resched+0x5e/0x7f (8)
 [<c039dee7>] down_read+0x33/0x18a (16)
 [<c0110963>] smp_apic_timer_interrupt+0x6d/0xe2 (12)
 [<c039e92b>] _spin_unlock_irq+0x18/0x2e (8)
 [<c0105aff>] do_invalid_op+0x0/0xf7 (16)
 [<c011bab5>] profile_task_exit+0x15/0x3e (4)
 [<c011dab4>] do_exit+0x18/0x3b1 (20)
 [<c011007b>] flush_tlb_all+0x26/0x65 (12)
 [<c0105aff>] do_invalid_op+0x0/0xf7 (16)
 [<c0105700>] do_divide_error+0x0/0x117 (8)
 [<c039d094>] __sched_text_start+0x64c/0x730 (40)
 [<c01142ca>] fixup_exception+0x16/0x34 (8)
 [<c0105bf4>] do_invalid_op+0xf5/0xf7 (12)
 [<c039d094>] __sched_text_start+0x64c/0x730 (60)
 [<c011b644>] release_console_sem+0x78/0xb7 (84)
 [<c011b552>] vprintk+0x11e/0x15b (28)
 [<c0104f21>] error_code+0x2d/0x38 (12)
 [<c011007b>] flush_tlb_all+0x26/0x65 (40)
 [<c039d094>] __sched_text_start+0x64c/0x730 (12)
 [<c011d486>] exit_notify+0x280/0x896 (28)
 [<c011dd8a>] do_exit+0x2ee/0x3b1 (68)
 [<c0105aff>] do_invalid_op+0x0/0xf7 (28)
 [<c0105700>] do_divide_error+0x0/0x117 (8)
 [<c039e2b7>] down_write_interruptible+0xfd/0x202 (40)
 [<c01142ca>] fixup_exception+0x16/0x34 (8)
 [<c0105bf4>] do_invalid_op+0xf5/0xf7 (12)
 [<c039e2b7>] down_write_interruptible+0xfd/0x202 (60)
 [<c011b644>] release_console_sem+0x78/0xb7 (28)
 [<c011b552>] vprintk+0x11e/0x15b (28)
 [<c01052c9>] show_stack+0x82/0x97 (56)
 [<c0104f21>] error_code+0x2d/0x38 (12)
 [<c039e2b7>] down_write_interruptible+0xfd/0x202 (52)
 [<c029dd80>] hpsbpkt_thread+0x2b/0x86 (56)
 [<c029dd55>] hpsbpkt_thread+0x0/0x86 (12)
 [<c01024d1>] kernel_thread_helper+0x5/0xb (4)
preempt count: 04000005
. 5-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: _spin_lock+0x19/0x6d / (0x0)
.. entry 3: __sched_text_start+0x36/0x730 / (0x0)
.. entry 4: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 5: print_traces+0x17/0x50 / (0x0)


--------------040005050903030201040608
Content-Type: text/plain;
 name="U8-smp4-noieee.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="U8-smp4-noieee.txt"

Linux version 2.6.9-rc4-mm1-RT-U8 (bash@devnull.rtsoft) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #11 SMP Wed Oct 20 18:49:11 MSD 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff30000 (usable)
 BIOS-e820: 000000001ff30000 - 000000001ff40000 (ACPI data)
 BIOS-e820: 000000001ff40000 - 000000001fff0000 (ACPI NVS)
 BIOS-e820: 000000001fff0000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000ff780
DMI 2.3 present.
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hda2 console=ttyS0,57600
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2798.919 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 512132k/523456k available (2689k kernel code, 10764k reserved, 1111k data, 192k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 03
per-CPU timeslice cutoff: 2926.33 usecs.
task migration cache decay timeout: 3 msecs.
Booting processor 1/1 eip 3000
Initializing CPU#1
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 03
Total of 2 processors activated (11108.35 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
ksoftirqd started up.
Brought up 2 CPUs
ksoftirqd started up.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1098284016.319:0): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU1] (supports C1)
ACPI: Processor [CPU2] (supports C1)
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 865 Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xf8000000
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: Floppy Controller [FDC] at I/O 0x3f0-0x3f5, 0x3f7 irq 6 dma channel 2
elevator: using anticipatory as default io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG SP0411N, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 1024KiB
hda: 78242976 sectors (40060 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 >
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: irq 23, pci mem 0xfebffc00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
uhci_hcd 0000:00:1d.0: irq 16, io base 0xef00
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
uhci_hcd 0000:00:1d.1: irq 19, io base 0xef20
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3
uhci_hcd 0000:00:1d.2: irq 18, io base 0xef40
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.3: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4
uhci_hcd 0000:00:1d.3: irq 16, io base 0xef80
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
AC'97 0 analog subsections not ready
intel8x0_measure_ac97_clock: measured 49987 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel ICH5 with AD1985 at 0xfebff800, irq 17
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 128 buckets, 21Kbytes
TCP: Hash tables configured (established 1024 bind 1560)
ip_conntrack version 2.1 (4089 buckets, 32712 max) - 308 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
ACPI: (supports S0 S1 S3 S4 S5)
ACPI wakeup devices: 
P0P4 MC97 USB1 USB2 USB3 USB4 EUSB PS2K PS2M ILAN 
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 192k freed
[...skip...]
Warning: dev (pts0) tty->count(16) != #fd's(8) in tty_open
Warning: dev (pts0) tty->count(16) != #fd's(11) in tty_open
Warning: dev (pts0) tty->count(17) != #fd's(13) in tty_open
Warning: dev (pts0) tty->count(18) != #fd's(16) in tty_open
Warning: dev (pts0) tty->count(18) != #fd's(16) in tty_open
Warning: dev (pts0) tty->count(18) != #fd's(16) in tty_open
Warning: dev (pts0) tty->count(19) != #fd's(16) in tty_open
Warning: dev (pts0) tty->count(19) != #fd's(16) in release_dev
Warning: dev (pts0) tty->count(18) != #fd's(16) in tty_open
Warning: dev (pts0) tty->count(18) != #fd's(16) in tty_open
Warning: dev (pts0) tty->count(19) != #fd's(17) in tty_open
Warning: dev (pts0) tty->count(19) != #fd's(17) in release_dev
Warning: dev (pts0) tty->count(18) != #fd's(17) in tty_open
Warning: dev (pts0) tty->count(18) != #fd's(17) in tty_open
Warning: dev (pts0) tty->count(19) != #fd's(17) in release_dev
Warning: dev (pts0) tty->count(17) != #fd's(18) in release_dev
Warning: dev (pts0) tty->count(16) != #fd's(19) in release_dev
Warning: dev (pts0) tty->count(15) != #fd's(18) in release_dev
Warning: dev (pts0) tty->count(14) != #fd's(18) in release_dev
Warning: dev (pts0) tty->count(14) != #fd's(18) in release_dev
Warning: dev (pts0) tty->count(13) != #fd's(18) in tty_open
Warning: dev (pts0) tty->count(14) != #fd's(19) in release_dev
Warning: dev (pts0) tty->count(13) != #fd's(18) in release_dev
Warning: dev (pts0) tty->count(13) != #fd's(17) in release_dev
Warning: dev (pts0) tty->count(12) != #fd's(18) in tty_open
Warning: dev (pts0) tty->count(12) != #fd's(18) in release_dev
Warning: dev (pts0) tty->count(12) != #fd's(18) in release_dev
Warning: dev (pts0) tty->count(28) != #fd's(16) in tty_open
Warning: dev (pts0) tty->count(528) != #fd's(13) in tty_open
Warning: dev (pts0) tty->count(528) != #fd's(13) in release_dev
Warning: dev (pts0) tty->count(527) != #fd's(12) in tty_open
Warning: dev (pts0) tty->count(528) != #fd's(12) in release_dev
Warning: dev (pts0) tty->count(538) != #fd's(28) in release_dev
Warning: dev (pts0) tty->count(537) != #fd's(528) in tty_open
Warning: dev (pts0) tty->count(537) != #fd's(527) in release_dev
Warning: dev (pts0) tty->count(536) != #fd's(527) in tty_open
Warning: dev (pts0) tty->count(536) != #fd's(527) in tty_open
Warning: dev (pts0) tty->count(536) != #fd's(527) in release_dev
Warning: dev (pts0) tty->count(535) != #fd's(527) in tty_open
Warning: dev (pts0) tty->count(535) != #fd's(530) in tty_open
[...skip...]
Warning: dev (pts0) tty->count(11) != #fd's(71) in release_dev
Warning: dev (pts0) tty->count(10) != #fd's(71) in release_dev
Warning: dev (pts0) tty->count(9) != #fd's(71) in release_dev
Warning: dev (pts0) tty->count(8) != #fd's(71) in release_dev
Warning: dev (pts0) tty->count(7) != #fd's(71) in release_dev
Warning: dev (pts0) tty->count(6) != #fd's(71) in release_dev
Warning: dev (pts0) tty->count(5) != #fd's(71) in release_dev
Warning: dev (pts0) tty->count(4) != #fd's(71) in release_dev
Warning: dev (pts0) tty->count(3) != #fd's(71) in release_dev
eggcups: page allocation failure. order:1, mode:0x20
 [<c01439d8>] __alloc_pages+0x228/0x3ff (8)
 [<c0143bce>] __get_free_pages+0x1f/0x3b (68)
 [<c014719c>] kmem_getpages+0x25/0xe0 (8)
 [<c0147ee1>] cache_grow+0xca/0x16f (24)
 [<c0148067>] cache_alloc_refill+0xe1/0x230 (52)
 [<c01484a4>] __kmalloc+0x76/0x98 (48)
 [<c0325521>] pskb_expand_head+0x51/0x123 (24)
 [<c032a8ae>] skb_checksum_help+0x103/0x114 (40)
 [<c037a8d7>] ip_nat_fn+0x203/0x215 (36)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c03352bb>] nf_iterate+0x71/0xa5 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (20)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (16)
 [<c03355b9>] nf_hook_slow+0x77/0x125 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c0343bed>] dst_output+0x0/0x29 (28)
 [<c034131a>] ip_finish_output+0x24c/0x251 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (24)
 [<c0343bed>] dst_output+0x0/0x29 (24)
 [<c0343c01>] dst_output+0x14/0x29 (4)
 [<c033561e>] nf_hook_slow+0xdc/0x125 (8)
 [<c0343bed>] dst_output+0x0/0x29 (28)
 [<c0341a9e>] ip_queue_xmit+0x51d/0x61c (32)
 [<c0343bed>] dst_output+0x0/0x29 (24)
 [<c0143645>] buffered_rmqueue+0x89/0x1f4 (28)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (48)
 [<c039e226>] cond_resched+0x20/0x7f (32)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (20)
 [<c039f019>] _spin_unlock+0x12/0x2d (16)
 [<c039f019>] _spin_unlock+0x12/0x2d (16)
 [<c0147f5e>] cache_grow+0x147/0x16f (8)
 [<c035306c>] tcp_transmit_skb+0x521/0x8da (28)
 [<c0353f06>] tcp_write_xmit+0x16a/0x2c7 (72)
 [<c039e226>] cond_resched+0x20/0x7f (16)
 [<c03473fa>] tcp_sendmsg+0x541/0x1260 (40)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (20)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (20)
 [<c039f0e1>] _spin_unlock_irq+0x12/0x2e (48)
 [<c036a404>] inet_sendmsg+0x4d/0x59 (28)
 [<c0320fce>] sock_sendmsg+0xe5/0x100 (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (72)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (28)
 [<c039f019>] _spin_unlock+0x12/0x2d (40)
 [<c0133550>] autoremove_wake_function+0x0/0x57 (52)
 [<c0320d33>] sockfd_lookup+0x1c/0x77 (32)
 [<c0322424>] sys_sendto+0xe3/0xfe (20)
 [<c03221c3>] sys_connect+0x91/0xb1 (68)
 [<c0324ae2>] sock_common_setsockopt+0x36/0x3a (96)
 [<c0322476>] sys_send+0x37/0x3b (40)
 [<c0322ce9>] sys_socketcall+0x139/0x256 (28)
 [<c0105259>] sysenter_past_esp+0x52/0x71 (64)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x50 / (0x0)

eggcups: page allocation failure. order:1, mode:0x20
 [<c01439d8>] __alloc_pages+0x228/0x3ff (8)
 [<c0143bce>] __get_free_pages+0x1f/0x3b (68)
 [<c014719c>] kmem_getpages+0x25/0xe0 (8)
 [<c0147ee1>] cache_grow+0xca/0x16f (24)
 [<c0148067>] cache_alloc_refill+0xe1/0x230 (52)
 [<c01484a4>] __kmalloc+0x76/0x98 (48)
 [<c0325521>] pskb_expand_head+0x51/0x123 (24)
 [<c032a8ae>] skb_checksum_help+0x103/0x114 (40)
 [<c037a8d7>] ip_nat_fn+0x203/0x215 (36)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c03352bb>] nf_iterate+0x71/0xa5 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (20)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (16)
 [<c03355b9>] nf_hook_slow+0x77/0x125 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c0343bed>] dst_output+0x0/0x29 (28)
 [<c034131a>] ip_finish_output+0x24c/0x251 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (24)
 [<c0343bed>] dst_output+0x0/0x29 (24)
 [<c0343c01>] dst_output+0x14/0x29 (4)
 [<c033561e>] nf_hook_slow+0xdc/0x125 (8)
 [<c0343bed>] dst_output+0x0/0x29 (28)
 [<c0341a9e>] ip_queue_xmit+0x51d/0x61c (32)
 [<c0343bed>] dst_output+0x0/0x29 (24)
 [<c0324ee0>] kfree_skbmem+0x24/0x2c (36)
 [<c0324f81>] __kfree_skb+0x99/0xf9 (16)
 [<c034d71c>] tcp_ack_saw_tstamp+0x22/0x57 (8)
 [<c034df0b>] tcp_clean_rtx_queue+0x40b/0x433 (16)
 [<c0324610>] sk_reset_timer+0x1f/0x2f (16)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (52)
 [<c035306c>] tcp_transmit_skb+0x521/0x8da (52)
 [<c0353f06>] tcp_write_xmit+0x16a/0x2c7 (72)
 [<c039e226>] cond_resched+0x20/0x7f (16)
 [<c03473fa>] tcp_sendmsg+0x541/0x1260 (40)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (20)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (20)
 [<c039f0e1>] _spin_unlock_irq+0x12/0x2e (48)
 [<c036a404>] inet_sendmsg+0x4d/0x59 (28)
 [<c0320fce>] sock_sendmsg+0xe5/0x100 (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (72)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (28)
 [<c039f019>] _spin_unlock+0x12/0x2d (40)
 [<c0133550>] autoremove_wake_function+0x0/0x57 (52)
 [<c0320d33>] sockfd_lookup+0x1c/0x77 (32)
 [<c0322424>] sys_sendto+0xe3/0xfe (20)
 [<c03221c3>] sys_connect+0x91/0xb1 (68)
 [<c0324ae2>] sock_common_setsockopt+0x36/0x3a (96)
 [<c0322476>] sys_send+0x37/0x3b (40)
 [<c0322ce9>] sys_socketcall+0x139/0x256 (28)
 [<c0105259>] sysenter_past_esp+0x52/0x71 (64)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x50 / (0x0)

eggcups: page allocation failure. order:1, mode:0x20
 [<c01439d8>] __alloc_pages+0x228/0x3ff (8)
 [<c0143bce>] __get_free_pages+0x1f/0x3b (68)
 [<c014719c>] kmem_getpages+0x25/0xe0 (8)
 [<c0147ee1>] cache_grow+0xca/0x16f (24)
 [<c0148067>] cache_alloc_refill+0xe1/0x230 (52)
 [<c01484a4>] __kmalloc+0x76/0x98 (48)
 [<c0325521>] pskb_expand_head+0x51/0x123 (24)
 [<c032a8ae>] skb_checksum_help+0x103/0x114 (40)
 [<c037a8d7>] ip_nat_fn+0x203/0x215 (36)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c03352bb>] nf_iterate+0x71/0xa5 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (20)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (16)
 [<c03355b9>] nf_hook_slow+0x77/0x125 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c0343bed>] dst_output+0x0/0x29 (28)
 [<c034131a>] ip_finish_output+0x24c/0x251 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (24)
 [<c0343bed>] dst_output+0x0/0x29 (24)
 [<c0343c01>] dst_output+0x14/0x29 (4)
 [<c033561e>] nf_hook_slow+0xdc/0x125 (8)
 [<c0343bed>] dst_output+0x0/0x29 (28)
 [<c0341a9e>] ip_queue_xmit+0x51d/0x61c (32)
 [<c0343bed>] dst_output+0x0/0x29 (24)
 [<c0324ee0>] kfree_skbmem+0x24/0x2c (36)
 [<c0324f81>] __kfree_skb+0x99/0xf9 (16)
 [<c034d71c>] tcp_ack_saw_tstamp+0x22/0x57 (8)
 [<c034df0b>] tcp_clean_rtx_queue+0x40b/0x433 (16)
 [<c0324610>] sk_reset_timer+0x1f/0x2f (16)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (52)
 [<c035306c>] tcp_transmit_skb+0x521/0x8da (52)
 [<c0353f06>] tcp_write_xmit+0x16a/0x2c7 (72)
 [<c039e226>] cond_resched+0x20/0x7f (16)
 [<c03473fa>] tcp_sendmsg+0x541/0x1260 (40)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (20)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (20)
 [<c039f0e1>] _spin_unlock_irq+0x12/0x2e (48)
 [<c036a404>] inet_sendmsg+0x4d/0x59 (28)
 [<c0320fce>] sock_sendmsg+0xe5/0x100 (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (72)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (28)
 [<c039f019>] _spin_unlock+0x12/0x2d (40)
 [<c0133550>] autoremove_wake_function+0x0/0x57 (52)
 [<c0320d33>] sockfd_lookup+0x1c/0x77 (32)
 [<c0322424>] sys_sendto+0xe3/0xfe (20)
 [<c03221c3>] sys_connect+0x91/0xb1 (68)
 [<c0324ae2>] sock_common_setsockopt+0x36/0x3a (96)
 [<c0322476>] sys_send+0x37/0x3b (40)
 [<c0322ce9>] sys_socketcall+0x139/0x256 (28)
 [<c0105259>] sysenter_past_esp+0x52/0x71 (64)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x50 / (0x0)

eggcups: page allocation failure. order:1, mode:0x20
 [<c01439d8>] __alloc_pages+0x228/0x3ff (8)
 [<c0143bce>] __get_free_pages+0x1f/0x3b (68)
 [<c014719c>] kmem_getpages+0x25/0xe0 (8)
 [<c0147ee1>] cache_grow+0xca/0x16f (24)
 [<c0148067>] cache_alloc_refill+0xe1/0x230 (52)
 [<c01484a4>] __kmalloc+0x76/0x98 (48)
 [<c0325521>] pskb_expand_head+0x51/0x123 (24)
 [<c032a8ae>] skb_checksum_help+0x103/0x114 (40)
 [<c037a8d7>] ip_nat_fn+0x203/0x215 (36)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c03352bb>] nf_iterate+0x71/0xa5 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (20)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (16)
 [<c03355b9>] nf_hook_slow+0x77/0x125 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c0343bed>] dst_output+0x0/0x29 (28)
 [<c034131a>] ip_finish_output+0x24c/0x251 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (24)
 [<c0343bed>] dst_output+0x0/0x29 (24)
 [<c0343c01>] dst_output+0x14/0x29 (4)
 [<c033561e>] nf_hook_slow+0xdc/0x125 (8)
 [<c0343bed>] dst_output+0x0/0x29 (28)
 [<c0341a9e>] ip_queue_xmit+0x51d/0x61c (32)
 [<c0343bed>] dst_output+0x0/0x29 (24)
 [<c0324ee0>] kfree_skbmem+0x24/0x2c (36)
 [<c0324f81>] __kfree_skb+0x99/0xf9 (16)
 [<c034d71c>] tcp_ack_saw_tstamp+0x22/0x57 (8)
 [<c034df0b>] tcp_clean_rtx_queue+0x40b/0x433 (16)
 [<c0324610>] sk_reset_timer+0x1f/0x2f (16)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (52)
 [<c035306c>] tcp_transmit_skb+0x521/0x8da (52)
 [<c0353f06>] tcp_write_xmit+0x16a/0x2c7 (72)
 [<c039e226>] cond_resched+0x20/0x7f (16)
 [<c03473fa>] tcp_sendmsg+0x541/0x1260 (40)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (20)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (20)
 [<c039f0e1>] _spin_unlock_irq+0x12/0x2e (48)
 [<c036a404>] inet_sendmsg+0x4d/0x59 (28)
 [<c0320fce>] sock_sendmsg+0xe5/0x100 (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (72)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (28)
 [<c039f019>] _spin_unlock+0x12/0x2d (40)
 [<c0133550>] autoremove_wake_function+0x0/0x57 (52)
 [<c0320d33>] sockfd_lookup+0x1c/0x77 (32)
 [<c0322424>] sys_sendto+0xe3/0xfe (20)
 [<c03221c3>] sys_connect+0x91/0xb1 (68)
 [<c0324ae2>] sock_common_setsockopt+0x36/0x3a (96)
 [<c0322476>] sys_send+0x37/0x3b (40)
 [<c0322ce9>] sys_socketcall+0x139/0x256 (28)
 [<c0105259>] sysenter_past_esp+0x52/0x71 (64)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x50 / (0x0)

eggcups: page allocation failure. order:1, mode:0x20
 [<c01439d8>] __alloc_pages+0x228/0x3ff (8)
 [<c0143bce>] __get_free_pages+0x1f/0x3b (68)
 [<c014719c>] kmem_getpages+0x25/0xe0 (8)
 [<c0147ee1>] cache_grow+0xca/0x16f (24)
 [<c0148067>] cache_alloc_refill+0xe1/0x230 (52)
 [<c01484a4>] __kmalloc+0x76/0x98 (48)
 [<c0325521>] pskb_expand_head+0x51/0x123 (24)
 [<c032a8ae>] skb_checksum_help+0x103/0x114 (40)
 [<c037a8d7>] ip_nat_fn+0x203/0x215 (36)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c03352bb>] nf_iterate+0x71/0xa5 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (20)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (16)
 [<c03355b9>] nf_hook_slow+0x77/0x125 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c0343bed>] dst_output+0x0/0x29 (28)
 [<c034131a>] ip_finish_output+0x24c/0x251 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (24)
 [<c0343bed>] dst_output+0x0/0x29 (24)
 [<c0343c01>] dst_output+0x14/0x29 (4)
 [<c033561e>] nf_hook_slow+0xdc/0x125 (8)
 [<c0343bed>] dst_output+0x0/0x29 (28)
 [<c0341a9e>] ip_queue_xmit+0x51d/0x61c (32)
 [<c0343bed>] dst_output+0x0/0x29 (24)
 [<c0324ee0>] kfree_skbmem+0x24/0x2c (36)
 [<c0324f81>] __kfree_skb+0x99/0xf9 (16)
 [<c034d71c>] tcp_ack_saw_tstamp+0x22/0x57 (8)
 [<c034df0b>] tcp_clean_rtx_queue+0x40b/0x433 (16)
 [<c0324610>] sk_reset_timer+0x1f/0x2f (16)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (52)
 [<c035306c>] tcp_transmit_skb+0x521/0x8da (52)
 [<c0353f06>] tcp_write_xmit+0x16a/0x2c7 (72)
 [<c039e226>] cond_resched+0x20/0x7f (16)
 [<c03473fa>] tcp_sendmsg+0x541/0x1260 (40)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (20)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (20)
 [<c039f0e1>] _spin_unlock_irq+0x12/0x2e (48)
 [<c036a404>] inet_sendmsg+0x4d/0x59 (28)
 [<c0320fce>] sock_sendmsg+0xe5/0x100 (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (72)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (28)
 [<c039f019>] _spin_unlock+0x12/0x2d (40)
 [<c0133550>] autoremove_wake_function+0x0/0x57 (52)
 [<c0320d33>] sockfd_lookup+0x1c/0x77 (32)
 [<c0322424>] sys_sendto+0xe3/0xfe (20)
 [<c03221c3>] sys_connect+0x91/0xb1 (68)
 [<c0324ae2>] sock_common_setsockopt+0x36/0x3a (96)
 [<c0322476>] sys_send+0x37/0x3b (40)
 [<c0322ce9>] sys_socketcall+0x139/0x256 (28)
 [<c0105259>] sysenter_past_esp+0x52/0x71 (64)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x50 / (0x0)

eggcups: page allocation failure. order:1, mode:0x20
 [<c01439d8>] __alloc_pages+0x228/0x3ff (8)
 [<c0143bce>] __get_free_pages+0x1f/0x3b (68)
 [<c014719c>] kmem_getpages+0x25/0xe0 (8)
 [<c0147ee1>] cache_grow+0xca/0x16f (24)
 [<c0148067>] cache_alloc_refill+0xe1/0x230 (52)
 [<c01484a4>] __kmalloc+0x76/0x98 (48)
 [<c0325521>] pskb_expand_head+0x51/0x123 (24)
 [<c032a8ae>] skb_checksum_help+0x103/0x114 (40)
 [<c037a8d7>] ip_nat_fn+0x203/0x215 (36)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c03352bb>] nf_iterate+0x71/0xa5 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (20)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (16)
 [<c03355b9>] nf_hook_slow+0x77/0x125 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c0343bed>] dst_output+0x0/0x29 (28)
 [<c034131a>] ip_finish_output+0x24c/0x251 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (24)
 [<c0343bed>] dst_output+0x0/0x29 (24)
 [<c0343c01>] dst_output+0x14/0x29 (4)
 [<c033561e>] nf_hook_slow+0xdc/0x125 (8)
 [<c0343bed>] dst_output+0x0/0x29 (28)
 [<c0341a9e>] ip_queue_xmit+0x51d/0x61c (32)
 [<c0343bed>] dst_output+0x0/0x29 (24)
 [<c0324ee0>] kfree_skbmem+0x24/0x2c (36)
 [<c0324f81>] __kfree_skb+0x99/0xf9 (16)
 [<c034d71c>] tcp_ack_saw_tstamp+0x22/0x57 (8)
 [<c034df0b>] tcp_clean_rtx_queue+0x40b/0x433 (16)
 [<c0324610>] sk_reset_timer+0x1f/0x2f (16)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (52)
 [<c035306c>] tcp_transmit_skb+0x521/0x8da (52)
 [<c0353f06>] tcp_write_xmit+0x16a/0x2c7 (72)
 [<c039e226>] cond_resched+0x20/0x7f (16)
 [<c03473fa>] tcp_sendmsg+0x541/0x1260 (40)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (20)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (20)
 [<c039f0e1>] _spin_unlock_irq+0x12/0x2e (48)
 [<c036a404>] inet_sendmsg+0x4d/0x59 (28)
 [<c0320fce>] sock_sendmsg+0xe5/0x100 (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (72)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (28)
 [<c039f019>] _spin_unlock+0x12/0x2d (40)
 [<c0133550>] autoremove_wake_function+0x0/0x57 (52)
 [<c0320d33>] sockfd_lookup+0x1c/0x77 (32)
 [<c0322424>] sys_sendto+0xe3/0xfe (20)
 [<c03221c3>] sys_connect+0x91/0xb1 (68)
 [<c0324ae2>] sock_common_setsockopt+0x36/0x3a (96)
 [<c0322476>] sys_send+0x37/0x3b (40)
 [<c0322ce9>] sys_socketcall+0x139/0x256 (28)
 [<c0105259>] sysenter_past_esp+0x52/0x71 (64)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x50 / (0x0)

eggcups: page allocation failure. order:1, mode:0x20
 [<c01439d8>] __alloc_pages+0x228/0x3ff (8)
 [<c0143bce>] __get_free_pages+0x1f/0x3b (68)
 [<c014719c>] kmem_getpages+0x25/0xe0 (8)
 [<c0147ee1>] cache_grow+0xca/0x16f (24)
 [<c0148067>] cache_alloc_refill+0xe1/0x230 (52)
 [<c01484a4>] __kmalloc+0x76/0x98 (48)
 [<c0325521>] pskb_expand_head+0x51/0x123 (24)
 [<c032a8ae>] skb_checksum_help+0x103/0x114 (40)
 [<c037a8d7>] ip_nat_fn+0x203/0x215 (36)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c03352bb>] nf_iterate+0x71/0xa5 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (20)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (16)
 [<c03355b9>] nf_hook_slow+0x77/0x125 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c0343bed>] dst_output+0x0/0x29 (28)
 [<c034131a>] ip_finish_output+0x24c/0x251 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (24)
 [<c0343bed>] dst_output+0x0/0x29 (24)
 [<c0343c01>] dst_output+0x14/0x29 (4)
 [<c033561e>] nf_hook_slow+0xdc/0x125 (8)
 [<c0343bed>] dst_output+0x0/0x29 (28)
 [<c0341a9e>] ip_queue_xmit+0x51d/0x61c (32)
 [<c0343bed>] dst_output+0x0/0x29 (24)
 [<c0324ee0>] kfree_skbmem+0x24/0x2c (36)
 [<c0324f81>] __kfree_skb+0x99/0xf9 (16)
 [<c034d71c>] tcp_ack_saw_tstamp+0x22/0x57 (8)
 [<c034df0b>] tcp_clean_rtx_queue+0x40b/0x433 (16)
 [<c0324610>] sk_reset_timer+0x1f/0x2f (16)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (52)
 [<c035306c>] tcp_transmit_skb+0x521/0x8da (52)
 [<c0353f06>] tcp_write_xmit+0x16a/0x2c7 (72)
 [<c039e226>] cond_resched+0x20/0x7f (16)
 [<c03473fa>] tcp_sendmsg+0x541/0x1260 (40)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (20)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (20)
 [<c039f0e1>] _spin_unlock_irq+0x12/0x2e (48)
 [<c036a404>] inet_sendmsg+0x4d/0x59 (28)
 [<c0320fce>] sock_sendmsg+0xe5/0x100 (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (72)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (28)
 [<c039f019>] _spin_unlock+0x12/0x2d (40)
 [<c0133550>] autoremove_wake_function+0x0/0x57 (52)
 [<c0320d33>] sockfd_lookup+0x1c/0x77 (32)
 [<c0322424>] sys_sendto+0xe3/0xfe (20)
 [<c03221c3>] sys_connect+0x91/0xb1 (68)
 [<c0324ae2>] sock_common_setsockopt+0x36/0x3a (96)
 [<c0322476>] sys_send+0x37/0x3b (40)
 [<c0322ce9>] sys_socketcall+0x139/0x256 (28)
 [<c0105259>] sysenter_past_esp+0x52/0x71 (64)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x50 / (0x0)

eggcups: page allocation failure. order:1, mode:0x20
 [<c01439d8>] __alloc_pages+0x228/0x3ff (8)
 [<c0143bce>] __get_free_pages+0x1f/0x3b (68)
 [<c014719c>] kmem_getpages+0x25/0xe0 (8)
 [<c0147ee1>] cache_grow+0xca/0x16f (24)
 [<c0148067>] cache_alloc_refill+0xe1/0x230 (52)
 [<c01484a4>] __kmalloc+0x76/0x98 (48)
 [<c0325521>] pskb_expand_head+0x51/0x123 (24)
 [<c032a8ae>] skb_checksum_help+0x103/0x114 (40)
 [<c037a8d7>] ip_nat_fn+0x203/0x215 (36)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c03352bb>] nf_iterate+0x71/0xa5 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (20)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (16)
 [<c03355b9>] nf_hook_slow+0x77/0x125 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c0343bed>] dst_output+0x0/0x29 (28)
 [<c034131a>] ip_finish_output+0x24c/0x251 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (24)
 [<c0343bed>] dst_output+0x0/0x29 (24)
 [<c0343c01>] dst_output+0x14/0x29 (4)
 [<c033561e>] nf_hook_slow+0xdc/0x125 (8)
 [<c0343bed>] dst_output+0x0/0x29 (28)
 [<c0341a9e>] ip_queue_xmit+0x51d/0x61c (32)
 [<c0343bed>] dst_output+0x0/0x29 (24)
 [<c0324ee0>] kfree_skbmem+0x24/0x2c (36)
 [<c0324f81>] __kfree_skb+0x99/0xf9 (16)
 [<c034d71c>] tcp_ack_saw_tstamp+0x22/0x57 (8)
 [<c034df0b>] tcp_clean_rtx_queue+0x40b/0x433 (16)
 [<c0324610>] sk_reset_timer+0x1f/0x2f (16)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (52)
 [<c035306c>] tcp_transmit_skb+0x521/0x8da (52)
 [<c0353f06>] tcp_write_xmit+0x16a/0x2c7 (72)
 [<c039e226>] cond_resched+0x20/0x7f (16)
 [<c03473fa>] tcp_sendmsg+0x541/0x1260 (40)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (20)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (20)
 [<c039f0e1>] _spin_unlock_irq+0x12/0x2e (48)
 [<c036a404>] inet_sendmsg+0x4d/0x59 (28)
 [<c0320fce>] sock_sendmsg+0xe5/0x100 (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (72)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (28)
 [<c039f019>] _spin_unlock+0x12/0x2d (40)
 [<c0133550>] autoremove_wake_function+0x0/0x57 (52)
 [<c0320d33>] sockfd_lookup+0x1c/0x77 (32)
 [<c0322424>] sys_sendto+0xe3/0xfe (20)
 [<c03221c3>] sys_connect+0x91/0xb1 (68)
 [<c0324ae2>] sock_common_setsockopt+0x36/0x3a (96)
 [<c0322476>] sys_send+0x37/0x3b (40)
 [<c0322ce9>] sys_socketcall+0x139/0x256 (28)
 [<c0105259>] sysenter_past_esp+0x52/0x71 (64)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x50 / (0x0)

eggcups: page allocation failure. order:1, mode:0x20
 [<c01439d8>] __alloc_pages+0x228/0x3ff (8)
 [<c0143bce>] __get_free_pages+0x1f/0x3b (68)
 [<c014719c>] kmem_getpages+0x25/0xe0 (8)
 [<c0147ee1>] cache_grow+0xca/0x16f (24)
 [<c0148067>] cache_alloc_refill+0xe1/0x230 (52)
 [<c01484a4>] __kmalloc+0x76/0x98 (48)
 [<c0325521>] pskb_expand_head+0x51/0x123 (24)
 [<c032a8ae>] skb_checksum_help+0x103/0x114 (40)
 [<c037a8d7>] ip_nat_fn+0x203/0x215 (36)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c03352bb>] nf_iterate+0x71/0xa5 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (20)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (16)
 [<c03355b9>] nf_hook_slow+0x77/0x125 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c0343bed>] dst_output+0x0/0x29 (28)
 [<c034131a>] ip_finish_output+0x24c/0x251 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (24)
 [<c0343bed>] dst_output+0x0/0x29 (24)
 [<c0343c01>] dst_output+0x14/0x29 (4)
 [<c033561e>] nf_hook_slow+0xdc/0x125 (8)
 [<c0343bed>] dst_output+0x0/0x29 (28)
 [<c0341a9e>] ip_queue_xmit+0x51d/0x61c (32)
 [<c0343bed>] dst_output+0x0/0x29 (24)
 [<c0324ee0>] kfree_skbmem+0x24/0x2c (36)
 [<c0324f81>] __kfree_skb+0x99/0xf9 (16)
 [<c034d71c>] tcp_ack_saw_tstamp+0x22/0x57 (8)
 [<c034df0b>] tcp_clean_rtx_queue+0x40b/0x433 (16)
 [<c0324610>] sk_reset_timer+0x1f/0x2f (16)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (52)
 [<c035306c>] tcp_transmit_skb+0x521/0x8da (52)
 [<c0353f06>] tcp_write_xmit+0x16a/0x2c7 (72)
 [<c039e226>] cond_resched+0x20/0x7f (16)
 [<c03473fa>] tcp_sendmsg+0x541/0x1260 (40)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (20)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (20)
 [<c039f0e1>] _spin_unlock_irq+0x12/0x2e (48)
 [<c036a404>] inet_sendmsg+0x4d/0x59 (28)
 [<c0320fce>] sock_sendmsg+0xe5/0x100 (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (72)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (28)
 [<c039f019>] _spin_unlock+0x12/0x2d (40)
 [<c0133550>] autoremove_wake_function+0x0/0x57 (52)
 [<c0320d33>] sockfd_lookup+0x1c/0x77 (32)
 [<c0322424>] sys_sendto+0xe3/0xfe (20)
 [<c03221c3>] sys_connect+0x91/0xb1 (68)
 [<c0324ae2>] sock_common_setsockopt+0x36/0x3a (96)
 [<c0322476>] sys_send+0x37/0x3b (40)
 [<c0322ce9>] sys_socketcall+0x139/0x256 (28)
 [<c0105259>] sysenter_past_esp+0x52/0x71 (64)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x50 / (0x0)

eggcups: page allocation failure. order:1, mode:0x20
 [<c01439d8>] __alloc_pages+0x228/0x3ff (8)
 [<c0143bce>] __get_free_pages+0x1f/0x3b (68)
 [<c014719c>] kmem_getpages+0x25/0xe0 (8)
 [<c0147ee1>] cache_grow+0xca/0x16f (24)
 [<c0148067>] cache_alloc_refill+0xe1/0x230 (52)
 [<c01484a4>] __kmalloc+0x76/0x98 (48)
 [<c0325521>] pskb_expand_head+0x51/0x123 (24)
 [<c032a8ae>] skb_checksum_help+0x103/0x114 (40)
 [<c037a8d7>] ip_nat_fn+0x203/0x215 (36)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c03352bb>] nf_iterate+0x71/0xa5 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (20)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (16)
 [<c03355b9>] nf_hook_slow+0x77/0x125 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (28)
 [<c0343bed>] dst_output+0x0/0x29 (28)
 [<c034131a>] ip_finish_output+0x24c/0x251 (4)
 [<c0343c16>] ip_finish_output2+0x0/0x1fa (24)
 [<c0343bed>] dst_output+0x0/0x29 (24)
 [<c0343c01>] dst_output+0x14/0x29 (4)
 [<c033561e>] nf_hook_slow+0xdc/0x125 (8)
 [<c0343bed>] dst_output+0x0/0x29 (28)
 [<c0341a9e>] ip_queue_xmit+0x51d/0x61c (32)
 [<c0343bed>] dst_output+0x0/0x29 (24)
 [<c0324ee0>] kfree_skbmem+0x24/0x2c (36)
 [<c0324f81>] __kfree_skb+0x99/0xf9 (16)
 [<c034d71c>] tcp_ack_saw_tstamp+0x22/0x57 (8)
 [<c034df0b>] tcp_clean_rtx_queue+0x40b/0x433 (16)
 [<c0324610>] sk_reset_timer+0x1f/0x2f (16)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (52)
 [<c035306c>] tcp_transmit_skb+0x521/0x8da (52)
 [<c0353f06>] tcp_write_xmit+0x16a/0x2c7 (72)
 [<c039e226>] cond_resched+0x20/0x7f (16)
 [<c03473fa>] tcp_sendmsg+0x541/0x1260 (40)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (20)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (20)
 [<c039f0e1>] _spin_unlock_irq+0x12/0x2e (48)
 [<c036a404>] inet_sendmsg+0x4d/0x59 (28)
 [<c0320fce>] sock_sendmsg+0xe5/0x100 (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (72)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (28)
 [<c039f019>] _spin_unlock+0x12/0x2d (40)
 [<c0133550>] autoremove_wake_function+0x0/0x57 (52)
 [<c0320d33>] sockfd_lookup+0x1c/0x77 (32)
 [<c0322424>] sys_sendto+0xe3/0xfe (20)
 [<c03221c3>] sys_connect+0x91/0xb1 (68)
 [<c0324ae2>] sock_common_setsockopt+0x36/0x3a (96)
 [<c0322476>] sys_send+0x37/0x3b (40)
 [<c0322ce9>] sys_socketcall+0x139/0x256 (28)
 [<c0105259>] sysenter_past_esp+0x52/0x71 (64)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x50 / (0x0)

Warning: trace overflow for c0414d40 (32), increase RWSEM_MAX_OWNERS
... disabling semaphore tracing and deadlock detection.
BUG: sleeping function called from invalid context bash(24154) at drivers/block/ll_rw_blk.c:1283
in_atomic():1 [00000001], irqs_disabled():1
 [<c011c4c7>] __might_sleep+0xbb/0xc9 (8)
 [<c026d24f>] generic_unplug_device+0x1f/0x50 (36)
 [<c026d29b>] blk_backing_dev_unplug+0x1b/0x1d (16)
 [<c01558bc>] swap_unplug_io_fn+0x58/0xb5 (8)
 [<c0162583>] block_sync_page+0x4f/0x58 (36)
 [<c013e5c4>] sync_page+0x50/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: scheduling with irqs disabled: bash/0x04000001/24154
caller is cond_resched+0x5e/0x7f
 [<c039d99f>] schedule+0x6c/0xb9 (8)
 [<c039e264>] cond_resched+0x5e/0x7f (8)
 [<c039e264>] cond_resched+0x5e/0x7f (24)
 [<c026d254>] generic_unplug_device+0x24/0x50 (16)
 [<c026d29b>] blk_backing_dev_unplug+0x1b/0x1d (16)
 [<c01558bc>] swap_unplug_io_fn+0x58/0xb5 (8)
 [<c0162583>] block_sync_page+0x4f/0x58 (36)
 [<c013e5c4>] sync_page+0x50/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 04000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: scheduling while atomic: bash/0x04000001/24154
caller is cond_resched+0x5e/0x7f
 [<c039d8e3>] __sched_text_start+0xbef/0xc3f (8)
 [<c039e264>] cond_resched+0x5e/0x7f (8)
 [<c011f16e>] vprintk+0x11e/0x15b (12)
 [<c0106116>] dump_stack+0x1c/0x20 (56)
 [<c039d99f>] schedule+0x6c/0xb9 (16)
 [<c039e264>] cond_resched+0x5e/0x7f (8)
 [<c039e264>] cond_resched+0x5e/0x7f (24)
 [<c026d254>] generic_unplug_device+0x24/0x50 (16)
 [<c026d29b>] blk_backing_dev_unplug+0x1b/0x1d (16)
 [<c01558bc>] swap_unplug_io_fn+0x58/0xb5 (8)
 [<c0162583>] block_sync_page+0x4f/0x58 (36)
 [<c013e5c4>] sync_page+0x50/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 04000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: scheduling while atomic: bash/0x00000001/24154
caller is down_write+0x14d/0x17c
 [<c039d8e3>] __sched_text_start+0xbef/0xc3f (8)
 [<c039e946>] down_write+0x14d/0x17c (8)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (16)
 [<c039e946>] down_write+0x14d/0x17c (52)
 [<c026d262>] generic_unplug_device+0x32/0x50 (40)
 [<c026d29b>] blk_backing_dev_unplug+0x1b/0x1d (16)
 [<c01558bc>] swap_unplug_io_fn+0x58/0xb5 (8)
 [<c0162583>] block_sync_page+0x4f/0x58 (36)
 [<c013e5c4>] sync_page+0x50/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: scheduling while atomic: bash/0x00000001/24154
caller is io_schedule+0x26/0x30
 [<c039d8e3>] __sched_text_start+0xbef/0xc3f (8)
 [<c039e2c8>] io_schedule+0x26/0x30 (8)
 [<c039e2c8>] io_schedule+0x26/0x30 (116)
 [<c013e5b8>] sync_page+0x44/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: sleeping function called from invalid context bash(24154) at lib/rwsem-generic.c:319
in_atomic():1 [00000001], irqs_disabled():0
 [<c011c4c7>] __might_sleep+0xbb/0xc9 (8)
 [<c039e69d>] down_read+0x2e/0x18a (36)
 [<c015587d>] swap_unplug_io_fn+0x19/0xb5 (40)
 [<c0162583>] block_sync_page+0x4f/0x58 (36)
 [<c013e5c4>] sync_page+0x50/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: scheduling while atomic: bash/0x04000001/24154
caller is cond_resched+0x5e/0x7f
 [<c039d8e3>] __sched_text_start+0xbef/0xc3f (8)
 [<c039e264>] cond_resched+0x5e/0x7f (8)
 [<c011f16e>] vprintk+0x11e/0x15b (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (16)
 [<c0106116>] dump_stack+0x1c/0x20 (40)
 [<c039e264>] cond_resched+0x5e/0x7f (36)
 [<c039e6a2>] down_read+0x33/0x18a (16)
 [<c015587d>] swap_unplug_io_fn+0x19/0xb5 (40)
 [<c0162583>] block_sync_page+0x4f/0x58 (36)
 [<c013e5c4>] sync_page+0x50/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 04000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: scheduling while atomic: bash/0x00000001/24154
caller is down_write+0x14d/0x17c
 [<c039d8e3>] __sched_text_start+0xbef/0xc3f (8)
 [<c039e946>] down_write+0x14d/0x17c (8)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (16)
 [<c039e946>] down_write+0x14d/0x17c (52)
 [<c026d262>] generic_unplug_device+0x32/0x50 (40)
 [<c026d29b>] blk_backing_dev_unplug+0x1b/0x1d (16)
 [<c01558bc>] swap_unplug_io_fn+0x58/0xb5 (8)
 [<c0162583>] block_sync_page+0x4f/0x58 (36)
 [<c013e5c4>] sync_page+0x50/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: scheduling while atomic: bash/0x00000001/24154
caller is io_schedule+0x26/0x30
 [<c039d8e3>] __sched_text_start+0xbef/0xc3f (8)
 [<c039e2c8>] io_schedule+0x26/0x30 (8)
 [<c039e2c8>] io_schedule+0x26/0x30 (116)
 [<c013e5b8>] sync_page+0x44/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: scheduling while atomic: bash/0x00000001/24154
caller is down_write+0x14d/0x17c
 [<c039d8e3>] __sched_text_start+0xbef/0xc3f (8)
 [<c039e946>] down_write+0x14d/0x17c (8)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (16)
 [<c039e946>] down_write+0x14d/0x17c (52)
 [<c026d262>] generic_unplug_device+0x32/0x50 (40)
 [<c026d29b>] blk_backing_dev_unplug+0x1b/0x1d (16)
 [<c01558bc>] swap_unplug_io_fn+0x58/0xb5 (8)
 [<c0162583>] block_sync_page+0x4f/0x58 (36)
 [<c013e5c4>] sync_page+0x50/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: scheduling while atomic: bash/0x00000001/24154
caller is io_schedule+0x26/0x30
 [<c039d8e3>] __sched_text_start+0xbef/0xc3f (8)
 [<c039e2c8>] io_schedule+0x26/0x30 (8)
 [<c039e2c8>] io_schedule+0x26/0x30 (116)
 [<c013e5b8>] sync_page+0x44/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: sleeping function called from invalid context bash(24154) at lib/rwsem-generic.c:319
in_atomic():1 [00000001], irqs_disabled():0
 [<c011c4c7>] __might_sleep+0xbb/0xc9 (8)
 [<c039e69d>] down_read+0x2e/0x18a (36)
 [<c015587d>] swap_unplug_io_fn+0x19/0xb5 (40)
 [<c0162583>] block_sync_page+0x4f/0x58 (36)
 [<c013e5c4>] sync_page+0x50/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: scheduling while atomic: bash/0x04000001/24154
caller is cond_resched+0x5e/0x7f
 [<c039d8e3>] __sched_text_start+0xbef/0xc3f (8)
 [<c039e264>] cond_resched+0x5e/0x7f (8)
 [<c011f16e>] vprintk+0x11e/0x15b (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (16)
 [<c0106116>] dump_stack+0x1c/0x20 (40)
 [<c039e264>] cond_resched+0x5e/0x7f (36)
 [<c039e6a2>] down_read+0x33/0x18a (16)
 [<c015587d>] swap_unplug_io_fn+0x19/0xb5 (40)
 [<c0162583>] block_sync_page+0x4f/0x58 (36)
 [<c013e5c4>] sync_page+0x50/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 04000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: scheduling while atomic: bash/0x00000001/24154
caller is down_write+0x14d/0x17c
 [<c039d8e3>] __sched_text_start+0xbef/0xc3f (8)
 [<c039e946>] down_write+0x14d/0x17c (8)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (16)
 [<c039e946>] down_write+0x14d/0x17c (52)
 [<c026d262>] generic_unplug_device+0x32/0x50 (40)
 [<c026d29b>] blk_backing_dev_unplug+0x1b/0x1d (16)
 [<c01558bc>] swap_unplug_io_fn+0x58/0xb5 (8)
 [<c0162583>] block_sync_page+0x4f/0x58 (36)
 [<c013e5c4>] sync_page+0x50/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: scheduling while atomic: bash/0x00000001/24154
caller is io_schedule+0x26/0x30
 [<c039d8e3>] __sched_text_start+0xbef/0xc3f (8)
 [<c039e2c8>] io_schedule+0x26/0x30 (8)
 [<c039e2c8>] io_schedule+0x26/0x30 (116)
 [<c013e5b8>] sync_page+0x44/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: scheduling while atomic: bash/0x00000001/24154
caller is down_write+0x14d/0x17c
 [<c039d8e3>] __sched_text_start+0xbef/0xc3f (8)
 [<c039e946>] down_write+0x14d/0x17c (8)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (16)
 [<c039e946>] down_write+0x14d/0x17c (52)
 [<c026d262>] generic_unplug_device+0x32/0x50 (40)
 [<c026d29b>] blk_backing_dev_unplug+0x1b/0x1d (16)
 [<c01558bc>] swap_unplug_io_fn+0x58/0xb5 (8)
 [<c0162583>] block_sync_page+0x4f/0x58 (36)
 [<c013e5c4>] sync_page+0x50/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: scheduling while atomic: bash/0x00000001/24154
caller is io_schedule+0x26/0x30
 [<c039d8e3>] __sched_text_start+0xbef/0xc3f (8)
 [<c039e2c8>] io_schedule+0x26/0x30 (8)
 [<c039f019>] _spin_unlock+0x12/0x2d (28)
 [<c039f019>] _spin_unlock+0x12/0x2d (52)
 [<c039e2c8>] io_schedule+0x26/0x30 (36)
 [<c013e5b8>] sync_page+0x44/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: sleeping function called from invalid context bash(24154) at lib/rwsem-generic.c:319
in_atomic():1 [00000001], irqs_disabled():0
 [<c011c4c7>] __might_sleep+0xbb/0xc9 (8)
 [<c039f019>] _spin_unlock+0x12/0x2d (24)
 [<c039e69d>] down_read+0x2e/0x18a (12)
 [<c015587d>] swap_unplug_io_fn+0x19/0xb5 (40)
 [<c0162583>] block_sync_page+0x4f/0x58 (36)
 [<c013e5c4>] sync_page+0x50/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: scheduling while atomic: bash/0x00000001/24154
caller is down_write+0x14d/0x17c
 [<c039d8e3>] __sched_text_start+0xbef/0xc3f (8)
 [<c039e946>] down_write+0x14d/0x17c (8)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (16)
 [<c039e946>] down_write+0x14d/0x17c (52)
 [<c026d262>] generic_unplug_device+0x32/0x50 (40)
 [<c026d29b>] blk_backing_dev_unplug+0x1b/0x1d (16)
 [<c01558bc>] swap_unplug_io_fn+0x58/0xb5 (8)
 [<c0162583>] block_sync_page+0x4f/0x58 (36)
 [<c013e5c4>] sync_page+0x50/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: scheduling while atomic: bash/0x00000001/24154
caller is io_schedule+0x26/0x30
 [<c039d8e3>] __sched_text_start+0xbef/0xc3f (8)
 [<c039e2c8>] io_schedule+0x26/0x30 (8)
 [<c039f019>] _spin_unlock+0x12/0x2d (28)
 [<c039f019>] _spin_unlock+0x12/0x2d (52)
 [<c039e2c8>] io_schedule+0x26/0x30 (36)
 [<c013e5b8>] sync_page+0x44/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: scheduling while atomic: bash/0x00000001/24154
caller is down_write+0x14d/0x17c
 [<c039d8e3>] __sched_text_start+0xbef/0xc3f (8)
 [<c039e946>] down_write+0x14d/0x17c (8)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (16)
 [<c039e946>] down_write+0x14d/0x17c (52)
 [<c026d262>] generic_unplug_device+0x32/0x50 (40)
 [<c026d29b>] blk_backing_dev_unplug+0x1b/0x1d (16)
 [<c01558bc>] swap_unplug_io_fn+0x58/0xb5 (8)
 [<c0162583>] block_sync_page+0x4f/0x58 (36)
 [<c013e5c4>] sync_page+0x50/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: scheduling while atomic: bash/0x00000001/24154
caller is io_schedule+0x26/0x30
 [<c039d8e3>] __sched_text_start+0xbef/0xc3f (8)
 [<c039e2c8>] io_schedule+0x26/0x30 (8)
 [<c039e2c8>] io_schedule+0x26/0x30 (116)
 [<c013e5b8>] sync_page+0x44/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: scheduling while atomic: bash/0x00000001/24154
caller is down_write+0x14d/0x17c
 [<c039d8e3>] __sched_text_start+0xbef/0xc3f (8)
 [<c039e946>] down_write+0x14d/0x17c (8)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (16)
 [<c039e946>] down_write+0x14d/0x17c (52)
 [<c026d262>] generic_unplug_device+0x32/0x50 (40)
 [<c026d29b>] blk_backing_dev_unplug+0x1b/0x1d (16)
 [<c01558bc>] swap_unplug_io_fn+0x58/0xb5 (8)
 [<c0162583>] block_sync_page+0x4f/0x58 (36)
 [<c013e5c4>] sync_page+0x50/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: scheduling while atomic: bash/0x00000001/24154
caller is io_schedule+0x26/0x30
 [<c039d8e3>] __sched_text_start+0xbef/0xc3f (8)
 [<c039e2c8>] io_schedule+0x26/0x30 (8)
 [<c039f019>] _spin_unlock+0x12/0x2d (28)
 [<c039f019>] _spin_unlock+0x12/0x2d (52)
 [<c039e2c8>] io_schedule+0x26/0x30 (36)
 [<c013e5b8>] sync_page+0x44/0x59 (12)
 [<c039e5c0>] __wait_on_bit_lock+0x53/0x61 (8)
 [<c013e574>] sync_page+0x0/0x59 (8)
 [<c013ed4b>] __lock_page+0xa3/0xab (20)
 [<c01335a7>] wake_bit_function+0x0/0x55 (24)
 [<c01335a7>] wake_bit_function+0x0/0x55 (32)
 [<c014e9ce>] do_swap_page+0x219/0x2da (20)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: sleeping function called from invalid context bash(24154) at kernel/mutex.c:25
in_atomic():1 [00000001], irqs_disabled():0
 [<c011c4c7>] __might_sleep+0xbb/0xc9 (8)
 [<c0133970>] _mutex_lock+0x1f/0x3b (36)
 [<c014e847>] do_swap_page+0x92/0x2da (16)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: scheduling while atomic: bash/0x04000001/24154
caller is cond_resched+0x5e/0x7f
 [<c039d8e3>] __sched_text_start+0xbef/0xc3f (8)
 [<c039e264>] cond_resched+0x5e/0x7f (8)
 [<c011f16e>] vprintk+0x11e/0x15b (24)
 [<c0133f74>] check_preempt_timing+0x70/0x1aa (16)
 [<c0106116>] dump_stack+0x1c/0x20 (40)
 [<c039e264>] cond_resched+0x5e/0x7f (36)
 [<c0133975>] _mutex_lock+0x24/0x3b (16)
 [<c014e847>] do_swap_page+0x92/0x2da (16)
 [<c014f175>] handle_mm_fault+0xdf/0x18e (52)
 [<c0117355>] do_page_fault+0x1be/0x595 (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (60)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c0117197>] do_page_fault+0x0/0x595 (12)
 [<c0105d3d>] error_code+0x2d/0x38 (8)
 [<c010521f>] sysenter_past_esp+0x18/0x71 (52)
preempt count: 04000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

BUG: scheduling while atomic: bash/0x00000001/24154
caller is do_exit+0x2ee/0x3b1
 [<c039d8e3>] __sched_text_start+0xbef/0xc3f (8)
 [<c01219a6>] do_exit+0x2ee/0x3b1 (8)
 [<c01210a2>] exit_notify+0x280/0x896 (48)
 [<c01219a6>] do_exit+0x2ee/0x3b1 (68)
 [<c0121b82>] do_group_exit+0x91/0xb5 (36)
 [<c012acfd>] get_signal_to_deliver+0x1bf/0x396 (24)
 [<c01050ea>] do_signal+0xe3/0x11b (48)
 [<c039f019>] _spin_unlock+0x12/0x2d (40)
 [<c015d40e>] vfs_read+0xbf/0x12a (88)
 [<c015d6df>] sys_read+0x51/0x80 (44)
 [<c010517a>] do_notify_resume+0x58/0x5a (28)
 [<c01052f7>] work_notifysig+0x13/0x18 (12)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
.. entry 2: print_traces+0x17/0x50 / (0x0)

INIT: Switching to runlevel: 6
INIT: Sending processes the TERM signal
Stopping atd: [  OK  ]
Stopping keytable:  [  OK  ]
Stopping cups: [  OK  ]
Shutting down xfs: [  OK  ]
Shutting down console mouse services: [  OK  ]
Stopping sshd:[  OK  ]
Shutting down sendmail: [  OK  ]
Shutting down sm-client: [  OK  ]
Stopping xinetd: [  OK  ]
Stopping crond: [  OK  ]
Saving random seed:  [  OK  ]
Stopping NFS statd: 

--------------040005050903030201040608--
