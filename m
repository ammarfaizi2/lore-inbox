Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbUA0Msc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 07:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUA0Msc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 07:48:32 -0500
Received: from [202.42.136.131] ([202.42.136.131]:32652 "EHLO mail.weslab.com")
	by vger.kernel.org with ESMTP id S263584AbUA0MsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 07:48:17 -0500
Message-ID: <40165D61.9030900@weslab.com>
Date: Tue, 27 Jan 2004 20:45:21 +0800
From: WESLAB - Ang Ho Soon <hosoon@weslab.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030731 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB in 2.6.X kernels
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've a problem with 2.6.x (2.6.1, 2.6.1-rc1, 2.6.2-rc1) kernels with 
mine USB hardware. it has a NEC USB 2.0 OHCI based controller. 2.4.x 
don't seem to work as well.

The kernel boots ok but USB debug messages does not point out much error 
except the following line: --> "usb 3-1: control timeout on ep0out" and 
the USB does not work when usb keyboard is plugged in.

I've tried compiling USB (core, hid, ohci, ehci) both within kernel and 
as modules but with all not working.

has anyone experienced USB OHCI host controller problems with new kernels?

I've the following hardware:

scanpci output
----------------------------------------------------------------------
pci bus 0x0000 cardnum 0x00 function 0x00: vendor 0x1279 device 0x0395
  Transmeta Corporation LongRun Northbridge

pci bus 0x0000 cardnum 0x00 function 0x01: vendor 0x1279 device 0x0396
  Transmeta Corporation SDRAM controller

pci bus 0x0000 cardnum 0x00 function 0x02: vendor 0x1279 device 0x0397
  Transmeta Corporation BIOS scratchpad

pci bus 0x0000 cardnum 0x03 function 0x00: vendor 0x10b9 device 0x5451
  ALi Corporation M5451 PCI AC-Link Controller Audio Device

pci bus 0x0000 cardnum 0x06 function 0x00: vendor 0x126f device 0x0712
  Silicon Motion, Inc. SM712 LynxEM+

pci bus 0x0000 cardnum 0x07 function 0x00: vendor 0x10b9 device 0x1533
  ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]

pci bus 0x0000 cardnum 0x0a function 0x00: vendor 0x1317 device 0x0985
  Linksys Network Everywhere Fast Ethernet 10/100 model NC100

pci bus 0x0000 cardnum 0x0b function 0x00: vendor 0x1260 device 0x3890
  Harris Semiconductor  Device unknown

pci bus 0x0000 cardnum 0x0d function 0x00: vendor 0x1033 device 0x0035
  NEC Corporation USB

pci bus 0x0000 cardnum 0x0d function 0x01: vendor 0x1033 device 0x0035
  NEC Corporation USB

pci bus 0x0000 cardnum 0x0d function 0x02: vendor 0x1033 device 0x00e0
  NEC Corporation USB 2.0

pci bus 0x0000 cardnum 0x0e function 0x00: vendor 0x1180 device 0x0476
  Ricoh Co Ltd RL5c476 II

pci bus 0x0000 cardnum 0x0e function 0x01: vendor 0x1180 device 0x0476
  Ricoh Co Ltd RL5c476 II

pci bus 0x0000 cardnum 0x10 function 0x00: vendor 0x10b9 device 0x5229
  ALi Corporation M5229 IDE

pci bus 0x0000 cardnum 0x11 function 0x00: vendor 0x10b9 device 0x7101
  ALi Corporation M7101 PMU


dmesg output (front part truncated)
----------------------------------------------------------------------
kernel 2.6.2-rc1

000000000e7f0000 - 000000000e7fe000 (ACPI data)
  BIOS-e820: 000000000e7fe000 - 000000000e800000 (ACPI NVS)
  BIOS-e820: 000000000e800000 - 000000000e900000 (reserved)
  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
231MB LOWMEM available.
On node 0 totalpages: 59376
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 55280 pages, LIFO batch:13
   HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7f60
