Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVCNPP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVCNPP7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 10:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVCNPP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 10:15:59 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:59802 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S261534AbVCNPPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 10:15:34 -0500
Date: Mon, 14 Mar 2005 16:15:28 +0100
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.11-mm3: SIS5513 DMA problem (set_drive_speed_status)
Message-ID: <20050314161528.575f3a77@phoebee>
X-Mailer: Sylpheed-Claws 0.9.12cvs53 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Mon__14_Mar_2005_16_15_28_+0100_Cr0bwCKTHj_56wyt;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Mon__14_Mar_2005_16_15_28_+0100_Cr0bwCKTHj_56wyt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

just tried the 2.6.11-mm3 and at boot-time my start scripts try to
enable DMA on my disk (hdparm -m16 -c1 -u1 -X69 /dev/hda).

But while running hdparm, the kernel waits many seconds and gives me
some DMA warnings/errors:

[dmesg output]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: WDC WD1600JB-00GVA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: IDE DVD-ROM 16X, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 1024KiB
hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=3D19457/255/63, UDM=
A(100)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20

....

BIOS EDD facility v0.16 2004-Jun-25, 1 devices found

....

hda: set_drive_speed_status: status=3D0xd0 { Busy }

ide: failed opcode was: unknown
hda: dma_timer_expiry: dma status =3D=3D 0x41
hda: DMA timeout error
hda: dma timeout error: status=3D0xd0 { Busy }

ide: failed opcode was: unknown
hda: DMA disabled
ide0: reset: success
hda: CHECK for good STATUS
hdc: Speed warnings UDMA 3/4/5 is not functional.
[/dmesg output]

That happened also with 2.6.11-rc3 since I thought I should switch away
from my 2.6.8-rc2-mm1 (the best kernel ever ;)).

In kernel config I enabled:
CONFIG_EDD=3Dy

CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
CONFIG_BLK_DEV_IDECD=3Dy

CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_GENERIC=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
CONFIG_IDEDMA_PCI_AUTO=3Dy
CONFIG_BLK_DEV_SIS5513=3Dy
CONFIG_BLK_DEV_IDEDMA=3Dy
CONFIG_IDEDMA_AUTO=3Dy

CONFIG_X86_UP_APIC=3Dy
CONFIG_X86_UP_IOAPIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_ACPI=3Dy


My machine:
Pentium 4 - 2,4Ghz


cat /proc/interrupts:
 14:      26411          XT-PIC  ide0
 15:         24          XT-PIC  ide1


lspci -vvxxx:
0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (pr=
og-if 80 [Master])
        Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller=
 (A,B step)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Region 4: I/O ports at ff00 [size=3D16]
00: 39 10 13 55 05 00 00 02 00 80 01 01 00 80 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 ff 00 00 00 00 00 00 00 00 00 00 39 10 13 55
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 06 00 00 00 00 00
50: f2 00 f2 00 2a 96 d5 c0 00 00 00 00 00 00 00 00
60: fb aa fb aa 00 00 00 00 00 00 00 00 00 00 00 00
70: 17 21 06 04 00 00 00 00 56 23 06 04 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00



Any hint/clue about that?

Regards,
Martin

--=20
MyExcuse:
Write-only-memory subsystem too slow for this machine. Contact your
local dealer.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature_Mon__14_Mar_2005_16_15_28_+0100_Cr0bwCKTHj_56wyt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCNaqTmjLYGS7fcG0RAqigAKCNFLHvvVdMhPqnDTsIsRNV+LbhFACgk0md
C6v3yXsYH2DFsEwe+B59MX0=
=BMyU
-----END PGP SIGNATURE-----

--Signature_Mon__14_Mar_2005_16_15_28_+0100_Cr0bwCKTHj_56wyt--
