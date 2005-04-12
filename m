Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbVDLIIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbVDLIIp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 04:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVDLIIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 04:08:44 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:57477 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S262056AbVDLIHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 04:07:24 -0400
Date: Tue, 12 Apr 2005 10:06:45 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dan@debian.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050412080645.GA6286@vagabond>
References: <20050325095838.GA9471@infradead.org> <E1DEmYC-0008Qg-00@dorka.pomaz.szeredi.hu> <20050331112427.GA15034@infradead.org> <E1DH13O-000400-00@dorka.pomaz.szeredi.hu> <20050331200502.GA24589@infradead.org> <E1DJsH6-0004nv-00@dorka.pomaz.szeredi.hu> <20050411114728.GA13128@infradead.org> <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu> <20050411153619.GA25987@nevyn.them.org> <E1DL1Gj-000091-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <E1DL1Gj-000091-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2005 at 17:56:09 +0200, Miklos Szeredi wrote:
> > Could you explain a little more?  I don't see the point in denying
> > access to root, but I also can't tell from your explanation whether you
> > do or not.
>=20
> Fuse by default does.  This can be disabled by one of two mount
> options: "allow_other" and "allow_root".  The former implies the
> later.  These mount options are only allowed for mounting by root, but
> this can be relaxed with a configuration option.
>=20
> > If I mount a filesystem using ssh, I want to be able to "sudo cp
> > foo.txt /etc" and not get an inexplicable permissions error.
>=20
> If you can do that sudo, you can also modify the configuration and use
> one of the mount options.

And that's as false as it can be! Ok, no sane admin would probably give
out sudo permissions for cp, but other commands may make sense (perhaps
setting some sysctl in /proc -- that needs fsuid=3D0 -- otherwise one
could teach sudo to set euid, but not fsuid). And than the user would
*NOT* be able to use those mount options.

Anyway, why are the options not available to non-root? It's their
filesystem, they should be allowed to set it up!

> > >   4) Access should not be further restricted for the owner of the
> > >      mount, even if permission bits, uid or gid would suggest
> > >      otherwise
> >=20
> > Similar questions.
>=20
> This behavior can be disabled by the "default_permissions" mount
> option (wich is not privileged, since it adds restrictions).  A FUSE
> filesystem mounted by root (and not for private purposes) would
> normally be done with "allow_other,default_permissions".

I'd hell lot prefer it the other way around. The user write bit is
an accident counter-measure similarly to the root squashing.

It needs to be split to two orthogonal options -- one to specify,
whether all files are owned by the mounter or by whomever the filesystem
says and another whether permissions are checked.

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCW4GVRel1vVwhjGURAtQ+AKCBgtGYn2uURCywP/uFR3PRBq/07ACg4nt4
STNQJEzZn2S1KdvswWY/Zuo=
=T1NO
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
