Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266147AbUAGJJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 04:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbUAGJJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 04:09:58 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:2177 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S266147AbUAGJJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 04:09:54 -0500
Date: Wed, 7 Jan 2004 10:09:53 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: LVM 2.6 compatibility?
Message-ID: <20040107090952.GO14285@lug-owl.de>
Mail-Followup-To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <1073397568.29659.178.camel@roy-sin> <Pine.LNX.4.43.0401070941040.23681-100000@cibs9.sns.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vrIGRKnBmQs2THAk"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43.0401070941040.23681-100000@cibs9.sns.it>
X-Operating-System: Linux mail 2.4.18
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vrIGRKnBmQs2THAk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-01-07 09:41:17 +0100, venom@sns.it <venom@sns.it>
wrote in message <Pine.LNX.4.43.0401070941040.23681-100000@cibs9.sns.it>:
>=20
> yes, there is full back compatibility

Erm, not to mention that I've recently been hit by some bug. This is
with LVM2 userland and LVM1 metadata. I just wanted to create a
snapshot, but I got

machineA#
  Rounding up size to full physical extend 252.00 MB                       =
    =20
device-mapper: error adding target to table                                =
    =20
  device-mapper ioctl cmd 9 failed: Invalid argument                       =
    =20
  Couldn't load device 'vg00-snap1'.                                       =
    =20
  Problem reactivating origin home_lv                                      =
    =20

and

which leaves me with:

machineB:~# lvdisplay=20
  --- Logical volume ---
  LV Name                /dev/storage_vg/whole_ftp_area_lv
  VG Name                storage_vg
  LV UUID                000000-0000-0000-0000-0000-0000-000000
  LV Write Access        read/write
  LV snapshot status     source of
                         /dev/storage_vg/tempsnap [INACTIVE]
  LV Status              NOT available
  LV Size                182.50 GB
  Current LE             2920
  Segments               23
  Allocation             next free
  Read ahead sectors     0
  =20
  --- Logical volume ---
  LV Name                /dev/storage_vg/public_storage_lv
  VG Name                storage_vg
  LV UUID                000000-0000-0000-0000-0000-0000-000001
  LV Write Access        read/write
  LV Status              available
  # open                 1
  LV Size                54.38 GB
  Current LE             870
  Segments               8
  Allocation             next free
  Read ahead sectors     0
  Block device           254:3
  =20
  --- Logical volume ---
  LV Name                /dev/storage_vg/tempsnap
  VG Name                storage_vg
  LV UUID                000000-0000-0000-0000-0000-0000-000002
  LV Write Access        read/write
  LV snapshot status     INACTIVE destination for /dev/storage_vg/whole_ftp=
_area_lv
  LV Status              available
  # open                 0
  LV Size                182.50 GB
  Current LE             2920
  Segments               1
  Snapshot chunk size    8.00 KB
  Allocated to snapshot  100.00%=20
  Allocation             next free
  Read ahead sectors     0
  Block device           254:2

So, after lvcreate -s on two different hosts, the snapshot isn't really
there (albeit vgmknodes creates nodes for them), but any attempt to
access them results in "they're not there". Worse than that, if the
original LV was mounted, anything accessing it will hang in D state, of
course:)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--vrIGRKnBmQs2THAk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+8zgHb1edYOZ4bsRAjKcAJ96ZBzfj+23PkQKgeyMjdQY+3cZjwCfYWaJ
yYShEiFeLlyy9fF+zjG5+dE=
=yaXC
-----END PGP SIGNATURE-----

--vrIGRKnBmQs2THAk--
