Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293039AbSB1A37>; Wed, 27 Feb 2002 19:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293116AbSB1A3t>; Wed, 27 Feb 2002 19:29:49 -0500
Received: from mailout6-0.nyroc.rr.com ([24.92.226.125]:28308 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S293101AbSB1A3f>; Wed, 27 Feb 2002 19:29:35 -0500
Subject: Re: ext3 and undeletion
From: James D Strandboge <jstrand1@rochester.rr.com>
To: alan@lxorguk.ukuu.org.uk
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1014851036.19931.90.camel@hedwig.strandboge.cxm>
In-Reply-To: <E16gCdF-00069W-00@the-village.bc.nu> 
	<1014851036.19931.90.camel@hedwig.strandboge.cxm>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-1dvHskwZrbUPMKO1azH6"
X-Mailer: Evolution/1.0.2 
Date: 27 Feb 2002 19:29:01 -0500
Message-Id: <1014856142.18953.116.camel@hedwig.strandboge.cxm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1dvHskwZrbUPMKO1azH6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-02-27 at 18:03, James D Strandboge wrote:
=20
> What is your opinion of having a mount option of 'undel' and a mount
> option of 'undeltrunc'?  The defaults for mount would be to not do
> either.  This way you could do something like:
>=20
> mount -o undel /		# saves unlink, not truncated
> mount /var			# does not save truncated or unlink
> mount -o undel,undeltrunc /home	# saves unlink and truncated
>=20
> A cron job or user daemon (or filter of some sort) could monitor those
> directories that were mounted with undel.

In thinking about truncate more (and at least 'cp' overwrite if not
more), IMHO this is an unavoidable delete and should not be implemented
in undelete.  It would create too much overhead both in disk I/O and
coding (be it in the kernel or user space).  Moving files to a directory
to be deleted later which should have just been truncated in the first
case is too kludgey and backward.

However, for unlink there wouldn't be a big I/O problem in getting the
items into .undelete-- we are just changing links.  It should be
relatively easy to implement, not very intrusive, should be useful in
the general case (rm and gui apps) and won't cause the disk to fill up.

Jamie

--=20
Email:        jstrand1@rochester.rr.com
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A

--=-1dvHskwZrbUPMKO1azH6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAjx9ec0ACgkQqnXcviY4SjrW5wCfUquDC+qstDCxssK2nCdrnidt
kTsAn2RV9BE+UkqELCgHvFvS1KUw2Lw6
=PPjb
-----END PGP SIGNATURE-----

--=-1dvHskwZrbUPMKO1azH6--

