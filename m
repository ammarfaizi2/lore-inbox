Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262855AbVAFOxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbVAFOxE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 09:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262854AbVAFOwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 09:52:53 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:13514 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262849AbVAFOvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 09:51:13 -0500
Subject: Re: [PATCH] Enhanced Trusted Path Execution (TPE) Linux Security
	Module
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       narahimi@us.ibm.com
In-Reply-To: <20050105212629.K469@build.pdx.osdl.net>
References: <1104979908.8060.34.camel@localhost.localdomain>
	 <20050105212629.K469@build.pdx.osdl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HJXTnNKRD2mOq06ty1k2"
Date: Thu, 06 Jan 2005 15:50:40 +0100
Message-Id: <1105023040.4028.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HJXTnNKRD2mOq06ty1k2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

El mi=E9, 05-01-2005 a las 21:26 -0800, Chris Wright escribi=F3:
> * Lorenzo Hern=E1ndez Garc=EDa-Hierro (lorenzo@gnu.org) wrote:
> > This patch adds support for an enhanced Trusted Path Execution (TPE)
> > subsystem relying in the Linux Security Modules framework.
> > It's a rewrite of the IBM's TPE LSM module by Niki A. Rahimi, which
> > adds a couple of improvements and feature enhancements.
>=20
> Thanks for taking interest and working on this.

NP, this is just for fun and maybe for doing something useful for
others.

> > The most notable of them are support for per-gid basis access control
> > lists in runtime and kernel-configuration time (adds support for truste=
d
> > and untrusted user groups), procfs interface for statistics and runtime
> > information and debugging capabilities (for limiting the garbage
> > messages).
>=20
> How does per-gid help in this case (esp. the desktop scenario you
> mentioned)?  And the /proc/tpe file might as well go under sysfs with
> the rest of the other entries instead of cluttering /proc.

It helps if you are going to trust a whole group of users.
The procfs entry goes inside proc to make it clearly accessible for the
immediate users, and /proc, in my opinion, is the legacy interface for
such type of things (even the input can not be handled as a sysctl as
grsec's tpe does, because we handle complete acl's and not just one
trusted group nor user).
Anyway, if i must do it i will do it, it's not a problem (i think so).

> > The reasons that give sense for including this, are that standard
> > Vanilla kernels have SELinux and LSM (SELinux already supports TPE
> > functionalities), but SELinux has less possibilities of being used by
> > those desktop or just not experienced users who are not already using
> > their distribution-specific SELinux implementation, even if they want
> > simple protections for their every-day system use, also, the
> > availability of some patch-sets with security enhancements (like
> > grsecurity) distracts users of being using the LSM framework or even
> > SELinux itself, in addition, this TPE has more features than
> > grsecurity's one in terms of per-users and groups acl basis, which make
> > easy the management of the TPE protection.
> > In short, after a first review you can see that it could worthy to
> > include this in the kernel sources.
>=20
> The two biggest issues are 1) it's trivial to bypass:
> $ /lib/ld.so /untrusted/path/to/program
> and 2) that there's no (visible/vocal) user base calling for the feature.

About the point 1), yesterday i wrote just a simple regression test
(that can be found at the same place as the patch) and of course it
bypasses, this is an old commented problem, Stephen suggested the use of
the mmap and mprotect hooks, so, i will have a look at them but i'm not
sure on how to (really) prevent the dirty,old trick.
About 2), just give it a chance, maybe it's useful and my work is not
completely nonsense.=20

> So working those issues will help make a better case for mainline
> inclusion.

OK, i will try to work on them but i can't promise, this is my second
month playing around with kernel hacking (and almost C programming), so,
i'll need one or two nights to see how to get it ;-)

Thanks for the comments and your attention,
Cheers.
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org> [1024D/6F2B2DEC]
[2048g/9AE91A22] Hardened Debian head developer & project manager

--=-HJXTnNKRD2mOq06ty1k2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB3VBADcEopW8rLewRAikeAJ9z/Plbyugoro+NPthH/k3bER/+VQCgptu6
Xg5J/4rxzFVN3yXCsz1IiTo=
=ZAZk
-----END PGP SIGNATURE-----

--=-HJXTnNKRD2mOq06ty1k2--

