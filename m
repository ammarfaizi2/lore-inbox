Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315981AbSEZLvJ>; Sun, 26 May 2002 07:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315982AbSEZLvI>; Sun, 26 May 2002 07:51:08 -0400
Received: from pop.gmx.de ([213.165.64.20]:55112 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S315981AbSEZLvI>;
	Sun, 26 May 2002 07:51:08 -0400
Date: Sun, 26 May 2002 13:50:58 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Gert Vervoort <Gert.Vervoort@wxs.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.18 ide-scsi compile fix
Message-Id: <20020526135058.493da149.sebastian.droege@gmx.de>
In-Reply-To: <3CEFAB05.62937A75@wxs.nl>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.0n0djRBG::0Udm"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.0n0djRBG::0Udm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 May 2002 17:17:25 +0200
Gert Vervoort <Gert.Vervoort@wxs.nl> wrote:

> > --- ide-scsi.c.1        Sat May 25 14:21:28 2002
> > +++ ide-scsi.c  Sat May 25 14:21:37 2002
> > @@ -804,7 +804,7 @@
> >  };
> > 
> > 
> > -static int __init idescsi_init(void)
> > +int __init idescsi_init(void)
> >  {
> >         int ret;
> >         ret = ata_driver_module(&idescsi_driver);
> 
> This does not boot, as idescsi_init seems is also called by the scsi subsystem.
> The following patch actually boots on my system:
> 
> --- ide.c.1     Sat May 25 16:22:54 2002
> +++ ide.c       Sat May 25 16:23:22 2002
> @@ -3444,9 +3444,7 @@
>         idefloppy_init();
>  #endif
>  #ifdef CONFIG_BLK_DEV_IDESCSI
> -# ifdef CONFIG_SCSI
> -       idescsi_init();
> -# else
> +# ifndef CONFIG_SCSI
>     #error ATA SCSI emulation selected but no SCSI-subsystem in kernel
>  # endif
>  #endif
This patch does not work too....
Only one ide-scsi device will get detected

BTW: why do I get an oops (reported 2 or 3 times but no answers) when mounting cdroms since 2.5.7 or something?

cat /proc/cmdline 
BOOT_IMAGE=2.5.18 rw root=301 hdc=scsi hdd=scsi

[...]
ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
ATA: Intel Corp. 82371AB PIIX4 IDE, PCI slot 00:07.1
ATA: chipset rev.: 1
ATA: non-legacy mode: IRQ probe delayed
PIIX: Intel Corp. 82371AB PIIX4 IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DTTA-351010, ATA DISK drive
hdb: WDC WD800BB-00BSA0, ATA DISK drive
hdc: CD-W512EB, ATAPI CD/DVD-ROM drive
hdd: CD-532E-B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
[...]
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TEAC      Model: CD-W512EB         Rev: 2.0E
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
--=.0n0djRBG::0Udm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE88Mwle9FFpVVDScsRAkmFAKDkPhvwrgKOxKn7u4JPZVGGb3U5JACg7Dc5
o+V2KoP1Qgp9+JRVicb2TRs=
=6tFL
-----END PGP SIGNATURE-----

--=.0n0djRBG::0Udm--

