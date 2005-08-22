Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbVHVVhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVHVVhD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbVHVVhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:37:03 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:26073 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751238AbVHVVg6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:36:58 -0400
Date: Mon, 22 Aug 2005 23:44:53 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Airlie <airlied@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: rc6 keeps hanging and blanking displays
Message-ID: <20050822214453.GA31266@aitel.hist.no>
References: <20050815221109.GA21279@aitel.hist.no> <21d7e99705081516182e97b8a1@mail.gmail.com> <21d7e99705081516241197164a@mail.gmail.com> <20050816165242.GA10024@aitel.hist.no> <Pine.LNX.4.58.0508160955270.3553@g5.osdl.org> <20050816211424.GA14367@aitel.hist.no> <21d7e99705081616504d28cca5@mail.gmail.com> <43031A12.8020301@aitel.hist.no> <21d7e997050817040523a1bf46@mail.gmail.com> <Pine.LNX.4.58.0508170815370.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508170815370.3553@g5.osdl.org>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 17, 2005 at 08:19:36AM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 17 Aug 2005, Dave Airlie wrote:
> > Just grab it from the link to comment #16 on 
> > http://bugzilla.kernel.org/show_bug.cgi?id=4965
> 
> That's a good one to try (and if it matters, can you please do a full 
> "lspci -vvx" for before-and-after? In fact, it would probably be good to 
> do that _regardless_ - do it with an old known-good kernel, and with one 
> recent kernel).
> 
> At the same time, something struck me. Does it happen to be much warmer in 
> your room lately? As in due to a heatwave? I'm just wondering if it might 
> be something as silly as a thermal shutdown.


Not warmer than usual, but the machine is always hot to the touch, 
it is sitting in a small closet where I have taken the door off. Air
circulation still isn't perfect, but there is a strong fan on the cpu,
almost as noisy as a vacuum cleaner. :-(

Cpu loads never killed it before, so I don't suspect that unless the 
radeon 9200SE has a thermal shutdown of its own.



I have found that the crash and the balnking may be different problems.
It seems that any kernel with a _working_ drm sooner or later will cause
a hang on the radeon display, possibly but not necessarily freezing the
machine for a while or forever.  This happens more often if I actually
stress drm, such as playing tuxracer. But it can happen with
plain firefox/xterm/thunderbird work too.  (no opengl screensavers
or animated window managers here.)

My rock solid 2.6.13-rc4-mm1 has drm compiled in, but drm fails when X
starts, and therefore drm isn't used.  And therefore, a stable kernel.
>From Xorg.2.log:
drmOpenDevice: open result is 6, (OK)
drmOpenByBusid: drmOpenMinor returns 6
drmOpenByBusid: drmGetBusid reports pci:0000:00:08.0
(II) RADEON(0): [drm] DRM interface version 1.2
(II) RADEON(0): [drm] created "radeon" driver at busid "pci:0000:00:08.0"
(II) RADEON(0): [drm] added 8192 byte SAREA at 0xffffc20000147000
(II) RADEON(0): [drm] drmMap failed
(EE) RADEON(0): [dri] DRIScreenInit failed.  Disabling DRI.
(II) RADEON(0): Memory manager initialized to (0,0) (1280,8191)
(II) RADEON(0): Reserved area from (0,1024) to (1280,1026)
(II) RADEON(0): Largest offscreen area available: 1280 x 7165
(II) RADEON(0): Render acceleration enabled
(II) RADEON(0): Using XFree86 Acceleration Architecture (XAA)
drmMap failed for this kernel.


Seems like replacing the radeon is a good idea, it will probably never
do stable 3D as even old kernels have this particular problem.  The
performance is apalling too, the old g550 gets a 3x-5x better framerate...

The blank display problem is different.  That problem follows the
bisect search, i.e. the "good" kernels never ever blanks the 
display for me, and the "bad" kernels always do so after a little while.
Even if all I use is 2D stuff. (All with drm configured)

As for the patch to revert - it did fix things so an rc6 without drm 
came up.  I'm using that kernel now. I guess it'll be fine,
with no drm. I'll keep it running tomorrow, for stability testing.

What is the next logical step?  rc6 with both drm and this patch reverted?
Or is there any new development?


There are three lspci-vvx files attached.
One for plain 2.6.13rc6, which can't run X.
One for 2.6.13rc6 with the patch reverted, and one for
the same kernel after I rebooted the machine and also
started X.  The lspci-vvx was sligthly different then.


Helge Hafting




--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci-vvx-2.6.13rc6"

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host Bridge (rev 01)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [80] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] #08 [0060]
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #08 [8001]
00: 06 11 88 31 06 00 30 22 01 00 00 06 00 08 00 00
10: 08 00 00 d8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800 South] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: f2000000-f4ffffff
	Prefetchable memory behind bridge: f0000000-f1ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 88 b1 07 01 30 02 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 20 22
