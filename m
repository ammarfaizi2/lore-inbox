Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285370AbRLNNyn>; Fri, 14 Dec 2001 08:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285368AbRLNNyY>; Fri, 14 Dec 2001 08:54:24 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:60176 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S285373AbRLNNyC>;
	Fri, 14 Dec 2001 08:54:02 -0500
Date: Sat, 15 Dec 2001 16:57:39 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
        Tim Waugh <twaugh@redhat.com>
Subject: [PATCH] move SIIG combo cards support to parport_serial.c
Message-ID: <20011215165739.A201@pazke.ipt>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
User-Agent: Mutt/1.0.1i
X-Uname: Linux pazke 2.5.1-pre11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi all,

These patches move SIIG serial & parallel combo cards support from
serial and parport drivers to parport_serial.c (where IMHO it must be).

Untested, but compiles and should work :))

These patches were sended to LKML some months ago, but seems like they=20
was lost somewhere and I can't remember any answer.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-SIIGcombo-parport
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/dontdiff /linux.vanilla/drivers/parport/parport_pc.c /lin=
ux/drivers/parport/parport_pc.c
--- /linux.vanilla/drivers/parport/parport_pc.c	Fri Nov 30 20:16:31 2001
+++ /linux/drivers/parport/parport_pc.c	Fri Nov 30 20:19:47 2001
@@ -2628,25 +2628,10 @@
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
@@ -2698,25 +2683,10 @@
                            BAR is 6) */
 	} addr[4];
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
@@ -2767,44 +2737,14 @@
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
diff -urN -X /usr/dontdiff /linux.vanilla/drivers/parport/parport_serial.c =
/linux/drivers/parport/parport_serial.c
--- /linux.vanilla/drivers/parport/parport_serial.c	Fri Nov 30 20:16:31 2001
+++ /linux/drivers/parport/parport_serial.c	Fri Nov 30 21:09:00 2001
@@ -41,6 +41,11 @@
 	avlab_2s1p,
 	avlab_2s1p_650,
 	avlab_2s1p_850,
+	siig_1s1p_10x,
+	siig_2s1p_10x,
+	siig_2p1s_20x,
+	siig_1s1p_20x,
+	siig_2s1p_20x,
 };
=20
=20
@@ -65,6 +70,11 @@
 	/* avlab_2s1p     */		{ 1, { { 2, 3}, } },
 	/* avlab_2s1p_650 */		{ 1, { { 2, 3}, } },
 	/* avlab_2s1p_850 */		{ 1, { { 2, 3}, } },
+	/* siig_1s1p_10x */		{ 1, { { 3, 4 }, } },
+	/* siig_2s1p_10x */		{ 1, { { 4, 5 }, } },
+	/* siig_2p1s_20x */		{ 2, { { 1, 2 }, { 3, 4 }, } },
+	/* siig_1s1p_20x */		{ 1, { { 1, 2 }, } },
+	/* siig_2s1p_20x */		{ 1, { { 2, 3 }, } },
 };
=20
 static struct pci_device_id parport_serial_pci_tbl[] __devinitdata =3D {
@@ -83,6 +93,37 @@
 	{ 0x14db, 0x2160, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_2s1p},
 	{ 0x14db, 0x2161, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_2s1p_650},
 	{ 0x14db, 0x2162, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_2s1p_850},
+	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_10x_550,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_1s1p_10x },
+	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_10x_650,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_1s1p_10x },
+	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_10x_850,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_1s1p_10x },
+	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_10x_550,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_10x },
+	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_10x_650,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_10x },
+	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_10x_850,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_10x },
+	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2P1S_20x_550,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2p1s_20x },
+	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2P1S_20x_650,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2p1s_20x },
+	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2P1S_20x_850,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2p1s_20x },
+	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_20x_550,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_20x },
+	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_20x_650,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_1s1p_20x },
+	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_20x_850,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_1s1p_20x },
+	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_20x_550,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_20x },
+	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_20x_650,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_20x },
+	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_20x_850,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_20x },
+
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci,parport_serial_pci_tbl);
@@ -98,6 +139,16 @@
 	int first_uart_offset;
 };
