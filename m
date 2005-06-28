Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262550AbVF2LLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbVF2LLI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 07:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVF2LLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 07:11:07 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:33226 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S262550AbVF2LKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 07:10:37 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: coverity-desc-bitmap-overrun-fix-fix
Date: Tue, 28 Jun 2005 20:10:08 +0200
User-Agent: KMail/1.7.2
References: <BAY19-F38CD6342E8B675570A6E179CE10@phx.gbl> <20050628040045.7a829f77.akpm@osdl.org>
In-Reply-To: <20050628040045.7a829f77.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1719911.NrPNnbtZU7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506282010.13916.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1719911.NrPNnbtZU7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Andrew,
hi lkml,

On Tuesday 28 June 2005 13:00, you wrote:
> From a maintainability POV it would be better to memset the whole array
> beforehand - I changed the patch to do that)
=20
Yes, but then you should not assign 0xff to memset regions.

> Signed-off-by: Zaur Kambarov <zkambarov@coverity.com>
> Cc: <linux-usb-devel@lists.sourceforge.net?
> Cc: Greg KH <greg@kroah.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>=20
>  drivers/usb/host/ohci-hub.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff -puN drivers/usb/host/ohci-hub.c~coverity-desc-bitmap-overrun-fix dr=
ivers/usb/host/ohci-hub.c
> --- 25/drivers/usb/host/ohci-hub.c~coverity-desc-bitmap-overrun-fix	2005-=
06-24 22:11:00.000000000 -0700
> +++ 25-akpm/drivers/usb/host/ohci-hub.c	2005-06-24 22:19:48.000000000 -07=
00
> @@ -419,10 +419,11 @@ ohci_hub_descriptor (
> =20
>  	/* two bitmaps:  ports removable, and usb 1.0 legacy PortPwrCtrlMask */
>  	rh =3D roothub_b (ohci);
> +	memset(desc->bitmap, 0xff, sizeof(desc->bitmap));
>  	desc->bitmap [0] =3D rh & RH_B_DR;
>  	if (ports > 7) {
>  		desc->bitmap [1] =3D (rh & RH_B_DR) >> 8;
> -		desc->bitmap [2] =3D desc->bitmap [3] =3D 0xff;
> +		desc->bitmap [2] =3D 0xff;
>  	} else
>  		desc->bitmap [1] =3D 0xff;
>  }

I would suggest:

	if (ports > 7)=20
		desc->bitmap[1] =3D (rh & RH_B_DR) >> 8

instead of the whole if construct.

Regards

Ingo Oeser


--nextPart1719911.NrPNnbtZU7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCwZKFU56oYWuOrkARAnR0AKCJt5nYpUfWk6rMHPuTRaLcwYOcXwCgv/44
f2gPQv/eEerJREt3hJJX3gc=
=6MjV
-----END PGP SIGNATURE-----

--nextPart1719911.NrPNnbtZU7--
