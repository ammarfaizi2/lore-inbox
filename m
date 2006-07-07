Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWGGU1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWGGU1h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 16:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWGGU1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 16:27:37 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:38309 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751242AbWGGU1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 16:27:36 -0400
Date: Fri, 7 Jul 2006 22:27:06 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       se.witt@gmx.de
Subject: Re: lost cpufreq (Re: Linux v2.6.18-rc1)
Message-ID: <20060707202706.GD7648@irc.pl>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, se.witt@gmx.de
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org> <20060707175239.GB7648@irc.pl> <20060707190739.GB5818@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Content-Disposition: inline
In-Reply-To: <20060707190739.GB5818@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 07, 2006 at 03:07:39PM -0400, Dave Jones wrote:
> On Fri, Jul 07, 2006 at 07:52:39PM +0200, Tomasz Torcz wrote:
>  > On Wed, Jul 05, 2006 at 09:26:35PM -0700, Linus Torvalds wrote:
>  > >=20
>  > > Ok,
>  > >  the merge window for 2.6.18 is closed, and -rc1 is out there
>  >=20
>  >   ... and cpufreq-nforce2.ko fails to work. Module can't be loaded:
>  > FATAL: Error inserting cpufreq_nforce2
>  > (/lib/modules/2.6.18-rc1/kernel/arch/i386/kernel/cpu/cpufreq/cpufreq-n=
force2.ko):
>  > Device or resource busy
>  >=20
>  >   Here's relevant difference between dmesg of 2.6.17 and 2.6.18-rc1:
>  >=20
>  > @@ -244,7 +240,6 @@
>  >  lp: driver loaded but no devices found
>  >  cpufreq: Detected nForce2 chipset revision C1
>  >  cpufreq: FSB changing is maybe unstable and can lead to crashes and d=
ata loss.
>  > -cpufreq: FSB currently at 165 MHz, FID 10.5
>  >  usbcore: registered new driver usbfs
>  >  usbcore: registered new driver hub
>=20
> Does it work again if you apply this patch with -R ?

  No.

>=20
> =20
> diff --git a/arch/i386/kernel/cpu/cpufreq/cpufreq-nforce2.c b/arch/i386/k=
ernel/cpu/cpufreq/cpufreq-nforce2.c
> index f275e0d..0d49d73 100644
> --- a/arch/i386/kernel/cpu/cpufreq/cpufreq-nforce2.c
> +++ b/arch/i386/kernel/cpu/cpufreq/cpufreq-nforce2.c
> @@ -90,7 +90,7 @@ static int nforce2_calc_pll(unsigned int
> =20
>  	/* Try to calculate multiplier and divider up to 4 times */
>  	while (((mul =3D=3D 0) || (div =3D=3D 0)) && (tried <=3D 3)) {
> -		for (xdiv =3D 1; xdiv <=3D 0x80; xdiv++)
> +		for (xdiv =3D 2; xdiv <=3D 0x80; xdiv++)
>  			for (xmul =3D 1; xmul <=3D 0xfe; xmul++)
>  				if (nforce2_calc_fsb(NFORCE2_PLL(xmul, xdiv)) =3D=3D
>  				    fsb + tried) {
>=20
>=20
> --=20
> http://www.codemonkey.org.uk
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--=20
Tomasz Torcz                 Morality must always be based on practicality.
zdzichu@irc.-nie.spam-.pl                -- Baron Vladimir Harkonnen


--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFErsOaThhlKowQALQRAm7NAKDGZoobTHwVfqaQHF9bJ2ESMO2HBACgli/e
0vq+tkLjvELS91mvP9nDmKI=
=Ei3u
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--
