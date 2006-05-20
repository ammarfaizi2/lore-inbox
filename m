Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWETSDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWETSDQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 14:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWETSDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 14:03:15 -0400
Received: from wx-out-0102.google.com ([66.249.82.192]:18660 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932350AbWETSDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 14:03:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=aYtMExmxHz+Iu39P9rsnHOGmF5QJJJigqvHFk4Q13QdklFtZSDYsrEZoE+F/gyUIzcAlnkfD6XcVUDgbzl9wmv0DYhXx8amezWM3LSmyr5dFnn4TsRChGlZZtw1+4o9VLsWN5OFRQ4p5FxN2WT99oLVydd8CrvP6X5mj5prsAew=
Message-ID: <8e6f94720605201103w3db0791bvb39e3b9bd6bc916f@mail.gmail.com>
Date: Sat, 20 May 2006 14:03:13 -0400
From: "Will Dyson" <will.dyson@gmail.com>
To: "Pete Zaitcev" <zaitcev@redhat.com>
Subject: Re: [linux-usb-devel] Re: USB 2.0 ehci failure with large amount of RAM (4GB) on x86_64
Cc: "David Brownell" <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net, nathanbecker@gmail.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060516102903.8cf069cf.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_121544_8604487.1148148193121"
References: <2151339d0605032148n5d6936ay31ab017fbabc65b3@mail.gmail.com>
	 <200605061232.52303.david-b@pacbell.net>
	 <2151339d0605092237m4ef4e835k16b8c779f6ad7046@mail.gmail.com>
	 <200605122132.41410.david-b@pacbell.net>
	 <20060516102903.8cf069cf.zaitcev@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_121544_8604487.1148148193121
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 5/16/06, Pete Zaitcev <zaitcev@redhat.com> wrote:
> On Fri, 12 May 2006 21:32:39 -0700, David Brownell <david-b@pacbell.net> =
wrote:
>
> > Can you confirm that this patch also resolves your issue? [...]
>
> I noticed that you added the mask inside the case while Nathan
> added it outside. So, he did it for all nVidia silicon.
>
> I would think it may be better if he tested your patch very
> exactly on top of a clean kernel (e.g. make sure that his own
> patch is not in the way), and also sent us the lspci output
> with the chip revision numbers.

I'm having a similar-seeming issue on my nforce3 board w/ 3GB ram. I
can use my usb2 devices normally if I boot with mem=3D2G but if I allow
linux to see all 3GB, plugging in a usb2 hub goes like this (full
dmesg and lspci attatched):

hub 3-0:1.0: state 7 ports 8 chg 0000 evt 0010
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001803 POWER sig=3Dj CSC CON=
NECT
hub 3-0:1.0: port 4, status 0501, change 0001, 480 Mb/s
hub 3-0:1.0: debounce: port 4: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=3Dse0 PE CO=
NNECT
usb 3-4: new high speed USB device using ehci_hcd and address 4
usb 3-4: khubd timed out on ep0in len=3D0/64
usb 3-4: khubd timed out on ep0in len=3D0/64
usb 3-4: khubd timed out on ep0in len=3D0/64
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=3Dse0 PE CO=
NNECT
usb 3-4: device descriptor read/64, error -110
usb 3-4: khubd timed out on ep0in len=3D0/64
usb 3-4: khubd timed out on ep0in len=3D0/64
usb 3-4: khubd timed out on ep0in len=3D0/64
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=3Dse0 PE CO=
NNECT
usb 3-4: device descriptor read/64, error -110
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=3Dse0 PE CO=
NNECT
usb 3-4: new high speed USB device using ehci_hcd and address 5

I tested the above patch and it does not resolve the issue.

--=20
Will Dyson

------=_Part_121544_8604487.1148148193121
Content-Type: text/plain; name=lspci.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_eng9mamb
Content-Disposition: attachment; filename="lspci.txt"

0000:00:00.0 Host bridge: nVidia Corporation nForce3 250Gb Host Bridge (rev a1)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [44] #08 [01c0]
	Capabilities: [c0] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=2 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4

0000:00:01.0 ISA bridge: nVidia Corporation nForce3 250Gb LPC Bridge (rev a2)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:01.1 SMBus: nVidia Corporation nForce 250Gb PCI System Management (rev a1)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at e800 [size=32]
	Region 4: I/O ports at 4c00 [size=64]
	Region 5: I/O ports at 4c40 [size=64]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.0 USB Controller: nVidia Corporation CK8S USB Controller (rev a1) (prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 217
	Region 0: Memory at f6003000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.1 USB Controller: nVidia Corporation CK8S USB Controller (rev a1) (prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 185
	Region 0: Memory at f6004000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.2 USB Controller: nVidia Corporation nForce3 EHCI USB 2.0 Controller (rev a2) (prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin C routed to IRQ 201
	Region 0: Memory at f6005000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] #0a [2098]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:05.0 Bridge: nVidia Corporation CK8S Ethernet Controller (rev a2)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 185
	Region 0: Memory at f6000000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at a400 [size=8]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce3 250Gb AC'97 Audio Controller (rev a1)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7585
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 193
	Region 0: I/O ports at a800 [size=256]
	Region 1: I/O ports at ac00 [size=128]
	Region 2: Memory at f6001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 IDE interface: nVidia Corporation CK8S Parallel ATA Controller (v2.5) (rev a2) (prog-if 8a [Master SecP PriP])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at f000 [size=16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.0 IDE interface: nVidia Corporation CK8S Serial ATA Controller (v2.5) (rev a2) (prog-if 85 [Master SecO PriO])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 193
	Region 0: I/O ports at 09e0 [size=8]
	Region 1: I/O ports at 0be0 [size=4]
	Region 2: I/O ports at 0960 [size=8]
	Region 3: I/O ports at 0b60 [size=4]
	Region 4: I/O ports at c800 [size=16]
	Region 5: I/O ports at cc00 [size=128]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0a.0 IDE interface: nVidia Corporation CK8S Serial ATA Controller (v2.5) (rev a2) (prog-if 85 [Master SecO PriO])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 201
	Region 0: I/O ports at 09f0 [size=8]
	Region 1: I/O ports at 0bf0 [size=4]
	Region 2: I/O ports at 0970 [size=8]
	Region 3: I/O ports at 0b70 [size=4]
	Region 4: I/O ports at e000 [size=16]
	Region 5: I/O ports at e400 [size=128]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0b.0 PCI bridge: nVidia Corporation nForce3 250Gb AGP Host to PCI Bridge (rev a2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=10
	I/O behind bridge: 00008000-00008fff
	Memory behind bridge: f4000000-f5ffffff
	Prefetchable memory behind bridge: d8000000-e7ffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

0000:00:0e.0 PCI bridge: nVidia Corporation nForce3 250Gb PCI-to-PCI Bridge (rev a2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=128
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: f0000000-f3ffffff
	Prefetchable memory behind bridge: c4000000-c40fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200] (rev 01) (prog-if 00 [VGA])
	Subsystem: C.P. Technology Co. Ltd: Unknown device 2063
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 177
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 8000 [size=256]
	Region 2: Memory at f5010000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at f4000000 [disabled] [size=128K]
	Capabilities: [58] AGP version 3.0
		Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200] (Secondary) (rev 01)
	Subsystem: C.P. Technology Co. Ltd: Unknown device 2062
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at e0000000 (32-bit, prefetchable) [disabled] [size=128M]
	Region 1: Memory at f5000000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:08.0 Multimedia video controller: Conexant CX23880/1/2/3 PCI Video and Audio Decoder (rev 05)
	Subsystem: pcHDTV pcHDTV HD3000 HDTV
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5000ns min, 13750ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 233
	Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=16M]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:08.2 Multimedia controller: Conexant CX23880/1/2/3 PCI Video and Audio Decoder [MPEG Port] (rev 05)
	Subsystem: pcHDTV pcHDTV HD3000 HDTV
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1500ns min, 22000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 233
	Region 0: Memory at f1000000 (32-bit, non-prefetchable) [size=16M]
	Capabilities: [4c] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 05)
	Subsystem: Creative Labs CT4850 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 225
	Region 0: I/O ports at 9000 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:0a.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 05)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at 9400 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:0c.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) (prog-if 10 [OHCI])
	Subsystem: Unknown device 0574:086c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 209
	Region 0: Memory at f3001000 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at 9800 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet (rev 10)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 025c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 177
	Region 0: I/O ports at 9c00 [size=256]
	Region 1: Memory at f3000000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at c4000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-



