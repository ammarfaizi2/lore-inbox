Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287872AbSAUTBC>; Mon, 21 Jan 2002 14:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287894AbSAUTAx>; Mon, 21 Jan 2002 14:00:53 -0500
Received: from p15.dynadsl.ifb.co.uk ([194.105.168.15]:51937 "HELO smeg")
	by vger.kernel.org with SMTP id <S287872AbSAUTAi>;
	Mon, 21 Jan 2002 14:00:38 -0500
From: "Lee Packham" <linux@mswinxp.net>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        "'Kai Germaschewski'" <kai@tp1.ruhr-uni-bochum.de>
Cc: "'Linus Torvalds'" <torvalds@transmeta.com>,
        "'Dave Jones'" <davej@suse.de>,
        "'Jes Sorensen'" <jes@wildopensource.com>,
        <linux-kernel@vger.kernel.org>,
        "'Marcelo Tosatti'" <marcelo@conectiva.com.br>
Subject: RE: [patch] VAIO irq assignment fix
Date: Mon, 21 Jan 2002 19:00:47 -0000
Message-ID: <000c01c1a2ad$efc5bcc0$8119fea9@lee>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000D_01C1A2AD.EFC5BCC0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <E16RMy8-0005UN-00@the-village.bc.nu>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_000D_01C1A2AD.EFC5BCC0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Now... I have a Sony Vaio FX-103 with the RICOH RL5C476 not the 75. The
laptop has 192 MB of RAM (not the standard 64) and a 10gb harddisk.
Mandrake 8.1 with a 2.4.16 kernel with a USB PCI IRQ Routing patch to
make USB work (yes I am waiting heavily for the ACPI stuff!).

Anyhow, no matter what I do (including your patch modified to work on
the different controller) I cannot get two cards to work inside this
laptop.

One is a wireless card, one is a compact flash converter thing (for the
camera).

Both cards work individually. The laptop locks up if I insert both
cards. There is no OOPS or anything... It just locks up. Removing the
cards does not spring it back to life.

It is probably down to the fact that the Vaio laptops assign everything
IRQ9. Please find attached my /proc/interrupts and lspci -vvv.

Any ideas?

Thanks

Lee P.



-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Alan Cox
Sent: 18 January 2002 00:33
To: Kai Germaschewski
Cc: Linus Torvalds; Dave Jones; Jes Sorensen; Alan Cox;
linux-kernel@vger.kernel.org; Marcelo Tosatti
Subject: Re: [patch] VAIO irq assignment fix

> Unfortunately, the PCI interrupt routing stuff in ACPI is not in a
static 
> table, but needs the full-blown AML interpreter. Bad, but we can't do 
> anything about it.

Is that true of the MPS table as well ? Can you deduce one from the
other
even if you dont have a usable APIC ?

> It would be nicer to dynamically add the table, e.g. have the
bootloader
> load it, kind of like the initrd, but that seems not possible without
a
> lot of effort. (Or is the initrd protocol flexible enough to allow for

> this?)

It may not be enough. The AML can be doing register setup and
configuration.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

------=_NextPart_000_000D_01C1A2AD.EFC5BCC0
Content-Type: application/octet-stream;
	name="lspci"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="lspci"

00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and =
Memory Controller Hub (rev 11)=0A=
	Subsystem: Sony Corporation: Unknown device 80df=0A=
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort+ >SERR- <PERR-=0A=
	Latency: 0=0A=
	Capabilities: [88] #09 [f205]=0A=
=0A=
00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset =
Graphics Controller] (rev 11) (prog-if 00 [VGA])=0A=
	Subsystem: Sony Corporation: Unknown device 80df=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
	Interrupt: pin A routed to IRQ 9=0A=
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=3D64M]=0A=
	Region 1: Memory at f4000000 (32-bit, non-prefetchable) [size=3D512K]=0A=
	Capabilities: [dc] Power Management version 2=0A=
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
=0A=
00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (-M) =
(rev 03) (prog-if 00 [Normal decode])=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D64=0A=
	I/O behind bridge: 00003000-00003fff=0A=
	Memory behind bridge: f4100000-f41fffff=0A=
	Prefetchable memory behind bridge: fff00000-000fffff=0A=
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-=0A=
=0A=
00:1f.0 ISA bridge: Intel Corp. 82820 820 (Camino 2) Chipset ISA Bridge =
(ICH2-M) (rev 03)=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
=0A=
00:1f.1 IDE interface: Intel Corp. 82820 820 (Camino 2) Chipset IDE U100 =
(-M) (rev 03) (prog-if 80 [Master])=0A=
	Subsystem: Sony Corporation: Unknown device 80df=0A=
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
	Region 4: I/O ports at 1800 [size=3D16]=0A=
=0A=
00:1f.2 USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB =
(Hub A) (rev 03) (prog-if 00 [UHCI])=0A=
	Subsystem: Sony Corporation: Unknown device 80df=0A=
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
	Interrupt: pin D routed to IRQ 9=0A=
	Region 4: I/O ports at 1820 [size=3D32]=0A=
