Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262350AbVG2OMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbVG2OMw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 10:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262583AbVG2OMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 10:12:52 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:21637 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S262350AbVG2OMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 10:12:52 -0400
Date: Fri, 29 Jul 2005 16:12:28 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Regression hunting with git (was: Re: 2.6.13-rc3-mm3)
Message-ID: <20050729141228.GK5680@kiste.smurf.noris.de>
References: <20050728025840.0596b9cb.akpm@osdl.org> <200507282111.32970.rjw@sisk.pl> <20050728121656.66845f70.akpm@osdl.org> <200507282340.57905.rjw@sisk.pl> <pan.2005.07.29.07.05.58.992113@smurf.noris.de> <20050729022735.0602ee76.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZMT28BdW279F9lxY"
Content-Disposition: inline
In-Reply-To: <20050729022735.0602ee76.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
From: Matthias Urlichs <smurf@smurf.noris.de>
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZMT28BdW279F9lxY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Andrew Morton:
> >  Note that if you work from my git import, git has a nice tree bisection
> >  option.
>=20
> Is that documented anywhere?

http://lkml.org/lkml/2005/6/24/234


Basically, you do this:

$ set -o noclobber
$ git-rev-tree --bisect ^good1 ^good2 bad > .git/refs/heads/tryN
$ git checkout tryN

(Initially, "good" is v2.6.12 or whatever version last worked for you;
 "bad" is "master", thus:
 $ git-rev-tree --bisect ^v2.6.12 master > .git/refs/heads/tryN
)

Build kernel, test. If good, add tryN to the list of good kernels, above;
if bad, replace "bad" with "tryN". N +=3D 1. Repeat.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
IT'S HERE AT LAST: Rush job; nobody knew it was coming

--ZMT28BdW279F9lxY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC6jlM8+hUANcKr/kRAqrDAJ47kDDMGPV1FJeH6YKPvImFeP7qIwCeKB0j
CnFiWtaJ1dS8hhY3EhM+vhY=
=3K1p
-----END PGP SIGNATURE-----

--ZMT28BdW279F9lxY--
