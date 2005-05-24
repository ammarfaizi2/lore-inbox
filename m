Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVEXQ6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVEXQ6t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 12:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVEXQ6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 12:58:48 -0400
Received: from mail4.utc.com ([192.249.46.193]:24476 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S262162AbVEXQjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 12:39:45 -0400
Message-ID: <42935890.2010109@cybsft.com>
Date: Tue, 24 May 2005 11:38:40 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, dwalker@mvista.com,
       Joe King <atom_bomb@rocketmail.com>, ganzinger@mvista.com,
       Lee Revell <rlrevell@joe-job.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
References: <20050523082637.GA15696@elte.hu>
In-Reply-To: <20050523082637.GA15696@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000307010007040708050703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000307010007040708050703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> i have released the -V0.7.47-06 Real-Time Preemption patch, which can be 
> downloaded from the usual place:
> 
>     http://redhat.com/~mingo/realtime-preempt/
> 
> there was more stabilization activity during the past couple of weeks - 
> i think i have all pending patches applied, let me know if something 
> went MIA. I've also applied Mingming's ext3 reservation latency 
> reductions.
> 
> Changes:
> 
>  - more plist fixes (Daniel Walker)
> 
>  - SMP global-RT-reschedule fix (Steven Rostedt)
> 
>  - x86_64 fixes - it builds & boots now (Joe King)
> 
>  - ext3 reservations latency reductions (Mingming Cao)
> 
>  - kstopmachine yield() fixes (Steven Rostedt)
> 
>  - ksoftirqd init fix (George Anzinger)
> 
>  - removed yield() uses from coredumping (suggested by many)
> 
> to build a -V0.7.47-06 tree, the following patches have to be applied:
> 
>    http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
>    http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc4.bz2
>    http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc4-V0.7.47-06
> 
> 	Ingo
> -

Ingo,

I did finally get to capture the log of -RT-2.6.12-rc4-V0.7.47-08 dying 
when booting. I have attached the log and the config. This is on dual 
2.6G Xeon with ht and smp enabled, 512M and IDE. What else can I do (in 
between alligators)? Output from lspci:

[aaektkf@swdev14 ~]$ lspci
00:00.0 Host bridge: Intel Corp. E7505 Memory Controller Hub (rev 03)
00:00.1 Class ff00: Intel Corp. E7505/E7205 Series RAS Controller (rev 03)
00:01.0 PCI bridge: Intel Corp. E7505/E7205 PCI-to-AGP Bridge (rev 03)
00:02.0 PCI bridge: Intel Corp. E7505 Hub Interface B PCI-to-PCI Bridge 
(rev 03)
00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #2 (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #3 (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI 
Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 82)
00:1f.0 ISA bridge: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) LPC Interface 
Bridge (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801DB (ICH4) IDE Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus 
Controller (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX 
440] (rev a3)
02:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03)
02:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
02:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03)
02:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
04:04.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5702X 
Gigabit Ethernet (rev 02)
05:01.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] 
(rev 78)
[aaektkf@swdev14 ~]$

-- 
    kr

--------------000307010007040708050703
Content-Type: text/plain;
 name="kr2.cap"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kr2.cap"

Linux version 2.6.12-rc4-RT-V0.7.47-08 (aaektkf@swdev14.rkd.snds.com) (gcc version 3.4.3 20050227 (Red Hat 3.4.3-22.fc3)) #9 SMP Tue May 24 09:50:14 CDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
 BIOS-e820: 000000001ff70000 - 000000001ff77000 (ACPI data)
 BIOS-e820: 000000001ff77000 - 000000001ff80000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f6b00
