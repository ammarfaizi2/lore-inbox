Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263556AbUC3JKr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 04:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263548AbUC3JKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 04:10:47 -0500
Received: from pop.gmx.net ([213.165.64.20]:53962 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263565AbUC3JI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 04:08:29 -0500
X-Authenticated: #1444759
Message-ID: <40693905.4050108@gmx.de>
Date: Tue, 30 Mar 2004 11:08:21 +0200
From: Bernd Fuhrmann <silverbanana@gmx.de>
Reply-To: silverbanana@gmx.de
Organization: Private
User-Agent: Mozilla Thunderbird 0.5+ (Windows/20040317)
X-Accept-Language: en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: usage of RealTek 8169 crashes my Linux system
References: <40673495.3050500@gmx.de> <4067378B.7070102@pobox.com> <4067489E.2090400@gmx.de> <20040329003600.A24995@electric-eye.fr.zoreil.com> <40687B75.3090709@gmx.de> <20040329215631.A4694@electric-eye.fr.zoreil.com>
In-Reply-To: <20040329215631.A4694@electric-eye.fr.zoreil.com>
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> Could you verify that the computer is otherwise stable if you issue a
> 'dd if=/dev/hda of=/dev/null bs=1024k' for 120~150 seconds ?

It worked always stable (except when using that r8169). I've tried dd 
and it didn't crash. I've tried all kinds of other things (like playing 
games, installing all kinds of stuff, etc.) and it didn't crash.

r8169 works finally with 2.6.5rc2mm5 and your patch (haven't tried 
2.6.5rc2mm5 alone). At least it didn't crash so far (transfered GBs 
through it). Thanks a lot for your help!

> An output of lspci -vx/dmesg/lsmod is always welcome btw.

No problem. Here it is, so you can find out what exactly might have 
caused the crash. Hopefully this improvement will find it's way into one 
of the next main kernel releases.

------------------
lspci -vx
0000:00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP 
[IGD4-2P] Syst
em Controller (rev 20)
         Flags: bus master, 66MHz, medium devsel, latency 32
         Memory at f8000000 (32-bit, prefetchable)
         Memory at f4c00000 (32-bit, prefetchable) [size=4K]
         I/O ports at 1010 [disabled] [size=4]
         Capabilities: [a0] AGP version 2.0
00: 22 10 0c 70 06 00 30 22 20 00 00 06 00 20 00 00
10: 08 00 00 f8 08 00 c0 f4 11 10 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP 
[IGD4-2P] AGP B
ridge (prog-if 00 [Normal decode])
         Flags: bus master, 66MHz, medium devsel, latency 99
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
         Memory behind bridge: f4000000-f48fffff
         Prefetchable memory behind bridge: f6000000-f7ffffff
00: 22 10 0d 70 07 00 20 02 00 00 04 06 00 63 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 f1 01 20 22
20: 00 f4 80 f4 00 f6 f0 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 0c 00

0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA 
(rev 05
)
         Flags: bus master, 66MHz, medium devsel, latency 0
00: 22 10 40 74 0f 00 20 02 05 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] 
IDE (rev
  04) (prog-if 8a [Master SecP PriP])
         Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
         Flags: bus master, medium devsel, latency 0
         I/O ports at f000 [size=16]
00: 22 10 41 74 05 00 00 02 04 8a 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 f0 00 00 00 00 00 00 00 00 00 00 22 10 41 74
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI 
(rev 03)
         Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI
         Flags: medium devsel
00: 22 10 43 74 00 00 80 02 03 00 80 06 00 16 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 43 74
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI 
(rev 05) (prog-if 00 [Normal decode])
         Flags: bus master, 66MHz, medium devsel, latency 64
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=168
         I/O behind bridge: 00002000-00002fff
         Memory behind bridge: f4900000-f49fffff
         Expansion ROM at 00002000 [disabled] [size=4K]
00: 22 10 48 74 17 00 20 22 05 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 a8 20 20 00 22
20: 90 f4 90 f4 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 04 00