20: 00 f2 f0 f4 00 f0 f0 f1 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 08 00

0000:00:05.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895 (rev 01)
	Subsystem: Tekram Technology Co.,Ltd. DC-390U2B SCSI adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (7500ns min, 16000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at 9000 [size=256]
	Region 1: Memory at f6032000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at f6031000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 1ff20000 [disabled] [size=64K]
00: 00 10 0c 00 17 00 00 02 01 00 00 01 10 20 00 00
10: 01 90 00 00 00 20 03 f6 00 10 03 f6 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 e1 1d 06 39
30: 00 00 f2 1f 00 00 00 00 00 00 00 00 0b 01 1e 40

0000:00:06.0 Multimedia audio controller: Trident Microsystems 4DWave NX (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 9400 [size=256]
	Region 1: Memory at f6030000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [48] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 23 10 01 20 07 00 10 02 02 00 01 04 00 20 00 00
10: 01 94 00 00 00 00 03 f6 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 48 00 00 00 00 00 00 00 0a 01 02 05

0000:00:08.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01) (prog-if 00 [VGA])
	Subsystem: PC Partner Limited: Unknown device 7c25
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at e0000000 (32-bit, prefetchable) [disabled] [size=128M]
	Region 1: I/O ports at 9800 [disabled] [size=256]
	Region 2: Memory at f6000000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Expansion ROM at 1ff00000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 64 59 00 00 90 02 01 00 00 03 08 20 80 00
10: 08 00 00 e0 01 98 00 00 00 00 00 f6 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 25 7c
30: 00 00 f0 1f 50 00 00 00 00 00 00 00 05 01 08 00

0000:00:08.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (Secondary) (rev 01)
	Subsystem: PC Partner Limited: Unknown device 7c24
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at e8000000 (32-bit, prefetchable) [disabled] [size=128M]
	Region 1: Memory at f6010000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 44 5d 00 00 90 02 01 00 80 03 08 20 00 00
10: 08 00 00 e8 00 00 01 f6 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 24 7c
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 08 00

0000:00:0b.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705 Gigabit Ethernet (rev 03)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (16000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f6020000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: ffbefdffffffef9c  Data: ffde
00: e4 14 53 16 06 00 b0 02 03 00 00 02 08 20 00 00
10: 04 00 02 f6 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 07 00 00 00 62 14 00 13
30: 00 00 00 00 48 00 00 00 00 00 00 00 0b 01 40 00

0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin B routed to IRQ 20
	Region 0: I/O ports at 9c00 [size=8]
	Region 1: I/O ports at a000 [size=4]
	Region 2: I/O ports at a400 [size=8]
	Region 3: I/O ports at a800 [size=4]
	Region 4: I/O ports at ac00 [size=16]
	Region 5: I/O ports at b000 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 49 31 07 00 90 02 80 00 04 01 00 20 80 00
10: 01 9c 00 00 01 a0 00 00 01 a4 00 00 01 a8 00 00
20: 01 ac 00 00 01 b0 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 c0 00 00 00 00 00 00 00 04 02 00 00

0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 20
	Region 4: I/O ports at b400 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b4 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 00 00

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 21
	Region 4: I/O ports at b800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 07 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b8 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 01 00 00

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 21
	Region 4: I/O ports at bc00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 07 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 bc 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 01 00 00

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 21
	Region 4: I/O ports at c000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 07 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 c0 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 02 00 00

0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin C routed to IRQ 21
	Region 0: Memory at f6033000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 04 31 17 00 10 02 86 20 03 0c 10 20 80 00
10: 00 30 03 f6 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 03 00 00

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 27 32 87 00 10 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 22
	Region 0: I/O ports at c800 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 59 30 01 00 10 02 60 00 01 04 00 00 00 00
10: 01 c8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0b 03 00 00

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 01) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G550 Dual Head DDR 32Mb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 8000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at f2000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at f3000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at f2020000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
00: 2b 10 27 25 07 00 90 02 01 00 00 03 08 20 00 00
10: 08 00 00 f0 00 00 00 f2 00 00 00 f3 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 84 0f
30: 00 00 02 f2 dc 00 00 00 00 00 00 00 0b 01 10 20


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci-vvx-2.6.13rc6p"

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host Bridge (rev 01)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 8
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [80] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] #08 [0060]
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #08 [8001]
00: 06 11 88 31 06 00 30 a2 01 00 00 06 00 08 00 00
10: 08 00 00 d8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800 South] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: f2000000-f4ffffff
	Prefetchable memory behind bridge: f0000000-f1ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 88 b1 07 01 30 02 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 20 22
