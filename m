Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264053AbRFKWH3>; Mon, 11 Jun 2001 18:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264062AbRFKWHU>; Mon, 11 Jun 2001 18:07:20 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:43269 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S264053AbRFKWHG>; Mon, 11 Jun 2001 18:07:06 -0400
Date: Tue, 12 Jun 2001 00:04:43 +0200
From: Kurt Garloff <garloff@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <hedrick@kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ide oops in 2.2.19/2.4.4
Message-ID: <20010612000443.A29184@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andre Hedrick <hedrick@kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.19 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alan, Andre,

here's a patch to prevent ide_dump_status () to deref a null pointer, when
the drive does not have its hwgroup setup yet.
Happens upon initialization of the via driver if the speed settings fails
(on an old IDE harddisk).

Linux version 2.2.19 (root@claudia) (gcc version egcs-2.91.66 19990314/Linux
 (egcs-1.1.2 release)) #2 Sat Jun 9 19:25:07 CEST 2001
[...]
Uniform Multi-Platform E-IDE driver Revision: 6.30
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 2
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: VIA vt82c586 (rev 02) IDE MWDMA16 controller on pci00:07.1
    ide0: BM-DMA at 0x6000-0x6007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x6008-0x600f, BIOS settings: hdc:pio, hdd:pio
hda: FUJITSU MPD3130AT, ATA DISK drive
hdc: st3144AT, ATA DISK drive
hdc: set_drive_speed_status: status=3D0x51 { DriveReady SeekComplete Error }
hdc: set_drive_speed_status: error=3D0x10 { SectorIdNotFound }, CHS=3D0/0/0=
<1>Unable
 to handle kernel NULL pointer dereference at virtual address 00000014
[ksymooopsed]
current->tss.cr3 =3D 00101000, %cr3 =3D 00101000
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0192b07>]
EFLAGS: 00010286
eax: 00000000   ebx: c026f200   ecx: 00000001   edx: 00000001
esi: c026f398   edi: c026f338   ebp: c026f2f8   esp: c4ffbe98
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, process nr: 1, stackpage=3Dc4ffb000)
Stack: c026f338 c026f2f8 00000000 00000000 c010b49b 00000210 00000286 c0196=
76e=20
       c026f338 c01f85b2 00000051 c026f338 00000000 c026f2f8 c026f338 00000=
00a=20
       c026f2f8 04000000 00000002 00000000 00000000 00000001 08000002 c01aa=
723=20
Call Trace: [<c010b49b>] [<c019676e>] [<c01f85b2>] [<c01aa723>] [<c01951f0>=
] [<c01a0010>] [<c01a72a3>]=20
       [<c01aa852>] [<c01a7807>] [<c01a8113>] [<c0106000>] [<c0106000>] [<c=
0106093>] [<c0108d1f>]=20
Code: 8b 48 14 85 c9 74 11 8b 41 10 50 68 4d 79 1f c0 e8 28 34 f8=20

>EIP: c0192b07 <ide_dump_status+2b3/2ec>
Trace: c010b49b <enable_irq+33/5c>
Trace: c019676e <ide_config_drive_speed+1f2/384>
Trace: c01f85b2 <ide_hwif_to_major+fcf/3c65>
Trace: c01aa723 <via_set_drive+4f/140>
Trace: c01951f0 <ide_delay_50ms+10/18>
Trace: c01a0010 <hard_dma_setup+38/168>
Trace: c01a72a3 <do_probe+20b/220>
Trace: c01aa852 <via82cxxx_tune_drive+3e/68>
Code:  c0192b07 <ide_dump_status+2b3/2ec>      00000000 <_EIP>: <=3D=3D=3D
Code:  c0192b07 <ide_dump_status+2b3/2ec>         0:    8b 48 14        mov=
l  0x14(%eax),%ecx <=3D=3D=3D
Code:  c0192b0a <ide_dump_status+2b6/2ec>         3:    85 c9           tes=
tl %ecx,%ecx
Code:  c0192b0c <ide_dump_status+2b8/2ec>         5:    74 11           je =
    c0192b1f <ide_dump_status+2cb/2ec>
Code:  c0192b0e <ide_dump_status+2ba/2ec>         7:    8b 41 10        mov=
l  0x10(%ecx),%eax
Code:  c0192b11 <ide_dump_status+2bd/2ec>         a:    50              pus=
hl %eax
Code:  c0192b12 <ide_dump_status+2be/2ec>         b:    68 4d 79 1f c0  pus=
hl $0xc01f794d
Code:  c0192b17 <ide_dump_status+2c3/2ec>        10:    e8 28 34 f8 00  cal=
l   c1115f44 <_end+e9fd48/59a2e54>

After applying the trival patch the kernel not only survives but works
flawlessly. Patches against 2.2.19 and 2.4.3 are attached. Should be applied
IMHO.

hdc: set_drive_speed_status: error=3D0x10 { SectorIdNotFound }, CHS=3D0/0/0
ide1: Drive 0 didn't accept speed setting. Oh, well.
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: FUJITSU MPD3130AT, 12417MB w/512kB Cache, CHS=3D1583/255/63, (U)DMA
hdc: st3144AT, 124MB w/32kB Cache, CHS=3D1001/15/17


Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations  <K.Garloff@Phys.TUE.NL>  [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>   [SuSE Nuernberg, FRG]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide-oops-2219.diff"

--- linux-2.2.19.SuSE/drivers/block/ide.c.orig	Tue May 15 15:56:49 2001
+++ linux-2.2.19.SuSE/drivers/block/ide.c	Sat Jun  9 20:09:09 2001
@@ -886,7 +886,7 @@
 					  cur & 0xf,
 					  IN_BYTE(IDE_SECTOR_REG));
 				}
-				if (HWGROUP(drive)->rq)
+				if (HWGROUP(drive) && HWGROUP(drive)->rq)
 					printk(", sector=%ld", HWGROUP(drive)->rq->sector);
 			}
 		}

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide-oops-243.diff"

--- linux-2.4.3p7.compile/drivers/ide/ide.c.orig	Mon Jun 11 23:57:09 2001
+++ linux-2.4.3p7.compile/drivers/ide/ide.c	Tue Apr 17 07:20:10 2001
@@ -876,7 +876,7 @@
 					  cur & 0xf,
 					  IN_BYTE(IDE_SECTOR_REG));
 				}
-				if (HWGROUP(drive) && HWGROUP(drive)->rq)
+				if (HWGROUP(drive)->rq)
 					printk(", sector=%ld", HWGROUP(drive)->rq->sector);
 			}
 		}

--pf9I7BMVVzbSWLtt--

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7JUB6xmLh6hyYd04RAvWNAJ47h+cE4DG2bdsIiyovCobcHWb1/ACfTniC
T1WwXd3WNiNd8pnywax1K3c=
=N6Ci
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
