Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266007AbUBQFlk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 00:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbUBQFlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 00:41:40 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:21652 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266007AbUBQFlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 00:41:25 -0500
Message-ID: <20040216214111.jxqg4owg44wwwc84@carlthompson.net>
X-Priority: 3 (Normal)
Date: Mon, 16 Feb 2004 21:41:11 -0800
From: Carl Thompson <cet@carlthompson.net>
To: linux-kernel@vger.kernel.org
Cc: cet@carlthompson.net
Subject: hard lock using combination of devices
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=_3ne6648025q8"
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 192.168.0.156
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.

--=_3ne6648025q8
Content-Type: text/plain; charset="ISO-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Please CC me on all responses because I am not on the linux-kernel list.

If this is not the correct forum for this question, please let me know.

Hello, I have a system lockup problem on my notebook computer the cause of
which I have not been able determine on my own.  My system sometimes locks up
hard when I do the following simultaneously:

1. Use a wireless network adapter plugged into the PC-Card slot

and

2. Output sound via the sound card

The facts are as follows:

* The probability of the machine locking at any given instant when a sound
  is output is directly proportional to the bandwith utilization over the
  wireless adapter.  At 1Mbps the machine might go days before it crashes.
  At 3Mbps the machine might go hours without crashing.  At 20Mpbs when a
  sound is played the machine will always crash in under a second.

* It does not matter whether I run kernel 2.4 or 2.6.  Kernel 2.6 _might_
  be more likely to crash / crash quicker (subjective opinion).

* Operating either the network or sound card exclusively is completely
  stable.  It is only when a sound is played at the same time there is some
  network bandwith utilization that there a chance for the machine to crash.

* Adjusting PCI latency for any or all of the devices either up or down has
  no effect.

* It doesn't matter whether I use the "trident" OSS sound driver or the
  "snd-ali5451" ALSA sound driver (I have integrated ALI 5451 sound).

* It does not matter what what network adapter or driver is used.  I have
  tried several different CardBus adapters with several completely different
  drivers and have had the same results.

* High network bandwith utilization over the machines built in 100BaseT
  adapter is completely stable.  It is only when using a PC-Card adapter that
  there is a possibility of locking the machine.

* Before the machine locks up, there is no hint that there is anything wrong
  in the logs or otherwise.

* Fiddling with a multitude of kernel configuration options has no effect.

* Other devices in the system don't seem to make a difference.  High disk
  bandwith utilization does not seem to affect the results.  Using X / not
  using X seems to make no difference.  (I have not tried high video card
  bandwith utilization though.)

* My gut feeling says this is some sort of PCI bus contention / bandwith
  issue.  I'm not sure why I think this and I may be wrong.

* I have attached the output of "dmesg" and "lspci -v" to this message.

Please...  can anyone help me?

Carl Thompson

--=_3ne6648025q8
Content-Type: text/plain; charset="UTF-8"; name="dmesg"
Content-Disposition: attachment; filename="dmesg"
Content-Transfer-Encoding: 7bit

Linux version 2.6.2 (root@Tweak) (gcc version 3.3.2 20040119 (Red Hat Linux 3.3.2-8)) #5 SMP Mon Feb 16 17:18:38 PST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002def0000 (usable)
 BIOS-e820: 000000002def0000 - 000000002deff000 (ACPI data)
 BIOS-e820: 000000002deff000 - 000000002df00000 (ACPI NVS)
 BIOS-e820: 000000002df00000 - 000000002e000000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
736MB LOWMEM available.
On node 0 totalpages: 188416
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 184320 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ARIMA                                     ) @ 0x000f7690
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x2defb0d2
ACPI: FADT (v001 ARIMA  W720-K7  0x06040000 PTL_ 0x000f4240) @ 0x2defee53
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x2defeec7
ACPI: DSDT (v001 ARIMA  W720-K7  0x06040000 MSFT 0x0100000d) @ 0x00000000
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda2 acpi=on
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1788.623 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 741432k/753664k available (1928k kernel code, 11380k reserved, 712k data, 172k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3530.75 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
Failure registering capabilities with the kernel
selinux_register_security:  Registering secondary module capability
Capability LSM initialized
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbf7 c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: AMD Mobile AMD Athlon(tm) XP 2200+ stepping 01
per-CPU timeslice cutoff: 731.38 usecs.
task migration cache decay timeout: 1 msecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1788.0568 MHz.
..... host bus clock speed is 264.0973 MHz.
Starting migration thread for cpu 0
CPUS done 0
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd88e, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20040116
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 *10 11 12)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNK6] (IRQs 3 4 *5 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNK7] (IRQs 3 4 5 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNK8] (IRQs 3 4 5 6 7 10 11 12)
ACPI: Embedded Controller [EC] (gpe 24)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
spurious 8259A interrupt: IRQ7.
ACPI: PCI Interrupt Link [LNK7] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNK6] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 11
ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb.
Activating ISA DMA hang workarounds.
pty: 2048 Unix98 ptys configured
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Ati IGP320/M chipset
agpgart: Maximum main memory to use for agp memory: 659M
agpgart: AGP aperture is 64M @ 0xf4000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x8828 (irq = 5) is a 8250
ttyS1 at I/O 0x8840 (irq = 5) is a 8250
ttyS2 at I/O 0x8850 (irq = 5) is a 8250
ttyS3 at I/O 0x8860 (irq = 5) is a 8250
ttyS4 at I/O 0x8870 (irq = 5) is a 8250
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Warning: ATI Radeon IGP Northbridge is not yet fully tested.
ALI15X3: IDE controller at PCI slot 0000:00:10.0
ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8080-0x8087, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x8088-0x808f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DJSA-220, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-R2312, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/1874KiB Cache, CHS=38760/16/63, UDMA(66)
 hda: hda1 hda2 hda3
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.8
 Sensor: 35
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 131072 bind 43690)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: hda2: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 771119
EXT3-fs: hda2: 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 172k freed
powernow: AMD K7 CPU detected.
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: Found PSB header at c00f0ce0
powernow: Table version: 0x12
powernow: Flags: 0x0 (Mobile voltage regulator)
powernow: Settling Time: 100 microseconds.
powernow: Has 43 PST tables. (Only dumping ones relevant to this CPU).
powernow: PST:30 (@c00f0eec)
powernow:  cpuid: 0x781	fsb: 133	maxFID: 0x15	startvid: 0xb
powernow:    FID: 0x12 (4.0x [532MHz])	VID: 0x19 (1.050V)
powernow:    FID: 0x4 (5.0x [665MHz])	VID: 0x19 (1.050V)
powernow:    FID: 0x6 (6.0x [798MHz])	VID: 0x19 (1.050V)
powernow:    FID: 0x8 (7.0x [931MHz])	VID: 0x19 (1.050V)
powernow:    FID: 0xe (10.0x [1330MHz])	VID: 0xe (1.300V)
powernow:    FID: 0x15 (13.5x [1795MHz])	VID: 0xb (1.450V)

