Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266886AbRGFWnv>; Fri, 6 Jul 2001 18:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266887AbRGFWnl>; Fri, 6 Jul 2001 18:43:41 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:49347 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S266886AbRGFWna>; Fri, 6 Jul 2001 18:43:30 -0400
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_DTB2AVAKJABQ8AXX8XYK"
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: linux-kernel@vger.kernel.org
Subject: 2.4.6 APM suspend kills Dell inspiron 3500 sound card, but revives network card.
Date: Fri, 6 Jul 2001 13:41:37 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01070613413700.01148@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_DTB2AVAKJABQ8AXX8XYK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

My devices on my laptop work very strangely with kernel 2.4.6.

-- Sound problems:

The sound card on my laptop (Dell Inspiron 3500) works fine when the system 
first boots up, but stops working with the first suspend.  Any attempt to 
write sound to it after that blocks indefinitely.  I don't even get console 
beeps until I reboot.

That's under kde with their not-esd daemon (I.E. using noatun).  If I do the 
same from the console it still plays fine before the suspend (using mpg123), 
and afterwords plays short samples in a loop with "DMA timeout" error 
messages to the console.

-- Network problems.

I have 3 pcmcia network cards (10baseT xircomm, 100baseT cardbus thing that 
isn't with me right now, and a wireless card.)  The two 10baseT (pcmica) ones 
have about the same behavior, the 100baseT (cardbus?) one's a little 
different.

Under previous kernels (the mutuant red hat 7.1 2.4.2), the pcmcia network 
card would work fine on boot but die when the system suspends.  (I didn't 
mind because I could pop it out and put it back in and it would work again.)  
Now with 2.4.6 it's exactly the OPPOSITE behavior: the network card doesn't 
work at all until I suspend and resume, but when the system comes back up 
after a suspend the card works fine.  Before the suspend, popping it out and 
putting it back in accomplish nothing.  Afterwards popping out and putting in 
work great, re-runs dhcpcd and everything.

Back under red hat's 2.4.2, putting the cardbus card in, suspending, 
resuming, and popping the card out produced a kernel panic.  I haven't tried 
with 2.4.6 (don't have the card with me), but I can try to reproduce this 
under 2.4.6 if it sounds interesting to anybody...

-- Fun little detail:

The two cardbus bridges and the sound card are all on IRQ 11, it seems.  
/proc/pci attached.

Rob

(P.S.  I take it the XFree86 hangs are an XFree86 problem, not kernel?  Rat 
pointer still moves, drive still chugs a bit in the background, so the kernel 
seems sort of still there...  Can't get out of the frozen gui though, no 
ctrl-alt-F1, no ctrl-alt-backspace...  Oh well.)
--------------Boundary-00=_DTB2AVAKJABQ8AXX8XYK
Content-Type: text/plain;
  charset="iso-8859-1";
  name="pci"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="pci"

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 2).
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 2).
      Master Capable.  Latency=128.  Min Gnt=140.
  Bus  0, device   4, function  0:
    CardBus bridge: Texas Instruments PCI1220 (rev 2).
      IRQ 11.
      Master Capable.  Latency=168.  Min Gnt=192.Max Lat=5.
      Non-prefetchable 32 bit memory at 0x10000000 [0x10000fff].
  Bus  0, device   4, function  1:
    CardBus bridge: Texas Instruments PCI1220 (#2) (rev 2).
      IRQ 11.
      Master Capable.  Latency=168.  Min Gnt=192.Max Lat=5.
      Non-prefetchable 32 bit memory at 0x10001000 [0x10001fff].
  Bus  0, device   7, function  0:
    Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 2).
  Bus  0, device   7, function  1:
    IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 1).
      Master Capable.  Latency=64.  
      I/O at 0xfcd0 [0xfcdf].
  Bus  0, device   7, function  2:
    USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 1).
      IRQ 10.
      Master Capable.  Latency=64.  
      I/O at 0xfce0 [0xfcff].
  Bus  0, device   7, function  3:
    Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 2).
      IRQ 9.
  Bus  1, device   0, function  0:
    VGA compatible controller: Neomagic Corporation [MagicMedia 256AV] (rev 18).
      Master Capable.  Latency=128.  Min Gnt=16.Max Lat=255.
      Prefetchable 32 bit memory at 0xfd000000 [0xfdffffff].
      Non-prefetchable 32 bit memory at 0xfe800000 [0xfebfffff].
      Non-prefetchable 32 bit memory at 0xfec00000 [0xfecfffff].
  Bus  1, device   0, function  1:
    Multimedia audio controller: Neomagic Corporation [MagicMedia 256AV Audio] (rev 18).
      IRQ 11.
      Prefetchable 32 bit memory at 0xfe000000 [0xfe3fffff].
      Non-prefetchable 32 bit memory at 0xfe700000 [0xfe7fffff].

--------------Boundary-00=_DTB2AVAKJABQ8AXX8XYK
Content-Type: text/plain;
  charset="iso-8859-1";
  name="modules"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="modules"

xirc2ps_cs             11808   1
ad1848                 17456   1
sound                  57728   1 [ad1848]

--------------Boundary-00=_DTB2AVAKJABQ8AXX8XYK--
