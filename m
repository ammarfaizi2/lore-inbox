Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282006AbRKUXvx>; Wed, 21 Nov 2001 18:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282003AbRKUXvh>; Wed, 21 Nov 2001 18:51:37 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:45835 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S282001AbRKUXvQ>;
	Wed, 21 Nov 2001 18:51:16 -0500
Date: Wed, 21 Nov 2001 23:51:07 +0000 (GMT)
From: Dave Airlie <airlied@skynet.ie>
X-X-Sender: <airlied@skynet>
To: <linux-kernel@vger.kernel.org>
Subject: PCMCIA and APM/ACPI issue (xircom card problem)
Message-ID: <Pine.LNX.4.32.0111212340001.25503-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I reported an issue with later kernels with Xircom adapter not showing up
in /proc/pci and not functioning properly... I took the time to track it
down and have discovered the root cause of the problem ..

2.4.10 was working for me so I went back and conducted my experiments with
it .. I'm using PCMCIA 3.1.29 also.

with 2.4.10 with CONFIG_PM, CONFIG_ACPI and CONFIG_APM=m it doesn't work.
with 2.4.10 with CONFIG_PM, CONFIG_ACPI and no CONFIG_APM it doesn't
work.
with 2.4.10 with CONFIG_PM, CONFIG_ACPI off, and CONFIG_APM=m it does
work..

each time I rebuilt the pcmcia-cs package against the new kernel and
installed it ..

below are four files... lspci -xv -H1  and dmesg for the kernels with ACPI
and APM on... lspci -xv doesn't work it gives some can't read 64 bytes of
configuration space.

the same problem is there in 2.4.15-pre4 also ... I might go try and get
the results with 2.4.15-pre8 and pcmcia-16Nov if I get a chance..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person

dmesg_acpi_on_2_4_10_pcmcia_3.1.29

Linux version 2.4.10-da1 (root@radon) (gcc version 2.95.2 19991024 (release)) #1 Wed Nov 21 23:27:49 GMT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000cc000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007fec000 (usable)
 BIOS-e820: 0000000007fec000 - 0000000007ff0000 (reserved)
 BIOS-e820: 00000000100a0000 - 0000000010100000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
