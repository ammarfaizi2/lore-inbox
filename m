Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284211AbRLKXgZ>; Tue, 11 Dec 2001 18:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284217AbRLKXgO>; Tue, 11 Dec 2001 18:36:14 -0500
Received: from think.faceprint.com ([166.90.149.11]:22421 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S284211AbRLKXfb>; Tue, 11 Dec 2001 18:35:31 -0500
Date: Tue, 11 Dec 2001 18:32:30 -0500
To: linux-kernel@vger.kernel.org
Subject: /proc/stat not showing disk_io stats for all disks
Message-ID: <20011211233230.GA1171@faceprint.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
From: faceprint@faceprint.com (Nathan Walp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I didn't notice this at first when I made the "jump" from the -ac series
to the linus, and now to the marcelo kernels, but /proc/stat is only
showing the disk_io statistics for my scsi drive.  It is not showing
the statistics for my IDE drive.

2.4.13-ac8:
disk_io: (8,0):(708,669,11701,39,1688) (33,0):(21,17,120,4,32)=20

2.4.17-pre7
disk_io: (8,0):(6097,5247,103381,850,29624)

I have one SCSI card (an adaptec 29160N) running with 1 scsi drive, and
2 cd-rom drives.  ide0 and ide1 are not used, as they are the onboard
(ATA/66) controllers on my motherboard.  ide2 ande ide3 are on the
Promise ATA/100 controller integrated into my motherboard (A7V). =20

I don't remember changing any CONFIG options that would cause this, but
it is possible (2.4.13-ac8 seems like eons ago).  Below is a piece of my
dmesg output from 2.4.17-pre7, maybe that will have some clues that I
didn't think to mention.

Hope someone can help me out.

Nathan


dmesg output:
<snip>
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller on PCI bus 00 dev 21
PCI: Enabling device 00:04.1 (0000 -> 0001)
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:04.1
VP_IDE: neither IDE port enabled (BIOS)
PDC20265: IDE controller on PCI bus 00 dev 88
PCI: Found IRQ 10 for device 00:11.0
PCI: Sharing IRQ 10 with 00:0b.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x6800-0x6807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x6808-0x680f, BIOS settings: hdg:pio, hdh:pio
hde: IBM-DTLA-307045, ATA DISK drive
ide2 at 0x8000-0x8007,0x7802 on irq 10
hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=3D89355/16/63, UDMA(1=
00)
Partition check:
 /dev/ide/host2/bus0/target0/lun0: [PTBL] [5606/255/63] p1 p2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
PCI: Enabling device 00:0b.0 (0014 -> 0017)
PCI: Found IRQ 10 for device 00:0b.0
PCI: Sharing IRQ 10 with 00:11.0
eth0: ADMtek Comet rev 17 at 0xe0818000, 00:04:5A:45:1C:DD, IRQ 10.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 64M @ 0xe4000000
[drm] AGP 0.99 on VIA Apollo KT133 @ 0xe4000000 64MB
[drm] Initialized radeon 1.1.1 20010405 on minor 0
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 14 for device 00:09.0
PCI: Sharing IRQ 14 with 00:04.2
PCI: Sharing IRQ 14 with 00:04.3
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 29160N Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=3D7, 32/253 SCBs

  Vendor: SEAGATE   Model: ST318436LW        Rev: 0005
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 31, 16bit)
  Vendor: PIONEER   Model: CD-ROM DR-U12X    Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:2): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: HP        Model: CD-Writer+ 9200   Rev: 1.0c
  Type:   CD-ROM                             ANSI SCSI revision: 04
(scsi0:A:6): 10.000MB/s transfers (10.000MHz, offset 15)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 35885168 512-byte hdwr sectors (18373 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 6, lun 0
sr0: scsi3-mmc drive: 12x/12x xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
</snip>

--=20
Nathan Walp             || faceprint@faceprint.com
GPG Fingerprint:        ||   http://faceprint.com/
5509 6EF3 928B 2363 9B2B  DA17 3E46 2CDC 492D DB7E


--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8FpeOPkYs3Ekt234RAqVuAJ49RYUxQs5D87hyhkYhLgaOrQAl0QCgzPkp
kRb06ZNkV/SzRxaAWGz6NKY=
=8IRE
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
