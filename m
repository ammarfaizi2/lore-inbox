Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753985AbWKHD4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753985AbWKHD4V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 22:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754086AbWKHD4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 22:56:21 -0500
Received: from mail.isohunt.com ([69.64.61.20]:7404 "EHLO mail.isohunt.com")
	by vger.kernel.org with ESMTP id S1753985AbWKHD4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 22:56:20 -0500
X-Spam-Check-By: mail.isohunt.com
Date: Tue, 7 Nov 2006 19:56:19 -0800
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: e1000/ICH8LAN weirdness - no ethtool link until initially forced up
Message-ID: <20061108035619.GE16523@curie-int.orbis-terrarum.net>
References: <20061106013153.GN15897@curie-int.orbis-terrarum.net> <20061107071449.GB21655@elf.ucw.cz> <4550AB7A.10508@intel.com> <20061107213138.GA16523@curie-int.orbis-terrarum.net> <45510980.2040808@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Content-Disposition: inline
In-Reply-To: <45510980.2040808@intel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2006 at 02:32:32PM -0800, Auke Kok wrote:
> >Would a patch that adds a modparam (not enabled by default) running the
> >behavior I'm after, be acceptable, so the e1000 driver can act identical
> >to all of the other drivers?
> I bet that all drivers work fine if you `ifconfig up` them. What happens =
if=20
> other NIC drivers implement similar powersaving methods and start working=
=20
> the same?
In that, case the following (puesdo-code) would need to be added to
ethtool.

(before reading link status)
1. $oldstate =3D GET(current software state of UP/DOWN from ifconfig)
2. if($oldstate !=3D UP) then SET(software state to UP)
3. if($oldstate !=3D UP) then (some delay might be needed)
4. read PHY status
5. if($oldstate !=3D UP) then SET(software state to $oldstate)

Thus ethtool should always report the correct PHY state.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFUVVjPpIsIjIzwiwRAqixAKCmDy8ZshY+NdIeprpDzpFfkKvCPACdFbtP
czfroCmZclqejmQ2A/50dzw=
=AFGr
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--
