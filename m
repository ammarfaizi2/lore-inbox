Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTJ3AHA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 19:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbTJ3AHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 19:07:00 -0500
Received: from porch.xs4all.nl ([80.126.78.181]:42764 "EHLO porch.xs4all.nl")
	by vger.kernel.org with ESMTP id S262108AbTJ3AGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 19:06:49 -0500
Message-ID: <3FA05616.5030002@asphyx.net>
Date: Thu, 30 Oct 2003 01:06:46 +0100
From: Mark <mark@asphyx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.5-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.4] weird stuff in per part /proc/partition stats
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just compiled new kernel turned on per part. stats (for the first time) and 
noticed:

    3     0   78150744 hda 119129 782652 1696861 60150 1 0 1 0 -1 1987100 -1945640
    3     1   78148161 hda1 106701 0 106701 18520 1 0 1 0 0 18520 18520
    3    64   78150744 hdb 571 48 4634 6490 209 0 1672 4920 -1 1999300 -1994380
    3    65   78148161 hdb1 570 45 4626 6480 209 0 1672 4920 0 6700 11400

See the negative values?! I don't know about the last field, but having -1 
io's running seems kinda unlikely....

This only happens w/ the IDE disks.

[OK, before posting I googled somewhat and found some references to this 
problem. They did not mention the following though.]

Another weird thing is that the "use" & "aveq" fields for hda & hdb are
incremented and decremented (respectivly) by 1010 every second (to be clear: 
whole disk only, not the stats for hd[ab]1).

This happens while the partitions are mouted, unmounted and even when the 
disks are spinned down (by BIOS PM(?))

It's not a real problem for me but I thought I'd report it.

If you request more info pls. CC me, I'm not on the list.

Regards,
Mark.

Kernel: 2.4.23-pre8 + cset-20031029_1302.txt.gz + 00_3.5G-address-space-5(from 
aa-tree)

# lsmod
Module                  Size  Used by    Tainted: PF
nvidia               1628704  11
via82cxxx_audio        18840   0  (unused)
b44                    14248   1

I also tried w/out nvidia module (as it taints the kernel). (Have to admit 
vmware modules were also loaded before)... Stats still keep changing at same rate.

$ dmesg
[note: I have CONFIG_LOG_BUF_SHIFT set to 17 (128kb) but this does not seem 
complete and "dmesg | wc -c" only gives ~16K. Does dmesg not support >16K??]

