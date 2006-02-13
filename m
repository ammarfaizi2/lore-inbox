Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWBMQhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWBMQhD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWBMQhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:37:00 -0500
Received: from ezoffice.mandriva.com ([84.14.106.134]:37389 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP
	id S1750800AbWBMQg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:36:58 -0500
From: Thierry Vignaud <tvignaud@mandriva.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16-rc3
Organization: Mandrakesoft
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
	<20060212190520.244fcaec.akpm@osdl.org> <s5hk6bz4gca.wl%tiwai@suse.de>
X-URL: <http://www.linux-mandrake.com/
Date: Mon, 13 Feb 2006 17:36:50 +0100
In-Reply-To: <s5hk6bz4gca.wl%tiwai@suse.de> (Takashi Iwai's message of "Mon,
	13 Feb 2006 13:02:13 +0100")
Message-ID: <m23binusf1.fsf@vador.mandriva.com>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Takashi Iwai <tiwai@suse.de> writes:

> It's not a "regression".  PM didn't work with ens1370 at all in the
> eralier version.

btw, PM support in snd-intel8x0 is broken (at least regarding
suspending) in 2.6.16-rc2-mm1 on a nforce2 chipset

even if not playing while suspending, ALSA won't resume playing: no
more program can play anything strace show that sound programs block
on unfinished "futex(0xb7768060, FUTEX_WAIT, 29, NULL..." calls

lspci -vvvv:

--=-=-=
Content-Disposition: attachment; filename=bug.suspend.lspci

00:00.0 Host bridge: nVidia Corporation nForce CPU bridge (rev b2)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <access denied>

00:00.1 RAM memory: nVidia Corporation nForce 220/420 Memory Controller (rev b2)
	Subsystem: ABIT Computer Corp. Unknown device 7105
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: nVidia Corporation nForce 220/420 Memory Controller (rev b2)
	Subsystem: ABIT Computer Corp. Unknown device 7105
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.3 RAM memory: nVidia Corporation nForce 420 Memory Controller (DDR) (rev b2)
	Subsystem: ABIT Computer Corp. Unknown device 7105
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:01.0 ISA bridge: nVidia Corporation nForce ISA Bridge (rev c3)
	Subsystem: ABIT Computer Corp. Unknown device 7105
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: <access denied>

00:01.1 SMBus: nVidia Corporation nForce PCI System Management (rev c1)
	Subsystem: ABIT Computer Corp. Unknown device 7105
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 5000 [size=16]
	Region 1: I/O ports at d000 [size=16]
	Region 2: I/O ports at d400 [size=32]
	Capabilities: <access denied>

00:02.0 USB Controller: nVidia Corporation nForce USB Controller (rev c3) (prog-if 10 [OHCI])
	Subsystem: ABIT Computer Corp. Unknown device 7105
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e0081000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>

00:03.0 USB Controller: nVidia Corporation nForce USB Controller (rev c3) (prog-if 10 [OHCI])
	Subsystem: ABIT Computer Corp. Unknown device 7105
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at e0080000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>

00:05.0 Multimedia audio controller: nVidia Corporation nForce Audio (rev c2)
	Subsystem: ABIT Computer Corp. Unknown device 7105
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 3000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: <access denied>

00:06.0 Multimedia audio controller: nVidia Corporation nForce Audio (rev c2)
	Subsystem: ABIT Computer Corp. Unknown device 7105
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at d800 [size=256]
	Region 1: I/O ports at dc00 [size=128]
	Region 2: Memory at e0082000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>

00:08.0 PCI bridge: nVidia Corporation nForce PCI-to-PCI bridge (rev c2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: de000000-dfffffff
	Prefetchable memory behind bridge: 10000000-100fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:09.0 IDE interface: nVidia Corporation nForce IDE (rev c3) (prog-if 8a [Master SecP PriP])
	Subsystem: ABIT Computer Corp. Unknown device 7105
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at e400 [size=16]
	Capabilities: <access denied>

00:1e.0 PCI bridge: nVidia Corporation nForce AGP to PCI Bridge (rev b2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: dc000000-ddffffff
	Prefetchable memory behind bridge: d0000000-d7ffffff
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

01:06.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 64)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at c000 [size=128]
	Region 1: Memory at df000000 (32-bit, non-prefetchable) [size=128]
	[virtual] Expansion ROM at 10000000 [disabled] [size=128K]
	Capabilities: <access denied>

01:07.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Adaptec Unknown device 0335
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (250ns min, 10500ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at df001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>

01:07.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Adaptec Unknown device 0335
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (250ns min, 10500ns max), Cache Line Size 08
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at df002000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>

01:07.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
	Subsystem: Adaptec Unknown device 03e0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 8500ns max), Cache Line Size 10
	Interrupt: pin C routed to IRQ 11
	Region 0: Memory at df003000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <access denied>

02:00.0 VGA compatible controller: nVidia Corporation NVCrush11 [GeForce2 MX Integrated Graphics] (rev b1) (prog-if 00 [VGA])
	Subsystem: ABIT Computer Corp. Unknown device 7105
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	[virtual] Expansion ROM at dd000000 [disabled] [size=64K]
	Capabilities: <access denied>


--=-=-=--

