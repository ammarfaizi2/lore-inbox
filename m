Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLFMmZ>; Wed, 6 Dec 2000 07:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129423AbQLFMmO>; Wed, 6 Dec 2000 07:42:14 -0500
Received: from smtp.lax.megapath.net ([216.34.237.2]:39943 "EHLO
	smtp.lax.megapath.net") by vger.kernel.org with ESMTP
	id <S129183AbQLFMl7>; Wed, 6 Dec 2000 07:41:59 -0500
Message-ID: <3A2E2C95.10603@megapathdsl.net>
Date: Wed, 06 Dec 2000 04:09:57 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12 i686; en-US; m18) Gecko/20001202
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re:  The horrible hack from hell called A20
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reported problems with using my two Cardbus cards simultaneously
with previous test12 releases.  The behavior has changed with pre6.

#1

When I run "ifup eth0", I get an error message:

	SIOCADDRT: File exists
	SIOCADDRT: File exists

This happens even when my 3c575 Cardbus ethernet card is the
only Cardbus card inserted.  This behavior existed in pre4, too,
though.

#2

If I insert both my 3c575 and Belkin BusPort Mobile USB host-controller 
and then enable both of them, "modprobe usb-ohci" hangs.  If I then
attempt "modprobe -r 3c59x", that process hangs, too.  lsmod shows:

	usb-ohci     15072   1  (initializing)
	3c59x            0   0  (deleted)
	usbcore      50384   1  (autoclean) [usb-ohci]

Then, when I try to shut the machine down, the shutdown process
hangs when trying to close down eth0.

I am including my entire dmesg output.  I apologize for this, but
I am not sure what parts of the logfile are definitely irrelevant
to this report.

Linux version 2.4.0-test12 (root@agate) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #5 Wed Dec 6 00:48:18 PST 2000
BIOS-provided physical RAM map:
   BIOS-e820: 000000000009f800 @ 0000000000000000 (usable)
   BIOS-e820: 0000000000000800 @ 000000000009f800 (reserved)
   BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
   BIOS-e820: 0000000004f00000 @ 0000000000100000 (usable)
   BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009f800 for 4096 bytes.
