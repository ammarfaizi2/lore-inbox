Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbSKUVaP>; Thu, 21 Nov 2002 16:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbSKUVaP>; Thu, 21 Nov 2002 16:30:15 -0500
Received: from mail.cafes.net ([207.65.182.3]:12776 "EHLO mail.cafes.net")
	by vger.kernel.org with ESMTP id <S264844AbSKUVaH>;
	Thu, 21 Nov 2002 16:30:07 -0500
Date: Thu, 21 Nov 2002 15:31:22 -0600
From: Mike Eldridge <diz@cafes.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-rc2-xfs lockups
Message-ID: <20021121153122.B13338@ornery.cafes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

all,

i recently replaced a pII-350 with a pair of pIII-500s in a tyan
S1836-DLUAN-GX board (440GX dual slot 1).  i'm now getting loads of NMI
interrupts for unknown reasons (reasons 2c and 3c).

i thought perhaps it was because i was running a single-processor
non-APCI enabled kernel, so i built a smp-enabled kernel.  i still get
the errors.

per information i've garnered from the linux-kernel archives, i built a
kernel with basic ACPI support as well as enabling ACPI support in the
bios.  previously, both were disabled.  no dice.

up until now, these errors have been harmless.  however, i just
experienced a hard lockup while running X.  i can only assume the NMI
errors are a result.

i'm going to build a linux-2.2.22 kernel and give it a whirl.  other
ideas i have are: try APM instead if ACPI; try a single processor in the
board.  any suggestions are more than appreciated.

following are contents of /proc/pci, /proc/interrupts, and
/proc/cpuinfo.  if any other files would be of use, let me know.

thanks in advance,

-mike

------------------------------------------------------------------------
   /~\  the ascii                 grep me no patterns and I'll tell you
   \ /  ribbon campaign                                        no lines
    X   against html
   / \  email!


PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 440GX - 82443GX Host bridge (rev 0).
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xf0000000 [0xf7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 440GX - 82443GX AGP bridge (rev 0).
      Master Capable.  Latency=64.  Min Gnt=136.
  Bus  0, device   7, function  0:
    ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 2).
  Bus  0, device   7, function  1:
    IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 1).
      Master Capable.  Latency=64.  
      I/O at 0xffa0 [0xffaf].
  Bus  0, device   7, function  2:
    USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 1).
      IRQ 19.
      Master Capable.  Latency=64.  
      I/O at 0xef80 [0xef9f].
  Bus  0, device   7, function  3:
    Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 2).
      IRQ 9.
  Bus  0, device  16, function  0:
    PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 3).
      Master Capable.  Latency=64.  Min Gnt=3.
  Bus  0, device  17, function  0:
    Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 5).
      IRQ 19.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
      Prefetchable 32 bit memory at 0xfd4ff000 [0xfd4fffff].
      I/O at 0xef40 [0xef5f].
      Non-prefetchable 32 bit memory at 0xfea00000 [0xfeafffff].
  Bus  0, device  18, function  1:
    SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (#2) (rev 4).
      IRQ 16.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=8.
      I/O at 0xe800 [0xe8ff].
      Non-prefetchable 32 bit memory at 0xfebff000 [0xfebfffff].
  Bus  0, device  18, function  0:
    SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (rev 4).
      IRQ 16.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=8.
      I/O at 0xe400 [0xe4ff].
      Non-prefetchable 32 bit memory at 0xfebfe000 [0xfebfefff].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 4).
      IRQ 16.
      Master Capable.  Latency=64.  Min Gnt=16.Max Lat=32.
      Prefetchable 32 bit memory at 0xea000000 [0xebffffff].
      Non-prefetchable 32 bit memory at 0xfe5fc000 [0xfe5fffff].
      Non-prefetchable 32 bit memory at 0xfd800000 [0xfdffffff].

-----------------------------------------------------------------------

           CPU0       CPU1       
  0:      79088      85083    IO-APIC-edge  timer
  1:       1308       1230    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:          2         10    IO-APIC-edge  serial
  8:          1          0    IO-APIC-edge  rtc
  9:          0          0    IO-APIC-edge  acpi
 14:      56714      57395    IO-APIC-edge  ide0
 19:      16179      16113   IO-APIC-level  usb-uhci, eth0
NMI:         65          0 
LOC:     164100     164099 
ERR:          0
MIS:          0

-----------------------------------------------------------------------

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 2
cpu MHz		: 501.143
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 999.42

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 2
cpu MHz		: 501.143
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 999.42

