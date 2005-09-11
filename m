Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbVIKK1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbVIKK1q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 06:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbVIKK1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 06:27:46 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:33943 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S932516AbVIKK1p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 06:27:45 -0400
Date: Sun, 11 Sep 2005 12:27:43 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13: Badness in send_IPI_mask_bitmask at arch/i386/kernel/smp.c:168
Message-ID: <20050911102743.GA15700@janus>
References: <20050910140532.GA32331@janus> <20050911005339.4a2452b7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050911005339.4a2452b7.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2005 at 12:53:39AM -0700, Andrew Morton wrote:
> Frank van Maarseveen <frankvm@frankvm.com> wrote:
> >
> > Badness in send_IPI_mask_bitmask at arch/i386/kernel/smp.c:168
> > 
> > See www.frankvm.com/tmp/badness-smp-168.jpg for the full trace
> > 
> I assume that was in response to a `halt -p'?

yes

> 
> Either you don't have a pm_power_off handler, or the one which you do have
> is returning to the caller rather than powering off.

apm=power-off fixes it. And that was necessary for really powering it
down. The dmesg difference with apm=power-off is:

 < apm: disabled - APM is not SMP safe.
 ---
 > apm: disabled - APM is not SMP safe (power off active).

Hmm, maybe it's time to try ACPI again for /sbin/poweroff - WOL/wake-on-keyboard
sequences.

> 
> Did the machine correctly power itself off under any earlier kernel?  If
> so, which version?

Just tried 2.6.9: no Badness anymore but it didn't power of either unless
I again specified apm=power-off. BTW, the earlier reported time anomalies
are always present, on 2.6.9 too, but I don't think it is related.

> 
> Please send the full boot-time dmesg output from the failing kernel.

Linux version 2.6.13-x114 (fvm@iapetus.localdomain) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 SMP Sat Sep 3 16:51:00 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffb0000 (usable)
 BIOS-e820: 000000007ffb0000 - 000000007ffc0000 (ACPI data)
 BIOS-e820: 000000007ffc0000 - 000000007fff0000 (ACPI NVS)
 BIOS-e820: 000000007fff0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
DMI 2.3 present.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: ASUSTeK  Product ID: Deluxe       APIC at: 0xFEE00000
Processor #0 15:3 APIC version 16
Processor #1 15:3 APIC version 16
I/O APIC #2 Version 3 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Allocating PCI resources starting at 80000000 (gap: 80000000:7f780000)
Built 1 zonelists
Kernel command line: ro root=/dev/md1
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2003.107 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2070960k/2096832k available (3790k kernel code, 24748k reserved, 1759k data, 264k init, 1179328k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4014.73 BogoMIPS (lpj=8029470)
Mount-cache hash table entries: 512
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0(2) -> Core 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4005.37 BogoMIPS (lpj=8010751)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 1(2) -> Core 1
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
Total of 2 processors activated (8020.11 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
checking TSC synchronization across 2 CPUs: 
CPU#0 had 0 usecs TSC skew, fixed it up.
CPU#1 had 0 usecs TSC skew, fixed it up.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=1
PCI: Using configuration type 1
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1106/3227] at 0000:00:11.0
PCI->APIC IRQ transform: 0000:00:07.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:08.0[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:00:09.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:0a.0[A] -> IRQ 17
PCI->APIC IRQ transform: 0000:00:0d.0[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:00:0f.0[B] -> IRQ 20
PCI->APIC IRQ transform: 0000:00:0f.1[A] -> IRQ 20
PCI->APIC IRQ transform: 0000:00:10.0[A] -> IRQ 21
PCI->APIC IRQ transform: 0000:00:10.1[A] -> IRQ 21
PCI->APIC IRQ transform: 0000:00:10.2[B] -> IRQ 21
PCI->APIC IRQ transform: 0000:00:10.3[B] -> IRQ 21
PCI->APIC IRQ transform: 0000:00:10.4[C] -> IRQ 21
PCI->APIC IRQ transform: 0000:00:11.5[C] -> IRQ 22
PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
PCI: Bridge: 0000:00:01.0
  IO window: e000-efff
  MEM window: fbd00000-fbffffff
  PREFETCH window: e8000000-faffffff
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: disabled - APM is not SMP safe.
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API

	(lots of crypto test output)

radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=240.00 Mhz, System=200.00 MHz
radeonfb: PLL min 20000 max 40000
radeonfb: Monitor 1 type CRT found
radeonfb: Monitor 2 type no found
Console: switching to colour frame buffer device 80x30
mtrr: base(0xe8000000) is not aligned on a size(0x10000000) boundary
radeonfb (0000:01:00.0): ATI Radeon Y` 
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
[drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Technologies Inc RV280 [Radeon 9200 PRO]
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
nbd: registered device at major 43
plip: parport0 has no IRQ. Using IRQ-less mode,which is fairly inefficient!
NET3 PLIP version 2.4-parport gniibe@mri.co.jp
plip0: Parallel port at 0x378, not using IRQ.
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
NET: Registered protocol family 24
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
CSLIP: code copyright 1989 Regents of the University of California.
8139too Fast Ethernet driver 0.9.27
eth1: RealTek RTL8139 at 0xf881a000, 00:02:44:2c:e2:00, IRQ 18
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 4
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hda: HDS722525VLAT80, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HDS722525VLAT80, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 488397168 sectors (250059 MB) w/7938KiB Cache, CHS=30401/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
hdc: max request size: 1024KiB
hdc: 488397168 sectors (250059 MB) w/7938KiB Cache, CHS=30401/255/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3 hdc4
ata1: SATA max UDMA/133 cmd 0xF881C200 ctl 0xF881C238 bmdma 0x0 irq 18
ata2: SATA max UDMA/133 cmd 0xF881C280 ctl 0xF881C2B8 bmdma 0x0 irq 18
ata1: no device found (phy stat 00000000)
scsi0 : sata_promise
ata2: no device found (phy stat 00000000)
scsi1 : sata_promise
ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: irq 21, io mem 0xfbc00000
ehci_hcd 0000:00:10.4: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.3
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 5
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 21, io base 0x0000c400
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 5
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 21, io base 0x0000c800
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 5
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 21, io base 0x0000d000
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 5
uhci_hcd 0000:00:10.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#4)
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.3: irq 21, io base 0x0000d400
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
w83627hf 4-0290: Reading VID from GPIO5
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: pIII_sse
input: AT Translated Set 2 keyboard on isa0060/serio0
   pIII_sse  :  6331.000 MB/sec
raid5: using function: pIII_sse (6331.000 MB/sec)
md: faulty personality registered as nr 10
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.38
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Advanced Linux Sound Architecture Driver Version 1.0.9b (Thu Jul 28 12:20:13 2005 UTC).
PCI: Via IRQ fixup for 0000:00:11.5, from 5 to 6
logips2pp: Detected unknown logitech mouse model 1
input: PS/2 Logitech Mouse on isa0060/serio1
ALSA device list:
  #0: VIA 8237 with ALC850 at 0xd800, irq 22
oprofile: using NMI interrupt.
NET: Registered protocol family 26
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 248 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
ClusterIP Version 0.7 loaded successfully
arp_tables: (C) 2002 David S. Miller
TCP bic registered
TCP westwood registered
TCP highspeed registered
TCP hybla registered
TCP htcp registered
TCP vegas registered
TCP scalable registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Bridge firewalling registered
Ebtables v2.0 registered
Starting balanced_irq
Using IPI Shortcut mode
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdc4 ...
md:  adding hdc4 ...
md: hdc3 has different UUID to hdc4
md: hdc2 has different UUID to hdc4
md: hdc1 has different UUID to hdc4
md:  adding hda4 ...
md: hda3 has different UUID to hdc4
md: hda2 has different UUID to hdc4
md: hda1 has different UUID to hdc4
md: created md4
md: bind<hda4>
md: bind<hdc4>
md: running: <hdc4><hda4>
raid1: raid set md4 active with 2 out of 2 mirrors
md: considering hdc3 ...
md:  adding hdc3 ...
md: hdc2 has different UUID to hdc3
md: hdc1 has different UUID to hdc3
md:  adding hda3 ...
md: hda2 has different UUID to hdc3
md: hda1 has different UUID to hdc3
md: created md3
md: bind<hda3>
md: bind<hdc3>
md: running: <hdc3><hda3>
raid1: raid set md3 active with 2 out of 2 mirrors
md: considering hdc2 ...
md:  adding hdc2 ...
md: hdc1 has different UUID to hdc2
md:  adding hda2 ...
md: hda1 has different UUID to hdc2
md: created md2
md: bind<hda2>
md: bind<hdc2>
md: running: <hdc2><hda2>
raid1: raid set md2 active with 2 out of 2 mirrors
md: considering hdc1 ...
md:  adding hdc1 ...
md:  adding hda1 ...
md: created md1
md: bind<hda1>
md: bind<hdc1>
md: running: <hdc1><hda1>
raid1: raid set md1 active with 2 out of 2 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 264k freed
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
nbd0: Request when not-ready
end_request: I/O error, dev nbd0, sector 0
Buffer I/O error on device nbd0, logical block 0
Buffer I/O error on device nbd0, logical block 1
Buffer I/O error on device nbd0, logical block 2
Buffer I/O error on device nbd0, logical block 3
Buffer I/O error on device nbd0, logical block 4
Buffer I/O error on device nbd0, logical block 5
Buffer I/O error on device nbd0, logical block 6
Buffer I/O error on device nbd0, logical block 7
nbd0: Request when not-ready
end_request: I/O error, dev nbd0, sector 0
Buffer I/O error on device nbd0, logical block 0
nbd0: Request when not-ready
end_request: I/O error, dev nbd0, sector 4294965120
nbd0: Request when not-ready
end_request: I/O error, dev nbd0, sector 0
nbd1: Request when not-ready
end_request: I/O error, dev nbd1, sector 4294965120
nbd1: Request when not-ready
end_request: I/O error, dev nbd1, sector 0
nbd2: Request when not-ready
end_request: I/O error, dev nbd2, sector 4294965120
nbd2: Request when not-ready
end_request: I/O error, dev nbd2, sector 0
nbd3: Request when not-ready
end_request: I/O error, dev nbd3, sector 4294965120
nbd3: Request when not-ready
end_request: I/O error, dev nbd3, sector 0
nbd4: Request when not-ready
end_request: I/O error, dev nbd4, sector 4294965120
nbd4: Request when not-ready
end_request: I/O error, dev nbd4, sector 0
nbd5: Request when not-ready
end_request: I/O error, dev nbd5, sector 4294965120
nbd5: Request when not-ready
end_request: I/O error, dev nbd5, sector 0
nbd6: Request when not-ready
end_request: I/O error, dev nbd6, sector 4294965120
nbd6: Request when not-ready
end_request: I/O error, dev nbd6, sector 0
nbd7: Request when not-ready
end_request: I/O error, dev nbd7, sector 4294965120
nbd7: Request when not-ready
end_request: I/O error, dev nbd7, sector 0
nbd8: Request when not-ready
end_request: I/O error, dev nbd8, sector 4294965120
nbd8: Request when not-ready
end_request: I/O error, dev nbd8, sector 0
nbd9: Request when not-ready
end_request: I/O error, dev nbd9, sector 4294965120
nbd9: Request when not-ready
end_request: I/O error, dev nbd9, sector 0
nbd10: Request when not-ready
end_request: I/O error, dev nbd10, sector 4294965120
nbd10: Request when not-ready
end_request: I/O error, dev nbd10, sector 0
nbd11: Request when not-ready
end_request: I/O error, dev nbd11, sector 4294965120
nbd11: Request when not-ready
end_request: I/O error, dev nbd11, sector 0
nbd12: Request when not-ready
end_request: I/O error, dev nbd12, sector 4294965120
nbd12: Request when not-ready
end_request: I/O error, dev nbd12, sector 0
nbd13: Request when not-ready
end_request: I/O error, dev nbd13, sector 4294965120
nbd13: Request when not-ready
end_request: I/O error, dev nbd13, sector 0
nbd14: Request when not-ready
end_request: I/O error, dev nbd14, sector 4294965120
nbd14: Request when not-ready
end_request: I/O error, dev nbd14, sector 0
nbd15: Request when not-ready
end_request: I/O error, dev nbd15, sector 4294965120
nbd15: Request when not-ready
end_request: I/O error, dev nbd15, sector 0
EXT3 FS on md1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.

-- 
Frank
