Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVBRFQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVBRFQR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 00:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVBRFQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 00:16:17 -0500
Received: from bay101-f25.bay101.hotmail.com ([64.4.56.35]:46771 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261208AbVBRFQF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 00:16:05 -0500
Message-ID: <BAY101-F255EAA137B5062D367FF0AFE6E0@phx.gbl>
X-Originating-IP: [82.43.86.44]
X-Originating-Email: [rah1rah@hotmail.com]
From: "Richard Hoyle" <rah1rah@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Possible bug in the Linux 2.4.29 e1000 driver
Date: Fri, 18 Feb 2005 05:15:51 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 18 Feb 2005 05:16:03.0819 (UTC) FILETIME=[F147A3B0:01C51578]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There seems to be a bug in the Linux 2.4.29 e1000 driver.

With an SMP kernel on a single Intel 3.0GHZ HT cpu, and an 82547
NIC in half-duplex 100Mb/s mode, the kernel with lock up hard (no
nmi_watchdog=1 messages) under reasonably heavy transmit network
loads.  The bug does not manifest itself with a non SMP kernel,
and does not appear to be there in full duplex mode on a fully
switched network.

Using the e1000 driver from 2.4.28 or the latest 5.7.6 driver
seems to fix the problem.  I guess merging the latest driver
would be a good idea.

The 5.7.6 driver is available from:

http://sourceforge.net/project/showfiles.php?group_id=42302&package_id=54835

I'm using an Abit p4c800-E Deluxe m/b, and have verified this is
reproducible on similar machine with the same m/b.

Cheers,

===Rich

lspci -vv

02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet
Controller (LOM)
        Subsystem: Asustek Computer, Inc.: Unknown device 80f7

Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-

       Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-

        Latency: 0 (63750ns min), cache line size 04
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at fe9e0000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at cf80 [size=32]
        Capabilities: <available only to root>


cat /proc/cpuinfo

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping        : 9
cpu MHz         : 2998.594
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep
mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5989.99

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping        : 9
cpu MHz         : 2998.594
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep
mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5989.99

cat /proc/interrupts

          CPU0       CPU1
  0:     737790          0    IO-APIC-edge  timer
  1:          2          0    IO-APIC-edge  keyboard
  8:          1          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
14:       3767          1    IO-APIC-edge  ide0
15:         15          0    IO-APIC-edge  ide1
16:         25          0   IO-APIC-level  usb-uhci, usb-uhci
17:          0          0   IO-APIC-level  Intel ICH5
18:       4316          0   IO-APIC-level  eth0, usb-uhci
19:          0          0   IO-APIC-level  usb-uhci
20:          2          0   IO-APIC-level  ohci1394
23:          0          0   IO-APIC-level  ehci_hcd
NMI:     737722     737722
LOC:     737723     737727
ERR:          0
MIS:          0


uname -a
Linux p4-3gig 2.4.29 #1 SMP Tue Feb 15 16:40:54 GMT 2005 i686
unknown unknown GNU/Linux


