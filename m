Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVHAGmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVHAGmH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 02:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVHAGmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 02:42:07 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:59339 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S261981AbVHAGmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 02:42:05 -0400
Date: Mon, 1 Aug 2005 08:33:58 +0200
From: Harald Welte <laforge@gnumonks.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: git-net-fixup.patch added to -mm tree
Message-ID: <20050801063358.GA28252@rama.de.gnumonks.org>
References: <200508010504.j7154m5B022440@shell0.pdx.osdl.net> <20050731.221246.68159198.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20050731.221246.68159198.davem@davemloft.net>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 31, 2005 at 10:12:46PM -0700, David S. Miller wrote:
> From: akpm@osdl.org
> Date: Sun, 31 Jul 2005 22:03:47 -0700
>=20
> > From: Andrew Morton <akpm@osdl.org>
> >=20
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
>  ...
> >  /* decrement reference count on a conntrack */
> > -extern void ip_conntrack_put(struct ip_conntrack *ct);
> > +static inline void
> > +ip_conntrack_put(struct ip_conntrack *ct)
> > +{
> > +	IP_NF_ASSERT(ct);
> > +	nf_conntrack_put(&ct->ct_general);
> > +}
>=20
> You can instead just kill the EXPORT_SYMBOL_GPL() in
> ip_conntrack_standalone.c as that's the only reference outside of
> ip_conntrack_core.c

for 2.6.13 this should work.  net-2.6.14 contains
ip_conntrack_netlink.c, which needs ip_conntrakc_put (and therefore the
EXPORT_SYMBOL_GPL(). =20

We also have other code out-of-tree (e.g. ct_sync) that need the symbo.
I know this is no rectification, but I'm merely mentioning it JFYI.

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC7cJWXaXGVTD0i/8RAqIsAJ96eYoPAPtRDyJhIrboj1ge22iaNwCfQa17
pinbOh9jRUBZLYN1kKFxduk=
=t8m+
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
