Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWBSS7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWBSS7L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 13:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWBSS7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 13:59:11 -0500
Received: from [85.216.89.88] ([85.216.89.88]:42890 "EHLO afrodita")
	by vger.kernel.org with ESMTP id S932208AbWBSS7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 13:59:09 -0500
From: Ariel Garcia <garcia@iwr.fzk.de>
To: Jens Axboe <axboe@suse.de>
Subject: 2.6.16-rc4 libata + AHCI patched for suspend fails on ICH6
Date: Sun, 19 Feb 2006 19:58:34 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4511336.eqDzZp4EBj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602191958.38219.garcia@iwr.fzk.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4511336.eqDzZp4EBj
Content-Type: multipart/mixed;
  boundary="Boundary-01=_a/L+DiDlXfF73Aa"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_a/L+DiDlXfF73Aa
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jens,

regarding your suspend support patch for libata:

> author  Jens Axboe <axboe@suse.de>
>    Fri, 6 Jan 2006 08:28:07 +0000 (09:28 +0100)
> commit  9b847548663ef1039dd49f0eb4463d001e596bc3

>  [PATCH] Suspend support for libata
>  This patch adds suspend patch to libata, and ata_piix in particular.
> For most low level drivers, they should just need to add the 4 hooks to
> work. As I can only test ata_piix, I didn't enable it for more though.

i tested the trivial "4-hooks" patch on kernel 2.6.16-rc4, on my laptop=20
(i915, ICH6 chipset, sata hd - a Fujitsu-Siemens 7020)
but it doesn't work as it should:
   after resume the drive fails to respond to the commands so it
   ends up remounted read-only.

I am attaching:
   - the trivial patch i used
   - the output of lsmod (lsmod-clean.txt)
   - the output of lspci -vv  before (lspci-clean.txt)=20
        and after resuming (lspci-resume.txt)
   - the output of dmesg (glueing the full boot + resuming messages)

All this was done running in single mode. I also tried suspending after=20
removing all unnecessary modules (usb, snd,ide,...), same result.

BTW, running a    'diff lspci-clean.txt lspci-resume.txt'
i also noticed that after resume some pci devices get a different=20
"BusMaster" polarity, but the SATA controller doesn't.

I would be glad to test patches/debug other things, feel free to ask.

(Please CC me if replying to the ml, i'm not subscribed)

Thanks a lot!!

Ariel Garcia

--Boundary-01=_a/L+DiDlXfF73Aa
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ahci-suspend.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ahci-suspend.patch"

216a217,218
> 	.resume			= ata_scsi_device_resume,
> 	.suspend		= ata_scsi_device_suspend,
301a304,305
> 	.resume			= ata_pci_device_resume,
> 	.suspend		= ata_pci_device_suspend,

--Boundary-01=_a/L+DiDlXfF73Aa
Content-Type: text/plain;
  charset="us-ascii";
  name="lspci-clean.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci-clean.txt"

0000:00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express Processor to DRAM Controller (rev 04)
	Subsystem: Fujitsu Limited.: Unknown device 12d7
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] #09 [2109]

0000:00:02.0 VGA compatible controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics Controller (rev 04) (prog-if 00 [VGA])
	Subsystem: Fujitsu Limited.: Unknown device 12de
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at b0080000 (32-bit, non-prefetchable) [size=512K]
	Region 1: I/O ports at 1400 [size=8]
	Region 2: Memory at c0000000 (32-bit, prefetchable) [size=256M]
	Region 3: Memory at b0040000 (32-bit, non-prefetchable) [size=256K]
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics Controller (rev 04)
	Subsystem: Fujitsu Limited.: Unknown device 12de
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at 52000000 (32-bit, non-prefetchable) [disabled] [size=512K]
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1b.0 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 04)
	Subsystem: Fujitsu Limited.: Unknown device 1326
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 177
	Region 0: Memory at b0000000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] #10 [0091]

0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Memory behind bridge: b0100000-b01fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 40c1
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2 (rev 04) (prog-if 00 [Normal decode])
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Bus: primary=00, secondary=03, subordinate=04, sec-latency=0
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 40c9
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 04) (prog-if 00 [UHCI])
	Subsystem: Fujitsu Limited.: Unknown device 12e8
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 209
	Region 4: I/O ports at 1420 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 04) (prog-if 00 [UHCI])
	Subsystem: Fujitsu Limited.: Unknown device 12e8
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 217
	Region 4: I/O ports at 1440 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 04) (prog-if 00 [UHCI])
	Subsystem: Fujitsu Limited.: Unknown device 12e8
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 225
	Region 4: I/O ports at 1460 [size=32]

