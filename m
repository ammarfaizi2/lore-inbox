Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbTA1WCn>; Tue, 28 Jan 2003 17:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbTA1WCm>; Tue, 28 Jan 2003 17:02:42 -0500
Received: from turing.fb12.de ([193.41.124.37]:45441 "HELO turing.fb12.de")
	by vger.kernel.org with SMTP id <S261495AbTA1WCl>;
	Tue, 28 Jan 2003 17:02:41 -0500
Date: Tue, 28 Jan 2003 23:12:01 +0100
From: Sebastian Benoit <benoit-lists@fb12.de>
To: "David S. Miller" <davem@redhat.com>
Cc: kuznet@ms2.inr.ac.ru, dada1@cosmosbay.com, cgf@redhat.com, andersg@0x63.nu,
       lkernel2003@tuxers.net, linux-kernel@vger.kernel.org, tobi@tobi.nu
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x, through Cisco PIX
Message-ID: <20030128231201.A32048@turing.fb12.de>
Mail-Followup-To: Sebastian Benoit <benoit-lists@fb12.de>,
	"David S. Miller" <davem@redhat.com>, kuznet@ms2.inr.ac.ru,
	dada1@cosmosbay.com, cgf@redhat.com, andersg@0x63.nu,
	lkernel2003@tuxers.net, linux-kernel@vger.kernel.org, tobi@tobi.nu
References: <200301281409.RAA28740@sex.inr.ac.ru> <20030128.103534.115458142.davem@redhat.com> <20030128201645.A29746@turing.fb12.de> <20030128.123413.51821993.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030128.123413.51821993.davem@redhat.com>; from davem@redhat.com on Tue, Jan 28, 2003 at 12:34:13PM -0800
X-MSMail-Priority: High
x-gpg-fingerprint: 2999 9839 6C9E E4BF B540  C44B 4EC4 E1BE 5BA2 2F00
x-gpg-key: http://wwwkeys.de.pgp.net:11371/pks/lookup?op=get&search=0x82AE75E4
x-gpg-keyid: 0x82AE75E4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

David S. Miller(davem@redhat.com)@2003.01.28 12:34:13 +0000:
> Thanks for testing, how about this new patch at the end of this email?
> Does it make the problem go away?

this does it!

/B.

=20
> --- net/ipv4/tcp.c.~1~	Tue Jan 28 12:40:09 2003
> +++ net/ipv4/tcp.c	Tue Jan 28 12:41:48 2003
> @@ -1089,11 +1089,13 @@
>  				if (!skb)
>  					goto wait_for_memory;
> =20
> +#if 0
>  				/*
>  				 * Check whether we can use HW checksum.
>  				 */
>  				if (sk->route_caps & (NETIF_F_IP_CSUM|NETIF_F_NO_CSUM|NETIF_F_HW_CSU=
M))
>  					skb->ip_summed =3D CHECKSUM_HW;
> +#endif
> =20
>  				skb_entail(sk, tp, skb);
>  				copy =3D mss_now;
>=20

--=20
Sebastian Benoit <benoit-lists@fb12.de>
My mail is GnuPG signed -- Unsigned ones are bogus -- http://www.gnupg.org/
GnuPG 0x5BA22F00 2001-07-31 2999 9839 6C9E E4BF B540  C44B 4EC4 E1BE 5BA2 2=
F00

The dyslexic agnostic with insomnia laid awake all night wondering if there
really was a dog.

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj43ADEACgkQTsThvluiLwAeZACfQk5CMVJdZl8SbuzzWfGzY7ym
ywUAoIjqbDLTdmMoXHD+YIx5jEdRhaVc
=Q6x8
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
