Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265061AbUAYRvs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 12:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUAYRvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 12:51:48 -0500
Received: from d213-103-156-147.cust.tele2.ch ([213.103.156.147]:55616 "EHLO
	kameha") by vger.kernel.org with ESMTP id S265061AbUAYRva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 12:51:30 -0500
Message-ID: <40140221.40901@freesurf.ch>
Date: Sun, 25 Jan 2004 18:51:29 +0100
From: Marc Mongenet <Marc.Mongenet@freesurf.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: fr, en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.25pre7 - cannot mount 128MB vfat fs on Minolta camera
References: <4013D155.3080900@freesurf.ch> <87y8rw2eyy.fsf@devron.myhome.or.jp>
In-Reply-To: <87y8rw2eyy.fsf@devron.myhome.or.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:
> Marc Mongenet <Marc.Mongenet@freesurf.ch> writes:
> 
>>Hi, I have a Minolta DiMAGE F100 camera and two memory cards,
>>a 16 MB and a 128 MB.
>>With kernel 2.2.25 I can mount the 16 MB but not the 128 MB.
>>With kernel 2.4.16 to 2.4.25pre6 I can mount the 128 MB but not the 16 MB.
>>With kernel 2.4.25pre7 I can mount the 16 MB but not the 128 MB.
>>
>>There is probably something special with the filesystem used by Minolta
>>because I have to format it with the camera to be recognized by the camera.
> 
> What error did you get? Please send output of dmesg and first
> 256KB of 128MB card.

Well, 10 minutes after finally reporting the problem, I discovered that
it is different than described above...

So, I can mount the 16 MB card or the 128 MB card with any kernel,
BUT I have to reboot the system when I change the cards. Example:

1) boot the system

2) turn on camera with 16 MB card
Jan 25 18:35:39 kameha kernel: hub.c: new USB device 00:1d.1-1, assigned address 5

3)
# cat /etc/fstab | grep f100
/dev/sda1       /f100           vfat    users,noauto            0       0
# mount /f100
# ls /f100
dcim
# umount /f100
#

4) turn off camera
Jan 25 18:38:28 kameha kernel: usb.c: USB disconnect on device 00:1d.1-1 address 5

5) put 128 MB card inside, turn on again
Jan 25 18:39:00 kameha kernel: hub.c: new USB device 00:1d.1-1, assigned address 6

6)
# mount /f100
Jan 25 18:39:11 kameha kernel: FAT: bogus logical sector size 0
Jan 25 18:39:11 kameha kernel: VFS: Can't find a valid FAT filesystem on dev 08:01.
mount: wrong fs type, bad option, bad superblock on /dev/sda1,
        or too many mounted file systems

7)
# dmesg
Linux version 2.4.25-pre7 (root@kameha) (version gcc 3.3.2) #1 dim jan 25 13:14:11 CET 2004
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003ff40000 (usable)
  BIOS-e820: 000000003ff40000 - 000000003ff50000 (ACPI data)
  BIOS-e820: 000000003ff50000 - 0000000040000000 (ACPI NVS)
