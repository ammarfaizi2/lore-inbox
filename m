Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264592AbTE1HaG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 03:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264593AbTE1HaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 03:30:06 -0400
Received: from p164.ats40.donpac.ru ([217.107.128.164]:52409 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S264592AbTE1HaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 03:30:03 -0400
Date: Wed, 28 May 2003 11:43:14 +0400
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][VISWS] irqreturn_t conversion
Message-ID: <20030528074314.GD3389@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
X-Uname: Linux 2.5.68 i686 unknown
User-Agent: Mutt/1.5.4i
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -9.7 (---------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19Kvad-00036Q-VU*W2QuefrnCLM*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QRj9sO5tAVLaXnSD
Content-Type: multipart/mixed; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

this small patch (against 2.5.70) updates visws_apic.c in accordance=20
with linux irq handling changes.

Please consider applying.

Best regards.

--=20
Andrey Panin		| Embedded systems software developer
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-visws-2.5.70"
Content-Transfer-Encoding: quoted-printable

diff -urN linux-2.5.70.vanilla/arch/i386/mach-visws/visws_apic.c linux-2.5.=
70/arch/i386/mach-visws/visws_apic.c
--- linux-2.5.70.vanilla/arch/i386/mach-visws/visws_apic.c	2003-05-27 14:45=
:25.000000000 +0400
+++ linux-2.5.70/arch/i386/mach-visws/visws_apic.c	2003-05-27 11:37:04.0000=
00000 +0400
@@ -196,7 +196,7 @@
  * enable_irq gets the right irq. This 'master' irq is never directly
  * manipulated by any driver.
  */
-static void piix4_master_intr(int irq, void *dev_id, struct pt_regs * regs)
+static irqreturn_t piix4_master_intr(int irq, void *dev_id, struct pt_regs=
 * regs)
 {
 	int realirq;
 	irq_desc_t *desc;
@@ -254,11 +254,11 @@
 	if (!(desc->status & IRQ_DISABLED))
 		enable_8259A_irq(realirq);
=20
-	return;
+	return IRQ_HANDLED;
=20
 out_unlock:
 	spin_unlock_irqrestore(&i8259A_lock, flags);
-	return;
+	return IRQ_NONE;
 }
=20
 static struct irqaction master_action =3D {

--Yylu36WmvOXNoKYn--

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+1GiSby9O0+A2ZecRAp7CAKC1llo0RDANolvnIgw/3dv0Mt9SEACdFJw2
MzKDGz6Hb0glSk8CneKtzvQ=
=Hsrn
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