20: 00 f2 f0 f4 00 f0 f0 f1 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 08 00

0000:00:05.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895 (rev 01)
	Subsystem: Tekram Technology Co.,Ltd. DC-390U2B SCSI adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (7500ns min, 16000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at 9000 [size=256]
	Region 1: Memory at f6032000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at f6031000 (32-bit, non-prefetchable) [size=4K]
00: 00 10 0c 00 17 00 00 02 01 00 00 01 10 20 00 00
10: 01 90 00 00 00 20 03 f6 00 10 03 f6 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 e1 1d 06 39
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 1e 40

0000:00:06.0 Multimedia audio controller: Trident Microsystems 4DWave NX (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 9400 [size=256]
	Region 1: Memory at f6030000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [48] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 23 10 01 20 07 00 10 02 02 00 01 04 00 20 00 00
10: 01 94 00 00 00 00 03 f6 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 48 00 00 00 00 00 00 00 0a 01 02 05

0000:00:08.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01) (prog-if 00 [VGA])
	Subsystem: PC Partner Limited: Unknown device 7c25
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at e0000000 (32-bit, prefetchable) [disabled] [size=128M]
	Region 1: I/O ports at 9800 [disabled] [size=256]
	Region 2: Memory at f6000000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 64 59 00 00 90 02 01 00 00 03 08 20 80 00
10: 08 00 00 e0 01 98 00 00 00 00 00 f6 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 25 7c
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 01 08 00

0000:00:08.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (Secondary) (rev 01)
	Subsystem: PC Partner Limited: Unknown device 7c24
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at e8000000 (32-bit, prefetchable) [disabled] [size=128M]
	Region 1: Memory at f6010000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 44 5d 00 00 90 02 01 00 80 03 08 20 00 00
10: 08 00 00 e8 00 00 01 f6 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 24 7c
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 08 00

0000:00:0b.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705 Gigabit Ethernet (rev 03)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (16000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f6020000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: ffbefdffffffef9c  Data: ffde
00: e4 14 53 16 06 00 b0 02 03 00 00 02 08 20 00 00
10: 04 00 02 f6 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 07 00 00 00 62 14 00 13
30: 00 00 00 00 48 00 00 00 00 00 00 00 0b 01 40 00

0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin B routed to IRQ 20
	Region 0: I/O ports at 9c00 [size=8]
	Region 1: I/O ports at a000 [size=4]
	Region 2: I/O ports at a400 [size=8]
	Region 3: I/O ports at a800 [size=4]
	Region 4: I/O ports at ac00 [size=16]
	Region 5: I/O ports at b000 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 49 31 07 00 90 02 80 00 04 01 00 20 80 00
10: 01 9c 00 00 01 a0 00 00 01 a4 00 00 01 a8 00 00
20: 01 ac 00 00 01 b0 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 c0 00 00 00 00 00 00 00 04 02 00 00

0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 20
	Region 4: I/O ports at b400 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b4 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 00 00

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 21
	Region 4: I/O ports at b800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 07 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b8 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 01 00 00

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 21
	Region 4: I/O ports at bc00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 07 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 bc 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 01 00 00

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 21
	Region 4: I/O ports at c000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 07 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 c0 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 02 00 00

0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin C routed to IRQ 21
	Region 0: Memory at f6033000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 04 31 17 00 10 02 86 20 03 0c 10 20 80 00
10: 00 30 03 f6 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 03 00 00

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 27 32 87 00 10 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 22
	Region 0: I/O ports at c800 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 59 30 01 00 10 02 60 00 01 04 00 00 00 00
10: 01 c8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0b 03 00 00

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 01) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G550 Dual Head DDR 32Mb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 8000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at f2000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at f3000000 (32-bit, non-prefetchable) [size=8M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
00: 2b 10 27 25 07 00 90 02 01 00 00 03 08 20 00 00
10: 08 00 00 f0 00 00 00 f2 00 00 00 f3 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 84 0f
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 10 20


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci-vvx-2.6.13rc6p-afterX"

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host Bridge (rev 01)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [80] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] #08 [0060]
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #08 [8001]
00: 06 11 88 31 06 00 30 22 01 00 00 06 00 08 00 00
10: 08 00 00 d8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800 South] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: f2000000-f4ffffff
	Prefetchable memory behind bridge: f0000000-f1ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 88 b1 07 01 30 02 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 20 22
