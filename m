Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262269AbVAOO2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbVAOO2P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 09:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbVAOO2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 09:28:15 -0500
Received: from adsl-248-16.dsl.uva.nl ([146.50.248.16]:16073 "EHLO
	hogthrob.muppets.hoogervorst.net") by vger.kernel.org with ESMTP
	id S262269AbVAOO1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 09:27:24 -0500
Message-ID: <1898.172.16.1.112.1105799238.squirrel@hogthrob>
Date: Sat, 15 Jan 2005 15:27:18 +0100 (CET)
Subject: Sundance irq problem
From: "J.W. Hoogervorst" <J.W.Hoogervorst@uva.nl>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.5.1 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am experiencing a problem with my DLink DFE-580TX 4 port adapter (in a
machine with some more network interfaces - see below). The moment I load
the sundance driver on any 2.6 kernel and send a single packet out, I get
about 80 interrupts per second. This even happens with init=/bin/bash and
no other device driver loaded for any device on these IRQs, just sundance.
2.4.22-pre6-ac1 with Donald Becker's "sundance.c:v1.11 2/4/2003" works
flawless (I had some problems with the kernel sundance driver in 2.4.x -
but nothing like this, just MAC address silliness etc.), unfortunately
this driver does not compile with 2.6.x, so I could not test with that
driver.

I tried kernels 2.6.0, 2.6.5-rc1, 2.6.8.1 (this one even crashed due to
the exessive amount of interrupts) and now 2.6.11-rc1, all with more or
less the same results.

I also tried disabling acpi in the bios (only moved some IRQ's so they
would be shared by even more devices) and fiddling with acpi=xxx options,
but that didn't help either. This is all on a Transcend TS-ASL3 mainboard.

Can anyone help me correcting this problem?

Thanks.
Jeroen
----------
           CPU0
  0:   15371289          XT-PIC  timer
  1:        570          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:       7402          XT-PIC  uhci_hcd
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:    1283846          XT-PIC  eth6, eth1, eth10
 11:    3168118          XT-PIC  uhci_hcd, eth2, eth8, eth7
 12:    1303245          XT-PIC  eth5, eth0, serial
 14:      55242          XT-PIC  ide0
 15:    1285402          XT-PIC  eth9, eth3, eth4
NMI:          0
LOC:          0
ERR:          0
MIS:          0
----------
00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory
Controller Hub (rev 02)
        Subsystem: Intel Corp. 82815 815 Chipset Host Bridge and Memory
Controller Hub
        Flags: bus master, fast devsel, latency 0
        Capabilities: [88] #09 [f104]

00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphics
Controller] (rev 02) (prog-if 00 [VGA])
        Subsystem: Intel Corp. 82815 CGC [Chipset Graphics Controller]
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 255
        Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Memory at eb100000 (32-bit, non-prefetchable) [size=512K]
        Expansion ROM at <unassigned> [disabled]
        Capabilities: [dc] Power Management version 2

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 02) (prog-if
00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=04, sec-latency=32
        I/O behind bridge: 00008000-0000cfff
        Memory behind bridge: e4000000-eaffffff
        Prefetchable memory behind bridge: eb000000-eb0fffff

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 02)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 02) (prog-if 80
[Master])
        Subsystem: Intel Corp.: Unknown device 2442
        Flags: bus master, medium devsel, latency 0
        I/O ports at f000 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 02)
(prog-if 00 [UHCI])
        Subsystem: Intel Corp. 82801BA/BAM USB (Hub #1)
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at d000 [size=32]

00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 02)
        Subsystem: Intel Corp.: Unknown device 2442
        Flags: medium devsel
        I/O ports at 5000 [size=16]

00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 02)
(prog-if 00 [UHCI])
        Subsystem: Intel Corp.: Unknown device 2442
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at d400 [size=32]

01:09.0 Serial controller: NetMos Technology 222N-2 I/O Card (2S+1P) (rev
01) (prog-if 02 [16550])
        Subsystem: LSI Logic / Symbios Logic: Unknown device 0001
        Flags: medium devsel, IRQ 12
        I/O ports at c000 [size=8]
        I/O ports at c400 [size=8]
        I/O ports at c800 [size=8]
        I/O ports at b000 [size=8]
        I/O ports at b400 [size=8]
        I/O ports at b800 [size=16]

