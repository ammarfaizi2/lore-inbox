Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbUKOEjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbUKOEjn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 23:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbUKOEjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 23:39:43 -0500
Received: from dea.vocord.ru ([217.67.177.50]:21975 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261428AbUKOEji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 23:39:38 -0500
Subject: Re: [PATCH] matrox w1: fix integer to pointer conversion warnings
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4197BCEE.1080409@ppp0.net>
References: <41974A6C.20302@ppp0.net>
	 <20041114230617.5ce14ce9@zanzibar.2ka.mipt.ru>  <4197BCEE.1080409@ppp0.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-k8/neLhopAux76UXAELk"
Organization: MIPT
Message-Id: <1100493835.20731.63.camel@uganda>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 15 Nov 2004 07:43:55 +0300
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Mon, 15 Nov 2004 04:39:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-k8/neLhopAux76UXAELk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-11-14 at 23:15, Jan Dittmer wrote:
> Evgeniy Polyakov wrote:
> > On Sun, 14 Nov 2004 13:07:08 +0100
> > Jan Dittmer <jdittmer@ppp0.net> wrote:
> >=20
> >=20
> >>Get rid of some pointer to integer conversion warnings
> >>in the matrox w1 bus driver.
> >=20
>=20
> You mean like this? (Incremental to the other one)

We should not treat __iomem suffix like just addition for variable
declaration, it is now part of the type I think.

So there is no char __iomem, but only void __iomem.

> Jan
>=20
>=20
> ______________________________________________________________________
> =3D=3D=3D=3D=3D matrox_w1.c 1.4 vs edited =3D=3D=3D=3D=3D
> --- 1.4/drivers/w1/matrox_w1.c	2004-11-14 13:02:18 +01:00
> +++ edited/matrox_w1.c	2004-11-14 21:15:09 +01:00
> @@ -78,12 +78,12 @@
> =20
>  struct matrox_device
>  {
> -	char *base_addr;
> -	char *port_index, *port_data;
> +	char __iomem *base_addr;
> +	char __iomem *port_index, *port_data;
>  	u8 data_mask;
> =20
>  	unsigned long phys_addr;
> -	char *virt_addr;
> +	char __iomem *virt_addr;
>  	unsigned long found;
> =20
>  	struct w1_bus_master *bus_master;
> @@ -227,7 +227,7 @@
> =20
>  	if (dev->found) {
>  		w1_remove_master_device(dev->bus_master);
> -		iounmap((void *) dev->virt_addr);
> +		iounmap(dev->virt_addr);
>  	}
>  	kfree(dev);
>  }
--=20
	Evgeniy Polyakov

Crash is better than data corruption. -- Art Grabowski

--=-k8/neLhopAux76UXAELk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBmDQLIKTPhE+8wY0RAkZ4AKCPHMMK1gOaMq+XuRp+hmykPv1c6gCdHCXa
YnPll+BOGg+6x+VtcU/P84o=
=kU8u
-----END PGP SIGNATURE-----

--=-k8/neLhopAux76UXAELk--

