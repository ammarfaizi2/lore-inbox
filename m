Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUFNIeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUFNIeZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 04:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUFNIce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 04:32:34 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:58021 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S262062AbUFNIa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 04:30:29 -0400
Date: Mon, 14 Jun 2004 10:30:25 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild make deb patch
Message-ID: <20040614083025.GH20632@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040607141353.GK21794@wiggy.net> <20040608210846.GA5216@mars.ravnborg.org> <20040609142141.GT20632@lug-owl.de> <20040613061957.GA3012@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4QegTRG2QMwU8dpf"
Content-Disposition: inline
In-Reply-To: <20040613061957.GA3012@mars.ravnborg.org>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4QegTRG2QMwU8dpf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-06-13 08:19:57 +0200, Sam Ravnborg <sam@ravnborg.org>
wrote in message <20040613061957.GA3012@mars.ravnborg.org>:
> On Wed, Jun 09, 2004 at 04:21:41PM +0200, Jan-Benedict Glaw wrote:
> > On Tue, 2004-06-08 23:08:46 +0200, Sam Ravnborg <sam@ravnborg.org>
> > wrote in message <20040608210846.GA5216@mars.ravnborg.org>:
> > > On Mon, Jun 07, 2004 at 04:13:53PM +0200, Wichert Akkerman wrote:
> > > I'm in progress of doing some infrastructure work to better support b=
uilding
> > > different packages. I have requests for .tar.gz, tar.gz2 as well
> > > as deb.
> >=20
> > (Being a Debian user...) I really *love* to see a .tar.{gz,bz2} target.
> > For my in-house use (as well in in the company I work for) we do have a
> > script to basically install modules (+ vmlinuz + vmlinux + .config +
> > System.map), adding some identifier to the filenames (of the last four
> > files mentioned) and preparing a .tar.gz from that.
>=20
> Could you try to be more specific in what you expect to see in a .tar.gz'=
ed kernel.
> A script that creates a .tar.gz from current kernel would be fine :-)

I'd expect something that you can extract with:

~# cd /
/# tar xzf /path/to/kernel.tar.gz --no-same-owner

That tar file should contain:

=2E/boot/vmlinux-<version>	# unstripped vmlinux file for debugging
=2E/boot/vmlinuz-<version>	# bootable file - non-i386 archs obviously
				# need different files
=2E/boot/System.map-<version>	# Map file for 'ps' and for me
=2E/boot/config-<version>		# To recreate the kernel
=2E/boot/patch-<version>		# Only if it was requested at .tar.gz
				# build time, containing a -Nurp style
				# diff to a clean source tree (which
				# needs to be specified then)
=2E/lib/modules/<kversion>/*	# Modules

The tricky part is the <version> and/or <kversion> part. For my personal
use, version is like kversion, but extended with whatever the user
specified. kversion is Makefile's $(KERNELRELEASE).

As I stated, it's clumsy at ./lib/modules/<kversion>/*, because you'll
probably overwrite other modules of the same kernel version with a
different(ly compiled) .tar.gz .  The tarball's name should exactly
contain <version> in it's name so that a script that extracts is can
place a proper symlink within ./boot easily.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--4QegTRG2QMwU8dpf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAzWIhHb1edYOZ4bsRAhopAJ9EvFKSrpb6F0E2kqsGAYL5jd+GqgCeLJ8d
E4Aug2gVtJYniGyAO34uYmI=
=cXY3
-----END PGP SIGNATURE-----

--4QegTRG2QMwU8dpf--
