Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbVJZRcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbVJZRcS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 13:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbVJZRcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 13:32:18 -0400
Received: from cimice0.lam.cz ([212.71.168.90]:61136 "EHLO cimice.yo.cz")
	by vger.kernel.org with ESMTP id S964842AbVJZRcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 13:32:17 -0400
Date: Wed, 26 Oct 2005 19:31:50 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: viro@ftp.linux.org.uk, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/8] VFS: per inode statfs (core)
Message-ID: <20051026173150.GB11769@efreet.light.src>
References: <E1EU5bT-0005sq-00@dorka.pomaz.szeredi.hu> <20051025042519.GJ7992@ftp.linux.org.uk> <E1EUHbq-0006t6-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <E1EUHbq-0006t6-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.11
X-Spam-Score: -4.5 (----)
X-Spam-Report: Spam detection software, running on "shpek.cybernet.src", has inspected this
	incomming email and gave it -4.5 points (spam is above 5.0)
	Content analysis details:
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.9 ALL_TRUSTED            Did not pass through any untrusted hosts
	-1.7 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 25, 2005 at 07:44:30 +0200, Miklos Szeredi wrote:
> > > This patch adds a statfs method to inode operations.  This is invoked
> > > whenever the dentry is available (not called from sys_ustat()) and the
> > > filesystem implements this method.  Otherwise the normal
> > > s_op->statfs() will be called.
> > >=20
> > > This change is backward compatible, but calls to vfs_statfs() should
> > > be changed to vfs_dentry_statfs() whenever possible.
> >=20
> > What the fuck for?  statfs() returns data that by definition should
> > not depend on inode within a filesystem.
>=20
> Exactly.  But it's specified nowhere that there has to be a one-one
> mapping between remote filesystem - local filesystem.

Unfortunately making statfs alone aware of them does not help. Most useful
tools that use statfs go to /proc/mouts, read all the entries and invoke
statfs for each path. So if for some non-root path different values are
returned, these tools won't see them anyway. So try to think about how to
provide the info about subfilesystems first.

--
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDX72GRel1vVwhjGURAhciAKDK+njNkqbifrpnmG8V7NixnlrXaACg6/Wa
1ETVx55KW3CAntS733r1m14=
=2FBF
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
