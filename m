Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbUBVQFy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 11:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUBVQFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 11:05:54 -0500
Received: from dns.communicationvalley.it ([212.239.58.133]:36997 "HELO
	rose.communicationvalley.it") by vger.kernel.org with SMTP
	id S261585AbUBVQFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 11:05:07 -0500
From: Silla Rizzoli <silla@netvalley.it>
Organization: Communication Valley spa
To: daniel.ritz@gmx.ch
Subject: Re: 2.4.25 yenta problem and small fix/workaround
Date: Sun, 22 Feb 2004 17:03:54 +0100
User-Agent: KMail/1.6
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200402202331.45218.daniel.ritz@gmx.ch> <200402211328.56826.silla@netvalley.it> <200402211812.14040.daniel.ritz@gmx.ch>
In-Reply-To: <200402211812.14040.daniel.ritz@gmx.ch>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qLNOAN9n8f48kEZ"
Message-Id: <200402221703.55235.silla@netvalley.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_qLNOAN9n8f48kEZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> On Saturday 21 February 2004 13:28, Silla Rizzoli wrote:
> > > the CB_CDETECT1 and CB_CDETECT2 bits both should be 0 for the card
> > > being recognized correctly (and one of the voltage bits need to be set)
> >
> > Nope, sorry, same behaviour. :(
>
> either voltage interrogation is still not redone or one of
> CB_CDETECT1,CB_CDETECT2 is still set afterwards...
>
> could you apply the attached patch (on top of my previous patch) and send
> the output of dmesg?
>
> thanx
> -daniel

Hello,
while testing your last patch I noticed a strange thing...
...
mice: PS/2 mouse device common for all mice
yenta_get_status: socket e1d2b700 state 30000087
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
yenta_get_status: socket e1d2b700 state 30000087
SCSI subsystem driver Revision: 1.00

This is dmesg after bootup completes: if I insert the card nothing happens, 
but if I start X, the card gets magically recognized and initialized! 
The following lines are added to dmesg:

Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Intel i845 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] AGP 0.99 Aperture @ 0xe0000000 64MB
[drm] Initialized radeon 1.7.0 20020828 on minor 0
PCI: Found IRQ 11 for device 01:00.0
PCI: Sharing IRQ 11 with 00:1d.0
yenta_get_status: socket e1d2b700 state 30000511
yenta_get_status: socket e1d2b700 state 30000511
yenta_get_status: socket e1d2b700 state 30000519
yenta_get_status: socket e1d2b700 state 30000519
yenta_get_status: socket e1d2b700 state 30000519
yenta_get_status: socket e1d2b700 state 30000559
cs: memory probe 0xa0000000-0xa0ffffff: clean.
yenta_get_status: socket e1d2b700 state 30000559
airo:  Probing for PCI adapters
airo:  Finished probing for PCI adapters
airo: Doing fast bap_reads
airo: MAC enabled eth1 0:9:b7:c4:51:31
eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f
PCI: Found IRQ 11 for device 01:00.0
PCI: Sharing IRQ 11 with 00:1d.0

Here I stopped the pcmcia service: this unloads all the pccard modules:

yenta_get_status: socket e1d2b700 state 30000511
yenta_get_status: socket e1d2b700 state 30000511
yenta_get_status: socket e1d2b700 state 30000519
yenta_get_status: socket e1d2b700 state 30000519
yenta_get_status: socket e1d2b700 state 30000519
yenta_get_status: socket e1d2b700 state 30000559
cs: memory probe 0xa0000000-0xa0ffffff: clean.
yenta_get_status: socket e1d2b700 state 30000559
airo:  Probing for PCI adapters
airo:  Finished probing for PCI adapters
airo: Doing fast bap_reads
airo: MAC enabled eth1 0:9:b7:c4:51:31
eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f
PCI: Found IRQ 11 for device 01:00.0
PCI: Sharing IRQ 11 with 00:1d.0
yenta_config_init socket e1d2b700 state 30000559
unloading Kernel Card Services

Restarting pcmcia services...

Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 02:00.0
PCI: Sharing IRQ 11 with 00:1d.1
yenta_config_init socket e1d2b700 state 30000187
Yenta ISA IRQ mask 0x06f8, PCI irq 11
Socket status: 30000007
yenta_config_init socket e1d2b700 state 30000007
yenta_get_status: socket e1d2b700 state 30000087
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
yenta_get_status: socket e1d2b700 state 30000087

Inserting card one more time, it now gets initialized correctly:

yenta_get_status: socket e1d2b700 state 30000411
yenta_get_status: socket e1d2b700 state 30000411
yenta_get_status: socket e1d2b700 state 30000419
yenta_get_status: socket e1d2b700 state 30000419
yenta_get_status: socket e1d2b700 state 30000419
yenta_get_status: socket e1d2b700 state 30000459
cs: memory probe 0xa0000000-0xa0ffffff: clean.
yenta_get_status: socket e1d2b700 state 30000459
airo:  Probing for PCI adapters
airo:  Finished probing for PCI adapters
airo: Doing fast bap_reads
airo: MAC enabled eth1 0:9:b7:c4:51:31
eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f

Here I shutdown and restart the pcmcia services without extracting the card: 
once again everything works fine:

yenta_config_init socket e1d2b700 state 30000459
unloading Kernel Card Services
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 02:00.0
PCI: Sharing IRQ 11 with 00:1d.1
yenta_config_init socket e1d2b700 state 30000411
Yenta ISA IRQ mask 0x06f8, PCI irq 11
Socket status: 30000011
yenta_config_init socket e1d2b700 state 30000011
yenta_get_status: socket e1d2b700 state 30000411
yenta_get_status: socket e1d2b700 state 30000411
yenta_get_status: socket e1d2b700 state 30000419
yenta_get_status: socket e1d2b700 state 30000419
yenta_get_status: socket e1d2b700 state 30000419
yenta_get_status: socket e1d2b700 state 30000459
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
yenta_get_status: socket e1d2b700 state 30000459
cs: memory probe 0xa0000000-0xa0ffffff: clean.
yenta_get_status: socket e1d2b700 state 30000459
airo:  Probing for PCI adapters
airo:  Finished probing for PCI adapters
airo: Doing fast bap_reads
airo: MAC enabled eth1 0:9:b7:c4:51:31
eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f

After exiting X the card is only recognized if the pcmcia service is started 
with the card inserted. I attached the full dmesg and three lsmods. The first 
right after bootup (and after inserting the pc card, which by the way logs 
nothing), the second one after starting X and the third after exiting X.

Hope this helps,
Silla





--Boundary-00=_qLNOAN9n8f48kEZ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.txt"

Linux version 2.4.25 (root@mermaid) (gcc version 3.3.2 20031218 (Gentoo Linux 3.3.2-r5, propolice-3.3-7)) #1 Fri Feb 20 10:49:43 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff50000 (usable)
 BIOS-e820: 000000001ff50000 - 000000001ff68000 (ACPI data)
 BIOS-e820: 000000001ff68000 - 000000001ff7a000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130896
zone(0): 4096 pages.
zone(1): 126800 pages.
zone(2): 0 pages.
IBM machine detected. Enabling interrupts during APM calls.
Kernel command line: root=/dev/hda3 vga=792 hdc=ide-scsi
ide_setup: hdc=ide-scsi
No local APIC present or hardware disabled
Initializing CPU#0
Detected 1794.223 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 3578.26 BogoMIPS
Memory: 515144k/523584k available (1471k kernel code, 8052k reserved, 531k data, 124k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebf9ff 00000000 00000000 00000000
CPU:             Common caps: bfebf9ff 00000000 00000000 00000000
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 1.80GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd936, last bus=5
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
PCI: Using IRQ router PIIX/ICH [8086/24cc] at 00:1f.0
PCI: Found IRQ 11 for device 00:1f.1
PCI: Sharing IRQ 11 with 00:1d.2
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
PCI: Found IRQ 11 for device 01:00.0
PCI: Sharing IRQ 11 with 00:1d.0
radeonfb: ref_clk=2700, ref_div=60, xclk=14400 from BIOS
radeonfb: panel ID string: 1024x768                
radeonfb: detected LCD panel size from BIOS: 1024x768
Console: switching to colour frame buffer device 128x48
radeonfb: ATI Radeon M6 LY DDR SGRAM 16 MB
radeonfb: DVI port LCD monitor connected
radeonfb: CRT port no monitor connected
vesafb: abort, cannot reserve video memory at 0xe8000000
vesafb: framebuffer at 0xe8000000, mapped to 0xe1806000, size 4608k
vesafb: mode is 1024x768x24, linelength=3072, pages=6
vesafb: protected mode interface info at c000:52e9
vesafb: scrolling: redraw
vesafb: directcolor: size=0:8:8:8, shift=0:16:8:0
fb1: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
PCI: Found IRQ 11 for device 00:1f.6
PCI: Sharing IRQ 11 with 00:1f.3
PCI: Sharing IRQ 11 with 00:1f.5
i810_rng: RNG not detected
floppy0: no floppy controllers found
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PCI: Found IRQ 11 for device 00:1f.1
PCI: Sharing IRQ 11 with 00:1d.2
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23EA-20B, ATA DISK drive
blk: queue c0346b80, I/O limit 4095Mb (mask 0xffffffff)
hdc: UJDA730 DVD/CDRW, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 39070080 sectors (20004 MB) w/2048KiB Cache, CHS=2584/240/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0:<7>ldm_validate_partition_table(): Found an MS-DOS partition table, not a dynamic disk.
 p1 p2 p3
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
kjournald starting.  Commit interval 5 seconds
EXT3-fs: ide0(3,3): orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 180794
EXT3-fs: ide0(3,3): 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 124k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 1005472k swap-space (priority -1)
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
Intel(R) PRO/100 Network Driver - version 2.3.38-k1
Copyright (c) 2004 Intel Corporation

PCI: Found IRQ 11 for device 02:08.0
e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled

Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 02:00.0
PCI: Sharing IRQ 11 with 00:1d.1
yenta_config_init socket e1d2b700 state 30000117
Yenta ISA IRQ mask 0x06f8, PCI irq 11
Socket status: 30000007
yenta_config_init socket e1d2b700 state 30000007
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
Real Time Clock Driver v1.10f
PCI: Found IRQ 11 for device 00:1f.5
PCI: Sharing IRQ 11 with 00:1f.3
PCI: Sharing IRQ 11 with 00:1f.6
PCI: Setting latency timer of device 00:1f.5 to 64
intel8x0: clocking to 48000
slamr: SmartLink AMRMO modem.
slamr: probe 8086:24c6 ICH4 card...
PCI: Found IRQ 11 for device 00:1f.6
PCI: Sharing IRQ 11 with 00:1f.3
PCI: Sharing IRQ 11 with 00:1f.5
PCI: Setting latency timer of device 00:1f.6 to 64
slamr: mc97 codec is SIL27
slamr: slamr0 is ICH4 card.
devfs_register(slamr0): could not append to parent, err: -17
PCI: Found IRQ 11 for device 00:1d.7
PCI: Setting latency timer of device 00:1d.7 to 64
ehci_hcd 00:1d.7: Intel Corp. 82801DB USB2
ehci_hcd 00:1d.7: irq 11, pci mem e1dc5000
usb.c: new USB bus registered, assigned bus number 1
ehci_hcd 00:1d.7: enabled 64bit PCI DMA
PCI: cache line size of 128 is not supported by device 00:1d.7
ehci_hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29/2.4
hub.c: USB hub found
hub.c: 6 ports detected
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 11 for device 00:1d.0
PCI: Sharing IRQ 11 with 01:00.0
PCI: Setting latency timer of device 00:1d.0 to 64
uhci.c: USB UHCI at I/O 0x1800, IRQ 11
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 11 for device 00:1d.1
PCI: Sharing IRQ 11 with 02:00.0
PCI: Setting latency timer of device 00:1d.1 to 64
uhci.c: USB UHCI at I/O 0x1820, IRQ 11
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 11 for device 00:1d.2
PCI: Sharing IRQ 11 with 00:1f.1
PCI: Setting latency timer of device 00:1d.2 to 64
uhci.c: USB UHCI at I/O 0x1840, IRQ 11
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: new USB device 00:1d.1-1, assigned address 2
usb.c: USB device 2 (vend/prod 0xa12/0x1) is not claimed by any active driver.
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
BlueZ Core ver 2.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ HCI USB driver ver 2.4 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
usb.c: registered new driver hci_usb
hub.c: new USB device 00:1d.1-2, assigned address 3
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb.c: USB device 3 (vend/prod 0x45e/0x7d) is not claimed by any active driver.
usb.c: registered new driver hiddev
usb.c: registered new driver hid
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
input: USB HID v1.00 Mouse [Microsoft Microsoft 3-Button Mouse with IntelliEye?] on usb3:3.0
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
yenta_get_status: socket e1d2b700 state 30000087
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
yenta_get_status: socket e1d2b700 state 30000087
SCSI subsystem driver Revision: 1.00
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Intel i845 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] AGP 0.99 Aperture @ 0xe0000000 64MB
[drm] Initialized radeon 1.7.0 20020828 on minor 0
PCI: Found IRQ 11 for device 01:00.0
PCI: Sharing IRQ 11 with 00:1d.0
yenta_get_status: socket e1d2b700 state 30000511
yenta_get_status: socket e1d2b700 state 30000511
yenta_get_status: socket e1d2b700 state 30000519
yenta_get_status: socket e1d2b700 state 30000519
yenta_get_status: socket e1d2b700 state 30000519
yenta_get_status: socket e1d2b700 state 30000559
cs: memory probe 0xa0000000-0xa0ffffff: clean.
yenta_get_status: socket e1d2b700 state 30000559
airo:  Probing for PCI adapters
airo:  Finished probing for PCI adapters
airo: Doing fast bap_reads
airo: MAC enabled eth1 0:9:b7:c4:51:31
eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f
yenta_config_init socket e1d2b700 state 30000559
unloading Kernel Card Services
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 02:00.0
PCI: Sharing IRQ 11 with 00:1d.1
yenta_config_init socket e1d2b700 state 30000117
Yenta ISA IRQ mask 0x06f8, PCI irq 11
Socket status: 30000007
yenta_config_init socket e1d2b700 state 30000007
yenta_get_status: socket e1d2b700 state 30000087
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
yenta_get_status: socket e1d2b700 state 30000087
yenta_get_status: socket e1d2b700 state 30000411
yenta_get_status: socket e1d2b700 state 30000411
yenta_get_status: socket e1d2b700 state 30000419
yenta_get_status: socket e1d2b700 state 30000419
yenta_get_status: socket e1d2b700 state 30000419
yenta_get_status: socket e1d2b700 state 30000459
cs: memory probe 0xa0000000-0xa0ffffff: clean.
yenta_get_status: socket e1d2b700 state 30000459
airo:  Probing for PCI adapters
airo:  Finished probing for PCI adapters
airo: Doing fast bap_reads
airo: MAC enabled eth1 0:9:b7:c4:51:31
eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f
yenta_config_init socket e1d2b700 state 30000459
unloading Kernel Card Services
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 02:00.0
PCI: Sharing IRQ 11 with 00:1d.1
yenta_config_init socket e1d2b700 state 30000411
Yenta ISA IRQ mask 0x06f8, PCI irq 11
Socket status: 30000011
yenta_config_init socket e1d2b700 state 30000011
yenta_get_status: socket e1d2b700 state 30000411
yenta_get_status: socket e1d2b700 state 30000411
yenta_get_status: socket e1d2b700 state 30000419
yenta_get_status: socket e1d2b700 state 30000419
yenta_get_status: socket e1d2b700 state 30000419
yenta_get_status: socket e1d2b700 state 30000459
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
yenta_get_status: socket e1d2b700 state 30000459
cs: memory probe 0xa0000000-0xa0ffffff: clean.
yenta_get_status: socket e1d2b700 state 30000459
airo:  Probing for PCI adapters
airo:  Finished probing for PCI adapters
airo: Doing fast bap_reads
airo: MAC enabled eth1 0:9:b7:c4:51:31
eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f
yenta_config_init socket e1d2b700 state 30000459
unloading Kernel Card Services
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 02:00.0
PCI: Sharing IRQ 11 with 00:1d.1
yenta_config_init socket e1d2b700 state 30000411
Yenta ISA IRQ mask 0x06f8, PCI irq 11
Socket status: 30000011
yenta_config_init socket e1d2b700 state 30000011
yenta_get_status: socket e1d2b700 state 30000411
yenta_get_status: socket e1d2b700 state 30000411
yenta_get_status: socket e1d2b700 state 30000419
yenta_get_status: socket e1d2b700 state 30000419
yenta_get_status: socket e1d2b700 state 30000419
yenta_get_status: socket e1d2b700 state 30000459
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
yenta_get_status: socket e1d2b700 state 30000459
cs: memory probe 0xa0000000-0xa0ffffff: clean.
yenta_get_status: socket e1d2b700 state 30000459
airo:  Probing for PCI adapters
airo:  Finished probing for PCI adapters
airo: Doing fast bap_reads
airo: MAC enabled eth1 0:9:b7:c4:51:31
eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f
yenta_config_init socket e1d2b700 state 30000459
unloading Kernel Card Services
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 02:00.0
PCI: Sharing IRQ 11 with 00:1d.1
yenta_config_init socket e1d2b700 state 30000017
Yenta ISA IRQ mask 0x06f8, PCI irq 11
Socket status: 30000007
yenta_config_init socket e1d2b700 state 30000007
yenta_get_status: socket e1d2b700 state 30000087
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
yenta_get_status: socket e1d2b700 state 30000087

--Boundary-00=_qLNOAN9n8f48kEZ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lsmod_after_exiting_X.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lsmod_after_exiting_X.txt"

Module                  Size  Used by    Tainted: P  
airo_cs                 4004   0 (unused)
airo                   49048   0 [airo_cs]
ds                      7028   1 [airo_cs]
yenta_socket           11072   1
pcmcia_core            47328   0 [airo_cs ds yenta_socket]
aes                    31200   1 (autoclean)
radeon                106816   0
agpgart                19312   1 (autoclean)
ide-cd                 32416   0 (autoclean)
sr_mod                 14392   0 (autoclean) (unused)
cdrom                  29248   0 (autoclean) [ide-cd sr_mod]
scsi_mod               87712   1 (autoclean) [sr_mod]
mousedev                4372   0
hid                    21988   0 (unused)
input                   3616   0 [mousedev hid]
hci_usb                 6648   0 (unused)
bluez                  32996   1 [hci_usb]
uhci                   25948   0 (unused)
ehci-hcd               18764   0 (unused)
slamr                 247108   0 (unused)
snd-pcm-oss            39492   0 (unused)
snd-mixer-oss          13648   0 [snd-pcm-oss]
snd-intel8x0           19428   0 (autoclean)
snd-pcm                62980   0 (autoclean) [snd-pcm-oss snd-intel8x0]
snd-ac97-codec         43256   0 (autoclean) [snd-intel8x0]
snd-page-alloc          6676   0 (autoclean) [snd-intel8x0 snd-pcm]
snd-mpu401-uart         3376   0 (autoclean) [snd-intel8x0]
snd-rawmidi            14048   0 (autoclean) [snd-mpu401-uart]
snd-seq-oss            29632   0 (unused)
snd-seq-midi-event      3552   0 [snd-seq-oss]
snd-seq                37040   2 [snd-seq-oss snd-seq-midi-event]
snd-timer              14852   0 [snd-pcm snd-seq]
snd-seq-device          4400   0 [snd-rawmidi snd-seq-oss snd-seq]
snd                    34148   0 [snd-pcm-oss snd-mixer-oss snd-intel8x0 snd-pcm snd-ac97-codec snd-mpu401-uart snd-rawmidi snd-seq-oss snd-seq-midi-event snd-seq snd-timer snd-seq-device]
soundcore               3940   5 [snd]
rtc                     7080   0 (autoclean)
usbcore                63852   1 [hid hci_usb uhci ehci-hcd]
ipv6                  171924  -1
e100                   49992   0 (unused)
unix                   15468   5 (autoclean)

--Boundary-00=_qLNOAN9n8f48kEZ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lsmod_after_starting_X.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lsmod_after_starting_X.txt"

Module                  Size  Used by    Tainted: P  
aes                    31200   1 (autoclean)
airo_cs                 4004   0 (unused)
airo                   49048   0 [airo_cs]
radeon                106816   1
agpgart                19312   3 (autoclean)
ide-cd                 32416   0 (autoclean)
sr_mod                 14392   0 (autoclean) (unused)
cdrom                  29248   0 (autoclean) [ide-cd sr_mod]
scsi_mod               87712   1 (autoclean) [sr_mod]
ds                      7028   1 [airo_cs]
mousedev                4372   1
hid                    21988   0 (unused)
input                   3616   0 [mousedev hid]
hci_usb                 6648   0 (unused)
bluez                  32996   1 [hci_usb]
uhci                   25948   0 (unused)
ehci-hcd               18764   0 (unused)
slamr                 247108   0 (unused)
snd-pcm-oss            39492   0 (unused)
snd-mixer-oss          13648   0 [snd-pcm-oss]
snd-intel8x0           19428   1 (autoclean)
snd-pcm                62980   0 (autoclean) [snd-pcm-oss snd-intel8x0]
snd-ac97-codec         43256   0 (autoclean) [snd-intel8x0]
snd-page-alloc          6676   0 (autoclean) [snd-intel8x0 snd-pcm]
snd-mpu401-uart         3376   0 (autoclean) [snd-intel8x0]
snd-rawmidi            14048   0 (autoclean) [snd-mpu401-uart]
snd-seq-oss            29632   0 (unused)
snd-seq-midi-event      3552   0 [snd-seq-oss]
snd-seq                37040   2 [snd-seq-oss snd-seq-midi-event]
snd-timer              14852   0 [snd-pcm snd-seq]
snd-seq-device          4400   0 [snd-rawmidi snd-seq-oss snd-seq]
snd                    34148   1 [snd-pcm-oss snd-mixer-oss snd-intel8x0 snd-pcm snd-ac97-codec snd-mpu401-uart snd-rawmidi snd-seq-oss snd-seq-midi-event snd-seq snd-timer snd-seq-device]
soundcore               3940   5 [snd]
rtc                     7080   0 (autoclean)
usbcore                63852   1 [hid hci_usb uhci ehci-hcd]
ipv6                  171924  -1
yenta_socket           11072   1
pcmcia_core            47328   0 [airo_cs ds yenta_socket]
e100                   49992   0 (unused)
unix                   15468 126 (autoclean)

--Boundary-00=_qLNOAN9n8f48kEZ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lsmod_before_starting_X.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lsmod_before_starting_X.txt"

Module                  Size  Used by    Tainted: P  
ide-cd                 32416   0 (autoclean)
sr_mod                 14392   0 (autoclean) (unused)
cdrom                  29248   0 (autoclean) [ide-cd sr_mod]
scsi_mod               87712   1 (autoclean) [sr_mod]
ds                      7028   1
mousedev                4372   0 (unused)
hid                    21988   0 (unused)
input                   3616   0 [mousedev hid]
hci_usb                 6648   0 (unused)
bluez                  32996   1 [hci_usb]
uhci                   25948   0 (unused)
ehci-hcd               18764   0 (unused)
slamr                 247108   0 (unused)
snd-pcm-oss            39492   0 (unused)
snd-mixer-oss          13648   0 [snd-pcm-oss]
snd-intel8x0           19428   0 (autoclean)
snd-pcm                62980   0 (autoclean) [snd-pcm-oss snd-intel8x0]
snd-ac97-codec         43256   0 (autoclean) [snd-intel8x0]
snd-page-alloc          6676   0 (autoclean) [snd-intel8x0 snd-pcm]
snd-mpu401-uart         3376   0 (autoclean) [snd-intel8x0]
snd-rawmidi            14048   0 (autoclean) [snd-mpu401-uart]
snd-seq-oss            29632   0 (unused)
snd-seq-midi-event      3552   0 [snd-seq-oss]
snd-seq                37040   2 [snd-seq-oss snd-seq-midi-event]
snd-timer              14852   0 [snd-pcm snd-seq]
snd-seq-device          4400   0 [snd-rawmidi snd-seq-oss snd-seq]
snd                    34148   0 [snd-pcm-oss snd-mixer-oss snd-intel8x0 snd-pcm snd-ac97-codec snd-mpu401-uart snd-rawmidi snd-seq-oss snd-seq-midi-event snd-seq snd-timer snd-seq-device]
soundcore               3940   5 [snd]
rtc                     7080   0 (autoclean)
usbcore                63852   1 [hid hci_usb uhci ehci-hcd]
ipv6                  171924  -1
yenta_socket           11072   1
pcmcia_core            47328   0 [ds yenta_socket]
e100                   49992   0 (unused)
unix                   15468   4 (autoclean)

--Boundary-00=_qLNOAN9n8f48kEZ--
