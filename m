Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S159776AbRA2HMD>; Mon, 29 Jan 2001 02:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145183AbRA2HMA>; Mon, 29 Jan 2001 02:12:00 -0500
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:17926 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S159776AbRA2HLm>; Mon, 29 Jan 2001 02:11:42 -0500
To: torvalds@transmeta.com
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: PCI IRQ routing problem in 2.4.0
From: Robert Siemer <Robert.Siemer@gmx.de>
In-Reply-To: <Pine.LNX.4.10.10101282220460.5605-100000@penguin.transmeta.com>
In-Reply-To: <20010129070810S.siemer@panorama.hadiko.de>
	<Pine.LNX.4.10.10101282220460.5605-100000@penguin.transmeta.com>
X-Mailer: Mew version 1.94b25 on Emacs 20.5 / Mule 4.0 (HANANOEN)
Reply-To: Robert Siemer <siemer@panorama.hadiko.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010129081132I.siemer@panorama.hadiko.de>
Date: Mon, 29 Jan 2001 08:11:32 +0100
X-Dispatcher: imput version 990425(IM115)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@transmeta.com>
> On Mon, 29 Jan 2001, Robert Siemer wrote:
> > > 
> > > and see if that changes the behaviour. 
> > 
> > It doesn't.   A diff from the kernel output is following. Maybe it
> > helps...
> 
> Actually, this looks like it _did_ fix something - now the kernel no
> longer thinks there is a IRQ routing conflict, so it does seem to be
> happier.
> 
> Also, while you're unhappy that it assigns irq 12 instead of 9, the pirq
> table actually says that it's ok, and again the code seems to say that
> this was actually what the system was set up for.

I'm not just unhappy to be unable to control the IRQs with the bios
anymore, sym53c8xx doesn't want to share IRQs with the usb
subsystem in this case... (kernel panic (killing interrupt handler(?))
and reboot (rebooting in 60 seconds))

2.4.0-test9 behaviour was different. It really used what the 'bios
box' stated during bootup. - A way to set the IRQ distribution via
kernel-params is okay for me, too.

> Can you re-iterate what the failure mode is, again? Preferable with
> this kernel that definitely looks like it at least agrees with what
> the BIOS tells it.

I'm native German - what is 'failure mode'?

2.4.0-test9 agrees with the bios. [Currently I gave my VGA card (the
S3) an IRQ - without one in the bios 2.4.0-test9 was happy, but 2.4.0
gave it IRQ 8 on its own.]

> Oh, and please do a "lspci -vvvxxx" as root and send me that as
> well.

Okay. For 2.4.0-test9 it's following immediately. After that a
diff of "lspci -vvx" from 2.4.0-test9 to 2.4.0 is included.

Full "lspci -vvx" are in my original post:
http://boudicca.tux.org/hypermail/linux-kernel/latest/0130.html

To mention it: I have also an ASUS SP97 like Aaron Tiensivu. But the
XV version with (unused) onboard VGA.

Further I always see '09' in the Configuration Space at Interrupt_Line
(0x3c) for the 00:01.2 USB Controller. But 2.4.0 says:
  Interrupt: pin A routed to IRQ 12
while 2.4.0-test9 states:
  Interrupt: pin A routed to IRQ 9

