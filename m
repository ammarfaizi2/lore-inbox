Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310364AbSCBMhh>; Sat, 2 Mar 2002 07:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310365AbSCBMh1>; Sat, 2 Mar 2002 07:37:27 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:51724 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id <S310364AbSCBMhR>; Sat, 2 Mar 2002 07:37:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Stephen Mollett <molletts@yahoo.com>
Organization: Total lack thereof
To: linux-kernel@vger.kernel.org
Subject: Handling of bogus PCI bus numbering
Date: Sat, 2 Mar 2002 12:38:17 +0000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16h8lH-000PtZ-0W@anchor-post-32.mail.demon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.4 PCI subsystem seems not to handle bogus BIOS-assigned PCI bus numbers 
well. (OK, it shouldn't be necessary for the OS to have to tweak the 
numbering, but alas, it is.)

I've got an IBM Thinkpad 240 and the BIOS incorrectly assigns bus number 0 to 
the CardBus (obviously, bus 0 is the primary internal PCI bus). Because of 
this, it's impossible to use CardBus devices - when one is inserted, its 
device number (00:00.0) collides with the 82443BX Northbridge and Card 
Services understandably gets rather confused, thinking I've just plugged in a 
440BX chip... ahem.

I've emailed Martin Mares (listed as the PCI maintainer in the PCI-driver 
source) a while back but I think he must be busy at the moment. I had a look 
at the source myself with a view to trying to write a patch but had to get 
myself a stiff drink after about 5 minutes to help me recover from the 
shell-shock :o)

(I'm using stock 2.4.17 on the machine at the moment.)

Here's /proc/pci without any CardBus devices inserted:

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (AGP disabled) 
(rev 3).
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
  Bus  0, device   7, function  0:
    Bridge: Intel Corp. 82371AB PIIX4 ISA (rev 2).
  Bus  0, device   7, function  1:
    IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 1).
      Master Capable.  Latency=64.  
      I/O at 0x1040 [0x104f].
  Bus  0, device   7, function  2:
    USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 1).
      IRQ 10.
      Master Capable.  Latency=64.  
      I/O at 0x1060 [0x107f].
  Bus  0, device   7, function  3:
    Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 2).
      IRQ 9.
  Bus  0, device   9, function  0:
    VGA compatible controller: Neomagic Corporation NM2160 [MagicGraph 128XD] 
(rev 1).
      Master Capable.  Latency=128.  Min Gnt=16.Max Lat=255.
      Prefetchable 32 bit memory at 0xf5000000 [0xf5ffffff].
      Non-prefetchable 32 bit memory at 0xf4000000 [0xf41fffff].
      Non-prefetchable 32 bit memory at 0xf4200000 [0xf42fffff].
  Bus  0, device  10, function  0:
    CardBus bridge: Texas Instruments PCI1211 (rev 0).
      IRQ 11.
      Master Capable.  Latency=168.  Min Gnt=192.Max Lat=7.
      Non-prefetchable 32 bit memory at 0x10000000 [0x10000fff].
  Bus  0, device  11, function  0:
    Multimedia audio controller: ESS Technology ES1969 Solo-1 Audiodrive (rev 
2).
      IRQ 3.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=24.
      I/O at 0x1000 [0x103f].
      I/O at 0x1090 [0x109f].
      I/O at 0x1080 [0x108f].
      I/O at 0x10a4 [0x10a7].
      I/O at 0x10a0 [0x10a3].
  Bus  0, device  12, function  0:
    Communication controller: Lucent Microelectronics WinModem 56k (rev 1).
      IRQ 10.
      Master Capable.  No bursts.  Min Gnt=252.Max Lat=14.
      Non-prefetchable 32 bit memory at 0xf4300000 [0xf43000ff].
      I/O at 0x10a8 [0x10af].
      I/O at 0x1400 [0x14ff].

With a 3Com 3CCFE575CT CardBus 100Mbit NIC inserted, /proc/pci is identical 
except for one extra device at the end of the listing:

  Bus  0, device   0, function  0:
    Host bridge:  (rev 3).
      Master Capable.  Latency=64.  

and the entry for the CardBus bridge, which shows Min Gnt=128 instead of 192.

Card Services (version 3.1.31, from pcmcia-cs.sf.net) reports:

Mar  2 12:10:08 rodin cardmgr[47]: unsupported card in socket 0
Mar  2 12:10:08 rodin kernel: cs: cb_alloc(bus 0): vendor 0x8086, device 
0x7192
Mar  2 12:10:08 rodin cardmgr[47]:   no product info available
Mar  2 12:10:08 rodin cardmgr[47]:   PCI id: 0x8086, 0x7192

when I insert the NIC.

Please cc any responses to me - I can't take the lkml traffic!

Thanks
Stephen
