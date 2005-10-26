Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbVJZTxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbVJZTxL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 15:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbVJZTxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 15:53:11 -0400
Received: from cimice0.lam.cz ([212.71.168.90]:52689 "EHLO cimice.yo.cz")
	by vger.kernel.org with ESMTP id S964882AbVJZTxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 15:53:09 -0400
Date: Wed, 26 Oct 2005 21:52:41 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: viro@ftp.linux.org.uk, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/8] VFS: per inode statfs (core)
Message-ID: <20051026195240.GB15046@efreet.light.src>
References: <E1EU5bT-0005sq-00@dorka.pomaz.szeredi.hu> <20051025042519.GJ7992@ftp.linux.org.uk> <E1EUHbq-0006t6-00@dorka.pomaz.szeredi.hu> <20051026173150.GB11769@efreet.light.src> <E1EUqm3-00013A-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
In-Reply-To: <E1EUqm3-00013A-00@dorka.pomaz.szeredi.hu>
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


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 26, 2005 at 21:17:23 +0200, Miklos Szeredi wrote:
> > > > > This patch adds a statfs method to inode operations.  This is inv=
oked
> > > > > whenever the dentry is available (not called from sys_ustat()) an=
d the
> > > > > filesystem implements this method.  Otherwise the normal
> > > > > s_op->statfs() will be called.
> > > > >=20
> > > > > This change is backward compatible, but calls to vfs_statfs() sho=
uld
> > > > > be changed to vfs_dentry_statfs() whenever possible.
> > > >=20
> > > > What the fuck for?  statfs() returns data that by definition should
> > > > not depend on inode within a filesystem.
> > >=20
> > > Exactly.  But it's specified nowhere that there has to be a one-one
> > > mapping between remote filesystem - local filesystem.
> >=20
> > Unfortunately making statfs alone aware of them does not help. Most use=
ful
> > tools that use statfs go to /proc/mouts, read all the entries and invoke
> > statfs for each path. So if for some non-root path different values are
> > returned, these tools won't see them anyway. So try to think about how =
to
> > provide the info about subfilesystems first.
>=20
> 'df .': tried it and it did not do what was expected, but that can
> definitely be fixed

It *did* what was expected -- walked back up to the mountpoint and called
statfs there. And it cannot be fixed (without loss of functionality) unless
you somehow tell it where the boundary of the subfilesystem lies.

> 'stat -f .': actually works

Sure it does. I don't expect many people to use that manually though.

> foo-filemanager: before copying a file or directory tree, checks for
> free space in destination directory

While most others simply don't care -- if it fails, it fails. Looking up the
free space beforehand is only a heurisitics anyway, as the free space can
change between the stat and the copy anyway.

> None of the above examples need (and use) /etc/mtab or /proc/mounts.
>=20
> Just because the info is not available about the placement of the
> subfilesystems, doesn't mean that the subfilesystems don't actually
> exist.

No, it does not. But it does mean that some applications that should know
about them won't know and will give even more confusing results.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDX96IRel1vVwhjGURAny1AKDjOskLCGd6WAPI6R6y5JmN4mlgXgCg0g8T
v9ceRlKQ3bfsycHyrWZrNSw=
=g0mC
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