=20
+static int __devinit siig10x_init_fn(struct pci_dev *dev, struct pci_board=
_no_ids *board, int enable)
+{
+	return pci_siig10x_fn(dev, NULL, enable);
+}
+
+static int __devinit siig20x_init_fn(struct pci_dev *dev, struct pci_board=
_no_ids *board, int enable)
+{
+	return pci_siig20x_fn(dev, NULL, enable);
+}
+
 static struct pci_board_no_ids pci_boards[] __devinitdata =3D {
 	/*
 	 * PCI Flags, Number of Ports, Base (Maximum) Baud Rate,
@@ -120,6 +171,11 @@
 /* avlab_2s1p (n/t) */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
 /* avlab_2s1p_650 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
 /* avlab_2s1p_850 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
+/* siig_1s1p_10x */	{ SPCI_FL_BASE2, 1, 460800, 0, 0, siig10x_init_fn },
+/* siig_2s1p_10x */	{ SPCI_FL_BASE2, 1, 921600, 0, 0, siig10x_init_fn },
+/* siig_2p1s_20x */	{ SPCI_FL_BASE0, 1, 921600, 0, 0, siig20x_init_fn },
+/* siig_1s1p_20x */	{ SPCI_FL_BASE0, 1, 921600, 0, 0, siig20x_init_fn },
+/* siig_2s1p_20x */	{ SPCI_FL_BASE0, 1, 921600, 0, 0, siig20x_init_fn },
 };
=20
 struct parport_serial_private {

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-SIIGcombo-serial
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/dontdiff /linux.vanilla/drivers/char/serial.c /linux/driv=
ers/char/serial.c
--- /linux.vanilla/drivers/char/serial.c	Fri Nov 30 20:15:25 2001
+++ /linux/drivers/char/serial.c	Fri Nov 30 20:52:13 2001
@@ -4085,12 +4085,14 @@
  * interface chip and different configuration methods:
  *     - 10x cards have control registers in IO and/or memory space;
  *     - 20x cards have control registers in standard PCI configuration sp=
ace.
+ *
+ * SIIG initialization functions exported for use by parport_serial.c modu=
le.
  */
=20
 #define PCI_DEVICE_ID_SIIG_1S_10x (PCI_DEVICE_ID_SIIG_1S_10x_550 & 0xfffc)
 #define PCI_DEVICE_ID_SIIG_2S_10x (PCI_DEVICE_ID_SIIG_2S_10x_550 & 0xfff8)
=20
-static int __devinit
+int __devinit
 pci_siig10x_fn(struct pci_dev *dev, struct pci_board *board, int enable)
 {
        u16 data, *p;
@@ -4115,11 +4117,12 @@
        iounmap(p);
        return 0;
 }
+EXPORT_SYMBOL(pci_siig10x_fn);
=20
 #define PCI_DEVICE_ID_SIIG_2S_20x (PCI_DEVICE_ID_SIIG_2S_20x_550 & 0xfffc)
 #define PCI_DEVICE_ID_SIIG_2S1P_20x (PCI_DEVICE_ID_SIIG_2S1P_20x_550 & 0xf=
ffc)
=20
-static int __devinit
+int __devinit
 pci_siig20x_fn(struct pci_dev *dev, struct pci_board *board, int enable)
 {
        u8 data;
@@ -4138,6 +4141,7 @@
        }
        return 0;
 }
+EXPORT_SYMBOL(pci_siig20x_fn);
=20
 /* Added for EKF Intel i960 serial boards */
 static int __devinit
@@ -4708,15 +4712,6 @@
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_10x_850,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_siig10x_0 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_10x_550,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig10x_1 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_10x_650,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig10x_1 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_10x_850,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig10x_1 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_10x_550,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_siig10x_2 },
@@ -4726,15 +4721,6 @@
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_10x_850,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_siig10x_2 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_10x_550,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig10x_2 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_10x_650,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig10x_2 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_10x_850,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig10x_2 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_10x_550,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_siig10x_4 },
@@ -4753,24 +4739,6 @@
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_20x_850,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_siig20x_0 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_20x_550,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_0 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_20x_650,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_0 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_20x_850,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_0 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2P1S_20x_550,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_0 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2P1S_20x_650,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_0 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2P1S_20x_850,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_0 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_20x_550,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_siig20x_2 },
@@ -4778,15 +4746,6 @@
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_siig20x_2 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_20x_850,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_2 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_20x_550,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_2 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_20x_650,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_siig20x_2 },
-	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_20x_850,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_siig20x_2 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_20x_550,
diff -urN -X /usr/dontdiff /linux.vanilla/include/linux/serialP.h /linux/in=
clude/linux/serialP.h
--- /linux.vanilla/include/linux/serialP.h	Fri Nov 30 20:13:59 2001
+++ /linux/include/linux/serialP.h	Fri Nov 30 20:50:37 2001
@@ -157,6 +157,9 @@
 	struct pci_dev		*dev;
 };
=20
+extern int pci_siig10x_fn(struct pci_dev *dev, struct pci_board *board, in=
t enable);
+extern int pci_siig20x_fn(struct pci_dev *dev, struct pci_board *board, in=
t enable);
+
 #ifndef PCI_ANY_ID
 #define PCI_ANY_ID (~0)
 #endif

--pf9I7BMVVzbSWLtt--

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8G1bTBm4rlNOo3YgRAiqvAJ4jOfuc2aMKzbQWYGrQdDE8A+WjGACeNjsD
WYLPg/KqeDoWP38aTiGoxEg=
=TDuI
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
