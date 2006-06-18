Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWFRR3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWFRR3U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 13:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWFRR3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 13:29:20 -0400
Received: from mx27.mail.ru ([194.67.23.63]:56668 "EHLO mx27.mail.ru")
	by vger.kernel.org with ESMTP id S932270AbWFRR3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 13:29:19 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] 2.6.17: dmesg flooded with "ohci_hcd 0000:00:02.0: wakeup"
Date: Sun, 18 Jun 2006 21:29:14 +0400
User-Agent: KMail/1.9.3
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200606181919.51126.arvidjaar@mail.ru> <200606180929.23119.david-b@pacbell.net>
In-Reply-To: <200606180929.23119.david-b@pacbell.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606182129.15712.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 18 June 2006 20:29, David Brownell wrote:
> On Sunday 18 June 2006 8:19 am, Andrey Borzenkov wrote:
> > After reboot with 2.6.17 dmesg is overflowed with the above. 2.6.16.20
> > was OK. Please let me know what additional information may be useful; for
> > now I simply commented out this printk. dmesg, lsusb and lspci follow.
>
> The printk means you're getting more IRQs than would be good.
> Did you apply any patches to this, e.g. from the MM tree?
>

no.

> An alternative (but post-boot) workaround _should_ be
>
>     echo disabled > /sys/bus/pci/devices/0000:00:02.0/power/wakeup
>
> Looks like this is an old ALI-based motherboard with only one USB
> controller; this might be a hardware problem, some others from
> that era had problems handling USB suspend states.  In your case
> (no USB devices hooked up here, right?) maybe this problem can
> be automagically detected and worked around.
>

This is Tohiba Portege 4000 notebook. So far I did not have any USB related 
issues at least since 2.6.12. And true, I do not have any devices plugged in.

> What would be most useful in this case -- and is ISTR one of
> the FAQs for "how to report USB problems" -- is rebuilding
> with CONFIG_USB_DEBUG and sending the boot log, so I can see
> how that OHCI controller comes up in more detail than you've
> provided here.
>

Here you are. I am still puzzled where all these "suspends" come from - I did 
not try any suspend in the meantime ...

- -andrey


ble entries: 32768 (order: 5, 131072 bytes)
Memory: 499180k/507264k available (1663k kernel code, 7456k reserved, 795k 
data, 176k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1496.80 BogoMIPS (lpj=748402)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0387f9ff 00000000 00000000 00000000 
00000000 00000000 00000000
CPU: After vendor identify, caps: 0387f9ff 00000000 00000000 00000000 00000000 
00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
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
Freeing initrd memory: 230k freed
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
audit(1150650880.535:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
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
Freeing unused kernel memory: 176k freed
Write protecting the kernel read-only data: 516k
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
input: AT Translated Set 2 keyboard as /class/input/input0
ALI15X3: IDE controller at PCI slot 0000:00:04.0
ACPI: PCI Interrupt 0000:00:04.0[A]: no GSI
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xeff0-0xeff7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xeff8-0xefff, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IC25N020ATDA04-0, ATA DISK drive
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/1806KiB Cache, CHS=38760/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKG] -> GSI 11 (level, low) -> 
IRQ 11
ohci_hcd 0000:00:02.0: OHCI Host Controller
/home/bor/src/linux-git/drivers/usb/core/inode.c: creating file 'devices'
/home/bor/src/linux-git/drivers/usb/core/inode.c: creating file '001'
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: created debug files
ohci_hcd 0000:00:02.0: irq 11, io mem 0xf7eff000
ohci_hcd 0000:00:02.0: resetting from state 'reset', control = 0x0
ohci_hcd 0000:00:02.0: enabling initreset quirk
ohci_hcd 0000:00:02.0: OHCI controller state
ohci_hcd 0000:00:02.0: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:02.0: control 0x083 HCFS=operational CBSR=3
ohci_hcd 0000:00:02.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.0: intrstatus 0x00000044 RHSC SF
ohci_hcd 0000:00:02.0: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.0: hcca frame #0003
ohci_hcd 0000:00:02.0: roothub.a 01000203 POTPGT=1 NPS NDP=3(3)
ohci_hcd 0000:00:02.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [2] 0x00000100 PPS
usb usb1: default language 0x0409
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.17-2avb ohci_hcd
usb usb1: SerialNumber: 0000:00:02.0
usb usb1: uevent
usb usb1: configuration #1 chosen from 1 choice
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: uevent
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
/home/bor/src/linux-git/drivers/usb/core/inode.c: creating file '001'
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected ALi M1644 chipset
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
agpgart: AGP aperture is 64M @ 0xf0000000
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> 
IRQ 11
Yenta: CardBus bridge found at 0000:00:10.0 [12a3:ab01]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:10.0, mfunc 0x01000002, devctl 0x60
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
Yenta: ISA IRQ mask 0x0000, PCI irq 11
Socket status: 30000059
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> 
IRQ 11
Yenta: CardBus bridge found at 0000:00:11.0 [1179:0001]
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000007
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
pccard: PCMCIA card inserted into slot 0
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcbfff 0xe0000-0xfffff
cs: memory probe 0x60000000-0x60ffffff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
pcmcia: registering new device pcmcia0.0
ACPI: PCI Interrupt 0000:00:11.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> 
IRQ 11
Yenta: CardBus bridge found at 0000:00:11.1 [1179:0001]
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
wlags49_h1_cs v7.18 for PCMCIA, 03/31/2004 14:31:00 by Agere Systems, 
http://www.agere.com
*** Modified for kernel 2.6 by Andrey Borzenkov <arvidjaar@mail.ru> $Revision: 
22 $
*** Station Mode (STA) Support: YES
*** Access Point Mode (AP) Support: YES
eth0: PRI 31 variant 2 version 9.48
eth0: NIC 5 variant 2 version 1.02
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
eth0: Wireless, io_addr 0x100, irq 11, mac_address 00:02:2D:26:95:6C
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000007
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN] (off)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THRM] (56 C)
toshiba_acpi: Toshiba Laptop ACPI Extras version 0.18
toshiba_acpi:     HCI method: \_SB_.VALD.GHCI
ACPI: Video Device [VGA] (multi-head: yes  rom: yes  post: no)
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
Adding 500432k swap on /dev/hda1.  Priority:-1 extents:1 across:500432k
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
loop: loaded (max 8 devices)
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
hdc: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
ohci_hcd 0000:00:02.0: suspend root hub
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFElY1rR6LMutpd94wRArYJAJ9wJyt8wZsdmtVx5nHBYlTrGZkYPwCgwhjC
+43GSMQZlzRyb1CKdcGCFT4=
=H9TZ
-----END PGP SIGNATURE-----
