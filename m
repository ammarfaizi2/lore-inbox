Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271976AbRHVJsI>; Wed, 22 Aug 2001 05:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271977AbRHVJsA>; Wed, 22 Aug 2001 05:48:00 -0400
Received: from wildsau.idv-edu.uni-linz.ac.at ([140.78.40.25]:58637 "EHLO
	wildsau.idv-edu.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S271976AbRHVJrs>; Wed, 22 Aug 2001 05:47:48 -0400
From: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Message-Id: <200108220947.f7M9luF00966@wildsau.idv-edu.uni-linz.ac.at>
Subject: pcmcia will freeze system with certain hardware
To: linux-kernel@vger.kernel.org
Date: Wed, 22 Aug 2001 11:47:56 +0200 (MET DST)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

I just tried to attach one of these IBM-microdrives to a system, but this
froze the system completely. This microdrive will be seen  by the system
as a IDE disk. I know that this works under linux, since I've tried (and
succeeded) on different system, it's the particular hardware combination
that fails.

Hardware:

on "normal" systems, such as PCs, you cannot directly use the microdrive,
instead, you need a PC-Card adapter (available from IBM too) which you
plug into an PCMCIA slot. Then, plug the microdrive into the PC-Card
adapter.

on system which do not have a PCMCIA-slot, you would additionally need
a PCI to PCMCIA interface, like the one I am using.

there are other system too, which do not need a PC-Card adapter, since
there are connectors for the microdrive on board, you would just plug
the microdrive on the board.

so, on a PC with no PCMCIA-slot, the stackings looks like this:

  || Motherboard  -- PCMCIA/PCI bridge -- PC-Card Adapter -- Microdrive ||

Systems where the microdrive will work as expected:

(o) boards which have microdrive connectors.

(o) noteboos with PCMCIA-slots, which require the PC-Card adatper.

Systems where the microdrive (or another component) will freeze linux:

(o) PCs which no PCMCIA-slot, but a PCMCIA/PCI bridge.


software-versions I am using:
   (o) linux-kernel is 2.4.9
   (o) pcmcia is 3.1.28 (not the kernel version, but from sourceforge.org)

the system will not oops or panic, it will simply hang. Here's what I get
on a serial console (only relevant lines are shown):

-- snip --
Linux version 2.4.9 (root@blau) (gcc version 2.95.3 20010315 (release)) #2 Wed Aug 22 11:13:12 MEST 2001
[...]
/sbin/init.d/rc2.d/S03pcmcia start
Starting PCMCIA services: modulesLinux PCMCIA Card Services 3.1.28
  kernel build: 2.4.9 #2 Wed Aug 22 11:13:12 MEST 2001
  options:  [pci] [cardbus] [apm]
Intel PCIC probe: <6>PCI: Found IRQ 9 for device 00:0c.0
PCI: Sharing IRQ 9 with 00:07.5
PCI: Sharing IRQ 9 with 00:0a.0
PCI: Sharing IRQ 9 with 00:0c.1
PCI: Found IRQ 9 for device 00:0c.1
PCI: Sharing IRQ 9 with 00:07.5
PCI: Sharing IRQ 9 with 00:0a.0
PCI: Sharing IRQ 9 with 00:0c.0

  TI 1225 rev 01 PCI-to-CardBus at slot 00:0c, mem 0xdf003000
    host opts [0]: [pci only] [pci irq 9] [lat 32/176] [bus 2/5]
    host opts [1]: [pci only] [pci irq 9] [lat 32/176] [bus 6/9]
    PCI card interrupts, PCI status changes
 cardmgr.
cardmgr[83]: starting, version is 3.1.28
[...]
cardmgr[83]: inics: memory probe 0xa0000000-0xa0ffffff:tializing socket 0
 clean.
cardmgr[83]: socket 0: ATA/IDE Fixed Disk
cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x207 0x220-0x22f 0x330-0x337 0x378-0x37f 0x388-0x38f 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0208-0x021f: clean.
cs: IO port probe 0x0230-0x032f: clean.
cs: IO port probe 0x0338-0x0377: clean.
cs: IO port probe 0x0380-0x0387: clean.
cs: IO port probe 0x0390-0x03bf: clean.
cs: IO port probe 0x03e0-0x04cf: clean.
cs: IO port probe 0x04d8-0x04ff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
cs: IO port probe 0x0c00-0x0cff: clean.
-- snip --

famous last words. after that, the system is frozen.

/proc/pci looks like this (only PCMCIA bridge is shown):

-- snip --
  Bus  0, device  12, function  0:
    CardBus bridge: Texas Instruments PCI1225 (rev 1).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=192.Max Lat=7.
      Non-prefetchable 32 bit memory at 0xdf003000 [0xdf003fff].
  Bus  0, device  12, function  1:
    CardBus bridge: Texas Instruments PCI1225 (#2) (rev 1).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=192.Max Lat=7.
      Non-prefetchable 32 bit memory at 0xdf007000 [0xdf007fff].
-- snip --

unfortunately, I dont have a different PCMCIA/PCI bridge here.
I'll check out if my homesystem will crash too, that is, if the
freeze is related to the PCI1225 from TI (maybe the hardware is damaged?).

/proc/pci at my homemachine will show a PCI1221:
PCI devices found:
[...]
  Bus  0, device  12, function  0:
    CardBus bridge: Texas Instruments PCI1221 (rev 0).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=64.Max Lat=3.
      Non-prefetchable 32 bit memory at 0xdb002000 [0xdb002fff].
  Bus  0, device  12, function  1:
    CardBus bridge: Texas Instruments PCI1221 (#2) (rev 0).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=64.Max Lat=3.
      Non-prefetchable 32 bit memory at 0xdb006000 [0xdb006fff].
[...]

is it worth digging into that problem is this rather like being
a dead-end?

/herp


----- End of forwarded message from Herbert Rosmanith -----
