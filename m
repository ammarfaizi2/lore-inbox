Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263781AbUDQKGm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 06:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263826AbUDQKE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 06:04:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55425 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263781AbUDQJxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 05:53:37 -0400
Subject: Re: Fix UDF-FS potentially dereferencing null
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       bfennema@falcon.csc.calpoly.edu
In-Reply-To: <Pine.LNX.4.58.0404161720450.3947@ppc970.osdl.org>
References: <20040416214104.GT20937@redhat.com>
	 <20040416220014.GI24997@parcelfarce.linux.theplanet.co.uk>
	 <40806880.1030007@pobox.com> <20040416231823.GZ20937@redhat.com>
	 <Pine.LNX.4.58.0404161720450.3947@ppc970.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-REr96fbvowsU0xSMH9IE"
Organization: Red Hat UK
Message-Id: <1082195458.4691.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 17 Apr 2004 11:50:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-REr96fbvowsU0xSMH9IE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-04-17 at 02:44, Linus Torvalds wrote:
> On Sat, 17 Apr 2004, Dave Jones wrote:
> >=20
> > And there's a *lot* of them. Those half dozen or so patches earlier wer=
e
> > results of just a quick random skim of the list the coverity folks came=
 up with.
> >=20
> > It'll take a lot of effort to 'fix' them all, and given the non-severit=
y
> > of a lot of them, I'm not convinced it's worth the effort.
>=20
> Just for the fun of it, I added a "safe" attribute to sparse (hey, it was=
=20
> trivial), and made it warn if you test a safe variable.=20
>=20
> You can do
>=20
> 	#define __safe __attribute__((safe))
>=20
> 	static struct denty *
> 	udf_lookup(struct inode * __safe dir,
> 			struct dentry * __safe dentry,
> 			struct nameidata * __safe nd);
>=20
> or

Hi,

is it maybe a good idea to map this to gcc's "nonnull" attribute in some
way? That way both sparse and the compiler get this explicit
knowledge.... (afaics gcc will then also just optimize out the null ptr
checks)

--=-REr96fbvowsU0xSMH9IE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD4DBQBAgP4BxULwo51rQBIRAlgWAJoCs2VKg55GpmIq2CSII3nFBhWN0wCY3SJr
GpvTlARW1Csff+p55F9UHg==
=wLYn
-----END PGP SIGNATURE-----

--=-REr96fbvowsU0xSMH9IE--

