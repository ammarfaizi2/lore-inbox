Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267751AbUJRTtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267751AbUJRTtz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 15:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267651AbUJRTq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 15:46:26 -0400
Received: from ranger.systems.pipex.net ([62.241.162.32]:45033 "EHLO
	ranger.systems.pipex.net") by vger.kernel.org with ESMTP
	id S267638AbUJRTnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 15:43:25 -0400
Message-ID: <41741CDB.5010300@dsl.pipex.com>
Date: Mon, 18 Oct 2004 20:43:23 +0100
From: Johan Groth <jgroth@dsl.pipex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Dma problems with Promise IDE controller
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm using a Promise controller controlling 4 IDE HD:s, setup as a sw 
raid0 array. Lately I'm getting interuppt problems that looks like this:

Oct 18 18:03:06 lion kernel: hdg: dma_timer_expiry: dma status == 0x61
Oct 18 18:03:16 lion kernel: hdg: dma timeout retry: status=0x51 { 
DriveReady SeekComplete Error }
Oct 18 18:03:16 lion kernel: hdg: dma timeout retry: error=0x40 { 
UncorrectableError }, LBAsect=53500655, sector=53500520
Oct 18 18:03:16 lion kernel: end_request: I/O error, dev 22:01 (hdg), 
sector 53500520
Oct 18 18:03:16 lion kernel: blk: queue c030c85c, I/O limit 4095Mb (mask 
0xffffffff)
Oct 18 18:03:21 lion kernel: hdg: read_intr: status=0x59 { DriveReady 
SeekComplete DataRequest Error }
Oct 18 18:03:21 lion kernel: hdg: read_intr: error=0x40 { 
UncorrectableError }, LBAsect=53500655, sector=53500592
Oct 18 18:03:21 lion kernel: end_request: I/O error, dev 22:01 (hdg), 
sector 53500592

System info:
lion:~# uname -a
Linux lion 2.4.25 #4 Mon Aug 9 15:30:49 CEST 2004 i586 GNU/Linux

lion:~# gcc --version
gcc (GCC) 3.3.2 (Debian)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

lion:~# lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
         Flags: bus master, medium devsel, latency 16
         Memory at e0000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo 
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
         Flags: bus master, 66Mhz, medium devsel, latency 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 00009000-00009fff

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] 
(rev 12)
         Subsystem: VIA Technologies, Inc. VT82C596/A/B PCI to ISA Bridge
         Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
         Flags: bus master, medium devsel, latency 64
         I/O ports at a000 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 08) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Flags: bus master, medium devsel, latency 64, IRQ 11
         I/O ports at a400 [size=32]

00:07.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management 
(rev 20)
         Flags: medium devsel

00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20268 
(rev 02) (prog-if 85)
         Subsystem: Promise Technology, Inc. Ultra100TX2
         Flags: bus master, 66Mhz, slow devsel, latency 64, IRQ 12
         I/O ports at a800 [size=8]
         I/O ports at ac00 [size=4]
         I/O ports at b000 [size=8]
         I/O ports at b400 [size=4]
         I/O ports at b800 [size=16]
         Memory at eb100000 (32-bit, non-prefetchable) [size=16K]
         Expansion ROM at e8000000 [disabled] [size=16K]
         Capabilities: [60] Power Management version 1

lion:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 9
model name      : AMD-K6(tm) 3D+ Processor
stepping        : 1
cpu MHz         : 451.036
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow 
k6_mtrr
bogomips        : 897.84

hde: WDC WD800BB-32BSA0, ATA DISK drive
hdf: WDC WD800BB-32BSA0, ATA DISK drive
blk: queue c030c408, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c030c544, I/O limit 4095Mb (mask 0xffffffff)
hdg: WDC WD800BB-32BSA0, ATA DISK drive
hdh: WDC WD800BB-32CCB0, ATA DISK drive
blk: queue c030c85c, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c030c998, I/O limit 4095Mb (mask 0xffffffff)

Well, that is all the info I can think of.
As you can see the system is a:
AMD K6-3 450 MHz with VIA Apollo MVP3 chipset.
Promise Ultra TX02 controller
4 x Western Digital 80 GB ATA100

I thought the controller was dying so I bought a new one but with the 
same result. Can it be that hdg is dying?

Please, CC me as I'm not subscribed to this list.

Regards,
Johan Groth
