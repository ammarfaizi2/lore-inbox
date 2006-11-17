Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933622AbWKQOeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933622AbWKQOeH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 09:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933624AbWKQOeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 09:34:07 -0500
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86]:61906 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP id S933622AbWKQOeD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 09:34:03 -0500
Date: Fri, 17 Nov 2006 09:36:58 -0500
From: Stuffed Crust <pizza@shaftnet.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Christian Hoffmann <chrmhoffmann@gmail.com>,
       Andrew Morton <akpm@osdl.org>,
       Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Message-ID: <20061117143658.GB5158@shaftnet.org>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-fbdev-devel@lists.sourceforge.net,
	Christian Hoffmann <chrmhoffmann@gmail.com>,
	Andrew Morton <akpm@osdl.org>,
	Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>,
	LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com> <200611151109.06956.rjw@sisk.pl> <200611162317.30880.chrmhoffmann@gmail.com> <200611162344.41622.rjw@sisk.pl> <20061117052755.GA23831@shaftnet.org> <1163744220.5940.443.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <1163744220.5940.443.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.0.2 (shaft.shaftnet.org [127.0.0.1]); Fri, 17 Nov 2006 09:37:00 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2006 at 05:17:00PM +1100, Benjamin Herrenschmidt wrote:
> > radeonfb is still using its own code for saving and restoring PCI=20
> > registers; I'm in the process of fixing it up to use proper PCI
> > subsystem calls.  That will hopefully work better.  =20
> >=20
> > It's possible there's a good reason (other than "nobody's ported it ove=
r=20
> > yet") that the radeonfb driver is doing it manually, but I don't know=
=20
> > why that would be the case. =20
>=20
> Well, radeonfb has code to bring back some cards from D2 or D3 cold (or
> hard reset). It differenciates those states by checking if the config
> space has been trashed. We should try to find out some better way.

The d2 vs d3 is determined by chipset in advance -- powermacs and some=20
thinkpads use d2, and everyone else uses d3.

On resume, we check that same flag, and restore differently.  We only=20
checked the config space on D3 resume, and restored everything if the=20
first byte was trashed..  =20

If I understand what you're saying correctly, if we re-write a valid set
of pci registers, we'll trash the radeon state?   Why _wouldn't_ a D3=20
resume be trashed?

 - Solomon
--=20
Solomon Peachy        		       pizza at shaftnet dot org	=20
Melbourne, FL                          ^^ (mail/jabber/gtalk) ^^
Quidquid latine dictum sit, altum viditur.          ICQ: 1318344


--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFFXckKPuLgii2759ARAlPdAKCMAaSNaASscvIbRz8/d7rIKiJlJQCeOegj
/hGsErmJP2Rhbp7xs/SjXHM=
=NqTo
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
