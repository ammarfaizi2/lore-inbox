Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTJNV31 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 17:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262947AbTJNV31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 17:29:27 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:10161 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262942AbTJNV3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 17:29:24 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: len.brown@intel.com
Subject: [PATCH][2.4] fix "pci=noacpi" boot option
Date: Tue, 14 Oct 2003 23:28:58 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_bqGj/9JDIm2jPp1";
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200310142328.59083.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_bqGj/9JDIm2jPp1
Content-Type: multipart/mixed;
  boundary="Boundary-01=_aqGj/N2hMuYpb7z"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_aqGj/N2hMuYpb7z
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Len,

some time ago I sent a patch which fixed problems with the "pci=3Dnoacpi" b=
oot=20
option of the 2.5.xx linux-kernel. It got applied to the 2.5 kernel tree bu=
t=20
I missed to create a similar fix for the 2.4 tree which seems to have the=20
same issue.

Now I've seen reports of people having problems with the "pci=3Dnoacpi" boo=
t=20
option with current 2.4.xx kernel versions, too. So I ported my old patch t=
o=20
2.4.22-bk34, tested it and attached it to this mail. You may consider pushi=
ng=20
it to Marcelo.

Kind regards,
  Thomas

--Boundary-01=_aqGj/N2hMuYpb7z
Content-Type: text/x-diff;
  charset="us-ascii";
  name="fix_pci_noacpi.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="fix_pci_noacpi.diff"

=2D-- linux-2.4.22-bk34/arch/i386/kernel/acpi.c.orig	Tue Oct 14 20:50:18 20=
03
+++ linux-2.4.22-bk34/arch/i386/kernel/acpi.c	Tue Oct 14 20:53:45 2003
@@ -58,6 +58,7 @@
=20
 #ifdef CONFIG_ACPI_BOOT
 extern int acpi_disabled;
+extern int acpi_irq;
 extern int acpi_ht;
=20
 enum acpi_irq_model_id		acpi_irq_model;
@@ -415,7 +416,7 @@
 	 * If MPS is present, it will handle them,
 	 * otherwise the system will stay in PIC mode
 	 */
=2D	if (acpi_disabled) {
+	if (acpi_disabled || !acpi_irq) {
 		return 1;
 	}
=20
=2D-- linux-2.4.22-bk34/arch/i386/kernel/setup.c.orig	Tue Oct 14 20:50:25 2=
003
+++ linux-2.4.22-bk34/arch/i386/kernel/setup.c	Tue Oct 14 20:57:34 2003
@@ -184,6 +184,7 @@
 EXPORT_SYMBOL(acpi_disabled);
=20
 #ifdef	CONFIG_ACPI_BOOT
+	int acpi_irq __initdata =3D 1; 	/* enable IRQ */
 	int acpi_ht __initdata =3D 1; 	/* enable HT */
 #endif
=20
@@ -848,6 +849,11 @@
 		else if (!memcmp(from, "acpi=3Dht", 7)) {=20
 			acpi_ht =3D 1;=20
 			if (!acpi_force) acpi_disabled =3D 1;=20
+		}=20
+
+		/* "pci=3Dnoacpi" disables ACPI interrupt routing */
+		else if (!memcmp(from, "pci=3Dnoacpi", 10)) {=20
+			acpi_irq =3D 0;=20
 		}=20
=20
                 /* disable IO-APIC */

--Boundary-01=_aqGj/N2hMuYpb7z--

--Boundary-03=_bqGj/9JDIm2jPp1
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/jGqbYAiN+WRIZzQRAmtaAJ9WYGP5cONJPqohR68ms0FzHW3hAQCeJGv6
H6lLaljQB3dt8f3GNfvWJTk=
=E4CR
-----END PGP SIGNATURE-----

--Boundary-03=_bqGj/9JDIm2jPp1--
