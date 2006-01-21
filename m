Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWAUXmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWAUXmZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 18:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWAUXmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 18:42:25 -0500
Received: from smtp04.auna.com ([62.81.186.14]:64647 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S1751229AbWAUXmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 18:42:24 -0500
Date: Sun, 22 Jan 2006 00:46:36 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@osdl.org>,
       "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: SMP+nosmp=hang [was: Re: 2.6.15-rc5-mm2]
Message-ID: <20060122004636.0837de67@werewolf.auna.net>
In-Reply-To: <20060120192259.4460af42.akpm@osdl.org>
References: <20051211041308.7bb19454.akpm@osdl.org>
	<20051214095459.3912d59e@werewolf.auna.net>
	<20060120192259.4460af42.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 1.9.100cvs178 (GTK+ 2.8.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_1B8Axqxod3uKhRKiQVVanSp;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.216.29] Login:jamagallon@able.es Fecha:Sun, 22 Jan 2006 00:42:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_1B8Axqxod3uKhRKiQVVanSp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Jan 2006 19:22:59 -0800, Andrew Morton <akpm@osdl.org> wrote:

> "J.A. Magallon" <jamagallon@able.es> wrote:
> >
> > On Sun, 11 Dec 2005 04:13:08 -0800, Andrew Morton <akpm@osdl.org> wrote:
> >=20
> > >=20
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-=
rc5/2.6.15-rc5-mm2/
> > >=20
> >=20
> > Booting a SMP built kernel with 'nosmp' just hangs at the VFS layer, wi=
th
> > the message about 'not being able to find root device sda1'.
> > sda is a SATA drive on an Intel ICH5 controller:
> >=20
> > libata version 1.20 loaded.
> > ata_piix 0000:00:1f.2: version 1.05
> > ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
> > PCI: Setting latency timer of device 0000:00:1f.2 to 64
> > ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
> > ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
> > ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003=
 88:407f
> > ata1: dev 0 ATA-6, max UDMA/133, 390721968 sectors: LBA48
> > ata1: dev 0 configured for UDMA/133
> > scsi0 : ata_piix
> > ATA: abnormal status 0x7F on port 0xC807
> > scsi1 : ata_piix
> >   Vendor: ATA       Model: ST3200822AS       Rev: 3.01
> >   Type:   Direct-Access                      ANSI SCSI revision: 05
> > SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
> > SCSI device sda: drive cache: write back
> > SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
> > SCSI device sda: drive cache: write back
> >  sda: sda1 sda2 sda3
> > sd 0:0:0:0: Attached scsi disk sda
> >=20
> > I would have to double check, but I think it even missed the USB keyboa=
rd.
> >=20
>=20
> Is this still happening?

Yes. I have just tried with 2.6.16-rc1-mm2, and the result is the same.
No root device.

The nosmp-booted kernel looks much much slow than the SMP one, it takes
ages to detect devices like usb ones, and even spent about 20 seconds here:

[    0.431601] libata version 1.20 loaded.
[    0.431652] ata_piix 0000:00:1f.2: version 1.05
[    0.431670] ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -=
> IRQ 16
[    0.431792] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[    0.431852] ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 i=
rq 16
[    0.431950] ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 i=
rq 16
   >>>>>>>>>>>>> here <<<<<<<<<<<<<<<<<<
[    0.690451] ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3=
c01 87:4003 88:407f
[    0.690456] ata1: dev 0 ATA-6, max UDMA/133, 390721968 sectors: LBA48
[    0.696278] ata1: dev 0 configured for UDMA/133
[    0.701627] scsi0 : ata_piix
[    1.937443] scsi1 : ata_piix

and it did not detect any drive, so the no-root-device error. This one can =
be
a detection timeout, but as I say also the USB detection is dog slooow.

Need some info ? .config, or the like ?

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.15-jam5 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_1B8Axqxod3uKhRKiQVVanSp
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD0sfcRlIHNEGnKMMRAr1uAJ9zRuVw+pW+xQvUiu5nBCR5H+sQVQCbBf+C
nIMdtOY2kXe5iGmATCi3dE8=
=JY+B
-----END PGP SIGNATURE-----

--Sig_1B8Axqxod3uKhRKiQVVanSp--