01:0a.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet
Controller (rev 02)
        Subsystem: Intel Corp. PRO/1000 MT Desktop Adapter
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 10
        Memory at ea000000 (32-bit, non-prefetchable) [size=128K]
        Memory at ea020000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at bc00 [size=64]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device.
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-

01:0b.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
(prog-if 00 [Normal decode])
        Flags: bus master, medium devsel, latency 32
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 00008000-00008fff
        Memory behind bridge: e5000000-e6ffffff
        Prefetchable memory behind bridge: 00000000eb000000-00000000eb000000
        Capabilities: [dc] Power Management version 1

01:0c.0 PCI bridge: Intel Corp. 21152 PCI-to-PCI Bridge (prog-if 00
[Normal decode])
        Flags: bus master, medium devsel, latency 32
        Bus: primary=01, secondary=03, subordinate=03, sec-latency=32
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: e7000000-e7ffffff
        Capabilities: [dc] Power Management version 2

01:0d.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
(prog-if 00 [Normal decode])
        Flags: bus master, medium devsel, latency 32
        Bus: primary=01, secondary=04, subordinate=04, sec-latency=32
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: e8000000-e9ffffff
        Capabilities: [dc] Power Management version 1

02:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
05)
        Subsystem: Compaq Computer Corporation NC3122 Fast Ethernet NIC
(dual port)
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at eb000000 (32-bit, prefetchable) [size=4K]
        I/O ports at 8000 [size=32]
        Memory at e6000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 1

02:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
05)
        Subsystem: Compaq Computer Corporation NC3122 Fast Ethernet NIC
(dual port)
        Flags: bus master, medium devsel, latency 32, IRQ 15
        Memory at eb001000 (32-bit, prefetchable) [size=4K]
        I/O ports at 8400 [size=32]
        Memory at e6100000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 1

03:04.0 Ethernet controller: D-Link System Inc DL10050 Sundance Ethernet
(rev 14)
        Subsystem: D-Link System Inc DFE-580TX
        Flags: bus master, medium devsel, latency 32, IRQ 15
        I/O ports at 9000 [size=128]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [50] Power Management version 2

03:05.0 Ethernet controller: D-Link System Inc DL10050 Sundance Ethernet
(rev 14)
        Subsystem: D-Link System Inc DFE-580TX
        Flags: bus master, medium devsel, latency 32, IRQ 12
        I/O ports at 9400 [size=128]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [50] Power Management version 2

03:06.0 Ethernet controller: D-Link System Inc DL10050 Sundance Ethernet
(rev 14)
        Subsystem: D-Link System Inc DFE-580TX
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at 9800 [size=128]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [50] Power Management version 2

03:07.0 Ethernet controller: D-Link System Inc DL10050 Sundance Ethernet
(rev 14)
        Subsystem: D-Link System Inc DFE-580TX
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at 9c00 [size=128]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [50] Power Management version 2

04:04.0 Ethernet controller: Digital Equipment Corporation DECchip
21142/43 (rev 41)
        Subsystem: D-Link System Inc: Unknown device 1112
        Flags: bus master, medium devsel, latency 32, IRQ 12
        I/O ports at a000 [size=128]
        Memory at e9000000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at <unassigned> [disabled] [size=256K]

04:05.0 Ethernet controller: Digital Equipment Corporation DECchip
21142/43 (rev 41)
        Subsystem: D-Link System Inc: Unknown device 1112
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at a400 [size=128]
        Memory at e9001000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at <unassigned> [disabled] [size=256K]

04:06.0 Ethernet controller: Digital Equipment Corporation DECchip
21142/43 (rev 41)
        Subsystem: D-Link System Inc: Unknown device 1112
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at a800 [size=128]
        Memory at e9002000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at <unassigned> [disabled] [size=256K]

