Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTKFV63 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 16:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263846AbTKFV63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 16:58:29 -0500
Received: from wblv-224-88.telkomadsl.co.za ([165.165.224.88]:24460 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S263452AbTKFV60
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 16:58:26 -0500
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
	defined (trivial)
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: "David S. Miller" <davem@redhat.com>
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20031106131841.4b68502e.davem@redhat.com>
References: <1068140199.12287.246.camel@nosferatu.lan>
	 <20031106093746.5cc8066e.davem@redhat.com>
	 <1068143563.12287.264.camel@nosferatu.lan>
	 <1068144179.12287.283.camel@nosferatu.lan>
	 <20031106113716.7382e5d2.davem@redhat.com>
	 <1068149368.12287.331.camel@nosferatu.lan>
	 <20031106120548.097ccc7c.davem@redhat.com>
	 <1068150552.12287.349.camel@nosferatu.lan>
	 <20031106122723.5cbe1b6d.davem@redhat.com>
	 <1068153535.12287.355.camel@nosferatu.lan>
	 <20031106131841.4b68502e.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iEzuz+tOWDj3iO8jjS/G"
Message-Id: <1068155963.12287.370.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 06 Nov 2003 23:59:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iEzuz+tOWDj3iO8jjS/G
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-11-06 at 23:18, David S. Miller wrote:
> On Thu, 06 Nov 2003 23:18:55 +0200
> Martin Schlemmer <azarah@gentoo.org> wrote:
>=20
> > Ok - say for instance then you were to write the abi headers - how woul=
d
> > you handle a case like this that -ansi forbid type long long, but it
> > have to be in the struct userspace uses to pass data to the
> > kernel/device ?
>=20
> I can tell you what cannot happen.  You absolutely can't consider
> ideas like using '__u32 val[2];' and accessor macros, long long or
> whatever type the platform uses for __u64 has different alignment
> constraints than the '__u32 val[2]' array thing would.
>=20
> I believe there is a way to work around this by using the
> __extension__ keyword when defining the __u64 typedefs.  Someone
> should try playing with that.  But this is only going to work when
> the compiler is GCC.

Yes, I do understand, and no, I did not try to get on that
nerve =3D)

The thing is just that you guys cannot decide if left, or
right is the best path to take, and that do create some
confusion, especially when you want to do the proper fix,
and a few things are falling apart around you =3D)

And patching it the wrong way, and then hitting one of your
possible quirks, will make things even worse, as if nobody
can remember about this, then it might be a very hard job
to track it, as you will be the only ones with this issue.

Some upstream userland authors have already done come up
with the following 'fix', which you may or may not approve
of:

--
#undef __STRICT_ANSI__
#include <linux/cdrom.h>
#define __STRICT_ANSI__
--

I guess the easier option might just be to drop -ansi :/


Thanks,

--=20

Martin Schlemmer




--=-iEzuz+tOWDj3iO8jjS/G
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/qsQ7qburzKaJYLYRAtMCAKCTtQpj9T9U0glMbo59i3oa8SMmCQCgkr/X
tKp/4BjYRwzbgLSU7G6wzi0=
=nBBN
-----END PGP SIGNATURE-----

--=-iEzuz+tOWDj3iO8jjS/G--

