Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129318AbRBFPlw>; Tue, 6 Feb 2001 10:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129639AbRBFPll>; Tue, 6 Feb 2001 10:41:41 -0500
Received: from tux.rsn.hk-r.se ([194.47.143.135]:11674 "EHLO tux.rsn.hk-r.se")
	by vger.kernel.org with ESMTP id <S129318AbRBFPlZ>;
	Tue, 6 Feb 2001 10:41:25 -0500
Date: Tue, 6 Feb 2001 16:14:39 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: macro@ds2.pg.gda.pl
cc: linux-kernel@vger.kernel.org
Subject: APIC lockup in 2.4.x-x
Message-ID: <Pine.LNX.4.21.0102061559520.25695-100000@tux.rsn.hk-r.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I saw your patch for the APIC lockup and I saw that it was included in
2.4.1-ac2 so I tried that one.. but it didn't help..

I can begin with describing my machine:

dual pIII 800 (133MHz FSB)
Asus P3C-D mainboard with i820 chipset
256MB rimm (rambus)
Dlink DFE570TX (4 port tulip card)
Adaptec 29160 scsicard and 18GB scsidisk.

I belive that my problems are APIC related and I'm wondering if you might
have a clue to what's going on.

My test consists of quite heavy networktraffic and hardly any diskactivity
at all (syslog only).

It deadlocked after a few hours with 2.4.1-ac2 just as it does with all
other kernels I've tested. it appears to be stable with "noapic" on
2.4.1-pre10 , 2.4.1, 2.4.1-ac2. And it's also stable on UP (didn't try
with APIC on UP)

Right now the machine has an uptime of 17 hours and it has been recieving
150Mbit most of the time. and only 100Mbit the rest of the time.
This is with "noapic".

One very interesting part of the bootup messages is this:

Feb  5 00:11:57 rby-gw kernel: testing the IO APIC.......................
Feb  5 00:11:57 rby-gw kernel:
Feb  5 00:11:57 rby-gw kernel:  WARNING: unexpected IO-APIC, please mail
Feb  5 00:11:57 rby-gw kernel:           to linux-smp@vger.kernel.org
Feb  5 00:11:57 rby-gw kernel: .................................... done.

The output from /proc/cpuinfo, /proc/interrupts, lspci and the
bootmessages are included below.

I hope you can help me with this.

/Martin


/proc/cpuinfo:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 803.426
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1602.35

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 803.426
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1605.63


/proc/interrupts:

           CPU0       CPU1       
  0:    6254740          0          XT-PIC  timer
  1:          2          0          XT-PIC  keyboard
  2:          0          0          XT-PIC  cascade
  4:      12701          0          XT-PIC  serial
  5:   70870065          0          XT-PIC  eth1
 10:  646763830          0          XT-PIC  eth3
 11:      38868          0          XT-PIC  aic7xxx
 14:      79953          0          XT-PIC  ide0
NMI:          0          0 
LOC:    6254887    6254910 
ERR:          0

(booted with "noapic")

lspci:

00:00.0 Host bridge: Intel Corporation 82820 820 (Camino) Chipset Host Bridge (MCH) (rev 03)
00:01.0 PCI bridge: Intel Corporation 82820 820 (Camino) Chipset PCI to AGP Bridge (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801AA PCI Bridge (rev 02)
00:1f.0 ISA bridge: Intel Corporation 82801AA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02)
00:1f.2 USB Controller: Intel Corporation 82801AA USB (rev 02)
00:1f.3 SMBus: Intel Corporation 82801AA SMBus (rev 02)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 (rev 0b)
02:05.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01)
02:08.0 SCSI storage controller: Adaptec 7892A (rev 02)
02:0a.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
02:0b.0 DPIO module: Quicklogic Corporation: Unknown device 5030 (rev 01)
03:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
03:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
03:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
03:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)

(the soundcard is integrated on the mainboard)


bootmessages:

