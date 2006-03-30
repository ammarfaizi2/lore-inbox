Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWC3AXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWC3AXM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 19:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWC3AXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 19:23:12 -0500
Received: from spitalnik.net ([86.49.85.240]:15002 "EHLO
	spity-nb.home.spitalnik.net") by vger.kernel.org with ESMTP
	id S1751207AbWC3AXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 19:23:10 -0500
From: Jan Spitalnik <jan@spitalnik.net>
To: linux-kernel@vger.kernel.org
Subject: ACPI assign-busses
Date: Thu, 30 Mar 2006 02:23:13 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200603300223.13530.jan@spitalnik.net>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xTyKEOlaxpc/wRd"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_xTyKEOlaxpc/wRd
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

while playing with 2.6.16-git kernel from today, I've found out following 
message in dmesg:

PCI: Bus #04 (-#07) is hidden behind transparent bridge #02 (-#04) 
(try 'pci=assign-busses')

My notebook is HP nc6120 (Pent-M, ICH6). So i've rebooted with said parameter 
and dmesg changed a bit, finding new "resources" (not sure what's the proper 
terminology :)

Here's a diff before and after adding the parameter (I'm also attaching full 
dmesg output).

--- before	2006-03-29 16:06:36.000000000 +0200
+++ after	2006-03-29 16:09:14.000000000 +0200
@@ -1,4 +1,8 @@
-HP       HPQPpc 0x00001001 MSFT 0x0100000e) @ 0x4f7f7aa8
+@ 0x4f7efc84
+ACPI: FADT (v002 HP     099C     0x00000002 HP   0x00000001) @ 0x4f7efc00
+ACPI: MADT (v001 HP     099C     0x00000001 HP   0x00000001) @ 0x4f7efcb8
+ACPI: MCFG (v001 HP     099C     0x00000001 HP   0x00000001) @ 0x4f7efd14
+ACPI: SSDT (v001 HP       HPQPpc 0x00001001 MSFT 0x0100000e) @ 0x4f7f7aa8
 ACPI: DSDT (v001 HP       DAU00  0x00010000 MSFT 0x0100000e) @ 0x00000000
 ACPI: PM-Timer IO Port: 0x1008
 ACPI: Local APIC address 0xfec01000
@@ -61,8 +65,6 @@
 PCI: Enabled ICH6/i801 SMBus device
 PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
 PCI: Transparent bridge - 0000:00:1e.0
-PCI: Bus #04 (-#07) is hidden behind transparent bridge #02 (-#04) 
(try 'pci=assign-busses')
-Please report the result to linux-kernel to fix this permanently
 ACPI: PCI Interrupt Routing Table [\_SB_.C002._PRT]
 ACPI: PCI Interrupt Routing Table [\_SB_.C002.C068._PRT]
 ACPI: Embedded Controller [C004] (gpe 16) interrupt mode.
@@ -107,7 +109,7 @@
   IO window: 00003400-000034ff
   PREFETCH window: 50000000-51ffffff
   MEM window: 54000000-55ffffff
-PCI: Bus 4, cardbus bridge: 0000:02:06.1
+PCI: Bus 7, cardbus bridge: 0000:02:06.1
   IO window: 00003800-000038ff
   IO window: 00003c00-00003cff
   PREFETCH window: 52000000-53ffffff


-- 
Jan Spitalnik
jan@spitalnik.net

--Boundary-00=_xTyKEOlaxpc/wRd
Content-Type: text/plain;
  charset="us-ascii";
  name="after.dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="after.dmesg"

