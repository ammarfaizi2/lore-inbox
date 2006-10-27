Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752511AbWJ0Vhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511AbWJ0Vhc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 17:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752512AbWJ0Vhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 17:37:32 -0400
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:38411 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S1752511AbWJ0Vhb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 17:37:31 -0400
Date: Fri, 27 Oct 2006 16:37:29 -0500
From: Ryan Underwood <nemesis@icequake.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19-rc3] parport_pc: Add support for OX16PCI952 parallel port
Message-ID: <20061027213729.GA22687@dbz.icequake.net>
Reply-To: nemesis@icequake.net
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


This patch adds support for the parallel port (implemented as separate
PCI function) on the Oxford Semiconductor OX16PCI952.

Signed-off-by: Ryan Underwood <nemesis@icequake.net>

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 39c9664..5749500 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2747,6 +2747,7 @@ enum parport_pc_pci_cards {
 	titan_1284p2,
 	avlab_1p,
 	avlab_2p,
+	oxsemi_952,
 	oxsemi_954,
 	oxsemi_840,
 	aks_0100,
@@ -2822,6 +2823,7 @@ static struct parport_pc_pci {
 	/* avlab_2p		*/	{ 2, { { 0, 1}, { 2, 3 },} },
 	/* The Oxford Semi cards are unusual: 954 doesn't support ECP,
 	 * and 840 locks up if you write 1 to bit 2! */
+	/* oxsemi_952 */		{ 1, { { 0, 1 }, } },
 	/* oxsemi_954 */		{ 1, { { 0, -1 }, } },
 	/* oxsemi_840 */		{ 1, { { 0, -1 }, } },
 	/* aks_0100 */                  { 1, { { 0, -1 }, } },
@@ -2895,6 +2897,8 @@ static const struct pci_device_id parpor
 	/* PCI_VENDOR_ID_AVLAB/Intek21 has another bunch of cards ...*/
 	{ 0x14db, 0x2120, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1p}, /* AFAVLAB_TK9=
902 */
 	{ 0x14db, 0x2121, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_2p},
+	{ PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI952PP,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_952 },
 	{ PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954PP,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_954 },
 	{ PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_12PCI840,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index f3a168f..c486e3d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1859,6 +1859,7 @@ #define PCI_DEVICE_ID_OXSEMI_16PCI954	0x
 #define PCI_DEVICE_ID_OXSEMI_16PCI95N	0x9511
 #define PCI_DEVICE_ID_OXSEMI_16PCI954PP	0x9513
 #define PCI_DEVICE_ID_OXSEMI_16PCI952	0x9521
+#define PCI_DEVICE_ID_OXSEMI_16PCI952PP	0x9523
=20
 #define PCI_VENDOR_ID_SAMSUNG		0x144d



--=20
Ryan Underwood, <nemesis@icequake.net>

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFFQnwZIonHnh+67jkRAlozAJ9IizxkR6aQzJM4K3eQ7Wm3bmOhIACeJW09
w+vn4Q5OCmtQ0iQXoLNOq/4=
=V7jW
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
