Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbUAXWvi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 17:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUAXWvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 17:51:38 -0500
Received: from cust.7.144.adsl.cistron.nl ([62.216.7.144]:25729 "EHLO
	mail.vroon.org") by vger.kernel.org with ESMTP id S261464AbUAXWvY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 17:51:24 -0500
From: Tony Vroon <tony@vroon.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc1-mm2 (msp34xx badness in sched.c)
Date: Sat, 24 Jan 2004 23:47:37 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401242347.41497.tony@vroon.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

sleep_on called without kernel_lock, from what it looks like in msp34xx.

Full dmesg included, let me know if there's anything else you need.
Please CC me on any replies, not subscribed to LKML.

Tony.

Linux version 2.6.2-rc1-mm2 (root@prometheus) (gcc version 3.3.2 20031218 
(Gentoo Linux 3.3.2-r5, propolice-3.3-7)) #1 SMP Sat Jan 24 22:57:20 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
 BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f7ea0
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
On node 0 totalpages: 131052
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126956 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f85f0
ACPI: RSDT (v001 ASUS   A7M266-D 0x30303031 MSFT 0x31313031) @ 0x1ffec000
ACPI: FADT (v001 ASUS   A7M266-D 0x30303031 MSFT 0x31313031) @ 0x1ffec100
ACPI: BOOT (v001 ASUS   A7M266-D 0x30303031 MSFT 0x31313031) @ 0x1ffec040
ACPI: MADT (v001 ASUS   A7M266-D 0x30303031 MSFT 0x31313031) @ 0x1ffec080
ACPI: DSDT (v001   ASUS A7M266-D 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:6 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:6 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI BALANCE SET
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
current: c046aba0
current->thread_info: c0508000
Initializing CPU#0
Kernel command line: auto BOOT_IMAGE=linux ro root=803 aic7xxx=no_reset 
elevator=cfq
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1546.527 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 513616k/524208k available (3015k kernel code, 9844k reserved, 1106k 
data, 192k init, 0k highmem)
Calibrating delay loop... 3039.23 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: AMD Athlon(TM) MP 1800+ stepping 02
per-CPU timeslice cutoff: 731.54 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3088.38 BogoMIPS
CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Athlon(TM) MP 1800+ stepping 02
Total of 2 processors activated (6127.61 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not 
connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1545.0750 MHz.
..... host bus clock speed is 268.0826 MHz.
checking TSC synchronization across 2 CPUs: passed.
zapping low mappings.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1f30, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20031203
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:1)
    ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.UAR2._STA] 
(Node dff32d20), AE_NOT_EXIST
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 *14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
00:00:07[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
00:00:07[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18 Mode:1 Active:1)
00:00:07[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
00:00:07[D] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xc9 -> IRQ 20 Mode:1 Active:1)
00:00:08[A] -> 2-20 -> IRQ 20
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd1 -> IRQ 21 Mode:1 Active:1)
00:00:08[B] -> 2-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd9 -> IRQ 22 Mode:1 Active:1)
00:00:08[C] -> 2-22 -> IRQ 22
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xe1 -> IRQ 23 Mode:1 Active:1)
00:00:08[D] -> 2-23 -> IRQ 23
Pin 2-21 already programmed
Pin 2-22 already programmed
Pin 2-23 already programmed
Pin 2-20 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
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
 10 003 03  1    1    0   1   0    1    1    A9
 11 003 03  1    1    0   1   0    1    1    B1
 12 003 03  1    1    0   1   0    1    1    B9
 13 003 03  1    1    0   1   0    1    1    C1
 14 003 03  1    1    0   1   0    1    1    C9
 15 003 03  1    1    0   1   0    1    1    D1
 16 003 03  1    1    0   1   0    1    1    D9
 17 003 03  1    1    0   1   0    1    1    E1
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9-> 0:9
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
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
Starting balanced_irq
Total HugeTLB memory allocated, 0
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (FF) [SLPF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
hw_random: AMD768 system management I/O registers at 0xE400.
hw_random hardware driver 1.0.0 loaded
amd7xx_tco: build 20021116
loop: loaded (max 8 devices)
e100: Intel(R) PRO/100 Network Driver, 3.0.13_dev
e100: Copyright(c) 1999-2004 Intel Corporation
PCI: Enabling device 0000:02:08.0 (0014 -> 0017)
e100: eth0: e100_probe: addr 0xca000000, irq 19, MAC addr [removed]
netconsole: not configured, aborting
Linux video capture interface: v1.00
bttv: driver version 0.9.12 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 0000:02:05.0, irq: 18, latency: 32, mmio: 0xcf000000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: Hauppauge (bt878) [card=10,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffffdb [init]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
bttv0: Hauppauge eeprom: model=44354, tuner=Temic 4009FR5 (20), radio=yes
bttv0: using tuner=20
bttv0: i2c: checking for MSP34xx @ 0x80... found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL: 28636363 => 35468950 .. ok
msp34xx: init: chip=MSP3415D-B3 +nicam +simple
msp3410: daemon started
Badness in interruptible_sleep_on at kernel/sched.c:2230
Call Trace:
 [<c011ed24>] interruptible_sleep_on+0xf4/0x100
 [<c011e950>] default_wake_function+0x0/0x20
 [<c02b9a27>] msp3410d_thread+0xa7/0x680
 [<c02b9980>] <6>tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: 
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 
(PV951),ta8874z
msp3410d_thread+0x0/0x680
 [<c0108e69>] kernel_thread_helper+0x5/0xc

ir-kbd-i2c: i2c IR (Hauppauge) detected at i2c-0/0-0018/ir0
SAA5249 driver (SAA5249 interface) for VideoText version 1.7
tuner: chip found @ 0xc2
tuner: type set to 20 (Temic PAL_BG (4009 FR5) or PAL_I (4069 FR5))
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

Using cfq io scheduler
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
(scsi0:A:2:0): refuses WIDE negotiation.  Using 8bit transfers
(scsi0:A:2): 20.000MB/s transfers (20.000MHz, offset 16)
(scsi0:A:4:0): refuses WIDE negotiation.  Using 8bit transfers
(scsi0:A:4): 20.000MB/s transfers (20.000MHz, offset 7)
  Vendor: FUJITSU   Model: MAP3367NP         Rev: 0106
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
  Vendor: PIONEER   Model: DVD-ROM DVD-305   Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0N
  Type:   CD-ROM                             ANSI SCSI revision: 02
SCSI device sda: 71775284 512-byte hdwr sectors (36749 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0
cdrom: sr1: unknown mrw mode page
sr1: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 4, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 2, lun 0,  type 5
Attached scsi generic sg2 at scsi0, channel 0, id 4, lun 0,  type 5
PCI: Enabling device 0000:02:06.2 (0014 -> 0016)
ehci_hcd 0000:02:06.2: EHCI Host Controller
ehci_hcd 0000:02:06.2: irq 19, pci mem e0829000
ehci_hcd 0000:02:06.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:02:06.2: USB 2.0 enabled, EHCI 0.95, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
PCI: Enabling device 0000:02:06.0 (0014 -> 0016)
ohci_hcd 0000:02:06.0: OHCI Host Controller
ohci_hcd 0000:02:06.0: irq 17, pci mem e082b000
ohci_hcd 0000:02:06.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
PCI: Enabling device 0000:02:06.1 (0014 -> 0016)
ohci_hcd 0000:02:06.1: OHCI Host Controller
ohci_hcd 0000:02:06.1: irq 18, pci mem e082d000
ohci_hcd 0000:02:06.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver audio
drivers/usb/class/audio.c: v1.0.0:USB Audio Class driver
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
pwc Philips PCA645/646 + PCVC675/680/690 + PCVC730/740/750 webcam module 
version 8.12 loaded.
pwc Also supports the Askey VC010, various Logitech QuickCams, Samsung MPC-C10 
and MPC-C30,
pwc the Creative WebCam 5, SOTEC Afina Eye and Visionite VCS-UC300 and 
VCS-UM100.
drivers/usb/core/usb.c: registered new driver Philips webcam
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
i2c /dev entries driver
Advanced Linux Sound Architecture Driver Version 1.0.1 (Tue Dec 30 10:04:14 
2003 UTC).
PCI: Enabling device 0000:02:04.0 (0084 -> 0085)
ALSA device list:
  #0: C-Media PCI CMI8738-MC6 (model 55) at 0xc800, irq 17
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device sda3, size 8192, journal first block 18, max 
trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (sda3) for (sda3)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 192k freed
Adding 979956k swap on /dev/sda2.  Priority:-1 extents:1
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAEvYNp5vW4rUFj5oRAnu1AKCQ1NxekgtPIYIXimVvB4wPaUcpdwCfadYF
Jn2zn3XC6z0typUxr2iY0zI=
=hbgV
-----END PGP SIGNATURE-----
