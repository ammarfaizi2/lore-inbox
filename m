Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbVJaRy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbVJaRy6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 12:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbVJaRy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 12:54:58 -0500
Received: from mail02.hansenet.de ([213.191.73.62]:26527 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S932479AbVJaRy5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 12:54:57 -0500
Date: Mon, 31 Oct 2005 18:54:49 +0100
From: Felix Braun <Felix.Braun@mail.mcgill.ca>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.14 Oops in vfs_readdir()
Message-ID: <20051031185449.62f27844@tilion.getrex.org>
Organization: Vectrix -- Legal Department
X-Mailer: Sylpheed-Claws 1.9.99-rc2 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I'm able to Oops my vanilla 2.6.14 kernel pretty reliably when starting
hald 0.5.4. The catch is: the Oops only occurs with a likelyhood of
approx. 60%. I have no idea what introduces this randomness, so it may
just be faulty hardware. However, the system is stable if I don't run hald.

The same behaviour is also present in kernel 2.6.13.4. I will try to
compile a few older kernels later to see whether this is a regression.

Anyway I'm attaching Oops output, ksymoops output, and dmesg. I have time
to do further debugging if instructed what to do next.

Thanks for your help
Felix

======

Oops: 0000 [#1]
Modules linked in: lp
CPU:    0
EIP:    0060:[<c018ab7a>]    Not tainted VLI
EFLAGS: 00010286   (2.6.14)
EIP is at sysfs_readdir+0xca/0x220
eax: 00000000   ebx: dfafb7d0   ecx: 00000008   edx: dfafb7cc
esi: dfafb7cc   edi: df2aae45   ebp: df2aae3c   esp: df3c9f28
ds: 007b   es: 007b   ss: 0068
Process hald (pid: 9617, threadinfo=df3c8000 task=df67d600)
Stack: dfafb7cc dee6d7dc 00000005 0000000d 00000000 000020ef 00000004
dff32cb0 00000008 dfafb398 c152a6f8 dfaba260 fffffffe dfaba260 c0166a7f
dfaba260 df3c9f98 c0166d70 00001000 08087d0c fffffff7 c0166ee2 dfaba260
c0166d70 Call Trace:
 [<c0166a7f>] vfs_readdir+0x8f/0xb0
 [<c0166d70>] filldir64+0x0/0xf0
 [<c0166ee2>] sys_getdents64+0x82/0xe2
 [<c0166d70>] filldir64+0x0/0xf0
 [<c0102d6f>] sysenter_past_esp+0x54/0x75
Code: 00 89 34 24 e8 b8 e5 ff ff 89 c5 b9 ff ff ff ff 31 c0 89 ef f2 ae f7
d1 49 89 4c 24 20 8b 46 20 85 c0 0f 84 31 01 00 00 8b 40 08 <8b> 50 20 0f
b7 46 1c 8b 4c 24 3c 89 54 24 14 66 c1 e8 0c 83 e0

CPU:    0
EIP:    0060:[<c018ab7a>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286   (2.6.14)
eax: 00000000   ebx: dfafb7d0   ecx: 00000008   edx: dfafb7cc
esi: dfafb7cc   edi: df2aae45   ebp: df2aae3c   esp: df3c9f28
ds: 007b   es: 007b   ss: 0068
Stack: dfafb7cc dee6d7dc 00000005 0000000d 00000000 000020ef 00000004
dff32cb0 00000008 dfafb398 c152a6f8 dfaba260 fffffffe dfaba260 c0166a7f
dfaba260 df3c9f98 c0166d70 00001000 08087d0c fffffff7 c0166ee2 dfaba260
c0166d70 Call Trace:
 [<c0166a7f>] vfs_readdir+0x8f/0xb0
 [<c0166d70>] filldir64+0x0/0xf0
 [<c0166ee2>] sys_getdents64+0x82/0xe2
 [<c0166d70>] filldir64+0x0/0xf0
 [<c0102d6f>] sysenter_past_esp+0x54/0x75
Code: 00 89 34 24 e8 b8 e5 ff ff 89 c5 b9 ff ff ff ff 31 c0 89 ef f2 ae f7
d1 49


>>EIP; c018ab7a <sysfs_readdir+ca/220>   <=====

>>ebx; dfafb7d0 <pg0+1f6a57d0/3fba8400>
>>edx; dfafb7cc <pg0+1f6a57cc/3fba8400>
>>esi; dfafb7cc <pg0+1f6a57cc/3fba8400>
>>edi; df2aae45 <pg0+1ee54e45/3fba8400>
>>ebp; df2aae3c <pg0+1ee54e3c/3fba8400>
>>esp; df3c9f28 <pg0+1ef73f28/3fba8400>

Trace; c0166a7f <vfs_readdir+8f/b0>
Trace; c0166d70 <filldir64+0/f0>
Trace; c0166ee2 <sys_getdents64+82/e2>
Trace; c0166d70 <filldir64+0/f0>
Trace; c0102d6f <sysenter_past_esp+54/75>

Code;  c018ab7a <sysfs_readdir+ca/220>
00000000 <_EIP>:
Code;  c018ab7a <sysfs_readdir+ca/220>   <=====
   0:   00 89 34 24 e8 b8         add    %cl,0xb8e82434(%ecx)   <=====
Code;  c018ab80 <sysfs_readdir+d0/220>
   6:   e5 ff                     in     $0xff,%eax
Code;  c018ab82 <sysfs_readdir+d2/220>
   8:   ff 89 c5 b9 ff ff         decl   0xffffb9c5(%ecx)
Code;  c018ab88 <sysfs_readdir+d8/220>
   e:   ff                        (bad)  
Code;  c018ab89 <sysfs_readdir+d9/220>
   f:   ff 31                     pushl  (%ecx)
Code;  c018ab8b <sysfs_readdir+db/220>
  11:   c0 89 ef f2 ae f7 d1      rorb   $0xd1,0xf7aef2ef(%ecx)
Code;  c018ab92 <sysfs_readdir+e2/220>
  18:   49                        dec    %ecx

Linux version 2.6.14 (root@tilion) (gcc-Version 3.4.4 (Gentoo 3.4.4-r1))
#14 Fri Oct 28 11:01:18 CEST 2005 BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126972 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6490
ACPI: RSDT (v001 ASUS   A7V8X    0x42302e31 MSFT 0x31313031) @ 0x1fffc000
ACPI: FADT (v001 ASUS   A7V8X    0x42302e31 MSFT 0x31313031) @ 0x1fffc0b2
ACPI: BOOT (v001 ASUS   A7V8X    0x42302e31 MSFT 0x31313031) @ 0x1fffc030
ACPI: MADT (v001 ASUS   A7V8X    0x42302e31 MSFT 0x31313031) @ 0x1fffc058
ACPI: DSDT (v001   ASUS A7V8X    0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Built 1 zonelists
Kernel command line: parport=0x378,7,3
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1350.693 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515320k/524272k available (2389k kernel code, 8352k reserved, 689k
data, 164k init, 0k highmem) Checking if this processor honours the WP bit
even in supervisor mode... Ok. Calibrating delay using timer specific
routine.. 2703.50 BogoMIPS (lpj=1351754) Mount-cache hash table entries:
512 CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
00000000 00000000 00000000 CPU: After vendor identify, caps: 0383fbff
c1c3fbff 00000000 00000000 00000000 00000000 00000000 CPU: L1 I Cache: 64K
(64 bytes/line), D cache 64K (64 bytes/line) CPU: L2 Cache: 256K (64
bytes/line) CPU: After all inits, caps: 0383fbff c1c3fbff 00000000
00000020 00000000 00000000 00000000 Intel machine check architecture
supported. Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: AMD Athlon(TM) XP 2200+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
softlockup thread 0 started up.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf1ad0, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled. ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15)
*0, disabled. ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14
15) *0, disabled. ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 10 11
12 14) ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region e400-e47f claimed by vt8235 PM
PCI quirk: region e800-e80f claimed by vt8235 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report pnp: 00:01: ioport range 0xe400-0xe47f could not be reserved
pnp: 00:01: ioport range 0xe800-0xe81f could not be reserved
pnp: 00:0d: ioport range 0x290-0x291 has been reserved
pnp: 00:0d: ioport range 0x370-0x372 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: e6000000-e75fffff
  PREFETCH window: e7700000-efffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
Simple Boot Flag at 0x3a set to 0x1
Machine check exception polling timer started.
NTFS driver 2.1.24 [Flags: R/O].
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: CPU0 (power states: C1[C1])
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 (0x778), irq 7, dma 3
[PCSPP,TRISTATE,COMPAT,ECP,DMA] parport0: faking semi-colon
parport0: Printer, Hewlett-Packard HP LaserJet 1100
io scheduler noop registered
io scheduler anticipatory registered
b44.c:v0.95 (Aug 3, 2004)
PCI: Enabling device 0000:00:09.0 (0004 -> 0006)
ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 18 (level, low) -> IRQ 16
eth0: Broadcom 4400 10/100BaseT Ethernet 00:e0:18:e0:c5:ff
PPP generic driver version 2.4.2
NET: Registered protocol family 24
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt 0000:00:11.1[A]: no GSI
PCI: Via IRQ fixup for 0000:00:11.1, from 255 to 15
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: ST380021A, ATA DISK drive
hdb: SAMSUNG SP2014N, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: RW-481248 1.07, ATAPI CD/DVD-ROM drive
hdd: IDE DVD-ROM 16X, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63,
UDMA(100) hda: cache flushes not supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 >
hdb: max request size: 1024KiB
hdb: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63,
UDMA(100) hdb: cache flushes supported
 hdb: hdb1
hdc: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
usbmon: debugfs is not available
ACPI: PCI Interrupt 0000:00:10.3[D] -> GSI 21 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:10.3, from 0 to 1
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.3: irq 17, io mem 0xe5000000
ehci_hcd 0000:00:10.3: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:10.0, from 0 to 1
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 17, io base 0x0000d800
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[B] -> GSI 21 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:10.1, from 0 to 1
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 17, io base 0x0000d400
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[C] -> GSI 21 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:10.2, from 0 to 1
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 17, io base 0x0000d000
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12
08:13:09 2005 UTC). ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level,
low) -> IRQ 18 PCI: Via IRQ fixup for 0000:00:11.5, from 0 to 2
PCI: Setting latency timer of device 0000:00:11.5 to 64
input: ImExPS/2 Logitech Wheel Mouse on isa0060/serio1
usb 3-2: new full speed USB device using uhci_hcd and address 2
ALSA device list:
  #0: VIA 8235 with ALC650E at 0xe000, irq 18
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 5, 131072 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
ip_tables: (C) 2000-2002 Netfilter core team
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Using IPI Shortcut mode
kjournald starting.  Commit interval 5 seconds
EXT3-fs: hda6: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 197465
ext3_orphan_cleanup: deleting unreferenced inode 197454
ext3_orphan_cleanup: deleting unreferenced inode 197450
EXT3-fs: hda6: 3 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 164k freed
Adding 995988k swap on /dev/hda7.  Priority:-1 extents:1 across:995988k
EXT3 FS on hda6, internal journal
lp0: using parport0 (interrupt-driven).
NTFS volume version 3.1.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
cdrom: open failed.
cdrom: open failed.
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is off for TX and off for RX.
lp0: ECP mode


-- 
Felix Braun
