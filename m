Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbUFSBEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUFSBEw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 21:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265724AbUFSBDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 21:03:00 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:38550 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S265654AbUFSBBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 21:01:31 -0400
Date: Fri, 18 Jun 2004 13:36:32 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: 4Front Technologies <dev@opensound.com>
Cc: Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
Message-ID: <20040618193632.GO14915@schnapps.adilger.int>
Mail-Followup-To: 4Front Technologies <dev@opensound.com>,
	Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay> <40D23701.1030302@opensound.com> <1087573691.19400.116.camel@winden.suse.de> <40D32C1D.80309@opensound.com> <20040618190257.GN14915@schnapps.adilger.int> <40D34CB2.10900@opensound.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LW0Rr0Uq98qh6Rv"
Content-Disposition: inline
In-Reply-To: <40D34CB2.10900@opensound.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1LW0Rr0Uq98qh6Rv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 18, 2004  13:12 -0700, 4Front Technologies wrote:
> Andreas Dilger wrote:
> >We gave up trying to use kernel versions to determine what=20
> >features/interface
> >to use for a given kernel long ago.  Instead we have configure check for=
 a
> >particular interface and use "#ifdef HAVE_foo", not "#if=20
> >LINUX_KERNEL_VERSION".
> >
> >I can understand why SuSE does this - there is no way they can ship the
> >"latest" kernel and still have tested it thoroughly, yet if they find a
> >specific defect they need to fix it (preferrably in the same way that a
> >later kernel fixes it).
> >
>=20
> We precisely use this mechanism - we use=20
> /lib/modules/<version>/build/include/linux/config.h to figure such featur=
es=20
> out but when the "build" part of the path doesn't point to the right sour=
ce=20
> tree, where do you look?. SuSE ships kernel sources "unconfigured" which
> means that you have to rely on something else to tell you what the exact
> kernel configuration looks like.

Using include/linux/config.h only tells you which kernel config options
are set/unset.  That doesn't tell you anything about API changes between
kernel versions, vendor backports of some of those features, etc.

For example, one vendor ships their 2.4 kernel with the .direct_IO
address_space_operation with "struct file *" as the second parameter,
while most other kernels pass "struct inode *" as that same parameter.
Ideally, when they made that API change they should have #defined
HAVE_DIO_FILE or something in the fs.h header so it can be detected.
Instead we have configure tests to know which struct is being passed.

There are similar changes in kernel-internal APIs between versions,
structs (kiobuf is lots of fun), architectures, etc.  What my point was
is that just looking at CONFIG_POSIX_ACL or whatever isn't necessarily
going to tell you the whole story, and even if some change was made in
kernel 2.6.6 doesn't mean that other vendor kernels at 2.6.5 won't also
have that.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/                 http://members.shaw.ca/goli=
nux/


--1LW0Rr0Uq98qh6Rv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFA00RApIg59Q01vtYRAqJsAJwNlAQY86fVk/vXbZzJQoqUo4L7RgCgpe1s
Vv745r84SVEJ8zBa2rl2lBY=
=jAD4
-----END PGP SIGNATURE-----

--1LW0Rr0Uq98qh6Rv--
