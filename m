Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265052AbUF1Uv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265052AbUF1Uv0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 16:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265084AbUF1Uv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 16:51:26 -0400
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:21135 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S265052AbUF1UvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 16:51:14 -0400
Date: Mon, 28 Jun 2004 13:50:58 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: "David S. Miller" <davem@redhat.com>
Cc: Scott Wood <scott@timesys.com>, oliver@neukum.org, zaitcev@redhat.com,
       greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com,
       tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, david-b@pacbell.net
Subject: Re: drivers/block/ub.c
Message-ID: <20040628205058.GB8502@one-eyed-alien.net>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	Scott Wood <scott@timesys.com>, oliver@neukum.org,
	zaitcev@redhat.com, greg@kroah.com, arjanv@redhat.com,
	jgarzik@redhat.com, tburke@redhat.com, linux-kernel@vger.kernel.org,
	stern@rowland.harvard.edu, david-b@pacbell.net
References: <20040626130645.55be13ce@lembas.zaitcev.lan> <200406270631.41102.oliver@neukum.org> <20040626233423.7d4c1189.davem@redhat.com> <200406271242.22490.oliver@neukum.org> <20040627142628.34b60c82.davem@redhat.com> <20040628141517.GA4311@yoda.timesys> <20040628132531.036281b0.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
In-Reply-To: <20040628132531.036281b0.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 28, 2004 at 01:25:31PM -0700, David S. Miller wrote:
> I think it's bad to just "smack this attribute onto any structure that
> _MIGHT_ need it on some platform"  I never do that in my drivers,
> and they work on all platforms.  For example, if you have a simple
> DMA descriptor structure such as:
>=20
> 	struct txd {
> 		u32 dma_addr;
> 		u32 length;
> 	};
>=20
> It is just total and utter madness to put a packed or the proposed
> __nopadding__ attribute on that structure.  Yet this seems to be
> what was suggested now and at the beginning of this thread.

I guess, in the end, what this comes down to is the fact that we're all
going to get bitten on the ass when we finally get to a platform where the
default alignment is 64-bits, which would then (by default) add padding to
the above structure.

How long until that time comes?  Likely within my lifetime, and I'd rather
not have to re-write working code into more working code because I couldn't
express to the compiler what I needed it to do.

Yes, __packed__ is overkill, because it specifies both a no-wasted-space
storage as well as the possibility of a completely unaligned pointer.
__nopadding__ would, as proposed, represent what we mean more closely.

Personally, I think it would be nice to see a way to mark all structures
that are passed "over the wire" (regardless of if that wire is USB, PCI, or
whatever), so that when we move to the FooMatic4000 arch, it will
JustWork(tm) instead of being a major PITA.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

You are needink to look more evil.  You likink very strong coffee?
					-- Pitr to Dust Puppy
User Friendly, 10/16/1998

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA4ISyIjReC7bSPZARAlPdAJ49KW+hDoj8qRwLVc5DSQ/JaZSCawCgjtq4
Liz42KXDWe4avxkTMpQASqg=
=81db
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