@ 0x4f7efc84
ACPI: FADT (v002 HP     099C     0x00000002 HP   0x00000001) @ 0x4f7efc00
ACPI: MADT (v001 HP     099C     0x00000001 HP   0x00000001) @ 0x4f7efcb8
ACPI: MCFG (v001 HP     099C     0x00000001 HP   0x00000001) @ 0x4f7efd14
ACPI: SSDT (v001 HP       HPQPpc 0x00001001 MSFT 0x0100000e) @ 0x4f7f7aa8
ACPI: DSDT (v001 HP       DAU00  0x00010000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfec01000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:13 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 4f800000:90800000)
Built 1 zonelists
Kernel command line: ro elevator=cfq video=vesafb:mtrr:ypan lapic quiet splash=silent,fadein,theme:emergence CONSOLE=/dev/tty1 resume2=swap:/dev/hda2 reboot=b vga=791 pci=assign-busses
mapped APIC to ffffd000 (fec01000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 798.183 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1287496k/1302336k available (1704k kernel code, 13668k reserved, 554k data, 156k init, 384832k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1598.60 BogoMIPS (lpj=3197203)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1.86GHz stepping 08
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
ACPI: Subsystem revision 20060127
ACPI Error (evgpeblk-0284): Unknown GPE method type: C20E (name not of form _Lxx or _Exx) [20060127]
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [C002] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.C002] bus is 0
Boot video device is 0000:00:02.0
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1100-113f claimed by ICH6 GPIO
PCI: Enabled ICH6/i801 SMBus device
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.C002._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C002.C068._PRT]
ACPI: Embedded Controller [C004] (gpe 16) interrupt mode.
ACPI: Power Resource [C1A6] (on)
ACPI: Power Resource [C1B5] (on)
ACPI: Power Resource [C1C5] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.C002.C0CC._PRT]
ACPI: PCI Interrupt Link [C0D8] (IRQs 10 *11)
ACPI: PCI Interrupt Link [C0D9] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0DA] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0DB] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0EE] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0EF] (IRQs 10 *11)
ACPI: PCI Interrupt Link [C0F0] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0F1] (IRQs 10 11) *0, disabled.
ACPI: Power Resource [C244] (off)
ACPI: Power Resource [C245] (off)
ACPI: Power Resource [C246] (off)
ACPI: Power Resource [C247] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.0
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
Setting up standard PCI resources
pnp: 00:0b: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0b: ioport range 0x1000-0x107f could not be reserved
pnp: 00:0b: ioport range 0x1100-0x113f has been reserved
pnp: 00:0b: ioport range 0x1200-0x121f has been reserved
initcall at 0xc034d530: pnp_system_init+0x0/0x10(): returned with error code 4
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bus 3, cardbus bridge: 0000:02:06.0
  IO window: 00003000-000030ff
  IO window: 00003400-000034ff
  PREFETCH window: 50000000-51ffffff
  MEM window: 54000000-55ffffff
