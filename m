Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286895AbSBMPmC>; Wed, 13 Feb 2002 10:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287003AbSBMPln>; Wed, 13 Feb 2002 10:41:43 -0500
Received: from 75-223.davnet.com.hk ([202.69.75.223]:65169 "EHLO
	nicksbox.tyict.vtc.edu.hk") by vger.kernel.org with ESMTP
	id <S286893AbSBMPld>; Wed, 13 Feb 2002 10:41:33 -0500
Message-ID: <3C6A890F.FF90C3BB@vtc.edu.hk>
Date: Wed, 13 Feb 2002 23:41:04 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-pre7-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: cmd649 ok 1 cpu, 2 cpus, not working
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear team,

I use cmd649 IDE cards with 1 CPU no problems (long term experience),
but with 2 CPUs, it has never worked with an ACER Altos 2-cpu system
(dual p-iii 800 MHz) with many different kernels, all the way from
2.4.10-acx to 2.4.18-pre9-ac2.
Here we have 2.4.18-pre9-ac2,

In this system, we have SCSI disks, and a cmd649 card with an
unrecognised disk attached to the primary.

$ ls -l /proc/ide
total 0
-r--r--r--    1 root     root            0 Feb 13 23:39 cmd64x
-r--r--r--    1 root     root            0 Feb 13 23:39 drivers
lrwxrwxrwx    1 root     root            8 Feb 13 23:39 hda -> ide0/hda
dr-xr-xr-x    3 root     root            0 Feb 13 23:39 ide0
-r--r--r--    1 root     root            0 Feb 13 23:39 via
[nicku@ictlab] /proc/ide
1009 $ cat via
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.29
South Bridge:                       VIA vt82c686a
Revision:                           ISA 0x22 IDE 0x10
Highest DMA rate:                   UDMA66
BM-DMA base:                        0x90c0
PCI clock:                          33MHz
Master Read  Cycle IRDY:            1ws
Master Write Cycle IRDY:            1ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                  no
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       DMA       DMA       DMA
Address Setup:       30ns     120ns     120ns     120ns
Cmd Active:          90ns      90ns     480ns     480ns
Cmd Recovery:        30ns      30ns     480ns     480ns
Data Active:         90ns     330ns     330ns     330ns
Data Recovery:       30ns     270ns     270ns     270ns
Cycle Time:          60ns     600ns     600ns     600ns
Transfer Rate:   33.0MB/s   3.3MB/s   3.3MB/s   3.3MB/s

$ cat cmd64x

                                CMD649 Chipset.
--------------- Primary Channel ---------------- Secondary Channel
-------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ----------
drive1 ------
DMA enabled:    no               no              no                no
DMA Mode:        PIO(?)           PIO(?)          PIO(?)
PIO(?)
PIO Mode:       ?                ?               ?                 ?
                polling                          polling
                pending                          clear
                enabled                          enabled
CFR       = 0x44, HI = 0x04, LOW = 0x04
ARTTIM23  = 0x0c, HI = 0x00, LOW = 0x0c
MRDMODE   = 0x04, HI = 0x00, LOW = 0x04
[nicku@ictlab] /proc/ide
1005 $ ls -l /proc/ide
total 0
-r--r--r--    1 root     root            0 Feb 13 23:24 cmd64x
-r--r--r--    1 root     root            0 Feb 13 23:24 drivers
lrwxrwxrwx    1 root     root            8 Feb 13 23:24 hda -> ide0/hda
dr-xr-xr-x    3 root     root            0 Feb 13 23:24 ide0
-r--r--r--    1 root     root            0 Feb 13 23:24 via
$ sudo lspci -v
Password:
00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev
c4)
        Flags: bus master, medium devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00007000-00007fff
        Memory behind bridge: 80100000-820fffff
        Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 22)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
(prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at 90c0 [size=16]
        Capabilities: [c0] Power Management version 2

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at 9080 [size=32]
        Capabilities: [80] Power Management version 2

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
        Flags: medium devsel
        Capabilities: [68] Power Management version 2

00:08.0 RAID bus controller: CMD Technology Inc PCI0649 (rev 02)
        Subsystem: CMD Technology Inc PCI0649
        Flags: bus master, medium devsel, latency 64, IRQ 16
        I/O ports at 8000 [size=8]
        I/O ports at 8040 [size=4]
        I/O ports at 8080 [size=8]
        I/O ports at 80c0 [size=4]
        I/O ports at 8400 [size=16]
        Expansion ROM at 82100000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2

00:0d.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corporation 82559 Fast Ethernet LAN on Motherboard
        Flags: bus master, medium devsel, latency 32, IRQ 18
        Memory at 82700000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 9000 [size=64]
        Memory at 82800000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at 82900000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2

00:0f.0 SCSI storage controller: Adaptec 7899P (rev 01)
        Subsystem: Acer Incorporated [ALI]: Unknown device 2005
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 19
        BIST result: 00
        I/O ports at 8800 [disabled] [size=256]
        Memory at 82181000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at 821a0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

00:0f.1 SCSI storage controller: Adaptec 7899P (rev 01)
        Subsystem: Acer Incorporated [ALI]: Unknown device 2005
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 19
        BIST result: 00
        I/O ports at 8c00 [disabled] [size=256]
        Memory at 82182000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at 821c0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP (rev 65) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0008
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 17
        Memory at 81000000 (32-bit, non-prefetchable) [size=16M]
        I/O ports at 7000 [size=256]
        Memory at 80100000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 80120000 [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0
        Capabilities: [5c] Power Management version 1

[nicku@ictlab] /proc/ide
1007 $ sudo lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
        Flags: bus master, medium devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00007000-00007fff
        Memory behind bridge: 80100000-820fffff
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at 90c0 [size=16]
        Capabilities: [c0] Power Management version 2

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at 9080 [size=32]
        Capabilities: [80] Power Management version 2

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
        Flags: medium devsel
        Capabilities: [68] Power Management version 2

00:08.0 RAID bus controller: CMD Technology Inc PCI0649 (rev 02)
        Subsystem: CMD Technology Inc PCI0649
        Flags: bus master, medium devsel, latency 64, IRQ 16
        I/O ports at 8000 [size=8]
        I/O ports at 8040 [size=4]
        I/O ports at 8080 [size=8]
        I/O ports at 80c0 [size=4]
        I/O ports at 8400 [size=16]
        Expansion ROM at 82100000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2

00:0d.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corporation 82559 Fast Ethernet LAN on Motherboard
        Flags: bus master, medium devsel, latency 32, IRQ 18
        Memory at 82700000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 9000 [size=64]
        Memory at 82800000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at 82900000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2

00:0f.0 SCSI storage controller: Adaptec 7899P (rev 01)
        Subsystem: Acer Incorporated [ALI]: Unknown device 2005
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 19
        BIST result: 00
        I/O ports at 8800 [disabled] [size=256]
        Memory at 82181000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at 821a0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

00:0f.1 SCSI storage controller: Adaptec 7899P (rev 01)
        Subsystem: Acer Incorporated [ALI]: Unknown device 2005
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 19
        BIST result: 00
        I/O ports at 8c00 [disabled] [size=256]
        Memory at 82182000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at 821c0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP (rev 65) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0008
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 17
        Memory at 81000000 (32-bit, non-prefetchable) [size=16M]
        I/O ports at 7000 [size=256]
        Memory at 80100000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 80120000 [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0
        Capabilities: [5c] Power Management version 1

Desperate to solve this.  It is the departmental student server and I
only have ATA disks to solve the out of disk space problem.  We have
over 1000 studnet accounts on this used daily.

--
Nick Urbanik   RHCE                                  nicku@vtc.edu.hk
Dept. of Information & Communications Technology
Hong Kong Institute of Vocational Education (Tsing Yi)
Tel:   (852) 2436 8576, (852) 2436 8579          Fax: (852) 2436 8526
PGP: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B     ID: 7529555D
GPG: 7FFA CDC7 5A77 0558 DC7A 790A 16DF EC5B BB9D 2C24   ID: BB9D2C24