ACPI: RSDT (v001 PTLTD    RSDT   0x06040005  LTP 0x00000000) @ 0x0e7fafa1
ACPI: FADT (v001 TMETA  PDB.ALI  0x06040005 PTL  0x000f4240) @ 0x0e7fde6a
ACPI: SSDT (v001 PTLTD  ACPIPST1 0x06040005  LTP 0x00000001) @ 0x0e7fdede
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040005  LTP 0x00000001) @ 0x0e7fdfd8
ACPI: DSDT (v001     TM PDBALI35 0x06040005 MSFT 0x0100000e) @ 0x00000000
Building zonelist for node : 0
Kernel command line: root=/dev/hda1
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 742.086 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 231128k/237504k available (2161k kernel code, 5656k reserved, 
804k data, 136k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1138.68 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0080893f 0081813f 00000000 00000000
CPU:     After vendor identify, caps: 0080893f 0081813f 000001ce 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 512K (128 bytes/line)
CPU: Processor revision 1.4.1.0, 733 MHz
CPU: Code Morphing Software revision 4.4.3-10-184
CPU: 20030618 15:27 official release 4.4.3#1
CPU:     After all inits, caps: 0080893f 0081813f 000001ce 00000000
CPU: Transmeta(tm) Crusoe(tm) Processor TM5800 stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd88c, last bus=0
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *5)
ACPI: PCI Interrupt Link [LNKC] (IRQs 7)
ACPI: PCI Interrupt Link [LNKD] (IRQs *7)
ACPI: PCI Interrupt Link [LNKE] (IRQs 5 7 10)
ACPI: PCI Interrupt Link [LNKF] (IRQs 5 7 10)
ACPI: PCI Interrupt Link [LNKG] (IRQs 5 6 7 10)
ACPI: PCI Interrupt Link [LNKH] (IRQs *5)
ACPI: PCI Interrupt Link [LNKU] (IRQs 11)
ACPI: Embedded Controller [EC0] (gpe 1)
Linux Kernel Card Services
   options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 7
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0 - using 
IRQ 255
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
ikconfig 0.7 with /proc/config*
NTFS driver 2.1.6 [Flags: R/O].
Activating ISA DMA hang workarounds.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
fakephp: Fake PCI Hot Plug Controller Driver
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Using anticipatory io scheduler
nbd: registered device at major 43
Loaded prism54 driver, version 1.0.2.2
PCI: Enabling device 0000:00:0b.0 (0010 -> 0012)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: TOSHIBA THNCF256MMA, CFA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 500736 sectors (256 MB) w/2KiB Cache, CHS=978/16/32
  hda: hda1
Yenta: CardBus bridge found at 0000:00:0e.0 [0000:0000]
Yenta: ISA IRQ mask 0x0898, PCI irq 10
Socket status: 30000006
Yenta: CardBus bridge found at 0000:00:0e.1 [0000:0000]
irq 5: nobody cared!
Call Trace:
  [<c010c8fa>] __report_bad_irq+0x2a/0x90
  [<c010c9f0>] note_interrupt+0x70/0xb0
  [<c010ccb0>] do_IRQ+0x130/0x140
  [<c010af88>] common_interrupt+0x18/0x20
  [<c0125190>] run_timer_softirq+0x0/0x1b0
  [<c0120da5>] do_softirq+0x95/0xa0
  [<c010cc87>] do_IRQ+0x107/0x140
  [<c010af88>] common_interrupt+0x18/0x20
  [<c010d29e>] setup_irq+0x9e/0xf0
  [<c027a9a0>] yenta_interrupt+0x0/0x40
  [<c010cda6>] request_irq+0xa6/0xe0
  [<c027be7e>] yenta_probe+0x18e/0x250
  [<c027a9a0>] yenta_interrupt+0x0/0x40
  [<c01f6b12>] pci_device_probe_static+0x52/0x70
  [<c01f6b6c>] __pci_device_probe+0x3c/0x50
  [<c01f6bac>] pci_device_probe+0x2c/0x50
  [<c0237fff>] bus_match+0x3f/0x70
  [<c023812c>] driver_attach+0x5c/0x90
  [<c02383dd>] bus_add_driver+0x8d/0xa0
  [<c023882f>] driver_register+0x2f/0x40
  [<c025c6d7>] ide_register_driver+0xf7/0x120
  [<c01f6d9c>] pci_register_driver+0x5c/0x90
  [<c03fa74f>] yenta_socket_init+0xf/0x20
  [<c03e87cb>] do_initcalls+0x2b/0xa0
  [<c012cf8f>] init_workqueues+0xf/0x30
  [<c01050cd>] init+0x2d/0x130
  [<c01050a0>] init+0x0/0x130
  [<c0108cb9>] kernel_thread_helper+0x5/0xc

