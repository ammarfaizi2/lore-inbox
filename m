Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263072AbRE1PF2>; Mon, 28 May 2001 11:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263067AbRE1PFS>; Mon, 28 May 2001 11:05:18 -0400
Received: from adsl-81-162-123.asm.bellsouth.net ([65.81.162.123]:39050 "EHLO
	tweetie.comstar.net") by vger.kernel.org with ESMTP
	id <S261741AbRE1PFP>; Mon, 28 May 2001 11:05:15 -0400
Date: Mon, 28 May 2001 11:05:14 -0400 (EDT)
From: Gregory McLean <gregm@comstar.net>
To: <linux-kernel@vger.kernel.org>
Subject: USB and Tyan Tsunami MB
Message-ID: <Pine.LNX.4.33.0105281040410.19576-100000@tweetie.comstar.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Has anyone managed to get this motherboard's (tyan tsunami AT) on board
usb to work? I'm currently using an add on pci card to use the usb devices
I have but would _love_ to free that PCI slot up.

Specifics:
Tsunami MB (AT Form factor)
Single processor:
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 334.095
cache size      : 512 KB
Bios Version 1.16
USB Controller:
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at ef80 [size=32]
00: 86 80 12 71 05 00 80 02 01 00 03 0c 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 ef 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 04 00 00

Symptoms:
The kernel detects the hub just fine:
usb-uhci.c: $Revision: 1.259 $ time 11:21:32 May 26 2001
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xef80, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected

However pluging _anything_ into that hub just don't work, Lots of error
messages about EMI, usb-uhci.c: interrupt, status 3 frame# <blah> Device
disconnects etc etc.

Needless to say said device never gets initalized, though it is detected
as being inserted. So just to be sure I went and got another pair of usb
ports to connect to the header. No joy.

I tried with an external (powered) hub and things atleast got initialized
but was still unable to use the devices (went into that spew about
usb-uhci: interrup, status 3, frame# <blah> over and over again)

Pokeing around I see that the mother board's bios will _always_ assign the
usb controller to IRQ 9, what makes me wonder a bit is this next bit from
lspci:

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
00: 86 80 13 71 01 00 80 02 02 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Thats also routed to IRQ 9 (could this be the problem?)

However _this_ USB controller works just fine:

00:13.0 USB Controller: VIA Technologies, Inc. UHCI USB (rev 04) (prog-if
00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR+ <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 4: I/O ports at ef40 [size=32]
00: 06 11 38 30 17 01 00 42 04 00 03 0c 08 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 ef 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00

So its also routed to IRQ 9.

I've tried kernels 2.4.0 -> 2.4.5 all with pretty much the same result
(except 2.4.4 which oops on boot in the usb controller ;) )

I've rummaged around on the linux-usb lists and didn't see anything there.
So is this a known problem with this motherboard/bios version?

Thanks for any tips,

  Greg





