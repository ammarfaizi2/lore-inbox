Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbSJZEgZ>; Sat, 26 Oct 2002 00:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261856AbSJZEgZ>; Sat, 26 Oct 2002 00:36:25 -0400
Received: from CPE3236333432363339.cpe.net.cable.rogers.com ([24.101.90.246]:37124
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S261855AbSJZEgX>; Sat, 26 Oct 2002 00:36:23 -0400
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: [CFT] faster athlon/duron memory copy implementation - 2.5.44 vanilla Test
Date: Sat, 26 Oct 2002 00:45:46 -0400
User-Agent: KMail/1.4.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200210260045.46366.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Single CPU only (SMP capable)

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) MP 2000+
stepping        : 2
cpu MHz         : 1680.359
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3309.56

[Notes: 2.5 seems to show slower Mhz / bogos]

RAM is PC2100 Registered DDR 512MB 
Motherboard/Chipset: A7M266-D AMD 760MPX

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controller (rev 11)
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 04)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 04)

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controller
(rev 17).
      Master Capable.  Latency=32.
      Prefetchable 32 bit memory at 0xf0000000 [0xf7ffffff].
      Prefetchable 32 bit memory at 0xef800000 [0xef800fff].
      I/O at 0xe800 [0xe803].
  Bus  0, device   1, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge 
(rev 0).
      Master Capable.  No bursts.  Min Gnt=8.

Kernel Preformed on: 2.5.44 vanilla

gcc (GCC) 3.2.1 20021011 (prerelease)
Copyright (C) 2002 Free Software Foundation, Inc.

gcc athlon.c -O3 -march=athlon-mp -mcpu=athlon-mp -falign-functions 
-fomit-frame-pointer 
-mpreferred-stack-boundary=2 -falign-functions=4 -fschedule-insns2 
-fexpensive-optimizations -o athlon

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 21014 cycles per page
copy_page function '2.4 non MMX'         took 23435 cycles per page
copy_page function '2.4 MMX fallback'    took 23399 cycles per page
copy_page function '2.4 MMX version'     took 20983 cycles per page
copy_page function 'faster_copy'         took 11722 cycles per page
copy_page function 'even_faster'         took 12030 cycles per page
copy_page function 'no_prefetch'         took 9433 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 20766 cycles per page
copy_page function '2.4 non MMX'         took 23229 cycles per page
copy_page function '2.4 MMX fallback'    took 23187 cycles per page
copy_page function '2.4 MMX version'     took 20889 cycles per page
copy_page function 'faster_copy'         took 11654 cycles per page
copy_page function 'even_faster'         took 11967 cycles per page
copy_page function 'no_prefetch'         took 9428 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 20957 cycles per page
copy_page function '2.4 non MMX'         took 23600 cycles per page
copy_page function '2.4 MMX fallback'    took 23471 cycles per page
copy_page function '2.4 MMX version'     took 20943 cycles per page
copy_page function 'faster_copy'         took 11724 cycles per page
copy_page function 'even_faster'         took 12029 cycles per page
copy_page function 'no_prefetch'         took 9422 cycles per page

[Note: this seems very slightly slower but more consistant then 2.4.20-pre7]

Shawn.


