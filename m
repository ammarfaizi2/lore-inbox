Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266535AbUHOH4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266535AbUHOH4Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 03:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266538AbUHOH4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 03:56:25 -0400
Received: from zero.voxel.net ([209.123.232.253]:18399 "EHLO zero.voxel.net")
	by vger.kernel.org with ESMTP id S266535AbUHOH4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 03:56:21 -0400
Subject: Re: [PATCH] don't delete debian directory in official debian builds
From: Andres Salomon <dilinger@voxel.net>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20040815071559.GB7182@mars.ravnborg.org>
References: <1092512343.3971.23.camel@spiral.internal>
	 <20040815071559.GB7182@mars.ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mDRIBZvUwbP0mIumoSYF"
Date: Sun, 15 Aug 2004 03:56:32 -0400
Message-Id: <1092556593.20551.14.camel@toaster.hq.voxel.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.90 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mDRIBZvUwbP0mIumoSYF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-08-15 at 09:15 +0200, Sam Ravnborg wrote:
> On Sat, Aug 14, 2004 at 03:39:03PM -0400, Andres Salomon wrote:
> > Hi,
> >=20
> > Somewhere along the 2.6 series, there was a change made that causes
> > distclean to automatically delete the debian/ subdirectory from the top
> > of the kernel tree.  This causes grief for the official debian kernel
> > packages; the debian directory shouldn't be deleted in the packages.
> > Please apply the attached patch; it causes the debian/ subdirectory to
> > only be deleted if there's no debian/official.
> >=20
> > An even better solution would be to mark the debian directory as being
> > created by the kernel (touch debian/linus), and only delete it if the
> > kernel created it.
>=20
> Such special cases are not acceptable.
>=20

This isn't a special case; this is debian using a directory for years,
and the kernel suddenly deciding to not only use the same directory, but
assume ownership of it and delete it when distcleaning.  By providing a
rule that creates a debian package, you've managed to inconvenience the
people who actually create and maintain the main system your debian
package would run on.  Please take this into consideration.


> If this causes a problem then there are the following options:
> 1) Rename directory in debian or the kernel
> 2) Debian apply a patch to the kernel

How about not deleting the directory if you haven't created it?  Debian
already applies patches to the kernel, but we feed changes/fixes back to
linus and co; this is one of those fixes that should be in the main
kernel.  If you're going to provide a make rule for *Debian*, then make
it consistent with Debian packaging standards.  Otherwise, why even
bother?  Debian has its own supported methods for creating kernel
packages (named, oddly enough, kernel-package).

Honestly, I'd rather see the deb rule removed completely; Debian and
Debian-derived distributions provide their own kernel packages.  Users
who compile their own kernel have the option of using a Debian supported
method for building kernel packages (they can also simply copy images
around, without bothering w/ packages).  Generating a package without
kernel-package is not supported; does it even handle grub and lilo
updates in postinst?


>=20
> Preference to 1).

I'm not quite sure what you mean w/ #1.  You want Debian, which has used
the debian/ subdirectory for years, to use something else for its kernel
packages?


>=20
> Comments?
>=20
> 	Sam
--=20
Andres Salomon <dilinger@voxel.net>

--=-mDRIBZvUwbP0mIumoSYF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBHxcv78o9R9NraMQRAhcIAJ9M8Wb6JW3qWX+gaRsXDt7p9/fg6wCglsdY
syTXWvbjW/mdwA6vP+4azXM=
=ktZR
-----END PGP SIGNATURE-----

--=-mDRIBZvUwbP0mIumoSYF--

