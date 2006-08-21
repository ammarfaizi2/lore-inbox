Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751881AbWHUOe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbWHUOe2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 10:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030468AbWHUOe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 10:34:28 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:13552 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1030512AbWHUOe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 10:34:27 -0400
Date: Mon, 21 Aug 2006 10:34:02 -0400
From: David Hollis <dhollis@davehollis.com>
Subject: Re: [PATCH] driver for mcs7830 (aka DeLOCK) USB ethernet adapter
In-reply-to: <200608202207.39709.arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, support@moschip.com,
       Michael Helmling <supermihi@web.de>
Message-id: <1156170842.2878.6.camel@dhollis-lnx.sunera.com>
MIME-version: 1.0
X-Mailer: Evolution 2.7.91 (2.7.91-5.fc6)
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-/NtVOpiqI63kUSHMv27L"
References: <200608071500.55903.arnd.bergmann@de.ibm.com>
	<1154962496.2496.12.camel@dhollis-lnx.sunera.com>
	<200608071811.09978.arnd.bergmann@de.ibm.com>
	<200608202207.39709.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/NtVOpiqI63kUSHMv27L
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-08-20 at 22:07 +0200, Arnd Bergmann wrote:

> +static int mcs7830_set_autoneg(struct usbnet *dev, int ptrUserPhyMode)
> +{
> +	int ret;
> +	/* Enable all media types */
> +	ret =3D mcs7830_write_phy(dev, MII_ADVERTISE, 0x05e1);
> +	/* First Disable All */
> +	if (!ret)
> +		ret =3D mcs7830_write_phy(dev, MII_BMCR, 0x0000);
> +	/* Enable Auto Neg */
> +	if (!ret)
> +		ret =3D mcs7830_write_phy(dev, MII_BMCR, 0x1000);
> +	/* Restart Auto Neg (Keep the Enable Auto Neg Bit Set) */
> +	if (!ret)
> +		ret =3D mcs7830_write_phy(dev, MII_BMCR, 0x1200);
> +	return ret < 0 ? : 0;
> +}

include/linux/mii.h also has defines for the flags for MII_ADVERTISE and
MII_BMCR:

So your 0x1200 can be 'BMCR_ANENABLE | BMCR_ANRESTART' for example.
Makes it easier to tell whats going on.

Other than that, it's looking pretty good.


--=20
David Hollis <dhollis@davehollis.com>

--=-/NtVOpiqI63kUSHMv27L
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE6cRaxasLqOyGHncRAmgKAJsEYGJfk58JXx/8QffLaiHn/zkfCgCfTtBf
HZoONxgTLtHwJurS7NEZKhQ=
=d53k
-----END PGP SIGNATURE-----

--=-/NtVOpiqI63kUSHMv27L--

