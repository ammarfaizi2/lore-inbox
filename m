Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966656AbWKYQcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966656AbWKYQcE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 11:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966654AbWKYQcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 11:32:03 -0500
Received: from bizon.gios.gov.pl ([212.244.124.8]:23239 "EHLO
	bizon.gios.gov.pl") by vger.kernel.org with ESMTP id S966641AbWKYQcA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 11:32:00 -0500
Date: Sat, 25 Nov 2006 17:31:53 +0100 (CET)
From: Krzysztof Oledzki <olel@ans.pl>
X-X-Sender: olel@bizon.gios.gov.pl
To: Alan <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: pata_via in 2.6.19-rc6: UDMA/66 hdd downgraded to UDMA/33
In-Reply-To: <20061125160342.4e9ddef0@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0611251718210.2557@bizon.gios.gov.pl>
References: <Pine.LNX.4.64.0611250216550.26262@bizon.gios.gov.pl>
 <20061125160342.4e9ddef0@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-32982785-1164472313=:2557"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-32982785-1164472313=:2557
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Sat, 25 Nov 2006, Alan wrote:

>> ata1.00: ATA-5, max UDMA/66, 40031712 sectors: LBA
>> ata1.00: ata1: dev 0 multi count 16
>> ata1.00: configured for UDMA/33
>
> Looks like a cable detect error.

Oh, indeed. Forcing ATA_CBL_PATA80 brings back expected UDMA66 speed.

>> scsi1 : pata_via
>> ata2: port is slow to respond, please be patient (Status 0xff)
>> ata2: port failed to respond (30 secs, Status 0xff)
>> ata2: SRST failed (status 0xFF)
>> ata2: SRST failed (err_mask=3D0x100)
>> ata2: softreset failed, retrying in 5 secs
>> ata2: SRST failed (status 0xFF)
>> ata2: SRST failed (err_mask=3D0x100)
>> ata2: softreset failed, retrying in 5 secs
>> ata2: SRST failed (status 0xFF)
>
> This is a known bug in the libata core at the moment
OK.

>> BTW: is it possible to do something with this annoying long delay with
>> the "port is slow to respond, please be patient" message? :)
>
> No, but it does appear to be a bug. Can you send me an lspci -vvxxx

00:00.0 Host bridge: VIA Technologies, Inc. VT8605 [ProSavage PM133] (rev 0=
1)
 =09Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B-
 =09Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort+ >SERR- <PERR+
 =09Latency: 0
 =09Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D64M]
 =09Capabilities: [a0] AGP version 2.0
 =09=09Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- =
64bit- FW- AGP3- Rate=3Dx1,x2,x4
 =09=09Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- FW- Rate=
=3D<none>
 =09Capabilities: [c0] Power Management version 2
 =09=09Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,=
D3cold-)
 =09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 06 11 05 06 06 00 10 a2 01 00 00 06 00 00 00 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: fd d8 c8 b6 05 00 18 18 08 80 00 00 08 10 14 18
60: 3c 0a c0 20 d5 e6 e6 00 43 38 86 2d 08 2f 00 00
70: c0 88 cc 0c 0e a1 d2 00 01 f4 09 02 00 00 00 08
80: 0f 40 00 00 c0 00 00 00 02 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 02 c0 20 00 07 02 00 1f 00 00 00 00 6b 02 04 00
b0: 7f ff 12 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 0a 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 22 42 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc. VT8605 [PM133 AGP] (prog-if 00 [=
Normal decode])
 =09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B-
 =09Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort+ >SERR- <PERR-
 =09Latency: 0
 =09Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
 =09I/O behind bridge: 00009000-00009fff
 =09Memory behind bridge: dee00000-dfefffff
 =09Prefetchable memory behind bridge: dcc00000-decfffff
 =09Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- <SERR- <PERR-
 =09BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
 =09Capabilities: [80] Power Management version 2
 =09=09Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,=
D3cold-)
 =09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 06 11 05 86 07 00 30 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 90 90 00 00
20: e0 de e0 df c0 dc c0 de 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 08 00
40: 48 cd 00 44 04 72 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 02 02 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (r=
ev 22)
 =09Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
 =09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping+ SERR- FastB2B-
 =09Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
 =09Latency: 0
