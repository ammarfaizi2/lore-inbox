Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVDCU0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVDCU0A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 16:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVDCU0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 16:26:00 -0400
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90]:53686 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id S261899AbVDCUZj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 16:25:39 -0400
Subject: Re: Use of C99 int types
From: Kenneth Johansson <ken@kenjo.org>
To: Renate Meijer <kleuske@xs4all.nl>
Cc: Dag Arne Osvik <da@osvik.no>, Stephen Rothwell <sfr@canb.auug.org.au>,
       linux-kernel@vger.kernel.org
In-Reply-To: <524d7fda64be6a3ab66a192027807f57@xs4all.nl>
References: <424FD9BB.7040100@osvik.no>
	 <20050403220508.712e14ec.sfr@canb.auug.org.au> <424FE1D3.9010805@osvik.no>
	 <524d7fda64be6a3ab66a192027807f57@xs4all.nl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-P4cZdj95vahrIYu5LVd+"
Date: Sun, 03 Apr 2005 22:25:33 +0200
Message-Id: <1112559934.5268.9.camel@tiger>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-P4cZdj95vahrIYu5LVd+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-04-03 at 21:23 +0200, Renate Meijer wrote:
> On Apr 3, 2005, at 2:30 PM, Dag Arne Osvik wrote:
>=20
> > Stephen Rothwell wrote:
> >
> >> On Sun, 03 Apr 2005 13:55:39 +0200 Dag Arne Osvik <da@osvik.no> wrote:
> >>
> >>> I've been working on a new DES implementation for Linux, and ran into
> >>> the problem of how to get access to C99 types like uint_fast32_t for
> >>> internal (not interface) use.  In my tests, key setup on Athlon 64=20
> >>> slows
> >>> down by 40% when using u32 instead of uint_fast32_t.
> >>>
> >>
> >> If you look in stdint.h you may find that uint_fast32_t is actually
> >> 64 bits on Athlon 64 ... so does it help if you use u64?
> >>
> >>
> >
> > Yes, but wouldn't it be much better to avoid code like the following,=20
> > which may also be wrong (in terms of speed)?
> >
> > #ifdef CONFIG_64BIT  // or maybe CONFIG_X86_64?
> >  #define fast_u32 u64
> > #else
> >  #define fast_u32 u32
> > #endif
>=20
> Isn't it better to use a general integer type, reflecting the cpu's=20
> native register-size and let the compiler sort it out? Restrict all=20
> uses of explicit width types to where it's *really* needed, that is, in=20

But is this not exactly what Dag Arne Osvik was trying to do ??=20
uint_fast32_t means that we want at least 32 bits but it's OK with more
if that happens to be faster on this particular architecture.  The
problem was that the C99 standard types are not defined anywhere in the
kernel headers so they can not be used.

Perhaps they should be added to asm/types.h ?




--=-P4cZdj95vahrIYu5LVd+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCUFE9mDGOmJIy9x8RAqUxAJ42ty6fOKWPdQWPT+Es37McM1yQNQCfQgxo
tOXYSiA8eEiB+hPBoDmf4x8=
=fE5c
-----END PGP SIGNATURE-----

--=-P4cZdj95vahrIYu5LVd+--

