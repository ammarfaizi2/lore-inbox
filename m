Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWINSju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWINSju (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 14:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWINSju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 14:39:50 -0400
Received: from mail.isohunt.com ([69.64.61.20]:54248 "EHLO mail.isohunt.com")
	by vger.kernel.org with ESMTP id S1750728AbWINSjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 14:39:49 -0400
X-Spam-Check-By: mail.isohunt.com
Date: Thu, 14 Sep 2006 13:05:00 -0700
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: robbat2@gentoo.org
Subject: 2.6.18-rc7-git1: AHCI not seeing devices on ICH8 mobo (DG965RY)
Message-ID: <20060914200500.GD27531@curie-int.orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Please CC me, I'm not subscribed.]

Recently picked up some new hardware (without sufficiently researching
it), and I have found that the AHCI driver does NOT see my SATA optical
device at all.

CPU: Core 2 Duo E6400
Motherboard: Intel DG965RY
DVD: Plextor PX-755SA, SATA DVD burner

# lspci -s 00:1f.2 -vv
00:1f.2 SATA controller: Intel Corporation 82801HR/HO/HH (ICH8R/DO/DH) SATA=
 AHCI Controller (rev 02) (prog-if 01 [AHCI 1.0])
	Subsystem: Intel Corporation Unknown device 514d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 74
	Region 0: I/O ports at 4108 [size=3D8]
	Region 1: I/O ports at 411c [size=3D4]
	Region 2: I/O ports at 4100 [size=3D8]
	Region 3: I/O ports at 4118 [size=3D4]
	Region 4: I/O ports at 4020 [size=3D32]
	Region 5: Memory at 90625000 (32-bit, non-prefetchable) [size=3D2K]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=3D0/4 Enable+
		Address: fee00000  Data: 404a
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [a8] #12 [0010]

Snippets from dmesg (http://www.orbis-terrarum.net/~robbat2/x86_64-mmconfig=
-failure/dmesg-2.6.18-rc7-git1-pci=3Dnommconf):
libata version 2.00 loaded.
ahci 0000:00:1f.2: version 2.0
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 19 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0x33 impl SATA mo=
de
ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part=20
ata1: SATA max UDMA/133 cmd 0xFFFFC20000040100 ctl 0x0 bmdma 0x0 irq 74
ata2: SATA max UDMA/133 cmd 0xFFFFC20000040180 ctl 0x0 bmdma 0x0 irq 74
ata3: SATA max UDMA/133 cmd 0xFFFFC20000040200 ctl 0x0 bmdma 0x0 irq 74
ata4: SATA max UDMA/133 cmd 0xFFFFC20000040280 ctl 0x0 bmdma 0x0 irq 74
scsi1 : ahci
ata1: SATA link down (SStatus 0 SControl 300)
scsi2 : ahci
ata2: SATA link down (SStatus 0 SControl 300)
scsi3 : ahci
ata3: SATA link down (SStatus 0 SControl 0)
scsi4 : ahci
ata4: SATA link down (SStatus 0 SControl 0)

I don't have any SATA hard drives on hand (I'm using a 3ware IDE controller=
 for
storage presently), so I haven't tested with them yet, but I intend to pick
some up this afternoon.

On a separate issue, this board incidently is also the one mentioned in
previous LKML posts that has a presently unsupported Marvell IDE controller.
Jeff Garzik said he was asking Marvell for specs, does anybody know how that
went, or did anybody try to prod around with the controller?

Details as follows:

# lspci -s 02:00.0 -vv=20
02:00.0 IDE interface: Marvell Technology Group Ltd. Unknown device 6101 (r=
ev b1) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Marvell Technology Group Ltd. Unknown device 6101
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 3018 [size=3D8]
	Region 1: I/O ports at 3024 [size=3D4]
	Region 2: I/O ports at 3010 [size=3D8]
	Region 3: I/O ports at 3020 [size=3D4]
	Region 4: I/O ports at 3000 [size=3D16]
	Region 5: Memory at 90400000 (32-bit, non-prefetchable) [size=3D512]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0+,D1+,D2-,D3hot+,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [50] Message Signalled Interrupts: 64bit- Queue=3D0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [e0] Express Legacy Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 0
		Link: Latency L0s <256ns, L1 unlimited
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFCbXsPpIsIjIzwiwRAliEAKCsqyc/zBuSCrqlQi+/oKknJr9PEQCgngmB
4reV51PXy/L4NnVpAUqQRyo=
=Gram
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--