0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 04) (prog-if 00 [UHCI])
	Subsystem: Fujitsu Limited.: Unknown device 12e8
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin D routed to IRQ 177
	Region 4: I/O ports at 1480 [size=32]

0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 04) (prog-if 20 [EHCI])
	Subsystem: Fujitsu Limited.: Unknown device 12e9
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 209
	Region 0: Memory at b0004000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=06, subordinate=07, sec-latency=32
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: b0200000-b02fffff
	Prefetchable memory behind bridge: 0000000050000000-0000000051f00000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] #0d [0000]

0000:00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge (rev 04)
	Subsystem: Fujitsu Limited.: Unknown device 12e4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 04) (prog-if 8a [Master SecP PriP])
	Subsystem: Fujitsu Limited.: Unknown device 12e5
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 225
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 1410 [size=16]

0000:00:1f.2 0106: Intel Corporation 82801FBM (ICH6M) SATA Controller (rev 04) (prog-if 01)
	Subsystem: Fujitsu Limited.: Unknown device 12e6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 217
	Region 0: I/O ports at 14b8 [size=8]
	Region 1: I/O ports at 140c [size=4]
	Region 2: I/O ports at 14b0 [size=8]
	Region 3: I/O ports at 1408 [size=4]
	Region 4: I/O ports at 14a0 [size=16]
	Region 5: Memory at b0004400 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 04)
	Subsystem: Fujitsu Limited.: Unknown device 12e7
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at 14c0 [size=32]

0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751M Gigabit Ethernet PCI Express (rev 21)
	Subsystem: Fujitsu Limited.: Unknown device 1300
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 177
	Region 0: Memory at b0100000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: 06061068cc09b100  Data: 1c20
	Capabilities: [d0] #10 [0001]

0000:06:03.0 CardBus bridge: O2 Micro, Inc. OZ711MP1/MS1 MemoryCardBus Controller (rev 20)
	Subsystem: Fujitsu Limited.: Unknown device 131e
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 177
	Region 0: Memory at b0206000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=06, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 50000000-51fff000 (prefetchable)
	Memory window 1: 54000000-55fff000
	I/O window 0: 00002000-000020ff
	I/O window 1: 00002400-000024ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:06:05.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 05)
	Subsystem: Intel Corporation: Unknown device 2702
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 225
	Region 0: Memory at b0204000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-

0000:06:06.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Fujitsu Limited.: Unknown device 1162
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at b0205000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at b0200000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--Boundary-01=_a/L+DiDlXfF73Aa
Content-Type: text/plain;
  charset="us-ascii";
  name="lspci-resume.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci-resume.txt"

0000:00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express Processor to DRAM Controller (rev 04)
	Subsystem: Fujitsu Limited.: Unknown device 12d7
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] #09 [2109]

0000:00:02.0 VGA compatible controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics Controller (rev 04) (prog-if 00 [VGA])
	Subsystem: Fujitsu Limited.: Unknown device 12de
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at b0080000 (32-bit, non-prefetchable) [size=512K]
	Region 1: I/O ports at 1400 [size=8]
	Region 2: Memory at c0000000 (32-bit, prefetchable) [size=256M]
	Region 3: Memory at b0040000 (32-bit, non-prefetchable) [size=256K]
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics Controller (rev 04)
	Subsystem: Fujitsu Limited.: Unknown device 12de
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at 52000000 (32-bit, non-prefetchable) [disabled] [size=512K]
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1b.0 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 04)
	Subsystem: Fujitsu Limited.: Unknown device 1326
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 177
	Region 0: Memory at b0000000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] #10 [0091]

0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Memory behind bridge: b0100000-b01fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 40c1
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2 (rev 04) (prog-if 00 [Normal decode])
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Bus: primary=00, secondary=03, subordinate=04, sec-latency=0
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 40c9
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 04) (prog-if 00 [UHCI])
	Subsystem: Fujitsu Limited.: Unknown device 12e8
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 209
	Region 4: I/O ports at 1420 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 04) (prog-if 00 [UHCI])
	Subsystem: Fujitsu Limited.: Unknown device 12e8
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 217
	Region 4: I/O ports at 1440 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 04) (prog-if 00 [UHCI])
	Subsystem: Fujitsu Limited.: Unknown device 12e8
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 225
	Region 4: I/O ports at 1460 [size=32]

0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 04) (prog-if 00 [UHCI])
	Subsystem: Fujitsu Limited.: Unknown device 12e8
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 177
	Region 4: I/O ports at 1480 [size=32]