On node 0 totalpages: 32748
zone(0): 4096 pages.
zone(1): 28652 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Kernel command line: BOOT_IMAGE=linux-old ro root=306 vga=0x0301 noinitrd
Initializing CPU#0
Detected 430.141 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 858.52 BogoMIPS
Memory: 127192k/130992k available (778k kernel code, 3412k reserved, 187k data, 180k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Celeron (Mendocino) stepping 0a
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfc0be, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
  got res[10000000:10000fff] for resource 0 of Texas Instruments PCI1225
  got res[10001000:10001fff] for resource 0 of Texas Instruments PCI1225 (#2)
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
devfs: v0.116 (20010919) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
ACPI: Core Subsystem version [20010831]
ACPI: Subsystem enabled
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0860-0x0867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x0868-0x086f, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MHH2064AT, ATA DISK drive
hdc: TORiSAN DVD-ROM DRD-U624, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 12685680 sectors (6495 MB) w/512KiB Cache, CHS=789/255/63, UDMA(33)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p3 < p5 p6 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 180k freed
Adding Swap: 136512k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.268 $ time 23:09:52 Nov 21 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 11 for device 00:07.2
PCI: Sharing IRQ 11 with 00:03.0
PCI: Sharing IRQ 11 with 00:03.1
usb-uhci.c: USB UHCI at I/O 0xdce0, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF c7d4e8a0, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: dce0
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c7d4e8a0
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
PCI: Found IRQ 5 for device 00:08.0
maestro: Configuring ESS Maestro 2E found at IO 0xD800 IRQ 5
maestro:  subvendor id: 0x00ab1028
maestro: PCI power management capability: 0x7622
maestro: AC97 Codec detected: v: 0x83847609 caps: 0x6940 pwr: 0xf
maestro: 1 channels configured.
maestro: version 0.15 time 23:09:12 Nov 21 2001
Linux PCMCIA Card Services 3.1.29
  kernel build: 2.4.10-da1 #1 Wed Nov 21 23:27:49 GMT 2001
  options:  [pci] [cardbus] [apm]
Intel ISA/PCI/CardBus PCIC probe:
PCI: Found IRQ 11 for device 00:03.0
PCI: Sharing IRQ 11 with 00:03.1
PCI: Sharing IRQ 11 with 00:07.2
PCI: Found IRQ 11 for device 00:03.1
PCI: Sharing IRQ 11 with 00:03.0
PCI: Sharing IRQ 11 with 00:07.2
  TI 1225 rev 01 PCI-to-CardBus at slot 00:03, mem 0x10000000
    host opts [0]: [ring] [serial pci & irq] [pci irq 11] [lat 32/32] [bus 4/4]
    host opts [1]: [ring] [serial pci & irq] [pci irq 11] [lat 32/32] [bus 5/5]
spurious 8259A interrupt: IRQ7.
    ISA irqs (scanned) = 3,4,7,10 PCI status changes
cs: cb_alloc(bus 4): vendor 0xffff, device 0xffff

lspci -xv -H1 for ACPI

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
	Flags: bus master, medium devsel, latency 32
	Memory at f4000000 (32-bit, prefetchable)
	Capabilities: [a0] AGP version 1.0
00: 86 80 90 71 06 01 10 22 03 00 00 06 00 20 00 00
10: 08 00 00 f4 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fc000000-feffffff
00: 86 80 91 71 1f 01 20 02 03 00 04 06 00 20 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 20 e0 e0 a0 22
20: 00 fc f0 fe f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 8c 00

00:03.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 00ab
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at 10000000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0001
00: 4c 10 1c ac 07 00 10 02 01 00 07 06 08 20 82 00
10: 00 00 00 10 a0 00 00 22 00 04 04 20 00 00 00 60
20: 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 80 06
40: 28 10 ab 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 00ab
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at 10001000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0001
00: 4c 10 1c ac 07 00 10 02 01 00 07 06 08 20 82 00
10: 00 10 00 10 a0 00 00 02 00 05 05 20 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 c0 07
40: 28 10 ab 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Flags: bus master, medium devsel, latency 0
00: 86 80 10 71 0f 01 80 02 02 00 80 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 32
	I/O ports at 0860
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 61 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at dce0
00: 86 80 12 71 05 00 80 02 01 00 03 0c 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: e1 dc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 00

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
	Flags: medium devsel
00: 86 80 13 71 03 00 80 02 03 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 10)
	Subsystem: Dell Computer Corporation: Unknown device 00ab
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at d800
	Capabilities: [c0] Power Management version 2
00: 5d 12 78 19 05 00 90 02 10 00 01 04 00 20 00 00
10: 01 d8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 ab 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 05 01 02 18

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage P/M Mobility AGP 2x (rev 64) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 00ab
	Flags: bus master, stepping, medium devsel, latency 32, IRQ 11
	Memory at fd000000 (32-bit, non-prefetchable)
	I/O ports at ec00
	Memory at fcfff000 (32-bit, non-prefetchable)
	Capabilities: [50] AGP version 1.0
	Capabilities: [5c] Power Management version 1
00: 02 10 4d 4c 87 00 90 02 64 00 00 03 08 20 00 00
10: 00 00 00 fd 01 ec 00 00 00 f0 ff fc 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 ab 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 08 00

04:00.0 Ethernet controller: Xircom Cardbus Ethernet 10/100 (rev 03)
	Subsystem: Xircom Cardbus Ethernet 10/100
	Flags: medium devsel, IRQ 255
	I/O ports at <unassigned> [disabled]
	Capabilities: [dc] Power Management version 1
00: 5d 11 03 00 00 00 10 02 03 00 00 02 00 00 80 00
10: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 07 01 00 00 5d 11 81 11
30: 00 00 00 00 dc 00 00 00 00 00 00 00 ff 01 14 28

04:00.1 Serial controller: Xircom Cardbus Ethernet + 56k Modem (rev 03) (prog-if 02 [16550])
	Subsystem: Xircom CBEM56G-100 Ethernet + 56k Modem
	Flags: medium devsel, IRQ 255
	I/O ports at <unassigned> [disabled]
	Capabilities: [dc] Power Management version 1
00: 5d 11 03 01 00 00 10 02 03 02 00 07 00 00 80 00
10: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 07 02 00 00 5d 11 81 11
30: 00 00 00 00 dc 00 00 00 00 00 00 00 ff 01 00 00

dmesg for APM

Linux version 2.4.10-da1 (root@radon) (gcc version 2.95.2 19991024 (release)) #1 Wed Nov 21 23:43:52 GMT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000cc000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007fec000 (usable)
 BIOS-e820: 0000000007fec000 - 0000000007ff0000 (reserved)
 BIOS-e820: 00000000100a0000 - 0000000010100000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
On node 0 totalpages: 32748
zone(0): 4096 pages.
zone(1): 28652 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Kernel command line: BOOT_IMAGE=linux-old ro root=306 vga=0x0301 noinitrd
Initializing CPU#0
Detected 430.143 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 858.52 BogoMIPS
Memory: 127292k/130992k available (698k kernel code, 3312k reserved, 172k data, 180k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Celeron (Mendocino) stepping 0a
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfc0be, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
  got res[10000000:10000fff] for resource 0 of Texas Instruments PCI1225
  got res[10001000:10001fff] for resource 0 of Texas Instruments PCI1225 (#2)
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
devfs: v0.116 (20010919) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0860-0x0867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x0868-0x086f, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MHH2064AT, ATA DISK drive
hdc: TORiSAN DVD-ROM DRD-U624, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 12685680 sectors (6495 MB) w/512KiB Cache, CHS=789/255/63, UDMA(33)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p3 < p5 p6 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 180k freed
Adding Swap: 136512k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.268 $ time 23:09:52 Nov 21 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 11 for device 00:07.2
PCI: Sharing IRQ 11 with 00:03.0
PCI: Sharing IRQ 11 with 00:03.1
usb-uhci.c: USB UHCI at I/O 0xdce0, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF c7a7f200, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: dce0
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c7a7f200
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
PCI: Found IRQ 5 for device 00:08.0
maestro: Configuring ESS Maestro 2E found at IO 0xD800 IRQ 5
maestro:  subvendor id: 0x00ab1028
maestro: PCI power management capability: 0x7622
maestro: AC97 Codec detected: v: 0x83847609 caps: 0x6940 pwr: 0xf
maestro: 1 channels configured.
maestro: version 0.15 time 23:09:12 Nov 21 2001
Linux PCMCIA Card Services 3.1.29
  kernel build: 2.4.10-da1 #1 Wed Nov 21 23:43:52 GMT 2001
  options:  [pci] [cardbus] [apm]
Intel ISA/PCI/CardBus PCIC probe:
PCI: Found IRQ 11 for device 00:03.0
PCI: Sharing IRQ 11 with 00:03.1
PCI: Sharing IRQ 11 with 00:07.2
PCI: Found IRQ 11 for device 00:03.1
PCI: Sharing IRQ 11 with 00:03.0
PCI: Sharing IRQ 11 with 00:07.2
  TI 1225 rev 01 PCI-to-CardBus at slot 00:03, mem 0x10000000
    host opts [0]: [ring] [serial pci & irq] [pci irq 11] [lat 32/32] [bus 2/5]
    host opts [1]: [ring] [serial pci & irq] [pci irq 11] [lat 32/32] [bus 6/9]
spurious 8259A interrupt: IRQ7.
    ISA irqs (scanned) = 3,4,7,10 PCI status changes
cs: cb_alloc(bus 2): vendor 0x115d, device 0x0003
ROM image dump:
  image 0: 0x000000-0x0001ff, signature PCIR
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
PCI: No IRQ known for interrupt pin A of device . Please try using pci=biosirq.
register_serial(): autoconfig failed
cs: cb_config(bus 2)
cs: IO port probe 0x0100-0x04ff: excluding 0x280-0x287 0x378-0x37f 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0288-0x0377: clean.
cs: IO port probe 0x0380-0x03bf: clean.
cs: IO port probe 0x03e0-0x04cf: clean.
cs: IO port probe 0x04d8-0x04ff: clean.
cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x84f
cs: IO port probe 0x0a00-0x0aff: clean.
cs: IO port probe 0x0c00-0x0cff: clean.
  fn 0 bar 2: mem 0x60013000-0x600137ff
  fn 0 bar 3: mem 0x60012000-0x600127ff
  fn 1 bar 1: io 0x480-0x487
  fn 1 bar 2: mem 0x60011000-0x600117ff
  fn 1 bar 3: mem 0x60010000-0x600107ff
  fn 0 bar 1: io 0x400-0x47f
  fn 0 rom: mem 0x6000c000-0x6000ffff
  fn 1 rom: mem 0x60008000-0x6000bfff
  irq 11
cs: cb_enable(bus 2)
  bridge io map 0 (flags 0x21): 0x400-0x487
  bridge mem map 0 (flags 0x1): 0x60008000-0x60013fff
tulip_attach(device 02:00.0)
tulip.c:v0.91g-ppc 7/16/99 becker@scyld.com (modified by danilo@cs.uni-magdeburg.de for XIRCOM CBE, fixed by Doug Ledford)
eth0: Xircom Cardbus Adapter (DEC 21143 compatible mode) rev 3 at 0x400, 00:10:A4:C4:3F:54, IRQ 11.
eth0:  MII transceiver #0 config 3100 status 7809 advertising 01e1.
serial_attach(device 02:00.1)
ttyS04 at port 0x0480 (irq = 11) is a 16550A
Trying to free nonexistent resource <00000480-00000487>
Trying to free nonexistent resource <00000480-00000487>

lspci for APM

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
	Flags: bus master, medium devsel, latency 32
	Memory at f4000000 (32-bit, prefetchable)
	Capabilities: [a0] AGP version 1.0
00: 86 80 90 71 06 01 10 22 03 00 00 06 00 20 00 00
10: 08 00 00 f4 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fc000000-feffffff
00: 86 80 91 71 1f 01 20 02 03 00 04 06 00 20 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 20 e0 e0 a0 22
20: 00 fc f0 fe f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 8c 00

00:03.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 00ab
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at 10000000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=32
	Memory window 0: 60008000-60013000
	I/O window 0: 00000400-00000487
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0001
00: 4c 10 1c ac 07 00 10 02 01 00 07 06 08 20 82 00
10: 00 00 00 10 a0 00 00 22 00 02 05 20 00 80 00 60
20: 00 30 01 60 00 00 00 00 00 00 00 00 00 04 00 00
30: 84 04 00 00 00 00 00 00 00 00 00 00 0b 01 00 06
40: 28 10 ab 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 00ab
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at 10001000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=32
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0001
00: 4c 10 1c ac 07 00 10 02 01 00 07 06 08 20 82 00
10: 00 10 00 10 a0 00 00 02 00 06 09 20 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 c0 07
40: 28 10 ab 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Flags: bus master, medium devsel, latency 0
00: 86 80 10 71 0f 01 80 02 02 00 80 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 32
	I/O ports at 0860
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 61 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at dce0
00: 86 80 12 71 05 00 80 02 01 00 03 0c 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: e1 dc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 00

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
	Flags: medium devsel
00: 86 80 13 71 03 00 80 02 03 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 10)
	Subsystem: Dell Computer Corporation: Unknown device 00ab
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at d800
	Capabilities: [c0] Power Management version 2
00: 5d 12 78 19 05 00 90 02 10 00 01 04 00 20 00 00
10: 01 d8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 ab 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 05 01 02 18

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage P/M Mobility AGP 2x (rev 64) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 00ab
	Flags: bus master, stepping, medium devsel, latency 32, IRQ 11
	Memory at fd000000 (32-bit, non-prefetchable)
	I/O ports at ec00
	Memory at fcfff000 (32-bit, non-prefetchable)
	Capabilities: [50] AGP version 1.0
	Capabilities: [5c] Power Management version 1
00: 02 10 4d 4c 87 00 90 02 64 00 00 03 08 20 00 00
10: 00 00 00 fd 01 ec 00 00 00 f0 ff fc 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 ab 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 08 00

02:00.0 Ethernet controller: Xircom Cardbus Ethernet 10/100 (rev 03)
	Subsystem: Xircom Cardbus Ethernet 10/100
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at 0400
	Memory at 60013000 (32-bit, non-prefetchable)
	Memory at 60012000 (32-bit, non-prefetchable)
	Expansion ROM at 6000c000
	Capabilities: [dc] Power Management version 1
00: 5d 11 03 00 07 00 10 02 03 00 00 02 08 40 80 00
10: 01 04 00 00 00 30 01 60 00 20 01 60 00 00 00 00
20: 00 00 00 00 00 00 00 00 07 01 00 00 5d 11 81 11
30: 01 c0 00 60 dc 00 00 00 00 00 00 00 0b 01 14 28

02:00.1 Serial controller: Xircom Cardbus Ethernet + 56k Modem (rev 03) (prog-if 02 [16550])
	Subsystem: Xircom CBEM56G-100 Ethernet + 56k Modem
	Flags: medium devsel, IRQ 11
	I/O ports at 0480
	Memory at 60011000 (32-bit, non-prefetchable)
	Memory at 60010000 (32-bit, non-prefetchable)
	Expansion ROM at 60008000
	Capabilities: [dc] Power Management version 1
00: 5d 11 03 01 03 00 10 02 03 02 00 07 00 00 80 00
10: 81 04 00 00 00 10 01 60 00 00 01 60 00 00 00 00
20: 00 00 00 00 00 00 00 00 07 02 00 00 5d 11 81 11
30: 01 80 00 60 dc 00 00 00 00 00 00 00 0b 01 00 00


