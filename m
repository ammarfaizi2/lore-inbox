Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263222AbTIVQWc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 12:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263220AbTIVQWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 12:22:18 -0400
Received: from fed1mtao05.cox.net ([68.6.19.126]:11775 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S263214AbTIVQWE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 12:22:04 -0400
Date: Mon, 22 Sep 2003 09:21:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Cliff White <cliffw@osdl.org>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: 2.6.0-test5 - powermac compile problem "incorrect section attributes for .plt"
Message-ID: <20030922162156.GI7443@ip68-0-152-218.tc.ph.cox.net>
References: <200309192208.h8JM8WH26535@mail.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <200309192208.h8JM8WH26535@mail.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2003 at 03:08:32PM -0700, Cliff White wrote:

> System is an iBook2,
> distro is Debian unstable
> kernel is 2.6.0-test5 or current from
> bk://ppc.bkbits.net/linuxppc-2.5
>=20
> gcc version 3.3.2 20030908 (Debian prerelease)
>=20
> When compiling modules, i get this warning, repeatedly:
>  CC [M]  sound/ppc/pmac.o
> {standard input}: Assembler messages:
> {standard input}:3: Warning: setting incorrect section attributes for .plt
>=20
> Then, this failure:
>=20
>   AS      arch/ppc/boot/common//util.o
> arch/ppc/boot/common/util.S: Assembler messages:
> arch/ppc/boot/common/util.S:220: Warning: setting incorrect section attri=
butes=20
> for .relocate_code
> arch/ppc/boot/common//util.o: File truncated
> arch/ppc/boot/common/util.S:281: FATAL: Can't write=20
> arch/ppc/boot/common//util.o: File truncated
> make[2]: *** [arch/ppc/boot/common//util.o] Error 1
> make[1]: *** [arch/ppc/boot/common/] Error 2
>=20
> Suggestions appreciated.

I suspect this is a binutils bug.  But can you try the following?  We
shouldn't need a '.previous' here, as it is the end of the file anyhow.

=3D=3D=3D=3D=3D arch/ppc/boot/common/util.S 1.6 vs edited =3D=3D=3D=3D=3D
--- 1.6/arch/ppc/boot/common/util.S	Thu Aug 21 10:17:00 2003
+++ edited/arch/ppc/boot/common/util.S	Mon Sep 22 09:21:37 2003
@@ -277,6 +277,3 @@
 	addi	r3,r3,L1_CACHE_BYTES	/* Next line, please */
 	bdnz	00b
 10:	blr
-
-	.previous
-

--=20
Tom Rini
http://gate.crashing.org/~trini/

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/byGkdZngf2G4WwMRAm3iAKCFuIqk8XQvus5J+kP3+AnoHeZ0qQCfeZQw
w2r4X8r8lwEhcUvuy6LwAws=
=nvoK
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
