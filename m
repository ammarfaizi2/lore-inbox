Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWCLSpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWCLSpk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 13:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbWCLSpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 13:45:40 -0500
Received: from pool-68-237-228-215.ny325.east.verizon.net ([68.237.228.215]:43971
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S1751690AbWCLSpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 13:45:39 -0500
Subject: Re: Linux v2.6.16-rc6
From: Paul Blazejowski <paulb@blazebox.homeip.net>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oKVyBeRSTI7cmmHIM8vM"
Date: Sun, 12 Mar 2006 13:45:54 -0500
Message-Id: <1142189154.21274.20.camel@blaze.homeip.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 Dropline GNOME 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oKVyBeRSTI7cmmHIM8vM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On recent kernel 2.6.15.6 (or any 2.6.15.x) and latest testing
2.6.16-rc6 libata detects and sets wrong UDMA modes for one of the
SATA-1 drives. This seems to be a bug.

My setup is as follows:

ASUS A8N-SLI-Premium Nforce4 mainboard
AMD Athlon X2 CPU running SMP
GCC 3.3.6
Slackware 10.2 Linux

The drives are used in RAID1 array (dmraid), they are WDC-WD2000JD
series purchased few months apart. Sata is compiled in the kernel as
module sata_nv and functions properly, no errors or any other anomalies
were noticed but the UDMA mode detection seem wrong on the second drive.

Drive one reports ata3: dev 0 configured for UDMA/100 while drive two
ata4: dev 0 configured for UDMA/133

Below is the full snippet of libata detection from dmesg:

libata version 1.20 loaded.
sata_nv 0000:00:07.0: version 0.8
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 22 (level,
low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD800 irq 20
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD808 irq 20
ata1: no device found (phy stat 00000000)
scsi1 : sata_nv
ata2: no device found (phy stat 00000000)
scsi2 : sata_nv
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 21 (level,
low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC400 irq 21
ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC408 irq 21
eth0: link up.
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023c0091065c55]
ata3: dev 0 cfg 49:2f00 82:306b 83:7e01 84:4003 85:3068 86:3c01 87:4003
88:203f
ata3: dev 0 ATA-6, max UDMA/100, 390721968 sectors: LBA48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata3: dev 0 configured for UDMA/100
scsi3 : sata_nv
ieee1394: Host added: ID:BUS[1-00:1023]  GUID[0011d800004f6359]
ata4: dev 0 cfg 49:2f00 82:346b 83:7f61 84:4003 85:3468 86:3c41 87:4003
88:407f
ata4: dev 0 ATA-6, max UDMA/133, 390721968 sectors: LBA48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata4: dev 0 configured for UDMA/133
scsi4 : sata_nv
  Vendor: ATA       Model: WDC WD2000JD-60K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sdb: drive cache: write back
 sdb:<4>nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
 sdb1 sdb2 sdb3 sdb4
sd 3:0:0:0: Attached scsi disk sdb
  Vendor: ATA       Model: WDC WD2000JD-00H  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sdc: drive cache: write back
 sdc:<4>nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
 sdc1 sdc2 sdc3 sdc4
sd 4:0:0:0: Attached scsi disk sdc

lspci -vvv=20

00:07.0 RAID bus controller: nVidia Corporation CK804 Serial ATA
Controller (rev f3) (prog-if 85)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 815a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 20
        Region 0: I/O ports at 09f0 [size=3D8]
        Region 1: I/O ports at 0bf0 [size=3D4]
        Region 2: I/O ports at 0970 [size=3D8]
        Region 3: I/O ports at 0b70 [size=3D4]
        Region 4: I/O ports at d800 [size=3D16]
        Region 5: Memory at d2002000 (32-bit, non-prefetchable)
[size=3D4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:08.0 RAID bus controller: nVidia Corporation CK804 Serial ATA
Controller (rev f3) (prog-if 85)
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 21
        Region 0: I/O ports at 09e0 [size=3D8]
        Region 1: I/O ports at 0be0 [size=3D4]
        Region 2: I/O ports at 0960 [size=3D8]
        Region 3: I/O ports at 0b60 [size=3D4]
        Region 4: I/O ports at c400 [size=3D16]
        Region 5: Memory at d2001000 (32-bit, non-prefetchable)
[size=3D4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-


Cheers!

Paul B.

--=-oKVyBeRSTI7cmmHIM8vM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEFGxiwu5Nmh3PsiMRAkb6AJ4n+W0OkoW+UeDTEtR9fYVsV4qeMgCeMc1N
UylXyNCygkRBi+nDscX+0KY=
=WjIV
-----END PGP SIGNATURE-----

--=-oKVyBeRSTI7cmmHIM8vM--

