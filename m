Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbULHU1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbULHU1t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 15:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbULHU1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 15:27:49 -0500
Received: from admingilde.org ([213.95.21.5]:28628 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S261357AbULHU1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 15:27:45 -0500
Date: Wed, 8 Dec 2004 21:27:13 +0100
From: Martin Waitz <tali@admingilde.org>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] new timeofday core subsystem (v.A1)
Message-ID: <20041208202713.GA4663@admingilde.org>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <1102470914.1281.27.camel@cog.beaverton.ibm.com> <1102470997.1281.30.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <1102470997.1281.30.camel@cog.beaverton.ibm.com>
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
X-Hashcash: 0:041208:johnstul@us.ibm.com:6e6f0c86507b35de
X-Hashcash: 0:041208:linux-kernel@vger.kernel.org:ac2f8ff929a0ba61
X-Spam-Score: -12.9 (------------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Dec 07, 2004 at 05:56:38PM -0800, john stultz wrote:
> +struct timesource_t {

usually only typedefs end with _t

> +	char* name;
> +	int priority;
> +	enum {
> +		TIMESOURCE_FUNCTION,
> +		TIMESOURCE_MMIO_32,
> +		TIMESOURCE_MMIO_64
> +	} type;
> +	cycle_t (*read_fnct)(void);
> +	void* ptr;

This could be made __iomem if it is intended to point to an IO memory regio=
n.
Hmm, but then there is no ioread64, so I guess I'm wrong.

> +	cycle_t mask;
> +	u32 mult;
> +	u32 shift;
> +};

> +static inline nsec_t cyc2ns(struct timesource_t* ts, cycle_t cycles, cyc=
le_t* rem)
> +{
> +	u64 ret;
> +	ret =3D (u64)cycles;
> +	ret *=3D ts->mult;
> +	ret >>=3D ts->shift;
> +	if (rem) /* XXX we still need to do remainder math */
> +		*rem =3D (cycle_t)0;
> +	return (nsec_t)ret;
> +}

well, the math is simple:
	if (rem) *rem =3D ret & (1 << ts->shift -1);
	ret >>=3D ts->shift;


--=20
Martin Waitz

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBt2Ogj/Eaxd/oD7IRAserAJoDFi3LfpnbriG1zXyYB1lko8RhywCfWiwx
m+AytjNZivW6IwCdHkKGt5o=
=4GQ7
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--

