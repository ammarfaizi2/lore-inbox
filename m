Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbVJ0IHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbVJ0IHd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 04:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbVJ0IHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 04:07:33 -0400
Received: from cimice0.lam.cz ([212.71.168.90]:19414 "EHLO cimice.yo.cz")
	by vger.kernel.org with ESMTP id S964988AbVJ0IHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 04:07:31 -0400
Date: Thu, 27 Oct 2005 10:07:13 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: viro@ftp.linux.org.uk, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/8] VFS: per inode statfs (core)
Message-ID: <20051027080713.GA25460@djinn>
References: <E1EU5bT-0005sq-00@dorka.pomaz.szeredi.hu> <20051025042519.GJ7992@ftp.linux.org.uk> <E1EUHbq-0006t6-00@dorka.pomaz.szeredi.hu> <20051026173150.GB11769@efreet.light.src> <E1EUqm3-00013A-00@dorka.pomaz.szeredi.hu> <20051026195240.GB15046@efreet.light.src> <E1EUrb7-0001AU-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <E1EUrb7-0001AU-00@dorka.pomaz.szeredi.hu>
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


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 26, 2005 at 22:10:09 +0200, Miklos Szeredi wrote:
> > > > > > > This patch adds a statfs method to inode operations.  This is=
 invoked
> > > > > > > whenever the dentry is available (not called from sys_ustat()=
) and the
> > > > > > > filesystem implements this method.  Otherwise the normal
> > > > > > > s_op->statfs() will be called.
> > > > > > >=20
> > > > > > > This change is backward compatible, but calls to vfs_statfs()=
 should
> > > > > > > be changed to vfs_dentry_statfs() whenever possible.
> > > > > >=20
> > > > > > What the fuck for?  statfs() returns data that by definition sh=
ould
> > > > > > not depend on inode within a filesystem.
> > > > >=20
> > > > > Exactly.  But it's specified nowhere that there has to be a one-o=
ne
> > > > > mapping between remote filesystem - local filesystem.
> > > >=20
> > > > Unfortunately making statfs alone aware of them does not help. Most=
 useful
> > > > tools that use statfs go to /proc/mouts, read all the entries and i=
nvoke
> > > > statfs for each path. So if for some non-root path different values=
 are
> > > > returned, these tools won't see them anyway. So try to think about =
how to
> > > > provide the info about subfilesystems first.
> > >=20
> > > 'df .': tried it and it did not do what was expected, but that can
> > > definitely be fixed
> >=20
> > It *did* what was expected -- walked back up to the mountpoint and call=
ed
> > statfs there.
>=20
> Yes, but I didn't expect that it would do that.  Why?  Because I asked
> it for free space in the current directory and not at the mountpoint.
>=20
> Since it's not _expecting_ subfilesystems to exist, it's
> understandable that it did not perform well.
>=20
> > And it cannot be fixed (without loss of functionality) unless
> > you somehow tell it where the boundary of the subfilesystem lies.
>=20
> Of course it can be fixed.  Just always let it do
> statfs(path_supplied_by_user).  If there are no subfses the results
> will be the same.  If there _are_ subfses the results will be more
> meaningful, not less.

Not _without__loss__of__functionality__. Part of the functionality is
looking up the mount-point and other info about the filesystem, which is
no longer correct when subfilesystems are exposed.

> [...]
> > > None of the above examples need (and use) /etc/mtab or /proc/mounts.
> > >=20
> > > Just because the info is not available about the placement of the
> > > subfilesystems, doesn't mean that the subfilesystems don't actually
> > > exist.
> >=20
> > No, it does not. But it does mean that some applications that should kn=
ow
> > about them won't know and will give even more confusing results.
>=20
> How will they give more confusing results?  Please ellaborate.

I mean specifically the case of df and similar things. So far remote
filesystems generally return obviously invalid results so far. But when
they are made to return correct values for subfilesystem, these tools
need a way to find where those subfilesystems start.

--
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDYIqwRel1vVwhjGURAgF6AJ9mPyysv/syne4d3dZH5AZvzLOipQCbB/0y
YWAriSQxyAN0qYqg5MZkEoA=
=ifxG
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
