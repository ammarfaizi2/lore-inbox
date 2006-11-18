Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755198AbWKRQ5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198AbWKRQ5w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 11:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755189AbWKRQ5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 11:57:51 -0500
Received: from crystal.sipsolutions.net ([195.210.38.204]:41681 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1755180AbWKRQ5v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 11:57:51 -0500
Subject: Re: bcm43xx regression 2.6.19rc3 -> rc5, rtnl_lock trouble?
From: Johannes Berg <johannes@sipsolutions.net>
To: Joseph Fannin <jhf@columbus.rr.com>
Cc: Ray Lee <ray-lk@madrabbit.org>, Larry Finger <Larry.Finger@lwfinger.net>,
       Bcm43xx-dev@lists.berlios.de, LKML <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, John Linville <linville@tuxdriver.com>,
       Michael Buesch <mb@bu3sch.de>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061118112438.GB15349@nineveh.rivenstone.net>
References: <455B63EC.8070704@madrabbit.org>
	 <20061118112438.GB15349@nineveh.rivenstone.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GYTok38B2melWxge36NU"
Date: Sat, 18 Nov 2006 17:55:55 +0100
Message-Id: <1163868955.27188.2.camel@johannes.berg>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
X-sips-origin: submit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GYTok38B2melWxge36NU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-11-18 at 06:24 -0500, Joseph Fannin wrote:

>     This sounds like what my laptop was doing in -rc5, though mine
> didn't take hours to start acting up.
>=20
>     I *think* it was the MSI troubles, causing interrupts to get
> lost forever.  Anyway, it went away in -rc6.

Hah, that's a lot more plausible than bcm43xx's drain patch actually
causing this. So maybe somehow interrupts for bcm43xx aren't routed
properly or something...

Ray, please check /proc/interrupts when this happens.

I am convinced that the patch in question (drain tx status) is not
causing this -- the patch should be a no-op in most cases anyway, and in
those cases where it isn't a no-op it'll run only once at card init and
remove some things from a hardware-internal FIFO.

johannes

--=-GYTok38B2melWxge36NU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFXzsb/ETPhpq3jKURAm80AJ44eSZHzQHOfpvhKLL3DVH+N2lF3QCgopKQ
ZbcPCp+FSe3daOEimqJv4n8=
=BC0X
-----END PGP SIGNATURE-----

--=-GYTok38B2melWxge36NU--

