Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263727AbTDNS2Q (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbTDNSPA (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:15:00 -0400
Received: from cpt-dial-196-30-178-206.mweb.co.za ([196.30.178.206]:21376 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S263632AbTDNSBp (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 14:01:45 -0400
Subject: Re: Oops: ptrace fix buggy
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: James Bourne <jbourne@hardrock.org>, Ken Brownfield <brownfld@irridia.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030414144709.GE10347@wohnheim.fh-wedel.de>
References: <200304121154.32997.m.c.p@wolk-project.de>
	 <Pine.LNX.4.44.0304140713510.22450-100000@cafe.hardrock.org>
	 <20030414134603.GB10347@wohnheim.fh-wedel.de>
	 <1050330667.4059.27.camel@workshop.saharact.lan>
	 <20030414144709.GE10347@wohnheim.fh-wedel.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9Fa2m7YVWrA7Oa2YC27o"
Organization: 
Message-Id: <1050343825.4757.17.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 14 Apr 2003 20:10:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9Fa2m7YVWrA7Oa2YC27o
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-04-14 at 16:47, J=F6rn Engel wrote:
> On Mon, 14 April 2003 16:31:08 +0200, Martin Schlemmer wrote:
> > On Mon, 2003-04-14 at 15:46, J=F6rn Engel wrote:
> >=20
> > > Privately, I have introduced a variable FIXLEVEL for this. The
> > > resulting kernel version is 2.4.20.2 instead of 2.4.20-uv2, which imo
> > > is more suiting for a fixed stable kernel.
> >=20
> > This is not a good idea ... especially if its a box that you
> > compile a lot of software on.  Reason is that everything expects
> > it to be MAJ.MIN.MIC  ... If you add now another version, then
> > things start to break.  A good example is mozilla ...
>=20
> That doesn't convince me (yet?). Why doesn't 2.4.20-pre5-ac3 break
> mozilla, but 2.4.20.1 does? If mozilla depends on this information, it
> should at least have a robust parser for it.
>=20
> Can you give me a little more details on this? Did anyone ever declare
> that userspace can expect kernel versions to fit this regex?
> \d+\.\d+\.\d+(-.+)?
>=20

=46rom include/linux/version.h:

---------------------------------------------------------------
#define UTS_RELEASE "2.5.67-bk2"
#define LINUX_VERSION_CODE 132419
#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))
---------------------------------------------------------------

Your changes will definitely break things that do:

#if ((LINUX_VERSION_CODE > KERNEL_VERSION(2.4.0)) && \
     (LINUX_VERSION_CODE < KERNEL_VERSION(2.5.0)))

Also, most docs explaining the version format, refer to

  major.minor.micro

Anyhow, I did not say it was set in stone, I just said if you
start getting breakage when compiling/configuring things, do
not wonder why =3D)


Regards,

--=20

Martin Schlemmer




--=-9Fa2m7YVWrA7Oa2YC27o
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+mvmRqburzKaJYLYRArZhAJ9/YuZDlw9v2tb6M1e03X54+x0fkACfWETa
QUY2QXippxvSPioSDtKjB2g=
=8502
-----END PGP SIGNATURE-----

--=-9Fa2m7YVWrA7Oa2YC27o--

