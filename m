Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932576AbWAJUYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbWAJUYc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbWAJUYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:24:32 -0500
Received: from mail47-s.fg.online.no ([148.122.161.47]:18323 "EHLO
	mail47-s.fg.online.no") by vger.kernel.org with ESMTP
	id S932583AbWAJUYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:24:30 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rt1
References: <20060103094720.GA16497@elte.hu>
From: Esben Stien <b0ef@esben-stien.name>
Date: Tue, 10 Jan 2006 23:17:01 +0100
In-Reply-To: <20060103094720.GA16497@elte.hu> (Ingo Molnar's message of
 "Tue, 3 Jan 2006 10:47:20 +0100")
Message-ID: <87hd8bk9sy.fsf@esben-stien.name>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> i have released the 2.6.15-rt1 tree

Didn't see any release announcement for 2.6.15-rt3, so I post here. 

I've booted up rt3 and got this: 

[drm] Loading R200 Microcode
check_monotonic_clock: monotonic inconsistency detected!
        from      157c03cbfc9 (1476398989257) to      157c03ca8f6 (1476398983414).
softirq-hrtimer/8[CPU#0]: BUG in check_monotonic_clock at kernel/time/timeofday.c:160
 [<c0112555>] __WARN_ON+0x40/0x5f (8)
 [<c012701a>] check_monotonic_clock+0x64/0x9a (48)
 [<c01273c7>] get_monotonic_clock+0xb5/0xe8 (32)
 [<c0124d95>] hrtimer_forward+0x2b/0xd6 (64)
 [<c011ae6a>] group_send_sig_info+0xb1/0xd3 (12)
 [<c0114e88>] it_real_fn+0x0/0x42 (40)
 [<c0114ec2>] it_real_fn+0x3a/0x42 (4)
 [<c01253c2>] run_hrtimer_softirq+0x7d/0xe8 (24)
 [<c01161e3>] ksoftirqd+0xce/0x139 (32)
 [<c0116115>] ksoftirqd+0x0/0x139 (40)
 [<c01223f2>] kthread+0x79/0xa3 (4)
 [<c0122379>] kthread+0x0/0xa3 (24)
 [<c0100db9>] kernel_thread_helper+0x5/0xb (16)

I'm also, for some reason, unable to get my Logitech MX1000 mouse to
work in xorg-6.8.1 here, through evdev. I changed my config file to
use normal /dev/psaux as a temporary solution. I'm coming from
linux-2.6.14-rt22 where everything related is working fine. No
software has changed.

I run my own distro. 

Here's the relevant part of xorg configuration: 

Section	"InputDevice"	# Logitech MX1000 
Identifier   "Mouse0"
Driver 	     "mouse"
Option 	     "Protocol" "evdev"
Option       "Dev Name" "Logitech USB Receiver" 
Option       "Dev Phys" "usb-0000:00:1d.0-1/input0" 
Option       "Device" "/dev/input/mice" 
Option       "Buttons" "12"
Option       "ZAxisMapping" "11 12 10 9"
Option       "Emulate3Buttons" "false"
Option       "Resolution" "800"
Option       "SampleRate" "800"
EndSection

This worked when I used (Option "Device" "/dev/psaux"). Then it is
bypassing the evdev system. The /dev/input/mice is present on the
system, though.

Here are some data about me: 

Linux version 2.6.15-rt3 (b0ef@quasar) (gcc version 3.4.2) #1 PREEMPT Tue Jan 10 08:28:48 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000005fef0000 (usable)
 BIOS-e820: 000000005fef0000 - 000000005fefb000 (ACPI data)
 BIOS-e820: 000000005fefb000 - 000000005ff00000 (ACPI NVS)
 BIOS-e820: 000000005ff00000 - 000000005ff80000 (usable)
 BIOS-e820: 000000005ff80000 - 0000000060000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
639MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 393088
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 163712 pages, LIFO batch:31
DMI present.
Allocating PCI resources starting at 70000000 (gap: 60000000:9ec00000)
Detected 2394.068 MHz processor.
Real-Time Preemption Support (C) 2004-2005 Ingo Molnar
Built 1 zonelists
Kernel command line: root=/dev/sda1 
Initializing CPU#0
WARNING: experimental RCU implementation.
PID hash table entries: 4096 (order: 12, 65536 bytes)
Event source pit installed with caps set: 07
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1555004k/1572352k available (2451k kernel code, 16896k reserved, 865k data, 132k init, 654784k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4789.85 BogoMIPS (lpj=2394925)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 128K
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
mtrr: v2.0 (20020519)
CPU: Intel(R) Celeron(R) CPU 2.40GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd987, last bus=3
PCI: Using configuration type 1
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI quirk: region f000-f07f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region f180-f1bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 0000:00:1f.0
PCI: IRQ 0 for device 0000:00:1f.2 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 7 for device 0000:00:1f.2
PCI: Sharing IRQ 7 with 0000:00:1d.2
PCI: Bridge: 0000:00:01.0
  IO window: 3000-3fff
  MEM window: c0000000-c00fffff
  PREFETCH window: e0000000-efffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 4000-4fff
  MEM window: c0100000-c01fffff
  PREFETCH window: 70000000-700fffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1136913723.097:1): initialized
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.25 [Flags: R/O].
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Time: tsc clocksource has been installed.
hrtimers: Switched to high resolution mode CPU 0
lp: driver loaded but no devices found
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 865 Chipset.
agpgart: AGP aperture is 256M @ 0xd0000000
[drm] Initialized drm 1.0.0 20040925
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ne2k-pci.c:v1.03 9/22/2003 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
PCI: Found IRQ 10 for device 0000:03:05.0
eth0: RealTek RTL-8029 found at 0x4000, IRQ 10, 52:54:00:DF:C7:EB.
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
PCI: Found IRQ 10 for device 0000:03:08.0
e100: eth1: e100_probe: addr 0xc0110000, irq 10, MAC addr 00:30:05:4F:61:E1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
ide1: I/O resource 0x170-0x177 not free.
ide1: ports already in use, skipping probe
libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
ata_piix 0000:00:1f.2: combined mode detected (p=0, s=1)
PCI: Found IRQ 7 for device 0000:00:1f.2
PCI: Sharing IRQ 7 with 0000:00:1d.2
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x2400 irq 14
ata1: disabling port
scsi0 : ata_piix
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x2408 irq 15
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e01 87:4663 88:407f
ata2: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : ata_piix
  Vendor: ATA       Model: Maxtor 6L300S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 1:0:0:0: Attached scsi disk sda
sd 1:0:0:0: Attached scsi generic sg0 type 0
ieee1394: raw1394: /dev/raw1394 device initialized
usbmon: debugfs is not available
USB Universal Host Controller Interface driver v2.3
PCI: Found IRQ 10 for device 0000:00:1d.0
PCI: Sharing IRQ 10 with 0000:00:1d.3
PCI: Sharing IRQ 10 with 0000:01:00.0
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 10, io base 0x00001000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 7 for device 0000:00:1d.1
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 7, io base 0x00001400
usb 1-1: new low speed USB device using uhci_hcd and address 2
usb 1-2: new full speed USB device using uhci_hcd and address 3
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
usb 1-2.2: new full speed USB device using uhci_hcd and address 4
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Found IRQ 7 for device 0000:00:1d.2
PCI: Sharing IRQ 7 with 0000:00:1f.2
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 7, io base 0x00001800
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PCI: Found IRQ 10 for device 0000:00:1d.3
PCI: Sharing IRQ 10 with 0000:00:1d.0
PCI: Sharing IRQ 10 with 0000:01:00.0
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 10, io base 0x00001c00
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
input: Logitech USB Receiver as /class/input/input0
input: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:00:1d.0-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07 13:30:21 2005 UTC).
ALSA device list:
  No soundcards found.
oprofile: using timer interrupt.
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 65536 (order: 9, 2359296 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
TCP reno registered
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 212 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ReiserFS: sda1: found reiserfs format "3.6" with standard journal
input: AT Translated Set 2 keyboard as /class/input/input1
ReiserFS: sda1: using ordered data mode
ReiserFS: sda1: journal params: device sda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda1: checking transaction log (sda1)
ReiserFS: sda1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 132k freed
Adding 3879688k swap on /dev/sda2.  Priority:1 extents:1 across:3879688k
PCI: Found IRQ 9 for device 0000:03:07.0
Hammerfall-DSP: Firmware already present, initializing card.
usbcore: registered new driver snd-usb-audio
do_settimeofday() was called!
e100: eth1: e100_watchdog: link up, 100Mbps, full-duplex
PCI: Found IRQ 10 for device 0000:01:00.0
PCI: Sharing IRQ 10 with 0000:00:1d.0
PCI: Sharing IRQ 10 with 0000:00:1d.3
[drm] Initialized radeon 1.19.0 20050911 on minor 0: 
mtrr: 0xe0000000,0x10000000 overlaps existing 0xe0000000,0x8000000
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: reserved bits set (4) in mode 0x1f004a0f. Fixed.
agpgart: X tried to set rate=x12. Setting to AGP3 x8 mode.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
[drm] Loading R200 Microcode
check_monotonic_clock: monotonic inconsistency detected!
	from      157c03cbfc9 (1476398989257) to      157c03ca8f6 (1476398983414).
softirq-hrtimer/8[CPU#0]: BUG in check_monotonic_clock at kernel/time/timeofday.c:160
 [<c0112555>] __WARN_ON+0x40/0x5f (8)
 [<c012701a>] check_monotonic_clock+0x64/0x9a (48)
 [<c01273c7>] get_monotonic_clock+0xb5/0xe8 (32)
 [<c0124d95>] hrtimer_forward+0x2b/0xd6 (64)
 [<c011ae6a>] group_send_sig_info+0xb1/0xd3 (12)
 [<c0114e88>] it_real_fn+0x0/0x42 (40)
 [<c0114ec2>] it_real_fn+0x3a/0x42 (4)
 [<c01253c2>] run_hrtimer_softirq+0x7d/0xe8 (24)
 [<c01161e3>] ksoftirqd+0xce/0x139 (32)
 [<c0116115>] ksoftirqd+0x0/0x139 (40)
 [<c01223f2>] kthread+0x79/0xa3 (4)
 [<c0122379>] kthread+0x0/0xa3 (24)
 [<c0100db9>] kernel_thread_helper+0x5/0xb (16)

I: Bus=0003 Vendor=046d Product=c50e Version=2500
N: Name="Logitech USB Receiver"
P: Phys=usb-0000:00:1d.0-1/input0
S: Sysfs=/class/input/input0
H: Handlers=mouse0 event0 
B: EV=7
B: KEY=ffff0000 0 0 0 0 0 0 0 0
B: REL=143

I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
S: Sysfs=/class/input/input1
H: Handlers=kbd event1 
B: EV=120013
B: KEY=4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe
B: MSC=10
B: LED=7

PCI devices found:
  Bus  0, device   0, function  0:
    Class 0600: PCI device 8086:2570 (rev 2).
      Prefetchable 32 bit memory at 0xd0000000 [0xdfffffff].
  Bus  0, device   1, function  0:
    Class 0604: PCI device 8086:2571 (rev 2).
      Master Capable.  Latency=176.  Min Gnt=13.
  Bus  0, device  29, function  0:
    Class 0c03: PCI device 8086:24d2 (rev 2).
      IRQ 10.
      I/O at 0x1000 [0x101f].
  Bus  0, device  29, function  1:
    Class 0c03: PCI device 8086:24d4 (rev 2).
      IRQ 7.
      I/O at 0x1400 [0x141f].
  Bus  0, device  29, function  2:
    Class 0c03: PCI device 8086:24d7 (rev 2).
      IRQ 7.
      I/O at 0x1800 [0x181f].
  Bus  0, device  29, function  3:
    Class 0c03: PCI device 8086:24de (rev 2).
      IRQ 10.
      I/O at 0x1c00 [0x1c1f].
  Bus  0, device  30, function  0:
    Class 0604: PCI device 8086:244e (rev 194).
      Master Capable.  No bursts.  Min Gnt=7.
  Bus  0, device  31, function  0:
    Class 0601: PCI device 8086:24d0 (rev 2).
  Bus  0, device  31, function  2:
    Class 0101: PCI device 8086:24d1 (rev 2).
      IRQ 7.
      I/O at 0x2400 [0x240f].
  Bus  0, device  31, function  3:
    Class 0c05: PCI device 8086:24d3 (rev 2).
      IRQ 4.
      I/O at 0x2000 [0x201f].
  Bus  1, device   0, function  0:
    Class 0300: PCI device 1002:5960 (rev 1).
      IRQ 10.
      Master Capable.  Latency=176.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xe0000000 [0xefffffff].
      I/O at 0x3000 [0x30ff].
      Non-prefetchable 32 bit memory at 0xc0000000 [0xc000ffff].
  Bus  3, device   5, function  0:
    Class 0200: PCI device 10ec:8029 (rev 0).
      IRQ 10.
      I/O at 0x4000 [0x401f].
  Bus  3, device   7, function  0:
    Class 0401: PCI device 10ee:3fc5 (rev 50).
      IRQ 9.
      Master Capable.  Latency=255.  
      Non-prefetchable 32 bit memory at 0xc0100000 [0xc010ffff].
  Bus  3, device   8, function  0:
    Class 0200: PCI device 8086:1051 (rev 2).
      IRQ 10.
      Master Capable.  Latency=176.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xc0110000 [0xc0110fff].
      I/O at 0x4400 [0x443f].


T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.15-rt3 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.3
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.15-rt3 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.2
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.15-rt3 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.1
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=129/900 us (14%), #Int=  2, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.15-rt3 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.0
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c50e Rev=25.00
S:  Manufacturer=Logitech
S:  Product=USB Receiver
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 70mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12  MxCh= 4
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0409 ProdID=0059 Rev= 1.00
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms

T:  Bus=01 Lev=02 Prnt=03 Port=01 Cnt=01 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1397 ProdID=00bc Rev= 1.00
S:  Manufacturer=BEHRINGER
S:  Product=BCF2000
C:* #Ifs= 2 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=snd-usb-audio
I:  If#= 1 Alt= 0 #EPs= 2 Cls=01(audio) Sub=03 Prot=00 Driver=snd-usb-audio
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=   4 Ivl=0ms

# dmidecode 2.6
SMBIOS 2.31 present.
87 structures occupying 2189 bytes.
Table at 0x000F03A0.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information
		Vendor: FUJITSU SIEMENS // Phoenix Technologies Ltd.
		Version: 4.06  Rev. 1.09.1561            
		Release Date: 04/23/2004
		Address: 0xE5690
		Runtime Size: 108912 bytes
		ROM Size: 512 kB
		Characteristics:
			PCI is supported
			PNP is supported
			APM is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			ESCD support is available
			Boot from CD is supported
			Selectable boot is supported
			Japanese floppy for NEC 9800 1.2 MB is supported (int 13h)
			Japanese floppy for Toshiba 1.2 MB is supported (int 13h)
			5.25"/360 KB floppy services are supported (int 13h)
			5.25"/1.2 MB floppy services are supported (int 13h)
			3.5"/720 KB floppy services are supported (int 13h)
			3.5"/2.88 MB floppy services are supported (int 13h)
			Print screen service is supported (int 5h)
			8042 keyboard services are supported (int 9h)
			Serial services are supported (int 14h)
			Printer services are supported (int 17h)
			CGA/mono video services are supported (int 10h)
			ACPI is supported
			USB legacy is supported
			AGP is supported
			LS-120 boot is supported
			ATAPI Zip drive boot is supported
			BIOS boot specification is supported
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer: FUJITSU SIEMENS
		Product Name: SCENIC P / SCENICO P
		Version:         
		Serial Number: YBEM389365
		UUID: D0DB43CC-E8AE-11D7-A847-F635F11A2CF7
		Wake-up Type: Power Switch
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: FUJITSU SIEMENS
		Product Name: D1561
		Version: S26361-D1561
		Serial Number:         
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information
		Manufacturer: FUJITSU SIEMENS
		Type: Mini Tower
		Lock: Present
		Version: SCEP 
		Serial Number: YBEM389365      
		Asset Tag: YBEM389365          
		Boot-up State: Safe
		Power Supply State: Safe
		Thermal State: Safe
		Security Status: None
		OEM Information: 0x00000000
Handle 0x0004
	DMI type 4, 35 bytes.
	Processor Information
		Socket Designation: CPU
		Type: Central Processor
		Family: Celeron
		Manufacturer: Intel
		ID: 29 0F 00 00 FF FB EB BF
		Signature: Type 0, Family 15, Model 2, Stepping 9
		Flags:
			FPU (Floating-point unit on-chip)
			VME (Virtual mode extension)
			DE (Debugging extension)
			PSE (Page size extension)
			TSC (Time stamp counter)
			MSR (Model specific registers)
			PAE (Physical address extension)
			MCE (Machine check exception)
			CX8 (CMPXCHG8 instruction supported)
			APIC (On-chip APIC hardware supported)
			SEP (Fast system call)
			MTRR (Memory type range registers)
			PGE (Page global enable)
			MCA (Machine check architecture)
			CMOV (Conditional move instruction supported)
			PAT (Page attribute table)
			PSE-36 (36-bit page size extension)
			CLFSH (CLFLUSH instruction supported)
			DS (Debug store)
			ACPI (ACPI supported)
			MMX (MMX technology supported)
			FXSR (Fast floating-point save and restore)
			SSE (Streaming SIMD extensions)
			SSE2 (Streaming SIMD extensions 2)
			SS (Self-snoop)
			HTT (Hyper-threading technology)
			TM (Thermal monitor supported)
			PBE (Pending break enabled)
		Version: Intel Celeron(R)
		Voltage: 3.3 V
		External Clock: 400 MHz
		Max Speed: 2400 MHz
		Current Speed: 2400 MHz
		Status: Populated, Enabled
		Upgrade: ZIF Socket
		L1 Cache Handle: 0x0005
		L2 Cache Handle: 0x0006
		L3 Cache Handle: 0x0007
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0005
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L1 Cache
		Configuration: Enabled, Not Socketed, Level 1
		Operational Mode: Write Through
		Location: Internal
		Installed Size: 8 KB
		Maximum Size: 32 KB
		Supported SRAM Types:
			Burst
			Synchronous
		Installed SRAM Type: Burst Synchronous
		Speed: Unknown
		Error Correction Type: Parity
		System Type: Data
		Associativity: Other
Handle 0x0006
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L2 Cache
		Configuration: Enabled, Not Socketed, Level 2
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 128 KB
		Maximum Size: 1024 KB
		Supported SRAM Types:
			Burst
			Pipeline Burst
			Synchronous
			Asynchronous
		Installed SRAM Type: Burst
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unified
		Associativity: Other
Handle 0x0007
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L3 Cache
		Configuration: Disabled, Not Socketed, Level 3
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 0 KB
		Maximum Size: 16384 KB
		Supported SRAM Types:
			Burst
			Pipeline Burst
			Synchronous
			Asynchronous
		Installed SRAM Type: None
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unified
		Associativity: Other
Handle 0x0008
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: SMsC
		Internal Connector Type: None
		External Reference Designator: PS/2 Mouse
		External Connector Type: PS/2
		Port Type: Mouse Port
Handle 0x0009
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: SMsC
		Internal Connector Type: None
		External Reference Designator: Keyboard
		External Connector Type: PS/2
		Port Type: Keyboard Port
Handle 0x000A
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: SMsC
		Internal Connector Type: None
		External Reference Designator: Parallel
		External Connector Type: DB-25 female
		Port Type: Parallel Port ECP/EPP
Handle 0x000B
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: SMsC
		Internal Connector Type: None
		External Reference Designator: Serial-1
		External Connector Type: DB-9 male
		Port Type: Serial Port 16550 Compatible
Handle 0x000C
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: SMsC
		Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
		External Reference Designator: Serial-2
		External Connector Type: None
		Port Type: Serial Port 16550 Compatible
Handle 0x000D
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: SMsC
		Internal Connector Type: On Board Floppy
		External Reference Designator: Floppy
		External Connector Type: None
		Port Type: None
Handle 0x000E
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: ICH5
		Internal Connector Type: On Board IDE
		External Reference Designator: Primary IDE
		External Connector Type: None
		Port Type: None
Handle 0x000F
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: ICH5
		Internal Connector Type: On Board IDE
		External Reference Designator: Secondary IDE
		External Connector Type: None
		Port Type: None
Handle 0x0010
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: ICH5
		Internal Connector Type: Other
		External Reference Designator: SATA-1
		External Connector Type: None
		Port Type: None
Handle 0x0011
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: ICH5
		Internal Connector Type: Other
		External Reference Designator: SATA-2
		External Connector Type: None
		Port Type: None
Handle 0x0012
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: ICH5
		Internal Connector Type: None
		External Reference Designator: USB-1
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0013
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: ICH5
		Internal Connector Type: None
		External Reference Designator: USB-2
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0014
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: ICH5
		Internal Connector Type: None
		External Reference Designator: USB-3
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0015
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: ICH5
		Internal Connector Type: None
		External Reference Designator: USB-4
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0016
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: ICH5
		Internal Connector Type: None
		External Reference Designator: USB-5
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0017
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: ICH5
		Internal Connector Type: None
		External Reference Designator: USB-6
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0018
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: ICH5
		Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
		External Reference Designator: USB-7
		External Connector Type: None
		Port Type: USB
Handle 0x0019
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: ICH5
		Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
		External Reference Designator: USB-8
		External Connector Type: None
		Port Type: USB
Handle 0x001A
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Intel 865G
		Internal Connector Type: None
		External Reference Designator: Video
		External Connector Type: DB-15 female
		Port Type: Video Port
Handle 0x001B
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: INTEL 82562EZ
		Internal Connector Type: None
		External Reference Designator: LAN
		External Connector Type: RJ-45
		Port Type: Network Port
Handle 0x001C
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: AD1980
		Internal Connector Type: None
		External Reference Designator: Rear: Line-In
		External Connector Type: Mini Jack (headphones)
		Port Type: Audio Port
Handle 0x001D
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: AD1980
		Internal Connector Type: None
		External Reference Designator: Rear: Line-Out
		External Connector Type: Mini Jack (headphones)
		Port Type: Audio Port
Handle 0x001E
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: AD1980
		Internal Connector Type: None
		External Reference Designator: Rear: Mic-In
		External Connector Type: Mini Jack (headphones)
		Port Type: Audio Port
Handle 0x001F
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: AD1980
		Internal Connector Type: None
		External Reference Designator: Front: Mic-In
		External Connector Type: Mini Jack (headphones)
		Port Type: Audio Port
Handle 0x0020
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: AD1980
		Internal Connector Type: None
		External Reference Designator: Front: Line-Out
		External Connector Type: Mini Jack (headphones)
		Port Type: Audio Port
Handle 0x0021
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: AGP
		Type: 32-bit AGP 4x
		Current Usage: In Use
		Length: Long
		ID: 1
		Characteristics:
			PME signal is supported
Handle 0x0022
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI-1
		Type: 32-bit PCI
		Current Usage: In Use
		Length: Long
		ID: 2
		Characteristics:
			5.0 V is provided
			3.3 V is provided
			PME signal is supported
Handle 0x0023
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI-2
		Type: 32-bit PCI
		Current Usage: In Use
		Length: Long
		ID: 3
		Characteristics:
			5.0 V is provided
			3.3 V is provided
			PME signal is supported
Handle 0x0024
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI-3
		Type: 32-bit PCI
		Current Usage: Available
		Length: Long
		ID: 4
		Characteristics:
			5.0 V is provided
			3.3 V is provided
			PME signal is supported
Handle 0x0025
	DMI type 10, 12 bytes.
	On Board Device 1 Information
		Type: Other
		Status: Disabled
		Description: SMsC SuperI/O
	On Board Device 2 Information
		Type: Sound
		Status: Disabled
		Description: AD1980
	On Board Device 3 Information
		Type: Ethernet
		Status: Disabled
		Description: Intel 82562EZ
	On Board Device 4 Information
		Type: Video
		Status: Disabled
		Description: Intel 865G
Handle 0x0026
	DMI type 11, 5 bytes.
	OEM Strings
		String 1: FUJITSU SIEMENS
		String 2: FUJITSU SIEMENS SYSTEM
Handle 0x0027
	DMI type 12, 5 bytes.
	System Configuration Options
		Option 1: J1-3: Default position
		Option 2: J1-2: Reserved
		Option 3: J5-6: Recovery BIOS active
Handle 0x0028
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: System Memory
		Error Correction Type: None
		Maximum Capacity: 4 GB
		Error Information Handle: Not Provided
		Number Of Devices: 4
Handle 0x0029
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0028
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 512 MB
		Form Factor: DIMM
		Set: None
		Locator: Slot-1
		Bank Locator: Channel A
		Type: DDR
		Type Detail: Synchronous
		Speed: 266 MHz (3.8 ns)
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x002A
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0028
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 512 MB
		Form Factor: DIMM
		Set: None
		Locator: Slot-3
		Bank Locator: Channel A
		Type: DDR
		Type Detail: Synchronous
		Speed: 266 MHz (3.8 ns)
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x002B
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0028
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 512 MB
		Form Factor: DIMM
		Set: None
		Locator: Slot-2
		Bank Locator: Channel B
		Type: DDR
		Type Detail: Synchronous
		Speed: 266 MHz (3.8 ns)
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x002C
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0028
		Error Information Handle: Not Provided
		Total Width: Unknown
		Data Width: Unknown
		Size: No Module Installed
		Form Factor: DIMM
		Set: None
		Locator: Slot-4
		Bank Locator: Channel B
		Type: DDR
		Type Detail: Synchronous
		Speed: 266 MHz (3.8 ns)
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x002D
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x000600003FF
		Range Size: 1572865 kB
		Physical Array Handle: 0x0028
		Partition Width: 0
Handle 0x002E
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 512 MB
		Physical Device Handle: 0x0029
		Memory Array Mapped Address Handle: 0x002D
		Partition Row Position: 1
Handle 0x002F
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00020000000
		Ending Address: 0x0003FFFFFFF
		Range Size: 512 MB
		Physical Device Handle: 0x002A
		Memory Array Mapped Address Handle: 0x002D
		Partition Row Position: 1
Handle 0x0030
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00040000000
		Ending Address: 0x0005FFFFFFF
		Range Size: 512 MB
		Physical Device Handle: 0x002B
		Memory Array Mapped Address Handle: 0x002D
		Partition Row Position: 1
Handle 0x0031
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x0005FFFFC00
		Ending Address: 0x0005FFFFFFF
		Range Size: 1 kB
		Physical Device Handle: 0x002C
		Memory Array Mapped Address Handle: 0x002D
		Partition Row Position: 1
Handle 0x0032
	DMI type 32, 11 bytes.
	System Boot Information
		Status: No errors detected
Handle 0x0033
	DMI type 39, 22 bytes.
	System Power Supply
		Location: Not Specified
		Name:                
		Manufacturer: Not Specified
		Serial Number:       
		Asset Tag: Not Specified
		Model Part Number: Not Specified
		Revision:           
		Max Power Capacity: 0.000 W
		Status: Present, Unknown
		Type: Switching
		Input Voltage Range Switching: Unknown
		Plugged: Yes
		Hot Replaceable: No
Handle 0x0034
	DMI type 130, 16 bytes.
	OEM-specific Type
		Header and Data:
			82 10 34 00 00 5F 46 4A 5F 4F 45 4D 5F 10 00 00
Handle 0x0035
	DMI type 130, 8 bytes.
	OEM-specific Type
		Header and Data:
			82 08 35 00 01 02 00 01
Handle 0x0036
	DMI type 176, 16 bytes.
	OEM-specific Type
		Header and Data:
			B0 10 36 00 00 80 61 15 00 00 FF FF 01 08 FF FF
Handle 0x0037
	DMI type 177, 12 bytes.
	OEM-specific Type
		Header and Data:
			B1 0C 37 00 11 02 09 61 00 00 00 00
Handle 0x0038
	DMI type 179, 6 bytes.
	OEM-specific Type
		Header and Data:
			B3 06 38 00 00 30
Handle 0x0039
	DMI type 180, 10 bytes.
	OEM-specific Type
		Header and Data:
			B4 0A 39 00 E0 01 F0 00 00 00
Handle 0x003A
	DMI type 185, 8 bytes.
	OEM-specific Type
		Header and Data:
			B9 08 3A 00 00 10 00 00
Handle 0x003B
	DMI type 185, 8 bytes.
	OEM-specific Type
		Header and Data:
			B9 08 3B 00 01 10 00 00
Handle 0x003C
	DMI type 185, 8 bytes.
	OEM-specific Type
		Header and Data:
			B9 08 3C 00 02 09 00 00
Handle 0x003D
	DMI type 185, 8 bytes.
	OEM-specific Type
		Header and Data:
			B9 08 3D 00 03 02 11 E6
Handle 0x003E
	DMI type 185, 8 bytes.
	OEM-specific Type
		Header and Data:
			B9 08 3E 00 05 02 07 E6
Handle 0x003F
	DMI type 185, 8 bytes.
	OEM-specific Type
		Header and Data:
			B9 08 3F 00 06 02 11 E6
Handle 0x0040
	DMI type 185, 8 bytes.
	OEM-specific Type
		Header and Data:
			B9 08 40 00 07 02 11 E6
Handle 0x0041
	DMI type 185, 8 bytes.
	OEM-specific Type
		Header and Data:
			B9 08 41 00 0A 02 11 E6
Handle 0x0042
	DMI type 185, 8 bytes.
	OEM-specific Type
		Header and Data:
			B9 08 42 00 0B 02 11 E6
Handle 0x0043
	DMI type 185, 8 bytes.
	OEM-specific Type
		Header and Data:
			B9 08 43 00 0C 02 11 E6
Handle 0x0044
	DMI type 185, 8 bytes.
	OEM-specific Type
		Header and Data:
			B9 08 44 00 0F 10 00 00
Handle 0x0045
	DMI type 185, 8 bytes.
	OEM-specific Type
		Header and Data:
			B9 08 45 00 10 02 11 E6
Handle 0x0046
	DMI type 185, 8 bytes.
	OEM-specific Type
		Header and Data:
			B9 08 46 00 11 02 03 A0
Handle 0x0047
	DMI type 185, 56 bytes.
	OEM-specific Type
		Header and Data:
			B9 38 47 00 13 07 01 14 00 00 00 02 31 00 00 00
			03 0A 00 00 00 05 05 03 00 FB 06 05 03 00 FB 07
			21 00 00 00 08 19 A6 32 02 0A 12 67 3C 02 0B 15
			A6 32 02 00 00 00 00 00
Handle 0x0048
	DMI type 185, 8 bytes.
	OEM-specific Type
		Header and Data:
			B9 08 48 00 14 00 00 00
Handle 0x0049
	DMI type 185, 8 bytes.
	OEM-specific Type
		Header and Data:
			B9 08 49 00 15 10 00 00
Handle 0x004A
	DMI type 185, 8 bytes.
	OEM-specific Type
		Header and Data:
			B9 08 4A 00 16 02 11 E6
Handle 0x004B
	DMI type 185, 8 bytes.
	OEM-specific Type
		Header and Data:
			B9 08 4B 00 17 10 00 00
Handle 0x004C
	DMI type 185, 8 bytes.
	OEM-specific Type
		Header and Data:
			B9 08 4C 00 18 02 11 E6
Handle 0x004D
	DMI type 185, 46 bytes.
	OEM-specific Type
		Header and Data:
			B9 2E 4D 00 19 07 0C 05 03 00 FB 0D AA 00 D8 00
			0E A5 00 D4 00 0F C1 00 FF 00 10 0A 05 35 39 11
			0A 05 2D 31 12 0A 05 4A 4D 00 00 00 00 00
Handle 0x004E
	DMI type 185, 8 bytes.
	OEM-specific Type
		Header and Data:
			B9 08 4E 00 1E 02 14 E6
Handle 0x004F
	DMI type 185, 8 bytes.
	OEM-specific Type
		Header and Data:
			B9 08 4F 00 FF 00 00 00
Handle 0x0050
	DMI type 186, 15 bytes.
	OEM-specific Type
		Header and Data:
			BA 0F 50 00 22 F0 15 26 01 01 01 01 12 0F EA
Handle 0x0051
	DMI type 187, 12 bytes.
	OEM-specific Type
		Header and Data:
			BB 0C 51 00 01 0F 58 12 22 05 21 00
Handle 0x0052
	DMI type 187, 12 bytes.
	OEM-specific Type
		Header and Data:
			BB 0C 52 00 02 0F 58 12 22 05 21 02
Handle 0x0053
	DMI type 187, 12 bytes.
	OEM-specific Type
		Header and Data:
			BB 0C 53 00 03 01 80 12 22 05 21 07
Handle 0x0054
	DMI type 188, 8 bytes.
	OEM-specific Type
		Header and Data:
			BC 08 54 00 38 38 31 24
Handle 0x0055
	DMI type 189, 7 bytes.
	OEM-specific Type
		Header and Data:
			BD 07 55 00 FF 33 00
Handle 0x0056
	DMI type 127, 4 bytes.
	End Of Table

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Celeron(R) CPU 2.40GHz
stepping	: 9
cpu MHz		: 2394.068
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips	: 4789.85

PCI devices found:
  Bus  0, device   0, function  0:
    Class 0600: PCI device 8086:2570 (rev 2).
      Prefetchable 32 bit memory at 0xd0000000 [0xdfffffff].
  Bus  0, device   1, function  0:
    Class 0604: PCI device 8086:2571 (rev 2).
      Master Capable.  Latency=176.  Min Gnt=13.
  Bus  0, device  29, function  0:
    Class 0c03: PCI device 8086:24d2 (rev 2).
      IRQ 10.
      I/O at 0x1000 [0x101f].
  Bus  0, device  29, function  1:
    Class 0c03: PCI device 8086:24d4 (rev 2).
      IRQ 7.
      I/O at 0x1400 [0x141f].
  Bus  0, device  29, function  2:
    Class 0c03: PCI device 8086:24d7 (rev 2).
      IRQ 7.
      I/O at 0x1800 [0x181f].
  Bus  0, device  29, function  3:
    Class 0c03: PCI device 8086:24de (rev 2).
      IRQ 10.
      I/O at 0x1c00 [0x1c1f].
  Bus  0, device  30, function  0:
    Class 0604: PCI device 8086:244e (rev 194).
      Master Capable.  No bursts.  Min Gnt=7.
  Bus  0, device  31, function  0:
    Class 0601: PCI device 8086:24d0 (rev 2).
  Bus  0, device  31, function  2:
    Class 0101: PCI device 8086:24d1 (rev 2).
      IRQ 7.
      I/O at 0x2400 [0x240f].
  Bus  0, device  31, function  3:
    Class 0c05: PCI device 8086:24d3 (rev 2).
      IRQ 4.
      I/O at 0x2000 [0x201f].
  Bus  1, device   0, function  0:
    Class 0300: PCI device 1002:5960 (rev 1).
      IRQ 10.
      Master Capable.  Latency=176.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xe0000000 [0xefffffff].
      I/O at 0x3000 [0x30ff].
      Non-prefetchable 32 bit memory at 0xc0000000 [0xc000ffff].
  Bus  3, device   5, function  0:
    Class 0200: PCI device 10ec:8029 (rev 0).
      IRQ 10.
      I/O at 0x4000 [0x401f].
  Bus  3, device   7, function  0:
    Class 0401: PCI device 10ee:3fc5 (rev 50).
      IRQ 9.
      Master Capable.  Latency=255.  
      Non-prefetchable 32 bit memory at 0xc0100000 [0xc010ffff].
  Bus  3, device   8, function  0:
    Class 0200: PCI device 8086:1051 (rev 2).
      IRQ 10.
      Master Capable.  Latency=176.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xc0110000 [0xc0110fff].
      I/O at 0x4400 [0x443f].


-- 
Esben Stien is b0ef@e     s      a             
         http://www. s     t    n m
          irc://irc.  b  -  i  .   e/%23contact
          [sip|iax]:   e     e 
           jid:b0ef@    n     n
