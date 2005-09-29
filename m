Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbVI2SE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVI2SE4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 14:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbVI2SE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 14:04:56 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:18015 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S932308AbVI2SEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 14:04:55 -0400
Message-ID: <433C2CB6.5040903@poczta.fm>
Date: Thu, 29 Sep 2005 20:04:38 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: udf uid/gid problem.
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig64ECA9E53A334662C2241371"
X-EMID: 1c2a5138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig64ECA9E53A334662C2241371
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Greetings.

A while ago someone, please forgive me I don't remeber exactly who,
stated here that UDF is much better than FAT for flash-drives. So I
try to use it this way. Unfortunately there seem to be a bug in kernel
rendering UDF on portable media completrly useless.

A filesystem for portable media should be "userless" because one most
probably has different uids on different machines. The first problem is
that I am unable to use uid=3D/gid=3D options if UDF volume's root direct=
ory
(super-block???) has an owner of uid differnet than -1. In any other
case the on-volume owner/group takes precedence over uid=3D/gid=3D option=
s.

The second bug lives somewhere in writing functions. If I set the root
(sb???) owner to -1, the uid=3D and gid=3D work until I write a single fi=
le
onto the volume. Next time I mount the volume, with uid=3D/gid=3D of cour=
se,
everything on it is owned by root:root.

No.3 If I create a volum with root directory (sb???) owned root:root,
without hacking mkudffs, and I chown(1) some files, file ownership
information also doesn't survive unmounting.

=46rom what I know UDF could really be a superb filesystem for flash
memory devices but today it is unfortunately completly useless. I might
even forget about the ownership information, as I said it's useless or
even harmfull on portables but setting the "root" of the volum is crucial=
=2E

Best regards.
PS. Please remember to CC, I'am not a subscriber.
--=20
By=C5=82o mi bardzo mi=C5=82o.                    Trzecia pospolita kl=C4=
=99ska, [...]
>=C5=81ukasz<                      Ju=C5=BC nie katolicka lecz z=C5=82odz=
iejska.  (c)PP


--------------enig64ECA9E53A334662C2241371
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDPCy7NdzY8sm9K9wRAlBtAKCOYE9X/KHuGiqz7ekKT/8H/4w9OQCgjzda
rXEL2FFjlXZBfyuSGHq9E7w=
=Lz5W
-----END PGP SIGNATURE-----

--------------enig64ECA9E53A334662C2241371--
