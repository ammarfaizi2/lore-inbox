Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316659AbSIIIoF>; Mon, 9 Sep 2002 04:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316667AbSIIIoF>; Mon, 9 Sep 2002 04:44:05 -0400
Received: from w-jens.oc.chemie.tu-darmstadt.de ([130.83.233.195]:20864 "HELO
	sonne.weltall") by vger.kernel.org with SMTP id <S316659AbSIIIn6>;
	Mon, 9 Sep 2002 04:43:58 -0400
Message-ID: <3D7C6080.5040300@hrzpub.tu-darmstadt.de>
Date: Mon, 09 Sep 2002 10:49:04 +0200
From: Jens Wiesecke <j_wiese@hrzpub.tu-darmstadt.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: de, de-de, en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Justin Heesemann <jh@ionium.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: P4 with i845E not booting with 2.4.19 / 3.5.31
References: <200209030153.47433.jh@ionium.org> <1031139394.3017.61.camel@irongate.swansea.linux.org.uk> <200209042135.17630.jh@ionium.org> <200209082357.27413.jh@ionium.org>
Content-Type: multipart/mixed;
 boundary="------------040400030405000406040503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040400030405000406040503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Justin Heesemann wrote:
>>On Wednesday 04 September 2002 13:36, Alan Cox wrote:
>>
>>>I don't know. Without a serial console oops dump I don't have time to
>>>figure it out either
>>
> 
> seems like serial console doesn't dump anything in my case.

I can confirm that the serial console doesn't send any Byte of 
information before the boot process hangs.

I tried several times over the weekend and it doesn't matter which 
kernel newer than 2.4.19pre7 I tried.

>>when i used the boot option:
>>mem=exactmap mem=640K@0 mem=510M@1M
>>i was able to boot the kernel.
>>
>>however.. when i tried to boot from a 2.4.19 kernel boot cd, it failed
>>with:
>>
>>here is the dmesg:
>>
>>Linux version 2.4.20-pre5-ac1 (root@lux) (gcc version 2.95.3 20010315
>>(release)) #1 Sun Sep 1 17:26:49 Local time zone must be set--see zic manua
>>BIOS-provided physical RAM map:
>> BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
>> BIOS-e820: 00000000000a0000 - 000000001fef0000 (reserved)
>> BIOS-e820: 000000001fef0000 - 000000001fef3000 (ACPI NVS)
>> BIOS-e820: 000000001fef3000 - 000000001ff00000 (ACPI data)
>>user-defined physical RAM map:
>> user: 0000000000000000 - 00000000000a0000 (usable)
>> user: 0000000000100000 - 000000001ff00000 (usable)
>>511MB LOWMEM available.

I tried 2.4.18-3 from RedHat 7.3 with mem=exactmap mem=640K@0 
mem=511M@1M (since I have no shared memory) and got (no APIC):

  Linux version 2.4.18-3 (bhcompile@daffy.perf.redhat.com) (gcc version
  2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 Thu Apr 18 07:37:53 EDT
  2002
  BIOS-provided physical RAM map:
   BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
   BIOS-e820: 00000000000a0000 - 000000001fff0000 (reserved)
   BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
   BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
  user-defined physical RAM map:
   user: 0000000000000000 - 00000000000a0000 (usable)
   user: 0000000000100000 - 0000000020000000 (usable)

but if I boot with plain 2.4.18 with mem=512M (with local APIC) I got:

  Linux version 2.4.18 (root@sonne.weltall) (gcc version 2.95.4 20011006
  (Debian prerelease)) #7 Sat Aug 31 12:18:39 CEST 2002
   BIOS-provided physical RAM map:
   BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
   BIOS-e820: 00000000000a0000 - 000000001fff0000 (reserved)
   BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
   BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
  found SMP MP-table at 000f5c40
  hm, page 000f5000 reserved twice.
  hm, page 000f6000 reserved twice.
  hm, page 000f1000 reserved twice.
  hm, page 000f2000 reserved twice.

the e820 routine seems to provide the same RAM map but 2.4.18 recognizes 
that several pages are reserved twice - since I'm no kernel guy at all: 
does this behaviour indicate any problem 2.4.19 might have with my (and 
Justin's) BIOS ?

> i tried again with a 2.2 kernel. they don't seem to require _any_ mem=xxx 
> parameters to work so i checked dmesg:
> 
> Linux version 2.2.20-idepci (herbert@gondolin) (gcc version 2.7.2.3) #1 Sat 
> Apr 20 12:45:19 EST 2002
> BIOS-provided physical RAM map:
>  BIOS-e820: 0009f000 @ 00000000 (usuable)
>  BIOS-e820: 1fdf0000 @ 00100000 (usuable)
> Detected 2019977 kHz processor.
> 
> 
> This is the same computer, same RAM, same Bios.
> how comes e820 provides these different results ?

I don't have any dmesg here but I can confirm that 2.2 series kernels 
don't need a mem=xxx boot parameter at all (on my board).

I added both dmesg files.

Best regrads
-- 
Jens Wiesecke
Institute for Macromolecular Chemistry
Darmstadt - Germany
e-mail: j_wiese@hrzpub.tu-darmstadt.de

--------------040400030405000406040503
Content-Type: text/plain;
 name="2.4.18-3-RedHat.msg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.18-3-RedHat.msg"

Linux version 2.4.18-3 (bhcompile@daffy.perf.redhat.com) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 Thu Apr 18 07:37:53 EDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000a0000 - 000000001fff0000 (reserved)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
user-defined physical RAM map:
 user: 0000000000000000 - 00000000000a0000 (usable)
 user: 0000000000100000 - 0000000020000000 (usable)
On node 0 totalpages: 131072
zone(0): 4096 pages.
zone(1): 126976 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/hda10 hdc=ide-scsi mem=exactmap mem=640k@0 mem=511M@1M
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 1614.986 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3224.37 BogoMIPS
Memory: 514172k/524288k available (1119k kernel code, 9732k reserved, 775k data, 280k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 1.60GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb0c0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/24c0] at 00:1f.0
PCI: Found IRQ 10 for device 00:1f.1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Starting kswapd
VFS: Diskquotas version dquot_6.5.0 initialized
Detected PS/2 Mouse Port.
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: 992 slots per queue, batch=248
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PCI_IDE: unknown IDE controller on PCI bus 00 device f9, VID=8086, DID=24cb
PCI: Device 00:1f.1 not available because of resource collisions
PCI_IDE: (ide_setup_pci_device:) Could not enable device.
hda: MAXTOR 6L060J3, ATA DISK drive
hdc: CD-RW CDR-5S40, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 117266688 sectors (60041 MB) w/1819KiB Cache, CHS=7299/255/63
ide-floppy driver 0.99.newide
hdd: No disk in drive
hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 280k freed
Adding Swap: 136512k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 07:43:07 Apr 18 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 12
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
hub.c: USB new device connect on bus1/1, assigned device number 2
usb.c: USB device 2 (vend/prod 0x5cc/0x2267) is not claimed by any active driver.
hub.c: USB new device connect on bus2/1, assigned device number 2
hub.c: USB hub found
hub.c: 5 ports detected
hub.c: USB new device connect on bus2/1/2, assigned device number 3
usb.c: USB device 3 (vend/prod 0x46d/0xc00b) is not claimed by any active driver.
hub.c: USB new device connect on bus2/1/4, assigned device number 4
usb.c: USB device 4 (vend/prod 0x46a/0x1) is not claimed by any active driver.
usb.c: registered new driver acm
usb.c: registered new driver hiddev
ttyACM0: USB ACM device
acm.c: v0.21:USB Abstract Control Model driver for USB modems and ISDN adapters
CDCEther.c: CDCEther.c: v0.98.5 22 Sep 2001 Brad Hards and another
usb.c: registered new driver CDCEther
usb.c: registered new driver hid
input0: USB HID v1.10 Mouse [Logitech USB Mouse] on usb2:3.0
input1: USB HID v1.00 Keyboard [046a:0001] on usb2:4.0
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
usb-uhci.c: ENXIO 84000380, flags 0, urb df578460, burb df578360
usb-uhci.c: ENXIO 84000380, flags 0, urb df578460, burb df578360
usb-uhci.c: ENXIO 80000280, flags 0, urb df578560, burb df578460
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb-uhci.c: ENXIO 84000380, flags 0, urb df578460, burb df578360
usb-uhci.c: ENXIO 84000380, flags 0, urb df578460, burb df578360
usb-uhci.c: ENXIO 80000280, flags 0, urb df578560, burb df578460
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
mice: PS/2 mouse device common for all mice
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: CD-RW     Model: CDR-5S40          Rev: ZSG4
  Type:   CD-ROM                             ANSI SCSI revision: 02
ide-floppy: hdd: I/O error, pc =  0, key =  2, asc = 3a, ascq =  0
ide-floppy: hdd: I/O error, pc = 1b, key =  2, asc = 3a, ascq =  0
hdd: No disk in drive
ide-floppy: hdd: I/O error, pc = 1e, key =  2, asc = 3a, ascq =  0
ip_conntrack (4096 buckets, 32768 max)
8139too Fast Ethernet driver 0.9.24
PCI: Found IRQ 11 for device 02:07.0
eth0: RealTek RTL8139 Fast Ethernet at 0xe0848000, 00:50:70:f1:03:48, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'

--------------040400030405000406040503
Content-Type: text/plain;
 name="2.4.18.msg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.18.msg"

Linux version 2.4.18 (root@sonne.weltall) (gcc version 2.95.4 20011006 (Debian prerelease)) #7 Sat Aug 31 12:18:39 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000a0000 - 000000001fff0000 (reserved)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
found SMP MP-table at 000f5c40
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 131072
zone(0): 4096 pages.
zone(1): 126976 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Unknown CPU [15:2] APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 1
Kernel command line: lang= devfs=nomount ramdisk_size=8192 mem=512M BOOT_IMAGE=vmlinuz auto
Initializing CPU#0
Detected 1630.971 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3224.37 BogoMIPS
Memory: 513484k/524288k available (1302k kernel code, 10416k reserved, 431k data, 216k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 1.60GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-12, 2-20, 2-21 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 21.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  0    0    0   0   0    1    1    51
 07 001 01  0    0    0   0   0    1    1    59
 08 001 01  0    0    0   0   0    1    1    61
 09 001 01  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 001 01  0    0    0   0   0    1    1    71
 0e 001 01  0    0    0   0   0    1    1    79
 0f 001 01  0    0    0   0   0    1    1    81
 10 001 01  1    1    0   1   0    1    1    89
 11 001 01  1    1    0   1   0    1    1    91
 12 001 01  1    1    0   1   0    1    1    99
 13 001 01  1    1    0   1   0    1    1    A1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 001 01  1    1    0   1   0    1    1    A9
 17 001 01  1    1    0   1   0    1    1    B1
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1615.0357 MHz.
..... host bus clock speed is 100.9395 MHz.
cpu: 0, clocks: 1009395, slice: 504697
CPU0<T0:1009392,T1:504688,D:7,S:504697,C:1009395>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb0c0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/24c0] at 00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P2) -> 18
PCI->APIC IRQ transform: (B0,I29,P3) -> 23
PCI->APIC IRQ transform: (B0,I31,P0) -> 16
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI->APIC IRQ transform: (B2,I7,P0) -> 22
PCI->APIC IRQ transform: (B2,I9,P0) -> 18
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Starting kswapd
NTFS driver v1.1.22 [Flags: R/O]
ACPI: APM is already active, exiting
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PCI_IDE: unknown IDE controller on PCI bus 00 device f9, VID=8086, DID=24cb
PCI: Device 00:1f.1 not available because of resource collisions
PCI_IDE: chipset revision 1
PCI_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
hda: MAXTOR 6L060J3, ATA DISK drive
hdc: CD-RW CDR-5S40, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 117266688 sectors (60041 MB) w/1819KiB Cache, CHS=7299/255/63
hdc: ATAPI 48X CD-ROM CD-R/RW drive, 1984kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.97.sv
hdd: No disk in drive
hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
8139too Fast Ethernet driver 0.9.24
eth0: RealTek RTL8139 Fast Ethernet at 0xe0800000, 00:50:70:f1:03:48, IRQ 22
eth0:  Identified 8139 chip type 'RTL-8139C'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 440M
agpgart: Detected Intel i845 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] AGP 0.99 on Intel i845 @ 0xe0000000 64MB
[drm] Initialized mga 3.0.2 20010321 on minor 0
ide-floppy driver 0.97.sv
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Setting latency timer of device 00:1d.0 to 64
uhci.c: USB UHCI at I/O 0xd800, IRQ 16
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
uhci.c: USB UHCI at I/O 0xd000, IRQ 19
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
uhci.c: USB UHCI at I/O 0xd400, IRQ 18
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
usb.c: registered new driver acm
acm.c: v0.21:USB Abstract Control Model driver for USB modems and ISDN adapters
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 216k freed
hub.c: USB new device connect on bus1/1, assigned device number 2
Adding Swap: 136512k swap-space (priority -1)
attempt to access beyond end of device
03:02: rw=0, want=2, limit=1
EXT2-fs: unable to read superblock
EXT2-fs warning: maximal mount count reached, running e2fsck is recommended
FAT: Did not find valid FSINFO signature.
Found signature1 0x4e0005 signature2 0xc00b6600 sector=1.
VFS: Can't find a valid FAT filesystem on dev 03:01.
ide-floppy: hdd: I/O error, pc =  0, key =  2, asc = 3a, ascq =  0
ide-floppy: hdd: I/O error, pc = 1b, key =  2, asc = 3a, ascq =  0
hdd: No disk in drive
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
ttyACM0: USB ACM device
hub.c: USB new device connect on bus2/1, assigned device number 2
hub.c: USB hub found
hub.c: 5 ports detected
hub.c: USB new device connect on bus2/1/2, assigned device number 3
input0: USB HID v1.10 Mouse [Logitech USB Mouse] on usb2:3.0
hub.c: USB new device connect on bus2/1/4, assigned device number 4
input1: USB HID v1.00 Keyboard [046a:0001] on usb2:4.0

--------------040400030405000406040503--

