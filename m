Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292599AbSB0XFL>; Wed, 27 Feb 2002 18:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293030AbSB0XEq>; Wed, 27 Feb 2002 18:04:46 -0500
Received: from mailout6-0.nyroc.rr.com ([24.92.226.125]:55537 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S293029AbSB0XEH>; Wed, 27 Feb 2002 18:04:07 -0500
Subject: Re: ext3 and undeletion
From: James D Strandboge <jstrand1@rochester.rr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E16gCdF-00069W-00@the-village.bc.nu>
In-Reply-To: <E16gCdF-00069W-00@the-village.bc.nu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-keDjmksehpr0t0eM4Wog"
X-Mailer: Evolution/1.0.2 
Date: 27 Feb 2002 18:03:56 -0500
Message-Id: <1014851036.19931.90.camel@hedwig.strandboge.cxm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-keDjmksehpr0t0eM4Wog
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-02-27 at 17:33, Alan Cox wrote:
> > /root/.bashrc /etc/fstab'), wouldn't 'cp' (or most any other app) first
> > unlink the first file (/etc/fstab), then create and write the new one?
>=20
> Unlikely - It will truncate it and write over it. Try strace cp 8)

Excellent, then I am totally missing something!

Then truncate would have to be implemented, for the very limited case of
using 'cp'.  ;-)

The mount option ('undeltrunc?') would have to be implemented.  However,
I just looked at the strace of vi for fun, and then remembered that it
uses a temporary file which is unlinked after the save.  Considering the
amount of truncates and unlinks that could potentially happen on a
system, .undelete would undoubtedly fill up quickly.  Filtering files
going into .undelete could be an option, but this would be kludgey to
put into the kernel, even for a daemon.

What is your opinion of having a mount option of 'undel' and a mount
option of 'undeltrunc'?  The defaults for mount would be to not do
either.  This way you could do something like:

mount -o undel /		# saves unlink, not truncated
mount /var			# does not save truncated or unlink
mount -o undel,undeltrunc /home	# saves unlink and truncated

A cron job or user daemon (or filter of some sort) could monitor those
directories that were mounted with undel.

Jamie

--=20
Email:        jstrand1@rochester.rr.com
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A

--=-keDjmksehpr0t0eM4Wog
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAjx9ZdwACgkQqnXcviY4SjrwIwCfX9rAvO3e3RtwnuilmIYTtPr+
XZMAoIL/lh+YrMlQim1mj63rXJ5wwzLP
=lWv7
-----END PGP SIGNATURE-----

--=-keDjmksehpr0t0eM4Wog--

