Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWGaOZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWGaOZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 10:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWGaOZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 10:25:29 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:62136 "EHLO smurf.noris.de")
	by vger.kernel.org with ESMTP id S1750849AbWGaOZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 10:25:28 -0400
Date: Mon, 31 Jul 2006 16:24:28 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: john stultz <johnstul@us.ibm.com>, ak@muc.de, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, bunk@stusta.de, lethal@linux-sh.org,
       hirofumi@mail.parknet.co.jp, asit.k.mallick@intel.com
Subject: Re: REGRESSION: the new i386 timer code fails to sync CPUs
Message-ID: <20060731142428.GF3662@kiste.smurf.noris.de>
References: <20060722173649.952f909f.akpm@osdl.org> <20060723081604.GD27566@kiste.smurf.noris.de> <20060723044637.3857d428.akpm@osdl.org> <20060723120829.GA7776@kiste.smurf.noris.de> <20060723053755.0aaf9ce0.akpm@osdl.org> <1153756738.9440.14.camel@localhost> <20060724171711.GA3662@kiste.smurf.noris.de> <20060724175150.GD50320@muc.de> <1153774443.12836.6.camel@localhost> <20060730020346.5d301bb5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I4VOKWutKNZEOIPu"
Content-Disposition: inline
In-Reply-To: <20060730020346.5d301bb5.akpm@osdl.org>
User-Agent: Mutt/1.5.11
From: Matthias Urlichs <smurf@smurf.noris.de>
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--I4VOKWutKNZEOIPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Andrew Morton:
> > Hack out the i386 TSC sync code.
> >=20
> > diff --git a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
> > index 6f5fea0..cd28914 100644
> > --- a/arch/i386/kernel/smpboot.c
> > +++ b/arch/i386/kernel/smpboot.c
> > @@ -435,7 +435,7 @@ static void __devinit smp_callin(void)
> >  	/*
> >  	 *      Synchronize the TSC with the BP
> >  	 */
> > -	if (cpu_has_tsc && cpu_khz && !tsc_sync_disabled)
> > +	if (0 && cpu_has_tsc && cpu_khz && !tsc_sync_disabled)
> >  		synchronize_tsc_ap();
> >  }
> > =20
> > @@ -1305,7 +1305,7 @@ static void __init smp_boot_cpus(unsigne
> >  	/*
> >  	 * Synchronize the TSC with the AP
> >  	 */
> > -	if (cpu_has_tsc && cpucount && cpu_khz)
> > +	if (0 && cpu_has_tsc && cpucount && cpu_khz)
> >  		synchronize_tsc_bp();
> >  }
>=20
> I guess Matthias didn't test this patch.  Can we get some obviously-corre=
ct
> fix in place for 2.6.18?
>=20
This patch doesn't change the problem.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Success is always being able to wear clothing that you actually like.
-- SJM

--I4VOKWutKNZEOIPu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEzhKc8+hUANcKr/kRAiRWAJ9OFyOEWFFGdVcab2NM3vdajVUcSQCeIgRW
YKJ0Qi2OtmSRWaxydiSTLPg=
=cRyn
-----END PGP SIGNATURE-----

--I4VOKWutKNZEOIPu--
