Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278365AbRJSLsV>; Fri, 19 Oct 2001 07:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278366AbRJSLsM>; Fri, 19 Oct 2001 07:48:12 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:55560 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S278365AbRJSLrx>;
	Fri, 19 Oct 2001 07:47:53 -0400
Date: Fri, 19 Oct 2001 15:48:31 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] MODULE_DEVICE_TABLE for stallion serial card drivers
Message-ID: <20011019154831.A2516@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 3:41pm  up 7 days,  3:50,  4 users,  load average: 0.08, 0.23, 0.22
X-Uname: Linux orbita1.ru 2.2.20pre2 
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Untested, but compiles ...

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-istallion
Content-Transfer-Encoding: quoted-printable

diff -ur -X /usr/dontdiff /linux.vanilla/drivers/char/istallion.c /linux/dr=
ivers/char/istallion.c
--- /linux.vanilla/drivers/char/istallion.c	Wed Oct 17 11:25:39 2001
+++ /linux/drivers/char/istallion.c	Thu Oct 18 12:28:21 2001
@@ -431,6 +431,12 @@
 #endif
 #endif
=20
+static struct pci_device_id istallion_pci_tbl[] =3D {
+	{ PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_ECRA, PCI_ANY_ID, PCI_ANY_ID, 0, =
0, 0 },
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(pci, istallion_pci_tbl);
+
 /*************************************************************************=
****/
=20
 /*

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-stallion
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/dontdiff linux.vanilla/drivers/char/stallion.c linux/driv=
ers/char/stallion.c
--- linux.vanilla/drivers/char/stallion.c	Wed Oct 17 11:25:42 2001
+++ linux/drivers/char/stallion.c	Fri Oct 19 12:13:18 2001
@@ -442,14 +442,20 @@
 	int			brdtype;
 } stlpcibrd_t;
=20
-static stlpcibrd_t	stl_pcibrds[] =3D {
-	{ PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_ECHPCI864, BRD_ECH64PCI },
-	{ PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_EIOPCI, BRD_EASYIOPCI },
-	{ PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_ECHPCI832, BRD_ECHPCI },
-	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87410, BRD_ECHPCI },
+static struct pci_device_id stl_pcibrds[] =3D {
+	{ PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_ECHPCI864,=20
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, BRD_ECH64PCI },
+	{ PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_EIOPCI,=20
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, BRD_EASYIOPCI },
+	{ PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_ECHPCI832,=20
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, BRD_ECHPCI },
+	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87410,=20
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, BRD_ECHPCI },
+	{ 0 }
 };
+MODULE_DEVICE_TABLE(pci, stl_pcibrds);
=20
-static int	stl_nrpcibrds =3D sizeof(stl_pcibrds) / sizeof(stlpcibrd_t);
+static int stl_nrpcibrds =3D (sizeof(stl_pcibrds) / sizeof(stlpcibrd_t)) -=
 1;
=20
 #endif
=20
@@ -2850,8 +2856,8 @@
 		return(0);
=20
 	for (i =3D 0; (i < stl_nrpcibrds); i++)
-		while ((dev =3D pci_find_device(stl_pcibrds[i].vendid,
-		    stl_pcibrds[i].devid, dev))) {
+		while ((dev =3D pci_find_device(stl_pcibrds[i].vendor,
+		    stl_pcibrds[i].device, dev))) {
=20
 /*
  *			Found a device on the PCI bus that has our vendor and
@@ -2860,7 +2866,7 @@
 			if ((dev->class >> 8) =3D=3D PCI_CLASS_STORAGE_IDE)
 				continue;
=20
-			rc =3D stl_initpcibrd(stl_pcibrds[i].brdtype, dev);
+			rc =3D stl_initpcibrd(stl_pcibrds[i].driver_data, dev);
 			if (rc)
 				return(rc);
 		}

--bg08WKrSYDhXBjb5--

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE70BMPBm4rlNOo3YgRApmSAJ97DncV4wpX5sma5cQg3aUiraT5UwCffqsi
Bd+7AB1/BoIJhW8JFSql+jY=
=VQqN
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
