Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286521AbSCKSg4>; Mon, 11 Mar 2002 13:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285424AbSCKSfS>; Mon, 11 Mar 2002 13:35:18 -0500
Received: from [217.79.102.244] ([217.79.102.244]:21998 "EHLO
	monkey.beezly.org.uk") by vger.kernel.org with ESMTP
	id <S286521AbSCKSfE>; Mon, 11 Mar 2002 13:35:04 -0500
Subject: Re: Sun GEM card looses TX on x86 32bit PCI
From: Beezly <beezly@beezly.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020311.042124.103955441.davem@redhat.com>
In-Reply-To: <20020310.164350.107967417.davem@redhat.com>
	<1015834777.1802.8.camel@monkey> <1015849164.2153.3.camel@monkey> 
	<20020311.042124.103955441.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-2WTo7g6NxiSiUQwrMa/C"
X-Mailer: Evolution/1.0.2 
Date: 11 Mar 2002 18:35:01 +0000
Message-Id: <1015871701.2832.1.camel@monkey>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2WTo7g6NxiSiUQwrMa/C
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi David,

Sorry it took so long for me to get back to you. Sadly it also hung with
this patch ;) I was unable to get an oops out of it (machine was
completely hosed and in X so I couldn't even note the oops on paper :(
).

Beezly

On Mon, 2002-03-11 at 12:21, David S. Miller wrote:
>    From: Beezly <beezly@beezly.org.uk>
>    Date: 11 Mar 2002 12:19:24 +0000
>=20
>    I managed to run the latest patch, but it appears to Oops when the
>    overflow condition occurs. Sadly I was not able to get the output of t=
he
>    oops... but it was at exactly the same time that I was run my "test"
>    which causes the RX to halt.
>=20
> Duh, this will fix it:
>=20
> --- drivers/net/sungem.c.~1~	Mon Mar 11 04:18:58 2002
> +++ drivers/net/sungem.c	Mon Mar 11 04:24:13 2002
> @@ -317,7 +317,7 @@
>  	}
> =20
>  	/* Second, disable RX DMA. */
> -	writel(0, RXDMA_CFG);
> +	writel(0, gp->regs + RXDMA_CFG);
>  	for (limit =3D 0; limit < 5000; limit++) {
>  		if (!(readl(gp->regs + RXDMA_CFG) & RXDMA_CFG_ENABLE))
>  			break;


--=-2WTo7g6NxiSiUQwrMa/C
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8jPjVXu4ZFsMQjPgRAmSWAKDH0+GZdRbMNpVoh4VBvJElwiucpACeJWJE
wpiSQy0j0v0Z9wp+YvOqJpI=
=yVYr
-----END PGP SIGNATURE-----

--=-2WTo7g6NxiSiUQwrMa/C--
