Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261307AbSJYIa1>; Fri, 25 Oct 2002 04:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261309AbSJYIa0>; Fri, 25 Oct 2002 04:30:26 -0400
Received: from cibs9.sns.it ([192.167.206.29]:30215 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S261307AbSJYIaY>;
	Fri, 25 Oct 2002 04:30:24 -0400
Date: Fri, 25 Oct 2002 10:35:57 +0200 (CEST)
From: venom@sns.it
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org, <arjanv@redhat.com>
Subject: Re: [CFT] faster athlon/duron memory copy implementation
In-Reply-To: <3DB82ABF.8030706@colorfullife.com>
Message-ID: <Pine.LNX.4.43.0210251031470.11695-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


on a DUAL Athlon 2100+ (2GB RAM, kernel 2.4.19):

I get:

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 21467 cycles per page
copy_page function '2.4 non MMX'         took 24583 cycles per page
copy_page function '2.4 MMX fallback'    took 24534 cycles per page
copy_page function '2.4 MMX version'     took 21312 cycles per page
copy_page function 'faster_copy'         took 12060 cycles per page
copy_page function 'even_faster'         took 12152 cycles per page
copy_page function 'no_prefetch'         took 10587 cycles per page


copy_page() tests
copy_page function 'warm up run'         took 21458 cycles per page
copy_page function '2.4 non MMX'         took 24592 cycles per page
copy_page function '2.4 MMX fallback'    took 24585 cycles per page
copy_page function '2.4 MMX version'     took 21334 cycles per page
copy_page function 'faster_copy'         took 12090 cycles per page
copy_page function 'even_faster'         took 12146 cycles per page
copy_page function 'no_prefetch'         took 10583 cycles per page


copy_page() tests
copy_page function 'warm up run'         took 21433 cycles per page
copy_page function '2.4 non MMX'         took 24557 cycles per page
copy_page function '2.4 MMX fallback'    took 24570 cycles per page
copy_page function '2.4 MMX version'     took 21331 cycles per page
copy_page function 'faster_copy'         took 12039 cycles per page
copy_page function 'even_faster'         took 12126 cycles per page
copy_page function 'no_prefetch'         took 10576 cycles per page



processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1733.362
cache size      : 256 KB
Physical processor ID   : 0
Number of siblings      : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3432.80

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1733.362
cache size      : 256 KB
Physical processor ID   : 0
Number of siblings      : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3466.21


CI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System
Controller (rev 17).
      Master Capable.  Latency=64.
      Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
      Prefetchable 32 bit memory at 0xf6200000 [0xf6200fff].
      I/O at 0x1810 [0x1813].
  Bus  0, device   1, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP
Bridge (rev 0).
      Master Capable.  Latency=64.  Min Gnt=4.
  Bus  0, device   7, function  0:
    ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 5).
  Bus  0, device   7, function  1:
    IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev
4).
      Master Capable.  Latency=64.
      I/O at 0xf000 [0xf00f].
  Bus  0, device   7, function  3:
    Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 3).
      Master Capable.  Latency=64.
  Bus  0, device  10, function  0:
    SCSI storage controller: Adaptec AIC-7899P U160/m (rev 1).
      IRQ 10.
      Master Capable.  Latency=72.  Min Gnt=40.Max Lat=25.
      I/O at 0x1000 [0x10ff].
      Non-prefetchable 64 bit memory at 0xf4000000 [0xf4000fff].
  Bus  0, device  10, function  1:
    SCSI storage controller: Adaptec AIC-7899P U160/m (#2) (rev 1).
      IRQ 11.
      Master Capable.  Latency=72.  Min Gnt=40.Max Lat=25.
      I/O at 0x1400 [0x14ff].
      Non-prefetchable 64 bit memory at 0xf4001000 [0xf4001fff].
  Bus  0, device  16, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 5).
      Master Capable.  Latency=99.  Min Gnt=12.
  Bus  2, device   0, function  0:
    USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev
7).
      IRQ 10.
      Master Capable.  Latency=64.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xf4100000 [0xf4100fff].
  Bus  2, device   7, function  0:
    VGA compatible controller: ATI Technologies Inc Rage XL (rev 39).
      Master Capable.  Latency=66.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0xf5000000 [0xf5ffffff].
      I/O at 0x2000 [0x20ff].
      Non-prefetchable 32 bit memory at 0xf4101000 [0xf4101fff].
  Bus  2, device   8, function  0:
    Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC
[Python-T] (rev 120).
      IRQ 5.
      Master Capable.  Latency=80.  Min Gnt=10.Max Lat=10.
      I/O at 0x2400 [0x247f].
      Non-prefetchable 32 bit memory at 0xf4102000 [0xf410207f].
  Bus  2, device   9, function  0:
    Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC
[Python-T] (#2) (rev 120).
      IRQ 9.
      Master Capable.  Latency=80.  Min Gnt=10.Max Lat=10.
      I/O at 0x2480 [0x24ff].
      Non-prefetchable 32 bit memory at 0xf4102400 [0xf410247f].


