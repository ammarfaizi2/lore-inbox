Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269069AbUHMKah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269069AbUHMKah (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 06:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269068AbUHMKaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 06:30:30 -0400
Received: from dea.vocord.ru ([194.220.215.4]:38546 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S269058AbUHMK1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 06:27:47 -0400
Subject: Re: [2.6 patch] let W1 select NET
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040813101717.GS13377@fs.tum.de>
References: <20040813101717.GS13377@fs.tum.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7yVYhr7+ziMIpUOonO7M"
Organization: MIPT
Message-Id: <1092393095.12729.424.camel@uganda>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 Aug 2004 14:31:35 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7yVYhr7+ziMIpUOonO7M
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-08-13 at 14:17, Adrian Bunk wrote:
> W1=3Dy and Net=3Dn fails with the following compile error:
>=20
> <--  snip  -->
>=20
> ...
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0x5efa38): In function `w1_alloc_dev':
> : undefined reference to `netlink_kernel_create'
> drivers/built-in.o(.text+0x5efac1): In function `w1_alloc_dev':
> : undefined reference to `sock_release'
> drivers/built-in.o(.text+0x5efb31): In function `w1_free_dev':
> : undefined reference to `sock_release'
> drivers/built-in.o(.text+0x5f0014): In function `w1_netlink_send':
> : undefined reference to `alloc_skb'
> drivers/built-in.o(.text+0x5f00cd): In function `w1_netlink_send':
> : undefined reference to `netlink_broadcast'
> drivers/built-in.o(.text+0x5f0131): In function `w1_netlink_send':
> : undefined reference to `skb_over_panic'
> make: *** [.tmp_vmlinux1] Error 1
>=20
> <--  snip  -->
>=20
>=20
> The patch below fixes this issue by letting W1 select NET.

Sure.
W1 requires netlink and thus CONFIG_NET.

Thank you.
I've applied your patch to my tree=20
and will send it to GregKH -> Andrew Morton.

>=20
> Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
>=20
> --- linux-2.6.8-rc4-mm1-full-3.4/drivers/w1/Kconfig.old	2004-08-13 12:00:=
05.000000000 +0200
> +++ linux-2.6.8-rc4-mm1-full-3.4/drivers/w1/Kconfig	2004-08-13 12:11:31.0=
00000000 +0200
> @@ -2,6 +2,7 @@
> =20
>  config W1
>  	tristate "Dallas's 1-wire support"
> +	select NET
>  	---help---
>  	  Dallas's 1-wire bus is usefull to connect slow 1-pin devices=20
>  	  such as iButtons and thermal sensors.
--=20
	Evgeniy Polyakov ( s0mbre )

Crash is better than data corruption. -- Art Grabowski

--=-7yVYhr7+ziMIpUOonO7M
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBHJiHIKTPhE+8wY0RAsH6AJ9vBZVJ+kmk84VPSRLon7hO9ZbzUwCeJ3oO
1wx2lqvyW513atME90rWJ8Q=
=9jkB
-----END PGP SIGNATURE-----

--=-7yVYhr7+ziMIpUOonO7M--

