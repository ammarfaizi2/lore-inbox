Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267684AbRGUPst>; Sat, 21 Jul 2001 11:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267686AbRGUPsk>; Sat, 21 Jul 2001 11:48:40 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:57991 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S267684AbRGUPs2>;
	Sat, 21 Jul 2001 11:48:28 -0400
Message-ID: <3B59A41C.77EE3A8A@candelatech.com>
Date: Sat, 21 Jul 2001 08:47:40 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: Martin Murray <mmurray@deepthought.ORG>, linux-kernel@vger.kernel.org
Subject: Re: yenta_socket hangs sager laptop in kernel 2.4.6
In-Reply-To: <200107211335.RAA13657@ms2.inr.ac.ru>
Content-Type: multipart/mixed;
 boundary="------------211C1C95A915C9DCB8AB4588"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This is a multi-part message in MIME format.
--------------211C1C95A915C9DCB8AB4588
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > You know. 2.2.19 uses my cardbus controller on IRQ 11 without a
> > problem. Could it be something in the way the yenta_socket driver sets up
> > the controller? I was thinking of dumping the read/write's from the i82365
> > from 2.2.19, and comparing it to the yenta_socket driver. Do you think
> > this is worthwhile?
> 
> Did you make any progress on this?
> 
> I have similar problem. Probably, we could cooperate to find a way to solve
> this.
> 

This sounds suspiciously like the problem(s) I'm seeing with my Sony VAIO
and the 2.4.5 and 2.4.6* kernels.  It seems to work with RH 7.1 kernel
(2.4.2+) though....  I did notice some messages about IRQ routing problems,
but I'm not sure if they are really a problem...  Here is a piece of the boot sequence
from the 2.4.2 RH 7.1 kernel, via dmesg:
.....
Via 686a audio driver 1.1.14b
PCI: Found IRQ 10 for device 00:07.5
IRQ routing conflict in pirq table for device 00:07.5
IRQ routing conflict in pirq table for device 00:07.6
PCI: The same IRQ used for device 00:0a.1
PCI: The same IRQ used for device 00:10.0
via82cxxx: timeout while reading AC97 codec (0xAA0000)
.....

The full dmesg output is attached in case that helps.


> Seems, you are right, yenta.c corrupts something in hardware
> and the problem is not related to irqs. Observations are:
> 
> * No irqs are generated at all after lockup. Printk added at do_IRQ, no activity.
>   (Moreover, here yenta irq is not shared with vga, but shared with firewire
>    port though.) Nothing. I did not find any software activity at all.
> * No activity at pcmcia is required to lockup. Loading yenta_socket is enough.
> * Unloading yenta before lockup happened does not help, i.e. something
>   is corrupted at time of yenta_init().
> * Lockup _inevitably_ happens when yenta_init was executed once
>   and I make any operation from set:
>   1. any call to APM bios, except for cpu idle.
>   2. Pressing any hotkey, including change of LCD brightness
>      (Sic! The last event is _absolutely_ invisible to software,
>       so that yenta_init does something terrible with hardware).
> 
> linux-2.2 with pcmcia does work, so that puzzle really can be solved
> comparing operations made by both implementations. Did you make this?
> 
> Alexey Kuznetsov
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
--------------211C1C95A915C9DCB8AB4588
Content-Type: text/plain; charset=us-ascii;
 name="foo.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="foo.txt"

