Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267463AbUG3Kjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267463AbUG3Kjq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 06:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUG3Kjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 06:39:46 -0400
Received: from rdrz.de ([217.160.107.209]:62406 "HELO rdrz.de")
	by vger.kernel.org with SMTP id S267463AbUG3Kjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 06:39:43 -0400
Date: Fri, 30 Jul 2004 12:39:41 +0200
From: Raphael Zimmerer <killekulla@rdrz.de>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Subject: [PATCH] [pci]: fix PCI access mode dependences in arch/i386/Kconfig
Message-ID: <20040730103941.GB28101@rdrz.de>
Reply-To: killekulla@rdrz.de
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

PCI acces mode Configuration

Problem:
While all ACPI stuff is deselected, and PCI access mode is set to
"Any", CONFIG_ACPI_BOOT is going to be set  because of CONFIG_PCI_MMCONFIG.

Solution:
If CONFIG_ACPI_BOOT is not allready set by other stuff, setting PCI access
mode to "Any" shouldn't set CONFIG_PCI_MMCONFIG. Anyhow, setting PCI access
mode to "MMConfig" should select CONFIG_ACPI_BOOT.

Regards,
Raphael

Signed-off-by: Raphael Zimmerer <killekulla@rdrz.de>                       =
                                         =20
 Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.8-rc2/arch/i386/Kconfig	2004-07-27 13:13:16.000000000 +0200
+++ linux-2.6.8-rc2-[uart]/arch/i386/Kconfig	2004-07-29 12:47:07.000000000 =
+0200
@@ -1105,7 +1105,7 @@
=20
 config PCI_MMCONFIG
 	bool
-	depends on PCI && (PCI_GOMMCONFIG || PCI_GOANY)
+	depends on PCI && (PCI_GOMMCONFIG || (PCI_GOANY && ACPI_BOOT))
 	select ACPI_BOOT
 	default y

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBCiVtUcUgUprPgz4RAk88AJ9ipn5cFL8ybUZZCWiv5ifiGBgfhwCffRYb
+LtnzQJoLmRkVFgTVvEaPmM=
=M9Sl
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
