Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVB0TwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVB0TwN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 14:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVB0TwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 14:52:13 -0500
Received: from ipp23-131.piekary.net ([80.48.23.131]:51140 "EHLO spock.one.pl")
	by vger.kernel.org with ESMTP id S261488AbVB0TwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 14:52:07 -0500
Date: Sun, 27 Feb 2005 20:52:06 +0100
From: Michal Januszewski <spock@gentoo.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Bootsplash for 2.6.11-rc4
Message-ID: <20050227195206.GA2202@spock.one.pl>
References: <20050218165254.GA1359@elf.ucw.cz> <20050219011433.GA5954@spock.one.pl> <20050219230326.GB13135@kroah.com> <20050219232519.GC1372@elf.ucw.cz> <20050220132600.GA19700@spock.one.pl> <20050227165420.GD1441@elf.ucw.cz> <1109532700.15362.42.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <1109532700.15362.42.camel@laptopd505.fenrus.org>
X-PGP-Key: http://dev.gentoo.org/~spock/spock.gpg
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 27, 2005 at 08:31:39PM +0100, Arjan van de Ven wrote:

> well.. how much does it really need in kernel space? I mean, with all
> drivers as modules, and the "quiet" option, initramfs runs *really*
> fast. And that can just bang a bitmap to the framebuffer as first
> thing... (rhgb does it a bit later but that's a design choice in a
> feature vs early-boot tradeoff).

Most of the code in fbsplash handles the so-called 'verbose' mode,
ie. displaying a pretty picture in the background of the consoles.=20
The 'silent' mode (progress bar and stuff) can be brought down to=20
a single call to a userspace helper which can paint the initial bitmap
or do whatever else it wants to do. In fact, this is how it works now.
However, fbsplash currently not only calls the helper, but also tracks
whether we're running in the 'silent' mode or in the 'verbose' mode.=20
I plan to remove that functionality, so we'll be left with the
following:=20
- silent is handled 100% by userspace
- verbose is handled by fbsplash (ie. kernelspace)
- fbsplash takes care of the initial call to the userspace=20
  helper when starting in the silent mode (splash=3Dsilent in
  the kernel command line)
=20
Live long and prosper.
--=20
Michal 'Spock' Januszewski                        Gentoo Linux Developer
cell: +48504917690                         http://dev.gentoo.org/~spock/
JID: spock@im.gentoo.org               freenode: #gentoo-dev, #gentoo-pl


--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCIiTmaQ0HSaOUe+YRAsXBAJ9rVU2xjwYCltX2FeF8NgfG9ltfyQCeP/m9
kq1D8GS65obiyuU95UEmIQc=
=BBPD
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
