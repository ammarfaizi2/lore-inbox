Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161096AbWGIGJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161096AbWGIGJp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 02:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161097AbWGIGJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 02:09:45 -0400
Received: from mx2.mail.ru ([194.67.23.122]:64356 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1161096AbWGIGJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 02:09:44 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-input@atrey.karlin.mff.cuni.cz
Subject: pnp: Failed to activate device 00:05.  on resume from STR
Date: Sun, 9 Jul 2006 10:09:34 +0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607091009.39746.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I noticed that after resuming from suspend to RAM I consistently get

pnp: Failed to activate device 00:05.
pnp: Failed to activate device 00:06.
pnp: Device 00:09 activated.

according to lpsnp:

00:05 PNP0303 IBM enhanced keyboard (101/102-key, PS/2 mouse support)
00:06 PNP0f13 PS/2 port for PS/2-style mice

lspnp -vv and dmesg since boot follow. This is almost vanilla 2.6.17.4 + 
recent libtata from tj.

- -andrey

{pts/1}% lspnp -vv
00:00 PNP0c01 System board
    state = active
    allocated resources:
        mem 0x0-0x9ffff
        mem 0xe0000-0xeffff
        mem 0xf0000-0xfffff
        mem 0x100000-0x1ef5ffff

00:01 PNP0a03 PCI bus
    state = active
    allocated resources:
        io 0xcf8-0xcff
        mem 0x0-0xff
        mem 0x0-0xcf7
        mem 0xd00-0xffff
        mem 0xa0000-0xbffff

00:02 PNP0200 AT DMA controller
    state = active
    allocated resources:
        io 0x0-0xf
        io 0x81-0x83
        io 0x87-0x87
        io 0x89-0x8b
        io 0x8f-0x8f
        io 0xc0-0xdf
        dma 4

00:03 PNP0800 AT speaker
    state = active
    allocated resources:
        io 0x61-0x61

00:04 PNP0c04 Math coprocessor
    state = active
    allocated resources:
        io 0xf0-0xff
        irq 13

00:05 PNP0303 IBM enhanced keyboard (101/102-key, PS/2 mouse support)
    state = active
    allocated resources:
        io 0x60-0x60
        io 0x64-0x64
        irq 1

00:06 PNP0f13 PS/2 port for PS/2-style mice
    state = active
    allocated resources:
        irq 12

00:07 PNP0b00 AT real-time clock
    state = active
    allocated resources:
        io 0x70-0x71
        irq 8

00:08 PNP0c02 Motherboard resources
    state = active
    allocated resources:
        io 0x2e-0x2f
        io 0x62-0x62
        io 0x66-0x66
        io 0x80-0x80
        io 0x84-0x86
        io 0x88-0x88
        io 0x8c-0x8e
        io 0x92-0x92

00:09 PNP0501 16550A-compatible serial port
    state = active
    allocated resources:
        io 0x3f8-0x3ff
        irq 4
    possible resources:
        irq 3,4,5,6,7,10,11 High-Edge
        Dependent: 01 - Priority acceptable
           port 0x3f8-0x3f8, align 0x0, size 0x8, 16-bit address decoding
        Dependent: 02 - Priority acceptable
           port 0x2f8-0x2f8, align 0x0, size 0x8, 16-bit address decoding
        Dependent: 03 - Priority acceptable
           port 0x2e8-0x2e8, align 0x0, size 0x8, 16-bit address decoding
        Dependent: 04 - Priority acceptable
           port 0x3e8-0x3e8, align 0x0, size 0x8, 16-bit address decoding

00:0a SMCf010 SMC Fast Infrared Port
    state = disabled
    possible resources:
        port 0x100-0x130, align 0xf, size 0x8, 16-bit address decoding
        irq 3,4,5,6,7,10,11 High-Edge
        dma 1,2,3 16-bit compatible
        Dependent: 01 - Priority acceptable
           port 0x3f8-0x3f8, align 0x0, size 0x8, 16-bit address decoding
        Dependent: 02 - Priority acceptable
           port 0x2e8-0x2e8, align 0x0, size 0x8, 16-bit address decoding
        Dependent: 03 - Priority acceptable
           port 0x2f8-0x2f8, align 0x0, size 0x8, 16-bit address decoding
        Dependent: 04 - Priority acceptable
           port 0x3e8-0x3e8, align 0x0, size 0x8, 16-bit address decoding

00:0b PNP0401 ECP printer port
    state = active
    allocated resources:
        io 0x378-0x37a
        io 0x778-0x77a
        irq 7
        dma 3
    possible resources:
        dma 1,2,3 8-bit compatible
        Dependent: 01 - Priority acceptable
           port 0x378-0x378, align 0x0, size 0x3, 16-bit address decoding
           port 0x778-0x778, align 0x0, size 0x3, 16-bit address decoding
           irq 7 High-Edge
        Dependent: 02 - Priority acceptable
           port 0x278-0x278, align 0x0, size 0x3, 16-bit address decoding
           port 0x678-0x678, align 0x0, size 0x3, 16-bit address decoding
           irq 5 High-Edge
        Dependent: 03 - Priority acceptable
           port 0x3bc-0x3bc, align 0x0, size 0x3, 16-bit address decoding
           port 0x7bc-0x7bc, align 0x0, size 0x3, 16-bit address decoding
           irq 7 High-Edge

Linux version 2.6.17.4-1avb (bor@cooker) (gcc version 4.1.1 20060518 
(prerelease)) #30 Sat Jul 8 23:15:13 MSD 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 00000000000eee00 (reserved)
 BIOS-e820: 00000000000eee00 - 00000000000ef000 (ACPI NVS)
 BIOS-e820: 00000000000ef000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ef60000 (usable)
 BIOS-e820: 000000001ef60000 - 000000001ef70000 (ACPI data)
 BIOS-e820: 000000001ef70000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
495MB LOWMEM available.
On node 0 totalpages: 126816
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 122720 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 TOSHIB                                ) @ 0x000f0090
ACPI: RSDT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x1ef60000
ACPI: FADT (v002 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x1ef60054
ACPI: DSDT (v001 TOSHIB 4000     0x20020417 MSFT 0x0100000a) @ 0x00000000
ACPI: PM-Timer IO Port: 0xee08
Allocating PCI resources starting at 30000000 (gap: 20000000:dff80000)
Built 1 zonelists
Kernel command line: root=/dev/sda2 resume=/dev/sda1 elevator=cfq vga=791
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (013e4000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Detected 747.722 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 499068k/507264k available (1660k kernel code, 7640k reserved, 794k 
data, 180k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1496.83 BogoMIPS (lpj=748415)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 
00000000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 
00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 0a
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ACPI: setting ELCR to 0200 (from 0a00)
checking if image is initramfs... it is
Freeing initrd memory: 302k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfe5ae, last bus=5
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region ee00-ee3f claimed by ali7101 ACPI
PCI quirk: region ef00-ef1f claimed by ali7101 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [PFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: f7f00000-fdffffff
  PREFETCH window: 3c000000-3c0fffff
PCI: Bus 2, cardbus bridge: 0000:00:10.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 32000000-33ffffff
PCI: Bus 6, cardbus bridge: 0000:00:11.0
  IO window: 00001800-000018ff
  IO window: 00001c00-00001cff
  PREFETCH window: 34000000-35ffffff
  MEM window: 36000000-37ffffff
PCI: Bus 10, cardbus bridge: 0000:00:11.1
  IO window: 00002000-000020ff
  IO window: 00002400-000024ff
  PREFETCH window: 38000000-39ffffff
  MEM window: 3a000000-3bffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Enabling device 0000:00:10.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> 
IRQ 11
PCI: Enabling device 0000:00:11.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> 
IRQ 11
PCI: Enabling device 0000:00:11.1 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:11.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> 
IRQ 11
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 8192 (order: 5, 163840 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1152386664.315:1): initialized
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Activating ISA DMA hang workarounds.
vesafb: framebuffer at 0xfc000000, mapped to 0xdf880000, using 3072k, total 
16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=9
vesafb: protected mode interface info at c000:775e
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 1
Using IPI Shortcut mode
ACPI wakeup devices: 
 COM USB1 ASND VIY0 VIY1  LAN MPC0 MPC1 NOV0  LID 
ACPI: (supports S0 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
Freeing unused kernel memory: 180k freed
Write protecting the kernel read-only data: 516k
SCSI subsystem initialized
input: AT Translated Set 2 keyboard as /class/input/input0
libata version 2.00 loaded.
ACPI: PCI Interrupt 0000:00:04.0[A]: no GSI
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xEFF0 irq 14
scsi0 : pata_ali
ata1.00: ATA-5, max UDMA/100, 39070080 sectors: LBA 
ata1.00: ata1: dev 0 multi count 0
ata1.00: configured for UDMA/33
  Vendor: ATA       Model: IC25N020ATDA04-0  Rev: DA3O
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xEFF8 irq 15
scsi1 : pata_ali
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
ata2.00: ATAPI, max UDMA/33
ata2.00: configured for PIO4
  Vendor: TOSHIBA   Model: DVD-ROM SD-C2502  Rev: 1313
  Type:   CD-ROM                             ANSI SCSI revision: 05
SCSI device sda: 39070080 512-byte hdwr sectors (20004 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
spurious 8259A interrupt: IRQ7.
SCSI device sda: 39070080 512-byte hdwr sectors (20004 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
ReiserFS: sda2: found reiserfs format "3.6" with standard journal
ReiserFS: sda2: using ordered data mode
ReiserFS: sda2: journal params: device sda2, size 8192, journal first block 
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda2: checking transaction log (sda2)
ReiserFS: sda2: Using r5 hash to sort names
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKG] -> GSI 11 (level, low) -> 
IRQ 11
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 11, io mem 0xf7eff000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
sr0: scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected ALi M1644 chipset
agpgart: AGP aperture is 64M @ 0xf0000000
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> 
IRQ 11
Yenta: CardBus bridge found at 0000:00:10.0 [12a3:ab01]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:10.0, mfunc 0x01000002, devctl 0x60
Yenta: ISA IRQ mask 0x0000, PCI irq 11
Socket status: 30000059
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> 
IRQ 11
Yenta: CardBus bridge found at 0000:00:11.0 [1179:0001]
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000007
pccard: PCMCIA card inserted into slot 0
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcbfff 0xe0000-0xfffff
cs: memory probe 0x60000000-0x60ffffff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
pcmcia: registering new device pcmcia0.0
ACPI: PCI Interrupt 0000:00:11.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> 
IRQ 11
Yenta: CardBus bridge found at 0000:00:11.1 [1179:0001]
wlags49_h1_cs v7.18 for PCMCIA, 03/31/2004 14:31:00 by Agere Systems, 
http://www.agere.com
*** Modified for kernel 2.6 by Andrey Borzenkov <arvidjaar@mail.ru> $Revision: 
25 $
*** Station Mode (STA) Support: YES
*** Access Point Mode (AP) Support: YES
eth0: PRI 31 variant 2 version 9.48
eth0: NIC 5 variant 2 version 1.02
eth0: Wireless, io_addr 0x100, irq 11, mac_address 00:02:2D:26:95:6C
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000007
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN] (off)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THRM] (54 C)
toshiba_acpi: Toshiba Laptop ACPI Extras version 0.18
toshiba_acpi:     HCI method: \_SB_.VALD.GHCI
ACPI: Video Device [VGA] (multi-head: yes  rom: yes  post: no)
Adding 500432k swap on /dev/sda1.  Priority:-1 extents:1 across:500432k
loop: loaded (max 8 devices)
NET: Registered protocol family 23
IrCOMM protocol (Dag Brattli)
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKH] -> GSI 11 (level, low) -> 
IRQ 11
NET: Registered protocol family 17
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> 
IRQ 11
e100: eth0: e100_probe: addr 0xf7efd000, irq 11, MAC addr 00:00:39:D7:14:A1
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
squashfs: version 3.0 (2006/03/15) Phillip Lougher, LZMA support by Andrey 
Borzenkov based on work of McMCC
pccard: card ejected from slot 0
Stopping tasks: 
==============================================================================|
pnp: Device 00:09 disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
BUG: sleeping function called from invalid context at 
include2/asm/semaphore.h:99
in_atomic():0, irqs_disabled():1
 <c010405d> show_trace+0xd/0x10  <c0104607> dump_stack+0x17/0x20
 <c0115f78> __might_sleep+0xa8/0xc0  <c01d3183> 
acpi_os_wait_semaphore+0x65/0xbb
 <c01e896e> acpi_ut_acquire_mutex+0x35/0x73  <c01df032> 
acpi_set_register+0x5a/0x16e
 <c01d766f> acpi_clear_event+0x25/0x2b  <c01e8fe7> acpi_pm_enter+0x93/0xb8
 <c013603c> suspend_enter+0x4c/0x60  <c0136110> enter_state+0xc0/0x170
 <c0136266> state_store+0xa6/0xb0  <c0196f6b> subsys_attr_store+0x2b/0x40
 <c0197283> sysfs_write_file+0xa3/0x100  <c015dfb9> vfs_write+0x99/0x160
 <c015e5dd> sys_write+0x3d/0x70  <c0102f1b> sysenter_past_esp+0x54/0x75
Back to C!
BUG: sleeping function called from invalid context 
at /home/bor/src/linux-git/mm/slab.c:2793
in_atomic():0, irqs_disabled():1
 <c010405d> show_trace+0xd/0x10  <c0104607> dump_stack+0x17/0x20
 <c0115f78> __might_sleep+0xa8/0xc0  <c015a249> kmem_cache_alloc+0x59/0x70
 <c01d2b43> acpi_os_acquire_object+0xe/0x3c  <c01e8621> 
acpi_ut_allocate_object_desc_dbg+0x13/0x45
 <c01e866b> acpi_ut_create_internal_object_dbg+0x18/0x6a  <c01e46ba> 
acpi_rs_set_srs_method_data+0x3a/0xaa
 <c01e4092> acpi_set_current_resources+0x1b/0x24  <c01ebcb9> 
acpi_pci_link_set+0xfb/0x174
 <c01ebd69> irqrouter_resume+0x37/0x56  <c020fc54> __sysdev_resume+0x14/0x80
 <c020fe97> sysdev_resume+0x57/0x90  <c0215148> device_power_up+0x8/0x10
 <c0136043> suspend_enter+0x53/0x60  <c0136110> enter_state+0xc0/0x170
 <c0136266> state_store+0xa6/0xb0  <c0196f6b> subsys_attr_store+0x2b/0x40
 <c0197283> sysfs_write_file+0xa3/0x100  <c015dfb9> vfs_write+0x99/0x160
 <c015e5dd> sys_write+0x3d/0x70  <c0102f1b> sysenter_past_esp+0x54/0x75
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKG] -> GSI 11 (level, low) -> 
IRQ 11
PM: Writing back config space on device 0000:00:02.0 at offset f (was 
500001ff, writing 5000010b)
ACPI: PCI Interrupt 0000:00:04.0[A]: no GSI
PM: Writing back config space on device 0000:00:06.0 at offset f (was 
180201ff, writing 1802010b)
PM: Writing back config space on device 0000:00:0a.0 at offset f (was 
380801ff, writing 3808010b)
PM: Writing back config space on device 0000:00:10.0 at offset 6 (was 50200, 
writing b0050200)
PM: Writing back config space on device 0000:00:10.0 at offset 1 (was 2100003, 
writing 2100007)
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> 
IRQ 11
pccard: PCMCIA card inserted into slot 0
pcmcia: registering new device pcmcia0.0
eth0: PRI 31 variant 2 version 9.48
eth0: NIC 5 variant 2 version 1.02
eth0: Wireless, io_addr 0x100, irq 11, mac_address 00:02:2D:26:95:6C
PM: Writing back config space on device 0000:00:11.0 at offset 1 (was 4900003, 
writing 4900007)
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> 
IRQ 11
PM: Writing back config space on device 0000:00:11.1 at offset 1 (was 4900003, 
writing 4900007)
ACPI: PCI Interrupt 0000:00:11.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> 
IRQ 11
PM: Writing back config space on device 0000:00:12.0 at offset f (was 1ff, 
writing 10b)
PM: Writing back config space on device 0000:01:00.0 at offset f (was 1ff, 
writing 10b)
pnp: Failed to activate device 00:05.
pnp: Failed to activate device 00:06.
pnp: Device 00:09 activated.
usb usb1: root hub lost power or was reset
Restarting tasks... done
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> 
IRQ 11
e100: eth0: e100_probe: addr 0xf7efd000, irq 11, MAC addr 00:00:39:D7:14:A1
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKH] -> GSI 11 (level, low) -> 
IRQ 11
nfsd: last server has exited
nfsd: unexporting all filesystems
pccard: card ejected from slot 0
Stopping tasks: 
===========================================================================|
pnp: Device 00:09 disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
BUG: sleeping function called from invalid context at 
include2/asm/semaphore.h:99
in_atomic():0, irqs_disabled():1
 <c010405d> show_trace+0xd/0x10  <c0104607> dump_stack+0x17/0x20
 <c0115f78> __might_sleep+0xa8/0xc0  <c01d3183> 
acpi_os_wait_semaphore+0x65/0xbb
 <c01e896e> acpi_ut_acquire_mutex+0x35/0x73  <c01df032> 
acpi_set_register+0x5a/0x16e
 <c01d766f> acpi_clear_event+0x25/0x2b  <c01e8fe7> acpi_pm_enter+0x93/0xb8
 <c013603c> suspend_enter+0x4c/0x60  <c0136110> enter_state+0xc0/0x170
 <c0136266> state_store+0xa6/0xb0  <c0196f6b> subsys_attr_store+0x2b/0x40
 <c0197283> sysfs_write_file+0xa3/0x100  <c015dfb9> vfs_write+0x99/0x160
 <c015e5dd> sys_write+0x3d/0x70  <c0102f1b> sysenter_past_esp+0x54/0x75
Back to C!
BUG: sleeping function called from invalid context 
at /home/bor/src/linux-git/mm/slab.c:2793
in_atomic():0, irqs_disabled():1
 <c010405d> show_trace+0xd/0x10  <c0104607> dump_stack+0x17/0x20
 <c0115f78> __might_sleep+0xa8/0xc0  <c015a249> kmem_cache_alloc+0x59/0x70
 <c01d2b43> acpi_os_acquire_object+0xe/0x3c  <c01e8621> 
acpi_ut_allocate_object_desc_dbg+0x13/0x45
 <c01e866b> acpi_ut_create_internal_object_dbg+0x18/0x6a  <c01e46ba> 
acpi_rs_set_srs_method_data+0x3a/0xaa
 <c01e4092> acpi_set_current_resources+0x1b/0x24  <c01ebcb9> 
acpi_pci_link_set+0xfb/0x174
 <c01ebd69> irqrouter_resume+0x37/0x56  <c020fc54> __sysdev_resume+0x14/0x80
 <c020fe97> sysdev_resume+0x57/0x90  <c0215148> device_power_up+0x8/0x10
 <c0136043> suspend_enter+0x53/0x60  <c0136110> enter_state+0xc0/0x170
 <c0136266> state_store+0xa6/0xb0  <c0196f6b> subsys_attr_store+0x2b/0x40
 <c0197283> sysfs_write_file+0xa3/0x100  <c015dfb9> vfs_write+0x99/0x160
 <c015e5dd> sys_write+0x3d/0x70  <c0102f1b> sysenter_past_esp+0x54/0x75
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKG] -> GSI 11 (level, low) -> 
IRQ 11
PM: Writing back config space on device 0000:00:02.0 at offset f (was 
500001ff, writing 5000010b)
ACPI: PCI Interrupt 0000:00:04.0[A]: no GSI
PM: Writing back config space on device 0000:00:06.0 at offset f (was 
180201ff, writing 1802010b)
PM: Writing back config space on device 0000:00:06.0 at offset 1 (was 2900003, 
writing c2900003)
PM: Writing back config space on device 0000:00:0a.0 at offset f (was 
380801ff, writing 3808010b)
PM: Writing back config space on device 0000:00:10.0 at offset 6 (was 50200, 
writing b0050200)
PM: Writing back config space on device 0000:00:10.0 at offset 1 (was 2100003, 
writing 2100007)
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> 
IRQ 11
pccard: PCMCIA card inserted into slot 0
pcmcia: registering new device pcmcia0.0
eth0: PRI 31 variant 2 version 9.48
eth0: NIC 5 variant 2 version 1.02
eth0: Wireless, io_addr 0x100, irq 11, mac_address 00:02:2D:26:95:6C
PM: Writing back config space on device 0000:00:11.0 at offset 1 (was 4900003, 
writing 4900007)
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> 
IRQ 11
PM: Writing back config space on device 0000:00:11.1 at offset 1 (was 4900003, 
writing 4900007)
ACPI: PCI Interrupt 0000:00:11.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> 
IRQ 11
PM: Writing back config space on device 0000:00:12.0 at offset f (was 1ff, 
writing 10b)
PM: Writing back config space on device 0000:01:00.0 at offset f (was 1ff, 
writing 10b)
pnp: Failed to activate device 00:05.
pnp: Failed to activate device 00:06.
pnp: Device 00:09 activated.
usb usb1: root hub lost power or was reset
Restarting tasks...<4>ATA: abnormal status 0x80 on port 0x1F7
ATA: abnormal status 0x80 on port 0x1F7
ATA: abnormal status 0x80 on port 0x1F7
 done
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: (BMDMA stat 0x80)
ata1.00: tag 0 cmd 0xca Emask 0x2 stat 0x58 err 0x0 (HSM violation)
ata1: soft resetting port
ata1.00: configured for UDMA/33
ata1: EH complete
SCSI device sda: 39070080 512-byte hdwr sectors (20004 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> 
IRQ 11
e100: eth0: e100_probe: addr 0xf7efd000, irq 11, MAC addr 00:00:39:D7:14:A1
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
eth1: PRI 31 variant 2 version 9.48
eth1: NIC 5 variant 2 version 1.02
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNKH] -> GSI 11 (level, low) -> 
IRQ 11
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEsJ2jR6LMutpd94wRApJOAKCpyrz4QahyPhsuGx8vz3+FCCXQBACdEuEw
Ez9vnlzMjYDBgGDHsstrSeI=
=AhoN
-----END PGP SIGNATURE-----