00: 06 11 86 06 87 00 10 02 22 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 86 06
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 08 00 00 00 00 80 60 e6 01 00 c4 00 00 00 00 f3
50: 0e 06 34 00 00 00 a0 90 00 06 ff 08 50 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 05 30 00 02 00 00 04 08 00 00 00 00
80: 10 00 00 00 00 09 00 00 00 00 00 02 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT82=
3x/A/C PIPC Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
 =09Subsystem: GVC/BCM Advanced Research Unknown device 2129
 =09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B-
 =09Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
 =09Latency: 32
 =09Region 4: I/O ports at ffa0 [size=3D16]
 =09Capabilities: [c0] Power Management version 2
 =09=09Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,=
D3cold-)
 =09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 06 11 71 05 07 00 90 02 10 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 ff 00 00 00 00 00 00 00 00 00 00 a4 14 29 21
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 00 00
40: 03 f2 08 3a 0c 1f c0 00 a8 a8 a8 20 7f 00 ff 20
50: 0b 03 0b e2 14 00 00 00 a8 a8 a8 a8 00 00 00 00
60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
70: 02 01 00 00 00 00 00 00 82 01 00 00 00 00 00 00
80: 00 d0 3f 01 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 10 00 71 05 a4 14 29 21 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Contr=
oller (rev 10) (prog-if 00 [UHCI])
 =09Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
 =09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Ste=
pping- SERR+ FastB2B-
 =09Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
 =09Latency: 64, Cache Line Size: 32 bytes
 =09Interrupt: pin D routed to IRQ 9
 =09Region 4: I/O ports at cc00 [size=3D32]
 =09Capabilities: [80] Power Management version 2
 =09=09Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,=
D3cold-)
 =09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 06 11 38 30 17 01 10 02 10 00 03 0c 08 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 cc 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 09 04 00 00
40: 00 10 03 00 c6 00 30 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Contr=
oller (rev 10) (prog-if 00 [UHCI])
 =09Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
 =09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Ste=
pping- SERR+ FastB2B-
 =09Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
 =09Latency: 64, Cache Line Size: 32 bytes
 =09Interrupt: pin D routed to IRQ 9
 =09Region 4: I/O ports at d000 [size=3D32]
 =09Capabilities: [80] Power Management version 2
 =09=09Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,=
D3cold-)
 =09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 06 11 38 30 17 01 10 02 10 00 03 0c 08 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d0 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 09 04 00 00
40: 00 10 03 00 c2 00 20 c0 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
 =09Subsystem: GVC/BCM Advanced Research Unknown device 2129
 =09Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B-
 =09Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
 =09Interrupt: pin ? routed to IRQ 7
 =09Capabilities: [68] Power Management version 2
 =09=09Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,=
D3cold-)
 =09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 06 11 57 30 00 00 90 02 30 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 a4 14 29 21
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 00 00
40: 20 84 57 00 5a 10 00 00 01 08 00 00 00 18 00 00
50: 00 df fe 00 10 00 00 00 00 ff fe 00 a4 14 29 21
60: 00 00 00 00 00 00 00 00 01 00 02 00 00 00 00 00
70: 01 0c 00 00 01 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 01 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 A=
udio Controller (rev 20)
 =09Subsystem: GVC/BCM Advanced Research Unknown device 2129
 =09Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B-
 =09Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
 =09Interrupt: pin C routed to IRQ 10
 =09Region 0: I/O ports at dc00 [size=3D256]
 =09Region 1: I/O ports at d800 [size=3D4]
 =09Region 2: I/O ports at d400 [size=3D4]
 =09Capabilities: [c0] Power Management version 2
 =09=09Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,=
D3cold-)
 =09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 06 11 58 30 01 00 10 02 20 00 01 04 00 00 00 00
10: 01 dc 00 00 01 d8 00 00 01 d4 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 a4 14 29 21
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0a 03 00 00
40: 01 c9 4b 1c 00 00 00 00 00 00 00 02 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:12.0 Ethernet controller: Intel Corporation 82546EB Gigabit Ethernet Con=
troller (Copper) (rev 01)
 =09Subsystem: Intel Corporation PRO/1000 MT Dual Port Server Adapter
 =09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Ste=
pping- SERR+ FastB2B-
 =09Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
 =09Latency: 64 (63750ns min), Cache Line Size: 32 bytes
 =09Interrupt: pin A routed to IRQ 10
 =09Region 0: Memory at dffc0000 (64-bit, non-prefetchable) [size=3D128K]
 =09Region 4: I/O ports at c400 [size=3D64]
 =09Capabilities: [dc] Power Management version 2
 =09=09Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,=
