Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290595AbSBLR3Z>; Tue, 12 Feb 2002 12:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290767AbSBLR3L>; Tue, 12 Feb 2002 12:29:11 -0500
Received: from mx02.qsc.de ([213.148.130.14]:44231 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id <S290595AbSBLR2y>;
	Tue, 12 Feb 2002 12:28:54 -0500
Subject: Re: pci_pool reap?
From: Daniel Stodden <stodden@in.tum.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, groudier@free.fr,
        alan@lxorguk.ukuu.org.uk, zaitcev@redhat.com,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020212154816.E31425@flint.arm.linux.org.uk>
In-Reply-To: <E16a6sw-0005Jw-00@the-village.bc.nu>
	<20020210211352.Q1910-100000@gerard>
	<20020211.184412.35663889.davem@redhat.com>
	<1013528224.2240.245.camel@bitch> 
	<20020212154816.E31425@flint.arm.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-D8m5veRzJ+m74u2UTOOR"
X-Mailer: Evolution/1.0.2 
Date: 12 Feb 2002 18:27:02 +0100
Message-Id: <1013534853.1598.270.camel@bitch>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D8m5veRzJ+m74u2UTOOR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hi.

On Tue, 2002-02-12 at 16:48, Russell King wrote:
> On Tue, Feb 12, 2002 at 04:36:34PM +0100, Daniel Stodden wrote:
> > ARM does GFP_KERNEL, and then __ioremaps the underlying pages.
> > ugh. is that the only way to get the area coherent?
>=20
> Yes.  Cache bits are in the page tables, and it would be idiotic to
> manipulate the cache bits on a 1MB granularity over the kernel
> direct mapped space.
>=20
> > furthermore i don't see why this could not be interrupt safe.
>=20
> GFP_KERNEL in the page table allocation functions mainly.  We've been
> around and around this recently on this mailing list, so I'm not going
> to say anything further.  I don't want another long discussion about
> this subject taking my time away from doing real work on ARM.  If you're
> really interested in the outcome, please examine the lkml archives.

ok. i read part of the old thread now. sorry. didn't know that this had
already been issued.

so, based on the fact that
1. _most_ archs can easily do atomically.
2. those which don't aren't necessarily the better ones.
3. many drivers may prefer/be able to alloc through during
   _init()/_release()
3.5 some may not.
4. even on arm, __ioremap() takes a gfp for quite some time now=20
   and nobody seems to disagree.

then why does pci_alloc_consistent() not just take gfp flags and people
put in what their personal preference is?

regards,
dns


--=20
___________________________________________________________________________
 mailto:stodden@in.tum.de


--=-D8m5veRzJ+m74u2UTOOR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8aVBmSPSplX5M5nQRAk90AKCAMUIOoO7UaqoiPc9Hy2dHS+HptwCeJ+mK
RETQ5TYBHUWeNRpI8bbDCTo=
=d62Z
-----END PGP SIGNATURE-----

--=-D8m5veRzJ+m74u2UTOOR--