20: 00 f2 f0 f4 00 f0 f0 f1 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

0000:00:05.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895 (rev 01)
	Subsystem: Tekram Technology Co.,Ltd. DC-390U2B SCSI adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (7500ns min, 16000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at 9000 [size=256]
	Region 1: Memory at f6032000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at f6031000 (32-bit, non-prefetchable) [size=4K]
00: 00 10 0c 00 17 00 00 02 01 00 00 01 10 20 00 00
10: 01 90 00 00 00 20 03 f6 00 10 03 f6 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 e1 1d 06 39
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 1e 40

0000:00:06.0 Multimedia audio controller: Trident Microsystems 4DWave NX (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 9400 [size=256]
	Region 1: Memory at f6030000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [48] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 23 10 01 20 07 00 10 02 02 00 01 04 00 20 00 00
10: 01 94 00 00 00 00 03 f6 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 48 00 00 00 00 00 00 00 0a 01 02 05

0000:00:08.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01) (prog-if 00 [VGA])
	Subsystem: PC Partner Limited: Unknown device 7c25
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 9800 [size=256]
	Region 2: Memory at f6000000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 64 59 07 00 90 02 01 00 00 03 08 20 80 00
10: 08 00 00 e0 01 98 00 00 00 00 00 f6 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 25 7c
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 01 08 00

0000:00:08.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (Secondary) (rev 01)
	Subsystem: PC Partner Limited: Unknown device 7c24
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at e8000000 (32-bit, prefetchable) [disabled] [size=128M]
	Region 1: Memory at f6010000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 44 5d 00 00 90 02 01 00 80 03 08 20 00 00
10: 08 00 00 e8 00 00 01 f6 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 24 7c
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 08 00

0000:00:0b.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705 Gigabit Ethernet (rev 03)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (16000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f6020000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: ffbefdffffffef9c  Data: ffde
00: e4 14 53 16 06 00 b0 02 03 00 00 02 08 20 00 00
10: 04 00 02 f6 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 07 00 00 00 62 14 00 13
30: 00 00 00 00 48 00 00 00 00 00 00 00 0b 01 40 00

0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin B routed to IRQ 20
	Region 0: I/O ports at 9c00 [size=8]
	Region 1: I/O ports at a000 [size=4]
	Region 2: I/O ports at a400 [size=8]
	Region 3: I/O ports at a800 [size=4]
	Region 4: I/O ports at ac00 [size=16]
	Region 5: I/O ports at b000 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 49 31 07 00 90 02 80 00 04 01 00 20 80 00
10: 01 9c 00 00 01 a0 00 00 01 a4 00 00 01 a8 00 00
20: 01 ac 00 00 01 b0 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 c0 00 00 00 00 00 00 00 04 02 00 00

0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 20
	Region 4: I/O ports at b400 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b4 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 00 00

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 21
	Region 4: I/O ports at b800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 07 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b8 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 01 00 00

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 21
	Region 4: I/O ports at bc00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 07 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 bc 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 01 00 00

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 21
	Region 4: I/O ports at c000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 07 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 c0 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 02 00 00

0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin C routed to IRQ 21
	Region 0: Memory at f6033000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 04 31 17 00 10 02 86 20 03 0c 10 20 80 00
10: 00 30 03 f6 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 03 00 00

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 27 32 87 00 10 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 22
	Region 0: I/O ports at c800 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 59 30 01 00 10 02 60 00 01 04 00 00 00 00
10: 01 c8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0b 03 00 00

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 01) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G550 Dual Head DDR 32Mb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 8000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at f2000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at f3000000 (32-bit, non-prefetchable) [size=8M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
00: 2b 10 27 25 07 00 90 02 01 00 00 03 08 20 00 00
10: 08 00 00 f0 00 00 00 f2 00 00 00 f3 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 84 0f
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 10 20


--sdtB3X0nJg68CQEu--