0000:01:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 
AGP (rev 04) (prog-if 00 [VGA])
         Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 32Mb
         Flags: bus master, medium devsel, latency 128, IRQ 18
         Memory at f6000000 (32-bit, prefetchable)
         Memory at f4800000 (32-bit, non-prefetchable) [size=16K]
         Memory at f4000000 (32-bit, non-prefetchable) [size=8M]
         Capabilities: [dc] Power Management version 2
         Capabilities: [f0] AGP version 2.0
00: 2b 10 25 05 07 00 90 02 04 00 00 03 10 80 00 00
10: 08 00 00 f6 00 00 80 f4 00 00 00 f4 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 79 21
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 10 20

0000:02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] 
USB (rev 07) (prog-if 10 [OHCI])
         Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] USB
         Flags: bus master, medium devsel, latency 64, IRQ 19
         Memory at f4900000 (32-bit, non-prefetchable)
00: 22 10 49 74 17 00 80 02 07 10 03 0c 00 40 00 00
10: 00 00 90 f4 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 49 74
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 04 00 50

0000:02:05.0 Unknown mass storage controller: Promise Technology, Inc. 
20267 (rev 02)
         Subsystem: Promise Technology, Inc. Ultra100
         Flags: bus master, medium devsel, latency 64, IRQ 17
         I/O ports at 24f0
         I/O ports at 24e4 [size=4]
         I/O ports at 24e8 [size=8]
         I/O ports at 24e0 [size=4]
         I/O ports at 2480 [size=64]
         Memory at f4920000 (32-bit, non-prefetchable) [size=128K]
         Capabilities: [58] Power Management version 1
00: 5a 10 30 4d 07 00 10 02 02 00 80 01 00 40 00 00
10: f1 24 00 00 e5 24 00 00 e9 24 00 00 e1 24 00 00
20: 81 24 00 00 00 00 92 f4 00 00 00 00 5a 10 33 4d
30: 00 00 00 00 58 00 00 00 00 00 00 00 05 01 00 00

0000:02:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8169 (rev 10)
         Subsystem: Realtek Semiconductor Co., Ltd. RTL-8169
         Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 18
         I/O ports at 2000
         Memory at f4901000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [dc] Power Management version 2
00: ec 10 69 81 17 00 b0 02 10 00 00 02 10 40 00 00
10: 01 20 00 00 00 10 90 f4 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 69 81
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 20 40

0000:02:07.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 
(rev 08)
         Subsystem: Creative Labs CT4760 SBLive!
         Flags: bus master, medium devsel, latency 64, IRQ 19
         I/O ports at 24c0
         Capabilities: [dc] Power Management version 1
00: 02 11 02 00 05 00 90 02 08 00 01 04 00 40 80 00
10: c1 24 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 40 80
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 02 14

0000:02:07.1 Input device controller: Creative Labs SB Live! MIDI/Game 
Port (rev 08)
         Subsystem: Creative Labs Gameport Joystick
         Flags: bus master, medium devsel, latency 64
         I/O ports at 24f8
         Capabilities: [dc] Power Management version 1
00: 02 11 02 70 05 00 90 02 08 00 80 09 00 40 80 00
10: f9 24 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 20 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 00 00

0000:02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M 
[Tornado] (rev 78)
         Subsystem: Tyan Computer: Unknown device 2466
         Flags: bus master, medium devsel, latency 80, IRQ 19
         I/O ports at 2400
         Memory at f4901400 (32-bit, non-prefetchable) [size=128]
         Capabilities: [dc] Power Management version 2
00: b7 10 00 92 17 00 10 02 78 00 00 02 10 50 00 00
10: 01 24 00 00 00 14 90 f4 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 f1 10 66 24
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 0a 0a
------------------
dmesg
  @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x01] enabled)
