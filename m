Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWIQSRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWIQSRT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 14:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWIQSRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 14:17:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15239 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751157AbWIQSRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 14:17:17 -0400
Subject: Re: Linux 2.6.18-rc6
From: Doug Ledford <dledford@redhat.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Olaf Hering <olaf@aepfle.de>, Linus Torvalds <torvalds@osdl.org>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1158501909.3485.1.camel@mulgrave.il.steeleye.com>
References: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org>
	 <20060905122656.GA3650@aepfle.de>
	 <1157490066.3463.73.camel@mulgrave.il.steeleye.com>
	 <20060906110147.GA12101@aepfle.de>
	 <1157551480.3469.8.camel@mulgrave.il.steeleye.com>
	 <20060907091517.GA21728@aepfle.de>
	 <1157637874.3462.8.camel@mulgrave.il.steeleye.com>
	 <1158378424.2661.150.camel@fc6.xsintricity.com>
	 <20060917053815.GA10918@aepfle.de>
	 <1158501909.3485.1.camel@mulgrave.il.steeleye.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DB8a90PxLJDkYspP0xCs"
Organization: Red Hat, Inc.
Date: Sun, 17 Sep 2006 14:17:01 -0400
Message-Id: <1158517021.17671.74.camel@fc6.xsintricity.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-1.fc6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DB8a90PxLJDkYspP0xCs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-09-17 at 09:05 -0500, James Bottomley wrote:
> On Sun, 2006-09-17 at 07:38 +0200, Olaf Hering wrote:
> > As pointed out in private mail, this patch fixes the machine check for
> > me. Thanks Doug.
> >=20
> > Maybe the AHC_ULTRA2 feature check is needed as well for other cards.
>=20
> It is ... the non ULTRA2 non twin cards might not have this register
> (and if they do, it doesn't reflect the LVD/SE bus setting).
>=20
> This is a pretty significant alteration, so it's not a -rc candidate,
> but I'll put it in scsi-misc and see how it works out.

No, it's present on all cards.  Reading it for signaling may not be
needed on non-ultra 2 cards (as far as LVD goes), but it won't hurt.
However, all the other places this particular register is touched in the
driver, the card is already paused.  Olaf's problem may be that this is
one of the registers that require the sequencer be paused before you
touch it.  Depending on the chipset, if you touch a pause only register,
it either pukes up like Olaf is seeing or auto pauses the chip.  I had
thought that all the Ultra2 chipsets did autopause, but maybe the
current driver disables that (and even if it did autopause, you would
still need an unpause or else the card stops until the next time
something happens that includes a pause/unpause pair).  Anyway, I asked
Olaf to try wrapping the read in an ahc_lock/unlock and pause/unpause
pair to see if it makes a difference.  We'll see.

--=20
Doug Ledford <dledford@redhat.com>
              GPG KeyID: CFBFF194
              http://people.redhat.com/dledford

Infiniband specific RPMs available at
              http://people.redhat.com/dledford/Infiniband

--=-DB8a90PxLJDkYspP0xCs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFDZEdg6WylM+/8ZQRArL6AJ9cNCzYKI8eMuhDH0oagHa2BMhAcACfa5ck
OwqNEePaNqgWQ8+Psn7xul4=
=CQjC
-----END PGP SIGNATURE-----

--=-DB8a90PxLJDkYspP0xCs--