1 MSFT 0x31313031) @ 0x3fffc030
ACPI: MADT (v001 ASUS   A7V8X    0x42302e31 MSFT 0x31313031) @ 0x3fffc058
ACPI: DSDT (v001   ASUS A7V8X    0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Pentium(tm) Pro APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] trigger[0x3])
Using ACPI (MADT) for SMP configuration information
Kernel command line: BOOT_IMAGE=Linux ro root=802
Initializing CPU#0
Detected 2000.120 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3984.58 BogoMIPS
Memory: 1034180k/1048560k available (1557k kernel code, 13992k reserved, 449k 
data, 284k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: CLK_CTL MSR was 6003d22f. Reprogramming to 2003d22f
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(TM) XP 2400+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not 
connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
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
  09 001 01  1    1    0   1   0    1    1    71
  0a 001 01  0    0    0   0   0    1    1    79
  0b 001 01  0    0    0   0   0    1    1    81
  0c 001 01  0    0    0   0   0    1    1    89
  0d 001 01  0    0    0   0   0    1    1    91
  0e 001 01  0    0    0   0   0    1    1    99
  0f 001 01  0    0    0   0   0    1    1    A1
  10 000 00  1    0    0   0   0    0    0    00
  11 000 00  1    0    0   0   0    0    0    00
  12 000 00  1    0    0   0   0    0    0    00
  13 000 00  1    0    0   0   0    0    0    00
  14 073 03  1    0    0   0   0    0    2    17
  15 000 00  1    0    0   0   0    0    0    00
  16 000 00  1    0    0   0   0    0    0    00
  17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1999.9871 MHz.
..... host bus clock speed is 266.6649 MHz.
cpu: 0, clocks: 2666649, slice: 1333324
CPU0<T0:2666640,T1:1333312,D:4,S:1333324,C:2666649>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xf1720, last bus=1
PCI: Using configuration type 1
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:1)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 10 11 12 14)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
PCI: Probing PCI hardware
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xa9 -> IRQ 17 Mode:1 Active:1)
00:00:07[A] -> 2-17 -> IRQ 17
Pin 2-17 already programmed
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb1 -> IRQ 18 Mode:1 Active:1)
00:00:09[A] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb9 -> IRQ 19 Mode:1 Active:1)
00:00:0c[A] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xc1 -> IRQ 16 Mode:1 Active:1)
00:00:0c[B] -> 2-16 -> IRQ 16
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc9 -> IRQ 21 Mode:1 Active:1)
00:00:10[A] -> 2-21 -> IRQ 21
Pin 2-21 already programmed
Pin 2-21 already programmed
Pin 2-21 already programmed
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd1 -> IRQ 22 Mode:1 Active:1)
00:00:11[C] -> 2-22 -> IRQ 22
Pin 2-16 already programmed
Pin 2-17 already programmed
PCI: No IRQ known for interrupt pin A of device 00:11.1 - using IRQ 255
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
PCI: Via IRQ fixup for 00:10.0, from 3 to 5
PCI: Via IRQ fixup for 00:10.1, from 3 to 5
PCI: Via IRQ fixup for 00:10.2, from 3 to 5
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
NTFS driver v1.1.22 [Flags: R/O]
ACPI: Processor [CPU0] (supports C1)
pty: 1024 Unix98 ptys configured
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
PCI: Enabling device 00:0f.0 (0014 -> 0017)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media 10baseT (#0) described by a 21142 Serial PHY (2) block.
tulip0:  Index #1 - Media 10baseT-FDX (#4) described by a 21142 Serial PHY (2) 
block.
tulip0:  Index #2 - Media 100baseTx (#3) described by a 21143 SYM PHY (4) block.
tulip0:  Index #3 - Media 100baseTx-FDX (#5) described by a 21143 SYM PHY (4) 
block.
eth0: Digital DS21143 Tulip rev 65 at 0xc080a000, 00:C0:95:F8:0E:FE, IRQ 18.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: Detected Via Apollo Pro KT400 chipset
agpgart: AGP aperture is 128M @ 0xf0000000
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
PCI: No IRQ known for interrupt pin A of device 00:11.1 - using IRQ 255
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
     ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:pio, hdd:pio
hda: WDC WD800BB-00CAA1, ATA DISK drive
hdb: WDC WD800JB-00CRA1, ATA DISK drive
blk: queue 8038f8a0, I/O limit 4095Mb (mask 0xffffffff)
blk: queue 8038f9e8, I/O limit 4095Mb (mask 0xffffffff)
hdc: TOSHIBA DVD-ROM SD-M1712, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63, UDMA(100)
hdb: attached ide-disk driver.
hdb: host protected area => 1
hdb: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=9729/255/63, UDMA(100)
hdc: attached ide-cdrom driver.
hdc: ATAPI 48X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
  hda: hda1
  hdb: hdb1
SCSI subsystem driver Revision: 1.00
sym.0.13.0: setting PCI_COMMAND_PARITY...
sym0: <895> rev 0x1 on pci bus 0 device 13 function 0 irq 16
sym0: Symbios NVRAM, ID 7, Fast-40, LVD, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: SCAN AT BOOT disabled for targets 0 3 6 8 9 10 11 12 13 14 15.
sym0: SCAN FOR LUNS disabled for targets 0 1 2 3 4 5 6 8 9 10 11 12 13 14 15.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.17a
blk: queue 81ba5a18, I/O limit 4095Mb (mask 0xffffffff)
   Vendor: MAXTOR    Model: ATLAS10K4_36WLS   Rev: DFL0
   Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue 81ba5e18, I/O limit 4095Mb (mask 0xffffffff)
   Vendor: QUANTUM   Model: ATLAS_V__9_WLS    Rev: 0230
   Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue bfccd018, I/O limit 4095Mb (mask 0xffffffff)
   Vendor: PLEXTOR   Model: CD-ROM PX-40TS    Rev: 1.05
   Type:   CD-ROM                             ANSI SCSI revision: 02
blk: queue bfccd418, I/O limit 4095Mb (mask 0xffffffff)
   Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.03
   Type:   CD-ROM                             ANSI SCSI revision: 02
blk: queue bfccd618, I/O limit 4095Mb (mask 0xffffffff)
sym0:1:0: tagged command queuing enabled, command queue depth 32.
sym0:2:0: tagged command queuing enabled, command queue depth 32.
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 2, lun 0
sym0:1: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 31)
SCSI device sda: 71833096 512-byte hdwr sectors (36779 MB)
  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
