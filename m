Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752924AbWKFMgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbWKFMgm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 07:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752929AbWKFMgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 07:36:42 -0500
Received: from h01.hostsharing.net ([212.42.230.152]:31210 "EHLO
	h01.hostsharing.net") by vger.kernel.org with ESMTP
	id S1752923AbWKFMgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 07:36:41 -0500
Date: Sun, 5 Nov 2006 23:04:06 +0100
From: Elimar Riesebieter <riesebie@lxtec.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, riesebie@lxtec.de,
       Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       Andy Adamson <andros@citi.umich.edu>,
       "J. Bruce Fields" <bfields@citi.umich.edu>,
       Trond Myklebust <Trond.Myklebust@netapp.com>,
       Olaf Kirch <okir@monad.swb.de>, bunk@stusta.de
Subject: Re: [PATCH 1/2] sunrpc: add missing spin_unlock
Message-ID: <20061105220406.GA3263@aragorn.home.lxtec.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
	Andy Adamson <andros@citi.umich.edu>,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	Trond Myklebust <Trond.Myklebust@netapp.com>,
	Olaf Kirch <okir@monad.swb.de>, bunk@stusta.de
References: <20061028185554.GM9973@localhost> <20061029133551.GA10072@localhost> <20061029133700.GA10295@localhost> <1162744516.26989.43.camel@twins> <20061105114533.4f57f333.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20061105114533.4f57f333.akpm@osdl.org>
Organization: LXTEC
X-gnupg-key-fingerprint: BE65 85E4 4867 7E9B 1F2A  B2CE DC88 3C6E C54F 7FB0
X-Editor: VIM - Vi IMproved 7.0 (2006 May 7, compiled Oct 25 2006 19:41:01)
User-Agent: Mutt/1.5.13-muttng (2006-11-01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 05 Nov 2006 the mental interface of
Andrew Morton told:

[...]
> > > Index: work-fault-inject/net/sunrpc/svcauth.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- work-fault-inject.orig/net/sunrpc/svcauth.c
> > > +++ work-fault-inject/net/sunrpc/svcauth.c
> > > @@ -126,6 +126,7 @@ void auth_domain_put(struct auth_domain=20
> > >  	if (atomic_dec_and_lock(&dom->ref.refcount, &auth_domain_lock)) {
> > >  		hlist_del(&dom->hash);
> > >  		dom->flavour->domain_release(dom);
> > > +		spin_unlock(&auth_domain_lock);
> > >  	}
> > >  }
>=20
> I wonder if this will fix http://bugzilla.kernel.org/show_bug.cgi?id=3D74=
57

It fixes it. Patched a native 2.6.19-rc4 and it works. Thanks.

Elimar

--=20
  Planung:
  Ersatz des Zufalls durch den Irrtum.
                                -unknown-

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFTl/V3Ig8bsVPf7ARAipwAKChORiiWm9UOsB+ONqB2fsE09ZzTwCgiJiI
awuru173W083NV9v02iQBlg=
=fVfr
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
