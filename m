Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267205AbTGOLfV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 07:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267210AbTGOLfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 07:35:21 -0400
Received: from mail.donpac.ru ([217.107.128.190]:31423 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S267205AbTGOLfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 07:35:13 -0400
Date: Tue, 15 Jul 2003 15:49:54 +0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] visws: fix PCI breakage in 2.6.0-test1
Message-ID: <20030715114954.GB719@pazke>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rqzD5py0kzyFAOWN"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -10.4 (----------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rqzD5py0kzyFAOWN
Content-Type: multipart/mixed; boundary="sHrvAb52M6C8blB9"
Content-Disposition: inline


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

this small patch (against 2.6.0-test1) fixes Visws PCI code
which was broken since 2.5.73.

Please apply.

Best regards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-visws-pci
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux-2.5.75.vanilla/arch/i386/pci/visws.c=
 linux-2.5.75/arch/i386/pci/visws.c
--- linux-2.5.75.vanilla/arch/i386/pci/visws.c	Tue Mar 25 18:59:20 2003
+++ linux-2.5.75/arch/i386/pci/visws.c	Sat Jul 12 00:09:19 2003
@@ -17,7 +17,7 @@
=20
 int broken_hp_bios_irq9;
=20
-extern struct pci_ops pci_direct_conf1;
+extern struct pci_raw_ops pci_direct_conf1;
=20
 static int pci_visws_enable_irq(struct pci_dev *dev) { return 0; }
=20
@@ -101,8 +101,9 @@
 	printk(KERN_INFO "PCI: Lithium bridge A bus: %u, "
 		"bridge B (PIIX4) bus: %u\n", pci_bus1, pci_bus0);
=20
-	pci_scan_bus(pci_bus0, &pci_direct_conf1, NULL);
-	pci_scan_bus(pci_bus1, &pci_direct_conf1, NULL);
+	raw_pci_ops =3D &pci_direct_conf1;
+	pci_scan_bus(pci_bus0, &pci_root_ops, NULL);
+	pci_scan_bus(pci_bus1, &pci_root_ops, NULL);
 	pci_fixup_irqs(visws_swizzle, visws_map_irq);
 	pcibios_resource_survey();
 	return 0;

--sHrvAb52M6C8blB9--

--rqzD5py0kzyFAOWN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/E+piby9O0+A2ZecRApZIAJ9yd/GicD3y7xo6RLN9Ry+dv3w3EQCgp++4
YTGx5gilyXgMHY1FkyhfZwQ=
=ztBE
-----END PGP SIGNATURE-----

--rqzD5py0kzyFAOWN--
