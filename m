Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163197AbWLGSc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163197AbWLGSc3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 13:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163195AbWLGSc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 13:32:29 -0500
Received: from master.altlinux.org ([62.118.250.235]:3499 "EHLO
	master.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163197AbWLGSc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 13:32:27 -0500
Date: Thu, 7 Dec 2006 21:32:17 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Bauke Jan Douma <bjdouma@xs4all.nl>
Cc: Adrian Bunk <bunk@stusta.de>, gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, Daniel Ritz <daniel.ritz@gmx.ch>,
       Daniel Drake <dsd@gentoo.org>, Jean Delvare <khali@linux-fr.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Linus Torvalds <torvalds@osdl.org>, Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Tomasz Koprowski <tomek@koprowski.org>
Subject: Re: RFC: PCI quirks update for 2.6.16
Message-ID: <20061207183217.GA7865@procyon.home>
References: <20061207132430.GF8963@stusta.de> <20061207165352.9cb61023.vsu@altlinux.ru> <45784F0C.7040005@xs4all.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <45784F0C.7040005@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2006 at 06:27:40PM +0100, Bauke Jan Douma wrote:
> Sergey Vlasov wrote on 07-12-06 14:53:
> >On Thu, 7 Dec 2006 14:24:30 +0100 Adrian Bunk wrote:
> >
> >>While checking how to fix the VIA quirk regressions for several users
> >>introduced into -stable in 2.6.16.17, I started looking through all
> >>drivers/pci/quirks.c updates up to both -stable and 2.6.19.
> >>
> [snip]
> >>
> >>Bauke Jan Douma (1):
> >>      PCI: quirk for asus a8v and a8v delux motherboards
> >
> >This quirk will cause breakage for people who used an external PCI
> >soundcard with these boards - the builtin sound chip which was
> >invisible before may become the first audio device.
>=20
> I'm afraid I don't understand the problem described here, when
> ALSA can assign any arbitrary index number of a user's choice
> to cards that are detected.

The problem is that -stable patches should not introduce regression.
And if this patch would be included in the next -stable release,
people who upgrade to this release may get unexpected changes of sound
cards indexes.  This may be OK for a new 2.6.x release, but not for a
new 2.6.16.y.

> Indeed, on my system (an A8V Deluxe motherboard, with this
> quirk active), my first soundcard (given index=3D0) is an offboard
> Creative SB Live, and the onboard card I have assigned index=3D1.

Yes, now I have exactly the same setup.  But before this patch I did
not have any index=3DN assignments in my configuration; after the patch
I needed to add them to get my system working as before.

> I for one need this quirk to get both soundcards at all (which
> I need) -- no matter what indexing order.

I don't question the need for this patch in mainline; however, it does
not seem to be suitable for -stable.

> >It also enables the MC97 device, which does not really work (there is
> >no MC97 codec attached to the controller at least on A8V Deluxe; I'm
> >not sure if there is some other variant of this board which has MC97,
> >but it seems unlikely).
>=20
> This one can be disabled separate of the AC97 -- let me get back
> on that.  I, for one (however much that is), don't need it either.

Currently I get:

VIA 82xx Modem: probe of 0000:00:11.6 failed with error -13

on every boot (and snd_via82xx_modem module in memory).  Not a grave
bug, but not a good thing either (and another reason for not adding
this patch to 2.6.16.y).

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFeF4xW82GfkQfsqIRAkESAJsEi9GTwmgRnVArHRors9YelKcopwCfeCAG
fgCSxhuI5so6ktbYYrjUPr0=
=z91v
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
