Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030360AbVIIUmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbVIIUmR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 16:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbVIIUmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 16:42:17 -0400
Received: from gathered-geeks.org ([217.160.210.51]:24537 "EHLO
	p15132835.pureserver.info") by vger.kernel.org with ESMTP
	id S1030360AbVIIUmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 16:42:15 -0400
Message-ID: <4321F396.3010707@funzi.de>
Date: Fri, 09 Sep 2005 22:41:58 +0200
From: Christopher Beppler <psiml@funzi.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050814)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [OOPS] hotplugging cpus via /sys/devices/system/cpu/
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
If I deactivate a CPU with /sys/devices/system/cpux and try to
reactivate it, then the CPU doesn't start and the kernel prints out an oops.

[2.] Full description of the problem/report:
I stopped my second cpu via echo 0 > /sys/devices/system/cpu/cpu1/online
and then I type echo 1 > /sys/devices/system/cpu/cpu1/online. Then I
wait 5 seconds and get an oops. But the CPU is offline either.

[3.] Keywords (i.e., modules, networking, kernel):
hotplug cpu

[4.] Kernel version (from /proc/version):
Linux version 2.6.13 (root@opteron) (gcc-Version 3.4.3) #7 SMP Mon Sep 5
04:55:34 CEST 2005

[5.] Output of Oops
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3185.45 BogoMIPS
(lpj=1592727)
CPU: After generic identify, caps: 078bfbff e1d3fbff 00000000 00000000
00000000 00000000 00000000
Unable to handle kernel paging request at virtual address 8d1ca2ad
 printing eip:
f5400002
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP
Modules linked in: nvidia ehci_hcd uhci_hcd i2c_amd756 i2c_amd8111
i2c_core isofs zlib_inflate dm_mod
CPU:    1
EIP:    0060:[<f5400002>]    Tainted: P      VLI
EFLAGS: 00010097   (2.6.13)
EIP is at 0xf5400002
eax: c04ed5e0   ebx: c04c0ac0   ecx: cccccccb   edx: 00000002
esi: ffffffff   edi: c04c0ae8   ebp: 00000000   esp: c217ff64
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c217e000 task=c2121520)
Stack: c010bab3 c04c0ac0 00000000 00000000 c0122637 00000001 c04c0ac0
000000c0
       c0114d38 c04c0ac0 c042ad80 000000c0 00000001 00000000 00000000
c0114e50
       00000001 01000800 00000000 01000800 01000800 c0114ede 00000000
01000800
Call Trace:
 [<c010bab3>] identify_cpu+0x1c3/0x260
 [<c0122637>] printk+0x17/0x20
 [<c0114d38>] smp_store_cpu_info+0x68/0x100
 [<c0114e50>] smp_callin+0x80/0x100
 [<c0114ede>] start_secondary+0xe/0x1a0
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 49 4e <81> b4
01 02 00 01 00 00 01 fe 00 00 03 e9 00 00 00 01 00 00 00
 <0>Kernel panic - not syncing: Attempted to kill the idle task!
 Stuck ??
Inquiring remote APIC #1...
... APIC #1 ID: 01000000
... APIC #1 VERSION: 00040010
... APIC #1 SPIV: 000000ff

[6.] A small shell script or example program which triggers the problem
(if possible):
echo 0 > /sys/devices/system/cpu/cpu1/online
echo 1 > /sys/devices/system/cpu/cpu1/online

[7.] Environment

[7.1.] Software
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux opteron 2.6.13 #7 SMP Mon Sep 5 04:55:34 CEST 2005 i686 athlon-4
i386 GNU/Linux

Gnu C                  3.4.3
Gnu make               3.80
binutils               2.15.94.0.2.2
util-linux             2.12q
mount                  2.12q
module-init-tools      3.1
e2fsprogs              1.37
reiserfsprogs          line
reiser4progs           line
xfsprogs               2.6.13
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Linux C++ Library      6.0.3
Procps                 3.2.5
Kbd                    1.12
Sh-utils               5.2.1
udev                   056
Modules Loaded         nvidia ehci_hcd uhci_hcd i2c_amd756 i2c_amd8111
i2c_core isofs zlib_inflate dm_mod

[7.2.] Processor information
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 5
model name	: AMD Opteron(tm) Processor 242
stepping	: 10
cpu MHz		: 1593.961
cache size	: 1024 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips	: 3191.30


[7.3.] Module information
nvidia 3706792 12 - Live 0xf8f2f000
ehci_hcd 30280 0 - Live 0xf8b24000
uhci_hcd 31120 0 - Live 0xf8b1b000
i2c_amd756 5636 0 - Live 0xf8af2000
i2c_amd8111 5248 0 - Live 0xf8aef000
i2c_core 17792 2 i2c_amd756,i2c_amd8111, Live 0xf8ae3000
isofs 32896 0 - Live 0xf8af9000
zlib_inflate 17152 1 isofs, Live 0xf8ae9000
dm_mod 52764 4 - Live 0xf8aa7000

[7.4.] Loaded driver and hardware information
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0295-0296 : pnp 00:09
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0680-06ff : pnp 00:09
0778-077f : pnp 00:09
0b78-0b7f : pnp 00:09
0cf8-0cff : PCI conf1
0f78-0f7f : pnp 00:09
5000-50bf : motherboard
  5000-5003 : PM1a_EVT_BLK
  5004-5005 : PM1a_CNT_BLK
  5008-500b : PM_TMR
  5010-5015 : ACPI CPU throttle
  5020-5023 : GPE0_BLK
  50b0-50b7 : GPE1_BLK
50c0-50df : motherboard
50e0-50ff : motherboard
  50e0-50ef : amd756-smbus
