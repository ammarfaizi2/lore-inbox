Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264675AbTFARMR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 13:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264676AbTFARMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 13:12:17 -0400
Received: from ik-dynamic-66-102-74-246.kingston.net ([66.102.74.246]:47113
	"EHLO linux.interlinx.bc.ca") by vger.kernel.org with ESMTP
	id S264675AbTFARMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 13:12:14 -0400
Subject: Re: [PATCH][2.5] Honour dont_enable_local_apic flag
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: mikpe@csd.uu.se
Cc: zwane@linuxpower.ca, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <200306011123.h51BNIT7019716@harpo.it.uu.se>
References: <200306011123.h51BNIT7019716@harpo.it.uu.se>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-m3KeYdO7vy0A/JqsS3hF"
Message-Id: <1054488333.6676.68.camel@pc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3-1mdk (Preview Release)
Date: 01 Jun 2003 13:25:33 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-m3KeYdO7vy0A/JqsS3hF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-06-01 at 07:23, mikpe@csd.uu.se wrote:
>=20
>    (And if its local APIC is broken, cpu_has_apic should be cleared
>    rather than setting the dont_enable flag. Post-boot code may
>    access the local APIC if CONFIG_X86_LOCAL_APIC && cpu_has_apic.)

So would you prefer something more along the lines of:

--- arch/i386/kernel/setup.c.orig       2003-04-26 10:34:35.000000000 -0400
+++ arch/i386/kernel/setup.c    2003-06-01 13:11:47.000000000 -0400
@@ -845,6 +845,10 @@
                 */
                else if (!memcmp(from, "highmem=3D", 8))
                        highmem_pages =3D memparse(from+8, &from) >> PAGE_S=
HIFT;
+               else if (!memcmp(from, "nolapic", 7)) {
+                               clear_bit(X86_FEATURE_APIC, &boot_cpu_data.=
x86_capability);
+                               set_bit(X86_FEATURE_APIC, &disabled_x86_cap=
s);
+               }
 nextchar:
                c =3D *(from++);
                if (!c)

b.

--=20
Brian J. Murrell <brian@interlinx.bc.ca>

--=-m3KeYdO7vy0A/JqsS3hF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+2jcNl3EQlGLyuXARArOHAKDUcp1cPMeUcZ6/zPMVgMaSFUGv3ACgniYS
9BtNAdj1TQQWj73VLvvIDTo=
=422x
-----END PGP SIGNATURE-----

--=-m3KeYdO7vy0A/JqsS3hF--