D3cold+)
 =09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
 =09Capabilities: [e4] PCI-X non-bridge device
 =09=09Command: DPERE- ERO+ RBC=3D512 OST=3D1
 =09=09Status: Dev=3D00:00.0 64bit+ 133MHz+ SCD- USC- DC=3Dsimple DMMRBC=3D=
2048 DMOST=3D1 DMCRS=3D16 RSCEM- 266MHz- 533MHz-
 =09Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=3D0/0 Ena=
ble-
 =09=09Address: 0000000000000000  Data: 0000
00: 86 80 10 10 17 01 30 02 01 00 00 02 08 40 80 00
10: 04 00 fc df 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 c4 00 00 00 00 00 00 00 00 00 00 86 80 12 10
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 ff 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 e4 22 c8
e0: 00 20 00 28 07 f0 02 00 00 00 43 04 00 00 00 00
f0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00

00:12.1 Ethernet controller: Intel Corporation 82546EB Gigabit Ethernet Con=
troller (Copper) (rev 01)
 =09Subsystem: Intel Corporation PRO/1000 MT Dual Port Server Adapter
 =09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Ste=
pping- SERR+ FastB2B-
 =09Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
 =09Latency: 64 (63750ns min), Cache Line Size: 32 bytes
 =09Interrupt: pin B routed to IRQ 9
 =09Region 0: Memory at dffe0000 (64-bit, non-prefetchable) [size=3D128K]
 =09Region 4: I/O ports at c800 [size=3D64]
 =09Capabilities: [dc] Power Management version 2
 =09=09Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,=
D3cold+)
 =09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
 =09Capabilities: [e4] PCI-X non-bridge device
 =09=09Command: DPERE- ERO+ RBC=3D512 OST=3D1
 =09=09Status: Dev=3D00:00.1 64bit+ 133MHz+ SCD- USC- DC=3Dsimple DMMRBC=3D=
2048 DMOST=3D1 DMCRS=3D16 RSCEM- 266MHz- 533MHz-
 =09Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=3D0/0 Ena=
ble-
 =09=09Address: 0000000000000000  Data: 0000
00: 86 80 10 10 17 01 30 02 01 00 00 02 08 40 80 00
10: 04 00 fe df 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 c8 00 00 00 00 00 00 00 00 00 00 86 80 12 10
30: 00 00 00 00 dc 00 00 00 00 00 00 00 09 02 ff 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 e4 22 c8
e0: 00 20 00 28 07 f0 02 00 01 00 43 04 00 00 00 00
f0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev =
03) (prog-if 00 [VGA])
 =09Subsystem: Matrox Graphics, Inc. Millennium G200 AGP
 =09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B-
 =09Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
 =09Latency: 64 (4000ns min, 8000ns max), Cache Line Size: 32 bytes
 =09Interrupt: pin A routed to IRQ 11
 =09Region 0: Memory at dd000000 (32-bit, prefetchable) [size=3D16M]
 =09Region 1: Memory at dfefc000 (32-bit, non-prefetchable) [size=3D16K]
 =09Region 2: Memory at df000000 (32-bit, non-prefetchable) [size=3D8M]
 =09Expansion ROM at dfee0000 [disabled] [size=3D64K]
 =09Capabilities: [dc] Power Management version 1
 =09=09Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,=
D3cold-)
 =09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
 =09Capabilities: [f0] AGP version 1.0
 =09=09Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- =
64bit- FW- AGP3- Rate=3Dx1,x2
 =09=09Command: RQ=3D32 ArqSz=3D0 Cal=3D0 SBA+ AGP+ GART64- 64bit- FW- Rate=
=3Dx2
00: 2b 10 21 05 07 00 90 02 03 00 00 03 08 40 00 00
10: 08 00 00 dd 00 c0 ef df 00 00 00 df 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 03 ff
30: 00 00 ee df dc 00 00 00 00 00 00 00 0b 01 10 20
40: 21 95 07 40 08 3c 00 00 00 00 4f 00 00 00 00 00
50: 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 f0 21 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 02 00 10 00 03 02 00 1f 02 03 00 1f 00 00 00 00


Best regards,


 =09=09=09=09Krzysztof Ol=EAdzki
---187430788-32982785-1164472313=:2557--