DMI present.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Processor #6 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID:   Product ID: PLACER CRB   APIC at: 0xFEE00000
I/O APIC #2 Version 32 at 0xFEC00000.
I/O APIC #3 Version 32 at 0xFEC80000.
I/O APIC #4 Version 32 at 0xFEC80100.
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Processors: 4
Allocating PCI resources starting at 20000000 (gap: 20000000:dec00000)
Real-Time Preemption Support (c) Ingo Molnar
Built 1 zonelists
Kernel command line: ro root=LABEL=/ noacpi console=ttyS0,38400 console=tty0
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2592.879 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 511212k/523712k available (1761k kernel code, 12112k reserved, 818k data, 216k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
Booting processor 1/1 eip 2000
Initializing CPU#1
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
Booting processor 2/6 eip 2000
Initializing CPU#2
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU2: Intel P4/Xeon Extended MCE MSRs (12) available
CPU2: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
Booting processor 3/7 eip 2000
Initializing CPU#3
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU3: Intel P4/Xeon Extended MCE MSRs (12) available
CPU3: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
Total of 4 processors activated (20643.84 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
checking TSC synchronization across 4 CPUs: passed.
spawn_desched_task(00000000)
desched cpu_callback 3/00000000
ksoftirqd started up.
softirq RT prio: 24.
desched cpu_callback 2/00000000
desched thread 0 started up.
desched cpu_callback 3/00000001
desched cpu_callback 2/00000001
ksoftirqd started up.
softirq RT prio: 24.
desched thread 1 started up.
desched cpu_callback 3/00000002
desched cpu_callback 2/00000002
ksoftirqd started up.
softirq RT prio: 24.
desched thread 2 started up.
desched cpu_callback 3/00000003
desched cpu_callback 2/00000003
ksoftirqd started up.
softirq RT prio: 24.
Brought up 4 CPUs
desched thread 3 started up.
checking if image is initramfs... it is
Freeing initrd memory: 392k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd915, last bus=5
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI->APIC IRQ transform: 0000:00:1d.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:1d.1[B] -> IRQ 19
PCI->APIC IRQ transform: 0000:00:1d.2[C] -> IRQ 18
PCI->APIC IRQ transform: 0000:00:1d.7[D] -> IRQ 23
PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:04:04.0[A] -> IRQ 52
PCI->APIC IRQ transform: 0000:05:01.0[A] -> IRQ 22
Simple Boot Flag at 0x36 set to 0x1
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH4: chipset revision 2
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1460-0x1467, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1468-0x146f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD800BB-75CAA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SONY DVD RW DW-U18A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: Host Protected Area detected.
	current capacity is 156250000 sectors (80000 MB)
	native  capacity is 156301488 sectors (80026 MB)
hda: Host Protected Area disabled.
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 < hda5 hda6 hda7 >
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 256 buckets, 18Kbytes
TCP established hash table entries: 32768 (order: 9, 2621440 bytes)
TCP bind hash table entries: 32768 (order: 9, 2359296 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
Starting balanced_irq
Freeing unused kernel memory: 216k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
hm, PI interest held at exit time? Task:
    kstopmachine:  759 [c1667970,   0]-------------------------
udev/757: BUG in set_new_owner at kernel/rt.c:754
 [<c0103d5a>] dump_stack+0x23/0x25 (20)
 [<c01365c7>] set_new_owner+0xd6/0xfb (44)
 [<c02b6b76>] __down_mutex+0x103/0x3c7 (124)
 [<c02b6ed6>] down_read_mutex+0x4c/0x63 (28)
 [<c0138096>] _read_lock+0x1d/0x1f (16)
 [<c017c9be>] d_path+0x28/0x116 (44)
 [<c0184ce6>] seq_path+0x41/0xfb (36)
 [<c0180326>] show_vfsmnt+0x6c/0x176 (40)
 [<c018467d>] seq_read+0xeb/0x2f3 (60)
 [<c016207b>] vfs_read+0xcb/0x134 (36)
 [<c0162350>] sys_read+0x4c/0x73 (44)
 [<c0102e42>] syscall_call+0x7/0xb (-8116)
---------------------------
| preempt count: 00000003 ]
| 3-level deep critical section nesting:
----------------------------------------
.. [<c02b762a>] .... _raw_spin_lock+0x1b/0x85
.....[<c02b6b0a>] ..   ( <= __down_mutex+0x97/0x3c7)
.. [<c02b762a>] .... _raw_spin_lock+0x1b/0x85
.....[<c02b6b5f>] ..   ( <= __down_mutex+0xec/0x3c7)
.. [<c013add4>] .... print_traces+0x1b/0x52
.....[<c0103d5a>] ..   ( <= dump_stack+0x23/0x25)

| waiter struct c1667f1c:
| w->task:
<none>
| lock:
BUGi Un:bBe ton a_dle keompl NUe a  kertel ret.c:r52ce [<c0103ss: 0068  0a/0x63b (000   ecx: c1667970   edx: 00000000
esi: c1667970   edi: c0112725   ebp: dfd8c6b4   esp: dfd8c690
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process kstopmachine (pid: 759, threadinfo=dfd8c000 task=c1667970)
Stack: c1667970 ffffe000 c010007b 0000007b ffffff00 0000000b dfd8c7d4 c02c8a0c 
       c0112725 dfd8c6f4 c010416b 00000000 00000001 dfd8c6cc 00000011 dfd8c7d4 
       c02c8a0c 00000002 000000ff 0000000b c0112725 dfd8c6f4 c011c3d8 00000000 
Call Trace:
 [<c0103d21>] show_stack+0x85/0x9b (28)
 [<c0103ec9>] show_registers+0x16d/0x1e6 (56)
 [<c01040e9>] die+0x10c/0x18e (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f.[<c0103d21>] ..   ( <= show_stack+0x85/0x9b)

Code: 00 00 00 00 00 00 8b 4b 14 f7 c1 ff ff ff ef 0f 85 83 02 00 00 89 34 24 e8 93 1f 02 00 89 34 24 e8 54 4b 03 00 8b 86 5c 04 00 00 <f0> ff 48 04 0f 94 c2 31 c0 84 d2 0f 95 c0 85 c0 89 45 ec 0f 85 
 <1>BUG: Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c011ee46
*pde = 00000000
Oops: 0002 [#16]
PREEMPT SMP 
Modules linked in: jbd
CPU:    0
EIP:    0060:[<c011ee46>]    Not tainted VLI
EFLAGS: 00010246   (2.6.12-rc4-RT-V0.7.47-08) 
EIP is at do_exit+0xb1/0x42a
eax: 00000000   ebx: dfd8c000   ecx: c1667970   edx: 00000000
esi: c1667970   edi: c0112725   ebp: dfd8c9a4   esp: dfd8c980
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process kstopmachine (pid: 759, threadinfo=dfd8c000 task=c1667970)
Stack: c1667970 dfd8c998 c010f468 00000086 dfd8cac4 0000000b dfd8cac4 c02c8a0c 
       c0112725 dfd8c9e4 c010416b 00000000 00000001 dfd8c9bc 0000000f dfd8cac4 
       c02c8a0c 00000002 000000ff 0000000b c0112725 dfd8c9e4 c011c3d8 00000000 
Call Trace:
 [<c0103d21>] show_stack+0x85/0x9b (28)
 [<c0103ec9>] show_registers+0x16d/0x1e6 (56)
 [<c01040e9>] die+0x10c/0x18e (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (84)
 [<c01352cc>] printk_waiter+0x60/0x90 (20)
 [<c011eff1>] do_exit+0x25c/0x42a (44)
 [<c0100fcf>] kernel_thread+0x0/0x8c (539435040)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c02b76af>] .... _raw_spin_lock_irqsave+0x1b/0x8e
.....[<c0104021>] ..   ( <= die+0x44/0x18e)
.. [<c013add4>] .... print_traces+0x1b/0x52
.....[<c0103d21>] ..   ( <= show_stack+0x85/0x9b)

Code: 00 00 00 00 00 00 8b 4b 14 f7 c1 ff ff ff ef 0f 85 83 02 00 00 89 34 24 e8 93 1f 02 00 89 34 24 e8 54 4b 03 00 8b 86 5c 04 00 00 <f0> ff 48 04 0f 94 c2 31 c0 84 d2 0f 95 c0 85 c0 89 45 ec 0f 85 
 <1>BUG: Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c011ee46
*pde = 00000000
Oops: 0002 [#17]
PREEMPT SMP 
Modules linked in: jbd
CPU:    0
EIP:    0060:[<c011ee46>]    Not tainted VLI
EFLAGS: 00010246   (2.6.12-rc4-RT-V0.7.47-08) 
EIP is at do_exit+0xb1/0x42a
eax: 00000000   ebx: dfd8c000   ecx: c1667970   edx: 00000000
esi: c1667970   edi: c0112725   ebp: dfd8c82c   esp: dfd8c808
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process kstopmachine (pid: 759, threadinfo=dfd8c000 task=c1667970)
Stack: c1667970 ffffe000 c010007b 0000007b ffffff00 0000000b dfd8c94c c02c8a0c 
       c0112725 dfd8c86c c010416b 00000000 00000001 dfd8c844 00000010 dfd8c94c 
       c02c8a0c 00000002 000000ff 0000000b c0112725 dfd8c86c c011c3d8 00000000 
Call Trace:
 [<c0103d21>] show_stack+0x85/0x9b (28)
 [<c0103ec9>] show_registers+0x16d/0x1e6 (56)
 [<c01040e9>] die+0x10c/0x18e (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (84)
 [<c01352cc>] printk_waiter+0x60/0x90 (20)
 [<c011eff1>] do_exit+0x25c/0x42a (44)
 [<c0100fcf>] kernel_thread+0x0/0x8c (539435040)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c02b76af>] .... _raw_spin_lock_irqsave+0x1b/0x8e
.....[<c0104021>] ..   ( <= die+0x44/0x18e)
.. [<c013add4>] .... print_traces+0x1b/0x52
.....[<c0103d21>] ..   ( <= show_stack+0x85/0x9b)

Code: 00 00 00 00 00 00 8b 4b 14 f7 c1 ff ff ff ef 0f 85 83 02 00 00 89 34 24 e8 93 1f 02 00 89 34 24 e8 54 4b 03 00 8b 86 5c 04 00 00 <f0> ff 48 04 0f 94 c2 31 c0 84 d2 0f 95 c0 85 c0 89 45 ec 0f 85 
 <1>BUG: Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c011ee46
*pde = 00000000
Oops: 0002 [#18]
PREEMPT SMP 
Modules linked in: jbd
CPU:    0
EIP:    0060:[<c011ee46>]    Not tainted VLI
EFLAGS: 00010246   (2.6.12-rc4-RT-V0.7.47-08) 
EIP is at do_exit+0xb1/0x42a
eax: 00000000   ebx: dfd8c000   ecx: c1667970   edx: 00000000
esi: c1667970   edi: c0112725   ebp: dfd8c6b4   esp: dfd8c690
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process kstopmachine (pid: 759, threadinfo=dfd8c000 task=c1667970)
Stack: c1667970 ffffe000 c010007b 0000007b ffffff00 0000000b dfd8c7d4 c02c8a0c 
       c0112725 dfd8c6f4 c010416b 00000000 00000001 dfd8c6cc 00000011 dfd8c7d4 
       c02c8a0c 00000002 000000ff 0000000b c0112725 dfd8c6f4 c011c3d8 00000000 
Call Trace:
 [<c0103d21>] show_stack+0x85/0x9b (28)
 [<c0103ec9>] show_registers+0x16d/0x1e6 (56)
 [<c01040e9>] die+0x10c/0x18e (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (84)
 [<c01352cc>] printk_waiter+0x60/0x90 (20)
 [<c011eff1>] do_exit+0x25c/0x42a (44)
 [<c0100fcf>] kernel_thread+0x0/0x8c (539435040)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c02b76af>] .... _raw_spin_lock_irqsave+0x1b/0x8e
.....[<c0104021>] ..   ( <= die+0x44/0x18e)
.. [<c013add4>] .... print_traces+0x1b/0x52
.....[<c0103d21>] ..   ( <= show_stack+0x85/0x9b)

Code: 00 00 00 00 00 00 8b 4b 14 f7 c1 ff ff ff ef 0f 85 83 02 00 00 89 34 24 e8 93 1f 02 00 89 34 24 e8 54 4b 03 00 8b 86 5c 04 00 00 <f0> ff 48 04 0f 94 c2 31 c0 84 d2 0f 95 c0 85 c0 89 45 ec 0f 85 
 <1>BUG: Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c011ee46
*pde = 00000000
Oops: 0002 [#19]
PREEMPT SMP 
Modules linked in: jbd
CPU:    0
EIP:    0060:[<c011ee46>]    Not tainted VLI
EFLAGS: 00010246   (2.6.12-rc4-RT-V0.7.47-08) 
EIP is at do_exit+0xb1/0x42a
eax: 00000000   ebx: dfd8c000   ecx: c1667970   edx: 00000000
esi: c1667970   edi: c0112725   ebp: dfd8c53c   esp: dfd8c518
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process kstopmachine (pid: 759, threadinfo=dfd8c000 task=c1667970)
Stack: c1667970 dfd8c530 c010f468 00000086 dfd8c65c 0000000b dfd8c65c c02c8a0c 
       c0112725 dfd8c57c c010416b 00000000 00000001 dfd8c554 00000012 dfd8c65c 
       c02c8a0c 00000002 000000ff 0000000b c0112725 dfd8c57c c011c3d8 00000000 
Call Trace:
 [<c0103d21>] show_stack+0x85/0x9b (28)
 [<c0103ec9>] show_registers+0x16d/0x1e6 (56)
 [<c01040e9>] die+0x10c/0x18e (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (96)
 [<c010416b>] do_trap+0x0/0xde (64)
 [<c0112b2f>] do_page_fault+0x40a/0x63b (216)
 [<c010393f>] error_code+0x4f/0x54 (84)
 [<c01352cc>] printk_waiter+0x60/0x90 (20)
 [<c011eff1>] do_exit+0x25c/0x42a (44)
 [<c0100fcf>] kernel_thread+0x0/0x8c (539435040)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c02b76af>] .... _raw_spin_lock_irqsave+0x1b/0x8e
.....[<c0104021>] ..   ( <= die+0x44/0x18e)
.. [<c013add4>] .... print_traces+0x1b/0x52
.....[<c0103d21>] ..   ( <= show_stack+0x85/0x9b)

Code: 00 00 00 00 00 00 8b 4b 14 f7 c1 ff ff ff ef 0f 85 83 02 00 00 89 34 24 e8 93 1f 02 00 89 34 24 e8 54 4b 03 00 8b 86 5c 04 00 00 <f0> ff 48 04 0f 94 c2 31 c0 84 d2 0f 95 c0 85 c0 89 45 ec 0f 85 
 <1>BUG: Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c011ee46
*pde = 00000000
Oops: 0002 [#20]
PREEMPT SMP 
Modules linked in: jbd
CPU:    0
EIP:    0060:[<c011ee46>]    Not tainted VLI
EFLAGS: 00010246   (2.6.12-rc4-RT-V0.7.47-08) 
BUG at kernel/latency.c:1255!

--------------000307010007040708050703
Content-Type: text/plain;
 name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.12-rc4-RT-V0.7.47-08
# Tue May 24 09:49:06 2005
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

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
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_CPUSETS is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

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
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HPET_TIMER is not set
CONFIG_SMP=y
CONFIG_NR_CPUS=8
CONFIG_SCHED_SMT=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT_DESKTOP is not set
CONFIG_PREEMPT_RT=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_SOFTIRQS=y
CONFIG_PREEMPT_HARDIRQS=y
CONFIG_PREEMPT_RCU=y
CONFIG_PREEMPT_BKL=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_ASM_SEMAPHORES=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m

#
# Firmware Drivers
#
CONFIG_EDD=m
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_IRQBALANCE=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_SECCOMP=y

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set
CONFIG_ACPI_BOOT=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
CONFIG_BLK_CPQ_DA=m
CONFIG_BLK_CPQ_CISS_DA=m
CONFIG_CISS_SCSI_TAPE=y
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=8192
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_LBD is not set
# CONFIG_CDROM_PKTCDVD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
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
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_IDEPNP is not set
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
# CONFIG_BLK_DEV_ATIIXP is not set
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_TRIFLEX=y
CONFIG_BLK_DEV_CY82C693=y
# CONFIG_BLK_DEV_CS5520 is not set
CONFIG_BLK_DEV_CS5530=y
CONFIG_BLK_DEV_HPT34X=y
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=y
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=y
# CONFIG_PDC202XX_BURST is not set
CONFIG_BLK_DEV_PDC202XX_NEW=y
# CONFIG_PDC202XX_FORCE is not set
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BLK_DEV_SIIMAGE=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
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
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set

#
# SCSI low-level drivers
#
CONFIG_BLK_DEV_3W_XXXX_RAID=m
# CONFIG_SCSI_3W_9XXX is not set
CONFIG_SCSI_7000FASST=m
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AHA152X=m
CONFIG_SCSI_AHA1542=m
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
CONFIG_SCSI_AIC7XXX_OLD=m
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_ENABLE_RD_STRM is not set
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_DPT_I2O is not set
CONFIG_SCSI_IN2000=m
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_AHCI is not set
CONFIG_SCSI_SATA_SVW=m
CONFIG_SCSI_ATA_PIIX=m
# CONFIG_SCSI_SATA_NV is not set
CONFIG_SCSI_SATA_PROMISE=m
# CONFIG_SCSI_SATA_QSTOR is not set
# CONFIG_SCSI_SATA_SX4 is not set
CONFIG_SCSI_SATA_SIL=m
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_ULI is not set
CONFIG_SCSI_SATA_VIA=m
# CONFIG_SCSI_SATA_VITESSE is not set
CONFIG_SCSI_BUSLOGIC=m
# CONFIG_SCSI_OMIT_FLASHPOINT is not set
CONFIG_SCSI_DMX3191D=m
CONFIG_SCSI_DTC3280=m
CONFIG_SCSI_EATA=m
CONFIG_SCSI_EATA_TAGGED_QUEUE=y
# CONFIG_SCSI_EATA_LINKED_COMMANDS is not set
CONFIG_SCSI_EATA_MAX_TAGS=16
CONFIG_SCSI_FUTURE_DOMAIN=m
CONFIG_SCSI_GDTH=m
CONFIG_SCSI_GENERIC_NCR5380=m
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_GENERIC_NCR53C400 is not set
CONFIG_SCSI_IPS=m
# CONFIG_SCSI_INITIO is not set
CONFIG_SCSI_INIA100=m
CONFIG_SCSI_NCR53C406A=m
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
# CONFIG_SCSI_IPR is not set
CONFIG_SCSI_PAS16=m
CONFIG_SCSI_PSI240I=m
CONFIG_SCSI_QLOGIC_FAS=m
CONFIG_SCSI_QLOGIC_FC=m
# CONFIG_SCSI_QLOGIC_FC_FIRMWARE is not set
CONFIG_SCSI_QLOGIC_1280=m
# CONFIG_SCSI_QLOGIC_1280_1040 is not set
CONFIG_SCSI_QLA2XXX=m
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_LPFC is not set
CONFIG_SCSI_SYM53C416=m
# CONFIG_SCSI_DC395x is not set
CONFIG_SCSI_DC390T=m
CONFIG_SCSI_T128=m
CONFIG_SCSI_U14_34F=m
# CONFIG_SCSI_U14_34F_TAGGED_QUEUE is not set
# CONFIG_SCSI_U14_34F_LINKED_COMMANDS is not set
CONFIG_SCSI_U14_34F_MAX_TAGS=8
CONFIG_SCSI_ULTRASTOR=m
CONFIG_SCSI_NSP32=m
CONFIG_SCSI_DEBUG=m

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
# CONFIG_MD_RAID10 is not set
CONFIG_MD_RAID5=m
# CONFIG_MD_RAID6 is not set
CONFIG_MD_MULTIPATH=m
# CONFIG_MD_FAULTY is not set
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_CRYPT is not set
# CONFIG_DM_SNAPSHOT is not set
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_ZERO is not set
# CONFIG_DM_MULTIPATH is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
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
CONFIG_IP_TCPDIAG=y
# CONFIG_IP_TCPDIAG_IPV6 is not set

#
# IP: Virtual Server Configuration
#
CONFIG_IP_VS=m
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=16

#
# IPVS transport protocol load balancing support
#
# CONFIG_IP_VS_PROTO_TCP is not set
# CONFIG_IP_VS_PROTO_UDP is not set
# CONFIG_IP_VS_PROTO_ESP is not set
# CONFIG_IP_VS_PROTO_AH is not set

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
# CONFIG_IP_VS_SED is not set
# CONFIG_IP_VS_NQ is not set

#
# IPVS application helper
#
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_BRIDGE_NETFILTER=y

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CONNTRACK_MARK is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
# CONFIG_IP_NF_MATCH_IPRANGE is not set
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
# CONFIG_IP_NF_MATCH_PHYSDEV is not set
# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
# CONFIG_IP_NF_MATCH_REALM is not set
# CONFIG_IP_NF_MATCH_SCTP is not set
# CONFIG_IP_NF_MATCH_COMMENT is not set
# CONFIG_IP_NF_MATCH_HASHLIMIT is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
# CONFIG_IP_NF_TARGET_NETMAP is not set
# CONFIG_IP_NF_TARGET_SAME is not set
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
# CONFIG_IP_NF_TARGET_CLASSIFY is not set
# CONFIG_IP_NF_RAW is not set
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

#
# Bridge: Netfilter Configuration
#
# CONFIG_BRIDGE_NF_EBTABLES is not set
CONFIG_XFRM=y
CONFIG_XFRM_USER=m

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
CONFIG_ATM=y
CONFIG_ATM_CLIP=y
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=m
CONFIG_ATM_BR2684=m
CONFIG_ATM_BR2684_IPFILTER=y
CONFIG_BRIDGE=m
CONFIG_VLAN_8021Q=m
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
CONFIG_IPX=m
# CONFIG_IPX_INTERN is not set
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=y
CONFIG_LTPC=m
CONFIG_COPS=m
CONFIG_COPS_DAYNA=y
CONFIG_COPS_TANGENT=y
CONFIG_IPDDP=m
CONFIG_IPDDP_ENCAP=y
CONFIG_IPDDP_DECAP=y
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
CONFIG_NET_DIVERT=y
# CONFIG_ECONET is not set
CONFIG_WAN_ROUTER=m

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CLK_JIFFIES=y
# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
# CONFIG_NET_SCH_CLK_CPU is not set
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
# CONFIG_NET_SCH_HFSC is not set
# CONFIG_NET_SCH_ATM is not set
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
# CONFIG_NET_SCH_NETEM is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
# CONFIG_NET_CLS_BASIC is not set
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
# CONFIG_CLS_U32_PERF is not set
# CONFIG_NET_CLS_IND is not set
# CONFIG_CLS_U32_MARK is not set
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
# CONFIG_NET_EMATCH is not set
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=y
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
CONFIG_HAPPYMEAL=m
CONFIG_SUNGEM=m
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL1=m
CONFIG_EL2=m
CONFIG_ELPLUS=m
CONFIG_EL16=m
CONFIG_EL3=m
CONFIG_3C515=m
CONFIG_VORTEX=m
CONFIG_TYPHOON=m
CONFIG_LANCE=m
CONFIG_NET_VENDOR_SMC=y
CONFIG_WD80x3=m
CONFIG_ULTRA=m
CONFIG_SMC9194=m
CONFIG_NET_VENDOR_RACAL=y
CONFIG_NI52=m
CONFIG_NI65=m

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
CONFIG_AT1700=m
CONFIG_DEPCA=m
CONFIG_HP100=m
CONFIG_NET_ISA=y
CONFIG_E2100=m
CONFIG_EWRK3=m
CONFIG_EEXPRESS=m
CONFIG_EEXPRESS_PRO=m
CONFIG_HPLAN_PLUS=m
CONFIG_HPLAN=m
CONFIG_LP486E=m
CONFIG_ETH16I=m
CONFIG_NE2000=m
# CONFIG_ZNET is not set
# CONFIG_SEEQ8005 is not set
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
CONFIG_AMD8111_ETH=m
# CONFIG_AMD8111E_NAPI is not set
CONFIG_ADAPTEC_STARFIRE=m
# CONFIG_ADAPTEC_STARFIRE_NAPI is not set
CONFIG_AC3200=m
CONFIG_APRICOT=m
CONFIG_B44=m
# CONFIG_FORCEDETH is not set
CONFIG_CS89x0=m
CONFIG_DGRS=m
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
CONFIG_SUNDANCE=m
# CONFIG_SUNDANCE_MMIO is not set
CONFIG_TLAN=m
CONFIG_VIA_RHINE=m
# CONFIG_VIA_RHINE_MMIO is not set
CONFIG_NET_POCKET=y
CONFIG_ATP=m
CONFIG_DE600=m
CONFIG_DE620=m

#
# Ethernet (1000 Mbit)
#
CONFIG_ACENIC=m
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_DL2K=m
CONFIG_E1000=m
CONFIG_E1000_NAPI=y
CONFIG_NS83820=m
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=m
CONFIG_R8169=m
# CONFIG_R8169_NAPI is not set
# CONFIG_R8169_VLAN is not set
CONFIG_SK98LIN=m
# CONFIG_VIA_VELOCITY is not set
CONFIG_TIGON3=m

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
CONFIG_TR=y
CONFIG_IBMTR=m
CONFIG_IBMOL=m
CONFIG_IBMLS=m
CONFIG_3C359=m
CONFIG_TMS380TR=m
CONFIG_TMSPCI=m
# CONFIG_SKISA is not set
# CONFIG_PROTEON is not set
CONFIG_ABYSS=m
CONFIG_SMCTR=m

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# ATM drivers
#
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E_MAYBE is not set
# CONFIG_ATM_HE is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
# CONFIG_PPP_BSDCOMP is not set
CONFIG_PPPOE=m
CONFIG_PPPOATM=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_NET_FC=y
CONFIG_SHAPER=m
CONFIG_NETCONSOLE=m

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

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
CONFIG_INPUT_EVDEV=m
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
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_UINPUT is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_ROCKETPORT=m
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_ISI is not set
CONFIG_SYNCLINK=m
# CONFIG_SYNCLINKMP is not set
CONFIG_N_HDLC=m
# CONFIG_SPECIALIX is not set
# CONFIG_SX is not set
CONFIG_STALDRV=y

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

#
# IPMI
#
CONFIG_IPMI_HANDLER=m
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
# CONFIG_IPMI_SI is not set
CONFIG_IPMI_WATCHDOG=m
# CONFIG_IPMI_POWEROFF is not set

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
CONFIG_WAFER_WDT=m
# CONFIG_I8XX_TCO is not set
CONFIG_SC1200_WDT=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_W83627HF_WDT is not set
CONFIG_W83877F_WDT=m
CONFIG_MACHZ_WDT=m

#
# ISA-based Watchdog Cards
#
CONFIG_PCWATCHDOG=m
# CONFIG_MIXCOMWD is not set
CONFIG_WDT=m
# CONFIG_WDT_501 is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
CONFIG_WDTPCI=m
# CONFIG_WDT_501_PCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_RTC_HISTOGRAM=y
CONFIG_BLOCKER=y
CONFIG_DTLK=m
CONFIG_R3964=m
# CONFIG_APPLICOM is not set
CONFIG_SONYPI=m

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=m
CONFIG_AGP_ALI=m
CONFIG_AGP_ATI=m
CONFIG_AGP_AMD=m
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=m
CONFIG_AGP_NVIDIA=m
CONFIG_AGP_SIS=m
CONFIG_AGP_SWORKS=m
CONFIG_AGP_VIA=m
# CONFIG_AGP_EFFICEON is not set
# CONFIG_DRM is not set
CONFIG_MWAVE=m
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set

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
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=m
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
# CONFIG_I2C_AMD756_S4882 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_I810=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_ISA=m
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_SIS5595=m
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_VOODOO3=m
# CONFIG_I2C_PCA_ISA is not set

#
# Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_ADM1021=m
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_FSCPOS is not set
CONFIG_SENSORS_GL518SM=m
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM75=m
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set

#
# Other I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_PCF8574=m
CONFIG_SENSORS_PCF8591=m
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

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
CONFIG_FB_SOFT_CURSOR=y
# CONFIG_FB_MACMODES is not set
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y
# CONFIG_FB_CIRRUS is not set
CONFIG_FB_PM2=m
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=m
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_HGA=m
# CONFIG_FB_HGA_ACCEL is not set
# CONFIG_FB_NVIDIA is not set
CONFIG_FB_RIVA=m
# CONFIG_FB_RIVA_I2C is not set
# CONFIG_FB_RIVA_DEBUG is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_INTEL is not set
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
# CONFIG_FB_MATROX_G is not set
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MULTIHEAD=y
# CONFIG_FB_RADEON_OLD is not set
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_I2C=y
# CONFIG_FB_RADEON_DEBUG is not set
CONFIG_FB_ATY128=m
CONFIG_FB_ATY=m
CONFIG_FB_ATY_CT=y
# CONFIG_FB_ATY_GENERIC_LCD is not set
# CONFIG_FB_ATY_XL_INIT is not set
CONFIG_FB_ATY_GX=y
# CONFIG_FB_SAVAGE is not set
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_NEOMAGIC=m
# CONFIG_FB_KYRO is not set
CONFIG_FB_3DFX=m
# CONFIG_FB_3DFX_ACCEL is not set
CONFIG_FB_VOODOO1=m
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_MDA_CONSOLE=m
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE is not set

#
# Logo configuration
#
# CONFIG_LOGO is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
# CONFIG_SND is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
# CONFIG_USB_BLUETOOTH_TTY is not set
CONFIG_USB_MIDI=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
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

#
# USB Input Devices
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m

#
# USB Multimedia devices
#
CONFIG_USB_DABUSB=m

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m

#
# USB Host-to-Host Cables
#
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_GENESYS=y
CONFIG_USB_NET1080=y
CONFIG_USB_PL2301=y
CONFIG_USB_KC2190=y

#
# Intelligent USB Devices/Gadgets
#
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_ZAURUS=y
CONFIG_USB_CDCETHER=y

#
# USB Network Adapters
#
CONFIG_USB_AX8817X=y
CONFIG_USB_MON=m

#
# USB port drivers
#

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_AIRPRIME is not set
CONFIG_USB_SERIAL_BELKIN=m
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
# CONFIG_USB_SERIAL_KEYSPAN_MPR is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
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
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_EZUSB=y

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
CONFIG_USB_AUERSWALD=m
CONFIG_USB_RIO500=m
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=m
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_TEST is not set

#
# USB ATM/DSL drivers
#
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m

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
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=m
# CONFIG_JFS_POSIX_ACL is not set
# CONFIG_JFS_SECURITY is not set
CONFIG_JFS_DEBUG=y
# CONFIG_JFS_STATISTICS is not set
CONFIG_FS_POSIX_ACL=y

#
# XFS support
#
# CONFIG_XFS_FS is not set
CONFIG_MINIX_FS=m
CONFIG_ROMFS_FS=m
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m

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
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
CONFIG_SYSV_FS=m
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_CIFS is not set
CONFIG_NCP_FS=m
CONFIG_NCPFS_PACKET_SIGNING=y
CONFIG_NCPFS_IOCTL_LOCKING=y
CONFIG_NCPFS_STRONG=y
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
CONFIG_NCPFS_SMALLDOS=y
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y
CONFIG_CODA_FS=m
# CONFIG_CODA_FS_OLD_API is not set
CONFIG_AFS_FS=m
CONFIG_RXRPC=m

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
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
# CONFIG_NLS_ASCII is not set
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
# Profiling support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=m

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=y
CONFIG_WAKEUP_TIMING=y
CONFIG_PREEMPT_TRACE=y
# CONFIG_CRITICAL_PREEMPT_TIMING is not set
# CONFIG_CRITICAL_IRQSOFF_TIMING is not set
CONFIG_LATENCY_TIMING=y
CONFIG_LATENCY_TRACE=y
CONFIG_MCOUNT=y
CONFIG_RT_DEADLOCK_DETECT=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
CONFIG_FRAME_POINTER=y
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_KEYS is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=y
# CONFIG_SECURITY_ROOTPLUG is not set
# CONFIG_SECURITY_SECLVL is not set
# CONFIG_SECURITY_SELINUX is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_AES_586 is not set
CONFIG_CRYPTO_CAST5=m
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_DEFLATE=m
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y

--------------000307010007040708050703--
