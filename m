Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268122AbTBMWf3>; Thu, 13 Feb 2003 17:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268121AbTBMWf3>; Thu, 13 Feb 2003 17:35:29 -0500
Received: from aramis.rutgers.edu ([128.6.4.2]:56451 "EHLO aramis.rutgers.edu")
	by vger.kernel.org with ESMTP id <S268122AbTBMWf1>;
	Thu, 13 Feb 2003 17:35:27 -0500
Subject: Re: O_DIRECT foolish question
From: Bruno Diniz de Paula <diniz@cs.rutgers.edu>
To: Andrew Morton <akpm@digeo.com>
Cc: cw@f00f.org, linux-kernel@vger.kernel.org
In-Reply-To: <20030213093144.23ff268e.akpm@digeo.com>
References: <20030212140338.6027fd94.akpm@digeo.com>
	 <1045088991.4767.85.camel@urca.rutgers.edu>
	 <20030212224226.GA13129@f00f.org>
	 <1045090977.21195.87.camel@urca.rutgers.edu>
	 <20030212232443.GA13339@f00f.org>
	 <1045092802.4766.96.camel@urca.rutgers.edu>
	 <20030212233846.GA13540@f00f.org>
	 <1045093775.21195.99.camel@urca.rutgers.edu>
	 <20030212235130.GA13629@f00f.org>
	 <1045094589.4767.106.camel@urca.rutgers.edu>
	 <20030213001302.GA13833@f00f.org>
	 <1045096579.21195.121.camel@urca.rutgers.edu>
	 <20030212211221.3f73ba45.akpm@digeo.com>
	 <1045149719.4766.126.camel@urca.rutgers.edu>
	 <20030213093144.23ff268e.akpm@digeo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3EA0qonZEF6HECRpMELX"
Organization: Rutgers University
Message-Id: <1045176317.938.1.camel@urca.rutgers.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Feb 2003 17:45:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3EA0qonZEF6HECRpMELX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

it worked perfectly on my box. Now I am going to try in my experiments
environment and I'll let you know if everything was ok.

Thanks a lot,

Bruno.

PS: BTW, is this patch going to be added to 2.4 kernel?

On Thu, 2003-02-13 at 12:31, Andrew Morton wrote:
> Bruno Diniz de Paula <diniz@cs.rutgers.edu> wrote:
> >
> > Thanks, Andrew. So, no chances of getting this working correctly on 2.4
> > kernel for now (I mean, reading files with size !=3D n*block_size), and
> > I'd better give up on this... Is it the case, or you think there is
> > still something to do to get this working on ext2 and 2.4 kernel?
> >=20
>=20
> Oh I think we can probably fix this up.  Can you test this diff?
>=20
>=20
> diff -puN fs/buffer.c~o_direct-length-fix fs/buffer.c
> --- 24/fs/buffer.c~o_direct-length-fix	2003-02-13 09:23:34.000000000 -080=
0
> +++ 24-akpm/fs/buffer.c	2003-02-13 09:24:39.000000000 -0800
> @@ -2107,7 +2107,7 @@ int generic_direct_IO(int rw, struct ino
>  	int length;
> =20
>  	length =3D iobuf->length;
> -	nr_blocks =3D length / blocksize;
> +	nr_blocks =3D (length + blocksize - 1) / blocksize;
>  	/* build the blocklist */
>  	for (i =3D 0; i < nr_blocks; i++, blocknr++) {
>  		struct buffer_head bh;
> @@ -2148,6 +2148,10 @@ int generic_direct_IO(int rw, struct ino
>  	retval =3D brw_kiovec(rw, 1, &iobuf, inode->i_dev, iobuf->blocks, block=
size);
>  	/* restore orig length */
>  	iobuf->length =3D length;
> +
> +	/* Return correct value for reads at eof */
> +	if (retval > 0 && retval > length)
> +		retval =3D length;
>   out:
> =20
>  	return retval;
>=20
> _
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
Bruno Diniz de Paula <diniz@cs.rutgers.edu>
Rutgers University

--=-3EA0qonZEF6HECRpMELX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+TB/9ZGORSF4wrt8RAg0ZAJ4qYCMisk1CsbjCPWdJ7qneLMHthACfQd9u
mOIofDiV6dFw9LvNcEn7SAY=
=iM3o
-----END PGP SIGNATURE-----

--=-3EA0qonZEF6HECRpMELX--

