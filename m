Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWISGZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWISGZX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 02:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbWISGZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 02:25:23 -0400
Received: from mail.isohunt.com ([69.64.61.20]:160 "EHLO mail.isohunt.com")
	by vger.kernel.org with ESMTP id S964904AbWISGZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 02:25:21 -0400
X-Spam-Check-By: mail.isohunt.com
Date: Tue, 19 Sep 2006 00:03:32 -0700
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, "Robin H. Johnson" <robbat2@gentoo.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc7-git1: AHCI not seeing devices on ICH8 mobo (DG965RY)
Message-ID: <20060919070332.GE569@curie-int.orbis-terrarum.net>
References: <20060914200500.GD27531@curie-int.orbis-terrarum.net> <4509AB2E.1030800@garzik.org> <20060914205050.GE27531@curie-int.orbis-terrarum.net> <20060916203812.GC30391@curie-int.orbis-terrarum.net> <20060916210857.GD30391@curie-int.orbis-terrarum.net> <20060917074929.GD25800@htj.dyndns.org> <450F88F0.307@garzik.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline
In-Reply-To: <450F88F0.307@garzik.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2006 at 02:06:40AM -0400, Jeff Garzik wrote:
> I don't really like this port_tbl approach.  I think it complicates=20
> things too much.
>=20
> Direct indexing should be fine.  For the non-linear case, just make sure=
=20
> the non-existent ports are always dummy ports.  If the driver directly=20
> references a port we know isn't there, that's just an AHCI bug to be=20
> fixed...
So you think we should ignore CAP.NP and instead set our n_ports to the
position of the left-most 1-bit in PI? That would break in your case of
PI containing invalid data.

I do think a mapping is the way to go, but the implementation can
perhaps be improved a little - so that the table is local to the
probing, and is not used thereafter - because the data is stored in the
ata_ports->private_data instead.

For my hardware, note that CAP.NP was 4, and PI was (binary) 110011. By
my reading of the spec, this is correct - and says there are 4 usable
ports, located at addresses 0, 1, 4, 5.

Looking at the motherboard more closely, I do find two other unpopulated
SATA headers (also lacking the various electrical bits, so not trivial
to hack on).

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFD5ZEPpIsIjIzwiwRArHOAJ9JwxUgk4699FuuIE5aoyYBiMb+xgCgru0s
BANBrpWbTVRJPSQ2008mkR8=
=9eNO
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
