Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162946AbWLBLBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162946AbWLBLBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162945AbWLBLBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:01:01 -0500
Received: from websrv.werbeagentur-aufwind.de ([88.198.253.206]:22418 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S1162942AbWLBLAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:00:52 -0500
Subject: Re: [stable][PATCH < 2.6.19] Fix data corruption with dm-crypt
	over RAID5
From: Christophe Saout <christophe@saout.de>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, dm-crypt@saout.de,
       Andrey <dm-crypt-revealed-address@lelik.org>,
       Andrew Morton <akpm@osdl.org>, agk@redhat.com,
       Neil Brown <neilb@suse.de>, Jens Axboe <jens.axboe@oracle.com>,
       stable@kernel.org
In-Reply-To: <20061202034947.GE6602@sequoia.sous-sol.org>
References: <456B732F.6080906@lelik.org>
	 <20061129145208.GQ4409@agk.surrey.redhat.com> <456F46E3.6030702@lelik.org>
	 <1164983209.24524.20.camel@leto.intern.saout.de>
	 <20061201152143.GE4409@agk.surrey.redhat.com> <45704B95.3020308@lelik.org>
	 <1165026116.29307.18.camel@leto.intern.saout.de>
	 <1165026476.29307.23.camel@leto.intern.saout.de>
	 <20061202034947.GE6602@sequoia.sous-sol.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6GPEPENJBxq39thyM/1x"
Date: Sat, 02 Dec 2006 12:00:48 +0100
Message-Id: <1165057248.15095.9.camel@leto.intern.saout.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6GPEPENJBxq39thyM/1x
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Freitag, den 01.12.2006, 19:49 -0800 schrieb Chris Wright:

> * Christophe Saout (christophe@saout.de) wrote:
> > Fix corruption issue with dm-crypt on top of software raid5. Cancelled
> > readahead bio's that report no error, just have BIO_UPTODATE cleared
> > were reported as successful reads to the higher layers (and leaving
> > random content in the buffer cache). Already fixed in 2.6.19.
>=20
> I take it this is fixed a different way in 2.6.19?  Mind clarifying the
> difference?

It's more or less fixed the same way in 2.6.19. The function was
reordered by Milan Broz to accommodate the changed write path (commit
8b004457168995f2ae2a35327f885183a9e74141):

> [PATCH] dm crypt: restructure for workqueue change
>
> Restructure part of the dm-crypt code in preparation for workqueue
> changes.
>
> Use 'base_bio' or 'clone' variable names consistently throughout.  No
> functional changes are included in this patch.

"No functional changes" actually included the correct fix, accidental or
not.

> Minor nit:  introduces trailing whitespaces, cleaned it up locally.

Ouch, sorry.


--=-6GPEPENJBxq39thyM/1x
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFcVzgZCYBcts5dM0RAvtuAKCcKAnVpKhxOo0y63OHHwIYGS35mwCgoPU5
z8Tt0rIhJW9ecEKOdrDa3pE=
=wMM/
-----END PGP SIGNATURE-----

--=-6GPEPENJBxq39thyM/1x--

