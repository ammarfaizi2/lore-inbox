Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277339AbRJJRs5>; Wed, 10 Oct 2001 13:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277341AbRJJRso>; Wed, 10 Oct 2001 13:48:44 -0400
Received: from [208.129.208.52] ([208.129.208.52]:48389 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S277339AbRJJRs1>;
	Wed, 10 Oct 2001 13:48:27 -0400
Date: Wed, 10 Oct 2001 10:54:12 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.11 uhci problem ( and maybe more ) ...
Message-ID: <Pine.LNX.4.40.0110101041150.984-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel 2.4.11 - gcc 3.0.1
I've got raced timeouts from uhci and a couple of complete kernel freeze.
No usb devices attached to my usb bus.
2.4.x , x <= 10 are fine



# dmesg
Linux version 2.4.11 (root@blue1.dev.mcafeelabs.com) (gcc version 3.0.1) #1 Wed Oct 10 10:22:16 PDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux-2.4.11 ro root=305 BOOT_FILE=/boot/vmlinuz-2.4.11
Initializing CPU#0
Detected 999.559 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1992.29 BogoMIPS
Memory: 255980k/262144k available (1174k kernel code, 5776k reserved, 332k data, 200k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb350, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
hda: WDC WD205BA, ATA DISK drive
hdb: CD-ROM 50X L, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 40088160 sectors (20525 MB) w/2048KiB Cache, CHS=2495/255/63
hdb: ATAPI 50X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 11 for device 00:14.0
PCI: Sharing IRQ 11 with 00:07.2
PCI: Sharing IRQ 11 with 00:07.3
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:02:B3:11:E5:92, IRQ 11.
  Board assembly 721383-016, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 204M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 32M @ 0xd4000000
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 11 for device 00:07.2
PCI: Sharing IRQ 11 with 00:07.3
PCI: Sharing IRQ 11 with 00:14.0
uhci.c: USB UHCI at I/O 0xd400, IRQ 11
usb.c: new USB bus registered, assigned bus number 1
usb: raced timeout, pipe 0x80000000 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
hub.c: USB hub found
usb: raced timeout, pipe 0x80000180 status 0 time left 0
hub.c: 2 ports detected
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
PCI: Found IRQ 11 for device 00:07.3
PCI: Sharing IRQ 11 with 00:07.2
PCI: Sharing IRQ 11 with 00:14.0
uhci.c: USB UHCI at I/O 0xd800, IRQ 11
usb.c: new USB bus registered, assigned bus number 2
usb: raced timeout, pipe 0x80000100 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
usb: raced timeout, pipe 0x80000000 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
hub.c: USB hub found
usb: raced timeout, pipe 0x80000180 status 0 time left 0
hub.c: 2 ports detected
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 200k freed
usb: raced timeout, pipe 0x80000100 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
Adding Swap: 530104k swap-space (priority -1)
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0


# cat /proc/interrupts
           CPU0
  0:      78783          XT-PIC  timer
  1:       1719          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
 11:      10357          XT-PIC  usb-uhci, usb-uhci, eth0
 12:       6358          XT-PIC  PS/2 Mouse
 14:      86465          XT-PIC  ide0
NMI:          0
ERR:          0


# cat /proc/driver/uhci/hc*
HC status
  usbcmd    =     0008   Maxp32 EGSM
  usbstat   =     0020   HCHalted
  usbint    =     000f
  usbfrnum  =   (1)cc4
  flbaseadd = 0ff30000
  sof       =       40
  stat1     =     0480
  stat2     =     0480
Frame List
Skeleton TD's
- skel_term_td
    [cff351b0] link (0ff351b0) e0 Length=0 MaxLen=7ff DT0 EndPt=0 Dev=7f,
PID=69(IN) (buf=00000000)
Skeleton QH's
HC status
  usbcmd    =     0008   Maxp32 EGSM
  usbstat   =     0020   HCHalted
  usbint    =     000f
  usbfrnum  =   (1)cc4
  flbaseadd = 0ff28000
  sof       =       40
  stat1     =     0480
  stat2     =     0480
Frame List
Skeleton TD's
- skel_term_td
    [cff2e1b0] link (0ff2e1b0) e0 Length=0 MaxLen=7ff DT0 EndPt=0 Dev=7f,
PID=69(IN) (buf=00000000)
Skeleton QH's





- Davide



