Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263500AbTKFLcq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 06:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbTKFLcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 06:32:46 -0500
Received: from mail.donpac.ru ([80.254.111.2]:3258 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S263500AbTKFLcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 06:32:43 -0500
Date: Thu, 6 Nov 2003 14:32:39 +0300
From: Andrey Panin <pazke@donpac.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix visws breakage in 2.6.0-test9
Message-ID: <20031106113239.GB2685@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
X-SMTP-TLS: TLSv1:AES256-SHA:256
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Clx92ZfkiYIKRjnr
Content-Type: multipart/mixed; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,=20

attached patch fixes visws subarch which was broken by
asm-i386/hw_irq.h changes in 2.6.0-test9.

Please apply.

Best regards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-visws-2.6.0-test9"
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux.vanilla/arch/i386/mach-visws/visws_a=
pic.c linux/arch/i386/mach-visws/visws_apic.c
--- linux.vanilla/arch/i386/mach-visws/visws_apic.c	2003-10-27 14:10:03.000=
000000 +0300
+++ linux/arch/i386/mach-visws/visws_apic.c	2003-10-31 15:42:06.000000000 +=
0300
@@ -31,9 +31,6 @@
 #include "irq_vectors.h"
=20
=20
-int irq_vector[NR_IRQS] =3D { FIRST_EXTERNAL_VECTOR, 0 };
-
-
 static spinlock_t cobalt_lock =3D SPIN_LOCK_UNLOCKED;
=20
 /*
@@ -42,7 +39,7 @@
  */
 static inline void co_apic_set(int entry, int irq)
 {
-	co_apic_write(CO_APIC_LO(entry), CO_APIC_LEVEL | irq_vector[irq]);
+	co_apic_write(CO_APIC_LO(entry), CO_APIC_LEVEL | (irq + FIRST_EXTERNAL_VE=
CTOR));
 	co_apic_write(CO_APIC_HI(entry), 0);
 }
=20
@@ -299,7 +296,6 @@
 		else if (IS_CO_APIC(i)) {
 			irq_desc[i].handler =3D &cobalt_irq_type;
 		}
-		irq_vector[i] =3D i + FIRST_EXTERNAL_VECTOR;
 	}
=20
 	setup_irq(CO_IRQ_8259, &master_action);

--qlTNgmc+xy1dBmNv--

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/qjFXby9O0+A2ZecRAneZAJ9R0SLByoLW8kRbhMsoIzxnUaiO8ACdE3VG
1+JswtR1FbNVRmyOZIztO0M=
=kI9X
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