Feb  5 00:11:56 rby-gw kernel: klogd 1.3-3#33.1, log source = /proc/kmsg started.
Feb  5 00:11:56 rby-gw kernel: Inspecting /boot/System.map-2.4.1-ac2
Feb  5 00:11:57 rby-gw kernel: Loaded 14269 symbols from /boot/System.map-2.4.1-ac2.
Feb  5 00:11:57 rby-gw kernel: Symbols match kernel version 2.4.1.
Feb  5 00:11:57 rby-gw kernel: Loaded 112 symbols from 9 modules.
Feb  5 00:11:57 rby-gw kernel: Linux version 2.4.1-ac2 (root@tux) (gcc version 2.95.3 20010125 (prerelease)) #2 SMP Sun Feb 4 23:37:53 CET 2001
Feb  5 00:11:57 rby-gw kernel: BIOS-provided physical RAM map:
Feb  5 00:11:57 rby-gw kernel:  BIOS-e820: 000000000009f800 @ 0000000000000000 (usable)
Feb  5 00:11:57 rby-gw kernel:  BIOS-e820: 0000000000000800 @ 000000000009f800 (reserved)
Feb  5 00:11:57 rby-gw kernel:  BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
Feb  5 00:11:57 rby-gw kernel:  BIOS-e820: 000000000fefc000 @ 0000000000100000 (usable)
Feb  5 00:11:57 rby-gw kernel:  BIOS-e820: 0000000000003000 @ 000000000fffc000 (ACPI data)
Feb  5 00:11:57 rby-gw kernel:  BIOS-e820: 0000000000001000 @ 000000000ffff000 (ACPI NVS)
Feb  5 00:11:57 rby-gw kernel:  BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
Feb  5 00:11:57 rby-gw kernel:  BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
Feb  5 00:11:57 rby-gw kernel:  BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
Feb  5 00:11:57 rby-gw kernel: Scan SMP from c0000000 for 1024 bytes.
Feb  5 00:11:57 rby-gw kernel: Scan SMP from c009fc00 for 1024 bytes.
Feb  5 00:11:57 rby-gw kernel: Scan SMP from c00f0000 for 65536 bytes.
Feb  5 00:11:57 rby-gw kernel: found SMP MP-table at 000f48d0
Feb  5 00:11:57 rby-gw kernel: hm, page 000f4000 reserved twice.
Feb  5 00:11:57 rby-gw kernel: hm, page 000f5000 reserved twice.
Feb  5 00:11:57 rby-gw kernel: hm, page 000f4000 reserved twice.
Feb  5 00:11:57 rby-gw kernel: hm, page 000f5000 reserved twice.
Feb  5 00:11:57 rby-gw kernel: On node 0 totalpages: 65532
Feb  5 00:11:57 rby-gw kernel: zone(0): 4096 pages.
Feb  5 00:11:57 rby-gw kernel: zone(1): 61436 pages.
Feb  5 00:11:57 rby-gw kernel: zone(2): 0 pages.
Feb  5 00:11:57 rby-gw kernel: Intel MultiProcessor Specification v1.1
Feb  5 00:11:57 rby-gw kernel:     Virtual Wire compatibility mode.
Feb  5 00:11:57 rby-gw kernel: OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Feb  5 00:11:57 rby-gw kernel: Processor #1 Pentium(tm) Pro APIC version 17
Feb  5 00:11:57 rby-gw kernel:     Floating point unit present.
Feb  5 00:11:57 rby-gw kernel:     Machine Exception supported.
Feb  5 00:11:57 rby-gw kernel:     64 bit compare & exchange supported.
Feb  5 00:11:57 rby-gw kernel:     Internal APIC present.
Feb  5 00:11:57 rby-gw kernel:     SEP present.
Feb  5 00:11:57 rby-gw kernel:     MTRR  present.
Feb  5 00:11:57 rby-gw kernel:     PGE  present.
Feb  5 00:11:57 rby-gw kernel:     MCA  present.
Feb  5 00:11:57 rby-gw kernel:     CMOV  present.
Feb  5 00:11:57 rby-gw kernel:     PAT  present.
Feb  5 00:11:57 rby-gw kernel:     PSE  present.
Feb  5 00:11:57 rby-gw kernel:     PSN  present.
Feb  5 00:11:57 rby-gw kernel:     MMX  present.
Feb  5 00:11:57 rby-gw kernel:     FXSR  present.
Feb  5 00:11:57 rby-gw kernel:     XMM  present.
Feb  5 00:11:57 rby-gw kernel:     Bootup CPU
Feb  5 00:11:57 rby-gw kernel: Processor #0 Pentium(tm) Pro APIC version 17
Feb  5 00:11:57 rby-gw kernel:     Floating point unit present.
Feb  5 00:11:57 rby-gw kernel:     Machine Exception supported.
Feb  5 00:11:57 rby-gw kernel:     64 bit compare & exchange supported.
Feb  5 00:11:57 rby-gw kernel:     Internal APIC present.
Feb  5 00:11:57 rby-gw kernel:     SEP present.
Feb  5 00:11:57 rby-gw kernel:     MTRR  present.
Feb  5 00:11:57 rby-gw kernel:     PGE  present.
Feb  5 00:11:57 rby-gw kernel:     MCA  present.
Feb  5 00:11:57 rby-gw kernel:     CMOV  present.
Feb  5 00:11:57 rby-gw kernel:     PAT  present.
Feb  5 00:11:57 rby-gw kernel:     PSE  present.
Feb  5 00:11:57 rby-gw kernel:     MMX  present.
Feb  5 00:11:57 rby-gw kernel:     FXSR  present.
Feb  5 00:11:57 rby-gw kernel:     XMM  present.
Feb  5 00:11:57 rby-gw kernel: Bus #0 is PCI   
Feb  5 00:11:57 rby-gw kernel: Bus #1 is PCI   
Feb  5 00:11:57 rby-gw kernel: Bus #2 is PCI   
Feb  5 00:11:57 rby-gw kernel: Bus #3 is PCI   
Feb  5 00:11:57 rby-gw kernel: Bus #4 is ISA   
Feb  5 00:11:57 rby-gw kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Feb  5 00:11:57 rby-gw kernel: Int: type 3, pol 0, trig 0, bus 4, IRQ 00, APIC ID 2, APIC INT 00
Feb  5 00:11:57 rby-gw kernel: Int: type 0, pol 0, trig 0, bus 4, IRQ 01, APIC ID 2, APIC INT 01
Feb  5 00:11:57 rby-gw kernel: Int: type 0, pol 0, trig 0, bus 4, IRQ 00, APIC ID 2, APIC INT 02
Feb  5 00:11:57 rby-gw kernel: Int: type 0, pol 0, trig 0, bus 4, IRQ 03, APIC ID 2, APIC INT 03
Feb  5 00:11:57 rby-gw kernel: Int: type 0, pol 0, trig 0, bus 4, IRQ 04, APIC ID 2, APIC INT 04
Feb  5 00:11:57 rby-gw kernel: Int: type 0, pol 0, trig 0, bus 4, IRQ 06, APIC ID 2, APIC INT 06
Feb  5 00:11:57 rby-gw kernel: Int: type 0, pol 0, trig 0, bus 4, IRQ 07, APIC ID 2, APIC INT 07
Feb  5 00:11:57 rby-gw kernel: Int: type 0, pol 0, trig 0, bus 4, IRQ 08, APIC ID 2, APIC INT 08
Feb  5 00:11:57 rby-gw kernel: Int: type 0, pol 0, trig 0, bus 4, IRQ 09, APIC ID 2, APIC INT 09
Feb  5 00:11:57 rby-gw kernel: Int: type 0, pol 0, trig 0, bus 4, IRQ 0e, APIC ID 2, APIC INT 0e
Feb  5 00:11:57 rby-gw kernel: Int: type 0, pol 0, trig 0, bus 4, IRQ 0f, APIC ID 2, APIC INT 0f
Feb  5 00:11:57 rby-gw kernel: Int: type 0, pol 3, trig 3, bus 4, IRQ 0b, APIC ID 2, APIC INT 10
Feb  5 00:11:57 rby-gw kernel: Int: type 0, pol 3, trig 3, bus 4, IRQ 0a, APIC ID 2, APIC INT 11
Feb  5 00:11:57 rby-gw kernel: Int: type 0, pol 3, trig 3, bus 4, IRQ 0c, APIC ID 2, APIC INT 12
Feb  5 00:11:57 rby-gw kernel: Int: type 0, pol 3, trig 3, bus 4, IRQ 05, APIC ID 2, APIC INT 13
Feb  5 00:11:57 rby-gw kernel: Lint: type 3, pol 1, trig 1, bus 4, IRQ 00, APIC ID ff, APIC LINT 00
Feb  5 00:11:57 rby-gw kernel: Lint: type 1, pol 1, trig 1, bus 4, IRQ 00, APIC ID ff, APIC LINT 01
Feb  5 00:11:57 rby-gw kernel: Processors: 2
Feb  5 00:11:57 rby-gw kernel: mapped APIC to ffffe000 (fee00000)
Feb  5 00:11:57 rby-gw kernel: mapped IOAPIC to ffffd000 (fec00000)
Feb  5 00:11:57 rby-gw kernel: Kernel command line: auto BOOT_IMAGE=Linux ro root=301 BOOT_FILE=/boot/vmlinuz-2.4.1-ac2 console=ttyS0,38400N8 console=tty0
Feb  5 00:11:57 rby-gw kernel: Initializing CPU#0
Feb  5 00:11:57 rby-gw kernel: Detected 803.425 MHz processor.
Feb  5 00:11:57 rby-gw kernel: Console: colour VGA+ 80x25
Feb  5 00:11:57 rby-gw kernel: Calibrating delay loop... 1602.35 BogoMIPS
Feb  5 00:11:57 rby-gw kernel: Memory: 255284k/262128k available (1165k kernel code, 6456k reserved, 410k data, 200k init, 0k highmem)
Feb  5 00:11:57 rby-gw kernel: Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Feb  5 00:11:57 rby-gw kernel: Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Feb  5 00:11:57 rby-gw kernel: Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Feb  5 00:11:57 rby-gw kernel: Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Feb  5 00:11:57 rby-gw kernel: CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
Feb  5 00:11:57 rby-gw kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Feb  5 00:11:57 rby-gw kernel: CPU: L2 cache: 256K
Feb  5 00:11:57 rby-gw kernel: Intel machine check architecture supported.
Feb  5 00:11:57 rby-gw kernel: Intel machine check reporting enabled on CPU#0.
Feb  5 00:11:57 rby-gw kernel: CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Feb  5 00:11:57 rby-gw kernel: CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
Feb  5 00:11:57 rby-gw kernel: CPU: Common caps: 0383fbff 00000000 00000000 00000000
Feb  5 00:11:57 rby-gw kernel: Enabling fast FPU save and restore... done.
Feb  5 00:11:57 rby-gw kernel: Enabling unmasked SIMD FPU exception support... done.
Feb  5 00:11:57 rby-gw kernel: Checking 'hlt' instruction... OK.
Feb  5 00:11:57 rby-gw kernel: POSIX conformance testing by UNIFIX
Feb  5 00:11:57 rby-gw kernel: mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
Feb  5 00:11:57 rby-gw kernel: mtrr: detected mtrr type: Intel
Feb  5 00:11:57 rby-gw kernel: CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
Feb  5 00:11:57 rby-gw kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Feb  5 00:11:57 rby-gw kernel: CPU: L2 cache: 256K
Feb  5 00:11:57 rby-gw kernel: Intel machine check reporting enabled on CPU#0.
Feb  5 00:11:57 rby-gw kernel: CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Feb  5 00:11:57 rby-gw kernel: CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
Feb  5 00:11:57 rby-gw kernel: CPU: Common caps: 0383fbff 00000000 00000000 00000000
Feb  5 00:11:57 rby-gw kernel: CPU0: Intel Pentium III (Coppermine) stepping 03
Feb  5 00:11:57 rby-gw kernel: per-CPU timeslice cutoff: 731.26 usecs.
Feb  5 00:11:57 rby-gw kernel: Getting VERSION: 40011
Feb  5 00:11:57 rby-gw kernel: Getting VERSION: 40011
Feb  5 00:11:57 rby-gw kernel: Getting ID: 1000000
Feb  5 00:11:57 rby-gw kernel: Getting ID: e000000
Feb  5 00:11:57 rby-gw kernel: Getting LVT0: 8700
Feb  5 00:11:57 rby-gw kernel: Getting LVT1: 400
Feb  5 00:11:57 rby-gw kernel: enabled ExtINT on CPU#0
Feb  5 00:11:57 rby-gw kernel: ESR value before enabling vector: 00000000
Feb  5 00:11:57 rby-gw kernel: ESR value after enabling vector: 00000000
Feb  5 00:11:57 rby-gw kernel: CPU present map: 3
Feb  5 00:11:57 rby-gw kernel: Booting processor 1/0 eip 2000
Feb  5 00:11:57 rby-gw kernel: Setting warm reset code and vector.
Feb  5 00:11:57 rby-gw kernel: 1.
Feb  5 00:11:57 rby-gw kernel: 2.
Feb  5 00:11:57 rby-gw kernel: 3.
Feb  5 00:11:57 rby-gw kernel: Asserting INIT.
Feb  5 00:11:57 rby-gw kernel: Waiting for send to finish...
Feb  5 00:11:57 rby-gw kernel: +Deasserting INIT.
Feb  5 00:11:57 rby-gw kernel: Waiting for send to finish...
Feb  5 00:11:57 rby-gw kernel: +#startup loops: 2.
Feb  5 00:11:57 rby-gw kernel: Sending STARTUP #1.
Feb  5 00:11:57 rby-gw kernel: After apic_write.
Feb  5 00:11:57 rby-gw kernel: Initializing CPU#1
Feb  5 00:11:57 rby-gw kernel: Startup point 1.
Feb  5 00:11:57 rby-gw kernel: CPU#1 (phys ID: 0) waiting for CALLOUT
Feb  5 00:11:57 rby-gw kernel: Waiting for send to finish...
Feb  5 00:11:57 rby-gw kernel: +Sending STARTUP #2.
Feb  5 00:11:57 rby-gw kernel: After apic_write.
Feb  5 00:11:57 rby-gw kernel: Startup point 1.
Feb  5 00:11:57 rby-gw kernel: Waiting for send to finish...
Feb  5 00:11:57 rby-gw kernel: +After Startup.
Feb  5 00:11:57 rby-gw kernel: Before Callout 1.
Feb  5 00:11:57 rby-gw kernel: After Callout 1.
Feb  5 00:11:57 rby-gw kernel: CALLIN, before setup_local_APIC().
Feb  5 00:11:57 rby-gw kernel: masked ExtINT on CPU#1
Feb  5 00:11:57 rby-gw kernel: ESR value before enabling vector: 00000000
Feb  5 00:11:57 rby-gw kernel: ESR value after enabling vector: 00000000
Feb  5 00:11:57 rby-gw kernel: Calibrating delay loop... 1605.63 BogoMIPS
Feb  5 00:11:57 rby-gw kernel: Stack at about cfff5fbc
Feb  5 00:11:57 rby-gw kernel: CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
Feb  5 00:11:57 rby-gw kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Feb  5 00:11:57 rby-gw kernel: CPU: L2 cache: 256K
Feb  5 00:11:57 rby-gw kernel: Intel machine check reporting enabled on CPU#1.
Feb  5 00:11:57 rby-gw kernel: CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Feb  5 00:11:57 rby-gw kernel: CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
Feb  5 00:11:57 rby-gw kernel: CPU: Common caps: 0383fbff 00000000 00000000 00000000
Feb  5 00:11:57 rby-gw kernel: OK.
Feb  5 00:11:57 rby-gw kernel: CPU1: Intel Pentium III (Coppermine) stepping 03
Feb  5 00:11:57 rby-gw kernel: CPU has booted.
Feb  5 00:11:57 rby-gw kernel: Before bogomips.
Feb  5 00:11:57 rby-gw kernel: Total of 2 processors activated (3207.98 BogoMIPS).
Feb  5 00:11:57 rby-gw kernel: Before bogocount - setting activated=1.
Feb  5 00:11:57 rby-gw kernel: Boot done.
Feb  5 00:11:57 rby-gw kernel: ENABLING IO-APIC IRQs
Feb  5 00:11:57 rby-gw kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
Feb  5 00:11:57 rby-gw kernel: Synchronizing Arb IDs.
Feb  5 00:11:57 rby-gw kernel: ..TIMER: vector=49 pin1=2 pin2=0
Feb  5 00:11:57 rby-gw kernel: activating NMI Watchdog ... done.
Feb  5 00:11:57 rby-gw kernel: testing NMI watchdog ... OK.
Feb  5 00:11:57 rby-gw kernel: testing the IO APIC.......................
Feb  5 00:11:57 rby-gw kernel: 
Feb  5 00:11:57 rby-gw kernel:  WARNING: unexpected IO-APIC, please mail
Feb  5 00:11:57 rby-gw kernel:           to linux-smp@vger.kernel.org
Feb  5 00:11:57 rby-gw kernel: .................................... done.
Feb  5 00:11:57 rby-gw kernel: calibrating APIC timer ...
Feb  5 00:11:57 rby-gw kernel: ..... CPU clock speed is 803.4238 MHz.
Feb  5 00:11:57 rby-gw kernel: ..... host bus clock speed is 133.9038 MHz.
Feb  5 00:11:57 rby-gw kernel: cpu: 0, clocks: 1339038, slice: 446346
Feb  5 00:11:57 rby-gw kernel: CPU0<T0:1339024,T1:892672,D:6,S:446346,C:1339038>
Feb  5 00:11:57 rby-gw kernel: cpu: 1, clocks: 1339038, slice: 446346
Feb  5 00:11:57 rby-gw kernel: CPU1<T0:1339024,T1:446320,D:12,S:446346,C:1339038>
Feb  5 00:11:57 rby-gw kernel: checking TSC synchronization across CPUs: passed.
Feb  5 00:11:57 rby-gw kernel: Setting commenced=1, go go go
Feb  5 00:11:57 rby-gw kernel: mtrr: your CPUs had inconsistent variable MTRR settings
Feb  5 00:11:57 rby-gw kernel: mtrr: probably your BIOS does not setup all CPUs
Feb  5 00:11:57 rby-gw kernel: PCI: PCI BIOS revision 2.10 entry at 0xf06d0, last bus=3
Feb  5 00:11:57 rby-gw kernel: PCI: Using configuration type 1
Feb  5 00:11:57 rby-gw kernel: PCI: Probing PCI hardware
Feb  5 00:11:57 rby-gw kernel: PCI: Using IRQ router PIIX [8086/2410] at 00:1f.0
Feb  5 00:11:57 rby-gw kernel: isapnp: Scanning for Pnp cards...
Feb  5 00:11:57 rby-gw kernel: isapnp: No Plug & Play device found
Feb  5 00:11:57 rby-gw kernel: Linux NET4.0 for Linux 2.4
Feb  5 00:11:57 rby-gw kernel: Based upon Swansea University Computer Society NET3.039
Feb  5 00:11:57 rby-gw kernel: Initializing RT netlink socket
Feb  5 00:11:57 rby-gw kernel: Starting kswapd v1.8
Feb  5 00:11:57 rby-gw kernel: Detected PS/2 Mouse Port.
Feb  5 00:11:57 rby-gw kernel: pty: 256 Unix98 ptys configured
Feb  5 00:11:57 rby-gw kernel: block: queued sectors max/low 169570kB/56523kB, 512 slots per queue
Feb  5 00:11:57 rby-gw kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Feb  5 00:11:57 rby-gw kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb  5 00:11:57 rby-gw kernel: PIIX4: IDE controller on PCI bus 00 dev f9
Feb  5 00:11:57 rby-gw kernel: PIIX4: chipset revision 2
Feb  5 00:11:57 rby-gw kernel: PIIX4: not 100%% native mode: will probe irqs later
Feb  5 00:11:57 rby-gw kernel:     ide0: BM-DMA at 0x7800-0x7807, BIOS settings: hda:pio, hdb:pio
Feb  5 00:11:57 rby-gw kernel:     ide1: BM-DMA at 0x7808-0x780f, BIOS settings: hdc:pio, hdd:pio
Feb  5 00:11:57 rby-gw kernel: hda: SanDisk SDCFB-128, ATA DISK drive
Feb  5 00:11:57 rby-gw kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb  5 00:11:57 rby-gw kernel: hda: 250880 sectors (128 MB) w/1KiB Cache, CHS=980/8/32, DMA
Feb  5 00:11:57 rby-gw kernel: Partition check:
Feb  5 00:11:57 rby-gw kernel:  hda:hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Feb  5 00:11:57 rby-gw kernel: hda: dma_intr: error=0x04 { DriveStatusError }
Feb  5 00:11:57 rby-gw kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Feb  5 00:11:57 rby-gw kernel: hda: dma_intr: error=0x04 { DriveStatusError }
Feb  5 00:11:57 rby-gw kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Feb  5 00:11:57 rby-gw kernel: hda: dma_intr: error=0x04 { DriveStatusError }
Feb  5 00:11:57 rby-gw kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Feb  5 00:11:57 rby-gw kernel: hda: dma_intr: error=0x04 { DriveStatusError }
Feb  5 00:11:57 rby-gw kernel: hda: DMA disabled
Feb  5 00:11:57 rby-gw kernel: ide0: reset: success
Feb  5 00:11:57 rby-gw kernel:  hda1
Feb  5 00:11:57 rby-gw kernel: Floppy drive(s): fd0 is 1.44M
Feb  5 00:11:57 rby-gw kernel: FDC 0 is a National Semiconductor PC87306
Feb  5 00:11:57 rby-gw kernel: Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Feb  5 00:11:57 rby-gw kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Feb  5 00:11:57 rby-gw kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Feb  5 00:11:57 rby-gw kernel: SCSI subsystem driver Revision: 1.00
Feb  5 00:11:57 rby-gw kernel: (scsi0) <Adaptec AIC-7892 Ultra 160/m SCSI host adapter> found at PCI 2/8/0
Feb  5 00:11:57 rby-gw kernel: (scsi0) Wide Channel, SCSI ID=7, 32/255 SCBs
Feb  5 00:11:57 rby-gw kernel: (scsi0) Downloading sequencer code... 392 instructions downloaded
Feb  5 00:11:57 rby-gw kernel: scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
Feb  5 00:11:57 rby-gw kernel:        <Adaptec AIC-7892 Ultra 160/m SCSI host adapter>
Feb  5 00:11:57 rby-gw kernel: (scsi0:0:6:0) Synchronous at 160.0 Mbyte/sec, offset 63.
Feb  5 00:11:57 rby-gw kernel:   Vendor: IBM       Model: DDYS-T18350N      Rev: S80D
Feb  5 00:11:57 rby-gw kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Feb  5 00:11:57 rby-gw kernel: Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
Feb  5 00:11:57 rby-gw kernel: SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
Feb  5 00:11:57 rby-gw kernel:  sda: sda1 sda2
Feb  5 00:11:57 rby-gw kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Feb  5 00:11:57 rby-gw kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Feb  5 00:11:57 rby-gw kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Feb  5 00:11:57 rby-gw kernel: TCP: Hash tables configured (established 16384 bind 16384)
Feb  5 00:11:57 rby-gw kernel: Linux IP multicast router 0.06 plus PIM-SM
Feb  5 00:11:57 rby-gw kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Feb  5 00:11:57 rby-gw kernel:  hda: hda1
Feb  5 00:11:57 rby-gw kernel:  hda: hda1
Feb  5 00:11:57 rby-gw kernel: VFS: Mounted root (ext2 filesystem) readonly.
Feb  5 00:11:57 rby-gw kernel: Freeing unused kernel memory: 200k freed
Feb  5 00:11:57 rby-gw kernel: pcwd: v1.10 (06/05/99) Ken Hollis (kenji@bitgate.com)
Feb  5 00:11:57 rby-gw kernel: pcwd: No card detected, or port not available.
Feb  5 00:11:57 rby-gw kernel: Linux Tulip driver version 0.9.4.3 (Apr 14, 2000) + fr+fc 010111
Feb  5 00:11:57 rby-gw kernel: eth0: Digital DS21143 Tulip rev 65 at 0xa800, 00:80:C8:CA:51:DD, IRQ 12.
Feb  5 00:11:57 rby-gw kernel: eth0:  EEPROM default media type Autosense.
Feb  5 00:11:57 rby-gw kernel: eth0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
Feb  5 00:11:57 rby-gw kernel: eth0:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
Feb  5 00:11:57 rby-gw kernel: eth1: Digital DS21143 Tulip rev 65 at 0xa400, 00:80:C8:CA:51:DE, IRQ 5.
Feb  5 00:11:57 rby-gw kernel: eth1:  EEPROM default media type Autosense.
Feb  5 00:11:57 rby-gw kernel: eth1:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
Feb  5 00:11:57 rby-gw kernel: eth1:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
Feb  5 00:11:57 rby-gw kernel: eth2: Digital DS21143 Tulip rev 65 at 0xa000, 00:80:C8:CA:51:DF, IRQ 11.
Feb  5 00:11:57 rby-gw kernel: eth2:  EEPROM default media type Autosense.
Feb  5 00:11:57 rby-gw kernel: eth2:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
Feb  5 00:11:57 rby-gw kernel: eth2:  MII transceiver #1 config 3100 status 7849 advertising 01e1.
Feb  5 00:11:57 rby-gw kernel: eth3: Digital DS21143 Tulip rev 65 at 0x9800, 00:80:C8:CA:51:E0, IRQ 10.
Feb  5 00:11:57 rby-gw kernel: eth3:  EEPROM default media type Autosense.
Feb  5 00:11:57 rby-gw kernel: eth3:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
Feb  5 00:11:57 rby-gw kernel: eth3:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
Feb  5 00:11:57 rby-gw kernel: ip_tables: (c)2000 Netfilter core team
Feb  5 00:11:57 rby-gw kernel: ip_conntrack (32768 buckets, 262144 max)
Feb  5 00:11:57 rby-gw kernel: reiserfs: checking transaction log (device 08:01) ...
Feb  5 00:11:57 rby-gw kernel: Using r5 hash to sort names
Feb  5 00:11:57 rby-gw kernel: ReiserFS version 3.6.25
Feb  5 00:11:57 rby-gw kernel: reiserfs: checking transaction log (device 08:02) ...
Feb  5 00:11:57 rby-gw kernel: Using r5 hash to sort names
Feb  5 00:11:57 rby-gw kernel: ReiserFS version 3.6.25
Feb  5 00:11:57 rby-gw kernel: ipfm uses obsolete (PF_INET,SOCK_PACKET)
Feb  5 00:11:57 rby-gw kernel: eth3: Promiscuous mode enabled.
Feb  5 00:11:57 rby-gw kernel: device eth3 entered promiscuous mode
Feb  5 00:11:57 rby-gw kernel: eth3: Promiscuous mode enabled.
Feb  5 00:11:57 rby-gw kernel: device eth3 left promiscuous mode
Feb  5 00:11:57 rby-gw kernel: Software Watchdog Timer: 0.05, timer margin: 60 sec
Feb  5 00:11:57 rby-gw kernel: eth1: Setting full-duplex based on MII#1 link partner capability of 41e1.
Feb  5 00:11:57 rby-gw kernel: eth3: Setting full-duplex based on MII#1 link partner capability of 45e1.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
