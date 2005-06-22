Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbVFVIrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbVFVIrF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 04:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbVFVIpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 04:45:05 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:55906 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S262928AbVFVImK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 04:42:10 -0400
Message-ID: <42B92449.10200@poczta.fm>
Date: Wed, 22 Jun 2005 10:41:45 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: mru@inprovide.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
References: <f192987705061303383f77c10c@mail.gmail.com>	<yw1xslzl8g1q.fsf@ford.inprovide.com> <42AFE624.4020403@poczta.fm>	<200506150454.11532.pmcfarland@downeast.net>	<42AFF184.2030209@poczta.fm> <yw1xd5qo2bzd.fsf@ford.inprovide.com>	<42B04090.7050703@poczta.fm>	<20050615212825.GS23621@csclub.uwaterloo.ca> <42B0BAF5.106@poczta.fm>	<yw1xll5a1vyd.fsf@ford.inprovide.com> <42B43424.6090708@poczta.fm> <yw1xekazs10v.fsf@ford.inprovide.com>
In-Reply-To: <yw1xekazs10v.fsf@ford.inprovide.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7D78AF2ACEBCEEEFEAE91A01"
X-EMID: 20b1a138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7D78AF2ACEBCEEEFEAE91A01
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

M=C3=A5ns Rullg=C3=A5rd napisa=C5=82(a):

>>>That's exactly how ext3, reiserfs, xfs, jfs, etc. all work.  A few
>>>filesystems are tagged as using some specific encoding.  If your
>>>filesystem is marked for iso-8859-1, what should a kernel with a
>>>conversion mechanism do if a user tries to name a file =EA=B9=80?
>>
>>Return -ENOENT? I am guessing.
>=20
>=20
> Doesn't seem very friendly.

Well, if user marks her fs as iso-8859-1 that means that she doesn't
want it to contain filenames unrepresentable in this particular
codepage. Aleksey has begun the whole thread because in Russia there are
several, equally popular, different encodings for the same alphabet. And
in this context his proposal is quite good: develope general, fs
independent NLS layer.

>>But please tell me what should do userland software if it runs with
>>locale set to something.iso-8859-2 and finds =EA=B9=80 in the directory=
?
>=20
>=20
> I suppose it will display =C4=99=C5=A1 (0x80 doesn't seem be a printabl=
e
> iso-8859-2 character).  You told it to use iso-8859-2 in the first
> place, so what do you expect?

ls(1) displays either \0nnn or ?. Or maybe some other mangling could be
done, however, octal representation seems to be ok.


>>That is the same problem. And for now ISO 8-bit encodings are far
>>more popular and usefull with contemporary tools than UTF-8.
>=20
>=20
> ISO 8-bit encodings are more common with characters they can
> represent.  These are a small minority of all characters commonly
> used.

OK. Let me be more general: fixed char width encodings. AFAIK Japanese
encodigs use 16bits, yet it is still fixed width.

>>That is why I think suggestion of a layer in the kernel that would
>>translate filenames form utf-8 stored on the media to e.g. latin2
>>used by tools is quite reasonable. Especially when there is more
>>than one encoding for a particular language (think Russian,
>>Polish). Even more, with such a facility transition would be much
>>more greaceful since you could have utf-8 filesystem and then you
>>can worry about tools other tools. The filesystem is already
>>populated with UFT-8 names.
>=20
>=20
> How is the kernel to know what to translate to/from?

Mount options. See the letter from Kyle Moffett
<C960854D-7EA5-4DD7-8F2B-7021092CE3EB@mac.com>


[ good filesystem for portable media ]
>>That's why IMHO FAT is quite enough for this purpose.
>=20
> FAT has a bad habit of constantly hammering the same sectors over and
> over.  This can wear out cheap flash media in no time at all.

Maybe. I don't think that digital cameras or audio players will suppoty
UDF though. But that is something completly differnent.

--=20
By=C2=B3o mi bardzo mi=C2=B3o.                    Trzecia pospolita kl=C3=
=AAska, [...]
>=C2=A3ukasz<                      Ju=C2=BF nie katolicka lecz z=C2=B3odz=
iejska.  (c)PP


--------------enig7D78AF2ACEBCEEEFEAE91A01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCuSRNNdzY8sm9K9wRAnZXAJ4soyTcpZ7fsAqnF2l4ocuebAn2gwCeOEyc
EUEEErfiPXGJ4thfPXHnfwU=
=QDuu
-----END PGP SIGNATURE-----

--------------enig7D78AF2ACEBCEEEFEAE91A01--
