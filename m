Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWCNOad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWCNOad (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 09:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWCNOac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 09:30:32 -0500
Received: from vs166246.vserver.de ([62.75.166.246]:34538 "EHLO bu3sch.de")
	by vger.kernel.org with ESMTP id S1750887AbWCNOab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 09:30:31 -0500
From: Michael Buesch <mb@bu3sch.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] hostap_{pci,plx}.c: fix memory leaks
Date: Tue, 14 Mar 2006 15:30:20 +0100
User-Agent: KMail/1.9.1
References: <20060313222841.GQ13973@stusta.de>
In-Reply-To: <20060313222841.GQ13973@stusta.de>
Cc: jkmaline@cc.hut.fi, hostap@shmoo.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart42314815.A9ZDOVLyYl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603141530.20901.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart42314815.A9ZDOVLyYl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 13 March 2006 23:28, you wrote:
> This patch fixes two memotry leaks spotted by the Coverity checker.
>=20
>=20
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>=20
> ---
>=20
>  drivers/net/wireless/hostap/hostap_pci.c |    6 +++---
>  drivers/net/wireless/hostap/hostap_plx.c |    6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>=20
> --- linux-2.6.16-rc6-mm1-full/drivers/net/wireless/hostap/hostap_pci.c.ol=
d	2006-03-13 22:34:30.000000000 +0100
> +++ linux-2.6.16-rc6-mm1-full/drivers/net/wireless/hostap/hostap_pci.c	20=
06-03-13 22:37:57.000000000 +0100
> @@ -301,14 +301,14 @@ static int prism2_pci_probe(struct pci_d
>  	struct hostap_interface *iface;
>  	struct hostap_pci_priv *hw_priv;
> =20
> +	if (pci_enable_device(pdev))
> +		return -EIO;
> +
>  	hw_priv =3D kmalloc(sizeof(*hw_priv), GFP_KERNEL);
>  	if (hw_priv =3D=3D NULL)

+               pci_disable_device(pdev);

>  		return -ENOMEM;
>  	memset(hw_priv, 0, sizeof(*hw_priv));
> =20
> -	if (pci_enable_device(pdev))
> -		return -EIO;
> -
>  	phymem =3D pci_resource_start(pdev, 0);
> =20
>  	if (!request_mem_region(phymem, pci_resource_len(pdev, 0), "Prism2")) {
> --- linux-2.6.16-rc6-mm1-full/drivers/net/wireless/hostap/hostap_plx.c.ol=
d	2006-03-13 22:39:40.000000000 +0100
> +++ linux-2.6.16-rc6-mm1-full/drivers/net/wireless/hostap/hostap_plx.c	20=
06-03-13 22:40:09.000000000 +0100
> @@ -446,14 +446,14 @@ static int prism2_plx_probe(struct pci_d
>  	int tmd7160;
>  	struct hostap_plx_priv *hw_priv;
> =20
> +	if (pci_enable_device(pdev))
> +		return -EIO;
> +
>  	hw_priv =3D kmalloc(sizeof(*hw_priv), GFP_KERNEL);
>  	if (hw_priv =3D=3D NULL)

Seems like pci_disable_device should be done here, too.

>  		return -ENOMEM;
>  	memset(hw_priv, 0, sizeof(*hw_priv));
> =20
> -	if (pci_enable_device(pdev))
> -		return -EIO;
> -
>  	/* National Datacomm NCP130 based on TMD7160, not PLX9052. */
>  	tmd7160 =3D (pdev->vendor =3D=3D 0x15e8) && (pdev->device =3D=3D 0x0131=
);

=2D-=20
Greetings Michael.

--nextPart42314815.A9ZDOVLyYl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEFtN8lb09HEdWDKgRAlyNAJsGh7BkxnBz5QlC9pBiTk7YWvKKvwCgjdks
qZqO0eX+QIJ6iA5myl3ZHGQ=
=Qlfa
-----END PGP SIGNATURE-----

--nextPart42314815.A9ZDOVLyYl--
