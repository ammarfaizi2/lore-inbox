Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279242AbRJWFGP>; Tue, 23 Oct 2001 01:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279243AbRJWFGF>; Tue, 23 Oct 2001 01:06:05 -0400
Received: from donna.siteprotect.com ([64.41.120.44]:24589 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S279242AbRJWFFw>; Tue, 23 Oct 2001 01:05:52 -0400
Date: Tue, 23 Oct 2001 01:06:11 -0400 (EDT)
From: John Clemens <john@deater.net>
X-X-Sender: <john@pianoman.cluster.toy>
To: <linux-kernel@vger.kernel.org>
cc: <linux-usb-devel@sourceforge.net>
Subject: PCI PIRQ routing questions..
Message-ID: <Pine.LNX.4.33.0110230052560.3178-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to get USB to work on my laptop (Ali Magik1 chipset, OHCI
controller).. it appears that no matter what i do, no IRQ's are getting
through... the OHCI controller shows up on IRQ9 and is shared by ACPI.
This is the same as it is in windows.. Under windows USB works (but
'pauses' for a few seconds every couple of minutes, bus reset?).

everything else on the laptop is set to IRQ11. (well, enet, cardbus,
video).  I tried using setpci to change the USB irq to something unused
(IRQ3).. but that didn't work (unless you use 'lspci -b' to show bus
view).. either way it didn't work in practice.

Using the dump_pirq program from pcmcia-cs, i get the following output:

Interrupt routing table found at address 0xfdf40:
  Version 1.0, size 0x00a0
  Interrupt router is device 00:07.0
  PCI exclusive interrupt mask: 0x0000 []
  Compatible router: vendor 0x10b9 device 0x1533

Device 00:0f.0 (slot 0): IDE interface

Device 00:02.0 (slot 0): USB Controller
  INTA: link 0x59, irq mask 0x0800 [11]

Device 00:08.0 (slot 1): Multimedia audio controller
  INTA: link 0x49, irq mask 0x0020 [5]

Device 00:04.0 (slot 0): CardBus bridge
  INTA: link 0x48, irq mask 0x0800 [11]
  INTB: link 0x48, irq mask 0x0800 [11]

Device 00:10.0 (slot 0): Ethernet controller
  INTA: link 0x48, irq mask 0x0800 [11]

Device 00:07.0 (slot 0): ISA bridge
  INTA: link 0x48, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]
  INTB: link 0x48, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]
  INTC: link 0x49, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]
  INTD: link 0x49, irq mask 0xdef8 [3,4,5,6,7,9,10,11,12,14,15]

Device 00:01.0 (slot 0): PCI bridge
  INTA: link 0x48, irq mask 0x0800 [11]

Device 01:00.0 (slot 0): VGA compatible controller
  INTA: link 0x48, irq mask 0x0800 [11]

Interrupt router at 00:07.0: AcerLabs Aladdin M1533 PCI-to-ISA bridge
  INT1 (link 1): irq 11
  INT2 (link 2): irq 11
  INT3 (link 3): unrouted
  INT4 (link 4): unrouted
  INT5 (link 5): unrouted
  INT6 (link 6): unrouted
  INT7 (link 7): unrouted
  INT8 (link 8): unrouted
  Serial IRQ: [enabled] [continuous] [frame=21] [pulse=12]

If i'm reading this correctly, the board is wired up for USB to use irq
11, not irq 9...but everything wants it to use irq9.  Without bios
support, what can I do?  Is linux's interpretation of the ALi PIRQ tables
incorrect?

Other files of interest follow.. any feedback would be appreciated.
john.c

-- 
John Clemens          http://www.deater.net/john
john@deater.net     ICQ: 7175925, IM: PianoManO8
      "I Hate Quotes" -- Samuel L. Clemens

00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
(prog-if 10 [OHCI])
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at fff70000 (32-bit, non-prefetchable)
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 37 52 13 00 90 02 03 10 03 0c 08 10 00 00
10: 00 00 f7 ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 09 01 00 50
40: 00 00 1f 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 02 06 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

           CPU0
  0:     100735          XT-PIC  timer
  1:       5433          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi, usb-ohci
 11:       6369          XT-PIC  Texas Instruments PCI1420, Texas
Instruments PCI1420 (#2), eth0
 12:       4854          XT-PIC  PS/2 Mouse
 14:       4825          XT-PIC  ide0
 15:          2          XT-PIC  ide1
NMI:         52
LOC:     100665
ERR:        137

usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 9 for device 00:02.0
usb-ohci.c: USB OHCI at membase 0xd08bd000, IRQ 9
usb-ohci.c: usb-00:02.0, Acer Laboratories Inc. [ALi] M5237 USB
usb.c: new USB bus registered, assigned bus number 1
.
.
.
hub.c: port 2 connection change
hub.c: port 2, portstatus 301, change 1, 1.5 Mb/s
hub.c: port 2, portstatus 303, change 10, 1.5 Mb/s
hub.c: USB new device connect on bus1/2, assigned device number 2
usb_control/bulk_msg: timeout
usb-ohci.c: unlink URB timeout
usb.c: USB device not accepting new address=2 (error=-110)
hub.c: port 2, portstatus 303, change 10, 1.5 Mb/s
hub.c: USB new device connect on bus1/2, assigned device number 3
usb_control/bulk_msg: timeout
usb-ohci.c: unlink URB timeout
usb.c: USB device not accepting new address=3 (error=-110)


