Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132729AbRDIMN1>; Mon, 9 Apr 2001 08:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132731AbRDIMNR>; Mon, 9 Apr 2001 08:13:17 -0400
Received: from orbita.don.sitek.net ([213.24.25.98]:60171 "EHLO
	orbita.don.sitek.net") by vger.kernel.org with ESMTP
	id <S132729AbRDIMNG>; Mon, 9 Apr 2001 08:13:06 -0400
Date: Mon, 9 Apr 2001 16:11:52 +0400
From: Andrey Panin <pazke@orbita.don.sitek.net>
To: linux-kernel@vger.kernel.org
Cc: kernel-janitor-discuss@lists.sourceforge.net
Subject: [PATCH] net drivers: missing __init's
Message-ID: <20010409161152.B3723@debian>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--96YOpH+ONegL0A3E
Content-Type: multipart/mixed; boundary="Fba/0zbH8Xs+Fj9o"


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi all,

attached patches add missing __init and (__devinit) to some network drivers:
	at1700.c, eepro.c, epic100.c, hamachi.c, sis900.c,=20
	tokenring/abyss.c, tokenring/tmsisa.c, tokenring/tmspci.c.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-at1700
Content-Transfer-Encoding: quoted-printable

diff -ur -x *.o -x *.flags /linux.vanilla/drivers/net/at1700.c /linux/drive=
rs/net/at1700.c
--- /linux.vanilla/drivers/net/at1700.c	Mon Apr  2 15:45:18 2001
+++ /linux/drivers/net/at1700.c	Sat Apr  7 21:22:27 2001
@@ -470,7 +470,7 @@
 #define EE_READ_CMD		(6 << 6)
 #define EE_ERASE_CMD	(7 << 6)
=20
-static int read_eeprom(int ioaddr, int location)
+static int __init read_eeprom(int ioaddr, int location)
 {
 	int i;
 	unsigned short retval =3D 0;

--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-eepro
Content-Transfer-Encoding: quoted-printable

diff -ur -x *.o -x *.flags /linux.vanilla/drivers/net/eepro.c /linux/driver=
s/net/eepro.c
--- /linux.vanilla/drivers/net/eepro.c	Mon Apr  2 15:45:19 2001
+++ /linux/drivers/net/eepro.c	Sun Apr  8 23:51:12 2001
@@ -588,7 +588,7 @@
 	return -ENODEV;
 }
=20
-static void printEEPROMInfo(short ioaddr, struct net_device *dev)
+static void __init printEEPROMInfo(short ioaddr, struct net_device *dev)
 {
 	unsigned short Word;
 	int i,j;
@@ -647,7 +647,7 @@
    probes on the ISA bus.  A good device probe avoids doing writes, and
    verifies that the correct device exists and functions.  */
=20
-static int eepro_probe1(struct net_device *dev, short ioaddr)
+static int __init eepro_probe1(struct net_device *dev, short ioaddr)
 {
 	unsigned short station_addr[6], id, counter;
 	int i,j, irqMask;

--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-epic100
Content-Transfer-Encoding: quoted-printable

diff -ur -x *.o -x *.flags /linux.vanilla/drivers/net/epic100.c /linux/driv=
ers/net/epic100.c
--- /linux.vanilla/drivers/net/epic100.c	Mon Apr  2 15:45:27 2001
+++ /linux/drivers/net/epic100.c	Sun Apr  8 23:46:03 2001
@@ -545,7 +545,7 @@
 #define EE_READ256_CMD	(6 << 8)
 #define EE_ERASE_CMD	(7 << 6)
=20
-static int read_eeprom(long ioaddr, int location)
+static int __devinit read_eeprom(long ioaddr, int location)
 {
 	int i;
 	int retval =3D 0;

--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-hamachi
Content-Transfer-Encoding: quoted-printable

diff -ur -x *.o -x *.flags /linux.vanilla/drivers/net/hamachi.c /linux/driv=
ers/net/hamachi.c
--- /linux.vanilla/drivers/net/hamachi.c	Mon Apr  2 15:45:33 2001
+++ /linux/drivers/net/hamachi.c	Sun Apr  8 23:48:24 2001
@@ -545,7 +544,7 @@
 static void set_rx_mode(struct net_device *dev);
=20
=20
-static int __init hamachi_init_one (struct pci_dev *pdev,
+static int __devinit hamachi_init_one (struct pci_dev *pdev,
 				    const struct pci_device_id *ent)
 {
 	static int did_version =3D 0;			/* Already printed version info. */
@@ -728,7 +727,7 @@
 	return 0;
 }
=20
-static int read_eeprom(long ioaddr, int location)
+static int __devinit read_eeprom(long ioaddr, int location)
 {
 	int bogus_cnt =3D 1000;
=20
@@ -1858,7 +1857,7 @@
 }
=20
=20
-static void __exit hamachi_remove_one (struct pci_dev *pdev)
+static void __devexit hamachi_remove_one (struct pci_dev *pdev)
 {
 	struct net_device *dev =3D pci_get_drvdata(pdev);
=20

--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-sis900
Content-Transfer-Encoding: quoted-printable

diff -ur -x *.o -x *.flags /linux.vanilla/drivers/net/sis900.c /linux/drive=
rs/net/sis900.c
--- /linux.vanilla/drivers/net/sis900.c	Mon Apr  2 15:45:26 2001
+++ /linux/drivers/net/sis900.c	Sun Apr  8 18:15:42 2001
@@ -60,7 +60,7 @@
=20
 #include "sis900.h"
=20
-static const char *version =3D
+static const char *version __initdata =3D
 "sis900.c: v1.07.09  2/9/2001\n";
=20
 static int max_interrupt_work =3D 20;
@@ -443,7 +443,7 @@
  *	Note that location is in word (16 bits) unit
  */
=20
-static u16 read_eeprom(long ioaddr, int location)
+static u16 __devinit read_eeprom(long ioaddr, int location)
 {
 	int i;
 	u16 retval =3D 0;

--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-abyss

diff -ur -x *.o -x *.flags /linux.vanilla/drivers/net/tokenring/abyss.c /linux/drivers/net/tokenring/abyss.c
--- /linux.vanilla/drivers/net/tokenring/abyss.c	Mon Apr  2 15:45:22 2001
+++ /linux/drivers/net/tokenring/abyss.c	Sat Apr  7 21:58:20 2001
@@ -390,7 +390,7 @@
  * Read configuration data from the AT24 SEEPROM on Madge cards.
  *
  */
-static void abyss_read_eeprom(struct net_device *dev)
+static void __init abyss_read_eeprom(struct net_device *dev)
 {
 	struct net_local *tp;
 	unsigned long ioaddr;

--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-tmsisa
Content-Transfer-Encoding: quoted-printable

diff -ur -x *.o -x *.flags /linux.vanilla/drivers/net/tokenring/tmsisa.c /l=
inux/drivers/net/tokenring/tmsisa.c
--- /linux.vanilla/drivers/net/tokenring/tmsisa.c	Mon Apr  2 15:45:22 2001
+++ /linux/drivers/net/tokenring/tmsisa.c	Sun Apr  8 18:18:51 2001
@@ -19,7 +19,7 @@
  *  TODO:
  *	1. Add support for Proteon TR ISA adapters (1392, 1392+)
  */
-static const char *version =3D "tmsisa.c: v1.00 14/01/2001 by Jochen Fried=
rich\n";
+static const char version[] __initdata =3D "tmsisa.c: v1.00 14/01/2001 by =
Jochen Friedrich\n";
=20
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -297,7 +297,7 @@
  * machine hard when this is called.  Luckily, its supported in a
  * seperate driver.  --ASF
  */
-static void tms_isa_read_eeprom(struct net_device *dev)
+static void __init tms_isa_read_eeprom(struct net_device *dev)
 {
 	int i;
 =09

--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-tmspci
Content-Transfer-Encoding: quoted-printable

diff -ur -x *.o -x *.flags /linux.vanilla/drivers/net/tokenring/tmspci.c /l=
inux/drivers/net/tokenring/tmspci.c
--- /linux.vanilla/drivers/net/tokenring/tmspci.c	Mon Apr  2 15:45:22 2001
+++ /linux/drivers/net/tokenring/tmspci.c	Sat Apr  7 22:04:33 2001
@@ -90,7 +90,7 @@
 	outw(val, dev->base_addr + reg);
 }
=20
-static int __init tms_pci_attach(struct pci_dev *pdev, const struct pci_de=
vice_id *ent)
+static int __devinit tms_pci_attach(struct pci_dev *pdev, const struct pci=
_device_id *ent)
 {=09
 	static int versionprinted;
 	struct net_device *dev;
@@ -192,7 +192,7 @@
  * machine hard when this is called.  Luckily, its supported in a
  * seperate driver.  --ASF
  */
-static void tms_pci_read_eeprom(struct net_device *dev)
+static void __devinit tms_pci_read_eeprom(struct net_device *dev)
 {
 	int i;
 =09
@@ -219,7 +219,7 @@
 	return val;
 }
=20
-static void __exit tms_pci_detach (struct pci_dev *pdev)
+static void __devexit tms_pci_detach (struct pci_dev *pdev)
 {
 	struct net_device *dev =3D pci_get_drvdata(pdev);
=20

--Fba/0zbH8Xs+Fj9o--

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE60acIBm4rlNOo3YgRArwCAJ46W0ZCGb76xQ2LAzul6zwUXCgyowCfcVpK
HvGT6s9tZKYXUknRJ76C51M=
=RUKd
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