0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 04) (prog-if 20 [EHCI])
	Subsystem: Fujitsu Limited.: Unknown device 12e9
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 209
	Region 0: Memory at b0004000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=06, subordinate=07, sec-latency=32
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: b0200000-b02fffff
	Prefetchable memory behind bridge: 0000000050000000-0000000051f00000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] #0d [0000]

0000:00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge (rev 04)
	Subsystem: Fujitsu Limited.: Unknown device 12e4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 04) (prog-if 8a [Master SecP PriP])
	Subsystem: Fujitsu Limited.: Unknown device 12e5
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 225
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 1410 [size=16]

0000:00:1f.2 0106: Intel Corporation 82801FBM (ICH6M) SATA Controller (rev 04) (prog-if 01)
	Subsystem: Fujitsu Limited.: Unknown device 12e6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 217
	Region 0: I/O ports at 14b8 [size=8]
	Region 1: I/O ports at 140c [size=4]
	Region 2: I/O ports at 14b0 [size=8]
	Region 3: I/O ports at 1408 [size=4]
	Region 4: I/O ports at 14a0 [size=16]
	Region 5: Memory at b0004400 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 04)
	Subsystem: Fujitsu Limited.: Unknown device 12e7
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at 14c0 [size=32]

0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751M Gigabit Ethernet PCI Express (rev 21)
	Subsystem: Fujitsu Limited.: Unknown device 1300
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 177
	Region 0: Memory at b0100000 (64-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: 06061068cc09b100  Data: 1c20
	Capabilities: [d0] #10 [0001]

0000:06:03.0 CardBus bridge: O2 Micro, Inc. OZ711MP1/MS1 MemoryCardBus Controller (rev 20)
	Subsystem: Fujitsu Limited.: Unknown device 131e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 177
	Region 0: Memory at b0206000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=06, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 50000000-51fff000 (prefetchable)
	Memory window 1: 54000000-55fff000
	I/O window 0: 00002000-000020ff
	I/O window 1: 00002400-000024ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:06:05.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 05)
	Subsystem: Intel Corporation: Unknown device 2702
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 6000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 225
	Region 0: Memory at b0204000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-

0000:06:06.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Fujitsu Limited.: Unknown device 1162
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at b0205000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at b0200000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--Boundary-01=_a/L+DiDlXfF73Aa
Content-Type: text/plain;
  charset="us-ascii";
  name="lsmod-clean.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="lsmod-clean.txt"

Module                  Size  Used by
agpgart                32284  1 intel_agp
ahci                   14340  5=20
cdrom                  37552  1 ide_cd
cpufreq_conservative     6756  0=20
cpufreq_ondemand        5980  0=20
ehci_hcd               33160  0=20
evdev                   9536  0=20
ext3                  125256  4=20
fan                     4484  0=20
fat                    52508  1 vfat
firmware_class         10816  2 pcmcia,ipw2200
freq_table              4612  1 speedstep_centrino
generic                 4292  0 [permanent]
i2c_core               22160  1 i2c_i801
i2c_i801                8332  0=20
ide_cd                 40096  0=20
ide_core              126064  6 usb_storage,ide_disk,ide_generic,ide_cd,pii=
x,generic
ide_disk               16640  0=20
ide_generic             1216  0 [permanent]
ieee80211              32584  1 ipw2200
ieee80211_crypt         6528  1 ieee80211
intel_agp              22684  1=20
ipw2200               111340  0=20
jbd                    60244  1 ext3
libata                 60428  1 ahci
mbcache                 9220  1 ext3
mousedev               11712  0=20
nls_cp437               5696  0=20
nls_iso8859_1           4096  0=20
pcmcia                 30344  0=20
pcmcia_core            41936  3 pcmcia,yenta_socket,rsrc_nonstatic
pcspkr                  3460  0=20
piix                   10308  0 [permanent]
processor              21888  2 speedstep_centrino,thermal
psmouse                38532  0=20
rsrc_nonstatic         11904  1 yenta_socket
rtc                    13748  0=20
scsi_mod              136268  4 usb_storage,sd_mod,ahci,libata
sd_mod                 17040  6=20
serio_raw               7236  0=20
snd                    54176  6 snd_hda_intel,snd_hda_codec,snd_pcm_oss,snd=
_mixer_oss,snd_pcm,snd_timer
snd_hda_codec         121792  1 snd_hda_intel
snd_hda_intel          17552  0=20
snd_mixer_oss          18240  1 snd_pcm_oss
snd_page_alloc         10504  2 snd_hda_intel,snd_pcm
snd_pcm                88264  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd_pcm_oss            51328  0=20
snd_timer              24580  1 snd_pcm
soundcore              10336  1 snd
speedstep_centrino      7352  1=20
tg3                   101636  0=20
thermal                12872  0=20
uhci_hcd               32656  0=20
usb_storage            71104  0=20
usbcore               129888  4 usb_storage,ehci_hcd,uhci_hcd
vfat                   13312  0=20
yenta_socket           14604  1=20

