Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317003AbSHNMEL>; Wed, 14 Aug 2002 08:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317054AbSHNMEK>; Wed, 14 Aug 2002 08:04:10 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:32922 "EHLO nick")
	by vger.kernel.org with ESMTP id <S317003AbSHNMEJ>;
	Wed, 14 Aug 2002 08:04:09 -0400
Date: Wed, 14 Aug 2002 13:12:43 +0100 (BST)
From: Matt Bernstein <mb/lkml@dcs.qmul.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: GA-7DX+ crashes
Message-ID: <Pine.LNX.4.44.0208141239380.1472-100000@r2-pc.dcs.qmul.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Auth-User: mb
X-uvscan-result: clean (17ewwU-00075d-00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We're very much at a loss as to why the 60 new PCs we've bought largely
don't run Linux (various 2.4 kernels including 2.4.19, limbo1-BOOT) for
very long without crashing. One of them seems to work OK; its /proc/pci is 
identical, but the batch number on the southbridge seems one lower--is 
this dodgy VIA hardware again? We'll be trying a different IDE controller 
next, but 60 of those ain't cheap..

Has anyone else had success or failure stories in particular with this 
motherboard? We don't really have a significant number of data points just 
yet, but are willing to try pretty much anything anyone might suggest!

Matt

symptoms
- random data corruption (sometimes memory, more often HDD)
- somtimes oopsing, but never in the same place

what we think we've ascertained so far
- they pass memtest86
- we've tried different HDDs, no effect
- tried ide=nodma, possibly makes it crash after longer
- tried noapic, no effect
- tried all sorts of BIOS settings, no effect (except--possibly--turning 
	off the on board IDE controller and playing nfsroot games)
- ..and yet they seem to run that other OS fine :-(
- extra cooling/underclocking doesn't seem to help
- seems to be fs-independent (tried ext3, reiserfs, jfs)

hardware
- GA-7DX+ motherboard
- AMD 761 northbridge 
- VIA 686B southbridge
- Athlon 2000XP
- 256MB DDR RAM

/proc/pci and /proc/cpuinfo:

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System Controller (rev 20).
      Master Capable.  Latency=32.  
      Prefetchable 32 bit memory at 0xe8000000 [0xebffffff].
      Prefetchable 32 bit memory at 0xee006000 [0xee006fff].
      I/O at 0xd000 [0xd003].
  Bus  0, device   1, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] AGP Bridge (rev 0).
      Master Capable.  Latency=32.  Min Gnt=14.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 64).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=32.  
      I/O at 0xd400 [0xd40f].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 26).
      IRQ 11.
      Master Capable.  Latency=32.  
      I/O at 0xd800 [0xd81f].
  Bus  0, device   7, function  3:
    USB Controller: VIA Technologies, Inc. UHCI USB (#2) (rev 26).
      IRQ 11.
      Master Capable.  Latency=32.  
      I/O at 0xdc00 [0xdc1f].
  Bus  0, device   7, function  4:
    SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 64).
      IRQ 9.
  Bus  0, device   7, function  5:
    Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 80).
      IRQ 5.
      I/O at 0xe000 [0xe0ff].
      I/O at 0xe400 [0xe403].
      I/O at 0xe800 [0xe803].
  Bus  0, device  13, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 16).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0xec00 [0xecff].
      Non-prefetchable 32 bit memory at 0xee004000 [0xee0040ff].
  Bus  0, device  15, function  0:
    FireWire (IEEE 1394): Texas Instruments TSB12LV23 IEEE-1394 Controller (rev 0).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=15.Max Lat=15.
      Non-prefetchable 32 bit memory at 0xee005000 [0xee0057ff].
      Non-prefetchable 32 bit memory at 0xee000000 [0xee003fff].
  Bus  1, device   5, function  0:
    VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX) (rev 178).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xec000000 [0xecffffff].
      Prefetchable 32 bit memory at 0xe0000000 [0xe7ffffff].

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) XP 2000+
stepping	: 2
cpu MHz		: 1675.283
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 3342.33



