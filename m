Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316143AbSEJWFy>; Fri, 10 May 2002 18:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316144AbSEJWFx>; Fri, 10 May 2002 18:05:53 -0400
Received: from iq.mensalinux.org ([208.255.12.114]:24448 "EHLO
	iq.mensalinux.org") by vger.kernel.org with ESMTP
	id <S316143AbSEJWFv>; Fri, 10 May 2002 18:05:51 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Jason Straight <jason@blazeconnect.net>
To: linux-kernel@vger.kernel.org
Subject: irq handling and APM on new Laptop Sony Vaio GRX 570
Date: Fri, 10 May 2002 18:06:21 -0400
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200205101806.21465.jason@blazeconnect.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I apparently have a system with a bios that doesn't play well with linux.

Laptop - Sony Vaio GRX 570 i8x0
The only problems I'm having are with audio (ac97_codec), and the modem (hcf).

The sound is choppy.

And the modem just won't work (drivers installed). All modules load clean when 
I try to access the modems dev with minicom or ppp but it won't communicate. 
I'm just guessing because it doesn't get assigned an IRQ.

I've tried booting with the pci=biosirq parm with no luck. If anyone has any 
ideas what I can do, thanks.

/proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 
4).
      Prefetchable 32 bit memory at 0xec000000 [0xefffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 4).
      Master Capable.  Latency=96.  Min Gnt=12.
  Bus  0, device  29, function  0:
    USB Controller: PCI device 8086:2482 (Intel Corp.) (rev 2).
      IRQ 9.
      I/O at 0x1800 [0x181f].
  Bus  0, device  29, function  1:
    USB Controller: PCI device 8086:2484 (Intel Corp.) (rev 2).
      IRQ 9.
      I/O at 0x1820 [0x183f].
  Bus  0, device  29, function  2:
    USB Controller: PCI device 8086:2487 (Intel Corp.) (rev 2).
      I/O at 0x1840 [0x185f].
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (-M) (rev 66).
      Master Capable.  No bursts.  Min Gnt=4.
  Bus  0, device  31, function  0:
    ISA bridge: PCI device 8086:248c (Intel Corp.) (rev 2).
  Bus  0, device  31, function  1:
    IDE interface: PCI device 8086:248a (Intel Corp.) (rev 2).
      I/O at 0x1f0 [0x1f7].
      I/O at 0x3f6 [0x3f6].
      I/O at 0x170 [0x177].
      I/O at 0x376 [0x376].
      I/O at 0x1860 [0x186f].
      Non-prefetchable 32 bit memory at 0xe8000000 [0xe80003ff].
  Bus  0, device  31, function  3:
    SMBus: PCI device 8086:2483 (Intel Corp.) (rev 2).
      I/O at 0x1880 [0x189f].
  Bus  0, device  31, function  5:
    Multimedia audio controller: Intel Corp. AC'97 Audio Controller (rev 2).
      IRQ 9.
      I/O at 0x1c00 [0x1cff].
      I/O at 0x18c0 [0x18ff].
  Bus  0, device  31, function  6:
    Modem: PCI device 8086:2486 (Intel Corp.) (rev 2).
      I/O at 0x2400 [0x24ff].
      I/O at 0x2000 [0x207f].
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LW (rev 
0).
      IRQ 9.
      Master Capable.  Latency=66.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xf0000000 [0xf7ffffff].
      I/O at 0x3000 [0x30ff].
      Non-prefetchable 32 bit memory at 0xe8100000 [0xe810ffff].
  Bus  2, device   5, function  0:
    CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 168).
      IRQ 3.
      Master Capable.  Latency=168.  Min Gnt=128.Max Lat=7.
      Non-prefetchable 32 bit memory at 0xe8202000 [0xe8202fff].
  Bus  2, device   5, function  1:
    CardBus bridge: Ricoh Co Ltd RL5c476 II (#2) (rev 168).
      Master Capable.  Latency=168.  Min Gnt=128.Max Lat=7.
      Non-prefetchable 32 bit memory at 0xe8203000 [0xe8203fff].
  Bus  2, device   5, function  2:
    FireWire (IEEE 1394): PCI device 1180:0552 (Ricoh Co Ltd) (rev 0).
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=4.
      Non-prefetchable 32 bit memory at 0xe8201000 [0xe82017ff].
  Bus  2, device   8, function  0:
    Ethernet controller: Intel Corp. 82801CAM (ICH3) Chipset Ethernet 
Controller (rev 66).
      IRQ 9.
      Master Capable.  Latency=66.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xe8200000 [0xe8200fff].
      I/O at 0x4000 [0x403f].

/proc/interrupts
           CPU0       
  0:     184731          XT-PIC  timer
  1:       9048          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       5826          XT-PIC  orinoco_cs
  8:      17213          XT-PIC  rtc
  9:          0          XT-PIC  usb-uhci, usb-uhci, Intel ICH3
 12:       9703          XT-PIC  PS/2 Mouse
 14:      29574          XT-PIC  ide0
 15:       2681          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0

/proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0100-013f : orinoco_cs
0170-0177 : PCI device 8086:248a (Intel Corp.)
  0170-0177 : ide1
01f0-01f7 : PCI device 8086:248a (Intel Corp.)
  01f0-01f7 : ide0
0376-0376 : PCI device 8086:248a (Intel Corp.)
  0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : PCI device 8086:248a (Intel Corp.)
  03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1800-181f : PCI device 8086:2482 (Intel Corp.)
  1800-181f : usb-uhci
1820-183f : PCI device 8086:2484 (Intel Corp.)
  1820-183f : usb-uhci
1840-185f : PCI device 8086:2487 (Intel Corp.)
1860-186f : PCI device 8086:248a (Intel Corp.)
  1860-1867 : ide0
  1868-186f : ide1
1880-189f : PCI device 8086:2483 (Intel Corp.)
18c0-18ff : Intel Corp. AC'97 Audio Controller
  18c0-18ff : Intel ICH3
1c00-1cff : Intel Corp. AC'97 Audio Controller
  1c00-1cff : Intel ICH3
2000-207f : PCI device 8086:2486 (Intel Corp.)
2400-24ff : PCI device 8086:2486 (Intel Corp.)
3000-3fff : PCI Bus #01
  3000-30ff : ATI Technologies Inc Radeon Mobility M6 LW
4000-4fff : PCI Bus #02
  4000-403f : Intel Corp. 82801CAM (ICH3) Chipset Ethernet Controller
    4000-403f : eepro100




-- 

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Jason Straight
President
BlazeConnect Internet Services
Cheboygan Michigan
www.blazeconnect.net
Phone: 231-597-0376

