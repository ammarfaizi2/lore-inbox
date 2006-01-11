Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932623AbWAKBQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbWAKBQw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 20:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932746AbWAKBQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 20:16:52 -0500
Received: from adsl-69-154-123-204.dsl.fyvlar.swbell.net ([69.154.123.204]:62389
	"EHLO electronsrus.com") by vger.kernel.org with ESMTP
	id S932623AbWAKBQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 20:16:51 -0500
From: Fredrick O Jackson <fred@electronsrus.com>
To: linux-kernel@vger.kernel.org
Subject: soundblaster pnp ide won't pnp
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Disposition: inline
Date: Tue, 10 Jan 2006 19:16:27 -0600
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200601101916.28019@bits.electronsrus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ok, so far Ive tried with and without isapnp support in the kernel, I've 
toggled the PNP OS, and ACPI switches in the bios, I've tried compiling the 
drivers into the kernel (hd, ide, ide-disk, isapnp, ide-pnp, and others) on 
2.6.14, 2.6.15 and 2.4.27. I've used kernel command lines. I usually get 
messages similar to that below (at the bottom). I also cannot find the 
modules ide, ide-probe, or ide-detect which are documented in the 
Documentation directory.

what method is recommended and what kernel would you suggest?

thanks in advance....
Fred

my system has ACPI APIC and pnp
my system config is:

pthree:~# lspnp 
00 PNP0000 AT programmable interrupt controller
01 PNP0200 AT DMA controller
02 PNP0100 AT system timer
03 PNP0b00 AT real-time clock
04 PNP0303 IBM enhanced keyboard (101/102-key, PS/2 mouse support)
05 PNP0800 AT-style speaker sound
06 PNP0c04 Math coprocessor
07 PNP0c01 System board
08 PNP0c02 Motherboard resources
09 PNP0a03 PCI bus
0b PNP0c02 Motherboard resources
0c PNP0501 16550A-compatible COM port
0d PNP0700 PC standard floppy disk controller
0f PNP0401 ECP printer port
10 PNP0501 16550A-compatible COM port

pthree:~# lspci
0000:00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host 
bridge (rev 03)
0000:00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP 
bridge (rev 03)
0000:00:07.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
0000:00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
0000:00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 
01)
0000:00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
0000:00:0b.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 
100] (rev 05)
0000:00:0d.0 Ethernet controller: Linksys NC100 Network Everywhere Fast 
Ethernet 10/100 (rev 11)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF/SG 
AGP
pthree:~#     
pthree:~# cat /sys/bus/pnp/devices/*/id
PNP0000
PNP0200
PNP0100
PNP0b00
PNP0303
PNP0800
PNP0c04
PNP0c01
PNP0c02
PNP0a03
PNP0c02
PNP0501
PNP0700
PNP0401
PNP0501
CTL0031
CTL2011
PNP0600
PNPffff
CTL7001
PNPb02f



pthree:~# cat /sys/bus/pnp/devices/01\:01.01/id
CTL2011
PNP0600
pthree:~# cat /sys/bus/pnp/devices/01\:01.01/resources
state = active
io 0x1e8-0x1ef
io 0x3ee-0x3ef
irq 11

pthree:~#  cat /proc/interrupts
           CPU0
  0:    4664549          XT-PIC  timer
  1:          8          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  7:          1          XT-PIC  parport0
  9:          0          XT-PIC  uhci_hcd:usb1
 10:          3          XT-PIC  eth1
 12:       4061          XT-PIC  eth0
 14:       1476          XT-PIC  ide0
 15:         62          XT-PIC  ide1
NMI:          0
LOC:          0
ERR:          0
MIS:          0


pthree:~# pnpdump
# $Id: pnpdump_main.c,v 1.27 2001/04/30 21:54:53 fox Exp $
# Release isapnptools-1.26
#
# This is free software, see the sources for details.
# This software has NO WARRANTY, use at your OWN RISK
#
# For details of the output file format, see isapnp.conf(5)
#
# For latest information and FAQ on isapnp and pnpdump see:
# http://www.roestock.demon.co.uk/isapnptools/
#
# Compiler flags:  -DREALTIME -DHAVE_PROC -DENABLE_PCI 
-DHAVE_SCHED_SETSCHEDULER -DHAVE_NANOSLEEP -DWANT_TO_VALIDATE
#
# Trying port address 0273
# Board 1 has serial identifier e4 10 02 d3 04 28 00 8c 0e

