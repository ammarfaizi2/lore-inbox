Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262327AbSJ0J4y>; Sun, 27 Oct 2002 04:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262328AbSJ0J4y>; Sun, 27 Oct 2002 04:56:54 -0500
Received: from h-66-166-207-249.SNVACAID.covad.net ([66.166.207.249]:8899 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262327AbSJ0J4x>; Sun, 27 Oct 2002 04:56:53 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 27 Oct 2002 02:03:05 -0800
Message-Id: <200210271003.CAA02741@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: PCI routing problems starting around 2.5.40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I've been meaning to debug this problem but have been
busy with other things, so I've decided to post about it before
it gets too old for anyone to remember a potentially relevant changes.

	Somewhere around 2.5.40, my Kapok 1100m notebook computer
(233MHz Pentium II) developed some IRQ problems.  The snd-es1968 PCI
sound driver initialization would basically stop the system for about
thirty seconds and then fail (waiting for an interrupt that never came
I assume).  About half of the time with 2.5.41, initialization of
either of two different CardBus network cards locks up the system.
For kernels after 2.5.41, the system always locks up during boot.
Under 2.5.41, removing either of the network cards causes a kernel
null pointer dereference.  Under 2.5.41, when X windows starts, the
keyboard and mouse go dead for about sixty seconds and then work.

	I'm not completely stuck, as that there are further debugging
steps that I can and eventually will take.  However, I thought I
should post about it to see if it rings a bell for anyone before the
changes in ~2.5.40 become ancient history and in case anyone searche
the archives for a similar problem.  If anyone has any hints on
relevant recent changes, I would of course appreciate hearing about
it.  I have attached the output of lspci and the boot messages in case
it is useful.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

lspci output:

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (AGP disabled) (rev 02)
00:07.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:08.0 VGA compatible controller: S3 Inc. ViRGE/MX+MV (rev 03)
00:0a.0 CardBus bridge: Texas Instruments PCI1220 (rev 02)
00:0a.1 CardBus bridge: Texas Instruments PCI1220 (rev 02)
00:0c.0 Multimedia controller: IBM 3780IDSP [MWave]
00:10.0 Multimedia audio controller: ESS Technology ES1968 Maestro 2
01:00.0 Ethernet controller: Abocom Systems Inc: Unknown device ab02 (rev 11)


Boot messages (truncated) from a successful 2.5.41 boot, except that
the first line was repeated 233 times at the beginning of the kernel
message history:

ALSA sound/pci/es1968.c:661: es1968: ac97 timeout
ALSA sound/pci/ac97/ac97_codec.c:1529: AC'97 0:0 does not respond - RESET [REC_GAIN = 0x0]
PCI: Found IRQ 5 for device 00:10.0
maestro: Configuring ESS Maestro 2 found at IO 0x3000 IRQ 5
maestro:  subvendor id: 0x0003abcd
maestro: not attempting power management.
maestro: AC97 Codec detected: v: 0x414b4d00 caps: 0x0 pwr: 0xf
maestro: 1 channels configured.
maestro: version 0.15 time 03:14:15 Oct 22 2002
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: IRQ 0 for device 00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Assigned IRQ 10 for device 00:0a.0
PCI: Sharing IRQ 10 with 00:0c.0
PCI: IRQ 0 for device 00:0a.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Assigned IRQ 10 for device 00:0a.1
Yenta IRQ list 0ad8, PCI irq10
Socket status: 30000020
Yenta IRQ list 0ad8, PCI irq10
Socket status: 30000006
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
PCI: Assigned IRQ 10 for device 00:07.2
drivers/usb/core/hcd-pci.c: uhci-hcd @ 00:07.2, PCI device 8086:7112
drivers/usb/core/hcd-pci.c: irq 10, io base 0000f300
drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 1
drivers/usb/host/uhci-hcd.c: detected 2 ports
drivers/usb/core/hcd.c: 00:07.2 root hub device address 1
drivers/usb/core/usb.c: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/usb.c: usb_hotplug
drivers/usb/core/usb.c: usb_new_device_Rsmp_d71c93d7 - registering 1-0:0
drivers/usb/core/usb.c: usb_device_probe_Rsmp_136db7f1
drivers/usb/core/usb.c: usb_device_probe_Rsmp_136db7f1 - got id
drivers/usb/core/hub.c: USB hub found at 0
drivers/usb/core/hub.c: 2 ports detected
drivers/usb/core/hub.c: standalone hub
drivers/usb/core/hub.c: ganged power switching
drivers/usb/core/hub.c: global over-current protection
drivers/usb/core/hub.c: Port indicators are not supported
drivers/usb/core/hub.c: power on to power good time: 2ms
drivers/usb/core/hub.c: hub controller current requirement: 0mA
drivers/usb/core/hub.c: local power source is good
drivers/usb/core/hub.c: no over-current condition exists
drivers/usb/core/hub.c: enabling power on all ports
drivers/usb/core/usb.c: usb_hotplug
drivers/usb/host/uhci-hcd.c: f300: suspend_hc
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 96M
agpgart: no supported devices found.
Real Time Clock Driver v1.11
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on loop(7,0), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Intel PCIC probe: not found.
cs: cb_alloc(bus 1): vendor 0x13d1, device 0xab02
PCI: Enabling device 01:00.0 (0000 -> 0003)
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x2f8-0x2ff 0x378-0x37f 0x3f8-0x3ff 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Setting latency timer of device 01:00.0 to 64
divert: allocating divert_blk for eth0
eth0: ADMtek Comet rev 17 at 0xc8929000, 00:E0:98:92:3B:C7, IRQ 10.
VFS: Can't find ext2 filesystem on dev ramdisk(1,1).
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 8Kbytes
TCP: Hash tables configured (established 4096 bind 5461)
Linux IP multicast router 0.06 plus PIM-SM
input: PS/2 Generic Mouse on isa0060/serio1
register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
MTRR: setting reg 1
