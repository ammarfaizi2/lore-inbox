Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWDFG6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWDFG6g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 02:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWDFG6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 02:58:36 -0400
Received: from lug-owl.de ([195.71.106.12]:56765 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751108AbWDFG6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 02:58:36 -0400
Date: Thu, 6 Apr 2006 08:58:32 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Sumit Narayan <talk2sumit@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ext3-users@redhat.com
Subject: Re: deleting partition does not effect superblock?
Message-ID: <20060406065832.GK13324@lug-owl.de>
Mail-Followup-To: Sumit Narayan <talk2sumit@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, ext3-users@redhat.com
References: <1458d9610604052337p2cafa6c8j78fc6da8c5f8be1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GmiNL4+5WUWrod5m"
Content-Disposition: inline
In-Reply-To: <1458d9610604052337p2cafa6c8j78fc6da8c5f8be1a@mail.gmail.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GmiNL4+5WUWrod5m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-04-06 14:37:33 +0800, Sumit Narayan <talk2sumit@gmail.com> wro=
te:
> Shouldn't the superblock be changed/deleted once the partition is
> deleted? I tried a reboot, but the output remained the same.

No, everything you see is "works as expected."  A partition is only a
container (as well as "disks", "volume groups", "RAID arrays",
"logical volumes", "image files" etc. are.)

Whenever you destroy such a container, its contents isn't modified (or
deleted) or otherwise modified. So it's perfectly okay to delete such
a container (eg. remove start and end from the partition table) and
recreate it at some time later (by adding those values back to the
partition table.)  As long as the new container starts at the same
location, a filesystem driver will be able to find the old
information. If you start a block later, it won't find it's
superblocks.

Finally, you have several choices how to defeat getting back old data.
Most probably, you'd just zero it out before deleting the partition
with something like:

# cat /dev/zero > /dev/hda3

(of course with the correct device name!)

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--GmiNL4+5WUWrod5m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFENLwYHb1edYOZ4bsRAqmpAJ9xEHG5uBpoig6R0u8koosGzeLcigCfRQCq
fBlGG16bfZSbwbI9B6HEtOk=
=vkZ4
-----END PGP SIGNATURE-----

--GmiNL4+5WUWrod5m--