# (DEBUG)
(READPORT 0x0273)
(ISOLATE PRESERVE)
(IDENTIFY *)
(VERBOSITY 2)
(CONFLICT (IO FATAL)(IRQ FATAL)(DMA FATAL)(MEM FATAL)) # or WARNING

# Card 1: (serial identifier e4 10 02 d3 04 28 00 8c 0e)
# Vendor Id CTL0028, Serial Number 268620548, checksum 0xE4.
# Version 1.0, Vendor version 1.0
# ANSI string -->Creative SB16 PnP<--
#
# Logical device id CTL0031
#     Device supports vendor reserved register @ 0x3b
#     Device supports vendor reserved register @ 0x3c
#     Device supports vendor reserved register @ 0x3f
#
# Edit the entries below to uncomment out the configuration required.
# Note that only the first value of any range is given, this may be changed if 
required
# Don't forget to uncomment the activate (ACT Y) when happy

(CONFIGURE CTL0028/268620548 (LD 0
#     ANSI string -->Audio<--

# Multiple choice time, choose one only !

#     Start dependent functions: priority preferred
#       IRQ 5.
#             High true, edge sensitive interrupt (by default)
# (INT 0 (IRQ 5 (MODE +E)))
#       First DMA channel 1.
#             8 bit DMA only
#             Logical device is a bus master
#             DMA may execute in count by byte mode
#             DMA may not execute in count by word mode
#             DMA channel speed in compatible mode
# (DMA 0 (CHANNEL 1))
#       Next DMA channel 5.
#             16 bit DMA only
#             Logical device is a bus master
#             DMA may not execute in count by byte mode
#             DMA may execute in count by word mode
#             DMA channel speed in compatible mode
# (DMA 1 (CHANNEL 5))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0220
#             Maximum IO base address 0x0220
#             IO base alignment 1 bytes
#             Number of IO addresses required: 16
# (IO 0 (SIZE 16) (BASE 0x0220))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0330
#             Maximum IO base address 0x0330
#             IO base alignment 1 bytes
#             Number of IO addresses required: 2
# (IO 1 (SIZE 2) (BASE 0x0330))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0388
#             Maximum IO base address 0x0388
#             IO base alignment 1 bytes
#             Number of IO addresses required: 4
# (IO 2 (SIZE 4) (BASE 0x0388))

#       Start dependent functions: priority acceptable
#       IRQ 5, 7 or 10.
#             High true, edge sensitive interrupt (by default)
# (INT 0 (IRQ 5 (MODE +E)))
#       First DMA channel 0, 1 or 3.
#             8 bit DMA only
#             Logical device is a bus master
#             DMA may execute in count by byte mode
#             DMA may not execute in count by word mode
#             DMA channel speed in compatible mode
# (DMA 0 (CHANNEL 0))
#       Next DMA channel 5, 6 or 7.
#             16 bit DMA only
#             Logical device is a bus master
#             DMA may not execute in count by byte mode
#             DMA may execute in count by word mode
#             DMA channel speed in compatible mode
# (DMA 1 (CHANNEL 5))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0220
#             Maximum IO base address 0x0280
#             IO base alignment 32 bytes
#             Number of IO addresses required: 16
# (IO 0 (SIZE 16) (BASE 0x0220))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0300
#             Maximum IO base address 0x0330
#             IO base alignment 48 bytes
#             Number of IO addresses required: 2
# (IO 1 (SIZE 2) (BASE 0x0300))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0388
#             Maximum IO base address 0x0388
#             IO base alignment 1 bytes
#             Number of IO addresses required: 4
# (IO 2 (SIZE 4) (BASE 0x0388))

#       Start dependent functions: priority acceptable
#       IRQ 5, 7 or 10.
#             High true, edge sensitive interrupt (by default)
# (INT 0 (IRQ 5 (MODE +E)))
#       First DMA channel 0, 1 or 3.
#             8 bit DMA only
#             Logical device is a bus master
#             DMA may execute in count by byte mode
#             DMA may not execute in count by word mode
#             DMA channel speed in compatible mode
# (DMA 0 (CHANNEL 0))
#       Next DMA channel 5, 6 or 7.
#             16 bit DMA only
#             Logical device is a bus master
#             DMA may not execute in count by byte mode
#             DMA may execute in count by word mode
#             DMA channel speed in compatible mode
# (DMA 1 (CHANNEL 5))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0220
#             Maximum IO base address 0x0280
#             IO base alignment 32 bytes
#             Number of IO addresses required: 16
# (IO 0 (SIZE 16) (BASE 0x0220))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0300
#             Maximum IO base address 0x0330
#             IO base alignment 48 bytes
#             Number of IO addresses required: 2
# (IO 1 (SIZE 2) (BASE 0x0300))

#       Start dependent functions: priority functional
#       IRQ 5, 7 or 10.
#             High true, edge sensitive interrupt (by default)
# (INT 0 (IRQ 5 (MODE +E)))
#       First DMA channel 0, 1 or 3.
#             8 bit DMA only
#             Logical device is a bus master
#             DMA may execute in count by byte mode
#             DMA may not execute in count by word mode
#             DMA channel speed in compatible mode
# (DMA 0 (CHANNEL 0))
#       Next DMA channel 5, 6 or 7.
#             16 bit DMA only
#             Logical device is a bus master
#             DMA may not execute in count by byte mode
#             DMA may execute in count by word mode
#             DMA channel speed in compatible mode
# (DMA 1 (CHANNEL 5))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0220
#             Maximum IO base address 0x0280
#             IO base alignment 32 bytes
#             Number of IO addresses required: 16
# (IO 0 (SIZE 16) (BASE 0x0220))

#       Start dependent functions: priority functional
#       IRQ 5, 7 or 10.
#             High true, edge sensitive interrupt (by default)
# (INT 0 (IRQ 5 (MODE +E)))
#       First DMA channel 0, 1 or 3.
#             8 bit DMA only
#             Logical device is a bus master
#             DMA may execute in count by byte mode
#             DMA may not execute in count by word mode
#             DMA channel speed in compatible mode
# (DMA 0 (CHANNEL 0))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0220
#             Maximum IO base address 0x0280
#             IO base alignment 32 bytes
#             Number of IO addresses required: 16
# (IO 0 (SIZE 16) (BASE 0x0220))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0300
#             Maximum IO base address 0x0330
#             IO base alignment 48 bytes
#             Number of IO addresses required: 2
# (IO 1 (SIZE 2) (BASE 0x0300))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0388
#             Maximum IO base address 0x0388
#             IO base alignment 1 bytes
#             Number of IO addresses required: 4
# (IO 2 (SIZE 4) (BASE 0x0388))

#       Start dependent functions: priority functional
#       IRQ 5, 7 or 10.
#             High true, edge sensitive interrupt (by default)
# (INT 0 (IRQ 5 (MODE +E)))
#       First DMA channel 0, 1 or 3.
#             8 bit DMA only
#             Logical device is a bus master
#             DMA may execute in count by byte mode
#             DMA may not execute in count by word mode
#             DMA channel speed in compatible mode
# (DMA 0 (CHANNEL 0))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0220
#             Maximum IO base address 0x0280
#             IO base alignment 32 bytes
#             Number of IO addresses required: 16
# (IO 0 (SIZE 16) (BASE 0x0220))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0300
#             Maximum IO base address 0x0330
#             IO base alignment 48 bytes
#             Number of IO addresses required: 2
# (IO 1 (SIZE 2) (BASE 0x0300))

#       Start dependent functions: priority functional
#       IRQ 5, 7, 10 or 11.
#             High true, edge sensitive interrupt (by default)
# (INT 0 (IRQ 5 (MODE +E)))
#       First DMA channel 0, 1 or 3.
#             8 bit DMA only
#             Logical device is a bus master
#             DMA may execute in count by byte mode
#             DMA may not execute in count by word mode
#             DMA channel speed in compatible mode
# (DMA 0 (CHANNEL 0))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0220
#             Maximum IO base address 0x0280
#             IO base alignment 32 bytes
#             Number of IO addresses required: 16
# (IO 0 (SIZE 16) (BASE 0x0220))

#     End dependent functions
 (NAME "CTL0028/268620548[0]{Audio               }")
# (ACT Y)
))
#
# Logical device id CTL2011
#     Device supports vendor reserved register @ 0x3b
#     Device supports vendor reserved register @ 0x3c
#     Device supports vendor reserved register @ 0x3f
#
# Edit the entries below to uncomment out the configuration required.
# Note that only the first value of any range is given, this may be changed if 
required
# Don't forget to uncomment the activate (ACT Y) when happy

