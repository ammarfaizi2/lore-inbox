Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752097AbWCJAIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbWCJAIj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbWCJAIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:08:39 -0500
Received: from mout1.freenet.de ([194.97.50.132]:33003 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S1752097AbWCJAIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:08:38 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Document Linux's memory barriers [try #4]
Date: Fri, 10 Mar 2006 01:07:46 +0100
User-Agent: KMail/1.8.3
References: <16835.1141936162@warthog.cambridge.redhat.com> <200603100045.10375.mbuesch@freenet.de> <Pine.LNX.4.64.0603091554200.18022@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603091554200.18022@g5.osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, akpm@osdl.org, mingo@redhat.com,
       alan@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
MIME-Version: 1.0
Message-Id: <200603100107.46655.mbuesch@freenet.de>
Content-Type: multipart/signed;
  boundary="nextPart10023134.nbRTIBHvRr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-Warning: 213.54.177.245 is listed at list.dsbl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart10023134.nbRTIBHvRr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 10 March 2006 00:56, you wrote:
>=20
> On Fri, 10 Mar 2006, Michael Buesch wrote:
> >=20
> > So what about:
> >=20
> > #define spin_lock_mmio(lock)	spin_lock(lock)
> > #define spin_unlock_mmio(lock)	do { spin_unlock(lock); mmiowb(); } whil=
e (0)
>=20
> You need to put the mmiowb() inside the spinlock.

Ok, sorry. That was a typo.
I should not do more than 3 things at the same time. :)

> Yes, that is painful. But the point being that if it's outside, then when=
=20
> somebody else gets the lock, the previous lock-owners MMIO stores may=20
> still be in flight, which is what you didn't want in the first place.
>=20
> Anyway, no need to make a new name for it, since you might as well just=20
> use the mmiowb() explicitly. At least until this has been shown to be a=20
> really common pattern (it clearly isn't, right now ;)

Ok, so maybe it is best if every device creates its own macros
for convenience (if needed =3D> if it is a common pattern
in the scope of the driver).

Example:
#define bcm43xx_lock(bcm, flags)	spin_lock_irqsave(&(bcm)->lock, flags)
#define bcm43xx_unlock(bcm, flags)	do { mmiowb(); spin_unlock_irqrestore(&(=
bcm)->lock, flags); } while (0)

=2D-=20
Greetings Michael.

--nextPart10023134.nbRTIBHvRr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEEMNSlb09HEdWDKgRAuOnAKC2qlALmVCy+lkWnpAEdr215kgCrgCeKas4
HSal0qzIVXDbUUr03kJndYo=
=zRBo
-----END PGP SIGNATURE-----

--nextPart10023134.nbRTIBHvRr--