--Boundary-01=_a/L+DiDlXfF73Aa
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg.txt"

 ACPI init
[4294671.424000] pnp: PnP ACPI: found 9 devices
[4294671.424000] PCI: Using ACPI for IRQ routing
[4294671.424000] PCI: If a device doesn't work, try "pci=3Drouteirq".  If i=
t helps, post a report
[4294671.425000] PCI: Cannot allocate resource region 7 of bridge 0000:00:1=
c.1
[4294671.425000] PCI: Cannot allocate resource region 8 of bridge 0000:00:1=
c.1
[4294671.425000] PCI: Cannot allocate resource region 9 of bridge 0000:00:1=
c.1
[4294671.443000] PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
[4294671.443000] PCI: Bridge: 0000:00:1c.0
[4294671.443000]   IO window: disabled.
[4294671.443000]   MEM window: b0100000-b01fffff
[4294671.443000]   PREFETCH window: disabled.
[4294671.443000] PCI: Bridge: 0000:00:1c.1
[4294671.444000]   IO window: disabled.
[4294671.444000]   MEM window: disabled.
[4294671.444000]   PREFETCH window: disabled.
[4294671.444000] PCI: Bus 7, cardbus bridge: 0000:06:03.0
[4294671.444000]   IO window: 00002000-000020ff
[4294671.444000]   IO window: 00002400-000024ff
[4294671.444000]   PREFETCH window: 50000000-51ffffff
[4294671.444000]   MEM window: 54000000-55ffffff
[4294671.444000] PCI: Bridge: 0000:00:1e.0
[4294671.444000]   IO window: 2000-2fff
[4294671.444000]   MEM window: b0200000-b02fffff
[4294671.444000]   PREFETCH window: 50000000-51ffffff
[4294671.444000] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low)=
 -> IRQ 169
[4294671.444000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[4294671.444000] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low)=
 -> IRQ 177
[4294671.445000] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[4294671.445000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[4294671.445000] ACPI: PCI Interrupt 0000:06:03.0[A] -> GSI 16 (level, low)=
 -> IRQ 177
[4294671.445000] Simple Boot Flag at 0x7f set to 0x1
[4294671.445000] audit: initializing netlink socket (disabled)
[4294671.445000] audit(1140368786.443:1): initialized
[4294671.445000] Initializing Cryptographic API
[4294671.446000] io scheduler noop registered
[4294671.446000] io scheduler anticipatory registered (default)
[4294671.446000] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low)=
 -> IRQ 169
[4294671.446000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[4294671.446000] assign_interrupt_mode Found MSI capability
[4294671.446000] Allocate Port Service[0000:00:1c.0:pcie00]
[4294671.446000] Allocate Port Service[0000:00:1c.0:pcie02]
[4294671.446000] Allocate Port Service[0000:00:1c.0:pcie03]
[4294671.446000] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low)=
 -> IRQ 177
[4294671.446000] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[4294671.446000] assign_interrupt_mode Found MSI capability
[4294671.447000] Allocate Port Service[0000:00:1c.1:pcie00]
[4294671.447000] Allocate Port Service[0000:00:1c.1:pcie02]
[4294671.447000] Allocate Port Service[0000:00:1c.1:pcie03]
[4294671.449000] PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x=
64 irq 1,12
[4294671.451000] i8042.c: Detected active multiplexing controller, rev 1.1.
[4294671.453000] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[4294671.453000] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[4294671.453000] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[4294671.453000] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[4294671.453000] serio: i8042 KBD port at 0x60,0x64 irq 1
[4294671.454000] RAMDISK driver initialized: 16 RAM disks of 8192K size 102=
4 blocksize
[4294671.454000] STRIP: Version 1.3A-STUART.CHESHIRE (unlimited channels)
[4294671.455000] MC: drivers/edac/edac_mc.c version edac_mc  Ver: 2.0.0 Feb=
 19 2006
[4294671.455000] NET: Registered protocol family 2
[4294671.465000] IP route cache hash table entries: 32768 (order: 5, 131072=
 bytes)