PCI: Bus 7, cardbus bridge: 0000:02:06.1
  IO window: 00003800-000038ff
  IO window: 00003c00-00003cff
  PREFETCH window: 52000000-53ffffff
  MEM window: 56000000-57ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 3000-3fff
  MEM window: d0000000-d03fffff
  PREFETCH window: 50000000-53ffffff
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 18 (level, low) -> IRQ 17
ACPI: PCI Interrupt 0000:02:06.1[B] -> GSI 19 (level, low) -> IRQ 18
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Initializing Cryptographic API
io scheduler noop registered
io scheduler cfq registered (default)
vesafb: framebuffer at 0xc0000000, mapped to 0xf8880000, using 3072k, total 7872k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [C172] (off-line)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [C1E8]
ACPI: Lid Switch [C1E9]
ACPI: Video Device [C055] (multi-head: yes  rom: no  post: no)
Using specific hotkey driver
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
ACPI: Processor [C000] (supports 8 throttling states)
Real Time Clock Driver v1.12ac
PNP: PS/2 Controller [PNP0303:C1C2,PNP0f13:C1C3] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 16 (level, low) -> IRQ 16
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2580-0x2587, BIOS settings: hda:DMA, hdb:DMA
Probing IDE interface ide0...
hda: HTS541010G9AT00, ATA DISK drive
hdb: MATSHITAUJ-840D, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 512KiB
hda: 195371568 sectors (100030 MB) w/7539KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdb: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
NET: Registered protocol family 1
NET: Registered protocol family 17
initcall at 0xc03403d0: acpi_cpufreq_init+0x0/0x10(): returned with error code -16
Using IPI Shortcut mode
ACPI wakeup devices: 
C068 C0BB C0C2 C0C3 C0C4 C0C5 C0CC C1CD 
ACPI: (supports S0 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 156k freed
Adding 2056312k swap on /dev/hda2.  Priority:-1 extents:1 across:2056312k
EXT3 FS on hda3, internal journal
tg3.c:v3.54 (Mar 23, 2006)
ACPI: PCI Interrupt 0000:02:0e.0[A] -> GSI 16 (level, low) -> IRQ 16
eth0: Tigon3 [partno(BCM95705A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:14:c2:df:d6:51
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1] 
eth0: dma_rwctrl[763f0000] dma_mask[64-bit]
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
ACPI: Fan [C248] (off)
ACPI: Fan [C249] (off)
ACPI: Fan [C24A] (off)
ACPI: Fan [C24B] (off)
ACPI: Thermal Zone [TZ1] (53 C)
ACPI: Thermal Zone [TZ2] (45 C)
ACPI: Thermal Zone [TZ3] (32 C)
ACPI: Thermal Zone [TZ4] (27 C)
ACPI: Battery Slot [C174] (battery present)
ACPI: Battery Slot [C173] (battery absent)
fuse init (API version 7.6)
loop: loaded (max 8 devices)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 21 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1e.2 to 64
intel8x0_measure_ac97_clock: measured 55536 usecs
intel8x0: clocking to 48000
ACPI: PCI Interrupt 0000:00:1e.3[B] -> GSI 22 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1e.3 to 64
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 915GM Chipset.
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xc0000000
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 21, io base 0x00002000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 22, io base 0x00002020
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 17, io base 0x00002040
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 18, io base 0x00002060
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 2-2: new full speed USB device using uhci_hcd and address 2
usb 2-2: configuration #1 chosen from 1 choice
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new driver hci_usb
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 21, io mem 0xd0580000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
usb 2-2: USB disconnect, address 2
usb 2-2: new full speed USB device using uhci_hcd and address 3
usb 2-2: configuration #1 chosen from 1 choice
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.7
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.1.1
ipw2200: Copyright(c) 2003-2006 Intel Corporation
ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 21 (level, low) -> IRQ 19
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ipw2200: Detected geography ZZR (14 802.11bg channels, 0 802.11a channels)
ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 18 (level, low) -> IRQ 17
Yenta: CardBus bridge found at 0000:02:06.0 [103c:099c]
Yenta: Enabling burst memory read transactions
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:06.0, mfunc 0x01aa1b22, devctl 0x64
Yenta: ISA IRQ mask 0x0cf8, PCI irq 17
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x3000 - 0x3fff
pcmcia: parent PCI bridge Memory window: 0xd0000000 - 0xd03fffff
pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x53ffffff
ACPI: PCI Interrupt 0000:02:06.1[B] -> GSI 19 (level, low) -> IRQ 18
Yenta: CardBus bridge found at 0000:02:06.1 [103c:099c]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:06.1, mfunc 0x01aa1b22, devctl 0x64
Yenta: ISA IRQ mask 0x0cf8, PCI irq 18
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x3000 - 0x3fff
pcmcia: parent PCI bridge Memory window: 0xd0000000 - 0xd03fffff
pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x53ffffff
Bridge firewalling registered
00:02: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
input: PC Speaker as /class/input/input1
Synaptics Touchpad, model: 1, fw: 6.2, id: 0x25a0b1, caps: 0xa04793/0x300000
serio: Synaptics pass-through port at isa0060/serio4/input0
input: SynPS/2 Synaptics TouchPad as /class/input/input2
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized i915 1.4.0 20060119 on minor 0

--Boundary-00=_xTyKEOlaxpc/wRd--