On node 0 totalpages: 20480
zone(0): 4096 pages.
zone(1): 16384 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01156000)
Kernel command line: auto BOOT_IMAGE=Serial-Debug ro root=305
pci=biosirq console=ttyS0,38400 console=tty0
Initializing CPU#0
Detected 232.112 MHz processor.
Console: colour VGA+ 80x43
Calibrating delay loop... 462.03 BogoMIPS
Memory: 78616k/81920k available (1032k kernel code, 2916k reserved, 82k
data, 204k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU: Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 00
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfda13, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
    got res[10000000:10000fff] for resource 0 of Texas Instruments PCI1131
    got res[10001000:10001fff] for resource 0 of Texas Instruments
PCI1131 (#2)
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
      ide0: BM-DMA at 0xfcf0-0xfcf7, BIOS settings: hda:DMA, hdb:pio
      ide1: BM-DMA at 0xfcf8-0xfcff, BIOS settings: hdc:pio, hdd:pio
hda: TOSHIBA MK4006MAV, ATA DISK drive
hdc: TOSHIBA CD-ROM XM-1702BC, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 8007552 sectors (4100 MB), CHS=993/128/63, UDMA(33)
Partition check:
   /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 >
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Linux PCMCIA Card Services 3.1.22
    options:  [pci] [cardbus]
PCI: Enabling device 00:04.0 (0000 -> 0002)
PCI: Assigned IRQ 11 for device 00:04.0
PCI: Enabling device 00:04.1 (0000 -> 0002)
PCI: Assigned IRQ 11 for device 00:04.1
Intel PCIC probe: not found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x2
Yenta IRQ list 0698, PCI irq11
Socket status: 30000006
Yenta IRQ list 0698, PCI irq11
Socket status: 30000020
cs: cb_alloc(bus 1): vendor 0x10b7, device 0x5157
    got res[1000:107f] for resource 0 of PCI device 10b7:5157
    got res[10800000:1080007f] for resource 1 of PCI device 10b7:5157
    got res[10800080:108000ff] for resource 2 of PCI device 10b7:5157
    got res[10400000:1041ffff] for resource 6 of PCI device 10b7:5157
PCI: Enabling device 01:00.0 (0000 -> 0003)
PCI: Found IRQ 11 for device 01:00.0
PCI: The same IRQ used for device 00:04.0
call_usermodehelper[/sbin/hotplug]: no root fs
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 204k freed
Adding Swap: 108824k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
3c59x.c:LK1.1.11 13 Nov 2000  Donald Becker and others.
http://www.scyld.com/network/vortex.html $Revision: 1.102.2.46 $
See Documentation/networking/vortex.txt
eth0: 3Com PCI 3CCFE575BT Cyclone CardBus at 0x1000, PCI: Found IRQ 11
for device 01:00.0
PCI: The same IRQ used for device 00:04.0
PCI: Setting latency timer of device 01:00.0 to 64
   00:10:4b:7c:9d:9d, IRQ 11
eth0: CardBus functions mapped 10800080->c5840080
    8K byte-wide RAM 5:3 Rx:Tx split, MII interface.
    MII transceiver found at address 0, status 782d.
    Enabling bus-master transmits and whole-frame receives.
eth0: using default media MII
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
snd: cs4231: port = 0x530, id = 0xa
snd: CS4231: VERSION (I25) = 0x3
snd: CS4231: ext version; rev = 0xe8, id = 0xe8
snd: CS4236: [0xf00] C1 (version) = 0xe8, ext = 0xe8
cs: cb_alloc(bus 5): vendor 0x1045, device 0xc861
    got res[11000000:11000fff] for resource 0 of PCI device 1045:c861
PCI: Enabling device 05:00.0 (0000 -> 0002)
PCI: Found IRQ 11 for device 05:00.0
PCI: The same IRQ used for device 00:04.0
PCI: The same IRQ used for device 01:00.0
PCI: Found IRQ 11 for device 05:00.0
PCI: The same IRQ used for device 00:04.0
PCI: The same IRQ used for device 01:00.0
PCI: Setting latency timer of device 05:00.0 to 64
usb-ohci.c: USB OHCI at membase 0xc586b000, IRQ 11
usb-ohci.c: usb-05:00.0, PCI device 1045:c861
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF c2a60720, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: c586b000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c2a60720
usb.c: kusbd: /sbin/hotplug add 1
hub.c: port 2 connection change
hub.c: port 2, portstatus 301, change 1, 1.5 Mb/s
hub.c: port 2, portstatus 303, change 10, 1.5 Mb/s
hub.c: USB new device connect on bus1/2, assigned device number 2
usb.c: kmalloc IF c2a603a0, numif 1
usb.c: skipped 1 class/vendor specific interface descriptors
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
usb.c: USB device number 2 default language ID 0x409
Manufacturer: Microsoft
Product: Microsoft IntelliMouse&reg; Optical
usb.c: unhandled interfaces on device
usb.c: USB device 2 (vend/prod 0x45e/0x29) is not claimed by any active
driver.
    Length              = 18
    DescriptorType      = 01
    USB version         = 1.10
    Vendor:Product      = 045e:0029
    MaxPacketSize0      = 8
    NumConfigurations   = 1
    Device version      = 1.08
    Device Class:SubClass:Protocol = 00:00:00
      Per-interface classes
Configuration:
    bLength             =    9
    bDescriptorType     =   02
    wTotalLength        = 0022
    bNumInterfaces      =   01
    bConfigurationValue =   01
    iConfiguration      =   00
    bmAttributes        =   a0
    MaxPower            =  100mA

    Interface: 0
    Alternate Setting:  0
      bLength             =    9
      bDescriptorType     =   04
      bInterfaceNumber    =   00
      bAlternateSetting   =   00
      bNumEndpoints       =   01
      bInterface Class:SubClass:Protocol =   03:01:02
      iInterface          =   00
      Endpoint:
        bLength             =    7
        bDescriptorType     =   05
        bEndpointAddress    =   81 (in)
        bmAttributes        =   03 (Interrupt)
        wMaxPacketSize      = 0004
        bInterval           =   0a
usb.c: kusbd: /sbin/hotplug add 2



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
