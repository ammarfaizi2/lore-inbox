Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262781AbVBBXfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbVBBXfI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 18:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbVBBXc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 18:32:58 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:2323 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S262857AbVBBX2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 18:28:32 -0500
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
	crypto_tfm
From: Fruhwirth Clemens <clemens@endorphin.org>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       michal@logix.cz, "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Xine.LNX.4.44.0502021728140.5000-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0502021728140.5000-100000@thoron.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rVbCTnqF52gFX2or6WJl"
Date: Thu, 03 Feb 2005 00:28:29 +0100
Message-Id: <1107386909.19339.9.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rVbCTnqF52gFX2or6WJl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-02-02 at 17:46 -0500, James Morris wrote:
> On Sun, 30 Jan 2005, Fruhwirth Clemens wrote:
> > James, please test it against ipsec. I'm confident, that everything wil=
l
> > work as expected and we can proceed to merge padlock-multiblock against=
 this
> > scatterwalker, so please Andrew, merge after a successful test of James=
.
>=20
> This code tests ok with IPSec, and delivers some good performance
> improvements.  e.g. FTP transfers over transport mode AES over GigE sped
> up with this patch applied on one side of the connection by 20% for send
> and 15% for receive.

Fine, nice to hear that!

> There are quite a few coding style and minor issues to be fixed (per=20
> below), and the code should probably then be tested in the -mm tree for a=
=20
> while (2.6.11 is too soon for mainline merge).
>=20
> > +static int ecb_process_gw(void *_priv, int nsg, void **buf)=20

> What does _gw mean?

generic walker.. can be removed, if you like.

> > +struct cbc_process_priv {
> > +	struct crypto_tfm *tfm;
> > +	int enc;
> > +	cryptfn_t *crfn;
> > +	u8 *curIV;
> > +	u8 *nextIV;
> > +};
>=20
> No caps please, I suggest curr_iv and next_iv.

Ack, cipher.c is underscore style. But my LRW private helper lib
gfmulseq.c is going to stay lowerCamelCase. I hope that's ok for
everyone. If not, the one concerned should post a reformat patch.

> > +		r =3D pf(priv, nsl, dispatch_list);
> > +		if(unlikely(r < 0))
> > +			goto out;
>=20
> Not sure if the unlikely() is justified here, given that this is not a=20
> fast path.  I guess it doesn't do any harm.

I suspected unlikely to be a hint for the compiler to do better jump
prediction and speculations. Remove?

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-rVbCTnqF52gFX2or6WJl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCAWIdW7sr9DEJLk4RArvPAJ9Y49fjmDQ3sHnDiiJ43zc5kGBHqwCcDtS3
BtGRoyra4FEohoqD59P7CrU=
=RqED
-----END PGP SIGNATURE-----

--=-rVbCTnqF52gFX2or6WJl--