9000-bfff : PCI Bus #01
  9400-943f : 0000:01:03.0
    9400-943f : e1000
  9800-983f : 0000:01:07.0
    9800-983f : EMU10K1
  9c00-9c7f : 0000:01:0a.0
  a000-a01f : 0000:01:0b.0
    a000-a01f : uhci_hcd
  a400-a41f : 0000:01:0b.1
    a400-a41f : uhci_hcd
  a800-a80f : 0000:01:05.0
    a800-a80f : sata_sil
  ac00-ac03 : 0000:01:05.0
    ac00-ac03 : sata_sil
  b000-b007 : 0000:01:05.0
    b000-b007 : sata_sil
  b400-b403 : 0000:01:05.0
    b400-b403 : sata_sil
  b800-b807 : 0000:01:05.0
    b800-b807 : sata_sil
  bc00-bc07 : 0000:01:07.1
cc00-cc1f : 0000:00:07.2
  cc00-cc1f : amd8111 SMBus 2.0
de00-de7f : motherboard
de80-deff : motherboard
ffa0-ffaf : 0000:00:07.1
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cebff : Video ROM
000cf000-000d37ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-7ffeffff : System RAM
  00100000-003d1dd4 : Kernel code
  003d1dd5-004c4d07 : Kernel data
7fff0000-7fffefff : ACPI Tables
7ffff000-7fffffff : ACPI Non-volatile Storage
80000000-800fffff : PCI Bus #01
  80000000-8007ffff : 0000:01:05.0
  80080000-8009ffff : 0000:01:03.0
dc600000-ec6fffff : PCI Bus #02
  dc600000-dc61ffff : 0000:02:00.0
  e0000000-e7ffffff : 0000:02:00.0
  ec680000-ec6fffff : 0000:02:00.0
f0000000-f7ffffff : 0000:00:00.0
  f0000000-f7ffffff : aperture
fc800000-fc9fffff : PCI Bus #01
  fc9a0000-fc9bffff : 0000:01:03.0
    fc9a0000-fc9bffff : e1000
  fc9c0000-fc9dffff : 0000:01:03.0
    fc9c0000-fc9dffff : e1000
  fc9f8000-fc9fbfff : 0000:01:07.2
  fc9fc000-fc9fcfff : 0000:01:00.0
  fc9fd000-fc9fdfff : 0000:01:00.1
  fc9fe800-fc9fefff : 0000:01:07.2
    fc9fe800-fc9fefff : ohci1394
  fc9ff000-fc9ff7ff : 0000:01:0a.0
    fc9ff000-fc9ff7ff : ohci1394
  fc9ff800-fc9ff8ff : 0000:01:0b.2
    fc9ff800-fc9ff8ff : ehci_hcd
  fc9ffc00-fc9fffff : 0000:01:05.0
    fc9ffc00-fc9fffff : sata_sil
fca00000-feafffff : PCI Bus #02
  fd000000-fdffffff : 0000:02:00.0
    fd000000-fdffffff : nvidia
ff780000-ffffffff : reserved

[7.5.] PCI information
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Advanced Micro Devices [AMD] AMD-8151 System Controller
(rev 20).
      Prefetchable 32 bit memory at 0xf0000000 [0xf7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-8151 AGP Bridge (rev 20).
      Master Capable.  Latency=64.  Min Gnt=8.
  Bus  0, device   6, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 7).
      Master Capable.  Latency=64.  Min Gnt=6.
  Bus  0, device   7, function  0:
    ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 5).
  Bus  0, device   7, function  1:
    IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 3).
      Master Capable.  Latency=32.
      I/O at 0xffa0 [0xffaf].
  Bus  0, device   7, function  2:
    SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 2).
      IRQ 10.
      Master Capable.  Latency=64.
      I/O at 0xcc00 [0xcc1f].
  Bus  0, device   7, function  3:
    Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 5).
      Master Capable.  Latency=64.
  Bus  0, device  25, function  0:
    Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration (#2) (rev 0).
  Bus  0, device  24, function  0:
    Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration (rev 0).
  Bus  0, device  25, function  1:
    Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map (#2) (rev 0).
  Bus  0, device  24, function  1:
    Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map (rev 0).
  Bus  0, device  25, function  2:
    Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM
Controller (#2) (rev 0).
  Bus  0, device  24, function  2:
    Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM
Controller (rev 0).
  Bus  0, device  25, function  3:
    Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control (#2) (rev 0).
  Bus  0, device  24, function  3:
    Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control (rev 0).
  Bus  2, device   0, function  0:
    VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti
4400] (rev 162).
      IRQ 18.
      Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xfd000000 [0xfdffffff].
      Prefetchable 32 bit memory at 0xe0000000 [0xe7ffffff].
      Prefetchable 32 bit memory at 0xec680000 [0xec6fffff].
  Bus  1, device   0, function  1:
    USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (#2) (rev 11).
      IRQ 10.
      Master Capable.  Latency=64.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xfc9fd000 [0xfc9fdfff].
  Bus  1, device   0, function  0:
    USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 11).
      IRQ 10.
      Master Capable.  Latency=64.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xfc9fc000 [0xfc9fcfff].
  Bus  1, device   3, function  0:
    Ethernet controller: Intel Corporation 82541GI/PI Gigabit Ethernet
Controller (rev 0).
      IRQ 16.
      Master Capable.  Latency=64.  Min Gnt=255.
      Non-prefetchable 32 bit memory at 0xfc9c0000 [0xfc9dffff].
      Non-prefetchable 32 bit memory at 0xfc9a0000 [0xfc9bffff].
      I/O at 0x9400 [0x943f].
  Bus  1, device   5, function  0:
    Unknown mass storage controller: Silicon Image, Inc. (formerly CMD
Technology Inc) SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 2).
      IRQ 17.
      Master Capable.  Latency=64.
      I/O at 0xb800 [0xb807].
      I/O at 0xb400 [0xb403].
      I/O at 0xb000 [0xb007].
      I/O at 0xac00 [0xac03].
      I/O at 0xa800 [0xa80f].
      Non-prefetchable 32 bit memory at 0xfc9ffc00 [0xfc9fffff].
  Bus  1, device   7, function  0:
    Multimedia audio controller: Creative Labs SB Audigy (rev 4).
      IRQ 17.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=20.
      I/O at 0x9800 [0x983f].
  Bus  1, device   7, function  1:
    Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 4).
      Master Capable.  Latency=64.
      I/O at 0xbc00 [0xbc07].
  Bus  1, device   7, function  2:
    FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 4).
      IRQ 18.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=4.
      Non-prefetchable 32 bit memory at 0xfc9fe800 [0xfc9fefff].
      Non-prefetchable 32 bit memory at 0xfc9f8000 [0xfc9fbfff].
  Bus  1, device  10, function  0:
    FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 128).
      IRQ 19.
      Master Capable.  Latency=64.  Max Lat=32.
      Non-prefetchable 32 bit memory at 0xfc9ff000 [0xfc9ff7ff].
      I/O at 0x9c00 [0x9c7f].
  Bus  1, device  11, function  1:
    USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (#2) (rev 97).
      IRQ 16.
      Master Capable.  Latency=64.
      I/O at 0xa400 [0xa41f].
  Bus  1, device  11, function  0:
    USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 97).
      IRQ 19.
      Master Capable.  Latency=64.
      I/O at 0xa000 [0xa01f].
  Bus  1, device  11, function  2:
    USB Controller: VIA Technologies, Inc. USB 2.0 (rev 99).
      IRQ 17.
      Master Capable.  Latency=64.
      Non-prefetchable 32 bit memory at 0xfc9ff800 [0xfc9ff8ff].