Please tell me if it helps te see a "lspci -vvvxxx" from 2.4.0 and
whether I should give some 2.4.0-test?? a try...
I must go to bed now - otherwise my mother kills me when she reads
linux-kernel tomorrow... (-:


00:00.0 Host bridge: Silicon Integrated Systems [SiS] 5597 [SiS5582] (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32 set
00: 39 10 97 55 07 00 00 22 02 00 00 06 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: c0 ea c0 1e fc 04 43 01 60 00 00 00 00 00 00 00
60: e6 00 00 f9 00 ff 00 ff 00 ff 00 ff 80 02 00 00
70: cc 88 00 00 88 88 88 00 00 00 00 00 00 00 00 00
80: 7c c8 ce f7 40 00 10 40 00 00 00 00 00 00 00 00
90: 02 00 03 44 00 00 00 00 00 00 00 07 00 00 ff ff
a0: ff ff 00 80 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set
00: 39 10 08 00 07 00 00 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: fa 0c 0e 0a 0b 64 00 00 ff ff 10 0f 11 20 04 01
50: 11 28 02 01 60 0b 64 0b 9c 2e 12 00 a6 0b 00 00
60: ff 80 49 00 88 00 00 02 00 80 80 00 20 19 00 00
70: 1a 00 00 c1 00 c1 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 ec 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 8f [Master SecP SecO PriP PriO])
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at d000 [size=16]
00: 39 10 13 55 01 00 00 00 d0 8f 01 01 00 20 80 00
10: 01 e4 00 00 01 e0 00 00 01 d8 00 00 01 d4 00 00
20: 01 d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0c 01 00 00
40: 00 00 00 00 00 00 00 00 00 07 e0 00 00 02 00 02
50: 00 01 07 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 10) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e5000000 (32-bit, non-prefetchable) [size=4K]
00: 39 10 01 70 17 00 80 02 10 10 03 0c 08 20 80 00
10: 00 00 00 e5 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00
40: 00 00 0f 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:09.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppage computer works Inc.: Unknown device 13eb
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 min, 40 max, 32 set
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e7800000 (32-bit, prefetchable) [size=4K]
00: 9e 10 6e 03 06 00 80 02 02 00 00 04 00 20 80 00
10: 08 00 80 e7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 70 00 eb 13
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 10 28
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:09.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppage computer works Inc.: Unknown device 13eb
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 4 min, 255 max, 32 set
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e7000000 (32-bit, prefetchable) [size=4K]
00: 9e 10 78 08 06 00 80 02 02 00 80 04 00 20 80 00
10: 08 00 00 e7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 70 00 eb 13
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 04 ff
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0a.0 Ethernet controller: Winbond Electronics Corp W89C940 (rev 0b)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at b800 [size=32]
00: 50 10 40 09 03 00 80 02 0b 00 00 02 00 00 00 00
10: 01 b8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.0 VGA compatible controller: S3 Inc. 86c968 [Vision 968 VRAM] rev 0 (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 14
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
00: 33 53 f0 88 83 00 00 02 00 00 00 03 00 00 00 00
10: 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0e 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0c.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 03)
	Subsystem: Tekram Technology Co.,Ltd. DC390F Ultra Wide SCSI Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 17 min, 64 max, 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at b400 [size=256]
	Region 1: Memory at e1800000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at e1000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
00: 00 10 0f 00 57 00 00 02 03 00 00 01 08 20 00 00
10: 01 b4 00 00 00 00 80 e1 00 00 00 e1 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 e1 1d 04 39
30: 00 00 00 00 00 00 00 00 00 00 00 00 0c 01 11 40
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: da 00 00 9d 47 0f 09 07 04 00 89 00 80 00 0f 0a
90: ff 60 2a 01 00 ff ff ff 20 f0 35 30 98 03 00 e1
a0: 00 08 24 00 00 00 00 50 b8 03 00 e1 c0 03 00 e1
b0: 00 00 00 e1 b0 76 2a 01 46 6d 00 81 c0 03 00 e1
c0: 8f 05 00 00 75 00 70 0f 0c 00 80 00 76 0c 00 80
d0: 00 00 00 80 00 00 00 80 00 00 00 80 00 84 00 20
e0: 43 d1 e6 21 d0 18 28 00 f8 41 22 81 aa ff cf 53
f0: 12 0f 80 20 6f bf 02 81 8e 84 22 a8 d5 f3 45 73

00:13.0 VGA compatible controller: Silicon Integrated Systems [SiS] 5597/5598 VGA (rev 65) (prog-if 00 [VGA])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at e6000000 (32-bit, prefetchable) [disabled] [size=4M]
	Region 1: Memory at e0800000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Region 2: I/O ports at b000 [disabled] [size=128]
	Expansion ROM at e5ff0000 [disabled] [size=32K]
00: 39 10 00 02 00 00 00 02 65 00 00 03 00 00 00 00
10: 08 00 00 e6 00 00 80 e0 01 b0 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 ff e5 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 80 e0 01 b0 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 80 e0 01 b0 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 80 e0 01 b0 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00




--- lspci-vvx.2.4.0-test9	Sun Jan 28 16:47:43 2001
+++ lspci-vvx.2.4.0	Mon Jan 29 06:25:53 2001
@@ -16,7 +16,7 @@
 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 
-00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 8f [Master SecP SecO PriP PriO])
+00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 8a [Master SecP PriP])
 	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Interrupt: pin A routed to IRQ 12
@@ -25,7 +25,7 @@
 	Region 2: I/O ports at <ignored>
 	Region 3: I/O ports at <ignored>
 	Region 4: I/O ports at d000 [size=16]
-00: 39 10 13 55 01 00 00 00 d0 8f 01 01 00 20 80 00
+00: 39 10 13 55 01 00 00 00 d0 8a 01 01 00 20 80 00
 10: 01 e4 00 00 01 e0 00 00 01 d8 00 00 01 d4 00 00
 20: 01 d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 30: 00 00 00 00 00 00 00 00 00 00 00 00 0c 01 00 00
@@ -34,7 +34,7 @@
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 32 set, cache line size 08
-	Interrupt: pin A routed to IRQ 9
+	Interrupt: pin A routed to IRQ 12
 	Region 0: Memory at e5000000 (32-bit, non-prefetchable) [size=4K]
 00: 39 10 01 70 17 00 80 02 10 10 03 0c 08 20 80 00
 10: 00 00 00 e5 00 00 00 00 00 00 00 00 00 00 00 00
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