Processor #1 6:10 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: auto BOOT_IMAGE=NeuerKernel ro root=301
CPU 0 irqstacks, hard=c06b1000 soft=c06af000
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2000.282 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 903072k/917504k available (3633k kernel code, 13688k reserved, 
1884k data, 272k init, 0k highmem)
Calibrating delay loop... 3940.35 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: AMD Athlon(tm) MP 2600+ stepping 00
per-CPU timeslice cutoff: 1462.76 usecs.
task migration cache decay timeout: 2 msecs.
masked ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 3000
CPU 1 irqstacks, hard=c06b2000 soft=c06b0000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3997.69 BogoMIPS
CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Athlon(tm) Processor stepping 00
Total of 2 processors activated (7938.04 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 
2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1999.0823 MHz.
..... host bus clock speed is 266.0643 MHz.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
zapping low mappings.
CPU0:  online
  domain 0: span 3
   groups: 1 2
CPU1:  online
  domain 0: span 3
   groups: 2 1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd7d0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.OP2P._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *5 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 *10 11)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xa9 -> IRQ 20 Mode:1 Active:1)
00:00:08[A] -> 2-20 -> IRQ 20
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xb1 -> IRQ 21 Mode:1 Active:1)
00:00:08[B] -> 2-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xb9 -> IRQ 22 Mode:1 Active:1)
00:00:08[C] -> 2-22 -> IRQ 22
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xc1 -> IRQ 23 Mode:1 Active:1)
00:00:08[D] -> 2-23 -> IRQ 23
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc9 -> IRQ 18 Mode:1 Active:1)
00:01:05[A] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xd1 -> IRQ 19 Mode:1 Active:1)
00:01:05[B] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xd9 -> IRQ 16 Mode:1 Active:1)
00:02:04[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xe1 -> IRQ 17 Mode:1 Active:1)
00:02:04[B] -> 2-17 -> IRQ 17
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0B000000
.......     : arbitration: 0B
.... IRQ redirection table:
  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
  00 000 00  1    0    0   0   0    0    0    00
  01 003 03  0    0    0   0   0    1    1    39
  02 003 03  0    0    0   0   0    1    1    31
  03 003 03  0    0    0   0   0    1    1    41
  04 003 03  0    0    0   0   0    1    1    49
  05 003 03  0    0    0   0   0    1    1    51
  06 003 03  0    0    0   0   0    1    1    59
  07 003 03  0    0    0   0   0    1    1    61
  08 003 03  0    0    0   0   0    1    1    69
  09 003 03  0    1    0   1   0    1    1    71
  0a 003 03  0    0    0   0   0    1    1    79
  0b 003 03  0    0    0   0   0    1    1    81
  0c 003 03  0    0    0   0   0    1    1    89
  0d 003 03  0    0    0   0   0    1    1    91
  0e 003 03  0    0    0   0   0    1    1    99
  0f 003 03  0    0    0   0   0    1    1    A1
  10 003 03  1    1    0   1   0    1    1    D9
  11 003 03  1    1    0   1   0    1    1    E1
  12 003 03  1    1    0   1   0    1    1    C9
  13 003 03  1    1    0   1   0    1    1    D1
  14 003 03  1    1    0   1   0    1    1    A9
  15 003 03  1    1    0   1   0    1    1    B1
  16 003 03  1    1    0   1   0    1    1    B9
  17 003 03  1    1    0   1   0    1    1    C1
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
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
Bluetooth: Core ver 2.4
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
matroxfb: Matrox Millennium G400 MAX (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x65536)
matroxfb: framebuffer at 0xF6000000, mapped to 0xf880d000, size 33554432
fb0: MATROX frame buffer device
fb0: initializing hardware
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb1: VGA16 VGA frame buffer device
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: disabled - APM is not SMP safe.
Starting balanced_irq
ikconfig 0.7 with /proc/config*
VFS: Disk quotas dquot_6.5.1
NTFS driver 2.1.6 [Flags: R/O].
Initializing Cryptographic API
BIOS failed to enable PCI standards compliance, fixing this error.
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (FF) [SLPF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
Console: switching to colour frame buffer device 80x30
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
ppdev: user-space parallel port driver
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected AMD 760MP chipset
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: AGP aperture is 64M @ 0xf8000000
[drm] Initialized mga 3.1.0 20021029 on minor 0: Matrox G400/G450 (AGP)
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
Using anticipatory io scheduler
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Compaq SMART2 Driver (v 2.6.0)
Compaq CISS Driver (v 2.6.0)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:08.0: 3Com PCI 3c905C Tornado at 0x2400. Vers LK1.1.19
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
NET: Registered protocol family 24
r8169 Gigabit Ethernet driver 1.2 loaded
eth1: Identified chip type is 'RTL8169s/8110s'.
eth1: RTL8169 at 0xfa851000, 00:08:54:d0:dd:85, IRQ 18
eth1: Auto-negotiation Enabled.
eth1: 100Mbps Full-duplex operation.
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7441: IDE controller at PCI slot 0000:00:07.1
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
AMD7441: 0000:00:07.1 (rev 04) UDMA100 controller
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 91741U4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Maxtor 4R080L0, ATA DISK drive
hdd: MAXTOR 4K060H3, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20267: IDE controller at PCI slot 0000:02:05.0
PDC20267: chipset revision 2
PDC20267: 100% native mode on irq 17
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
     ide2: BM-DMA at 0x2480-0x2487, BIOS settings: hde:pio, hdf:pio
     ide3: BM-DMA at 0x2488-0x248f, BIOS settings: hdg:pio, hdh:pio
hda: max request size: 128KiB
hda: 34004880 sectors (17410 MB) w/512KiB Cache, CHS=33735/16/63
  hda: hda1 hda2
hdc: max request size: 128KiB
hdc: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63
  hdc: hdc1
hdd: max request size: 128KiB
hdd: 117266688 sectors (60040 MB) w/2000KiB Cache, CHS=65535/16/63
  hdd: hdd1
ide-floppy driver 0.99.newide
ieee1394: raw1394: /dev/raw1394 device initialized
sbp2: $Rev: 1170 $ Ben Collins <bcollins@debian.org>
matroxfb_crtc2: secondary head of fb0 was registered as fb2
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:02:00.0: Advanced Micro Devices [AMD] AMD-768 [Opus] USB
ohci_hcd 0000:02:00.0: irq 19, pci mem fa853000
ohci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
USB Universal Host Controller Interface driver v2.2
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
inport.c: Didn't find InPort mouse at 0x23c
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS2++ Logitech MX Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 19
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
   (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
    (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
i2o_scsi.c: Version 0.1.2
   chain_pool: 0 bytes @ f7cf5c20
   (512 byte buffers X 4 can_queue X 0 i2o controllers)
i2c /dev entries driver
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
    8regs     :  2680.000 MB/sec
    8regs_prefetch:  2744.000 MB/sec
    32regs    :  2244.000 MB/sec
    32regs_prefetch:  1932.000 MB/sec
    pIII_sse  :  5396.000 MB/sec
    pII_mmx   :  5336.000 MB/sec
    p5_mmx    :  7140.000 MB/sec
raid5: using function: pIII_sse (5396.000 MB/sec)
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Bluetooth: HCI USB driver ver 2.5
usbcore: registered new driver hci_usb
Advanced Linux Sound Architecture Driver Version 1.0.3 (Mon Mar 01 
10:12:14 2004 UTC).
ALSA device list:
   #0: Sound Blaster Live! (rev.8) at 0x24c0, irq 19
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_conntrack version 2.1 (7168 buckets, 57344 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>. 
http://snowman.net/projects/ipt_recent/
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 4
ACPI: (supports S0 S1 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 272k freed
Adding 979956k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hdc1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdd1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:05.0 into 1x mode
atkbd.c: Unknown key released (translated set 2, code 0x7a on 
isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on 
isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
------------------
lsmod
Module                  Size  Used by
------------------
