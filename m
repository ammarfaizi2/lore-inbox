Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbTHULaz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 07:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbTHULay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 07:30:54 -0400
Received: from a226-128.dialup.iol.cz ([194.228.128.226]:8064 "EHLO
	vrapenec.gsf.de") by vger.kernel.org with ESMTP id S262613AbTHULap
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 07:30:45 -0400
Date: Thu, 21 Aug 2003 18:15:27 +0200 (MEST)
From: Martin Mokrejs <mmokrejs@natur.cuni.cz>
X-X-Sender: mokrejs@vrapenec.gsf.de
To: linux-kernel@vger.kernel.org
Subject: ACPI kernel crash with 2.4.22-pre7 on ASUS L3800C
Message-ID: <Pine.LNX.4.56.0308211738330.2294@vrapenec.gsf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I observe time to time on cold boot hang of my laptop. I remember to see 
such hangs at least since 2.4.21-pre3. Here's my latest running kernel:

# ksymoops --system-map=/boot/System.map-2.4.22-pre7 --vmlinux=/usr/src/linux-2.4.22-pre7/vmlinux ./cr
ksymoops 2.4.9 on i686 2.4.22-pre7.  Options used
     -v /usr/src/linux-2.4.22-pre7/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-pre7/ (default)
     -m /boot/System.map-2.4.22-pre7 (specified)

EFLAGS: 00010246
eax: 00000000 ebx: 638a05f0 ecx: 00000000 edx: 00000006
esi: 638a05f0 edi: f7ebddd0 ebp: f7ebdd78 esp: f7ebdd74
ds: 0018 es: 0018 ss: 0018
Process keventd: (pid 2, stackpage=f7ebd000)
Stack: f7ebdda4 f7ebdd90 c01ede68 638a05f0 f7ebdda4 f7ebddd0 638a05f0 f7ebddc0
       c01fc0f2 638a05f0 c01fc072 f7ebddd0 00010000 c0337755 c033770a 00000050
       f7ebddd4 f7ebddd4 638a05f0 f7ebddf0 c02037c2 638a05f0 f7ebddd0 00000000
Call Trace:     [<c01ede68>] [<c01fc0f2>] [<c01fc072>] [<c02037c2>] [<c01f8a2a>]
  [<c0203b8d>] [<c0203ee7>] [<c01fc4c7>] [<c01f8a00>] [<c0207aed>] [<c0207e5e>]
  [<c0208b60>] [<c01dce5a>] [<c01d4f7d>] [<c011ff0a>] [<c01282e5>] [<c01281b0>]
  [<c0105000>] [<c01057ee>] [<c01281b0>]
Code: 80 3b aa 0f 44 c3 5b 5d c3 a1 d4 55 40 c0 eb f6 55 89 e5 8b
Using defaults from ksymoops -t elf32-i386 -a i386


>>edi; f7ebddd0 <_end+37a9304c/3a4f02dc>
>>ebp; f7ebdd78 <_end+37a92ff4/3a4f02dc>
>>esp; f7ebdd74 <_end+37a92ff0/3a4f02dc>

Trace; c01ede68 <acpi_get_data+34/60>
Trace; c01fc0f2 <acpi_bus_get_device+45/a9>
Trace; c01fc072 <acpi_bus_data_handler+0/3b>
Trace; c02037c2 <acpi_power_get_context+46/a6>
Trace; c01f8a2a <acpi_ut_trace+29/2b>
Trace; c0203b8d <acpi_power_off_device+46/19d>
Trace; c0203ee7 <acpi_power_transition+111/138>
Trace; c01fc4c7 <acpi_bus_set_power+15f/273>
Trace; c01f8a00 <acpi_ut_debug_print_raw+29/2a>
Trace; c0207aed <acpi_thermal_active+bf/187>
Trace; c0207e5e <acpi_thermal_check+295/2e2>
Trace; c0208b60 <acpi_thermal_notify+a6/105>
Trace; c01dce5a <acpi_ev_notify_dispatch+54/7a>
Trace; c01d4f7d <acpi_os_execute_deferred+3a/6c>
Trace; c011ff0a <__run_task_queue+5a/70>
Trace; c01282e5 <context_thread+135/1d0>
Trace; c01281b0 <context_thread+0/1d0>
Trace; c0105000 <_stext+0/0>
Trace; c01057ee <arch_kernel_thread+2e/40>
Trace; c01281b0 <context_thread+0/1d0>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   80 3b aa                  cmpb   $0xaa,(%ebx)
Code;  00000003 Before first symbol
   3:   0f 44 c3                  cmove  %ebx,%eax
Code;  00000006 Before first symbol
   6:   5b                        pop    %ebx
Code;  00000007 Before first symbol
   7:   5d                        pop    %ebp
Code;  00000008 Before first symbol
   8:   c3                        ret    
Code;  00000009 Before first symbol
   9:   a1 d4 55 40 c0            mov    0xc04055d4,%eax
Code;  0000000e Before first symbol
   e:   eb f6                     jmp    6 <_EIP+0x6>
Code;  00000010 Before first symbol
  10:   55                        push   %ebp
Code;  00000011 Before first symbol
  11:   89 e5                     mov    %esp,%ebp
Code;  00000013 Before first symbol
  13:   8b 00                     mov    (%eax),%eax

# lspci -v
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
        Subsystem: Asustek Computer, Inc.: Unknown device 1626
        Flags: bus master, fast devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: [e4] #09 [d104]
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: d7000000-d7efffff
        Prefetchable memory behind bridge: d7f00000-dfffffff

00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 1628
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at b800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 1628
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at b400 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: d6000000-d6ffffff

00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 1628
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at 8400 [size=16]
        Memory at d5800000 (32-bit, non-prefetchable) [size=1K]

00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 1583
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at e000 [size=256]
        I/O ports at e100 [size=64]

00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 02) (prog-if 00 [Generic])
        Subsystem: Asustek Computer, Inc.: Unknown device 1496
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at e200 [size=256]
        I/O ports at e300 [size=128]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500] (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc.: Unknown device 1622
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 64, IRQ 5
        Memory at d8000000 (32-bit, prefetchable) [size=128M]
        I/O ports at d800 [size=256]
        Memory at d7000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at d7fe0000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2

02:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Asustek Computer, Inc.: Unknown device 1045
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at a800 [size=256]
        Memory at d6800000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

02:07.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
        Subsystem: Asustek Computer, Inc.: Unknown device 1624
        Flags: bus master, medium devsel, latency 32, IRQ 5
        Memory at 40000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=02, subordinate=03, sec-latency=64
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001

02:07.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
        Subsystem: Asustek Computer, Inc.: Unknown device 1624
        Flags: medium devsel, IRQ 11
        Memory at 40001000 (32-bit, non-prefetchable) [disabled] [size=4K]
        Bus: primary=02, secondary=04, subordinate=07, sec-latency=0
        I/O window 0: 00000000-00000003 [disabled]
        I/O window 1: 00000000-00000003 [disabled]
        16-bit legacy interface ports at 0001

02:07.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 1627
        Flags: bus master, medium devsel, latency 32, IRQ 9
        Memory at d6000000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [dc] Power Management version 2

# dmesg
Linux version 2.4.22-pre7 (root@vrapenec.gsf.de) (gcc version 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r1, propolice)) #1 Wed Jul 23 15:23
:54 MEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff9000 (usable)
 BIOS-e820: 000000003fff9000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 262137
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32761 pages.
ACPI: RSDP (v000 ASUS                       ) @ 0x000f6890
ACPI: RSDT (v001 ASUS   P4_L3CS  16944.11825) @ 0x3fff9000
ACPI: FADT (v001 ASUS   P4_L3CS  16944.11825) @ 0x3fff9080
ACPI: BOOT (v001 ASUS   P4_L3CS  16944.11825) @ 0x3fff9040
ACPI: DSDT (v001   ASUS P4_L3CS  00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Kernel command line: root=/dev/hda2 hdc=ide-scsi idebus=66
ide_setup: hdc=ide-scsi
ide_setup: idebus=66
No local APIC present or hardware disabled
Initializing CPU#0
Detected 1800.127 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3591.37 BogoMIPS
Memory: 1032544k/1048548k available (2085k kernel code, 15616k reserved, 752k data, 136k init, 131044k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebf9ff 00000000 00000000 00000000
CPU:             Common caps: bfebf9ff 00000000 00000000 00000000
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 1.80GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030619
PCI: PCI BIOS revision 2.10 entry at 0xf0e40, last bus=2
PCI: Using configuration type 1
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:............................................................................................................
........................................................................................................................................
..........
Table [DSDT](id F004) - 761 Objects with 59 Devices 254 Methods 26 Regions
ACPI Namespace successfully loaded at root c04055bc
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 000000000000E428 on int 9
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 16 to 31 [_GPE] 2 regs at 000000000000E42C on int 9
Completing Region/Field/Buffer/Package initialization:..................................................................................
Initialized 26/26 Regions 0/0 Fields 23/23 Buffers 33/33 Packages (769 nodes)
Executing all Device _STA and_INI methods:............................................................
60 Devices found containing: 60 _STA, 5 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs *5)
ACPI: PCI Interrupt Link [LNKB] (IRQs 7 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 11, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 11, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
ACPI: Embedded Controller [ECD0] (gpe 28)
schedule_task(): keventd has not started
ACPI: Power Resource [PRCF] (on)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LIDD]
ACPI: Fan [CFAN] (on)
ACPI: Processor [CPU0] (supports C1 C2, 2 performance states, 8 throttling states)
ACPI: Thermal Zone [THRM] (44 C)
Asus Laptop ACPI Extras version 0.24a
  L3C model detected, supported
  Notify Handler installed successfully
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
radeonfb: ref_clk=2700, ref_div=12, xclk=18300 from BIOS
radeonfb: panel ID string: Samsung LTN150P1-L02    
radeonfb: detected LCD panel size from BIOS: 1400x1050
Console: switching to colour frame buffer device 175x65
radeonfb: ATI Radeon M7 LW DDR SGRAM 32 MB
radeonfb: DVI port LCD monitor connected
radeonfb: CRT port no monitor connected
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ DETECT_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
lp0: console ready
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xfa81f000, 00:e0:18:b6:9d:31, IRQ 9
eth0:  Identified 8139 chip type 'RTL-8139B'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: Detected Intel i845 chipset
agpgart: AGP aperture is 256M @ 0xe0000000
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 66MHz system bus speed for PIO modes
ICH3M: IDE controller at PCI slot 00:1f.1
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8400-0x8407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x8408-0x840f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23EA-60, ATA DISK drive
blk: queue c04203e0, I/O limit 4095Mb (mask 0xffffffff)
hdc: TOSHIBA DVD-ROM SD-R2212, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 117210240 sectors (60012 MB) w/2048KiB Cache, CHS=7296/255/63, UDMA(100)
hdc: attached ide-scsi driver.
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TOSHIBA   Model: DVD-ROM SD-R2212  Rev: 1713
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
host/usb-uhci.c: $Revision: 1.275 $ time 15:26:41 Jul 23 2003
host/usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
host/usb-uhci.c: USB UHCI at I/O 0xb800, IRQ 5
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF f7d50940, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: b800
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
<cut>
sr0: Hmm, seems the drive doesn't support multisession CD's
attempt to access beyond end of device
0b:00: rw=0, want=34, limit=2
isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16

The above sr0 message is possibly related to the fact that the cdrom drive contains
empty CD-R media, so the drive cannot find anything on the disc.

However, I report here the ACPI bug. When it happened that I saw by luck the bootup
messages from the beginning and the crash happened, I always saw that the
CPU Fan state was not recognized. ACPI printed some messages, but I newer had
a chance to read them. Two screen pages later the computer locks.
Needless to say, the CPU Fan was always set to it's maximum RPM and was cooling
like crazy. Does that help?

Please Cc: me in replies.
Martin Mokrejs
mmokrejs@natur.cuni.cz
m.mokrejs@gsf.de

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Mobile Intel(R) Pentium(R) 4 - M CPU 1.80GHz
stepping        : 7
cpu MHz         : 1800.127
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3591.37

# cat /proc/acpi/info 
version:                 20030619
states:                  S0 S1 S3 S4 S5 
#
