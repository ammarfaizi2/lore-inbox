Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVCNKd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVCNKd3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 05:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVCNKd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 05:33:29 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:26702 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S262109AbVCNKcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 05:32:32 -0500
Message-ID: <4235683E.1020403@tls.msk.ru>
Date: Mon, 14 Mar 2005 13:32:30 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: mouse&keyboard with 2.6.10+
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticied a weird problem with input subsystem (mostly
mouse) which happens on my boxes with 2.6.10 and 2.6.11+
kernels (up to current 2.6.11.3), which didn't happen with
earlier kernels.

First issue is that psmouse module takes about 10 sec to
load (to detect the mouse), which was done instantly with
older kernels.  Not a very big problem ofcourse, but looks
like it is indicating some more deep problem.

2.6.10 almost works, but sometimes, the whole input
subsystem just "hungs", ie, both keyboard and mouse
just stops working.  Plugging in USB keyboard and
loading usbhid module solves the problem - both
keyboards and the mouse works after that, and I
didn't yet notice the problem repeats after usbhid
and usb keyboard is loaded.  I wasn't able to
determine when the problem occurs, for me it seems
it hangs at some "random" point - sometimes after
5 minutes after boot, sometimes after a hour or
so.

And 2.6.11 is almost screwed up.  I managed to
get mouse working with it only 2 or 3 times (all
after cold reboot).  It also takes about 10 sec
to load psmouse module (2.6.10 is a >< bit faster),
but the mouse does just not work.  Sometimes,
it detects my mouse as "Generic ps/2 mouse"
(it is  "Generic Wheel mouse" usually).  More,
quite often, after re-loading psmouse module
the keyboard stops working as well.

I played with i8042.noacpi parameter but it has
no visible effect (incl. the dmesg output).

The machine is some Gygabyte mobo based on VT8601
chipset with VIA C3 CPU in it (I love those fanless
system for their quiet operations).  Mouse and keyboard
(PS/2 interface) are pretty standard ones, mouse has
wheel.  All the stuff reported by the kernel looks ok
too, here's the dmesg output:

Linux version 2.6.10-i486-1 (mjt@paltus.tls.msk.ru) (gcc version 3.3.5 (Debian 1:3.3.5-5)) #1 Mon Feb 7 15:57:55 MSK 2005
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 00000000077f0000 (usable)
  BIOS-e820: 00000000077f0000 - 00000000077f3000 (ACPI NVS)
  BIOS-e820: 00000000077f3000 - 0000000007800000 (ACPI data)
  BIOS-e820: 0000000007800000 - 0000000008000000 (reserved)
  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
119MB LOWMEM available.
On node 0 totalpages: 30704
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 26608 pages, LIFO batch:6
   HighMem zone: 0 pages, LIFO batch:1
DMI not present.
ACPI: RSDP (v000 GBT                                   ) @ 0x000f7340
ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x077f3000
ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x077f3040
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Built 1 zonelists
Kernel command line: initrd=boot/initrd-2.6.10-i486-1 root=/dev/ram0 BOOT_IMAGE=boot/vmlinuz-2.6.10-i486-1 ip=192.168.1.165:192.168.1.1:192.168.1.5:255.255.255.0
No local APIC present or hardware disabled
mapped APIC to ffffd000 (010f2000)
Initializing CPU#0
CPU 0 irqstacks, hard=c0318000 soft=c0317000
PID hash table entries: 512 (order: 9, 8192 bytes)
Detected 910.013 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 118144k/122816k available (1235k kernel code, 4116k reserved, 653k data, 224k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1815.34 BogoMIPS (lpj=9076736)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 00803035 80803035 00000000 00000000
CPU: L1 I Cache: 64K (32 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 64K (32 bytes/line)
CPU: After all inits, caps:        00803135 80803035 00000000 00000000
CPU: Centaur VIA Ezra stepping 08
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 8e20)
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 610k freed
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfaa80, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Via IRQ fixup
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PnPBIOS: Disabled by ACPI
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
PCI: Disabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PC Speaker
EISA: Probing bus 0 at eisa0
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices:
PCI0 USB0 USB1 MODM
ACPI: (supports S0 S1 S4 S5)
RAMDISK: Compressed image found at block 0
VFS: Mounted root (romfs filesystem) readonly.
Freeing unused kernel memory: 224k freed
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 15
PCI: setting IRQ 15 as level-triggered
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 15 (level, low) -> IRQ 15
eth0: RealTek RTL8139 at 0xec00, 00:20:ed:bb:49:ae, IRQ 15
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
nfs warning: mount version older than kernel
VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1

(the machine is a diskless X client).

Relevant config entries (the config is almost the same
for 2.6.10 and 2.6.11 kernels):

CONFIG_X86_PC=y
CONFIG_M486=y
CONFIG_X86_GENERIC=y

CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_TSDEV=m
CONFIG_INPUT_TSDEV_SCREEN_X=240
CONFIG_INPUT_TSDEV_SCREEN_Y=320
# CONFIG_INPUT_EVDEV is not set  (which reminds me i should turn it on)
# CONFIG_INPUT_EVBUG is not set

# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_LIBPS2=y

CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y

CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_SERIAL=m

CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y

CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

# CONFIG_APM is not set

CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_PNPBIOS_PROC_FS=y
CONFIG_PNPACPI=y


The kernel is a vanilla kernel.org tarball.

Playing with acpi didn't change anything (at least the
problem looks the same).

Any ideas?

Thanks.

/mjt