------=_Part_121544_8604487.1148148193121
Content-Type: text/plain; name=dmesg.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_eng9mxdi
Content-Disposition: attachment; filename="dmesg.txt"

Bootdata ok (command line is root=/dev/sda2 ro )
Linux version 2.6.17-rc4-g0c056c50-dirty (will@zod) (gcc version 4.0.4 20060507 (prerelease) (Debian 4.0.3-3)) #1 PREEMPT Wed May 17 17:04:54 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
 BIOS-e820: 00000000bfff0000 - 00000000bfff3000 (ACPI NVS)
 BIOS-e820: 00000000bfff3000 - 00000000c0000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000fefffc00 - 00000000ff000000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
DMI 2.2 present.
ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7180
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff7a00
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
On node 0 totalpages: 775559
  DMA zone: 3934 pages, LIFO batch:0
  DMA32 zone: 771625 pages, LIFO batch:31
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:15 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at c4000000 (gap: c0000000:3ec00000)
Checking aperture...
CPU 0: aperture @ e8000000 size 128 MB
Built 1 zonelists
Kernel command line: root=/dev/sda2 ro 
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 1808.816 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 3074656k/3145664k available (2945k kernel code, 70268k reserved, 2070k data, 172k init)
Calibrating delay using timer specific routine.. 3618.66 BogoMIPS (lpj=1809333)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 00
Using local APIC timer interrupts.
result 12561230
Detected 12.561 MHz APIC timer.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: Power Resource [ISAV] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
Generic PHY: Registered new driver
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
agpgart: Detected AGP bridge 0
agpgart: Setting up Nforce3 AGP.
agpgart: AGP aperture is 128M @ 0xe8000000
PCI-DMA: Disabling IOMMU.
PCI: Bridge: 0000:00:0b.0
  IO window: 8000-8fff
  MEM window: f4000000-f5ffffff
  PREFETCH window: d8000000-e7ffffff
PCI: Bridge: 0000:00:0e.0
  IO window: 9000-9fff
  MEM window: f0000000-f3ffffff
  PREFETCH window: c4000000-c40fffff
PCI: Setting latency timer of device 0000:00:0e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Total HugeTLB memory allocated, 0
fuse init (API version 7.6)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler cfq registered
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
Using specific hotkey driver
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
GSI 16 sharing vector 0xB1 and IRQ 16
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 177
[drm] Initialized radeon 1.24.0 20060225 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
loop: loaded (max 8 devices)
Marvell 88E1101: Registered new driver
QS6612: Registered new driver
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.54.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
GSI 17 sharing vector 0xB9 and IRQ 17
ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [APCH] -> GSI 23 (level, high) -> IRQ 185
PCI: Setting latency timer of device 0000:00:05.0 to 64
eth0: forcedeth.c: subsystem: 01462:0250 bound to 0000:00:05.0
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
r8169 Gigabit Ethernet driver 2.2LK-NAPI loaded
ACPI: PCI Interrupt Link [APC5] enabled at IRQ 16
ACPI: PCI Interrupt 0000:02:0d.0[A] -> Link [APC5] -> GSI 16 (level, low) -> IRQ 177
eth1: Identified chip type is 'RTL8169s/8110s'.
eth1: RTL8169 at 0xffffc20000010000, 00:11:09:8f:4b:52, IRQ 177
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-250: IDE controller at PCI slot 0000:00:08.0
NFORCE3-250: chipset revision 162
NFORCE3-250: not 100% native mode: will probe irqs later
NFORCE3-250: 0000:00:08.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: PLEXTOR DVDR PX-712A, ATAPI CD/DVD-ROM drive
isa bounce pool size: 16 pages
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.20 loaded.
sata_nv 0000:00:09.0: version 0.8
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 22
GSI 18 sharing vector 0xC1 and IRQ 18
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [APSI] -> GSI 22 (level, high) -> IRQ 193
PCI: Setting latency timer of device 0000:00:09.0 to 64
ata1: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC800 irq 193
ata2: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC808 irq 193
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:346b 83:7f61 84:4003 85:3469 86:3c41 87:4003 88:407f
ata1: dev 0 ATA-6, max UDMA/133, 312581808 sectors: LBA48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata1: dev 0 configured for UDMA/133
scsi0 : sata_nv
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e01 87:4663 88:407f
ata2: dev 0 ATA-7, max UDMA/133, 490234752 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_nv
  Vendor: ATA       Model: WDC WD1600SD-01K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6L250S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 21