127MB HIGHMEM available.
896MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000fd000 reserved twice.
hm, page 000fe000 reserved twice.
On node 0 totalpages: 261952
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32576 pages.
ACPI: RSDP (v000 ACPIAM                                    ) @ 0x000f7370
ACPI: RSDT (v001 INTEL  D845PESV 0x20030425 MSFT 0x00000097) @ 0x3ff40000
ACPI: FADT (v001 INTEL  D845PESV 0x20030425 MSFT 0x00000097) @ 0x3ff40200
ACPI: MADT (v001 INTEL  D845PESV 0x20030425 MSFT 0x00000097) @ 0x3ff40300
ACPI: ASF! (v016 AMIASF I845GASF 0x00000001 MSFT 0x0100000d) @ 0x3ff44360
ACPI: DSDT (v001 INTEL  D845PESV 0x0000010a MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
Processor #129 invalid (max 16)
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 1
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI BALANCE SET
Using ACPI (MADT) for SMP configuration information
Kernel command line: BOOT_IMAGE=LinuxOLD ro root=307
Initializing CPU#0
Detected 2400.116 MHz processor.
Console: colour VGA+ 132x44
Calibrating delay loop... 4784.12 BogoMIPS
Memory: 1032748k/1047808k available (1458k kernel code, 14672k reserved, 524k data, 104k init, 130304k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
  IO-APIC (apicid-pin) 1-0, 1-16, 1-17, 1-18, 1-19, 1-20, 1-21, 1-22, 1-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2400.0978 MHz.
..... host bus clock speed is 133.3385 MHz.
cpu: 0, clocks: 1333385, slice: 666692
CPU0<T0:1333376,T1:666672,D:12,S:666692,C:1333385>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20031203
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
IOAPIC[0]: Set PCI routing entry (1-9 -> 0x71 -> IRQ 9 Mode:1 Active:0)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
PCI: Probing PCI hardware
IOAPIC[0]: Set PCI routing entry (1-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
00:00:1d[A] -> 1-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (1-19 -> 0xb1 -> IRQ 19 Mode:1 Active:1)
00:00:1d[B] -> 1-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (1-18 -> 0xb9 -> IRQ 18 Mode:1 Active:1)
00:00:1d[C] -> 1-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (1-23 -> 0xc1 -> IRQ 23 Mode:1 Active:1)
00:00:1d[D] -> 1-23 -> IRQ 23
Pin 1-18 already programmed
IOAPIC[0]: Set PCI routing entry (1-17 -> 0xc9 -> IRQ 17 Mode:1 Active:1)
00:00:1f[B] -> 1-17 -> IRQ 17
Pin 1-16 already programmed
Pin 1-17 already programmed
Pin 1-16 already programmed
IOAPIC[0]: Set PCI routing entry (1-20 -> 0xd1 -> IRQ 20 Mode:1 Active:1)
00:02:08[A] -> 1-20 -> IRQ 20
IOAPIC[0]: Set PCI routing entry (1-21 -> 0xd9 -> IRQ 21 Mode:1 Active:1)
00:02:00[A] -> 1-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (1-22 -> 0xe1 -> IRQ 22 Mode:1 Active:1)
00:02:00[B] -> 1-22 -> IRQ 22
Pin 1-23 already programmed
Pin 1-20 already programmed
Pin 1-22 already programmed
Pin 1-21 already programmed
Pin 1-20 already programmed
Pin 1-23 already programmed
Pin 1-18 already programmed
Pin 1-19 already programmed
Pin 1-17 already programmed
Pin 1-16 already programmed
Pin 1-19 already programmed
Pin 1-18 already programmed
Pin 1-21 already programmed
Pin 1-22 already programmed
Pin 1-17 already programmed
Pin 1-23 already programmed
Pin 1-16 already programmed
Pin 1-20 already programmed
Pin 1-18 already programmed
Pin 1-20 already programmed
Pin 1-22 already programmed
Pin 1-21 already programmed
number of MP IRQ sources: 15.
number of IO-APIC #1 registers: 24.
testing the IO APIC.......................

IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
  00 000 00  1    0    0   0   0    0    0    00
  01 001 01  0    0    0   0   0    1    1    39
  02 001 01  0    0    0   0   0    1    1    31
  03 001 01  0    0    0   0   0    1    1    41
  04 001 01  0    0    0   0   0    1    1    49
  05 001 01  0    0    0   0   0    1    1    51
  06 001 01  0    0    0   0   0    1    1    59
  07 001 01  0    0    0   0   0    1    1    61
  08 001 01  0    0    0   0   0    1    1    69
  09 001 01  0    1    0   0   0    1    1    71
  0a 001 01  0    0    0   0   0    1    1    79
  0b 001 01  0    0    0   0   0    1    1    81
  0c 001 01  0    0    0   0   0    1    1    89
  0d 001 01  0    0    0   0   0    1    1    91
  0e 001 01  0    0    0   0   0    1    1    99
  0f 001 01  0    0    0   0   0    1    1    A1
  10 001 01  1    1    0   1   0    1    1    A9
  11 001 01  1    1    0   1   0    1    1    C9
  12 001 01  1    1    0   1   0    1    1    B9
  13 001 01  1    1    0   1   0    1    1    B1
  14 001 01  1    1    0   1   0    1    1    D1
  15 001 01  1    1    0   1   0    1    1    D9
  16 001 01  1    1    0   1   0    1    1    E1
  17 001 01  1    1    0   1   0    1    1    C1
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9-> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
ACPI: Processor [CPU1] (supports C1, 8 throttling states)
ACPI: Processor [CPU2] (supports C1, 8 throttling states)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10f
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 at 0xf880cc00, 00:02:44:59:02:07, IRQ 22
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: Detected Intel(R) 845G chipset
agpgart: AGP aperture is 64M @ 0xf8000000
[drm] AGP 0.99 Aperture @ 0xf8000000 64MB
[drm] Initialized radeon 1.7.0 20020828 on minor 0
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH4: chipset revision 2
ICH4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD800JB-00CRA1, ATA DISK drive
blk: queue c033b8a0, I/O limit 4095Mb (mask 0xffffffff)
hdc: PLEXTOR CD-R PX-320A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=9729/255/63, UDMA(100)
hdc: attached ide-cdrom driver.
hdc: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
  hda: hda1 < hda5 hda6 hda7 hda8 hda9 > hda2
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Intel 810 + AC97 Audio, version 0.24, 13:15:36 Jan 25 2004
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH4 found at IO 0xe080 and 0xe400, MEM 0xffaff800 and 0xffaff400, IRQ 17
i810: Intel ICH4 mmio at 0xf8824800 and 0xf8826400
i810_audio: Primary codec has ID 2
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 2
ac97_codec: AC97 Audio codec, id: ADS116 (Unknown)
i810_audio: AC'97 codec 2 supports AMAP, total channels = 2
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
host/usb-uhci.c: $Revision: 1.275 $ time 13:15:45 Jan 25 2004
host/usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
host/usb-uhci.c: USB UHCI at I/O 0xe800, IRQ 16
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
host/usb-uhci.c: USB UHCI at I/O 0xe880, IRQ 19
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
host/usb-uhci.c: USB UHCI at I/O 0xec00, IRQ 18
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 104k freed
hub.c: new USB device 00:1d.0-2, assigned address 2
usb.c: USB device 2 (vend/prod 0x46d/0xc00e) is not claimed by any active driver.
hub.c: new USB device 00:1d.1-1, assigned address 2
scsi1 : SCSI emulation for USB Mass Storage devices
   Vendor: MINOLTA   Model: DiMAGE F100       Rev: 1.00
   Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sda: 29120 512-byte hdwr sectors (15 MB)
sda: Write Protect is off
  sda: sda1
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
usb.c: USB disconnect on device 00:1d.1-1 address 2
hub.c: new USB device 00:1d.1-1, assigned address 3
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 3
FAT: bogus logical sector size 0
VFS: Can't find a valid FAT filesystem on dev 08:01.
FAT: bogus logical sector size 0
VFS: Can't find a valid FAT filesystem on dev 08:01.
usb.c: USB disconnect on device 00:1d.1-1 address 3
hub.c: new USB device 00:1d.1-1, assigned address 4
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 4
FAT: bogus logical sector size 0
VFS: Can't find a valid FAT filesystem on dev 08:01.
usb.c: USB disconnect on device 00:1d.1-1 address 4
hub.c: new USB device 00:1d.1-1, assigned address 5
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 5
usb.c: USB disconnect on device 00:1d.1-1 address 5
hub.c: new USB device 00:1d.1-1, assigned address 6
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 6
FAT: bogus logical sector size 0
VFS: Can't find a valid FAT filesystem on dev 08:01.
FAT: bogus logical sector size 0
VFS: Can't find a valid FAT filesystem on dev 08:01.



I'll send the 256 KB of card privately.

Marc Mongenet
