Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263616AbUEPPDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263616AbUEPPDH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 11:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbUEPPDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 11:03:07 -0400
Received: from mail018.syd.optusnet.com.au ([211.29.132.72]:57830 "EHLO
	mail018.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263616AbUEPPC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 11:02:58 -0400
Date: Mon, 17 May 2004 01:02:48 +1000
From: Andrew Lau <netsnipe@users.sourceforge.net>
To: Simon Kelley <simon@thekelleys.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Atmel at76c50x PCMCIA 2.6.6 kernel panic
Message-ID: <20040516150248.GA19286@espresso>
References: <20040511134101.GA19530@espresso> <40A0E1CB.20209@thekelleys.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <40A0E1CB.20209@thekelleys.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks Simon,

The patch got it going again. One other problem I'd like to bring to
your attention is that your driver doesn't seem to be too APM-happy. If
I eject the PCMCIA card and attempt to (lid-)suspend my Thinkpad R40
immediately the system can enter a hard lockup. I have to wait about 10
seconds after ejection if I want to safely suspend.

Cheers,
Andrew "Netsnipe" Lau

On Tue, May 11, 2004 at 03:23:07PM +0100, Simon Kelley wrote:
> Andrew Lau wrote:
> >Hi Simon and co.,
> >
> >My Atmel AT76C502AR_D 802.11b PCMCIA card was previously working fine
> >under the 2.6.5 kernel via the atmel/atmel_cs modules. However, since
> >upgrading to 2.6.6 I now get a kernel panic whenever I insert my card
> >and hotplug (2004-03-29) attempts to upload the 0.7-1 version of Simon's
> >firmware <http://thekelleys.org.uk/atmel/>. I've provided as much
> >debugging information as I can below, so feel free to let me know if
> >I've missed out on anything.
> >
> >Thanks in advanced,
> >Andrew "Netsnipe" Lau
> >
> >PS: Please CC: me as I'm not on LKML.
> >
>=20
> Sorry 'bout that: I believe that this is a casualty of ongoing=20
> driver-model changes. I have the following patch which purports to work=
=20
> around the problem. Please could you try i and let me know:
>=20
>=20
> Cheers,
>=20
> Simon.
>=20
> --- linux.orig/drivers/net/wireless/atmel_cs.c
> +++ linux/drivers/net/wireless/atmel_cs.c
> @@ -350,6 +350,9 @@ static struct {
>=20
>  static struct device atmel_device =3D {
>          .bus_id    =3D "pcmcia",
> +	.kobj =3D {
> +		.k_name =3D "atmel_cs"
> +	}
>  };
>=20
>  static void atmel_config(dev_link_t *link)
>=20

--=20
---------------------------------------------------------------------------
	Andrew "Netsnipe" Lau	<http://www.cse.unsw.edu.au/~alau/>
 Debian GNU/Linux Maintainer & UNSW Computing Students' Society President
				     -
		  "Nobody expects the Debian Inquisition!
     Our two weapons are fear and surprise...and ruthless efficiency!"
---------------------------------------------------------------------------

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAp4KYmyTAfS6LaL0RAlrfAJ9Qhh6ILQcqXu4yXo6hCCaW98VqNgCfbSS1
AKhDAL8htnJ5vl5Fz7sTyRc=
=l4Yi
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
