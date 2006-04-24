Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWDXAqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWDXAqI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 20:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWDXAqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 20:46:08 -0400
Received: from iucha.net ([209.98.146.184]:31458 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S1751469AbWDXAqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 20:46:07 -0400
Date: Sun, 23 Apr 2006 19:46:06 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: pcmcia oops on 2.6.17-rc[12]
Message-ID: <20060424004606.GF8896@iucha.net>
References: <20060423192251.GD8896@iucha.net> <20060423150206.546b7483.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qp4W5+cUSnZs0RIF"
Content-Disposition: inline
In-Reply-To: <20060423150206.546b7483.akpm@osdl.org>
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 5E59 C2E7 941E B592 3BA4  7DCF 343D 2B14 2376 6F5B
User-Agent: Mutt/1.5.11+cvs20060403
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qp4W5+cUSnZs0RIF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 23, 2006 at 03:02:06PM -0700, Andrew Morton wrote:
> florin@iucha.net (Florin Iucha) wrote:
> > With 2.6.17-rc[12] I get the following oops:
>
> It's actually not an oops - it's a warning, telling us that i82365 is
> requesting an IRQ in non-sharing mode, but there's already a handler
> registered for that IRQ (which might or might not be shareable).
>
> Your machine should otherwise continue to work OK.  Is that the case?

Yes, it works fine - it just looked scary ;)

> Anyway.  We need to either a) make i82365 better-behaved or b) remove the
> warning or c) allow callers to suppress the warning (SA_PROBEIRQ?).
>=20
> I think c) - the warning can help find bugs.
>=20
>=20
>=20
> From: Andrew Morton <akpm@osdl.org>
>=20
> - Add new SA_PROBEIRQ which suppresses the new sharing-mismatch warning.=
=20
>   Some drivers like to use request_irq() to find an unused interrupt slot.
>=20
> - Use it in i82365.c
>=20
> - Kill unused SA_PROBE.

[With the fix suggested by Randy] it is all quiet now.

Thanks,
florin

--qp4W5+cUSnZs0RIF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFETB/OND0rFCN2b1sRAs/xAJwMfzZTnvH55pzv9G5M/Khwg1pibwCeMvf9
6h8RM5mxmHgzUy7LZN99n5w=
=FWA2
-----END PGP SIGNATURE-----

--qp4W5+cUSnZs0RIF--
