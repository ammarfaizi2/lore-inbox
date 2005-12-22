Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVLVKfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVLVKfr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 05:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbVLVKfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 05:35:47 -0500
Received: from math.ut.ee ([193.40.36.2]:47264 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1750731AbVLVKfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 05:35:46 -0500
Date: Thu, 22 Dec 2005 12:35:30 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Serial: bug in 8250.c when handling PCI or other level triggers
In-Reply-To: <20051221221516.GK1736@flint.arm.linux.org.uk>
Message-ID: <Pine.SOC.4.61.0512221231430.6200@math.ut.ee>
References: <1134573803.25663.35.camel@localhost.localdomain>
 <20051214160700.7348A14BEA@rhn.tartu-labor> <20051214172445.GF7124@flint.arm.linux.org.uk>
 <Pine.SOC.4.61.0512212221310.651@math.ut.ee> <20051221221516.GK1736@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unless the compiler is messing up the initialiser for:
>
>        struct list_head *l, *end = NULL;
>
> Could you try placing a:
>
> 	BUG_ON(end != NULL);
>
> between:
>
>        spin_lock(&i->lock);
>
> and:
>
>        l = i->head;
>
> in serial8250_interrupt please?
>
> If that doesn't trigger, then I'm all out of ideas.

It did not trigger.

But I might have some more information:

The first bunch of messages did not happen on serial port detection but 
when "discover" ran and opened the serial port.

The second bunch of messages happened when minicom opened the port. I 
then modprobed tulip to see separating lines in dmesg. Then I used cisco 
remote console and no messages appeared. Then I powered down the cisco 
and then quited minicom. This took time and produced another bunch of 
messages.

Linux version 2.6.15-rc6-gd5ea4e26 (mroos@rhn) (gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #114 PREEMPT Thu Dec 22 12:07:53 EET 2005
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001ffc0000 (usable)
  BIOS-e820: 000000001ffc0000 - 000000001fff8000 (ACPI data)
  BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
  BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131008
   DMA zone: 4096 pages, LIFO batch:0
   DMA32 zone: 0 pages, LIFO batch:0
   Normal zone: 126912 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000ff980
ACPI: RSDT (v001 D815EA D815EEA2 0x20021106 MSFT 0x00001011) @ 0x1fff0000
ACPI: FADT (v001 D815EA EA81510A 0x20021106 MSFT 0x00001011) @ 0x1fff1000
ACPI: DSDT (v001 D815E2 EA81520A 0x00000023 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
Allocating PCI resources starting at 30000000 (gap: 20000000:dfb80000)
Built 1 zonelists
Kernel command line: root=/dev/hda3 ro nmi_watchdog=1 lapic
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Initializing CPU#0
CPU 0 irqstacks, hard=c0414000 soft=c0413000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 897.201 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515136k/524032k available (2049k kernel code, 8424k reserved, 918k data, 152k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1796.06 BogoMIPS (lpj=3592124)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: Intel Celeron (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0e00)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0500-053f claimed by ICH4 GPIO
Boot video device is 0000:02:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
PCI: Bridge: 0000:00:01.0
   IO window: d000-dfff
   MEM window: ff900000-ff9fffff
   PREFETCH window: eea00000-f6afffff
PCI: Bridge: 0000:00:1e.0
   IO window: c000-cfff
   MEM window: ff800000-ff8fffff
   PREFETCH window: ee900000-ee9fffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PBTN]
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel i815 Chipset.
agpgart: AGP aperture is 64M @ 0xf8000000
[drm] Initialized drm 1.0.0 20040925
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
parport0: faking semi-colon
parport0: Printer, Hewlett-Packard HP LaserJet 1100
lp0: using parport0 (interrupt-driven).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [LNKE] -> GSI 11 (level, low) -> IRQ 11
e100: eth0: e100_probe: addr 0xff8ff000, irq 11, MAC addr 00:03:47:A4:64:D5
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 2
ICH2: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: ST380011A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: CDU5211, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
  hda: hda1 hda2 hda3 hda4
hdc: ATAPI 52X CD-ROM drive, 120kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input1
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 5, 131072 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Testing NMI watchdog ... OK.
Using IPI Shortcut mode
ACPI wakeup devices: 
PBTN PCI1 UAR1  USB USB2  AC9  SMB 
ACPI: (supports S0 S1 S4 S5)
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 152k freed
kjournald starting.  Commit interval 5 seconds
logips2pp: Detected unknown logitech mouse model 99
input: ImExPS/2 Logitech Explorer Mouse as /class/input/input2
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1f.2[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: UHCI Host Controller
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1f.2: irq 11, io base 0x0000ef40
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.4[C] -> Link [LNKH] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci_hcd 0000:00:1f.4: UHCI Host Controller
uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1f.4: irq 10, io base 0x0000ef80
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 55253 usecs
intel8x0: clocking to 41145
Adding 1004052k swap on /dev/hda2.  Priority:-1 extents:1 across:1004052k
EXT3 FS on hda3, internal journal
NTFS driver 2.1.25 [Flags: R/W MODULE].
SCSI subsystem initialized
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
smsc47m1: Found SMSC LPC47M10x/LPC47M13x
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
lp0: ECP mode
serial8250: too much work for irq4
serial8250: port c0452c80(0)
0: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
1: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
2: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
3: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
4: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
5: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
6: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
7: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
8: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
9: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
10: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
11: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
12: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
13: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
14: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
15: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
16: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
17: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
18: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
19: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
20: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
21: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
22: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
23: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
24: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
25: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
26: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
27: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
28: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
29: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
30: jif=fffef7bc type=00 num=00 iir=01 lsr=00 => iir=01 lsr=00
31: jif=fffef7bc type=00 num=01 iir=01 lsr=60 => iir=01 lsr=60
32: jif=fffef7bc type=00 num=02 iir=01 lsr=60 => iir=01 lsr=60
33: jif=fffef7bc type=00 num=03 iir=01 lsr=60 => iir=01 lsr=60
34: jif=fffef7bc type=00 num=04 iir=01 lsr=60 => iir=01 lsr=60
35: jif=fffef7bc type=00 num=05 iir=01 lsr=60 => iir=01 lsr=60
36: jif=fffef7bc type=00 num=06 iir=01 lsr=60 => iir=01 lsr=60
37: jif=fffef7bc type=00 num=07 iir=01 lsr=60 => iir=01 lsr=60
38: jif=fffef7bc type=00 num=08 iir=01 lsr=60 => iir=01 lsr=60
39: jif=fffef7bc type=00 num=09 iir=01 lsr=60 => iir=01 lsr=60
40: jif=fffef7bc type=00 num=0a iir=01 lsr=60 => iir=01 lsr=60
41: jif=fffef7bc type=00 num=0b iir=01 lsr=60 => iir=01 lsr=60
42: jif=fffef7bc type=00 num=0c iir=01 lsr=60 => iir=01 lsr=60
43: jif=fffef7bc type=00 num=0d iir=01 lsr=60 => iir=01 lsr=60
44: jif=fffef7bc type=00 num=0e iir=01 lsr=60 => iir=01 lsr=60
45: jif=fffef7bc type=00 num=0f iir=01 lsr=60 => iir=01 lsr=60
46: jif=fffef7bc type=00 num=10 iir=01 lsr=60 => iir=01 lsr=60
47: jif=fffef7bc type=00 num=11 iir=01 lsr=60 => iir=01 lsr=60
48: jif=fffef7bc type=00 num=12 iir=01 lsr=60 => iir=01 lsr=60
49: jif=fffef7bc type=00 num=13 iir=01 lsr=60 => iir=01 lsr=60
50: jif=fffef7bc type=00 num=14 iir=01 lsr=60 => iir=01 lsr=60
51: jif=fffef7bc type=00 num=15 iir=01 lsr=60 => iir=01 lsr=60
52: jif=fffef7bc type=00 num=16 iir=01 lsr=60 => iir=01 lsr=60
53: jif=fffef7bc type=00 num=17 iir=01 lsr=60 => iir=01 lsr=60
54: jif=fffef7bc type=00 num=18 iir=01 lsr=60 => iir=01 lsr=60
55: jif=fffef7bc type=00 num=19 iir=01 lsr=60 => iir=01 lsr=60
56: jif=fffef7bc type=00 num=1a iir=01 lsr=60 => iir=01 lsr=60
57: jif=fffef7bc type=00 num=1b iir=01 lsr=60 => iir=01 lsr=60
58: jif=fffef7bc type=00 num=1c iir=01 lsr=60 => iir=01 lsr=60
59: jif=fffef7bc type=00 num=1d iir=01 lsr=60 => iir=01 lsr=60
60: jif=fffef7bc type=00 num=1e iir=01 lsr=60 => iir=01 lsr=60
61: jif=fffef7bc type=00 num=1f iir=01 lsr=60 => iir=01 lsr=60
62: jif=fffef7bc type=00 num=20 iir=01 lsr=60 => iir=01 lsr=60
63: jif=fffef7bc type=00 num=21 iir=01 lsr=60 => iir=01 lsr=60
serial8250: too much work for irq4
serial8250: port c0452c80(0)
0: jif=fffef7bc type=00 num=06 iir=01 lsr=60 => iir=01 lsr=60
1: jif=fffef7bc type=00 num=07 iir=01 lsr=60 => iir=01 lsr=60
2: jif=fffef7bc type=00 num=08 iir=01 lsr=60 => iir=01 lsr=60
3: jif=fffef7bc type=00 num=09 iir=01 lsr=60 => iir=01 lsr=60
4: jif=fffef7bc type=00 num=0a iir=01 lsr=60 => iir=01 lsr=60
5: jif=fffef7bc type=00 num=0b iir=01 lsr=60 => iir=01 lsr=60
6: jif=fffef7bc type=00 num=0c iir=01 lsr=60 => iir=01 lsr=60
7: jif=fffef7bc type=00 num=0d iir=01 lsr=60 => iir=01 lsr=60
8: jif=fffef7bc type=00 num=0e iir=01 lsr=60 => iir=01 lsr=60
9: jif=fffef7bc type=00 num=0f iir=01 lsr=60 => iir=01 lsr=60
10: jif=fffef7bc type=00 num=10 iir=01 lsr=60 => iir=01 lsr=60
11: jif=fffef7bc type=00 num=11 iir=01 lsr=60 => iir=01 lsr=60
12: jif=fffef7bc type=00 num=12 iir=01 lsr=60 => iir=01 lsr=60
13: jif=fffef7bc type=00 num=13 iir=01 lsr=60 => iir=01 lsr=60
14: jif=fffef7bc type=00 num=14 iir=01 lsr=60 => iir=01 lsr=60
15: jif=fffef7bc type=00 num=15 iir=01 lsr=60 => iir=01 lsr=60
16: jif=fffef7bc type=00 num=16 iir=01 lsr=60 => iir=01 lsr=60
17: jif=fffef7bc type=00 num=17 iir=01 lsr=60 => iir=01 lsr=60
18: jif=fffef7bc type=00 num=18 iir=01 lsr=60 => iir=01 lsr=60
19: jif=fffef7bc type=00 num=19 iir=01 lsr=60 => iir=01 lsr=60
20: jif=fffef7bc type=00 num=1a iir=01 lsr=60 => iir=01 lsr=60
21: jif=fffef7bc type=00 num=1b iir=01 lsr=60 => iir=01 lsr=60
22: jif=fffef7bc type=00 num=1c iir=01 lsr=60 => iir=01 lsr=60
23: jif=fffef7bc type=00 num=1d iir=01 lsr=60 => iir=01 lsr=60
24: jif=fffef7bc type=00 num=1e iir=01 lsr=60 => iir=01 lsr=60
25: jif=fffef7bc type=00 num=1f iir=01 lsr=60 => iir=01 lsr=60
26: jif=fffef7bc type=00 num=20 iir=01 lsr=60 => iir=01 lsr=60
27: jif=fffef7bc type=00 num=21 iir=01 lsr=60 => iir=01 lsr=60
28: jif=fffef823 type=00 num=00 iir=c2 lsr=60 => iir=c1 lsr=60
29: jif=fffef823 type=00 num=01 iir=c1 lsr=00 => iir=c1 lsr=00
30: jif=fffef862 type=00 num=00 iir=c1 lsr=00 => iir=c1 lsr=00
31: jif=fffef862 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
32: jif=fffef862 type=00 num=02 iir=c1 lsr=60 => iir=c1 lsr=60
33: jif=fffef862 type=00 num=03 iir=c1 lsr=60 => iir=c1 lsr=60
34: jif=fffef862 type=00 num=04 iir=c1 lsr=60 => iir=c1 lsr=60
35: jif=fffef862 type=00 num=05 iir=c1 lsr=60 => iir=c1 lsr=60
36: jif=fffef862 type=00 num=06 iir=c1 lsr=60 => iir=c1 lsr=60
37: jif=fffef862 type=00 num=07 iir=c1 lsr=60 => iir=c1 lsr=60
38: jif=fffef862 type=00 num=08 iir=c1 lsr=60 => iir=c1 lsr=60
39: jif=fffef862 type=00 num=09 iir=c1 lsr=60 => iir=c1 lsr=60
40: jif=fffef862 type=00 num=0a iir=c1 lsr=60 => iir=c1 lsr=60
41: jif=fffef862 type=00 num=0b iir=c1 lsr=60 => iir=c1 lsr=60
42: jif=fffef862 type=00 num=0c iir=c1 lsr=60 => iir=c1 lsr=60
43: jif=fffef862 type=00 num=0d iir=c1 lsr=60 => iir=c1 lsr=60
44: jif=fffef862 type=00 num=0e iir=c1 lsr=60 => iir=c1 lsr=60
45: jif=fffef862 type=00 num=0f iir=c1 lsr=60 => iir=c1 lsr=60
46: jif=fffef862 type=00 num=10 iir=c1 lsr=60 => iir=c1 lsr=60
47: jif=fffef862 type=00 num=11 iir=c1 lsr=60 => iir=c1 lsr=60
48: jif=fffef862 type=00 num=12 iir=c1 lsr=60 => iir=c1 lsr=60
49: jif=fffef862 type=00 num=13 iir=c1 lsr=60 => iir=c1 lsr=60
50: jif=fffef862 type=00 num=14 iir=c1 lsr=60 => iir=c1 lsr=60
51: jif=fffef862 type=00 num=15 iir=c1 lsr=60 => iir=c1 lsr=60
52: jif=fffef862 type=00 num=16 iir=c1 lsr=60 => iir=c1 lsr=60
53: jif=fffef862 type=00 num=17 iir=c1 lsr=60 => iir=c1 lsr=60
54: jif=fffef862 type=00 num=18 iir=c1 lsr=60 => iir=c1 lsr=60
55: jif=fffef862 type=00 num=19 iir=c1 lsr=60 => iir=c1 lsr=60
56: jif=fffef862 type=00 num=1a iir=c1 lsr=60 => iir=c1 lsr=60
57: jif=fffef862 type=00 num=1b iir=c1 lsr=60 => iir=c1 lsr=60
58: jif=fffef862 type=00 num=1c iir=c1 lsr=60 => iir=c1 lsr=60
59: jif=fffef862 type=00 num=1d iir=c1 lsr=60 => iir=c1 lsr=60
60: jif=fffef862 type=00 num=1e iir=c1 lsr=60 => iir=c1 lsr=60
61: jif=fffef862 type=00 num=1f iir=c1 lsr=60 => iir=c1 lsr=60
62: jif=fffef862 type=00 num=20 iir=c1 lsr=60 => iir=c1 lsr=60
63: jif=fffef862 type=00 num=21 iir=c1 lsr=60 => iir=c1 lsr=60
serial8250: too much work for irq4
serial8250: port c0452c80(0)
0: jif=fffef862 type=00 num=04 iir=c1 lsr=60 => iir=c1 lsr=60
1: jif=fffef862 type=00 num=05 iir=c1 lsr=60 => iir=c1 lsr=60
2: jif=fffef862 type=00 num=06 iir=c1 lsr=60 => iir=c1 lsr=60
3: jif=fffef862 type=00 num=07 iir=c1 lsr=60 => iir=c1 lsr=60
4: jif=fffef862 type=00 num=08 iir=c1 lsr=60 => iir=c1 lsr=60
5: jif=fffef862 type=00 num=09 iir=c1 lsr=60 => iir=c1 lsr=60
6: jif=fffef862 type=00 num=0a iir=c1 lsr=60 => iir=c1 lsr=60
7: jif=fffef862 type=00 num=0b iir=c1 lsr=60 => iir=c1 lsr=60
8: jif=fffef862 type=00 num=0c iir=c1 lsr=60 => iir=c1 lsr=60
9: jif=fffef862 type=00 num=0d iir=c1 lsr=60 => iir=c1 lsr=60
10: jif=fffef862 type=00 num=0e iir=c1 lsr=60 => iir=c1 lsr=60
11: jif=fffef862 type=00 num=0f iir=c1 lsr=60 => iir=c1 lsr=60
12: jif=fffef862 type=00 num=10 iir=c1 lsr=60 => iir=c1 lsr=60
13: jif=fffef862 type=00 num=11 iir=c1 lsr=60 => iir=c1 lsr=60
14: jif=fffef862 type=00 num=12 iir=c1 lsr=60 => iir=c1 lsr=60
15: jif=fffef862 type=00 num=13 iir=c1 lsr=60 => iir=c1 lsr=60
16: jif=fffef862 type=00 num=14 iir=c1 lsr=60 => iir=c1 lsr=60
17: jif=fffef862 type=00 num=15 iir=c1 lsr=60 => iir=c1 lsr=60
18: jif=fffef862 type=00 num=16 iir=c1 lsr=60 => iir=c1 lsr=60
19: jif=fffef862 type=00 num=17 iir=c1 lsr=60 => iir=c1 lsr=60
20: jif=fffef862 type=00 num=18 iir=c1 lsr=60 => iir=c1 lsr=60
21: jif=fffef862 type=00 num=19 iir=c1 lsr=60 => iir=c1 lsr=60
22: jif=fffef862 type=00 num=1a iir=c1 lsr=60 => iir=c1 lsr=60
23: jif=fffef862 type=00 num=1b iir=c1 lsr=60 => iir=c1 lsr=60
24: jif=fffef862 type=00 num=1c iir=c1 lsr=60 => iir=c1 lsr=60
25: jif=fffef862 type=00 num=1d iir=c1 lsr=60 => iir=c1 lsr=60
26: jif=fffef862 type=00 num=1e iir=c1 lsr=60 => iir=c1 lsr=60
27: jif=fffef862 type=00 num=1f iir=c1 lsr=60 => iir=c1 lsr=60
28: jif=fffef862 type=00 num=20 iir=c1 lsr=60 => iir=c1 lsr=60
29: jif=fffef862 type=00 num=21 iir=c1 lsr=60 => iir=c1 lsr=60
30: jif=fffef863 type=00 num=00 iir=c1 lsr=60 => iir=c1 lsr=60
31: jif=fffef863 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
32: jif=fffef863 type=00 num=02 iir=c1 lsr=60 => iir=c1 lsr=60
33: jif=fffef863 type=00 num=03 iir=c1 lsr=60 => iir=c1 lsr=60
34: jif=fffef863 type=00 num=04 iir=c1 lsr=60 => iir=c1 lsr=60
35: jif=fffef863 type=00 num=05 iir=c1 lsr=60 => iir=c1 lsr=60
36: jif=fffef863 type=00 num=06 iir=c1 lsr=60 => iir=c1 lsr=60
37: jif=fffef863 type=00 num=07 iir=c1 lsr=60 => iir=c1 lsr=60
38: jif=fffef863 type=00 num=08 iir=c1 lsr=60 => iir=c1 lsr=60
39: jif=fffef863 type=00 num=09 iir=c1 lsr=60 => iir=c1 lsr=60
40: jif=fffef863 type=00 num=0a iir=c1 lsr=60 => iir=c1 lsr=60
41: jif=fffef863 type=00 num=0b iir=c1 lsr=60 => iir=c1 lsr=60
42: jif=fffef863 type=00 num=0c iir=c1 lsr=60 => iir=c1 lsr=60
43: jif=fffef863 type=00 num=0d iir=c1 lsr=60 => iir=c1 lsr=60
44: jif=fffef863 type=00 num=0e iir=c1 lsr=60 => iir=c1 lsr=60
45: jif=fffef863 type=00 num=0f iir=c1 lsr=60 => iir=c1 lsr=60
46: jif=fffef863 type=00 num=10 iir=c1 lsr=60 => iir=c1 lsr=60
47: jif=fffef863 type=00 num=11 iir=c1 lsr=60 => iir=c1 lsr=60
48: jif=fffef863 type=00 num=12 iir=c1 lsr=60 => iir=c1 lsr=60
49: jif=fffef863 type=00 num=13 iir=c1 lsr=60 => iir=c1 lsr=60
50: jif=fffef863 type=00 num=14 iir=c1 lsr=60 => iir=c1 lsr=60
51: jif=fffef863 type=00 num=15 iir=c1 lsr=60 => iir=c1 lsr=60
52: jif=fffef863 type=00 num=16 iir=c1 lsr=60 => iir=c1 lsr=60
53: jif=fffef863 type=00 num=17 iir=c1 lsr=60 => iir=c1 lsr=60
54: jif=fffef863 type=00 num=18 iir=c1 lsr=60 => iir=c1 lsr=60
55: jif=fffef863 type=00 num=19 iir=c1 lsr=60 => iir=c1 lsr=60
56: jif=fffef863 type=00 num=1a iir=c1 lsr=60 => iir=c1 lsr=60
57: jif=fffef863 type=00 num=1b iir=c1 lsr=60 => iir=c1 lsr=60
58: jif=fffef863 type=00 num=1c iir=c1 lsr=60 => iir=c1 lsr=60
59: jif=fffef863 type=00 num=1d iir=c1 lsr=60 => iir=c1 lsr=60
60: jif=fffef863 type=00 num=1e iir=c1 lsr=60 => iir=c1 lsr=60
61: jif=fffef863 type=00 num=1f iir=c1 lsr=60 => iir=c1 lsr=60
62: jif=fffef863 type=00 num=20 iir=c1 lsr=60 => iir=c1 lsr=60
63: jif=fffef863 type=00 num=21 iir=c1 lsr=60 => iir=c1 lsr=60
serial8250: too much work for irq3
serial8250: port c0453034(1)
0: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
1: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
2: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
3: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
4: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
5: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
6: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
7: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
8: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
9: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
10: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
11: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
12: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
13: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
14: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
15: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
16: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
17: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
18: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
19: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
20: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
21: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
22: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
23: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
24: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
25: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
26: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
27: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
28: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
29: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
30: jif=fffef864 type=00 num=00 iir=01 lsr=00 => iir=01 lsr=00
31: jif=fffef864 type=00 num=01 iir=01 lsr=60 => iir=01 lsr=60
32: jif=fffef864 type=00 num=02 iir=01 lsr=60 => iir=01 lsr=60
33: jif=fffef864 type=00 num=03 iir=01 lsr=60 => iir=01 lsr=60
34: jif=fffef864 type=00 num=04 iir=01 lsr=60 => iir=01 lsr=60
35: jif=fffef864 type=00 num=05 iir=01 lsr=60 => iir=01 lsr=60
36: jif=fffef864 type=00 num=06 iir=01 lsr=60 => iir=01 lsr=60
37: jif=fffef864 type=00 num=07 iir=01 lsr=60 => iir=01 lsr=60
38: jif=fffef864 type=00 num=08 iir=01 lsr=60 => iir=01 lsr=60
39: jif=fffef864 type=00 num=09 iir=01 lsr=60 => iir=01 lsr=60
40: jif=fffef864 type=00 num=0a iir=01 lsr=60 => iir=01 lsr=60
41: jif=fffef864 type=00 num=0b iir=01 lsr=60 => iir=01 lsr=60
42: jif=fffef864 type=00 num=0c iir=01 lsr=60 => iir=01 lsr=60
43: jif=fffef864 type=00 num=0d iir=01 lsr=60 => iir=01 lsr=60
44: jif=fffef864 type=00 num=0e iir=01 lsr=60 => iir=01 lsr=60
45: jif=fffef864 type=00 num=0f iir=01 lsr=60 => iir=01 lsr=60
46: jif=fffef864 type=00 num=10 iir=01 lsr=60 => iir=01 lsr=60
47: jif=fffef864 type=00 num=11 iir=01 lsr=60 => iir=01 lsr=60
48: jif=fffef864 type=00 num=12 iir=01 lsr=60 => iir=01 lsr=60
49: jif=fffef864 type=00 num=13 iir=01 lsr=60 => iir=01 lsr=60
50: jif=fffef864 type=00 num=14 iir=01 lsr=60 => iir=01 lsr=60
51: jif=fffef864 type=00 num=15 iir=01 lsr=60 => iir=01 lsr=60
52: jif=fffef864 type=00 num=16 iir=01 lsr=60 => iir=01 lsr=60
53: jif=fffef864 type=00 num=17 iir=01 lsr=60 => iir=01 lsr=60
54: jif=fffef864 type=00 num=18 iir=01 lsr=60 => iir=01 lsr=60
55: jif=fffef864 type=00 num=19 iir=01 lsr=60 => iir=01 lsr=60
56: jif=fffef864 type=00 num=1a iir=01 lsr=60 => iir=01 lsr=60
57: jif=fffef864 type=00 num=1b iir=01 lsr=60 => iir=01 lsr=60
58: jif=fffef864 type=00 num=1c iir=01 lsr=60 => iir=01 lsr=60
59: jif=fffef864 type=00 num=1d iir=01 lsr=60 => iir=01 lsr=60
60: jif=fffef864 type=00 num=1e iir=01 lsr=60 => iir=01 lsr=60
61: jif=fffef864 type=00 num=1f iir=01 lsr=60 => iir=01 lsr=60
62: jif=fffef864 type=00 num=20 iir=01 lsr=60 => iir=01 lsr=60
63: jif=fffef864 type=00 num=21 iir=01 lsr=60 => iir=01 lsr=60
serial8250: too much work for irq3
serial8250: port c0453034(1)
0: jif=fffef864 type=00 num=04 iir=01 lsr=60 => iir=01 lsr=60
1: jif=fffef864 type=00 num=05 iir=01 lsr=60 => iir=01 lsr=60
2: jif=fffef864 type=00 num=06 iir=01 lsr=60 => iir=01 lsr=60
3: jif=fffef864 type=00 num=07 iir=01 lsr=60 => iir=01 lsr=60
4: jif=fffef864 type=00 num=08 iir=01 lsr=60 => iir=01 lsr=60
5: jif=fffef864 type=00 num=09 iir=01 lsr=60 => iir=01 lsr=60
6: jif=fffef864 type=00 num=0a iir=01 lsr=60 => iir=01 lsr=60
7: jif=fffef864 type=00 num=0b iir=01 lsr=60 => iir=01 lsr=60
8: jif=fffef864 type=00 num=0c iir=01 lsr=60 => iir=01 lsr=60
9: jif=fffef864 type=00 num=0d iir=01 lsr=60 => iir=01 lsr=60
10: jif=fffef864 type=00 num=0e iir=01 lsr=60 => iir=01 lsr=60
11: jif=fffef864 type=00 num=0f iir=01 lsr=60 => iir=01 lsr=60
12: jif=fffef864 type=00 num=10 iir=01 lsr=60 => iir=01 lsr=60
13: jif=fffef864 type=00 num=11 iir=01 lsr=60 => iir=01 lsr=60
14: jif=fffef864 type=00 num=12 iir=01 lsr=60 => iir=01 lsr=60
15: jif=fffef864 type=00 num=13 iir=01 lsr=60 => iir=01 lsr=60
16: jif=fffef864 type=00 num=14 iir=01 lsr=60 => iir=01 lsr=60
17: jif=fffef864 type=00 num=15 iir=01 lsr=60 => iir=01 lsr=60
18: jif=fffef864 type=00 num=16 iir=01 lsr=60 => iir=01 lsr=60
19: jif=fffef864 type=00 num=17 iir=01 lsr=60 => iir=01 lsr=60
20: jif=fffef864 type=00 num=18 iir=01 lsr=60 => iir=01 lsr=60
21: jif=fffef864 type=00 num=19 iir=01 lsr=60 => iir=01 lsr=60
22: jif=fffef864 type=00 num=1a iir=01 lsr=60 => iir=01 lsr=60
23: jif=fffef864 type=00 num=1b iir=01 lsr=60 => iir=01 lsr=60
24: jif=fffef864 type=00 num=1c iir=01 lsr=60 => iir=01 lsr=60
25: jif=fffef864 type=00 num=1d iir=01 lsr=60 => iir=01 lsr=60
26: jif=fffef864 type=00 num=1e iir=01 lsr=60 => iir=01 lsr=60
27: jif=fffef864 type=00 num=1f iir=01 lsr=60 => iir=01 lsr=60
28: jif=fffef864 type=00 num=20 iir=01 lsr=60 => iir=01 lsr=60
29: jif=fffef864 type=00 num=21 iir=01 lsr=60 => iir=01 lsr=60
30: jif=fffef865 type=00 num=00 iir=01 lsr=00 => iir=01 lsr=00
31: jif=fffef865 type=00 num=01 iir=01 lsr=60 => iir=01 lsr=60
32: jif=fffef865 type=00 num=02 iir=01 lsr=60 => iir=01 lsr=60
33: jif=fffef865 type=00 num=03 iir=01 lsr=60 => iir=01 lsr=60
34: jif=fffef865 type=00 num=04 iir=01 lsr=60 => iir=01 lsr=60
35: jif=fffef865 type=00 num=05 iir=01 lsr=60 => iir=01 lsr=60
36: jif=fffef865 type=00 num=06 iir=01 lsr=60 => iir=01 lsr=60
37: jif=fffef865 type=00 num=07 iir=01 lsr=60 => iir=01 lsr=60
38: jif=fffef865 type=00 num=08 iir=01 lsr=60 => iir=01 lsr=60
39: jif=fffef865 type=00 num=09 iir=01 lsr=60 => iir=01 lsr=60
40: jif=fffef865 type=00 num=0a iir=01 lsr=60 => iir=01 lsr=60
41: jif=fffef865 type=00 num=0b iir=01 lsr=60 => iir=01 lsr=60
42: jif=fffef865 type=00 num=0c iir=01 lsr=60 => iir=01 lsr=60
43: jif=fffef865 type=00 num=0d iir=01 lsr=60 => iir=01 lsr=60
44: jif=fffef865 type=00 num=0e iir=01 lsr=60 => iir=01 lsr=60
45: jif=fffef865 type=00 num=0f iir=01 lsr=60 => iir=01 lsr=60
46: jif=fffef865 type=00 num=10 iir=01 lsr=60 => iir=01 lsr=60
47: jif=fffef865 type=00 num=11 iir=01 lsr=60 => iir=01 lsr=60
48: jif=fffef865 type=00 num=12 iir=01 lsr=60 => iir=01 lsr=60
49: jif=fffef865 type=00 num=13 iir=01 lsr=60 => iir=01 lsr=60
50: jif=fffef865 type=00 num=14 iir=01 lsr=60 => iir=01 lsr=60
51: jif=fffef865 type=00 num=15 iir=01 lsr=60 => iir=01 lsr=60
52: jif=fffef865 type=00 num=16 iir=01 lsr=60 => iir=01 lsr=60
53: jif=fffef865 type=00 num=17 iir=01 lsr=60 => iir=01 lsr=60
54: jif=fffef865 type=00 num=18 iir=01 lsr=60 => iir=01 lsr=60
55: jif=fffef865 type=00 num=19 iir=01 lsr=60 => iir=01 lsr=60
56: jif=fffef865 type=00 num=1a iir=01 lsr=60 => iir=01 lsr=60
57: jif=fffef865 type=00 num=1b iir=01 lsr=60 => iir=01 lsr=60
58: jif=fffef865 type=00 num=1c iir=01 lsr=60 => iir=01 lsr=60
59: jif=fffef865 type=00 num=1d iir=01 lsr=60 => iir=01 lsr=60
60: jif=fffef865 type=00 num=1e iir=01 lsr=60 => iir=01 lsr=60
61: jif=fffef865 type=00 num=1f iir=01 lsr=60 => iir=01 lsr=60
62: jif=fffef865 type=00 num=20 iir=01 lsr=60 => iir=01 lsr=60
63: jif=fffef865 type=00 num=21 iir=01 lsr=60 => iir=01 lsr=60
serial8250: too much work for irq3
serial8250: port c0453034(1)
0: jif=fffef865 type=00 num=06 iir=01 lsr=60 => iir=01 lsr=60
1: jif=fffef865 type=00 num=07 iir=01 lsr=60 => iir=01 lsr=60
2: jif=fffef865 type=00 num=08 iir=01 lsr=60 => iir=01 lsr=60
3: jif=fffef865 type=00 num=09 iir=01 lsr=60 => iir=01 lsr=60
4: jif=fffef865 type=00 num=0a iir=01 lsr=60 => iir=01 lsr=60
5: jif=fffef865 type=00 num=0b iir=01 lsr=60 => iir=01 lsr=60
6: jif=fffef865 type=00 num=0c iir=01 lsr=60 => iir=01 lsr=60
7: jif=fffef865 type=00 num=0d iir=01 lsr=60 => iir=01 lsr=60
8: jif=fffef865 type=00 num=0e iir=01 lsr=60 => iir=01 lsr=60
9: jif=fffef865 type=00 num=0f iir=01 lsr=60 => iir=01 lsr=60
10: jif=fffef865 type=00 num=10 iir=01 lsr=60 => iir=01 lsr=60
11: jif=fffef865 type=00 num=11 iir=01 lsr=60 => iir=01 lsr=60
12: jif=fffef865 type=00 num=12 iir=01 lsr=60 => iir=01 lsr=60
13: jif=fffef865 type=00 num=13 iir=01 lsr=60 => iir=01 lsr=60
14: jif=fffef865 type=00 num=14 iir=01 lsr=60 => iir=01 lsr=60
15: jif=fffef865 type=00 num=15 iir=01 lsr=60 => iir=01 lsr=60
16: jif=fffef865 type=00 num=16 iir=01 lsr=60 => iir=01 lsr=60
17: jif=fffef865 type=00 num=17 iir=01 lsr=60 => iir=01 lsr=60
18: jif=fffef865 type=00 num=18 iir=01 lsr=60 => iir=01 lsr=60
19: jif=fffef865 type=00 num=19 iir=01 lsr=60 => iir=01 lsr=60
20: jif=fffef865 type=00 num=1a iir=01 lsr=60 => iir=01 lsr=60
21: jif=fffef865 type=00 num=1b iir=01 lsr=60 => iir=01 lsr=60
22: jif=fffef865 type=00 num=1c iir=01 lsr=60 => iir=01 lsr=60
23: jif=fffef865 type=00 num=1d iir=01 lsr=60 => iir=01 lsr=60
24: jif=fffef865 type=00 num=1e iir=01 lsr=60 => iir=01 lsr=60
25: jif=fffef865 type=00 num=1f iir=01 lsr=60 => iir=01 lsr=60
26: jif=fffef865 type=00 num=20 iir=01 lsr=60 => iir=01 lsr=60
27: jif=fffef865 type=00 num=21 iir=01 lsr=60 => iir=01 lsr=60
28: jif=fffef8cc type=00 num=00 iir=c2 lsr=60 => iir=c1 lsr=60
29: jif=fffef8cc type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
30: jif=fffef90b type=00 num=00 iir=c1 lsr=60 => iir=c1 lsr=60
31: jif=fffef90b type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
32: jif=fffef90b type=00 num=02 iir=c1 lsr=60 => iir=c1 lsr=60
33: jif=fffef90b type=00 num=03 iir=c1 lsr=60 => iir=c1 lsr=60
34: jif=fffef90b type=00 num=04 iir=c1 lsr=60 => iir=c1 lsr=60
35: jif=fffef90b type=00 num=05 iir=c1 lsr=60 => iir=c1 lsr=60
36: jif=fffef90b type=00 num=06 iir=c1 lsr=60 => iir=c1 lsr=60
37: jif=fffef90b type=00 num=07 iir=c1 lsr=60 => iir=c1 lsr=60
38: jif=fffef90b type=00 num=08 iir=c1 lsr=60 => iir=c1 lsr=60
39: jif=fffef90b type=00 num=09 iir=c1 lsr=60 => iir=c1 lsr=60
40: jif=fffef90b type=00 num=0a iir=c1 lsr=60 => iir=c1 lsr=60
41: jif=fffef90b type=00 num=0b iir=c1 lsr=60 => iir=c1 lsr=60
42: jif=fffef90b type=00 num=0c iir=c1 lsr=60 => iir=c1 lsr=60
43: jif=fffef90b type=00 num=0d iir=c1 lsr=60 => iir=c1 lsr=60
44: jif=fffef90b type=00 num=0e iir=c1 lsr=60 => iir=c1 lsr=60
45: jif=fffef90b type=00 num=0f iir=c1 lsr=60 => iir=c1 lsr=60
46: jif=fffef90b type=00 num=10 iir=c1 lsr=60 => iir=c1 lsr=60
47: jif=fffef90b type=00 num=11 iir=c1 lsr=60 => iir=c1 lsr=60
48: jif=fffef90b type=00 num=12 iir=c1 lsr=60 => iir=c1 lsr=60
49: jif=fffef90b type=00 num=13 iir=c1 lsr=60 => iir=c1 lsr=60
50: jif=fffef90b type=00 num=14 iir=c1 lsr=60 => iir=c1 lsr=60
51: jif=fffef90b type=00 num=15 iir=c1 lsr=60 => iir=c1 lsr=60
52: jif=fffef90b type=00 num=16 iir=c1 lsr=60 => iir=c1 lsr=60
53: jif=fffef90b type=00 num=17 iir=c1 lsr=60 => iir=c1 lsr=60
54: jif=fffef90b type=00 num=18 iir=c1 lsr=60 => iir=c1 lsr=60
55: jif=fffef90b type=00 num=19 iir=c1 lsr=60 => iir=c1 lsr=60
56: jif=fffef90b type=00 num=1a iir=c1 lsr=60 => iir=c1 lsr=60
57: jif=fffef90b type=00 num=1b iir=c1 lsr=60 => iir=c1 lsr=60
58: jif=fffef90b type=00 num=1c iir=c1 lsr=60 => iir=c1 lsr=60
59: jif=fffef90b type=00 num=1d iir=c1 lsr=60 => iir=c1 lsr=60
60: jif=fffef90b type=00 num=1e iir=c1 lsr=60 => iir=c1 lsr=60
61: jif=fffef90b type=00 num=1f iir=c1 lsr=60 => iir=c1 lsr=60
62: jif=fffef90b type=00 num=20 iir=c1 lsr=60 => iir=c1 lsr=60
63: jif=fffef90b type=00 num=21 iir=c1 lsr=60 => iir=c1 lsr=60
serial8250: too much work for irq3
serial8250: port c0453034(1)
0: jif=fffef90b type=00 num=04 iir=c1 lsr=60 => iir=c1 lsr=60
1: jif=fffef90b type=00 num=05 iir=c1 lsr=60 => iir=c1 lsr=60
2: jif=fffef90b type=00 num=06 iir=c1 lsr=60 => iir=c1 lsr=60
3: jif=fffef90b type=00 num=07 iir=c1 lsr=60 => iir=c1 lsr=60
4: jif=fffef90b type=00 num=08 iir=c1 lsr=60 => iir=c1 lsr=60
5: jif=fffef90b type=00 num=09 iir=c1 lsr=60 => iir=c1 lsr=60
6: jif=fffef90b type=00 num=0a iir=c1 lsr=60 => iir=c1 lsr=60
7: jif=fffef90b type=00 num=0b iir=c1 lsr=60 => iir=c1 lsr=60
8: jif=fffef90b type=00 num=0c iir=c1 lsr=60 => iir=c1 lsr=60
9: jif=fffef90b type=00 num=0d iir=c1 lsr=60 => iir=c1 lsr=60
10: jif=fffef90b type=00 num=0e iir=c1 lsr=60 => iir=c1 lsr=60
11: jif=fffef90b type=00 num=0f iir=c1 lsr=60 => iir=c1 lsr=60
12: jif=fffef90b type=00 num=10 iir=c1 lsr=60 => iir=c1 lsr=60
13: jif=fffef90b type=00 num=11 iir=c1 lsr=60 => iir=c1 lsr=60
14: jif=fffef90b type=00 num=12 iir=c1 lsr=60 => iir=c1 lsr=60
15: jif=fffef90b type=00 num=13 iir=c1 lsr=60 => iir=c1 lsr=60
16: jif=fffef90b type=00 num=14 iir=c1 lsr=60 => iir=c1 lsr=60
17: jif=fffef90b type=00 num=15 iir=c1 lsr=60 => iir=c1 lsr=60
18: jif=fffef90b type=00 num=16 iir=c1 lsr=60 => iir=c1 lsr=60
19: jif=fffef90b type=00 num=17 iir=c1 lsr=60 => iir=c1 lsr=60
20: jif=fffef90b type=00 num=18 iir=c1 lsr=60 => iir=c1 lsr=60
21: jif=fffef90b type=00 num=19 iir=c1 lsr=60 => iir=c1 lsr=60
22: jif=fffef90b type=00 num=1a iir=c1 lsr=60 => iir=c1 lsr=60
23: jif=fffef90b type=00 num=1b iir=c1 lsr=60 => iir=c1 lsr=60
24: jif=fffef90b type=00 num=1c iir=c1 lsr=60 => iir=c1 lsr=60
25: jif=fffef90b type=00 num=1d iir=c1 lsr=60 => iir=c1 lsr=60
26: jif=fffef90b type=00 num=1e iir=c1 lsr=60 => iir=c1 lsr=60
27: jif=fffef90b type=00 num=1f iir=c1 lsr=60 => iir=c1 lsr=60
28: jif=fffef90b type=00 num=20 iir=c1 lsr=60 => iir=c1 lsr=60
29: jif=fffef90b type=00 num=21 iir=c1 lsr=60 => iir=c1 lsr=60
30: jif=fffef90b type=00 num=00 iir=01 lsr=60 => iir=01 lsr=60
31: jif=fffef90b type=00 num=01 iir=01 lsr=60 => iir=01 lsr=60
32: jif=fffef90b type=00 num=02 iir=01 lsr=60 => iir=01 lsr=60
33: jif=fffef90b type=00 num=03 iir=01 lsr=60 => iir=01 lsr=60
34: jif=fffef90b type=00 num=04 iir=01 lsr=60 => iir=01 lsr=60
35: jif=fffef90b type=00 num=05 iir=01 lsr=60 => iir=01 lsr=60
36: jif=fffef90b type=00 num=06 iir=01 lsr=60 => iir=01 lsr=60
37: jif=fffef90b type=00 num=07 iir=01 lsr=60 => iir=01 lsr=60
38: jif=fffef90b type=00 num=08 iir=01 lsr=60 => iir=01 lsr=60
39: jif=fffef90b type=00 num=09 iir=01 lsr=60 => iir=01 lsr=60
40: jif=fffef90b type=00 num=0a iir=01 lsr=60 => iir=01 lsr=60
41: jif=fffef90b type=00 num=0b iir=01 lsr=60 => iir=01 lsr=60
42: jif=fffef90b type=00 num=0c iir=01 lsr=60 => iir=01 lsr=60
43: jif=fffef90b type=00 num=0d iir=01 lsr=60 => iir=01 lsr=60
44: jif=fffef90b type=00 num=0e iir=01 lsr=60 => iir=01 lsr=60
45: jif=fffef90b type=00 num=0f iir=01 lsr=60 => iir=01 lsr=60
46: jif=fffef90b type=00 num=10 iir=01 lsr=60 => iir=01 lsr=60
47: jif=fffef90b type=00 num=11 iir=01 lsr=60 => iir=01 lsr=60
48: jif=fffef90b type=00 num=12 iir=01 lsr=60 => iir=01 lsr=60
49: jif=fffef90b type=00 num=13 iir=01 lsr=60 => iir=01 lsr=60
50: jif=fffef90b type=00 num=14 iir=01 lsr=60 => iir=01 lsr=60
51: jif=fffef90b type=00 num=15 iir=01 lsr=60 => iir=01 lsr=60
52: jif=fffef90b type=00 num=16 iir=01 lsr=60 => iir=01 lsr=60
53: jif=fffef90b type=00 num=17 iir=01 lsr=60 => iir=01 lsr=60
54: jif=fffef90b type=00 num=18 iir=01 lsr=60 => iir=01 lsr=60
55: jif=fffef90b type=00 num=19 iir=01 lsr=60 => iir=01 lsr=60
56: jif=fffef90b type=00 num=1a iir=01 lsr=60 => iir=01 lsr=60
57: jif=fffef90c type=00 num=1b iir=01 lsr=60 => iir=01 lsr=60
58: jif=fffef90c type=00 num=1c iir=01 lsr=60 => iir=01 lsr=60
59: jif=fffef90c type=00 num=1d iir=01 lsr=60 => iir=01 lsr=60
60: jif=fffef90c type=00 num=1e iir=01 lsr=60 => iir=01 lsr=60
61: jif=fffef90c type=00 num=1f iir=01 lsr=60 => iir=01 lsr=60
62: jif=fffef90c type=00 num=20 iir=01 lsr=60 => iir=01 lsr=60
63: jif=fffef90c type=00 num=21 iir=01 lsr=60 => iir=01 lsr=60
serial8250: too much work for irq3
serial8250: port c0453034(1)
0: jif=fffef90b type=00 num=04 iir=01 lsr=60 => iir=01 lsr=60
1: jif=fffef90b type=00 num=05 iir=01 lsr=60 => iir=01 lsr=60
2: jif=fffef90b type=00 num=06 iir=01 lsr=60 => iir=01 lsr=60
3: jif=fffef90b type=00 num=07 iir=01 lsr=60 => iir=01 lsr=60
4: jif=fffef90b type=00 num=08 iir=01 lsr=60 => iir=01 lsr=60
5: jif=fffef90b type=00 num=09 iir=01 lsr=60 => iir=01 lsr=60
6: jif=fffef90b type=00 num=0a iir=01 lsr=60 => iir=01 lsr=60
7: jif=fffef90b type=00 num=0b iir=01 lsr=60 => iir=01 lsr=60
8: jif=fffef90b type=00 num=0c iir=01 lsr=60 => iir=01 lsr=60
9: jif=fffef90b type=00 num=0d iir=01 lsr=60 => iir=01 lsr=60
10: jif=fffef90b type=00 num=0e iir=01 lsr=60 => iir=01 lsr=60
11: jif=fffef90b type=00 num=0f iir=01 lsr=60 => iir=01 lsr=60
12: jif=fffef90b type=00 num=10 iir=01 lsr=60 => iir=01 lsr=60
13: jif=fffef90b type=00 num=11 iir=01 lsr=60 => iir=01 lsr=60
14: jif=fffef90b type=00 num=12 iir=01 lsr=60 => iir=01 lsr=60
15: jif=fffef90b type=00 num=13 iir=01 lsr=60 => iir=01 lsr=60
16: jif=fffef90b type=00 num=14 iir=01 lsr=60 => iir=01 lsr=60
17: jif=fffef90b type=00 num=15 iir=01 lsr=60 => iir=01 lsr=60
18: jif=fffef90b type=00 num=16 iir=01 lsr=60 => iir=01 lsr=60
19: jif=fffef90b type=00 num=17 iir=01 lsr=60 => iir=01 lsr=60
20: jif=fffef90b type=00 num=18 iir=01 lsr=60 => iir=01 lsr=60
21: jif=fffef90b type=00 num=19 iir=01 lsr=60 => iir=01 lsr=60
22: jif=fffef90b type=00 num=1a iir=01 lsr=60 => iir=01 lsr=60
23: jif=fffef90c type=00 num=1b iir=01 lsr=60 => iir=01 lsr=60
24: jif=fffef90c type=00 num=1c iir=01 lsr=60 => iir=01 lsr=60
25: jif=fffef90c type=00 num=1d iir=01 lsr=60 => iir=01 lsr=60
26: jif=fffef90c type=00 num=1e iir=01 lsr=60 => iir=01 lsr=60
27: jif=fffef90c type=00 num=1f iir=01 lsr=60 => iir=01 lsr=60
28: jif=fffef90c type=00 num=20 iir=01 lsr=60 => iir=01 lsr=60
29: jif=fffef90c type=00 num=21 iir=01 lsr=60 => iir=01 lsr=60
30: jif=fffef90c type=00 num=00 iir=c1 lsr=60 => iir=c1 lsr=60
31: jif=fffef90c type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
32: jif=fffef90c type=00 num=02 iir=c1 lsr=60 => iir=c1 lsr=60
33: jif=fffef90c type=00 num=03 iir=c1 lsr=60 => iir=c1 lsr=60
34: jif=fffef90c type=00 num=04 iir=c1 lsr=60 => iir=c1 lsr=60
35: jif=fffef90c type=00 num=05 iir=c1 lsr=60 => iir=c1 lsr=60
36: jif=fffef90c type=00 num=06 iir=c1 lsr=60 => iir=c1 lsr=60
37: jif=fffef90c type=00 num=07 iir=c1 lsr=60 => iir=c1 lsr=60
38: jif=fffef90c type=00 num=08 iir=c1 lsr=60 => iir=c1 lsr=60
39: jif=fffef90c type=00 num=09 iir=c1 lsr=60 => iir=c1 lsr=60
40: jif=fffef90c type=00 num=0a iir=c1 lsr=60 => iir=c1 lsr=60
41: jif=fffef90c type=00 num=0b iir=c1 lsr=60 => iir=c1 lsr=60
42: jif=fffef90c type=00 num=0c iir=c1 lsr=60 => iir=c1 lsr=60
43: jif=fffef90c type=00 num=0d iir=c1 lsr=60 => iir=c1 lsr=60
44: jif=fffef90c type=00 num=0e iir=c1 lsr=60 => iir=c1 lsr=60
45: jif=fffef90c type=00 num=0f iir=c1 lsr=60 => iir=c1 lsr=60
46: jif=fffef90c type=00 num=10 iir=c1 lsr=60 => iir=c1 lsr=60
47: jif=fffef90c type=00 num=11 iir=c1 lsr=60 => iir=c1 lsr=60
48: jif=fffef90c type=00 num=12 iir=c1 lsr=60 => iir=c1 lsr=60
49: jif=fffef90c type=00 num=13 iir=c1 lsr=60 => iir=c1 lsr=60
50: jif=fffef90c type=00 num=14 iir=c1 lsr=60 => iir=c1 lsr=60
51: jif=fffef90c type=00 num=15 iir=c1 lsr=60 => iir=c1 lsr=60
52: jif=fffef90c type=00 num=16 iir=c1 lsr=60 => iir=c1 lsr=60
53: jif=fffef90c type=00 num=17 iir=c1 lsr=60 => iir=c1 lsr=60
54: jif=fffef90c type=00 num=18 iir=c1 lsr=60 => iir=c1 lsr=60
55: jif=fffef90c type=00 num=19 iir=c1 lsr=60 => iir=c1 lsr=60
56: jif=fffef90c type=00 num=1a iir=c1 lsr=60 => iir=c1 lsr=60
57: jif=fffef90c type=00 num=1b iir=c1 lsr=60 => iir=c1 lsr=60
58: jif=fffef90c type=00 num=1c iir=c1 lsr=60 => iir=c1 lsr=60
59: jif=fffef90c type=00 num=1d iir=c1 lsr=60 => iir=c1 lsr=60
60: jif=fffef90c type=00 num=1e iir=c1 lsr=60 => iir=c1 lsr=60
61: jif=fffef90c type=00 num=1f iir=c1 lsr=60 => iir=c1 lsr=60
62: jif=fffef90c type=00 num=20 iir=c1 lsr=60 => iir=c1 lsr=60
63: jif=fffef90c type=00 num=21 iir=c1 lsr=60 => iir=c1 lsr=60
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
lp0: ECP mode
lp0: ECP mode
lp0: ECP mode
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
NFSD: starting 90-second grace period
eth0: no IPv6 routers present
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized r128 2.5.0 20030725 on minor 0: 
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:02:00.0 into 2x mode
serial8250: too much work for irq4
serial8250: port c0452c80(0)
0: jif=fffef863 type=00 num=04 iir=c1 lsr=60 => iir=c1 lsr=60
1: jif=fffef863 type=00 num=05 iir=c1 lsr=60 => iir=c1 lsr=60
2: jif=fffef863 type=00 num=06 iir=c1 lsr=60 => iir=c1 lsr=60
3: jif=fffef863 type=00 num=07 iir=c1 lsr=60 => iir=c1 lsr=60
4: jif=fffef863 type=00 num=08 iir=c1 lsr=60 => iir=c1 lsr=60
5: jif=fffef863 type=00 num=09 iir=c1 lsr=60 => iir=c1 lsr=60
6: jif=fffef863 type=00 num=0a iir=c1 lsr=60 => iir=c1 lsr=60
7: jif=fffef863 type=00 num=0b iir=c1 lsr=60 => iir=c1 lsr=60
8: jif=fffef863 type=00 num=0c iir=c1 lsr=60 => iir=c1 lsr=60
9: jif=fffef863 type=00 num=0d iir=c1 lsr=60 => iir=c1 lsr=60
10: jif=fffef863 type=00 num=0e iir=c1 lsr=60 => iir=c1 lsr=60
11: jif=fffef863 type=00 num=0f iir=c1 lsr=60 => iir=c1 lsr=60
12: jif=fffef863 type=00 num=10 iir=c1 lsr=60 => iir=c1 lsr=60
13: jif=fffef863 type=00 num=11 iir=c1 lsr=60 => iir=c1 lsr=60
14: jif=fffef863 type=00 num=12 iir=c1 lsr=60 => iir=c1 lsr=60
15: jif=fffef863 type=00 num=13 iir=c1 lsr=60 => iir=c1 lsr=60
16: jif=fffef863 type=00 num=14 iir=c1 lsr=60 => iir=c1 lsr=60
17: jif=fffef863 type=00 num=15 iir=c1 lsr=60 => iir=c1 lsr=60
18: jif=fffef863 type=00 num=16 iir=c1 lsr=60 => iir=c1 lsr=60
19: jif=fffef863 type=00 num=17 iir=c1 lsr=60 => iir=c1 lsr=60
20: jif=fffef863 type=00 num=18 iir=c1 lsr=60 => iir=c1 lsr=60
21: jif=fffef863 type=00 num=19 iir=c1 lsr=60 => iir=c1 lsr=60
22: jif=fffef863 type=00 num=1a iir=c1 lsr=60 => iir=c1 lsr=60
23: jif=fffef863 type=00 num=1b iir=c1 lsr=60 => iir=c1 lsr=60
24: jif=fffef863 type=00 num=1c iir=c1 lsr=60 => iir=c1 lsr=60
25: jif=fffef863 type=00 num=1d iir=c1 lsr=60 => iir=c1 lsr=60
26: jif=fffef863 type=00 num=1e iir=c1 lsr=60 => iir=c1 lsr=60
27: jif=fffef863 type=00 num=1f iir=c1 lsr=60 => iir=c1 lsr=60
28: jif=fffef863 type=00 num=20 iir=c1 lsr=60 => iir=c1 lsr=60
29: jif=fffef863 type=00 num=21 iir=c1 lsr=60 => iir=c1 lsr=60
30: jif=ffff36f1 type=00 num=00 iir=01 lsr=60 => iir=01 lsr=60
31: jif=ffff36f1 type=00 num=01 iir=01 lsr=60 => iir=01 lsr=60
32: jif=ffff36f1 type=00 num=02 iir=01 lsr=60 => iir=01 lsr=60
33: jif=ffff36f1 type=00 num=03 iir=01 lsr=60 => iir=01 lsr=60
34: jif=ffff36f1 type=00 num=04 iir=01 lsr=60 => iir=01 lsr=60
35: jif=ffff36f1 type=00 num=05 iir=01 lsr=60 => iir=01 lsr=60
36: jif=ffff36f1 type=00 num=06 iir=01 lsr=60 => iir=01 lsr=60
37: jif=ffff36f1 type=00 num=07 iir=01 lsr=60 => iir=01 lsr=60
38: jif=ffff36f1 type=00 num=08 iir=01 lsr=60 => iir=01 lsr=60
39: jif=ffff36f1 type=00 num=09 iir=01 lsr=60 => iir=01 lsr=60
40: jif=ffff36f1 type=00 num=0a iir=01 lsr=60 => iir=01 lsr=60
41: jif=ffff36f1 type=00 num=0b iir=01 lsr=60 => iir=01 lsr=60
42: jif=ffff36f1 type=00 num=0c iir=01 lsr=60 => iir=01 lsr=60
43: jif=ffff36f1 type=00 num=0d iir=01 lsr=60 => iir=01 lsr=60
44: jif=ffff36f1 type=00 num=0e iir=01 lsr=60 => iir=01 lsr=60
45: jif=ffff36f1 type=00 num=0f iir=01 lsr=60 => iir=01 lsr=60
46: jif=ffff36f1 type=00 num=10 iir=01 lsr=60 => iir=01 lsr=60
47: jif=ffff36f1 type=00 num=11 iir=01 lsr=60 => iir=01 lsr=60
48: jif=ffff36f1 type=00 num=12 iir=01 lsr=60 => iir=01 lsr=60
49: jif=ffff36f1 type=00 num=13 iir=01 lsr=60 => iir=01 lsr=60
50: jif=ffff36f1 type=00 num=14 iir=01 lsr=60 => iir=01 lsr=60
51: jif=ffff36f1 type=00 num=15 iir=01 lsr=60 => iir=01 lsr=60
52: jif=ffff36f1 type=00 num=16 iir=01 lsr=60 => iir=01 lsr=60
53: jif=ffff36f1 type=00 num=17 iir=01 lsr=60 => iir=01 lsr=60
54: jif=ffff36f1 type=00 num=18 iir=01 lsr=60 => iir=01 lsr=60
55: jif=ffff36f1 type=00 num=19 iir=01 lsr=60 => iir=01 lsr=60
56: jif=ffff36f1 type=00 num=1a iir=01 lsr=60 => iir=01 lsr=60
57: jif=ffff36f1 type=00 num=1b iir=01 lsr=60 => iir=01 lsr=60
58: jif=ffff36f1 type=00 num=1c iir=01 lsr=60 => iir=01 lsr=60
59: jif=ffff36f1 type=00 num=1d iir=01 lsr=60 => iir=01 lsr=60
60: jif=ffff36f1 type=00 num=1e iir=01 lsr=60 => iir=01 lsr=60
61: jif=ffff36f1 type=00 num=1f iir=01 lsr=60 => iir=01 lsr=60
62: jif=ffff36f1 type=00 num=20 iir=01 lsr=60 => iir=01 lsr=60
63: jif=ffff36f1 type=00 num=21 iir=01 lsr=60 => iir=01 lsr=60
Linux Tulip driver version 1.1.13-NAPI (May 11, 2002)
serial8250: too much work for irq4
serial8250: port c0452c80(0)
0: jif=000023cc type=00 num=00 iir=c0 lsr=61 => iir=c1 lsr=60
1: jif=000023cc type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
2: jif=000023cc type=00 num=00 iir=c0 lsr=60 => iir=c1 lsr=60
3: jif=000023cc type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
4: jif=000023cc type=00 num=00 iir=c0 lsr=60 => iir=c1 lsr=60
5: jif=000023cc type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
6: jif=000023cc type=00 num=00 iir=c0 lsr=60 => iir=c1 lsr=60
7: jif=000023cc type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
8: jif=000023cc type=00 num=00 iir=c0 lsr=61 => iir=c1 lsr=60
9: jif=000023cc type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
10: jif=000023cd type=00 num=00 iir=c0 lsr=60 => iir=c1 lsr=60
11: jif=000023cd type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
12: jif=000023cd type=00 num=00 iir=c0 lsr=60 => iir=c1 lsr=60
13: jif=000023cd type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
14: jif=000023cd type=00 num=00 iir=c0 lsr=61 => iir=c1 lsr=60
15: jif=000023cd type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
16: jif=000023cd type=00 num=00 iir=c0 lsr=60 => iir=c1 lsr=60
17: jif=000023cd type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
18: jif=000023cd type=00 num=00 iir=c0 lsr=60 => iir=c1 lsr=60
19: jif=000023cd type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
20: jif=000023cd type=00 num=00 iir=c0 lsr=60 => iir=c1 lsr=60
21: jif=000023cd type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
22: jif=000023cd type=00 num=00 iir=c6 lsr=e9 => iir=c1 lsr=60
23: jif=000023cd type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
24: jif=000023cd type=00 num=00 iir=c0 lsr=60 => iir=c1 lsr=60
25: jif=000023cd type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
26: jif=000023cd type=00 num=00 iir=c0 lsr=60 => iir=c1 lsr=60
27: jif=000023cd type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
28: jif=000023cf type=00 num=00 iir=c0 lsr=60 => iir=c1 lsr=60
29: jif=000023cf type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
30: jif=00004773 type=00 num=00 iir=c1 lsr=60 => iir=c1 lsr=60
31: jif=00004773 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
32: jif=00004773 type=00 num=02 iir=c1 lsr=60 => iir=c1 lsr=60
33: jif=00004773 type=00 num=03 iir=c1 lsr=60 => iir=c1 lsr=60
34: jif=00004773 type=00 num=04 iir=c1 lsr=60 => iir=c1 lsr=60
35: jif=00004773 type=00 num=05 iir=c1 lsr=60 => iir=c1 lsr=60
36: jif=00004773 type=00 num=06 iir=c1 lsr=60 => iir=c1 lsr=60
37: jif=00004773 type=00 num=07 iir=c1 lsr=60 => iir=c1 lsr=60
38: jif=00004773 type=00 num=08 iir=c1 lsr=60 => iir=c1 lsr=60
39: jif=00004773 type=00 num=09 iir=c1 lsr=60 => iir=c1 lsr=60
40: jif=00004773 type=00 num=0a iir=c1 lsr=60 => iir=c1 lsr=60
41: jif=00004773 type=00 num=0b iir=c1 lsr=60 => iir=c1 lsr=60
42: jif=00004773 type=00 num=0c iir=c1 lsr=60 => iir=c1 lsr=60
43: jif=00004773 type=00 num=0d iir=c1 lsr=60 => iir=c1 lsr=60
44: jif=00004773 type=00 num=0e iir=c1 lsr=60 => iir=c1 lsr=60
45: jif=00004773 type=00 num=0f iir=c1 lsr=60 => iir=c1 lsr=60
46: jif=00004773 type=00 num=10 iir=c1 lsr=60 => iir=c1 lsr=60
47: jif=00004773 type=00 num=11 iir=c1 lsr=60 => iir=c1 lsr=60
48: jif=00004773 type=00 num=12 iir=c1 lsr=60 => iir=c1 lsr=60
49: jif=00004773 type=00 num=13 iir=c1 lsr=60 => iir=c1 lsr=60
50: jif=00004773 type=00 num=14 iir=c1 lsr=60 => iir=c1 lsr=60
51: jif=00004773 type=00 num=15 iir=c1 lsr=60 => iir=c1 lsr=60
52: jif=00004773 type=00 num=16 iir=c1 lsr=60 => iir=c1 lsr=60
53: jif=00004773 type=00 num=17 iir=c1 lsr=60 => iir=c1 lsr=60
54: jif=00004773 type=00 num=18 iir=c1 lsr=60 => iir=c1 lsr=60
55: jif=00004773 type=00 num=19 iir=c1 lsr=60 => iir=c1 lsr=60
56: jif=00004773 type=00 num=1a iir=c1 lsr=60 => iir=c1 lsr=60
57: jif=00004773 type=00 num=1b iir=c1 lsr=60 => iir=c1 lsr=60
58: jif=00004773 type=00 num=1c iir=c1 lsr=60 => iir=c1 lsr=60
59: jif=00004773 type=00 num=1d iir=c1 lsr=60 => iir=c1 lsr=60
60: jif=00004773 type=00 num=1e iir=c1 lsr=60 => iir=c1 lsr=60
61: jif=00004773 type=00 num=1f iir=c1 lsr=60 => iir=c1 lsr=60
62: jif=00004773 type=00 num=20 iir=c1 lsr=60 => iir=c1 lsr=60
63: jif=00004773 type=00 num=21 iir=c1 lsr=60 => iir=c1 lsr=60

-- 
Meelis Roos (mroos@linux.ee)
