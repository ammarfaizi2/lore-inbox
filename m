Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbULIHc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbULIHc4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 02:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbULIHc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 02:32:56 -0500
Received: from admingilde.org ([213.95.21.5]:59354 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S261471AbULIHct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 02:32:49 -0500
Date: Thu, 9 Dec 2004 08:32:33 +0100
From: Martin Waitz <tali@admingilde.org>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] new timeofday core subsystem (v.A1)
Message-ID: <20041209073233.GB4663@admingilde.org>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>,
	linux-kernel@vger.kernel.org
References: <1102470914.1281.27.camel@cog.beaverton.ibm.com> <1102470997.1281.30.camel@cog.beaverton.ibm.com> <20041208202713.GA4663@admingilde.org> <1102555933.1281.301.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <1102555933.1281.301.camel@cog.beaverton.ibm.com>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.6+20040907i
X-Hashcash: 0:041209:johnstul@us.ibm.com:86c99ec6249c3e1e
X-Hashcash: 0:041209:linux-kernel@vger.kernel.org:70488d6a98f0c551
X-Spam-Score: -12.9 (------------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Dec 08, 2004 at 05:32:13PM -0800, john stultz wrote:
> Ah, actually, you missed something. The remainder you propose above is
> in units of cycles multiplied by mult. Thus to get it back to just
> cycles, we have to divide. So:
>=20
> 	ret *=3D ts->mult;
> 	if (rem)
> 		*rem =3D (ret & (1 << ts->shift -1))/mult;
> 	ret >>=3D ts->shift;

you are of course right

> Agreed?

well, divisions are always slow and we would loose precision again.

I have another suggestion: just keep the remainder in units of
cycles*mult.

	ret *=3D ts->mult
	if (rem) {
		ret +=3D *rem;
		*rem =3D ret & (1 << ts->shift -1);
	}
	ret >>=3D ts->shift

and remove the offset_base adjustion below.

--=20
Martin Waitz

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBt/+Rj/Eaxd/oD7IRAmKIAJ9DZimOuXHT+LxPiQpI1ScoGu4HHACfSdfT
I/3/mGkMwVF2KEYo4eglGoo=
=SwuA
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--

