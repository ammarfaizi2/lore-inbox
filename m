Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292979AbSB0WRY>; Wed, 27 Feb 2002 17:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293017AbSB0WQl>; Wed, 27 Feb 2002 17:16:41 -0500
Received: from mailout6-0.nyroc.rr.com ([24.92.226.125]:45480 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S292507AbSB0WQZ>; Wed, 27 Feb 2002 17:16:25 -0500
Subject: Re: ext3 and undeletion
From: James D Strandboge <jstrand1@rochester.rr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E16gBoU-0005wL-00@the-village.bc.nu>
In-Reply-To: <E16gBoU-0005wL-00@the-village.bc.nu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-tIYW89iu//UDsvFYWcYn"
X-Mailer: Evolution/1.0.2 
Date: 27 Feb 2002 17:16:10 -0500
Message-Id: <1014848170.18953.57.camel@hedwig.strandboge.cxm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tIYW89iu//UDsvFYWcYn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-02-27 at 16:40, Alan Cox wrote:
> > Rather than modifying all the different filesystems, or libc, we could
> > modify the VFS unlink function in the kernel.  It would therefore work
>=20
> What about every data loss caused by truncate, overwriting etc..
>
This is a good point.  The easiest answer is 'that is what backups are
for'.  :-)=20

More seriously, truncate could be implemented in the truncate calls in
VFS as well, but this would have to be a copy to .undelete rather than a
simple link change.  I am not sure implementing truncate in undelete
would be that great of an idea though.  Many apps will truncate files
only to update them again, which would result in the .undelete directory
filling the disk.  This could be implemented with an optional mount
option and having the default be to not copy truncated files to
.undelete.

Unless I am missing something, overwrite should be handled by the change
to VFS sys_unlink transparently.  If a file is overwritten (eg 'cp
/root/.bashrc /etc/fstab'), wouldn't 'cp' (or most any other app) first
unlink the first file (/etc/fstab), then create and write the new one?

Jamie Strandboge

--=20
Email:        jstrand1@rochester.rr.com
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A

--=-tIYW89iu//UDsvFYWcYn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAjx9WqkACgkQqnXcviY4SjpXOQCeMYxyaj8U8Pw8c95f21aCaSlf
nnoAn0wOaMcR356DTlB/oZqfM0o3CobH
=GGCM
-----END PGP SIGNATURE-----

--=-tIYW89iu//UDsvFYWcYn--

