Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWAQXSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWAQXSM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWAQXSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:18:12 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.37]:6872 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S964886AbWAQXSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:18:10 -0500
Date: Wed, 18 Jan 2006 01:18:02 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Huge pages and small pages. . .
Message-ID: <20060117231802.GA14314@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	John Richard Moser <nigelenki@comcast.net>,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	linux-kernel@vger.kernel.org
References: <43CD3CE4.3090300@comcast.net> <Pine.LNX.4.61.0601171358240.1682@chaos.analogic.com> <43CD481A.6040606@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <43CD481A.6040606@comcast.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 17, 2006 at 02:40:10PM -0500, John Richard Moser wrote:
> Well, pages are typically 4KiB seen by the MMU.  If you fault across
> them, you need to have them cached in the TLB; if the TLB runs out of
> room, you invalidate entries; then when you hit entries not in the TLB,
> the TLB has to searhc for the page mapping in the PTE chain.
>=20
> There are 4MiB pages, called "huge pages," that if you clump 1024
> contiguous 4KiB pages together and draw a PTE entry up for can correlate
> to a single TLB entry.  In this way, there's no page faulting until you
> cross boundaries spaced 4MiB apart from eachother, and you use 1 TLB
> entry where you would normally use 1024.
>=20
Transparent superpages would certainly be nice. There's already various
superpage implementations floating around, but not without their
drawbacks. You might consider the Shimizu superpage patch for x86 if
you're not too concerned about demotion when trying to swap out the page.

There's some links on this subject on the ia64 wiki:

	http://www.gelato.unsw.edu.au/IA64wiki/SuperPages

Alternately, if you're simply interested in cutting down on the page
fault overhead and want a simpler and more naive approach, read the rice
paper and consider something like the IRIX/HP-UX approach (though for
x86, arm, etc. this might be slightly more work, since the larger pages
are at the PMD level, as opposed to other architectures where it's just a
matter of setting some bits in the PTE).

Since this topic seems to come up rather frequently, perhaps it would be
worthwhile documenting some of this on the linux-mm wiki.

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDzXsq1K+teJFxZ9wRAsvMAJ9TqL3Movygck3LbHdYCNyeT5UKwwCfZtEh
PwpPLKeT2wNMIqkZYFKmp3g=
=UHPt
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
