Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271674AbRHUQBL>; Tue, 21 Aug 2001 12:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271684AbRHUQBD>; Tue, 21 Aug 2001 12:01:03 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:9121 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S271674AbRHUQA4>; Tue, 21 Aug 2001 12:00:56 -0400
Message-ID: <3B8285A9.8030306@korseby.net>
Date: Tue, 21 Aug 2001 18:00:41 +0200
From: Kristian <kristian@korseby.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: de, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: cwidmer@iiic.ethz.ch, linux-kernel@vger.kernel.org
Subject: Re: massive filesystem corruption with 2.4.9
In-Reply-To: <E15ZC3L-0007s7-00@the-village.bc.nu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
 > Typically this indicates disk, memory or chipset problems. If your disk is
 > in UDMA33/66 mode you can pretty rule the disk out as the data is
 > protected
 >
 > If you have a VIA chipset, especially if there is an SB Live! in the machine
 > then that may be the cause (fixes in 2.4.8-ac, should be a fix in 2.4.9 but
 > Linus tree also applies another bogus change but which should be harmless)

No. I can't find any VIA chipset. I'm really surprised. :-) But it is an
original Compaq-Board (EP-Series..) with a horroble BIOS. It seems that they're
using intel only..

I did a probe of my harddisk with IBM's Drive Fitness program. It detected no
errors.

Here's the output of it:

     Model                   : IBM-DTLA-305040
     Serial no.              : YJ025714
     Capacity                : 41.17 GB
     Cache size              : 380 KB
     Microcode level         : TW4OA60A
     ATA Compliance          : ATA-5

     Ultra DMA
       Highest mode          : 5
       Active mode           : 1

     Settings
       Write cache           : Enabled
       Read look-ahead       : Enabled
       Auto reassign         : Enabled
       S.M.A.R.T. operations : Enabled
       S.M.A.R.T. status     : Good
       ABLE                  : Disabled
       AAM                   : Disabled
       Security feature      : Supported
         Password            : Not Set


Here is the output of cat /proc/pci:
PCI devices found:
    Bus  0, device   0, function  0:
      Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 3).
        Master Capable.  Latency=64.
        Prefetchable 32 bit memory at 0x44000000 [0x47ffffff].
    Bus  0, device   1, function  0:
      PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 3).
        Master Capable.  Latency=64.  Min Gnt=140.
    Bus  0, device  14, function  0:
      Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 5).
        IRQ 11.
        Master Capable.  Latency=66.  Min Gnt=8.Max Lat=56.
        Prefetchable 32 bit memory at 0x48100000 [0x48100fff].
        I/O at 0x1000 [0x101f].
        Non-prefetchable 32 bit memory at 0x48000000 [0x480fffff].
    Bus  0, device  15, function  0:
      Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 6).
        IRQ 11.
        Master Capable.  Latency=64.  Min Gnt=12.Max Lat=128.
        I/O at 0x1080 [0x10bf].
    Bus  0, device  16, function  0:
      Multimedia video controller: Brooktree Corporation Bt878 (rev 17).
        IRQ 11.
        Master Capable.  Latency=66.  Min Gnt=16.Max Lat=40.
        Prefetchable 32 bit memory at 0x48200000 [0x48200fff].
    Bus  0, device  16, function  1:
      Multimedia controller: Brooktree Corporation Bt878 (rev 17).
        IRQ 11.
        Master Capable.  Latency=66.  Min Gnt=4.Max Lat=255.
        Prefetchable 32 bit memory at 0x48300000 [0x48300fff].
    Bus  0, device  20, function  0:
      ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 2).
    Bus  0, device  20, function  1:
      IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 1).
        Master Capable.  Latency=64.
        I/O at 0x1040 [0x104f].
    Bus  0, device  20, function  2:
      USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 1).
        IRQ 11.
        Master Capable.  Latency=64.
        I/O at 0x1020 [0x103f].
    Bus  0, device  20, function  3:
      Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 2).
        IRQ 9.
    Bus  1, device   0, function  0:
      VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 130).
        IRQ 11.
        Master Capable.  Latency=64.  Min Gnt=16.Max Lat=32.
        Prefetchable 32 bit memory at 0x42000000 [0x43ffffff].
        Non-prefetchable 32 bit memory at 0x40800000 [0x40803fff].
        Non-prefetchable 32 bit memory at 0x40000000 [0x407fffff].

/proc/cpuinfo:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 597.413
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 mmx fxsr sse
bogomips        : 1192.75

/proc/interrupts:

    0:    1337585          XT-PIC  timer
    1:      46916          XT-PIC  keyboard
    2:          0          XT-PIC  cascade
    8:          1          XT-PIC  rtc
   11:     162990          XT-PIC  es1371, bttv, eth0
   12:     294331          XT-PIC  PS/2 Mouse
   14:      21839          XT-PIC  ide0
   15:         17          XT-PIC  ide1
NMI:          0
ERR:          0


Kristian

·· · · reach me :: · ·· ·· ·  · ·· · ··  · ··· · ·
                           :: http://www.korseby.net
                           :: http://www.tomlab.de
kristian@korseby.net ....::

