Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317971AbSHVHja>; Thu, 22 Aug 2002 03:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317986AbSHVHja>; Thu, 22 Aug 2002 03:39:30 -0400
Received: from m206-234.dsl.tsoft.com ([198.144.206.234]:55680 "EHLO
	jojda.2y.net") by vger.kernel.org with ESMTP id <S317971AbSHVHj2>;
	Thu, 22 Aug 2002 03:39:28 -0400
Message-ID: <3D649628.904477EB@bigfoot.com>
Date: Thu, 22 Aug 2002 00:43:36 -0700
From: Erik Steffl <steffl@bigfoot.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en, sk, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VT82C693A/694x and ripping audio CDs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  my system:

  debian unstable
  kernel 2.4.18
  ABIT VH6 II motherboard with VT82C693A/694x [Apollo PRO133x]
  hdc: FX810T4, ATAPI CD/DVD-ROM drive
  hde: TDK CDRW321040B, ATAPI CD/DVD-ROM drive
  card 00:09.0 SCSI storage controller: Artop Electronic Corp ATP865
(rev 02)

  (the SCSI storage is really PCI IDE card)

  many of you are probably aware that it is a common problem for
VT82C693A/694x based MBs not to be able to rip audio CDs under linux
(usual message is 'lost interrupt').

  I have heard that updating the BIOS might help in some cases so I
tried that and here's what happened (_few_ related problems listed
below).

-----------------------------------------------------------
  fun with PCI DIE card
-----------------------------------------------------------

  during boot there is strange message when probing PCI IDE card (STSTUS
instead of ALTSTATUS error message):

Aug 21 23:47:29 localhost kernel: Uniform Multi-Platform E-IDE driver
Revision: 6.31
Aug 21 23:47:29 localhost kernel: ide: Assuming 33MHz system bus speed
for PIO modes; override with idebus=xx
Aug 21 23:47:29 localhost kernel: VP_IDE: IDE controller on PCI bus 00
dev 39
Aug 21 23:47:29 localhost kernel: VP_IDE: chipset revision 6
Aug 21 23:47:29 localhost kernel: VP_IDE: not 100%% native mode: will
probe irqs later
Aug 21 23:47:29 localhost kernel: VP_IDE: VIA vt82c686b (rev 40) IDE
UDMA100 controller on pci00:07.1
Aug 21 23:47:29 localhost kernel:     ide0: BM-DMA at 0xc000-0xc007,
BIOS settings: hda:DMA, hdb:DMA
Aug 21 23:47:29 localhost kernel:     ide1: BM-DMA at 0xc008-0xc00f,
BIOS settings: hdc:DMA, hdd:pio
Aug 21 23:47:29 localhost kernel: hda: WDC AC22000L, ATA DISK drive
Aug 21 23:47:29 localhost kernel: hdb: Maxtor 94098U8, ATA DISK drive
Aug 21 23:47:29 localhost kernel: hdc: FX810T4, ATAPI CD/DVD-ROM drive
Aug 21 23:47:29 localhost kernel: hde: probing with STATUS(0x51) instead
of ALTSTATUS(0xff)
Aug 21 23:47:29 localhost last message repeated 2 times
Aug 21 23:47:29 localhost kernel: hde: TDK CDRW321040B, ATAPI CD/DVD-ROM
drive
Aug 21 23:47:29 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 21 23:47:29 localhost kernel: ide1 at 0x170-0x177,0x376 on irq 15
Aug 21 23:47:29 localhost kernel: ide2 at 0xcc00-0xcc07,0xd000 on irq 11
Aug 21 23:47:29 localhost kernel: hda: 3907008 sectors (2000 MB)
w/256KiB Cache, CHS=969/64/63, UDMA(33)
Aug 21 23:47:29 localhost kernel: hdb: 80041248 sectors (40981 MB)
w/2048KiB Cache, CHS=4982/255/63, UDMA(66)
Aug 21 23:47:29 localhost kernel: Partition check:
Aug 21 23:47:29 localhost kernel:  hda: hda1 hda2 hda3 hda4
Aug 21 23:47:29 localhost kernel:  hdb: hdb1 < hdb5 hdb6 hdb7 > hdb2