[7.7.] USB information

[7.8.] dmesg log
Linux version 2.6.13 (root@opteron) (gcc-Version 3.4.3) #7 SMP Mon Sep 5
04:55:34 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
 BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 524272
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 294896 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f6930
ACPI: RSDT (v001 A M I  OEMRSDT  0x11000409 MSFT 0x00000097) @ 0x7fff0000
ACPI: FADT (v001 A M I  OEMFACP  0x11000409 MSFT 0x00000097) @ 0x7fff0200
ACPI: MADT (v001 A M I  OEMAPIC  0x11000409 MSFT 0x00000097) @ 0x7fff0380
ACPI: OEMB (v001 A M I  OEMBIOS  0x11000409 MSFT 0x00000097) @ 0x7ffff040
ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0x7fff3330
ACPI: DSDT (v001  0AAAA 0AAAA000 0x00000000 INTL 0x02002026) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 80000000:7f780000)
Built 1 zonelists
Kernel command line: root=/dev/sda3
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1593.961 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2074228k/2097088k available (2887k kernel code, 21668k reserved,
971k data, 220k init, 1179584k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3191.30 BogoMIPS
(lpj=1595650)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 078bfbff e1d3fbff 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 078bfbff e1d3fbff 00000000 00000000
00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: After all inits, caps: 078bfbff e1d3fbff 00000000 00000010 00000000
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: AMD Opteron(tm) Processor 242 stepping 0a
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3186.38 BogoMIPS
(lpj=1593194)
CPU: After generic identify, caps: 078bfbff e1d3fbff 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 078bfbff e1d3fbff 00000000 00000000
00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: After all inits, caps: 078bfbff e1d3fbff 00000000 00000010 00000000
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Opteron(tm) Processor 242 stepping 0a
Total of 2 processors activated (6377.68 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
Boot video device is 0000:02:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: fca00000-feafffff
  PREFETCH window: dc600000-ec6fffff
PCI: Bridge: 0000:00:06.0
  IO window: 9000-bfff
  MEM window: fc800000-fc9fffff
  PREFETCH window: 80000000-800fffff
pnp: 00:09: ioport range 0x680-0x6ff has been reserved
pnp: 00:09: ioport range 0x295-0x296 has been reserved
pnp: 00:09: ioport range 0x778-0x77f has been reserved
pnp: 00:09: ioport range 0xb78-0xb7f has been reserved
pnp: 00:09: ioport range 0xf78-0xf7f has been reserved
highmem bounce pool size: 64 pages
SGI XFS with large block numbers, no debug enabled
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
Using specific hotkey driver
ACPI: CPU0 (power states: C1[C1])
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: CPU1 (power states: C1[C1])
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected AMD 8151 AGP Bridge rev B3
agpgart: AGP aperture is 128M @ 0xf0000000
PNP: PS/2 controller doesn't have AUX irq; using default 0xc
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 112
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
io scheduler noop registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Intel(R) PRO/1000 Network Driver - version 6.0.60-k2
Copyright (c) 1999-2005 Intel Corporation.
ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 18 (level, low) -> IRQ 16
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: LITE-ON DVDRW SOHW-1673S, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: PLEXTOR DVD-ROM PX-130A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
hdc: ATAPI 50X DVD-ROM drive, 512kB Cache
libata version 1.12 loaded.
sata_sil version 0.9
ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 19 (level, low) -> IRQ 17
ata1: SATA max UDMA/100 cmd 0xF8804C80 ctl 0xF8804C8A bmdma 0xF8804C00
irq 17
ata2: SATA max UDMA/100 cmd 0xF8804CC0 ctl 0xF8804CCA bmdma 0xF8804C08
irq 17
ata3: SATA max UDMA/100 cmd 0xF8804E80 ctl 0xF8804E8A bmdma 0xF8804E00
irq 17
ata4: SATA max UDMA/100 cmd 0xF8804EC0 ctl 0xF8804ECA bmdma 0xF8804E08
irq 17
ata1: dev 0 cfg 49:2f00 82:74eb 83:7f63 84:4003 85:74e9 86:3c43 87:4003
88:207f
ata1: dev 0 ATA, max UDMA/133, 145226112 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: dev 0 cfg 49:2f00 82:74eb 83:7f63 84:4003 85:74e9 86:3c43 87:4003
88:207f
ata2: dev 0 ATA, max UDMA/133, 145226112 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
ata3: no device found (phy stat 00000000)
scsi2 : sata_sil
ata4: no device found (phy stat 00000000)
scsi3 : sata_sil
  Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 31.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 31.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:01:07.2[B] -> GSI 16 (level, low) -> IRQ 18
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[18]
MMIO=[fc9fe800-fc9fefff]  Max Packet=[2048]
ACPI: PCI Interrupt 0000:01:0a.0[A] -> GSI 17 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:01:0a.0, from 5 to 3
ohci1394: fw-host1: OHCI-1394 1.0 (PCI): IRQ=[19]
MMIO=[fc9ff000-fc9ff7ff]  Max Packet=[2048]
usbmon: debugfs is not available
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.9b (Thu Jul 28
12:20:13 2005 UTC).
ACPI: PCI Interrupt 0000:01:07.0[A] -> GSI 19 (level, low) -> IRQ 17
Installing spdif_bug patch: Audigy 2 ZS [SB0350]
ALSA device list:
  #0: Audigy 2 ZS [SB0350] (rev.4, serial:0x20021102) at 0x9800, irq 17
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI No-Shortcut mode
ACPI wakeup devices:
PCI1 USB0 USB1 PS2K UAR1 UAR2 SMBC AC97 MODM PWRB
ACPI: (supports S0 S1 S4 S5)
XFS mounting filesystem sda3
Ending clean XFS mount for filesystem: sda3
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 220k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023c0151109d38]
Adding 2996080k swap on /dev/sdb1.  Priority:1 extents:1
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
ieee1394: Host added: ID:BUS[1-00:1023]  GUID[00e0810000305e17]
XFS mounting filesystem dm-0
Ending clean XFS mount for filesystem: dm-0
XFS mounting filesystem dm-1
Ending clean XFS mount for filesystem: dm-1
cdrom: open failed.
cdrom: open failed.
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:01:0b.0[A] -> GSI 17 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:01:0b.0, from 5 to 3
uhci_hcd 0000:01:0b.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller
uhci_hcd 0000:01:0b.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:01:0b.0: irq 19, io base 0x0000a000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:01:0b.1[B] -> GSI 18 (level, low) -> IRQ 16
PCI: Via IRQ fixup for 0000:01:0b.1, from 9 to 0
uhci_hcd 0000:01:0b.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (#2)
uhci_hcd 0000:01:0b.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:01:0b.1: irq 16, io base 0x0000a400
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:01:0b.2[C] -> GSI 19 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:01:0b.2, from 10 to 1
ehci_hcd 0000:01:0b.2: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:01:0b.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:01:0b.2: irq 17, io mem 0xfc9ff800
ehci_hcd 0000:01:0b.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 18
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-7676  Fri Jul
29 12:58:54 PDT 2005
e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Device is in legacy mode, falling back to 2.x
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:02:00.0 into 4x mode
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Device is in legacy mode, falling back to 2.x
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:02:00.0 into 4x mode
CPU 1 is now offline
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3185.45 BogoMIPS
(lpj=1592727)
CPU: After generic identify, caps: 078bfbff e1d3fbff 00000000 00000000
00000000 00000000 00000000
Unable to handle kernel paging request at virtual address 8d1ca2ad
 printing eip:
f5400002
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP
Modules linked in: nvidia ehci_hcd uhci_hcd i2c_amd756 i2c_amd8111
i2c_core isofs zlib_inflate dm_mod
CPU:    1
EIP:    0060:[<f5400002>]    Tainted: P      VLI
EFLAGS: 00010097   (2.6.13)
EIP is at 0xf5400002
eax: c04ed5e0   ebx: c04c0ac0   ecx: cccccccb   edx: 00000002
esi: ffffffff   edi: c04c0ae8   ebp: 00000000   esp: c217ff64
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c217e000 task=c2121520)
Stack: c010bab3 c04c0ac0 00000000 00000000 c0122637 00000001 c04c0ac0
000000c0
       c0114d38 c04c0ac0 c042ad80 000000c0 00000001 00000000 00000000
c0114e50
       00000001 01000800 00000000 01000800 01000800 c0114ede 00000000
01000800
Call Trace:
 [<c010bab3>] identify_cpu+0x1c3/0x260
 [<c0122637>] printk+0x17/0x20
 [<c0114d38>] smp_store_cpu_info+0x68/0x100
 [<c0114e50>] smp_callin+0x80/0x100
 [<c0114ede>] start_secondary+0xe/0x1a0
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 49 4e <81> b4
01 02 00 01 00 00 01 fe 00 00 03 e9 00 00 00 01 00 00 00
 <0>Kernel panic - not syncing: Attempted to kill the idle task!
 Stuck ??
Inquiring remote APIC #1...
... APIC #1 ID: 01000000
... APIC #1 VERSION: 00040010
... APIC #1 SPIV: 000000ff

[7.11.] sysctl -A
dev.cdrom.check_media = 0
dev.cdrom.lock = 1
dev.cdrom.debug = 0
dev.cdrom.autoeject = 0
dev.cdrom.autoclose = 1
dev.cdrom.info = CD-ROM information, Id: cdrom.c 3.20 2003/12/17
dev.cdrom.info =
dev.cdrom.info = drive name:		hdc	hda
dev.cdrom.info = drive speed:		0	48
dev.cdrom.info = drive # of slots:	1	1
dev.cdrom.info = Can close tray:		1	1
dev.cdrom.info = Can open tray:		1	1
dev.cdrom.info = Can lock tray:		1	1
dev.cdrom.info = Can change speed:	1	1
dev.cdrom.info = Can select disk:	0	0
dev.cdrom.info = Can read multisession:	1	1
dev.cdrom.info = Can read MCN:		1	1
dev.cdrom.info = Reports media changed:	1	1
dev.cdrom.info = Can play audio:		1	1
dev.cdrom.info = Can write CD-R:		0	1
dev.cdrom.info = Can write CD-RW:	0	1
dev.cdrom.info = Can read DVD:		1	1
dev.cdrom.info = Can write DVD-R:	0	1
dev.cdrom.info = Can write DVD-RAM:	0	0
dev.cdrom.info = Can read MRW:		1	1
dev.cdrom.info = Can write MRW:		1	1
dev.cdrom.info = Can write RAM:		1	1
dev.cdrom.info =
dev.cdrom.info =
dev.parport.parport0.devices.active = none
dev.parport.parport0.modes = PCSPP
dev.parport.parport0.dma = -1
dev.parport.parport0.irq = 7
dev.parport.parport0.base-addr = 888	0
dev.parport.parport0.spintime = 500
dev.parport.default.spintime = 500
dev.parport.default.timeslice = 200
dev.rtc.max-user-freq = 1024
dev.scsi.logging_level = 0
fs.xfs.stats_clear = 0
fs.xfs.rotorstep = 1
fs.xfs.inherit_nosymlinks = 0
fs.xfs.age_buffer_centisecs = 1500
fs.xfs.xfsbufd_centisecs = 100
fs.xfs.inherit_noatime = 1
fs.xfs.inherit_nodump = 1
fs.xfs.inherit_sync = 1
fs.xfs.xfssyncd_centisecs = 3000
fs.xfs.error_level = 3
fs.xfs.panic_mask = 0
fs.xfs.irix_symlink_mode = 0
fs.xfs.irix_sgid_inherit = 0
fs.xfs.restrict_chown = 1
fs.suid_dumpable = 0
fs.inotify.max_queued_events = 16384
fs.inotify.max_user_watches = 8192
fs.inotify.max_user_instances = 128
fs.aio-max-nr = 65536
fs.aio-nr = 0
fs.lease-break-time = 45
fs.dir-notify-enable = 1
fs.leases-enable = 1
fs.overflowgid = 65534
fs.overflowuid = 65534
fs.dentry-state = 11350	9855	45	0	0	0
fs.file-max = 206224
fs.file-nr = 440	0	206224
fs.inode-state = 10503	36	0	0	0	0	0
fs.inode-nr = 10503	36
net.unix.max_dgram_qlen = 10
net.ipv4.conf.eth0.promote_secondaries = 0
net.ipv4.conf.eth0.force_igmp_version = 0
net.ipv4.conf.eth0.disable_policy = 0
net.ipv4.conf.eth0.disable_xfrm = 0
net.ipv4.conf.eth0.arp_ignore = 0
net.ipv4.conf.eth0.arp_announce = 0
net.ipv4.conf.eth0.arp_filter = 0
net.ipv4.conf.eth0.tag = 0
net.ipv4.conf.eth0.log_martians = 0
net.ipv4.conf.eth0.bootp_relay = 0
net.ipv4.conf.eth0.medium_id = 0
net.ipv4.conf.eth0.proxy_arp = 0
net.ipv4.conf.eth0.accept_source_route = 1
net.ipv4.conf.eth0.send_redirects = 1
net.ipv4.conf.eth0.rp_filter = 0
net.ipv4.conf.eth0.shared_media = 1
net.ipv4.conf.eth0.secure_redirects = 1
net.ipv4.conf.eth0.accept_redirects = 1
net.ipv4.conf.eth0.mc_forwarding = 0
net.ipv4.conf.eth0.forwarding = 0
net.ipv4.conf.default.promote_secondaries = 0
net.ipv4.conf.default.force_igmp_version = 0
net.ipv4.conf.default.disable_policy = 0
net.ipv4.conf.default.disable_xfrm = 0
net.ipv4.conf.default.arp_ignore = 0
net.ipv4.conf.default.arp_announce = 0
net.ipv4.conf.default.arp_filter = 0
net.ipv4.conf.default.tag = 0
net.ipv4.conf.default.log_martians = 0
net.ipv4.conf.default.bootp_relay = 0
net.ipv4.conf.default.medium_id = 0
net.ipv4.conf.default.proxy_arp = 0
net.ipv4.conf.default.accept_source_route = 1
net.ipv4.conf.default.send_redirects = 1
net.ipv4.conf.default.rp_filter = 0
net.ipv4.conf.default.shared_media = 1
net.ipv4.conf.default.secure_redirects = 1
net.ipv4.conf.default.accept_redirects = 1
net.ipv4.conf.default.mc_forwarding = 0
net.ipv4.conf.default.forwarding = 0
net.ipv4.conf.all.promote_secondaries = 0
net.ipv4.conf.all.force_igmp_version = 0
net.ipv4.conf.all.disable_policy = 0
net.ipv4.conf.all.disable_xfrm = 0
net.ipv4.conf.all.arp_ignore = 0
net.ipv4.conf.all.arp_announce = 0
net.ipv4.conf.all.arp_filter = 0
net.ipv4.conf.all.tag = 0
net.ipv4.conf.all.log_martians = 0
net.ipv4.conf.all.bootp_relay = 0
net.ipv4.conf.all.medium_id = 0
net.ipv4.conf.all.proxy_arp = 0
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.all.send_redirects = 1
net.ipv4.conf.all.rp_filter = 0
net.ipv4.conf.all.shared_media = 1
net.ipv4.conf.all.secure_redirects = 1
net.ipv4.conf.all.accept_redirects = 1
net.ipv4.conf.all.mc_forwarding = 0
net.ipv4.conf.all.forwarding = 0
net.ipv4.conf.lo.promote_secondaries = 0
net.ipv4.conf.lo.force_igmp_version = 0
net.ipv4.conf.lo.disable_policy = 1
net.ipv4.conf.lo.disable_xfrm = 1
net.ipv4.conf.lo.arp_ignore = 0
net.ipv4.conf.lo.arp_announce = 0
net.ipv4.conf.lo.arp_filter = 0
net.ipv4.conf.lo.tag = 0
net.ipv4.conf.lo.log_martians = 0
net.ipv4.conf.lo.bootp_relay = 0
net.ipv4.conf.lo.medium_id = 0
net.ipv4.conf.lo.proxy_arp = 0
net.ipv4.conf.lo.accept_source_route = 1
net.ipv4.conf.lo.send_redirects = 1
net.ipv4.conf.lo.rp_filter = 0
net.ipv4.conf.lo.shared_media = 1
net.ipv4.conf.lo.secure_redirects = 1
net.ipv4.conf.lo.accept_redirects = 1
net.ipv4.conf.lo.mc_forwarding = 0
net.ipv4.conf.lo.forwarding = 0
net.ipv4.neigh.eth0.base_reachable_time_ms = 30000
net.ipv4.neigh.eth0.retrans_time_ms = 1000
net.ipv4.neigh.eth0.locktime = 99
net.ipv4.neigh.eth0.proxy_delay = 79
net.ipv4.neigh.eth0.anycast_delay = 99
net.ipv4.neigh.eth0.proxy_qlen = 64
net.ipv4.neigh.eth0.unres_qlen = 3
net.ipv4.neigh.eth0.gc_stale_time = 60
net.ipv4.neigh.eth0.delay_first_probe_time = 5
net.ipv4.neigh.eth0.base_reachable_time = 30
net.ipv4.neigh.eth0.retrans_time = 99
net.ipv4.neigh.eth0.app_solicit = 0
net.ipv4.neigh.eth0.ucast_solicit = 3
net.ipv4.neigh.eth0.mcast_solicit = 3
net.ipv4.neigh.lo.base_reachable_time_ms = 30000
net.ipv4.neigh.lo.retrans_time_ms = 1000
net.ipv4.neigh.lo.locktime = 99
net.ipv4.neigh.lo.proxy_delay = 79
net.ipv4.neigh.lo.anycast_delay = 99
net.ipv4.neigh.lo.proxy_qlen = 64
net.ipv4.neigh.lo.unres_qlen = 3
net.ipv4.neigh.lo.gc_stale_time = 60
net.ipv4.neigh.lo.delay_first_probe_time = 5
net.ipv4.neigh.lo.base_reachable_time = 30
net.ipv4.neigh.lo.retrans_time = 99
net.ipv4.neigh.lo.app_solicit = 0
net.ipv4.neigh.lo.ucast_solicit = 3
net.ipv4.neigh.lo.mcast_solicit = 3
net.ipv4.neigh.default.base_reachable_time_ms = 30000
net.ipv4.neigh.default.retrans_time_ms = 1000
net.ipv4.neigh.default.gc_thresh3 = 1024
net.ipv4.neigh.default.gc_thresh2 = 512
net.ipv4.neigh.default.gc_thresh1 = 128
net.ipv4.neigh.default.gc_interval = 30
net.ipv4.neigh.default.locktime = 99
net.ipv4.neigh.default.proxy_delay = 79
net.ipv4.neigh.default.anycast_delay = 99
net.ipv4.neigh.default.proxy_qlen = 64
net.ipv4.neigh.default.unres_qlen = 3
net.ipv4.neigh.default.gc_stale_time = 60
net.ipv4.neigh.default.delay_first_probe_time = 5
net.ipv4.neigh.default.base_reachable_time = 30
net.ipv4.neigh.default.retrans_time = 99
net.ipv4.neigh.default.app_solicit = 0
net.ipv4.neigh.default.ucast_solicit = 3
net.ipv4.neigh.default.mcast_solicit = 3
net.ipv4.tcp_congestion_control = bic
net.ipv4.tcp_tso_win_divisor = 3
net.ipv4.tcp_moderate_rcvbuf = 1
net.ipv4.tcp_no_metrics_save = 0
net.ipv4.ipfrag_secret_interval = 600
net.ipv4.tcp_low_latency = 0
net.ipv4.tcp_frto = 0
net.ipv4.tcp_tw_reuse = 0
net.ipv4.icmp_ratemask = 6168
net.ipv4.icmp_ratelimit = 1000
net.ipv4.tcp_adv_win_scale = 2
net.ipv4.tcp_app_win = 31
net.ipv4.tcp_rmem = 4096	87380	174760
net.ipv4.tcp_wmem = 4096	16384	131072
net.ipv4.tcp_mem = 196608	262144	393216
net.ipv4.tcp_dsack = 1
net.ipv4.tcp_ecn = 0
net.ipv4.tcp_reordering = 3
net.ipv4.tcp_fack = 1
net.ipv4.tcp_orphan_retries = 0
net.ipv4.inet_peer_gc_maxtime = 120
net.ipv4.inet_peer_gc_mintime = 10
net.ipv4.inet_peer_maxttl = 600
net.ipv4.inet_peer_minttl = 120
net.ipv4.inet_peer_threshold = 65664
net.ipv4.igmp_max_msf = 10
net.ipv4.route.secret_interval = 600
net.ipv4.route.min_adv_mss = 256
net.ipv4.route.min_pmtu = 552
net.ipv4.route.mtu_expires = 600
net.ipv4.route.gc_elasticity = 8
net.ipv4.route.error_burst = 5000
net.ipv4.route.error_cost = 1000
net.ipv4.route.redirect_silence = 20480
net.ipv4.route.redirect_number = 9
net.ipv4.route.redirect_load = 20
net.ipv4.route.gc_interval = 60
net.ipv4.route.gc_timeout = 300
net.ipv4.route.gc_min_interval_ms = 500
net.ipv4.route.gc_min_interval = 0
net.ipv4.route.max_size = 2097152
net.ipv4.route.gc_thresh = 131072
net.ipv4.route.max_delay = 10
net.ipv4.route.min_delay = 2
net.ipv4.icmp_errors_use_inbound_ifaddr = 0
net.ipv4.icmp_ignore_bogus_error_responses = 0
net.ipv4.icmp_echo_ignore_broadcasts = 0
net.ipv4.icmp_echo_ignore_all = 0
net.ipv4.ip_local_port_range = 32768	61000
net.ipv4.tcp_max_syn_backlog = 1024
net.ipv4.tcp_rfc1337 = 0
net.ipv4.tcp_stdurg = 0
net.ipv4.tcp_abort_on_overflow = 0
net.ipv4.tcp_tw_recycle = 0
net.ipv4.tcp_fin_timeout = 60
net.ipv4.tcp_retries2 = 15
net.ipv4.tcp_retries1 = 3
net.ipv4.tcp_keepalive_intvl = 75
net.ipv4.tcp_keepalive_probes = 9
net.ipv4.tcp_keepalive_time = 7200
net.ipv4.ipfrag_time = 30
net.ipv4.ip_dynaddr = 0
net.ipv4.ipfrag_low_thresh = 196608
net.ipv4.ipfrag_high_thresh = 262144
net.ipv4.tcp_max_tw_buckets = 180000
net.ipv4.tcp_max_orphans = 65536
net.ipv4.tcp_synack_retries = 5
net.ipv4.tcp_syn_retries = 5
net.ipv4.ip_nonlocal_bind = 0
net.ipv4.ip_no_pmtu_disc = 0
net.ipv4.ip_autoconfig = 0
net.ipv4.ip_default_ttl = 64
net.ipv4.ip_forward = 0
net.ipv4.tcp_retrans_collapse = 1
net.ipv4.tcp_sack = 1
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_timestamps = 1
net.core.netdev_budget = 300
net.core.somaxconn = 128
net.core.optmem_max = 10240
net.core.message_burst = 10
net.core.message_cost = 5
net.core.netdev_max_backlog = 1000
net.core.dev_weight = 64
net.core.rmem_default = 103424
net.core.wmem_default = 103424
net.core.rmem_max = 131071
net.core.wmem_max = 131071
vm.swap_token_timeout = 0
vm.legacy_va_layout = 0
vm.vfs_cache_pressure = 100
vm.block_dump = 0
vm.laptop_mode = 0
vm.max_map_count = 65536
vm.min_free_kbytes = 3831
vm.lowmem_reserve_ratio = 256	32
vm.swappiness = 60
vm.nr_pdflush_threads = 2
vm.dirty_expire_centisecs = 3000
vm.dirty_writeback_centisecs = 500
vm.dirty_ratio = 40
vm.dirty_background_ratio = 10
vm.page-cluster = 3
vm.overcommit_ratio = 50
vm.overcommit_memory = 0
kernel.randomize_va_space = 1
kernel.bootloader_type = 113
kernel.unknown_nmi_panic = 0
kernel.ngroups_max = 65536
kernel.printk_ratelimit_burst = 10
kernel.printk_ratelimit = 5
kernel.panic_on_oops = 0
kernel.pid_max = 32768
kernel.overflowgid = 65534
kernel.overflowuid = 65534
kernel.pty.nr = 2
kernel.pty.max = 4096
kernel.random.uuid = 52ff0c08-dd7e-47e6-9c59-8c9c85b8989b
kernel.random.boot_id = 4b8f048a-725d-4862-88e6-efc15843042e
kernel.random.write_wakeup_threshold = 128
kernel.random.read_wakeup_threshold = 64
kernel.random.entropy_avail = 3089
kernel.random.poolsize = 4096
kernel.threads-max = 32767
kernel.cad_pid = 1
kernel.sem = 250	32000	32	128
kernel.msgmnb = 16384
kernel.msgmni = 16
kernel.msgmax = 8192
kernel.shmmni = 4096
kernel.shmall = 2097152
kernel.shmmax = 33554432
kernel.hotplug = /sbin/udevsend
kernel.modprobe = /sbin/modprobe
kernel.printk = 15	4	1	7
kernel.ctrl-alt-del = 0
kernel.real-root-dev = 0
kernel.cap-bound = -257
kernel.tainted = 1
kernel.core_pattern = core
kernel.core_uses_pid = 0
kernel.panic = 0
kernel.domainname = (none)
kernel.hostname = opteron
kernel.version = #7 SMP Mon Sep 5 04:55:34 CEST 2005
kernel.osrelease = 2.6.13
kernel.ostype = Linux

[8.] Config file
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.13
# Mon Sep  5 04:50:46 2005
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
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_CPUSETS is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
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
# CONFIG_MODVERSIONS is not set
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
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
CONFIG_MK8=y
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_SMP=y
CONFIG_NR_CPUS=2
# CONFIG_SCHED_SMT is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
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
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_IRQBALANCE=y
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_REGPARM is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_PHYSICAL_START=0x100000
# CONFIG_KEXEC is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set
CONFIG_SUSPEND_SMP=y

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_HOTKEY=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_HOTPLUG_CPU is not set
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set
# CONFIG_ACPI_CONTAINER is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set

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
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG_CPU=y

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
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
# CONFIG_IP_TCPDIAG is not set
# CONFIG_IP_TCPDIAG_IPV6 is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=8192
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_LBD=y
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_AS is not set
# CONFIG_IOSCHED_DEADLINE is not set
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
# CONFIG_BLK_DEV_IDEDISK is not set
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_SHARE_IRQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_AHCI is not set
# CONFIG_SCSI_SATA_SVW is not set
# CONFIG_SCSI_ATA_PIIX is not set
# CONFIG_SCSI_SATA_NV is not set
# CONFIG_SCSI_SATA_PROMISE is not set
# CONFIG_SCSI_SATA_QSTOR is not set
# CONFIG_SCSI_SATA_SX4 is not set
CONFIG_SCSI_SATA_SIL=y
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_ULI is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA24XX is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_DM=m
CONFIG_DM_CRYPT=m
# CONFIG_DM_SNAPSHOT is not set
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_ZERO is not set
# CONFIG_DM_MULTIPATH is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=y

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set
# CONFIG_IEEE1394_EXTRA_CONFIG_ROMS is not set
# CONFIG_IEEE1394_EXPORT_FULL_API is not set

#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=y

#
# Protocol Drivers
#
# CONFIG_IEEE1394_VIDEO1394 is not set
# CONFIG_IEEE1394_SBP2 is not set
# CONFIG_IEEE1394_ETH1394 is not set
# CONFIG_IEEE1394_DV1394 is not set
# CONFIG_IEEE1394_RAWIO is not set
# CONFIG_IEEE1394_CMP is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=y
# CONFIG_E1000_NAPI is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SKGE is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

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
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
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
# CONFIG_MOUSE_PS2 is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
CONFIG_AGP_AMD64=y
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
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
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
# CONFIG_I2C_AMD756_S4882 is not set
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_ISA is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set
# CONFIG_I2C_SENSOR is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=y
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

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
CONFIG_DVB=y
CONFIG_DVB_CORE=m

#
# Supported SAA7146 based PCI Adapters
#
# CONFIG_DVB_AV7110 is not set
# CONFIG_DVB_BUDGET is not set
# CONFIG_DVB_BUDGET_CI is not set
# CONFIG_DVB_BUDGET_AV is not set

#
# Supported USB Adapters
#
# CONFIG_DVB_USB is not set
# CONFIG_DVB_TTUSB_BUDGET is not set
# CONFIG_DVB_TTUSB_DEC is not set
# CONFIG_DVB_CINERGYT2 is not set

#
# Supported FlexCopII (B2C2) Adapters
#
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_USB is not set
# CONFIG_DVB_B2C2_FLEXCOP_DEBUG is not set

#
# Supported BT878 Adapters
#

#
# Supported Pluto2 Adapters
#
# CONFIG_DVB_PLUTO2 is not set

#
# Supported DVB Frontends
#

#
# Customise DVB Frontends
#

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_STV0299=m
# CONFIG_DVB_CX24110 is not set
# CONFIG_DVB_TDA8083 is not set
# CONFIG_DVB_TDA80XX is not set
CONFIG_DVB_MT312=m
# CONFIG_DVB_VES1X93 is not set
# CONFIG_DVB_S5H1420 is not set

#
# DVB-T (terrestrial) frontends
#
# CONFIG_DVB_SP8870 is not set
# CONFIG_DVB_SP887X is not set
# CONFIG_DVB_CX22700 is not set
# CONFIG_DVB_CX22702 is not set
# CONFIG_DVB_L64781 is not set
# CONFIG_DVB_TDA1004X is not set
# CONFIG_DVB_NXT6000 is not set
CONFIG_DVB_MT352=m
# CONFIG_DVB_DIB3000MB is not set
# CONFIG_DVB_DIB3000MC is not set

#
# DVB-C (cable) frontends
#
# CONFIG_DVB_ATMEL_AT76C651 is not set
# CONFIG_DVB_VES1820 is not set
# CONFIG_DVB_TDA10021 is not set
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terresterial DTV) frontends
#
CONFIG_DVB_NXT2002=m
# CONFIG_DVB_OR51211 is not set
# CONFIG_DVB_OR51132 is not set
CONFIG_DVB_BCM3510=m
# CONFIG_DVB_LGDT330X is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SOFT_CURSOR=y
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_MODE_HELPERS is not set
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=y
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
CONFIG_SND_EMU10K1=y
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_HDA_INTEL is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be
needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_USBAT=y
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
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_ITMTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
CONFIG_USB_MON=y

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

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
# SN Devices
#

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set

#
# XFS support
#
CONFIG_XFS_FS=y
CONFIG_XFS_EXPORT=y
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_SECURITY is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
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
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=15
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_EARLY_PRINTK=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_AES_586=m
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_DEFLATE is not set
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
# CONFIG_CRC_CCITT is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y

[9.] Other notes, patches, fixes, workarounds:
  _|_|                _|
_|    _|  _|  _|_|  _|_|_|_|
_|    _|  _|_|        _|
_|    _|  _|          _|
  _|_|    _|            _|_|
OOPS Reporting Tool v.b5
www.wsi.edu.pl/~piotrowskim/
/files/ort/beta/