[4294671.465000] TCP established hash table entries: 131072 (order: 7, 5242=
88 bytes)
[4294671.465000] TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
[4294671.466000] TCP: Hash tables configured (established 131072 bind 65536)
[4294671.466000] TCP reno registered
[4294671.466000] TCP bic registered
[4294671.466000] NET: Registered protocol family 1
[4294671.466000] NET: Registered protocol family 17
[4294671.466000] NET: Registered protocol family 8
[4294671.466000] NET: Registered protocol family 20
[4294671.466000] Using IPI Shortcut mode
[4294671.466000] ACPI wakeup devices:=20
[4294671.466000] PCIB MODM AZAL EXP1 EXP2  LID=20
[4294671.467000] ACPI: (supports S0 S3 S4 S5)
[4294671.467000] Freeing unused kernel memory: 164k freed
[4294671.527000] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[4294671.615000] input: AT Translated Set 2 keyboard as /class/input/input0
[4294671.695000] usbcore: registered new driver usbfs
[4294671.695000] usbcore: registered new driver hub
[4294671.696000] USB Universal Host Controller Interface driver v2.3
[4294671.696000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low)=
 -> IRQ 209
[4294671.696000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[4294671.696000] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[4294671.696000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bu=
s number 1
[4294671.696000] uhci_hcd 0000:00:1d.0: irq 209, io base 0x00001420
[4294671.697000] usb usb1: configuration #1 chosen from 1 choice
[4294671.697000] hub 1-0:1.0: USB hub found
[4294671.697000] hub 1-0:1.0: 2 ports detected
[4294671.798000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low)=
 -> IRQ 217
[4294671.798000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[4294671.798000] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[4294671.798000] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bu=
s number 2
[4294671.798000] uhci_hcd 0000:00:1d.1: irq 217, io base 0x00001440
[4294671.798000] usb usb2: configuration #1 chosen from 1 choice
[4294671.798000] hub 2-0:1.0: USB hub found
[4294671.798000] hub 2-0:1.0: 2 ports detected
[4294671.899000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low)=
 -> IRQ 225
[4294671.899000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[4294671.899000] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[4294671.899000] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bu=
s number 3
[4294671.899000] uhci_hcd 0000:00:1d.2: irq 225, io base 0x00001460
[4294671.900000] usb usb3: configuration #1 chosen from 1 choice
[4294671.900000] hub 3-0:1.0: USB hub found
[4294671.900000] hub 3-0:1.0: 2 ports detected
[4294672.001000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low)=
 -> IRQ 177
[4294672.001000] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[4294672.001000] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[4294672.001000] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bu=
s number 4
[4294672.001000] uhci_hcd 0000:00:1d.3: irq 177, io base 0x00001480
[4294672.001000] usb usb4: configuration #1 chosen from 1 choice
[4294672.001000] hub 4-0:1.0: USB hub found
[4294672.001000] hub 4-0:1.0: 2 ports detected
[4294672.102000] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low)=
 -> IRQ 209
[4294672.102000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[4294672.102000] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[4294672.102000] ehci_hcd 0000:00:1d.7: debug port 1
[4294672.102000] PCI: cache line size of 32 is not supported by device 0000=
:00:1d.7
[4294672.102000] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bu=
s number 5
[4294672.103000] ehci_hcd 0000:00:1d.7: irq 209, io mem 0xb0004000
[4294672.107000] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver =
10 Dec 2004
[4294672.107000] usb usb5: configuration #1 chosen from 1 choice
[4294672.107000] hub 5-0:1.0: USB hub found
[4294672.107000] hub 5-0:1.0: 8 ports detected
[4294672.188000] SCSI subsystem initialized
[4294672.190000] libata version 1.20 loaded.
[4294672.201000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[4294672.201000] ide: Assuming 33MHz system bus speed for PIO modes; overri=
de with idebus=3Dxx
[4294672.208000] tg3.c:v3.49 (Feb 2, 2006)
[4294672.208000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low)=
 -> IRQ 177
[4294672.208000] PCI: Setting latency timer of device 0000:02:00.0 to 64
[4294672.231000] eth0: Tigon3 [partno(BCM95751m) rev 4201 PHY(5750)] (PCI E=
xpress) 10/100/1000BaseT Ethernet 00:0b:5d:c7:47:ef
[4294672.232000] eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] Wi=
reSpeed[1] TSOcap[1]=20
[4294672.232000] eth0: dma_rwctrl[76180000]
[4294672.252000] ahci 0000:00:1f.2: version 1.2
[4294672.252000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low)=
 -> IRQ 217
[4294676.564000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[4294676.564000] ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbp=
s 0x5 impl SATA mode
[4294676.564000] ahci 0000:00:1f.2: flags: 64bit ncq pm led slum part=20
[4294676.564000] ata1: SATA max UDMA/133 cmd 0xF882E500 ctl 0x0 bmdma 0x0 i=
rq 217
[4294676.564000] ata2: SATA max UDMA/133 cmd 0xF882E580 ctl 0x0 bmdma 0x0 i=
rq 217
[4294676.564000] ata3: SATA max UDMA/133 cmd 0xF882E600 ctl 0x0 bmdma 0x0 i=
rq 217
[4294676.564000] ata4: SATA max UDMA/133 cmd 0xF882E680 ctl 0x0 bmdma 0x0 i=
rq 217
[4294676.766000] ata1: SATA link up 1.5 Gbps (SStatus 113)
[4294676.766000] ata1: dev 0 cfg 49:2f00 82:346b 83:7f09 84:6063 85:346b 86=
:bf09 87:6063 88:203f
[4294676.766000] ata1: dev 0 ATA-7, max UDMA/100, 156301488 sectors: LBA48
[4294676.768000] ata1: dev 0 configured for UDMA/100
[4294676.768000] scsi0 : ahci
[4294676.970000] ata2: SATA link down (SStatus 0)
[4294676.970000] scsi1 : ahci
[4294677.172000] ata3: SATA link down (SStatus 0)
[4294677.172000] scsi2 : ahci
[4294677.374000] ata4: SATA link down (SStatus 0)
[4294677.374000] scsi3 : ahci
[4294677.374000]   Vendor: ATA       Model: FUJITSU MHV2080B  Rev: 0000
[4294677.375000]   Type:   Direct-Access                      ANSI SCSI rev=
ision: 05
[4294677.378000] ICH6: IDE controller at PCI slot 0000:00:1f.1
[4294677.378000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low)=
 -> IRQ 225
[4294677.378000] ICH6: chipset revision 4
[4294677.378000] ICH6: not 100% native mode: will probe irqs later
[4294677.378000]     ide0: BM-DMA at 0x1410-0x1417, BIOS settings: hda:DMA,=
 hdb:pio
[4294677.379000] Probing IDE interface ide0...
[4294677.413000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[4294677.413000] sda: Write Protect is off
[4294677.413000] sda: Mode Sense: 00 3a 00 10
[4294677.413000] SCSI device sda: drive cache: write back w/ FUA
[4294677.414000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[4294677.414000] sda: Write Protect is off
[4294677.414000] sda: Mode Sense: 00 3a 00 10
[4294677.414000] SCSI device sda: drive cache: write back w/ FUA
[4294677.414000]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[4294677.531000] sd 0:0:0:0: Attached scsi disk sda
[4294678.051000] hda: MATSHITAUJ-841Db, ATAPI CD/DVD-ROM drive
[4294678.357000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[4294678.367000] hda: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, =
UDMA(33)
[4294678.368000] Uniform CD-ROM driver Revision: 3.20
[4294678.770000] Probing IDE interface ide1...
[4294679.371000] Attempting manual resume
[4294679.371000] swsusp: Resume From Partition 8:6
[4294679.371000] PM: Checking swsusp image.
[4294679.371000] PM: Resume from disk failed.
[4294679.384000] EXT3-fs: INFO: recovery required on readonly filesystem.
[4294679.384000] EXT3-fs: write access will be enabled during recovery.
[4294680.065000] EXT3-fs: recovery complete.
[4294680.065000] kjournald starting.  Commit interval 5 seconds
[4294680.071000] EXT3-fs: mounted filesystem with ordered data mode.
[4294682.065000] Real Time Clock Driver v1.12ac
[4294682.069000] Linux agpgart interface v0.101 (c) Dave Jones
[4294682.070000] agpgart: Detected an Intel 915GM Chipset.
[4294682.070000] agpgart: Detected 7932K stolen memory.
[4294682.090000] agpgart: AGP aperture is 256M @ 0xc0000000
[4294682.108000] input: PC Speaker as /class/input/input1
[4294682.211000] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low)=
 -> IRQ 177
[4294682.212000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[4294682.560000] hw_random: RNG not detected
[4294682.816000] Synaptics Touchpad, model: 1, fw: 5.9, id: 0xf8eb1, caps: =
0xa04793/0x102000
[4294682.816000] serio: Synaptics pass-through port at isa0060/serio4/input0
[4294682.856000] ACPI: PCI Interrupt 0000:06:03.0[A] -> GSI 16 (level, low)=
 -> IRQ 177
[4294682.857000] Yenta: CardBus bridge found at 0000:06:03.0 [10cf:131e]
[4294682.858000] input: SynPS/2 Synaptics TouchPad as /class/input/input2
[4294682.904000] ieee80211_crypt: registered algorithm 'NULL'
[4294682.906000] ieee80211: 802.11 data/management/control stack, git-1.1.7
[4294682.906000] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jket=
reno@linux.intel.com>
[4294682.924000] ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, g=
it-1.0.8
[4294682.924000] ipw2200: Copyright(c) 2003-2005 Intel Corporation
[4294682.980000] Yenta: ISA IRQ mask 0x0cb8, PCI irq 177
[4294682.980000] Socket status: 30000006
[4294682.980000] pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
[4294682.980000] pcmcia: parent PCI bridge Memory window: 0xb0200000 - 0xb0=
2fffff
[4294682.980000] pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x51=
ffffff
[4294682.981000] ACPI: PCI Interrupt 0000:06:05.0[A] -> GSI 18 (level, low)=
 -> IRQ 225
[4294682.981000] ipw2200: Detected Intel PRO/Wireless 2200BG Network Connec=
tion
[4294683.441000] ipw2200: Radio Frequency Kill Switch is On:
[4294683.441000] Kill switch must be turned off for wireless networking to =
work.
[4294687.034000] input: PS/2 Generic Mouse as /class/input/input3
[4294687.347000] Adding 1012052k swap on /dev/sda6.  Priority:-1 extents:1 =
across:1012052k
[4294687.451000] EXT3 FS on sda2, internal journal
[4294690.531000] mice: PS/2 mouse device common for all mice
[4294691.902000] kjournald starting.  Commit interval 5 seconds
[4294691.902000] EXT3 FS on sda1, internal journal
[4294691.902000] EXT3-fs: mounted filesystem with ordered data mode.
[4294691.922000] kjournald starting.  Commit interval 5 seconds
[4294691.922000] EXT3 FS on sda5, internal journal
[4294691.922000] EXT3-fs: mounted filesystem with ordered data mode.
[4294691.924000] kjournald starting.  Commit interval 5 seconds
[4294691.925000] EXT3 FS on sda3, internal journal
[4294691.925000] EXT3-fs: mounted filesystem with ordered data mode.
[4294856.664000] usb 5-3: new high speed USB device using ehci_hcd and addr=
ess 2
[4294856.790000] usb 5-3: configuration #1 chosen from 1 choice
[4294856.891000] Initializing USB Mass Storage driver...
[4294856.892000] scsi4 : SCSI emulation for USB Mass Storage devices
[4294856.892000] usb-storage: device found at 2
[4294856.892000] usb-storage: waiting for device to settle before scanning
[4294856.892000] usbcore: registered new driver usb-storage
[4294856.892000] USB Mass Storage support registered.
[4294861.892000]   Vendor:           Model: USB DISK 2.0      Rev: PMAP
[4294861.893000]   Type:   Direct-Access                      ANSI SCSI rev=
ision: 00
[4294862.070000] SCSI device sdb: 121856 512-byte hdwr sectors (62 MB)
[4294862.071000] sdb: Write Protect is off
[4294862.071000] sdb: Mode Sense: 23 00 00 00
[4294862.071000] sdb: assuming drive cache: write through
[4294862.073000] SCSI device sdb: 121856 512-byte hdwr sectors (62 MB)
[4294862.074000] sdb: Write Protect is off
[4294862.074000] sdb: Mode Sense: 23 00 00 00
[4294862.074000] sdb: assuming drive cache: write through
[4294862.074000]  sdb: sdb1
[4294862.075000] sd 4:0:0:0: Attached scsi removable disk sdb
[4294862.075000] usb-storage: device scan complete


[4295044.894000] PM: Preparing system for mem sleep
[4295044.895000] Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D|
[4295045.922000] eth1: Going into suspend...
[4295045.922000] ACPI: PCI interrupt for device 0000:06:05.0 disabled
[4295045.933000] ACPI: PCI interrupt for device 0000:06:03.0 disabled
[4295045.933000] ACPI: PCI interrupt for device 0000:00:1f.2 disabled
[4295045.944000] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
[4295045.955000] ACPI: PCI interrupt for device 0000:00:1d.3 disabled
[4295045.955000] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
[4295045.955000] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
[4295045.955000] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
[4295045.959000] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
[4295045.959000] PM: Entering mem sleep
[4295045.959000] Intel machine check architecture supported.
[4295045.959000] Intel machine check reporting enabled on CPU#0.
[4295045.959000] Back to C!
[4295062.959000] PM: Finishing wakeup.
[4295062.999000] ipw2200: Unable to load ucode: -22
[4295062.999000] ipw2200: Unable to load firmware: -22
[4295062.999000] ipw2200: Failed to up device
[4295063.015000] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low)=
 -> IRQ 177
[4295063.015000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[4295063.060000] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low)=
 -> IRQ 169
[4295063.060000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[4295063.060000] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low)=
 -> IRQ 177
[4295063.060000] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[4295063.060000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low)=
 -> IRQ 209
[4295063.060000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[4295063.060000] usb usb1: root hub lost power or was reset
[4295063.060000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low)=
 -> IRQ 217
[4295063.060000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[4295063.060000] usb usb2: root hub lost power or was reset
[4295063.061000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low)=
 -> IRQ 225
[4295063.061000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[4295063.061000] usb usb3: root hub lost power or was reset
[4295063.061000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low)=
 -> IRQ 177
[4295063.061000] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[4295063.061000] usb usb4: root hub lost power or was reset
[4295063.072000] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low)=
 -> IRQ 209
[4295063.072000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[4295063.072000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[4295063.072000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low)=
 -> IRQ 225
[4295063.083000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low)=
 -> IRQ 217
[4295063.083000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[4295063.083000] ACPI: PCI Interrupt 0000:06:03.0[A] -> GSI 16 (level, low)=
 -> IRQ 177
[4295063.114000] eth1: Coming out of suspend...
[4295063.125000] PCI: Enabling device 0000:06:05.0 (0000 -> 0002)
[4295063.125000] ACPI: PCI Interrupt 0000:06:05.0[A] -> GSI 18 (level, low)=
 -> IRQ 225
[4295063.125000] pnp: Failed to activate device 00:07.
[4295063.125000] pnp: Failed to activate device 00:08.
[4295073.125000] ipw2200: ipw-2.4-boot.fw load failed: Reason -2
[4295073.125000] ipw2200: Unable to load firmware: -2
[4295093.907000] ata1: qc timeout (cmd 0xef)
[4295093.907000] ata1: failed to set xfermode, disabled
[4295093.907000] ata1: dev 0 configured for UDMA/100
[4295098.576000] Restarting tasks... done
[4295098.578000] sd 0:0:0:0: SCSI error: return code =3D 0x40000
[4295098.578000] end_request: I/O error, dev sda, sector 169882
[4295098.578000] sd 0:0:0:0: SCSI error: return code =3D 0x40000
[4295098.578000] end_request: I/O error, dev sda, sector 169890
[4295098.578000] sd 0:0:0:0: SCSI error: return code =3D 0x40000
[4295098.578000] end_request: I/O error, dev sda, sector 169898
[4295098.579000] sd 0:0:0:0: SCSI error: return code =3D 0x40000
[4295098.579000] end_request: I/O error, dev sda, sector 169906
[4295098.579000] Buffer I/O error on device sda2, logical block 1157
[4295098.579000] lost page write due to I/O error on sda2
[4295098.579000] Aborting journal on device sda2.
[4295098.599000] ACPI Error (evevent-0312): No installed handler for fixed =
event [00000002] [20060127]
[4295098.601000] ext3_abort called.
[4295098.601000] EXT3-fs error (device sda2): ext3_journal_start_sb: Detect=
ed aborted journal
[4295098.602000] Remounting filesystem read-only
[4295098.998000] sd 0:0:0:0: SCSI error: return code =3D 0x40000
[4295098.998000] end_request: I/O error, dev sda, sector 14594970
[4295098.998000] sd 0:0:0:0: SCSI error: return code =3D 0x40000
[4295098.998000] end_request: I/O error, dev sda, sector 14594970
[4295098.998000] sd 0:0:0:0: SCSI error: return code =3D 0x40000
[4295098.998000] end_request: I/O error, dev sda, sector 14594970

--Boundary-01=_a/L+DiDlXfF73Aa--

--nextPart4511336.eqDzZp4EBj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD+L/eJTvErkMlPvkRAnKaAKDtOLiCfHtJYYQ+Wi8mk+evm5XdrQCfZ0it
f0pN1TPW10I79oiSY75QeQ0=
=dowk
-----END PGP SIGNATURE-----

--nextPart4511336.eqDzZp4EBj--