Linux version 2.4.2-2 (root@porky.devel.redhat.com) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-79)) #1 Sun Apr 8 20:41:30 EDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009f800 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000800 @ 000000000009f800 (reserved)
 BIOS-e820: 0000000000015c00 @ 00000000000ea400 (reserved)
 BIOS-e820: 0000000007ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000fc00 @ 0000000007ff0000 (ACPI data)
 BIOS-e820: 0000000000000400 @ 0000000007fffc00 (ACPI NVS)
 BIOS-e820: 0000000000020000 @ 00000000fffe0000 (reserved)
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone DMA has max 32 cached pages.
zone(1): 28656 pages.
zone Normal has max 223 cached pages.
zone(2): 0 pages.
zone HighMem has max 1 cached pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=305 BOOT_FILE=/boot/vmlinuz-2.4.2-2
Initializing CPU#0
Detected 800.052 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1595.80 BogoMIPS
Memory: 126412k/131008k available (1365k kernel code, 4208k reserved, 92k data, 236k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
VFS: Diskquotas version dquot_6.5.0 initialized
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Duron(tm) Processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd83d, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
  got res[10000000:10000fff] for resource 0 of Texas Instruments PCI1420
  got res[10001000:10001fff] for resource 0 of Texas Instruments PCI1420 (#2)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 83866kB/27955kB, 256 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0x1c40-0x1c47, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1c48-0x1c4f, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MHM2100AT, ATA DISK drive
hdc: HITACHI DVD-ROM GD-S200, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 19640880 sectors (10056 MB) w/2048KiB Cache, CHS=1222/255/63, UDMA(33)
Partition check:
 hda: hda1 hda2 < hda5 hda6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10d
md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md.c: sizeof(mdp_super_t) = 4096
autodetecting RAID arrays
autorun ...
... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 236k freed
Adding Swap: 265032k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.251 $ time 20:53:29 Apr  8 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Assigned IRQ 9 for device 00:07.2
PCI: The same IRQ used for device 00:07.3
PCI: The same IRQ used for device 00:0e.0
PCI: Setting latency timer of device 00:07.2 to 64
usb-uhci.c: USB UHCI at I/O 0x1c00, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 9 for device 00:07.3
PCI: The same IRQ used for device 00:07.2
PCI: The same IRQ used for device 00:0e.0
PCI: Setting latency timer of device 00:07.3 to 64
usb-uhci.c: USB UHCI at I/O 0x1c20, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: possible IRQ conflict!
0x378: ECP port cfgA=0x10 cfgB=0x00
0x378: ECP settings irq=<none or set by other means> dma=<none or set by other means>
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=0x378, irq=7
8139too Fast Ethernet driver 0.9.15 loaded
PCI: Assigned IRQ 10 for device 00:10.0
IRQ routing conflict in pirq table for device 00:07.5
IRQ routing conflict in pirq table for device 00:07.6
PCI: The same IRQ used for device 00:0a.1
PCI: Setting latency timer of device 00:10.0 to 64
eth0: RealTek RTL8139 Fast Ethernet at 0xc883d800, 08:00:46:1d:7b:d8, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Assigned IRQ 9 for device 00:0a.0
PCI: Found IRQ 10 for device 00:0a.1
IRQ routing conflict in pirq table for device 00:07.5
IRQ routing conflict in pirq table for device 00:07.6
PCI: The same IRQ used for device 00:10.0
Yenta IRQ list 0808, PCI irq9
Socket status: 30000010
Yenta IRQ list 0808, PCI irq10
Socket status: 30000010
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
eth1: NE2000 (DL10022 rev 30): io 0x300, irq 3, hw_addr 00:50:BA:70:69:F1
eth2: NE2000 (DL10022 rev 30): io 0x320, irq 11, hw_addr 00:50:BA:70:69:EC
NET4: Linux IPX 0.46 for NET4.0
IPX Portions Copyright (c) 1995 Caldera, Inc.
IPX Portions Copyright (c) 2000, 2001 Conectiva, Inc.
NET4: AppleTalk 0.18a for Linux NET4.0
eth1: MII is missing!
eth1: found link beat
eth1: autonegotiation complete: 100baseT-FD selected
eth2: MII is missing!
eth2: found link beat
eth2: autonegotiation complete: 100baseT-FD selected
mtrr: type mismatch for f5000000,800000 old: write-back new: write-combining
mtrr: type mismatch for f5000000,800000 old: write-back new: write-combining
Via 686a audio driver 1.1.14b
PCI: Found IRQ 10 for device 00:07.5
IRQ routing conflict in pirq table for device 00:07.5
IRQ routing conflict in pirq table for device 00:07.6
PCI: The same IRQ used for device 00:0a.1
PCI: The same IRQ used for device 00:10.0
via82cxxx: timeout while reading AC97 codec (0xAA0000)
ac97_codec: AC97 Audio codec, id: 0x4144:0x5348 (Analog Devices AD1881A)
via82cxxx: board #1 at 0x1000, IRQ 5
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12

--------------211C1C95A915C9DCB8AB4588--