04:07.0 Ethernet controller: Digital Equipment Corporation DECchip
21142/43 (rev 41)
        Subsystem: D-Link System Inc: Unknown device 1112
        Flags: bus master, medium devsel, latency 32, IRQ 15
        I/O ports at ac00 [size=128]
        Memory at e9003000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at <unassigned> [disabled] [size=256K]
----------
Linux version 2.6.11-rc1 (jeroen@hoogervorst.net) (gcc version 3.3.2
(Mandrake Linux 10.0 3.3.2-6mdk)) #2 SMP Fri Jan 14 20:51:57 CET
2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
 BIOS-e820: 000000000fef0000 - 000000000fef3000 (ACPI NVS)
 BIOS-e820: 000000000fef3000 - 000000000ff00000 (ACPI data)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
254MB LOWMEM available.
On node 0 totalpages: 65264
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61168 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 IntelR                                ) @ 0x000f6460
ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fef3000
ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fef3040
ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
Built 1 zonelists
Kernel command line: root=/dev/hda1 devfs=mount video=i810fb:off
No local APIC present or hardware disabled
mapped APIC to ffffd000 (01220000)
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 600.028 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 254236k/261056k available (2057k kernel code, 6312k reserved,
1178k data
, 216k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1183.74 BogoMIPS (lpj=591872)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 00803035 80803035 00000000 00000000
00000000
00000000 00000000
CPU: L1 I Cache: 64K (32 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 64K (32 bytes/line)
CPU: After all inits, caps: 00803135 80803035 00000000 00000000 00000000
0000000
0 00000000
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 9c20)
CPU0: Centaur VIA Samuel 2 stepping 02
per-CPU timeslice cutoff: 182.56 usecs.
task migration cache decay timeout: 1 msecs.
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Brought up 1 CPUs
CPU0 attaching sched-domain:
 domain 0: span 1
  groups: 1
  domain 1: span 1
   groups: 1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb190, last bus=4
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041210
    ACPI-1138: *** Error: Method execution failed [\STRC] (Node cfecf800),
AE_AM
L_BUFFER_LIMIT
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0._INI] (Node
cfed37
00), AE_AML_BUFFER_LIMIT
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
PnPBIOS: Disabled by ACPI
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
audit: initializing netlink socket (disabled)
audit(1105782614.831:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i815 Chipset.
agpgart: Maximum main memory to use for agp memory: 202M
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized drm 1.0.0 20040925
intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G chipsets
intelfb: Version 0.9.2
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 2
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: IC25N020ATCS04-0, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ide1: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/1768KiB Cache, CHS=38760/16/63, UDMA(33)
hda: cache flushes not supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 >
libata version 1.10 loaded.
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 16Kbytes
TCP established hash table entries: 8192 (order: 5, 131072 bytes)
TCP bind hash table entries: 8192 (order: 4, 98304 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
NET: Registered protocol family 1
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
kjournald starting.  Commit interval 5 seconds
Mounted devfs on /dev
Freeing unused kernel memory: 216k freed
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:1f.2[D] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1f.2: Intel Corp. 82801BA/BAM USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: irq 11, io base 0xd000
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI interrupt 0000:00:1f.4[C] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:1f.4: Intel Corp. 82801BA/BAM USB (Hub #2)
usb 1-2: new full speed USB device using uhci_hcd and address 2
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci_hcd 0000:00:1f.4: irq 5, io base 0xd400
uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 2-2: new full speed USB device using uhci_hcd and address 2
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.7
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 4 ports detected
usbcore: registered new driver hci_usb
usb 2-2.2: new full speed USB device using uhci_hcd and address 3
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
usbcore: registered new driver usbserial_generic
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for PL-2303
pl2303 2-2.2:1.0: PL-2303 converter detected
usb 2-2.2: PL-2303 converter now attached to ttyUSB0
usbcore: registered new driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver
v0.12
EXT3 FS on hda1, internal journal
Adding 497972k swap on /dev/hda5.  Priority:-1 extents:1
Serial: 8250/16550 driver $Revision: 1.90 $ 52 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 12
PCI: setting IRQ 12 as level-triggered
ACPI: PCI interrupt 0000:01:09.0[A] -> GSI 12 (level, low) -> IRQ 12
ttyS14 at I/O 0xc000 (irq = 12) is a 16550A
ttyS15 at I/O 0xc400 (irq = 12) is a 16550A
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
Linux Tulip driver version 1.1.13-NAPI (May 11, 2002)
ACPI: PCI interrupt 0000:04:04.0[A] -> GSI 12 (level, low) -> IRQ 12
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
eth0: Digital DS21143 Tulip rev 65 at d0960000, 00:80:C8:B9:AF:69, IRQ 12.
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:04:05.0[A] -> GSI 10 (level, low) -> IRQ 10
tulip1:  EEPROM default media type Autosense.
tulip1:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip1:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
eth1: Digital DS21143 Tulip rev 65 at d0962000, 00:80:C8:B9:AF:6A, IRQ 10.
ACPI: PCI interrupt 0000:04:06.0[A] -> GSI 11 (level, low) -> IRQ 11
tulip2:  EEPROM default media type Autosense.
tulip2:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip2:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
eth2: Digital DS21143 Tulip rev 65 at d0964000, 00:80:C8:B9:AF:6B, IRQ 11.
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 15
PCI: setting IRQ 15 as level-triggered
ACPI: PCI interrupt 0000:04:07.0[A] -> GSI 15 (level, low) -> IRQ 15
tulip3:  EEPROM default media type Autosense.
tulip3:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip3:  MII transceiver #1 config 3100 status 7869 advertising 01e1.
eth3: Digital DS21143 Tulip rev 65 at d0966000, 00:80:C8:B9:AF:6C, IRQ 15.
sundance.c:v1.01+LK1.09a 10-Jul-2003  Written by Donald Becker
  http://www.scyld.com/network/sundance.html
ACPI: PCI interrupt 0000:03:04.0[A] -> GSI 15 (level, low) -> IRQ 15
eth4: D-Link DFE-580TX 4 port Server Adapter at 00019000,
00:05:5d:71:9d:3c, IRQ
 15.
eth4: MII PHY found at address 1, status 0x7809 advertising 01e1.
ACPI: PCI interrupt 0000:03:05.0[A] -> GSI 12 (level, low) -> IRQ 12
eth5: D-Link DFE-580TX 4 port Server Adapter at 00019400,
00:05:5d:71:9d:3d, IRQ
 12.
eth5: MII PHY found at address 1, status 0x7809 advertising 01e1.
ACPI: PCI interrupt 0000:03:06.0[A] -> GSI 10 (level, low) -> IRQ 10
eth6: D-Link DFE-580TX 4 port Server Adapter at 00019800,
00:05:5d:71:9d:3e, IRQ
 10.
eth6: MII PHY found at address 1, status 0x7809 advertising 01e1.
ACPI: PCI interrupt 0000:03:07.0[A] -> GSI 11 (level, low) -> IRQ 11
eth7: D-Link DFE-580TX 4 port Server Adapter at 00019c00,
00:05:5d:71:9d:3f, IRQ
 11.
eth7: MII PHY found at address 1, status 0x7809 advertising 01e1.
e100: Intel(R) PRO/100 Network Driver, 3.3.6-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
PCI: 0000:02:04.0 has unsupported PM cap regs version (1)
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
e100: eth8: e100_probe: addr 0xeb000000, irq 11, MAC addr 00:50:8B:B2:CE:8D
PCI: 0000:02:05.0 has unsupported PM cap regs version (1)
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 15 (level, low) -> IRQ 15
e100: eth9: e100_probe: addr 0xeb001000, irq 15, MAC addr 00:50:8B:B2:CE:8E
Intel(R) PRO/1000 Network Driver - version 5.6.10.1-k2
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:01:0a.0[A] -> GSI 10 (level, low) -> IRQ 10
e1000: eth10: e1000_probe: Intel(R) PRO/1000 Network Connection
NET: Registered protocol family 17
Capability LSM initialized
i2c /dev entries driver
Bluetooth: L2CAP ver 2.6
Bluetooth: L2CAP socket layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
Bluetooth: BNEP filters: protocol multicast
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.