handlers:
[<c027a9a0>] (yenta_interrupt+0x0/0x40)
Disabling IRQ #5
Yenta: ISA IRQ mask 0x0898, PCI irq 5
Socket status: 30000006
mice: PS/2 mouse device common for all mice
ts: Compaq touchscreen protocol output
evbug.c: Connected device: "PC Speaker", isa0061/input0
input: PC Speaker
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 
19:16:36 2003 UTC).
PCI: Enabling device 0000:00:03.0 (0000 -> 0003)
ALSA device list:
   #0: ALI 5451 at 0x1400, irq 5
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
BIOS EDD facility v0.10 2003-Oct-11, 1 devices found
Please report your BIOS at http://domsch.com/linux/edd30/results.html
  hda: hda1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 136k freed
EXT3 FS on hda1, internal journal
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 64
ehci_hcd 0000:00:0d.2: EHCI Host Controller
ehci_hcd 0000:00:0d.2: reset hcs_params 0x2395 dbg=0 cc=2 pcc=3 ports=5
ehci_hcd 0000:00:0d.2: reset portroute 1 0 1 0 0
ehci_hcd 0000:00:0d.2: reset hcc_params e806 thresh 0 uframes 
256/512/1024 park
ehci_hcd 0000:00:0d.2: capability 0001 at e8
ehci_hcd 0000:00:0d.2: irq 7, pci mem cf01d400
ehci_hcd 0000:00:0d.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:0d.2: reset command 080b22 park=3 ithresh=8 Async 
period=1024 Reset HALT
ehci_hcd 0000:00:0d.2: init command 010b09 park=3 ithresh=1 period=256 RUN
ehci_hcd 0000:00:0d.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
ehci_hcd 0000:00:0d.2: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.2-rc1-tx2000 ehci_hcd
usb usb1: SerialNumber: 0000:00:0d.2
drivers/usb/core/usb.c: usb_hotplug
usb usb1: registering 1-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: individual port power switching
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times
hub 1-0:1.0: Port indicators are not supported
hub 1-0:1.0: power on to power good time: 0ms
hub 1-0:1.0: hub controller current requirement: 0mA
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports
ehci_hcd 0000:00:0d.2: GetStatus port 2 status 001803 POWER sig=j  CSC 
CONNECT
hub 1-0:1.0: port 2, status 501, change 1, 480 Mb/s
hub 1-0:1.0: debounce: port 2: delay 100ms stable 4 status 0x501
ehci_hcd 0000:00:0d.2: port 2 full speed --> companion
ehci_hcd 0000:00:0d.2: GetStatus port 2 status 003801 POWER OWNER sig=j 
  CONNECT
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:0d.0: OHCI Host Controller
ohci_hcd 0000:00:0d.0: reset, control = 0x97
ohci_hcd 0000:00:0d.0: irq 5, pci mem cf034000
ohci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:0d.0: root hub device address 1
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.2-rc1-tx2000 ohci_hcd
usb usb2: SerialNumber: 0000:00:0d.0
drivers/usb/core/usb.c: usb_hotplug
usb usb2: registering 2-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: ganged power switching
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: Port indicators are not supported
hub 2-0:1.0: power on to power good time: 30ms
hub 2-0:1.0: hub controller current requirement: 0mA
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: enabling power on all ports
ohci_hcd 0000:00:0d.0: created debug files
ohci_hcd 0000:00:0d.0: OHCI controller state
ohci_hcd 0000:00:0d.0: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:0d.0: control 0x08f HCFS=operational IE PLE CBSR=3
ohci_hcd 0000:00:0d.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:0d.0: intrstatus 0x00000004 SF
ohci_hcd 0000:00:0d.0: intrenable 0x80000012 MIE UE WDH
ohci_hcd 0000:00:0d.0: hcca frame #01be
ohci_hcd 0000:00:0d.0: roothub.a 0f000203 POTPGT=15 NPS NDP=3
ohci_hcd 0000:00:0d.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:0d.0: roothub.status 00000000
ohci_hcd 0000:00:0d.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:0d.0: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:0d.0: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:0d.1: OHCI Host Controller
ohci_hcd 0000:00:0d.1: reset, control = 0x97
ohci_hcd 0000:00:0d.1: irq 5, pci mem cf036000
ehci_hcd 0000:00:0d.2: GetStatus port 2 status 001803 POWER sig=j  CSC 
CONNECT
hub 1-0:1.0: port 2, status 501, change 1, 480 Mb/s
ohci_hcd 0000:00:0d.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:0d.1: root hub device address 1
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb3: Product: OHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.2-rc1-tx2000 ohci_hcd
usb usb3: SerialNumber: 0000:00:0d.1
drivers/usb/core/usb.c: usb_hotplug
usb usb3: registering 3-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: ganged power switching
hub 3-0:1.0: global over-current protection
hub 3-0:1.0: Port indicators are not supported
hub 3-0:1.0: power on to power good time: 30ms
hub 3-0:1.0: hub controller current requirement: 0mA
hub 3-0:1.0: local power source is good
hub 3-0:1.0: no over-current condition exists
hub 3-0:1.0: enabling power on all ports
hub 1-0:1.0: debounce: port 2: delay 100ms stable 4 status 0x501
ohci_hcd 0000:00:0d.1: created debug files
ohci_hcd 0000:00:0d.1: OHCI controller state
ohci_hcd 0000:00:0d.1: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:0d.1: control 0x08f HCFS=operational IE PLE CBSR=3
ohci_hcd 0000:00:0d.1: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:0d.1: intrstatus 0x00000004 SF
ohci_hcd 0000:00:0d.1: intrenable 0x80000012 MIE UE WDH
ohci_hcd 0000:00:0d.1: hcca frame #01a4
ohci_hcd 0000:00:0d.1: roothub.a 0f000202 POTPGT=15 NPS NDP=2
ohci_hcd 0000:00:0d.1: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:0d.1: roothub.status 00000000
ohci_hcd 0000:00:0d.1: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:0d.1: roothub.portstatus [1] 0x00000100 PPS
ehci_hcd 0000:00:0d.2: port 2 full speed --> companion
ehci_hcd 0000:00:0d.2: GetStatus port 2 status 003801 POWER OWNER sig=j 
  CONNECT
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
ohci_hcd 0000:00:0d.1: GetStatus roothub.portstatus [1] = 0x00010101 CSC 
PPS CCS
hub 3-0:1.0: port 1, status 101, change 1, 12 Mb/s
hub 3-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x101
ohci_hcd 0000:00:0d.1: GetStatus roothub.portstatus [1] = 0x00100103 
PRSC PPS PES CCS
hub 3-0:1.0: new USB device on port 1, assigned address 2
eth0: islpci_open()
eth0: resetting device...
eth0: uploading firmware...
eth0: firmware uploaded done, now triggering reset...
eth0: prism54_mib_init()
eth0: done with prism54_mib_init()! -- Client Managed mode
request_module: failed /sbin/modprobe -- net-pf-4. error = 256
eth0: prism54_mib_init()
eth0: done with prism54_mib_init()! -- Client Managed mode
usb 3-1: control timeout on ep0out
ohci_hcd 0000:00:0d.1: Unlink after no-IRQ?  Different ACPI or APIC 
settings may help.
TRAP: oid 0x18000001, device 2, flags 0x0 length 12
TRAP: oid 0x18000003, device 2, flags 0x0 length 12
TRAP: oid 0x1, device 2, flags 0x0 length 4
TRAP: oid 0x18000001, device 2, flags 0x0 length 12
TRAP: oid 0x1800000b, device 2, flags 0x0 length 12
TRAP: oid 0x1, device 2, flags 0x0 length 4
TRAP: oid 0x18000001, device 2, flags 0x0 length 12
TRAP: oid 0x18000003, device 2, flags 0x0 length 12
TRAP: oid 0x1, device 2, flags 0x0 length 4
request_module: failed /sbin/modprobe -- net-pf-10. error = 256
TRAP: oid 0x18000001, device 2, flags 0x0 length 12
TRAP: oid 0x1800000b, device 2, flags 0x0 length 12
TRAP: oid 0x1, device 2, flags 0x0 length 4
TRAP: oid 0x18000001, device 2, flags 0x0 length 12
TRAP: oid 0x1800000b, device 2, flags 0x0 length 12
TRAP: oid 0x1, device 2, flags 0x0 length 4
request_module: failed /sbin/modprobe -- char-major-4-65. error = 256
-- 

Sincerely,

Ang Ho Soon
hosoon@weslab.com