powernow: Minimum speed 532 MHz. Maximum speed 1795 MHz.
input: PC Speaker
EXT3 FS on hda2, internal journal
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (FF) [SLPF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (51 C)
EXT3 FS on hda2, internal journal
Adding 1502068k swap on /dev/hda3.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
quotaon: numerical sysctl 5 16 8 is obsolete.
blk: queue ed3f4df8, I/O limit 4095Mb (mask 0xffffffff)

--=_3ne6648025q8
Content-Type: text/plain; charset="UTF-8"; name="lspci"
Content-Disposition: attachment; filename="lspci"
Content-Transfer-Encoding: 7bit

0000:00:00.0 Host bridge: ATI Technologies Inc AGP Bridge [IGP 320M] (rev 13)
	Flags: bus master, 66Mhz, medium devsel, latency 64
	Memory at f4000000 (32-bit, prefetchable)
	Memory at f0400000 (32-bit, prefetchable) [size=4K]
	I/O ports at 8090 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0

0000:00:01.0 PCI bridge: ATI Technologies Inc PCI Bridge [IGP 320M] (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: f0100000-f01fffff
	Prefetchable memory behind bridge: f8000000-fbffffff
	Secondary status: SERR
	Expansion ROM at 00009000 [disabled] [size=4K]

0000:00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: ALi Corporation ALI M1533 Aladdin IV ISA Bridge
	Flags: bus master, medium devsel, latency 0
	Capabilities: [a0] Power Management version 1

0000:00:08.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 02)
	Subsystem: Unknown device 161f:2029
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at 8400
	Memory at f0002000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2

0000:00:09.0 Modem: ALi Corporation Intel 537 [M5457 AC-Link Modem] (prog-if 00 [Generic])
	Subsystem: Unknown device 161f:2027
	Flags: medium devsel, IRQ 5
	Memory at f0003000 (32-bit, non-prefetchable)
	I/O ports at 8800 [size=256]
	Capabilities: [40] Power Management version 2

0000:00:0a.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller
	Subsystem: Unknown device 161f:2029
	Flags: bus master, medium devsel, latency 168, IRQ 10
	Memory at 2e000000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 2e400000-2e7ff000 (prefetchable)
	Memory window 1: 2e800000-2ebff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

0000:00:0d.0 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
	Subsystem: Unknown device 161f:2029
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at f0004000 (32-bit, non-prefetchable)
	Capabilities: [40] Power Management version 2

0000:00:0d.1 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
	Subsystem: Unknown device 161f:2029
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at f0005000 (32-bit, non-prefetchable)
	Capabilities: [40] Power Management version 2

0000:00:0d.2 USB Controller: NEC Corporation USB 2.0 (rev 04) (prog-if 20 [EHCI])
	Subsystem: Unknown device 161f:2029
	Flags: medium devsel, IRQ 11
	Memory at f0006000 (32-bit, non-prefetchable)
	Capabilities: [40] Power Management version 2

0000:00:0e.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
	Subsystem: Unknown device 161f:2029
	Flags: bus master, fast devsel, latency 64, IRQ 11
	Memory at f0000000 (32-bit, non-prefetchable)
	Capabilities: [40] Power Management version 2

0000:00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if fa)
	Subsystem: Unknown device 161f:2029
	Flags: bus master, medium devsel, latency 0
	I/O ports at 8080 [size=16]
	Capabilities: [60] Power Management version 2

0000:00:11.0 Bridge: ALi Corporation M7101 PMU
	Subsystem: Unknown device 161f:2029
	Flags: medium devsel

0000:01:05.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility U1 (prog-if 00 [VGA])
	Subsystem: Unknown device 161f:2029
	Flags: bus master, stepping, fast Back2Back, 66Mhz, medium devsel, latency 66, IRQ 10
	Memory at f8000000 (32-bit, prefetchable)
	I/O ports at 9000 [size=256]
	Memory at f0100000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2

0000:02:00.0 Network controller: Broadcom Corporation BCM94306 802.11g (rev 02)
	Subsystem: Linksys WPC54G
	Flags: bus master, fast devsel, latency 168, IRQ 10
	Memory at 2e800000 (32-bit, non-prefetchable)
	Capabilities: [40] Power Management version 2


--=_3ne6648025q8--

