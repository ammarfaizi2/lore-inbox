Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVCULbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVCULbG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 06:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVCULbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 06:31:06 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:21522 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261753AbVCULbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 06:31:02 -0500
Subject: Re: [5/5] [CRYPTO] Optimise kmap calls in crypt()
From: Fruhwirth Clemens <clemens@endorphin.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: James Morris <jmorris@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cryptoapi@lists.logix.cz
In-Reply-To: <20050321095322.GE23235@gondor.apana.org.au>
References: <20050321094047.GA23084@gondor.apana.org.au>
	 <20050321094807.GA23235@gondor.apana.org.au>
	 <20050321094939.GB23235@gondor.apana.org.au>
	 <20050321095057.GC23235@gondor.apana.org.au>
	 <20050321095208.GD23235@gondor.apana.org.au>
	 <20050321095322.GE23235@gondor.apana.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xSV7SU6l8vnQLc9Y9N1S"
Date: Mon, 21 Mar 2005 12:30:59 +0100
Message-Id: <1111404659.12532.9.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xSV7SU6l8vnQLc9Y9N1S
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-03-21 at 20:53 +1100, Herbert Xu wrote:

> Perform kmap once (or twice if the buffer is not aligned correctly)
> per page in crypt() instead of the current code which does it once
> per block.  Consequently it will yield once per page instead of once
> per block.

Thanks for your work, Herbert.=20

Applying all patches results in a "does not work for me". The decryption
result is different from the original and my LUKS managed partition
refuses to mount.

I assume you have a test environment already setup, so I would suggest
to find out up to which patch the following test succeeds (should be
paste-able)

cd /tmp
dd if=3D/dev/zero of=3Dtest-crypt count=3D100
losetup /dev/loop5 /tmp/test-crypt
echo 0 100 crypt aes-plain 0123456789abcdef0123456789abcdef 0 /dev/loop5 0 =
| dmsetup create test-map
sha1sum /dev/mapper/test-map

Result:
368d017dbdb4299ed7f27d3fc815442f7e438865  /dev/mapper/test-map

Cheers,
--=20
Fruhwirth Clemens - http://clemens.endorphin.org=20
for robots: sp4mtrap@endorphin.org

--=-xSV7SU6l8vnQLc9Y9N1S
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCPrBybjN8iSMYtrsRAsnYAJ4u05hfZtE/qbh+8uFBRd+G4y8oLACgqFsx
NSUWz+L0mZ1zXdQAnaRF8QI=
=Ilku
-----END PGP SIGNATURE-----

--=-xSV7SU6l8vnQLc9Y9N1S--