-----------------------------------------------------------
  even more fun with usb
-----------------------------------------------------------

  USB didn't work before because it is on the same interrupt as PCI IDE
card but this time I get:

...
Aug 21 23:44:11 localhost kernel: lp0: using parport0 (polling).
Aug 21 23:44:11 localhost kernel: lp0: console ready
Aug 21 23:44:11 localhost kernel: Unable to handle kernel NULL pointer
dereference at virtual address 000000b8
Aug 21 23:44:11 localhost kernel:  printing eip:
Aug 21 23:44:11 localhost kernel: d8856644
Aug 21 23:44:11 localhost kernel: *pde = 00000000
Aug 21 23:44:11 localhost kernel: Oops: 0000
Aug 21 23:44:11 localhost kernel: CPU:    0
Aug 21 23:44:11 localhost kernel: EIP:   
0010:[8139too:__insmod_8139too_O/lib/modules/2.4.18/kernel/drivers/net/81+-31164/96]   
Not tainted
Aug 21 23:44:11 localhost kernel: EFLAGS: 00010286
Aug 21 23:44:11 localhost kernel: eax: d6d1a000   ebx: 00000000   ecx:
c01daae8   edx: 00000000
Aug 21 23:44:11 localhost kernel: esi: 00000000   edi: d6d1a000   ebp:
00000000   esp: d6d65f48
Aug 21 23:44:11 localhost kernel: ds: 0018   es: 0018   ss: 0018
Aug 21 23:44:11 localhost kernel: Process usb (pid: 314,
stackpage=d6d65000)
Aug 21 23:44:11 localhost kernel: Stack: d75df2e0 00000000 d7321680
d885a740 00000000 d88568f6 d6d65fa4 d6d65fa8 
Aug 21 23:44:11 localhost kernel:        d6d65f94 d7321680 00000000
d75df2c0 00000000 00000000 00000000 00000000 
Aug 21 23:44:11 localhost kernel:        d7321660 ffffffea 00000400
00000000 00000000 c012d7d6 d7321660 40015000 
Aug 21 23:44:11 localhost kernel: Call Trace:
[8139too:__insmod_8139too_O/lib/modules/2.4.18/kernel/drivers/net/81+-14528/96]
[8139too:__insmod_8139too_O/lib/modules/2.4.18/kernel/drivers/net/81+-30474/96]
[sys
_read+150/228] [system_call+51/56] 
Aug 21 23:44:11 localhost kernel: 
Aug 21 23:44:11 localhost kernel: Code: 8b 82 b8 00 00 00 85 c0 74 08 89
eb 83 38 ff 0f 45 18 8b 4c 

  at least I assume it's usb, when I disable usb in BIOS setup it works
(that why I am able to write this email:-)

-----------------------------------------------------------
  on board ide and cdrom ripping
-----------------------------------------------------------

  cd ripping still does not work but I get quite different messages, no
'lost interrupt' but:

Aug 21 23:52:38 localhost kernel: hdc: packet command error: status=0x51
{ DriveReady SeekComplete Error }
Aug 21 23:52:38 localhost kernel: hdc: packet command error: error=0xb0
Aug 21 23:52:38 localhost kernel: ATAPI device hdc:
Aug 21 23:52:38 localhost kernel:   Error: Aborted command -- (Sense
key=0x0b)
Aug 21 23:52:38 localhost kernel:   (vendor-specific error) --
(asc=0xbf, ascq=0x00)
Aug 21 23:52:38 localhost kernel:   The failed "Read CD" packet command
was: 
Aug 21 23:52:38 localhost kernel:   "be 04 00 00 09 01 00 00 08 f8 00 00
"

  this set of messages is repeated as long as I try to rip CD.

  BTW ripping on the other CDROM (/dev/hde, on PCI IDE card) still works
OK.

  any advices on any of above:

  - is it possible to make cd ripping work?
  - is it possible to make USB work even if it shares interrupt with PCI
IDE card?
  - any ideas why I'm getting ALTSTATUS message now (it wasn't there
before)

  TIA

	erik
