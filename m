Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVGTLPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVGTLPt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 07:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVGTLPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 07:15:49 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:48874 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S261157AbVGTLP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 07:15:27 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci_find_device --> pci_get_device
Date: Wed, 20 Jul 2005 13:19:29 +0200
User-Agent: KMail/1.8.1
Cc: Jiri Slaby <jirislaby@gmail.com>, rth@twiddle.net, dhowells@redhat.com,
       kumar.gala@freescale.com, davem@davemloft.net, mhw@wittsend.com,
       Rogier Wolff <R.E.Wolff@bitwizard.nl>, nils@kernelconcepts.de,
       cjtsai@ali.com.tw, Lionel.Bouton@inet6.fr, benh@kernel.crashing.org,
       mchehab@brturbo.com.br, laredo@gnu.org, rbultje@ronald.bitfreak.net,
       middelin@polyware.nl, philb@gnu.org, tim@cyberelk.net,
       campbell@torque.net, andrea@suse.de, linux@advansys.com,
       mulix@mulix.org
References: <42DC4873.2080807@gmail.com> <200507191820.35472@bilbo.math.uni-mannheim.de> <42DE2A31.7080505@gmail.com>
In-Reply-To: <42DE2A31.7080505@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart17263247.sU2RnSQhd5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507201319.42050@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart17263247.sU2RnSQhd5
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch, 20. Juli 2005 12:40 schrieb Jiri Slaby:
>Rolf Eike Beer napsal(a):
>>Your patch to arch/sparc64/kernel/ebus.c is broken, the removed and added
>>parts do not match in behaviour.
>
>I can't still see the difference.

diff --git a/arch/sparc64/kernel/ebus.c b/arch/sparc64/kernel/ebus.c
=2D-- a/arch/sparc64/kernel/ebus.c
+++ b/arch/sparc64/kernel/ebus.c
@@ -527,8 +527,15 @@ static struct pci_dev *find_next_ebus(st
 {
 	struct pci_dev *pdev =3D start;
=20
=2D	do {
=2D		pdev =3D pci_find_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev);
+    while (pdev =3D pci_get_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev))
+		if (pdev->device =3D=3D PCI_DEVICE_ID_SUN_EBUS ||
+			pdev->device =3D=3D PCI_DEVICE_ID_SUN_RIO_EBUS)
+			break;
+
+	*is_rio_p =3D !!(pdev && (pdev->device =3D=3D PCI_DEVICE_ID_SUN_RIO_EBUS)=
);
+=09
+/*	do { // BEFORE \/           AFTER ^
+ *		pdev =3D pci_find_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev);
 		if (pdev &&
 		    (pdev->device =3D=3D PCI_DEVICE_ID_SUN_EBUS ||
 		     pdev->device =3D=3D PCI_DEVICE_ID_SUN_RIO_EBUS))

Eike

--nextPart17263247.sU2RnSQhd5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBC3jNNXKSJPmm5/E4RAr3zAJ0SVBMR2yLnLRWoYPy8pGPIYtcVSQCginj7
UnLy4+fvkmvVH5pkBQXQHLo=
=XaRf
-----END PGP SIGNATURE-----

--nextPart17263247.sU2RnSQhd5--