(CONFIGURE CTL0028/268620548 (LD 1
#     Compatible device id PNP0600
#     ANSI string -->IDE<--

# Multiple choice time, choose one only !

#     Start dependent functions: priority preferred
#       IRQ 10.
#             High true, edge sensitive interrupt (by default)
# (INT 0 (IRQ 10 (MODE +E)))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0168
#             Maximum IO base address 0x0168
#             IO base alignment 1 bytes
#             Number of IO addresses required: 8
# (IO 0 (SIZE 8) (BASE 0x0168))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x036e
#             Maximum IO base address 0x036e
#             IO base alignment 1 bytes
#             Number of IO addresses required: 2
# (IO 1 (SIZE 2) (BASE 0x036e))

#       Start dependent functions: priority acceptable
#       IRQ 11.
#             High true, edge sensitive interrupt (by default)
# (INT 0 (IRQ 11 (MODE +E)))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x01e8
#             Maximum IO base address 0x01e8
#             IO base alignment 1 bytes
#             Number of IO addresses required: 8
# (IO 0 (SIZE 8) (BASE 0x01e8))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x03ee
#             Maximum IO base address 0x03ee
#             IO base alignment 1 bytes
#             Number of IO addresses required: 2
# (IO 1 (SIZE 2) (BASE 0x03ee))

#       Start dependent functions: priority acceptable
#       IRQ 10, 11, 12 or 15.
#             High true, edge sensitive interrupt (by default)
# (INT 0 (IRQ 10 (MODE +E)))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0100
#             Maximum IO base address 0x01f8
#             IO base alignment 8 bytes
#             Number of IO addresses required: 8
# (IO 0 (SIZE 8) (BASE 0x0100))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0300
#             Maximum IO base address 0x03fe
#             IO base alignment 2 bytes
#             Number of IO addresses required: 2
# (IO 1 (SIZE 2) (BASE 0x0300))

#       Start dependent functions: priority functional
#       IRQ 15.
#             High true, edge sensitive interrupt (by default)
# (INT 0 (IRQ 15 (MODE +E)))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0170
#             Maximum IO base address 0x0170
#             IO base alignment 1 bytes
#             Number of IO addresses required: 8
# (IO 0 (SIZE 8) (BASE 0x0170))
#       Logical device decodes 16 bit IO address lines
#             Minimum IO base address 0x0376
#             Maximum IO base address 0x0376
#             IO base alignment 1 bytes
#             Number of IO addresses required: 1
# (IO 1 (SIZE 1) (BASE 0x0376))

#     End dependent functions
 (NAME "CTL0028/268620548[1]{IDE                 }")
# (ACT Y)
))
#
# Logical device id PNPffff
#     Device supports vendor reserved register @ 0x3b
#     Device supports vendor reserved register @ 0x3c
#     Device supports vendor reserved register @ 0x3f
#
# Edit the entries below to uncomment out the configuration required.
# Note that only the first value of any range is given, this may be changed if 
required
# Don't forget to uncomment the activate (ACT Y) when happy