sym0:2: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 31)
SCSI device sdb: 17930694 512-byte hdwr sectors (9181 MB)
  sdb: sdb1
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 5, lun 0
sym0:4: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 15)
sr0: scsi-1 drive
sym0:5: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 16)
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Creative EMU10K1 PCI Audio Driver, version 0.20, 23:31:48 Oct 29 2003
PCI: Enabling device 00:0b.0 (0004 -> 0005)
emu10k1: EMU10K1 rev 10 model 0x8065 found, IO at 0xd800-0xd81f, IRQ 19
ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708)
emu10k1: SBLive! 5.1 card detected
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
ehci_hcd 00:10.3: VIA Technologies, Inc. USB 2.0
ehci_hcd 00:10.3: irq 21, pci mem c0836000
usb.c: new USB bus registered, assigned bus number 1
ehci_hcd 00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-19/2.4
hub.c: USB hub found
hub.c: 6 ports detected
host/usb-uhci.c: $Revision: 1.275 $ time 23:31:55 Oct 29 2003
host/usb-uhci.c: High bandwidth mode enabled
host/usb-uhci.c: USB UHCI at I/O 0xb400, IRQ 21
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
host/usb-uhci.c: USB UHCI at I/O 0xb000, IRQ 21
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
host/usb-uhci.c: USB UHCI at I/O 0xa800, IRQ 21
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 284k freed
Adding Swap: 507896k swap-space (priority -1)
hub.c: new USB device 00:10.0-1, assigned address 2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb2:2.0
b44.c:v0.91 (Oct 3, 2003)
PCI: Enabling device 00:09.0 (0004 -> 0006)
eth1: Broadcom 4400 10/100BaseT Ethernet 00:e0:18:b2:75:f8
Via 686a/8233/8235 audio driver 1.9.1-ac3
via82cxxx: Six channel audio available
PCI: Setting latency timer of device 00:11.5 to 64
ac97_codec: AC97 Audio codec, id: ALG32 (ALC650)
via82cxxx: board #1 at 0xE000, IRQ 22
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496  Wed Jul 
16 19:03:09 PDT 2003
b44: eth1: Link is down.
b44: eth1: Link is up at 100 Mbps, full duplex.
b44: eth1: Flow control is on for TX and on for RX.
eth0: no IPv6 routers present
eth1: no IPv6 routers present
/dev/vmmon: Module vmmon: registered with major=10 minor=165
/dev/vmmon: Module vmmon: initialized
/dev/vmnet: open called by PID 1365 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth1: up
bridge-eth1: attached
/dev/vmnet: open called by PID 1388 (vmnet-natd)
/dev/vmnet: hub 8 does not exist, allocating memory.
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 1643 (vmnet-netifup)
/dev/vmnet: hub 1 does not exist, allocating memory.
/dev/vmnet: port on hub 1 successfully opened
/dev/vmnet: open called by PID 1653 (vmnet-dhcpd)
/dev/vmnet: port on hub 1 successfully opened
/dev/vmnet: open called by PID 1656 (vmnet-netifup)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 1666 (vmnet-dhcpd)
/dev/vmnet: port on hub 8 successfully opened
vmnet8: no IPv6 routers present
vmnet1: no IPv6 routers present
/dev/vmmon: Module vmmon: unloaded




