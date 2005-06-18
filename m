Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbVFROs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVFROs1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 10:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbVFROs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 10:48:27 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:56348 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S262128AbVFROsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 10:48:22 -0400
Message-ID: <42B43424.6090708@poczta.fm>
Date: Sat, 18 Jun 2005 16:48:04 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: mru@inprovide.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
References: <f192987705061303383f77c10c@mail.gmail.com>	<yw1xslzl8g1q.fsf@ford.inprovide.com> <42AFE624.4020403@poczta.fm>	<200506150454.11532.pmcfarland@downeast.net>	<42AFF184.2030209@poczta.fm> <yw1xd5qo2bzd.fsf@ford.inprovide.com>	<42B04090.7050703@poczta.fm>	<20050615212825.GS23621@csclub.uwaterloo.ca> <42B0BAF5.106@poczta.fm> <yw1xll5a1vyd.fsf@ford.inprovide.com>
In-Reply-To: <yw1xll5a1vyd.fsf@ford.inprovide.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBD8BFC3699578F1EC5C9C98F"
X-EMID: 9a286138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBD8BFC3699578F1EC5C9C98F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

M=C3=A5ns Rullg=C3=A5rd napisa=C5=82(a):
>>>What do you do if the underlying filesystem can not store some unicode=

>>>characters that are allowed on others?
>>
>>That's why UTF-8 is suggested. UTF-8 has been developed to "fool" the
>>software that need not to be aware of unicodeness of the text it manage=
s
>>to handle it without any hickups *and* to store in the text information=

>>about multibyte characters.What characters exactly you do mean? NULL?
>>There is no NULL byte in any UTF-8 string except the one which
>>terminates it.
>=20
> That's exactly how ext3, reiserfs, xfs, jfs, etc. all work.  A few
> filesystems are tagged as using some specific encoding.  If your
> filesystem is marked for iso-8859-1, what should a kernel with a
> conversion mechanism do if a user tries to name a file =EA=B9=80?

Return -ENOENT? I am guessing. But please tell me what should do
userland software if it runs with locale set to something.iso-8859-2 and
finds =EA=B9=80 in the directory? That is the same problem. And for now I=
SO
8-bit encodings are far more popolar and usefull with contemporary tools
than UTF-8. That is why I think suggestion of a layer in the kernel that
would translate filenames form utf-8 stored on the media to e.g. latin2
used by tools is quite reasonable. Especially when there is more than
one encoding for a particular language (think Russian, Polish). Even
more, with such a facility transition would be much more greaceful since
you could have utf-8 filesystem and then you can worry about tools other
tools. The filesystem is already populated with UFT-8 names.

>>>I think UDF is a better filesystem for many types of media since it is=

>>>able to me more gently to the sectors storing the meta data than VFAT
>>>ever will be.
>>I've tried cd packet writing with UDF and it gives insane overhead of
>>about 20%. What metadata you'd like to store for example on your
>>flashdrive or a floppy disk?
>=20
> Filename, timestamps, all the usual.

That's why IMHO FAT is quite enough for this purpose.

--=20
By=C5=82o mi bardzo mi=C5=82o.                    Trzecia pospolita kl=C4=
=99ska, [...]
>=C5=81ukasz<                      Ju=C5=BC nie katolicka lecz z=C5=82odz=
iejska.  (c)PP


--------------enigBD8BFC3699578F1EC5C9C98F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCtDQpNdzY8sm9K9wRAhddAJ4vSNXl/L2aT9Po6176PFkyGv3C9QCghxEy
UFBmjWn+pY4UsXxnF2ueHaM=
=8T2G
-----END PGP SIGNATURE-----

--------------enigBD8BFC3699578F1EC5C9C98F--