(CONFIGURE CTL0028/268620548 (LD 2
#     ANSI string -->Reserved<--
#     Logical device decodes 16 bit IO address lines
#         Minimum IO base address 0x0100
#         Maximum IO base address 0x03f8
#         IO base alignment 8 bytes
#         Number of IO addresses required: 1
# (IO 0 (SIZE 1) (BASE 0x0100))
 (NAME "CTL0028/268620548[2]{Reserved            }")
# (ACT Y)
))
#
# Logical device id CTL7001
#     Device supports vendor reserved register @ 0x3b
#     Device supports vendor reserved register @ 0x3c
#     Device supports vendor reserved register @ 0x3f
#
# Edit the entries below to uncomment out the configuration required.
# Note that only the first value of any range is given, this may be changed if 
required
# Don't forget to uncomment the activate (ACT Y) when happy

(CONFIGURE CTL0028/268620548 (LD 3
#     Compatible device id PNPb02f
#     ANSI string -->Game<--
#     Logical device decodes 16 bit IO address lines
#         Minimum IO base address 0x0200
#         Maximum IO base address 0x0200
#         IO base alignment 1 bytes
#         Number of IO addresses required: 8
# (IO 0 (SIZE 8) (BASE 0x0200))
 (NAME "CTL0028/268620548[3]{Game                }")
# (ACT Y)
))
# End tag... Checksum 0x00 (OK)

# Returns all cards to the "Wait for Key" state
(WAITFORKEY)
pthree:~#                                   