=0A=
00:1f.3 SMBus: Intel Corp. 82820 820 (Camino 2) Chipset SMBus (rev 03)=0A=
	Subsystem: Sony Corporation: Unknown device 80df=0A=
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Interrupt: pin B routed to IRQ 9=0A=
	Region 4: I/O ports at 1810 [size=3D16]=0A=
=0A=
00:1f.4 USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB =
(Hub B) (rev 03) (prog-if 00 [UHCI])=0A=
	Subsystem: Sony Corporation: Unknown device 80df=0A=
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
	Interrupt: pin C routed to IRQ 9=0A=
	Region 4: I/O ports at 1840 [size=3D32]=0A=
=0A=
00:1f.5 Multimedia audio controller: Intel Corp. 82820 820 (Camino 2) =
Chipset AC'97 Audio Controller (rev 03)=0A=
	Subsystem: Sony Corporation: Unknown device 80df=0A=
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
	Interrupt: pin B routed to IRQ 9=0A=
	Region 0: I/O ports at 1c00 [size=3D256]=0A=
	Region 1: I/O ports at 1880 [size=3D64]=0A=
=0A=
00:1f.6 Modem: Intel Corp. 82820 820 (Camino 2) Chipset AC'97 Modem =
Controller (rev 03) (prog-if 00 [Generic])=0A=
	Subsystem: Sony Corporation: Unknown device 80df=0A=
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Interrupt: pin B routed to IRQ 9=0A=
	Region 0: I/O ports at 2400 [size=3D256]=0A=
	Region 1: I/O ports at 2000 [size=3D128]=0A=
=0A=
01:00.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8021 =
(rev 02) (prog-if 10 [OHCI])=0A=
	Subsystem: Sony Corporation: Unknown device 80df=0A=
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Interrupt: pin A routed to IRQ 9=0A=
	Region 0: Memory at f4105000 (32-bit, non-prefetchable) [size=3D2K]=0A=
	Region 1: Memory at f4100000 (32-bit, non-prefetchable) [size=3D16K]=0A=
	Capabilities: [44] Power Management version 2=0A=
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=3D0mA =
PME(D0-,D1-,D2+,D3hot+,D3cold-)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
=0A=
01:02.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)=0A=
	Subsystem: Sony Corporation: Unknown device 80df=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 168=0A=
	Interrupt: pin A routed to IRQ 9=0A=
	Region 0: Memory at f4106000 (32-bit, non-prefetchable) [size=3D4K]=0A=
	Bus: primary=3D01, secondary=3D02, subordinate=3D05, sec-latency=3D176=0A=
	Memory window 0: 00000000-00000000 (prefetchable)=0A=
	Memory window 1: 00000000-00000000 (prefetchable)=0A=
	I/O window 0: 00000000-00000003=0A=
	I/O window 1: 00000000-00000003=0A=
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+=0A=
	16-bit legacy interface ports at 0001=0A=
=0A=
01:02.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)=0A=
	Subsystem: Sony Corporation: Unknown device 80df=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 168=0A=
	Interrupt: pin B routed to IRQ 0=0A=
	Region 0: Memory at f4107000 (32-bit, non-prefetchable) [size=3D4K]=0A=
	Bus: primary=3D01, secondary=3D06, subordinate=3D09, sec-latency=3D176=0A=
	Memory window 0: 00000000-00000000 (prefetchable)=0A=
	Memory window 1: 00000000-00000000 (prefetchable)=0A=
	I/O window 0: 00000000-00000003=0A=
	I/O window 1: 00000000-00000003=0A=
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+=0A=
	16-bit legacy interface ports at 0001=0A=
=0A=
01:08.0 Ethernet controller: Intel Corp. 82820 (ICH2) Chipset Ethernet =
Controller (rev 03)=0A=
	Subsystem: Intel Corp.: Unknown device 3013=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 66 (2000ns min, 14000ns max), cache line size 08=0A=
	Interrupt: pin A routed to IRQ 9=0A=
	Region 0: Memory at f4104000 (32-bit, non-prefetchable) [size=3D4K]=0A=
	Region 1: I/O ports at 3000 [size=3D64]=0A=
	Capabilities: [dc] Power Management version 2=0A=
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)=0A=
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-=0A=
=0A=

------=_NextPart_000_000D_01C1A2AD.EFC5BCC0
Content-Type: text/plain;
	name="interrupts.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="interrupts.txt"

           CPU0       =0A=
  0:      33588          XT-PIC  timer=0A=
  1:        335          XT-PIC  keyboard=0A=
  2:          0          XT-PIC  cascade=0A=
  5:          5          XT-PIC  prism2_cs=0A=
  8:          1          XT-PIC  rtc=0A=
  9:       1181          XT-PIC  acpi, usb-uhci, usb-uhci, Intel ICH, =
i810@PCI:0:2:0=0A=
 11:          3          XT-PIC  sonypi=0A=
 12:        676          XT-PIC  PS/2 Mouse=0A=
 14:       5368          XT-PIC  ide0=0A=
 15:          3          XT-PIC  ide1=0A=
NMI:          0 =0A=
ERR:          0=0A=

------=_NextPart_000_000D_01C1A2AD.EFC5BCC0--

