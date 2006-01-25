Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWAYAH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWAYAH4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 19:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWAYAH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 19:07:56 -0500
Received: from smtp06.auna.com ([62.81.186.16]:8076 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S1750838AbWAYAHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 19:07:55 -0500
Date: Wed, 25 Jan 2006 01:12:11 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Ed Sweetman <safemode@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: poor raid0 performance in 2.6.16-rc1-mm2?
Message-ID: <20060125011211.337169ac@werewolf.auna.net>
In-Reply-To: <43D6B7F9.3020407@comcast.net>
References: <43D6B7F9.3020407@comcast.net>
X-Mailer: Sylpheed-Claws 1.9.100cvs183 (GTK+ 2.8.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_PJmHzDuyPCX2qpziUIgn96E;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.216.29] Login:jamagallon@able.es Fecha:Wed, 25 Jan 2006 01:07:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_PJmHzDuyPCX2qpziUIgn96E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Jan 2006 18:27:53 -0500, Ed Sweetman <safemode@comcast.net> wrot=
e:

> I'll have to reboot to double check that this is specific to the above=20
> kernel version, but It seems something is either wrong with my=20
> particular kernel config for raid0, or my raid0 is setup wrong.
>=20
> my raid0 uses 64k chunk sizes on an ext3 fs that's 367GB large, (across=20
> two identical sata disks on nforce4 chipset)
>=20
> I have partitions on both drives of equal size (2 altogether) that are=20
> outside of the raid0.  I dbenched those partitions, the raid0 device,=20
> and libata pata devices i also have (same rpm, less cache, same company).=
 =20
>=20
> pata disk : 403MB/sec
> sata disk 1: 446MB/sec
> raid0 : between 336MB/sec and 386MB/sec
>=20

Uh ? I want some of those disks....
How are you measuring that ?

Some more real numbers.

A SATA raid5:
nada:~# lsscsi
[1:0:0:0]    disk    ATA      Maxtor 7Y250M0   YAR5  -      =20
[2:0:0:0]    disk    ATA      Maxtor 7Y250M0   YAR5  -      =20
[3:0:0:0]    disk    ATA      Maxtor 7Y250M0   YAR5  -      =20
[4:0:0:0]    disk    ATA      Maxtor 7Y250M0   YAR5  -      =20
[5:0:0:0]    disk    ATA      Maxtor 7Y250M0   YAR5  -      =20
[6:0:0:0]    disk    ATA      Maxtor 7Y250M0   YAR5  -      =20
[7:0:0:0]    disk    ATA      Maxtor 7Y250M0   YAR5  -
nada:~# hdparm -t /dev/sdb /dev/sdc

/dev/sdb:
 Timing buffered disk reads:  156 MB in  3.02 seconds =3D  51.70 MB/sec

/dev/sdc:
 Timing buffered disk reads:  154 MB in  3.02 seconds =3D  50.96 MB/sec

nada:~# hdparm -t /dev/md0

/dev/md0:
 Timing buffered disk reads:  148 MB in  3.01 seconds =3D  49.20 MB/sec

An SCSI raid0 one (160 and 320 mixed...)

annwn:~# hdparm -t /dev/sdc /dev/sdb

/dev/sdc:
 Timing buffered disk reads:  226 MB in  3.02 seconds =3D  74.72 MB/sec

/dev/sdb:
 Timing buffered disk reads:  122 MB in  3.00 seconds =3D  40.64 MB/sec

annwn:~# hdparm -t /dev/md0

/dev/md0:
 Timing buffered disk reads:  242 MB in  3.00 seconds =3D  80.62 MB/sec


> now the sata disks alone, get 446MB/sec, but the raid device that's=20
> comprised of them is getting >60MB/sec less throughput.=20
>=20
> This difference is much more drastic when say only 1 process is used=20
> with dbench,
>=20
> sata disk 1: 230MB/sec
> raid0 : 96MB/sec
>=20
>=20
> Something definitely feels wrong with these numbers.=20
>=20
> All filesystems are ext3, on an athlon 64 x2 system, during each test no=
=20
> other io was performed, there is no swap and no other cpu intensive=20
> operations were going on.=20
>=20
> the filesystems were all created the same way, and all have the same=20
> blocksizes and such.  All are mounted with default options too.=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.15-jam5 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_PJmHzDuyPCX2qpziUIgn96E
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD1sJbRlIHNEGnKMMRAtpHAJ4zej6En0vmci1awG0ukYK+Yg9X/ACfdhA8
5e0rE0vkBaGS3BgTlGUrBss=
=6Jx7
-----END PGP SIGNATURE-----

--Sig_PJmHzDuyPCX2qpziUIgn96E--