Jan 10 12:27:17 pthree kernel: No module found in object
Jan 10 12:35:30 pthree kernel: Probing IDE interface ide2...
Jan 10 12:35:30 pthree kernel: hde: probing with STATUS(0x50) instead of 
ALTSTATUS(0xd0)
Jan 10 12:35:30 pthree kernel: hde: QUANTUM FIREBALL EX6.4A, ATA DISK drive
Jan 10 12:35:31 pthree kernel: hdf: probing with STATUS(0x00) instead of 
ALTSTATUS(0x80)
Jan 10 12:35:31 pthree kernel: hdf: probing with STATUS(0x00) instead of 
ALTSTATUS(0x80)
Jan 10 12:35:31 pthree kernel: ide2 at 0x168-0x16f,0x36e on irq 10
Jan 10 12:35:31 pthree kernel: hde: max request size: 128KiB
Jan 10 12:35:34 pthree udevd-event[5552]: wait_for_sysfs: waiting for 
'/sys/devices/ide2/2.0/bus' failed
Jan 10 12:36:01 pthree kernel: hde: irq timeout: status=0x52 { DriveReady 
SeekComplete Index }
Jan 10 12:36:01 pthree kernel: ide: failed opcode was: 0xf8
Jan 10 12:36:01 pthree kernel: hde: Host Protected Area detected.
Jan 10 12:36:01 pthree kernel: ^Icurrent capacity is 12594960 sectors (6448 
MB)
Jan 10 12:36:01 pthree kernel: ^Inative  capacity is 238293056 sectors (122006 
MB)
Jan 10 12:36:31 pthree kernel: hde: irq timeout: status=0x50 { DriveReady 
SeekComplete }
Jan 10 12:36:31 pthree kernel: ide: failed opcode was: 0xf9
Jan 10 12:36:31 pthree kernel: hde: Host Protected Area disabled.
Jan 10 12:36:31 pthree kernel: hde: 1 sectors (0 MB) w/418KiB Cache, 
CHS=13328/15/63
Jan 10 12:36:31 pthree kernel: hde: cache flushes not supported
Jan 10 12:36:41 pthree kernel:  hde:hde: irq timeout: status=0x58 { DriveReady 
SeekComplete DataRequest }
Jan 10 12:36:41 pthree kernel: ide: failed opcode was: unknown
Jan 10 12:36:51 pthree kernel: hde: irq timeout: status=0x58 { DriveReady 
SeekComplete DataRequest }
Jan 10 12:36:51 pthree kernel: ide: failed opcode was: unknown
Jan 10 12:37:21 pthree kernel: hde: irq timeout: status=0x50 { DriveReady 
SeekComplete }
Jan 10 12:37:21 pthree kernel: ide: failed opcode was: unknown
Jan 10 12:37:31 pthree kernel: hde: irq timeout: status=0x58 { DriveReady 
SeekComplete DataRequest }
.
.
.
.
.
.
.
Jan 10 12:40:51 pthree kernel: hde: irq timeout: status=0x50 { DriveReady 
SeekComplete }
Jan 10 12:40:51 pthree kernel: ide: failed opcode was: unknown
Jan 10 12:41:01 pthree kernel: hde: irq timeout: status=0x58 { DriveReady 
SeekComplete DataRequest }
Jan 10 12:41:01 pthree kernel: ide: failed opcode was: unknown
Jan 10 12:41:01 pthree kernel: ide2: reset: success
Jan 10 12:41:31 pthree kernel: hde: irq timeout: status=0x50 { DriveReady 
SeekComplete }
Jan 10 12:41:31 pthree kernel: ide: failed opcode was: unknown
Jan 10 12:42:01 pthree kernel: hde: irq timeout: status=0x50 { DriveReady 
SeekComplete }
Jan 10 12:42:01 pthree kernel: ide: failed opcode was: unknown
Jan 10 12:42:31 pthree kernel: hde: irq timeout: status=0x50 { DriveReady 
SeekComplete }
Jan 10 12:42:31 pthree kernel: ide: failed opcode was: unknown
Jan 10 12:42:41 pthree kernel: hde: irq timeout: status=0x58 { DriveReady 
SeekComplete DataRequest }
Jan 10 12:42:41 pthree kernel: ide: failed opcode was: unknown
Jan 10 12:42:41 pthree kernel: ide2: reset: success
Jan 10 12:43:11 pthree kernel: hde: irq timeout: status=0x50 { DriveReady 
SeekComplete }
Jan 10 12:43:11 pthree kernel: ide: failed opcode was: unknown
Jan 10 12:43:11 pthree kernel: end_request: I/O error, dev hde, sector 0
Jan 10 12:43:11 pthree kernel: Buffer I/O error on device hde, logical block 0
Jan 10 12:43:11 pthree kernel:  unable to read partition table
Jan 10 12:43:11 pthree kernel: ide2: generic PnP IDE interface



-- 
Fredrick O Jackson
1065 S Washington
Fayetteville AR 72701
479-313-4204