GSI 19 sharing vector 0xC9 and IRQ 19
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APSJ] -> GSI 21 (level, high) -> IRQ 201
PCI: Setting latency timer of device 0000:00:0a.0 to 64
ata3: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xE000 irq 201
ata4: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xE008 irq 201
ata3: SATA link down (SStatus 0)
scsi2 : sata_nv
ata4: SATA link down (SStatus 0)
scsi3 : sata_nv
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
GSI 20 sharing vector 0xD1 and IRQ 20
ACPI: PCI Interrupt 0000:02:0c.0[A] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 209
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[209]  MMIO=[f3001000-f30017ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 80 td 96
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
GSI 21 sharing vector 0xD9 and IRQ 21
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 20 (level, high) -> IRQ 217
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
drivers/usb/core/inode.c: creating file 'devices'
drivers/usb/core/inode.c: creating file '001'
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: created debug files
ohci_hcd 0000:00:02.0: irq 217, io mem 0xf6003000
ohci_hcd 0000:00:02.0: resetting from state 'reset', control = 0x600
ohci_hcd 0000:00:02.0: OHCI controller state
ohci_hcd 0000:00:02.0: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:02.0: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:02.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.0: intrstatus 0x00000004 SF
ohci_hcd 0000:00:02.0: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.0: hcca frame #0003
ohci_hcd 0000:00:02.0: roothub.a 01000204 POTPGT=1 NPS NDP=4(4)
ohci_hcd 0000:00:02.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [3] 0x00000100 PPS
usb usb1: default language 0x0409
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.17-rc4-g0c056c50-dirty ohci_hcd
usb usb1: SerialNumber: 0000:00:02.0
usb usb1: uevent
usb usb1: configuration #1 chosen from 1 choice
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: uevent
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: state 7 ports 4 chg 0000 evt 0000
drivers/usb/core/inode.c: creating file '001'
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCG] -> GSI 23 (level, high) -> IRQ 185
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: OHCI Host Controller
drivers/usb/core/inode.c: creating file '002'
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.1: created debug files
ohci_hcd 0000:00:02.1: irq 185, io mem 0xf6004000
ohci_hcd 0000:00:02.1: resetting from state 'reset', control = 0x600
ohci_hcd 0000:00:02.1: OHCI controller state
ohci_hcd 0000:00:02.1: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:02.1: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:02.1: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.1: intrstatus 0x00000044 RHSC SF
ohci_hcd 0000:00:02.1: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.1: hcca frame #0003
ohci_hcd 0000:00:02.1: roothub.a 01000204 POTPGT=1 NPS NDP=4(4)
ohci_hcd 0000:00:02.1: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.1: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.1: roothub.portstatus [0] 0x00010301 CSC LSDA PPS CCS
ohci_hcd 0000:00:02.1: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.1: roothub.portstatus [2] 0x00010101 CSC PPS CCS
ohci_hcd 0000:00:02.1: roothub.portstatus [3] 0x00000100 PPS
usb usb2: default language 0x0409
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.17-rc4-g0c056c50-dirty ohci_hcd
usb usb2: SerialNumber: 0000:00:02.1
usb usb2: uevent
usb usb2: configuration #1 chosen from 1 choice
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: uevent
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
drivers/usb/core/inode.c: creating file '001'
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [0] = 0x00010301 CSC LSDA PPS CCS
hub 2-0:1.0: port 1, status 0301, change 0001, 1.5 Mb/s
ohci_hcd 0000:00:02.0: suspend root hub
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x301
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [0] = 0x00100303 PRSC LSDA PPS PES CCS
usb 2-1: new low speed USB device using ohci_hcd and address 2
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [0] = 0x00100303 PRSC LSDA PPS PES CCS
usb 2-1: skipped 1 descriptor after interface
usb 2-1: default language 0x0409
usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-1: Product: USB-PS/2 Optical Mouse
usb 2-1: Manufacturer: Logitech
usb 2-1: uevent
usb 2-1: configuration #1 chosen from 1 choice
usb 2-1: adding 2-1:1.0 (config #1, interface 0)
usb 2-1:1.0: uevent
drivers/usb/core/inode.c: creating file '002'
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00010101 CSC PPS CCS
hub 2-0:1.0: port 3, status 0101, change 0001, 12 Mb/s
hub 2-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x101
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00100103 PRSC PPS PES CCS
usb 2-3: new full speed USB device using ohci_hcd and address 3
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00100103 PRSC PPS PES CCS
usb 2-3: ep0 maxpacket = 8
usb 2-3: default language 0x0409
usb 2-3: new device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-3: Product: USB Printer
usb 2-3: Manufacturer: EPSON
usb 2-3: SerialNumber: L41019901181352300
usb 2-3: uevent
usb 2-3: configuration #1 chosen from 1 choice
usb 2-3: adding 2-3:1.0 (config #1, interface 0)
usb 2-3:1.0: uevent
drivers/usb/core/inode.c: creating file '003'
hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0002
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbhid 2-1:1.0: usb_probe_interface
usbhid 2-1:1.0: usb_probe_interface - got id
input: Logitech USB-PS/2 Optical Mouse as /class/input/input0
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:02.1-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input1
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0010dc00006c260b]
input: AT Translated Set 2 keyboard as /class/input/input2
i2c /dev entries driver
EDAC MC: Ver: 2.0.0 May 17 2006
Advanced Linux Sound Architecture Driver Version 1.0.11rc4 (Wed Mar 22 10:27:24 2006 UTC).
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [APCJ] -> GSI 22 (level, high) -> IRQ 193
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 50615 usecs
intel8x0: clocking to 46872
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
GSI 22 sharing vector 0xE1 and IRQ 22
ACPI: PCI Interrupt 0000:02:0a.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 225
ALSA device list:
  #0: NVidia CK8S with ALC850 at 0xf6001000, irq 193
  #1: SBLive! Value [CT4670] (rev.5, serial:0x201102) at 0x9000, irq 225
u32 classifier
    Actions configured 
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 280 bytes per conntrack
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.60.2)
powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
powernow-k8:    1 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
cpu_init done, current fid 0xa, vid 0x6
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
ReiserFS: sda2: found reiserfs format "3.6" with standard journal
ReiserFS: sda2: using ordered data mode
ReiserFS: sda2: journal params: device sda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda2: checking transaction log (sda2)
ReiserFS: sda2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 172k freed
usb 2-3:1.0: uevent
usb 2-3: uevent
usb 2-1:1.0: uevent
usb 2-1: uevent
usb 2-0:1.0: uevent
usb usb2: uevent
usb 1-0:1.0: uevent
usb usb1: uevent
usblp 2-3:1.0: usb_probe_interface
usblp 2-3:1.0: usb_probe_interface - got id
drivers/usb/core/file.c: looking for a minor, starting at 0
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 0 proto 2 vid 0x04B8 pid 0x0005
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
ehci_hcd: block sizes: qh 160 qtd 96 itd 192 sitd 96
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [APCL] -> GSI 21 (level, high) -> IRQ 201
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: EHCI Host Controller
drivers/usb/core/inode.c: creating file '003'
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:02.2: reset hcs_params 0x102488 dbg=1 cc=2 pcc=4 !ppc ports=8
ehci_hcd 0000:00:02.2: reset portroute 0 0 1 1 1 0 1 0 
ehci_hcd 0000:00:02.2: reset hcc_params a082 caching frame 256/512/1024
ehci_hcd 0000:00:02.2: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: supports USB remote wakeup
ehci_hcd 0000:00:02.2: irq 201, io mem 0xf6005000
ehci_hcd 0000:00:02.2: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
ehci_hcd 0000:00:02.2: init command 010009 (park)=0 ithresh=1 period=256 RUN
ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb3: default language 0x0409
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: EHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.17-rc4-g0c056c50-dirty ehci_hcd
usb usb3: SerialNumber: 0000:00:02.2
usb usb3: uevent
usb usb3: configuration #1 chosen from 1 choice
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: uevent
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 8 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: individual port over-current protection
hub 3-0:1.0: Single TT
hub 3-0:1.0: TT requires at most 8 FS bit times (666 ns)
hub 3-0:1.0: power on to power good time: 20ms
hub 3-0:1.0: local power source is good
eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
hub 2-0:1.0: state 7 ports 4 chg 0000 evt 000a
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [0] = 0x00030300 PESC CSC LSDA PPS
hub 2-0:1.0: port 1, status 0300, change 0003, 1.5 Mb/s
usb 2-1: USB disconnect, address 2
usb 2-1: usb_disable_device nuking all URBs
usb 2-1: unregistering interface 2-1:1.0
usb 2-1:1.0: uevent
usb 2-1: unregistering device
usb 2-1: uevent
drivers/usb/core/inode.c: creating file '001'
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x300
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00030100 PESC CSC PPS
hub 2-0:1.0: port 3, status 0100, change 0003, 12 Mb/s
usb 2-3: USB disconnect, address 3
usb 2-3: usb_disable_device nuking all URBs
usb 2-3: unregistering interface 2-3:1.0
drivers/usb/core/file.c: removing 0 minor
drivers/usb/class/usblp.c: usblp0: removed
usb 2-3:1.0: uevent
usb 2-3: unregistering device
usb 2-3: uevent
hub 2-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x100
hub 3-0:1.0: state 7 ports 8 chg 0000 evt 0000
ehci_hcd 0000:00:02.2: GetStatus port 3 status 001403 POWER sig=k CSC CONNECT
hub 3-0:1.0: port 3, status 0501, change 0001, 480 Mb/s
ohci_hcd 0000:00:02.1: suspend root hub
cx2388x dvb driver version 0.0.5 loaded
CORE cx88[0]: subsystem: 7063:3000, board: pcHDTV HD3000 HDTV [card=22,autodetected]
TV tuner 52 at 0x1fe, Radio tuner -1 at 0x1fe
hub 3-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:02.2: port 3 low speed --> companion
ehci_hcd 0000:00:02.2: GetStatus port 3 status 003402 POWER OWNER sig=k CSC
ehci_hcd 0000:00:02.2: GetStatus port 6 status 001803 POWER sig=j CSC CONNECT
hub 3-0:1.0: port 6, status 0501, change 0001, 480 Mb/s
cx2388x v4l2 driver version 0.0.5 loaded
hub 3-0:1.0: debounce: port 6: total 100ms stable 100ms status 0x501
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
GSI 23 sharing vector 0xE9 and IRQ 23
ACPI: PCI Interrupt 0000:02:08.2[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 233
cx88[0]/2: found at 0000:02:08.2, rev: 5, irq: 233, latency: 32, mmio: 0xf1000000
cx88[0]/2: cx2388x based dvb card
DVB: registering new adapter (cx88[0]).
DVB: registering frontend 0 (Oren OR51132 VSB/QAM Frontend)...
ACPI: PCI Interrupt 0000:02:08.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 233
cx88[0]/0: found at 0000:02:08.0, rev: 5, irq: 233, latency: 32, mmio: 0xf0000000
ehci_hcd 0000:00:02.2: port 6 full speed --> companion
ehci_hcd 0000:00:02.2: GetStatus port 6 status 003001 POWER OWNER sig=se0 CONNECT
hub 3-0:1.0: state 7 ports 8 chg 0000 evt 0000
hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000, resume root
ohci_hcd 0000:00:02.1: wakeup
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [0] = 0x00010301 CSC LSDA PPS CCS
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00010101 CSC PPS CCS
hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [0] = 0x00010301 CSC LSDA PPS CCS
hub 2-0:1.0: port 1, status 0301, change 0001, 1.5 Mb/s
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x301
tuner 2-0061: chip found @ 0xc2 (cx88[0])
tuner 2-0061: type set to 52 (Thomson DTT 7610 (ATSC/NTSC))
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [0] = 0x00100303 PRSC LSDA PPS PES CCS
tda9887 2-0043: chip found @ 0x86 (cx88[0])
cx88[0]/0: registered device video0 [v4l2]
cx88[0]/0: registered device vbi0
cx88[0]/0: registered device radio0
usb 2-1: new low speed USB device using ohci_hcd and address 4
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [0] = 0x00100303 PRSC LSDA PPS PES CCS
cx2388x blackbird driver version 0.0.5 loaded
usb 2-1: skipped 1 descriptor after interface
usb 2-1: default language 0x0409
usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-1: Product: USB-PS/2 Optical Mouse
usb 2-1: Manufacturer: Logitech
usb 2-1: uevent
usb 2-1: configuration #1 chosen from 1 choice
usb 2-1: adding 2-1:1.0 (config #1, interface 0)
usb 2-1:1.0: uevent
usbhid 2-1:1.0: usb_probe_interface
usbhid 2-1:1.0: usb_probe_interface - got id
input: Logitech USB-PS/2 Optical Mouse as /class/input/input3
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:02.1-1
drivers/usb/core/inode.c: creating file '004'
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00010101 CSC PPS CCS
hub 2-0:1.0: port 3, status 0101, change 0001, 12 Mb/s
hub 2-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x101
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00100103 PRSC PPS PES CCS
usb 2-3: new full speed USB device using ohci_hcd and address 5
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00100103 PRSC PPS PES CCS
usb 2-3: ep0 maxpacket = 8
usb 2-3: default language 0x0409
usb 2-3: new device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-3: Product: USB Printer
usb 2-3: Manufacturer: EPSON
usb 2-3: SerialNumber: L41019901181352300
usb 2-3: uevent
usb 2-3: configuration #1 chosen from 1 choice
usb 2-3: adding 2-3:1.0 (config #1, interface 0)
usb 2-3:1.0: uevent
usblp 2-3:1.0: usb_probe_interface
usblp 2-3:1.0: usb_probe_interface - got id
drivers/usb/core/file.c: looking for a minor, starting at 0
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 5 if 0 alt 0 proto 2 vid 0x04B8 pid 0x0005
drivers/usb/core/inode.c: creating file '005'
hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0002
Adding 979956k swap on /dev/sda1.  Priority:-1 extents:1 across:979956k
w83627hf 9191-0290: Reading VID from GPIO5
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
ReiserFS: sda3: found reiserfs format "3.6" with standard journal
ReiserFS: sda3: using ordered data mode
ReiserFS: sda3: journal params: device sda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda3: checking transaction log (sda3)
ReiserFS: sda3: Using r5 hash to sort names
ReiserFS: sdb1: found reiserfs format "3.6" with standard journal
ReiserFS: sdb1: using ordered data mode
ReiserFS: sdb1: journal params: device sdb1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdb1: checking transaction log (sdb1)
ReiserFS: sdb1: Using r5 hash to sort names
ip_conntrack_pptp version 3.1 loaded
ip_nat_pptp version 3.0 loaded
eth0: no IPv6 routers present
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
[drm] Setting GART location based on new memory map
[drm] Loading R200 Microcode
[drm] writeback test succeeded in 1 usecs
hub 3-0:1.0: state 7 ports 8 chg 0000 evt 0010
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001803 POWER sig=j CSC CONNECT
hub 3-0:1.0: port 4, status 0501, change 0001, 480 Mb/s
hub 3-0:1.0: debounce: port 4: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=se0 PE CONNECT
usb 3-4: new high speed USB device using ehci_hcd and address 4
usb 3-4: khubd timed out on ep0in len=0/64
usb 3-4: khubd timed out on ep0in len=0/64
usb 3-4: khubd timed out on ep0in len=0/64
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=se0 PE CONNECT
usb 3-4: device descriptor read/64, error -110
usb 3-4: khubd timed out on ep0in len=0/64
usb 3-4: khubd timed out on ep0in len=0/64
usb 3-4: khubd timed out on ep0in len=0/64
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=se0 PE CONNECT
usb 3-4: device descriptor read/64, error -110
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=se0 PE CONNECT
usb 3-4: new high speed USB device using ehci_hcd and address 5
usb 3-4: khubd timed out on ep0in len=0/64
usb 3-4: khubd timed out on ep0in len=0/64
usb 3-4: khubd timed out on ep0in len=0/64
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=se0 PE CONNECT
usb 3-4: device descriptor read/64, error -110
usb 3-4: khubd timed out on ep0in len=0/64
usb 3-4: khubd timed out on ep0in len=0/64
usb 3-4: khubd timed out on ep0in len=0/64
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001002 POWER sig=se0 CSC
hub 3-0:1.0: state 7 ports 8 chg 0000 evt 0010


------=_Part_121544_8604487.1148148193121
Content-Type: text/plain; name=dmesg2G.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_eng9n5qz
Content-Disposition: attachment; filename="dmesg2G.txt"

Bootdata ok (command line is root=/dev/sda2 mem=2G ro single)
Linux version 2.6.17-rc4-g0c056c50-dirty (will@zod) (gcc version 4.0.4 20060507 (prerelease) (Debian 4.0.3-3)) #1 PREEMPT Wed May 17 17:04:54 EDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
 BIOS-e820: 00000000bfff0000 - 00000000bfff3000 (ACPI NVS)
 BIOS-e820: 00000000bfff3000 - 00000000c0000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000fefffc00 - 00000000ff000000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
DMI 2.2 present.
ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7180
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff7a00
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
On node 0 totalpages: 517014
  DMA zone: 3934 pages, LIFO batch:0
  DMA32 zone: 513080 pages, LIFO batch:31
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:15 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at c4000000 (gap: c0000000:3ec00000)
Checking aperture...
CPU 0: aperture @ e8000000 size 128 MB
Built 1 zonelists
Kernel command line: root=/dev/sda2 mem=2G ro single
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 1808.821 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 2043744k/2097152k available (2945k kernel code, 52832k reserved, 2070k data, 172k init)
Calibrating delay using timer specific routine.. 3618.66 BogoMIPS (lpj=1809330)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 00
Using local APIC timer interrupts.
result 12561263
Detected 12.561 MHz APIC timer.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: Power Resource [ISAV] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
Generic PHY: Registered new driver
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
agpgart: Detected AGP bridge 0
agpgart: Setting up Nforce3 AGP.
agpgart: AGP aperture is 128M @ 0xe8000000
PCI-DMA: Disabling IOMMU.
PCI: Bridge: 0000:00:0b.0
  IO window: 8000-8fff
  MEM window: f4000000-f5ffffff
  PREFETCH window: d8000000-e7ffffff
PCI: Bridge: 0000:00:0e.0
  IO window: 9000-9fff
  MEM window: f0000000-f3ffffff
  PREFETCH window: c4000000-c40fffff
PCI: Setting latency timer of device 0000:00:0e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Total HugeTLB memory allocated, 0
fuse init (API version 7.6)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler cfq registered
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
Using specific hotkey driver
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
GSI 16 sharing vector 0xB1 and IRQ 16
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 177
[drm] Initialized radeon 1.24.0 20060225 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
loop: loaded (max 8 devices)
Marvell 88E1101: Registered new driver
QS6612: Registered new driver
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.54.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
GSI 17 sharing vector 0xB9 and IRQ 17
ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [APCH] -> GSI 23 (level, high) -> IRQ 185
PCI: Setting latency timer of device 0000:00:05.0 to 64
eth0: forcedeth.c: subsystem: 01462:0250 bound to 0000:00:05.0
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
r8169 Gigabit Ethernet driver 2.2LK-NAPI loaded
ACPI: PCI Interrupt Link [APC5] enabled at IRQ 16
ACPI: PCI Interrupt 0000:02:0d.0[A] -> Link [APC5] -> GSI 16 (level, low) -> IRQ 177
eth1: Identified chip type is 'RTL8169s/8110s'.
eth1: RTL8169 at 0xffffc20000010000, 00:11:09:8f:4b:52, IRQ 177
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-250: IDE controller at PCI slot 0000:00:08.0
NFORCE3-250: chipset revision 162
NFORCE3-250: not 100% native mode: will probe irqs later
NFORCE3-250: 0000:00:08.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: PLEXTOR DVDR PX-712A, ATAPI CD/DVD-ROM drive
isa bounce pool size: 16 pages
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.20 loaded.
sata_nv 0000:00:09.0: version 0.8
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 22
GSI 18 sharing vector 0xC1 and IRQ 18
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [APSI] -> GSI 22 (level, high) -> IRQ 193
PCI: Setting latency timer of device 0000:00:09.0 to 64
ata1: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC800 irq 193
ata2: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC808 irq 193
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:346b 83:7f61 84:4003 85:3469 86:3c41 87:4003 88:407f
ata1: dev 0 ATA-6, max UDMA/133, 312581808 sectors: LBA48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata1: dev 0 configured for UDMA/133
scsi0 : sata_nv
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e01 87:4663 88:407f
ata2: dev 0 ATA-7, max UDMA/133, 490234752 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_nv
  Vendor: ATA       Model: WDC WD1600SD-01K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6L250S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 21
GSI 19 sharing vector 0xC9 and IRQ 19
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APSJ] -> GSI 21 (level, high) -> IRQ 201
PCI: Setting latency timer of device 0000:00:0a.0 to 64
ata3: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xE000 irq 201
ata4: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xE008 irq 201
ata3: SATA link down (SStatus 0)
scsi2 : sata_nv
ata4: SATA link down (SStatus 0)
scsi3 : sata_nv
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
GSI 20 sharing vector 0xD1 and IRQ 20
ACPI: PCI Interrupt 0000:02:0c.0[A] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 209
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[209]  MMIO=[f3001000-f30017ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 80 td 96
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
GSI 21 sharing vector 0xD9 and IRQ 21
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 20 (level, high) -> IRQ 217
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
drivers/usb/core/inode.c: creating file 'devices'
drivers/usb/core/inode.c: creating file '001'
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: created debug files
ohci_hcd 0000:00:02.0: irq 217, io mem 0xf6003000
ohci_hcd 0000:00:02.0: resetting from state 'reset', control = 0x600
ohci_hcd 0000:00:02.0: OHCI controller state
ohci_hcd 0000:00:02.0: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:02.0: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:02.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.0: intrstatus 0x00000004 SF
ohci_hcd 0000:00:02.0: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.0: hcca frame #0003
ohci_hcd 0000:00:02.0: roothub.a 01000204 POTPGT=1 NPS NDP=4(4)
ohci_hcd 0000:00:02.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [3] 0x00000100 PPS
usb usb1: default language 0x0409
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.17-rc4-g0c056c50-dirty ohci_hcd
usb usb1: SerialNumber: 0000:00:02.0
usb usb1: uevent
usb usb1: configuration #1 chosen from 1 choice
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: uevent
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: state 7 ports 4 chg 0000 evt 0000
drivers/usb/core/inode.c: creating file '001'
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCG] -> GSI 23 (level, high) -> IRQ 185
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: OHCI Host Controller
drivers/usb/core/inode.c: creating file '002'
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.1: created debug files
ohci_hcd 0000:00:02.1: irq 185, io mem 0xf6004000
ohci_hcd 0000:00:02.1: resetting from state 'reset', control = 0x600
ohci_hcd 0000:00:02.1: OHCI controller state
ohci_hcd 0000:00:02.1: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:02.1: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:02.1: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.1: intrstatus 0x00000044 RHSC SF
ohci_hcd 0000:00:02.1: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.1: hcca frame #0003
ohci_hcd 0000:00:02.1: roothub.a 01000204 POTPGT=1 NPS NDP=4(4)
ohci_hcd 0000:00:02.1: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.1: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.1: roothub.portstatus [0] 0x00010301 CSC LSDA PPS CCS
ohci_hcd 0000:00:02.1: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.1: roothub.portstatus [2] 0x00010101 CSC PPS CCS
ohci_hcd 0000:00:02.1: roothub.portstatus [3] 0x00000100 PPS
usb usb2: default language 0x0409
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.17-rc4-g0c056c50-dirty ohci_hcd
usb usb2: SerialNumber: 0000:00:02.1
usb usb2: uevent
usb usb2: configuration #1 chosen from 1 choice
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: uevent
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
drivers/usb/core/inode.c: creating file '001'
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [0] = 0x00010301 CSC LSDA PPS CCS
hub 2-0:1.0: port 1, status 0301, change 0001, 1.5 Mb/s
ohci_hcd 0000:00:02.0: suspend root hub
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x301
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [0] = 0x00100303 PRSC LSDA PPS PES CCS
usb 2-1: new low speed USB device using ohci_hcd and address 2
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [0] = 0x00100303 PRSC LSDA PPS PES CCS
usb 2-1: skipped 1 descriptor after interface
usb 2-1: default language 0x0409
usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-1: Product: USB-PS/2 Optical Mouse
usb 2-1: Manufacturer: Logitech
usb 2-1: uevent
usb 2-1: configuration #1 chosen from 1 choice
usb 2-1: adding 2-1:1.0 (config #1, interface 0)
usb 2-1:1.0: uevent
drivers/usb/core/inode.c: creating file '002'
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00010101 CSC PPS CCS
hub 2-0:1.0: port 3, status 0101, change 0001, 12 Mb/s
hub 2-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x101
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00100103 PRSC PPS PES CCS
usb 2-3: new full speed USB device using ohci_hcd and address 3
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00100103 PRSC PPS PES CCS
usb 2-3: ep0 maxpacket = 8
usb 2-3: default language 0x0409
usb 2-3: new device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-3: Product: USB Printer
usb 2-3: Manufacturer: EPSON
usb 2-3: SerialNumber: L41019901181352300
usb 2-3: uevent
usb 2-3: configuration #1 chosen from 1 choice
usb 2-3: adding 2-3:1.0 (config #1, interface 0)
usb 2-3:1.0: uevent
drivers/usb/core/inode.c: creating file '003'
hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0002
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbhid 2-1:1.0: usb_probe_interface
usbhid 2-1:1.0: usb_probe_interface - got id
input: Logitech USB-PS/2 Optical Mouse as /class/input/input0
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:02.1-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input1
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0010dc00006c260b]
input: AT Translated Set 2 keyboard as /class/input/input2
i2c /dev entries driver
EDAC MC: Ver: 2.0.0 May 17 2006
Advanced Linux Sound Architecture Driver Version 1.0.11rc4 (Wed Mar 22 10:27:24 2006 UTC).
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [APCJ] -> GSI 22 (level, high) -> IRQ 193
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 50623 usecs
intel8x0: clocking to 46879
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
GSI 22 sharing vector 0xE1 and IRQ 22
ACPI: PCI Interrupt 0000:02:0a.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 225
ALSA device list:
  #0: NVidia CK8S with ALC850 at 0xf6001000, irq 193
  #1: SBLive! Value [CT4670] (rev.5, serial:0x201102) at 0x9000, irq 225
u32 classifier
    Actions configured 
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 280 bytes per conntrack
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.60.2)
powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
powernow-k8:    1 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
cpu_init done, current fid 0xa, vid 0x6
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
ReiserFS: sda2: found reiserfs format "3.6" with standard journal
ReiserFS: sda2: using ordered data mode
ReiserFS: sda2: journal params: device sda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda2: checking transaction log (sda2)
ReiserFS: sda2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 172k freed
usb 2-3:1.0: uevent
usb 2-3: uevent
usb 2-1:1.0: uevent
usb 2-1: uevent
usb 2-0:1.0: uevent
usb usb2: uevent
usb 1-0:1.0: uevent
usb usb1: uevent
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
ehci_hcd: block sizes: qh 160 qtd 96 itd 192 sitd 96
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [APCL] -> GSI 21 (level, high) -> IRQ 201
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: EHCI Host Controller
drivers/usb/core/inode.c: creating file '003'
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:02.2: reset hcs_params 0x102488 dbg=1 cc=2 pcc=4 !ppc ports=8
ehci_hcd 0000:00:02.2: reset portroute 0 0 1 1 1 0 1 0 
ehci_hcd 0000:00:02.2: reset hcc_params a082 caching frame 256/512/1024
ehci_hcd 0000:00:02.2: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: supports USB remote wakeup
ehci_hcd 0000:00:02.2: irq 201, io mem 0xf6005000
ehci_hcd 0000:00:02.2: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
ehci_hcd 0000:00:02.2: init command 010009 (park)=0 ithresh=1 period=256 RUN
ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb3: default language 0x0409
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: EHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.17-rc4-g0c056c50-dirty ehci_hcd
usb usb3: SerialNumber: 0000:00:02.2
usb usb3: uevent
usb usb3: configuration #1 chosen from 1 choice
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: uevent
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 8 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: individual port over-current protection
hub 3-0:1.0: Single TT
hub 3-0:1.0: TT requires at most 8 FS bit times (666 ns)
hub 3-0:1.0: power on to power good time: 20ms
hub 3-0:1.0: local power source is good
usblp 2-3:1.0: usb_probe_interface
usblp 2-3:1.0: usb_probe_interface - got id
ohci_hcd 0000:00:02.1: urb ffff81007ee24b00 path 3 ep0out 5ec20000 cc 5 --> status -110
drivers/usb/class/usblp.c: can't set desired altsetting 0 on interface 0
usblp: probe of 2-3:1.0 failed with error -5
hub 2-0:1.0: state 7 ports 4 chg 0000 evt 000a
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [0] = 0x00030300 PESC CSC LSDA PPS
hub 2-0:1.0: port 1, status 0300, change 0003, 1.5 Mb/s
usb 2-1: USB disconnect, address 2
usb 2-1: usb_disable_device nuking all URBs
usb 2-1: unregistering interface 2-1:1.0
usb 2-1:1.0: uevent
usb 2-1: unregistering device
usb 2-1: uevent
drivers/usb/core/inode.c: creating file '001'
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x300
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00030100 PESC CSC PPS
hub 2-0:1.0: port 3, status 0100, change 0003, 12 Mb/s
usb 2-3: USB disconnect, address 3
usb 2-3: usb_disable_device nuking all URBs
usb 2-3: unregistering interface 2-3:1.0
usb 2-3:1.0: uevent
usb 2-3: unregistering device
usb 2-3: uevent
cx2388x dvb driver version 0.0.5 loaded
CORE cx88[0]: subsystem: 7063:3000, board: pcHDTV HD3000 HDTV [card=22,autodetected]
TV tuner 52 at 0x1fe, Radio tuner -1 at 0x1fe
cx2388x v4l2 driver version 0.0.5 loaded
hub 2-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x100
hub 3-0:1.0: state 7 ports 8 chg 0000 evt 0000
ehci_hcd 0000:00:02.2: GetStatus port 3 status 001403 POWER sig=k CSC CONNECT
hub 3-0:1.0: port 3, status 0501, change 0001, 480 Mb/s
ohci_hcd 0000:00:02.1: suspend root hub
hub 3-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:02.2: port 3 low speed --> companion
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
GSI 23 sharing vector 0xE9 and IRQ 23
ACPI: PCI Interrupt 0000:02:08.2[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 233
cx88[0]/2: found at 0000:02:08.2, rev: 5, irq: 233, latency: 32, mmio: 0xf1000000
cx88[0]/2: cx2388x based dvb card
DVB: registering new adapter (cx88[0]).
DVB: registering frontend 0 (Oren OR51132 VSB/QAM Frontend)...
ACPI: PCI Interrupt 0000:02:08.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 233
cx88[0]/0: found at 0000:02:08.0, rev: 5, irq: 233, latency: 32, mmio: 0xf0000000
ehci_hcd 0000:00:02.2: GetStatus port 3 status 003402 POWER OWNER sig=k CSC
ehci_hcd 0000:00:02.2: GetStatus port 6 status 001803 POWER sig=j CSC CONNECT
hub 3-0:1.0: port 6, status 0501, change 0001, 480 Mb/s
tuner 2-0061: chip found @ 0xc2 (cx88[0])
tuner 2-0061: type set to 52 (Thomson DTT 7610 (ATSC/NTSC))
tda9887 2-0043: chip found @ 0x86 (cx88[0])
cx88[0]/0: registered device video0 [v4l2]
cx88[0]/0: registered device vbi0
cx88[0]/0: registered device radio0
cx2388x blackbird driver version 0.0.5 loaded
hub 3-0:1.0: debounce: port 6: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:02.2: port 6 full speed --> companion
ehci_hcd 0000:00:02.2: GetStatus port 6 status 003001 POWER OWNER sig=se0 CONNECT
hub 3-0:1.0: state 7 ports 8 chg 0000 evt 0000
hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000, resume root
ohci_hcd 0000:00:02.1: wakeup
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [0] = 0x00010301 CSC LSDA PPS CCS
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00010101 CSC PPS CCS
hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [0] = 0x00010301 CSC LSDA PPS CCS
hub 2-0:1.0: port 1, status 0301, change 0001, 1.5 Mb/s
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x301
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [0] = 0x00100303 PRSC LSDA PPS PES CCS
usb 2-1: new low speed USB device using ohci_hcd and address 4
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [0] = 0x00100303 PRSC LSDA PPS PES CCS
usb 2-1: skipped 1 descriptor after interface
usb 2-1: default language 0x0409
usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-1: Product: USB-PS/2 Optical Mouse
usb 2-1: Manufacturer: Logitech
usb 2-1: uevent
usb 2-1: configuration #1 chosen from 1 choice
usb 2-1: adding 2-1:1.0 (config #1, interface 0)
usb 2-1:1.0: uevent
usbhid 2-1:1.0: usb_probe_interface
usbhid 2-1:1.0: usb_probe_interface - got id
input: Logitech USB-PS/2 Optical Mouse as /class/input/input3
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:02.1-1
drivers/usb/core/inode.c: creating file '004'
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00010101 CSC PPS CCS
hub 2-0:1.0: port 3, status 0101, change 0001, 12 Mb/s
hub 2-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x101
Adding 979956k swap on /dev/sda1.  Priority:-1 extents:1 across:979956k
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00100103 PRSC PPS PES CCS
usb 2-3: new full speed USB device using ohci_hcd and address 5
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00100103 PRSC PPS PES CCS
usb 2-3: ep0 maxpacket = 8
usb 2-3: default language 0x0409
usb 2-3: new device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-3: Product: USB Printer
usb 2-3: Manufacturer: EPSON
usb 2-3: SerialNumber: L41019901181352300
usb 2-3: uevent
usb 2-3: configuration #1 chosen from 1 choice
usb 2-3: adding 2-3:1.0 (config #1, interface 0)
usb 2-3:1.0: uevent
usblp 2-3:1.0: usb_probe_interface
usblp 2-3:1.0: usb_probe_interface - got id
drivers/usb/core/file.c: looking for a minor, starting at 0
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 5 if 0 alt 0 proto 2 vid 0x04B8 pid 0x0005
drivers/usb/core/inode.c: creating file '005'
hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0002
w83627hf 9191-0290: Reading VID from GPIO5
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
ReiserFS: sda3: found reiserfs format "3.6" with standard journal
ReiserFS: sda3: using ordered data mode
ReiserFS: sda3: journal params: device sda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda3: checking transaction log (sda3)
ReiserFS: sda3: Using r5 hash to sort names
ReiserFS: sdb1: found reiserfs format "3.6" with standard journal
ReiserFS: sdb1: using ordered data mode
ReiserFS: sdb1: journal params: device sdb1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdb1: checking transaction log (sdb1)
ReiserFS: sdb1: Using r5 hash to sort names
ip_conntrack_pptp version 3.1 loaded
ip_nat_pptp version 3.0 loaded
eth0: no IPv6 routers present
hub 3-0:1.0: state 7 ports 8 chg 0000 evt 0010
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001803 POWER sig=j CSC CONNECT
hub 3-0:1.0: port 4, status 0501, change 0001, 480 Mb/s
hub 3-0:1.0: debounce: port 4: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=se0 PE CONNECT
usb 3-4: new high speed USB device using ehci_hcd and address 4
ehci_hcd 0000:00:02.2: port 4 high speed
ehci_hcd 0000:00:02.2: GetStatus port 4 status 001005 POWER sig=se0 PE CONNECT
usb 3-4: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 3-4: uevent
usb 3-4: configuration #1 chosen from 1 choice
usb 3-4: adding 3-4:1.0 (config #1, interface 0)
usb 3-4:1.0: uevent
hub 3-4:1.0: usb_probe_interface
hub 3-4:1.0: usb_probe_interface - got id
hub 3-4:1.0: USB hub found
hub 3-4:1.0: 4 ports detected
hub 3-4:1.0: standalone hub
hub 3-4:1.0: individual port power switching
hub 3-4:1.0: individual port over-current protection
hub 3-4:1.0: TT per port
hub 3-4:1.0: TT requires at most 8 FS bit times (666 ns)
hub 3-4:1.0: Port indicators are supported
hub 3-4:1.0: power on to power good time: 100ms
hub 3-4:1.0: local power source is good
hub 3-4:1.0: enabling power on all ports
usb 3-4: link qh256-0001/ffff81007e665140 start 255 [1/0 us]
drivers/usb/core/inode.c: creating file '004'
hub 3-4:1.0: state 7 ports 4 chg 0000 evt 0000
hub 3-4:1.0: state 7 ports 4 chg 0000 evt 0008
hub 3-4:1.0: port 3, status 0101, change 0001, 12 Mb/s
hub 3-4:1.0: debounce: port 3: total 100ms stable 100ms status 0x101
hub 3-4:1.0: port 3 not reset yet, waiting 10ms
usb 3-4.3: new high speed USB device using ehci_hcd and address 5
hub 3-4:1.0: port 3 not reset yet, waiting 10ms
usb 3-4.3: default language 0x0409
usb 3-4.3: new device strings: Mfr=1, Product=2, SerialNumber=3
usb 3-4.3: Product: iPod
usb 3-4.3: Manufacturer: Apple
usb 3-4.3: SerialNumber: 000A2700129D2D99
usb 3-4.3: uevent
usb 3-4.3: configuration #1 chosen from 1 choice
usb 3-4.3: adding 3-4.3:1.0 (config #1, interface 0)
usb 3-4.3:1.0: uevent
libusual 3-4.3:1.0: usb_probe_interface
libusual 3-4.3:1.0: usb_probe_interface - got id
drivers/usb/core/inode.c: creating file '005'
Initializing USB Mass Storage driver...
usb-storage 3-4.3:1.0: usb_probe_interface
usb-storage 3-4.3:1.0: usb_probe_interface - got id
scsi4 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 5
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
  Vendor: Apple     Model: iPod              Rev: 1.62
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdc: 3999743 512-byte hdwr sectors (2048 MB)
sdc: Write Protect is off
sdc: Mode Sense: 68 00 00 08
sdc: assuming drive cache: write through
SCSI device sdc: 3999743 512-byte hdwr sectors (2048 MB)
sdc: Write Protect is off
sdc: Mode Sense: 68 00 00 08
sdc: assuming drive cache: write through
 sdc: sdc1 sdc2
sd 4:0:0:0: Attached scsi removable disk sdc
usb-storage: device scan complete
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
[drm] Setting GART location based on new memory map
[drm] Loading R200 Microcode
[drm] writeback test succeeded in 1 usecs


------=_Part_121544_8604487.1148148193121--
