Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266243AbUAVMLd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 07:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266254AbUAVMLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 07:11:33 -0500
Received: from mail.donpac.ru ([80.254.111.2]:26500 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S266243AbUAVML1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 07:11:27 -0500
Date: Thu, 22 Jan 2004 15:11:31 +0300
From: Andrey Panin <pazke@donpac.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] remove SIIG combo cards PCI ids from parport_pc
Message-ID: <20040122121131.GH5045@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vv4Sf/kQfcwinyKX"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
X-SMTP-TLS: TLSv1:AES256-SHA:256
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vv4Sf/kQfcwinyKX
Content-Type: multipart/mixed; boundary="AkbCVLjbJ9qUtAXD"
Content-Disposition: inline


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

support for SIIG made serial/parallel conbo cards was moved
to parport_serial driver some months ago, but their PCI ids
still remain in parport_pc PCI device table.
Attached patch (2.6.1) removes them. Please apply.

Best regards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-siig-combo-parport-remove-2.6"
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux-2.6.0-test11.vanilla/drivers/parport=
/parport_pc.c linux-2.6.0-test11/drivers/parport/parport_pc.c
--- linux-2.6.0-test11.vanilla/drivers/parport/parport_pc.c	2003-12-05 01:4=
3:22.000000000 +0300
+++ linux-2.6.0-test11/drivers/parport/parport_pc.c	2003-12-05 01:34:02.000=
000000 +0300
@@ -2686,25 +2686,10 @@
=20
=20
 enum parport_pc_pci_cards {
-	siig_1s1p_10x_550 =3D last_sio,
-	siig_1s1p_10x_650,
-	siig_1s1p_10x_850,
-	siig_1p_10x,
+	siig_1p_10x =3D last_sio,
 	siig_2p_10x,
-	siig_2s1p_10x_550,
-	siig_2s1p_10x_650,
-	siig_2s1p_10x_850,
 	siig_1p_20x,
 	siig_2p_20x,
-	siig_2p1s_20x_550,
-	siig_2p1s_20x_650,
-	siig_2p1s_20x_850,
-	siig_1s1p_20x_550,
-	siig_1s1p_20x_650,
-	siig_1s1p_20x_850,
-	siig_2s1p_20x_550,
-	siig_2s1p_20x_650,
-	siig_2s1p_20x_850,
 	lava_parallel,
 	lava_parallel_dual_a,
 	lava_parallel_dual_b,
@@ -2766,25 +2751,10 @@
 	 * is non-zero we couldn't use any of the ports. */
 	void (*postinit_hook) (struct pci_dev *pdev, int failed);
 } cards[] __devinitdata =3D {
-	/* siig_1s1p_10x_550 */		{ 1, { { 3, 4 }, } },
-	/* siig_1s1p_10x_650 */		{ 1, { { 3, 4 }, } },
-	/* siig_1s1p_10x_850 */		{ 1, { { 3, 4 }, } },
 	/* siig_1p_10x */		{ 1, { { 2, 3 }, } },
 	/* siig_2p_10x */		{ 2, { { 2, 3 }, { 4, 5 }, } },
-	/* siig_2s1p_10x_550 */		{ 1, { { 4, 5 }, } },
-	/* siig_2s1p_10x_650 */		{ 1, { { 4, 5 }, } },
-	/* siig_2s1p_10x_850 */		{ 1, { { 4, 5 }, } },
 	/* siig_1p_20x */		{ 1, { { 0, 1 }, } },
 	/* siig_2p_20x */		{ 2, { { 0, 1 }, { 2, 3 }, } },
-	/* siig_2p1s_20x_550 */		{ 2, { { 1, 2 }, { 3, 4 }, } },
-	/* siig_2p1s_20x_650 */		{ 2, { { 1, 2 }, { 3, 4 }, } },
-	/* siig_2p1s_20x_850 */		{ 2, { { 1, 2 }, { 3, 4 }, } },
-	/* siig_1s1p_20x_550 */		{ 1, { { 1, 2 }, } },
-	/* siig_1s1p_20x_650 */		{ 1, { { 1, 2 }, } },
-	/* siig_1s1p_20x_850 */		{ 1, { { 1, 2 }, } },
-	/* siig_2s1p_20x_550 */		{ 1, { { 2, 3 }, } },
-	/* siig_2s1p_20x_650 */		{ 1, { { 2, 3 }, } },
-	/* siig_2s1p_20x_850 */		{ 1, { { 2, 3 }, } },
 	/* lava_parallel */		{ 1, { { 0, -1 }, } },
 	/* lava_parallel_dual_a */	{ 1, { { 0, -1 }, } },
 	/* lava_parallel_dual_b */	{ 1, { { 0, -1 }, } },
@@ -2836,44 +2806,14 @@
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, sio_ite_8872 },
=20
 	/* PCI cards */
-	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_10x_550,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_1s1p_10x_550 },
-	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_10x_650,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_1s1p_10x_650 },
-	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_10x_850,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_1s1p_10x_850 },
 	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1P_10x,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_1p_10x },
 	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2P_10x,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2p_10x },
-	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_10x_550,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_10x_550 },
-	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_10x_650,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_10x_650 },
-	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_10x_850,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_10x_850 },
 	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1P_20x,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_1p_20x },
 	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2P_20x,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2p_20x },
-	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2P1S_20x_550,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2p1s_20x_550 },
-	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2P1S_20x_650,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2p1s_20x_650 },
-	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2P1S_20x_850,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2p1s_20x_850 },
-	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_20x_550,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_20x_550 },
-	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_20x_650,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_1s1p_20x_650 },
-	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_20x_850,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_1s1p_20x_850 },
-	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_20x_550,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_20x_550 },
-	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_20x_650,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_20x_650 },
-	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_20x_850,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_20x_850 },
 	{ PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_PARALLEL,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, lava_parallel },
 	{ PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_DUAL_PAR_A,

--AkbCVLjbJ9qUtAXD--

--vv4Sf/kQfcwinyKX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAD73zby9O0+A2ZecRApSqAJ40PjWy6hD+p6r1eG9fDz8GiXKjOACfXG/y
UwcLtN/ubp42r0rxG22vksM=
=kmRg
-----END PGP SIGNATURE-----

--vv4Sf/kQfcwinyKX--
