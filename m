Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268901AbRHBLxx>; Thu, 2 Aug 2001 07:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268900AbRHBLxf>; Thu, 2 Aug 2001 07:53:35 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:9221 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S268899AbRHBLxb>;
	Thu, 2 Aug 2001 07:53:31 -0400
Date: Thu, 2 Aug 2001 15:53:31 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] move SIIG parallel/serial combo cards to parport-serial.c
Message-ID: <20010802155331.A6072@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 10:31am  up 5 days, 17:36,  1 user,  load average: 0.00, 0.03, 0.00
X-Uname: Linux orbita1.ru 2.2.20pre2-acl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

attached patch moves SIIG serial/parallel combo card support from
serail and parport_pc drivers to parport_serial.

This patch is untested, but at least it doesn't broke my one port SIIG seri=
al card :)

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-SIIG-combo

diff -urN -X /usr/dontdiff /linux.vanilla/drivers/char/serial.c /linux/drivers/char/serial.c
--- /linux.vanilla/drivers/char/serial.c	Sun Jul 29 18:30:27 2001
+++ /linux/drivers/char/serial.c	Tue Jul 31 21:52:19 2001
@@ -4667,15 +4667,6 @@
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
@@ -4685,15 +4676,6 @@
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
@@ -4712,24 +4694,6 @@
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
@@ -4737,15 +4701,6 @@
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
diff -urN -X /usr/dontdiff /linux.vanilla/drivers/parport/parport_pc.c /linux/drivers/parport/parport_pc.c
--- /linux.vanilla/drivers/parport/parport_pc.c	Sun Jul 29 18:30:31 2001
+++ /linux/drivers/parport/parport_pc.c	Tue Jul 31 21:23:52 2001
@@ -2500,25 +2500,10 @@
 
 
 enum parport_pc_pci_cards {
-	siig_1s1p_10x_550 = last_sio,
-	siig_1s1p_10x_650,
-	siig_1s1p_10x_850,
-	siig_1p_10x,
+	siig_1p_10x = last_sio,
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
@@ -2564,25 +2549,10 @@
                            BAR is 6) */
 	} addr[4];
 } cards[] __devinitdata = {
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
@@ -2623,44 +2593,14 @@
 	{ 0x1106, 0x0686, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sio_via_686a },
 
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
diff -urN -X /usr/dontdiff /linux.vanilla/drivers/parport/parport_serial.c /linux/drivers/parport/parport_serial.c
--- /linux.vanilla/drivers/parport/parport_serial.c	Tue Jul 24 23:49:38 2001
+++ /linux/drivers/parport/parport_serial.c	Tue Jul 31 23:03:43 2001
@@ -43,6 +43,11 @@
 	avlab_2s1p,
 	avlab_2s1p_650,
 	avlab_2s1p_850,
+	siig_1s1p_10x,
+	siig_2s1p_10x,
+	siig_2p1s_20x,
+	siig_1s1p_20x,
+	siig_2s1p_20x,
 };
 
 
@@ -69,6 +74,11 @@
 	/* avlab_2s1p     */		{ 1, { { 2, 3}, } },
 	/* avlab_2s1p_650 */		{ 1, { { 2, 3}, } },
 	/* avlab_2s1p_850 */		{ 1, { { 2, 3}, } },
+	/* siig_1s1p_10x */		{ 1, { { 3, 4 }, } },
+	/* siig_2s1p_10x */		{ 1, { { 4, 5 }, } },
+	/* siig_2p1s_20x */		{ 2, { { 1, 2 }, { 3, 4 }, } },
+	/* siig_1s1p_20x */		{ 1, { { 1, 2 }, } },
+	/* siig_2s1p_20x */		{ 1, { { 2, 3 }, } },
 };
 
 static struct pci_device_id parport_serial_pci_tbl[] __devinitdata = {
@@ -91,6 +101,37 @@
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
@@ -106,6 +147,58 @@
 	int first_uart_offset;
 };
 
+#define PCI_DEVICE_ID_SIIG_2S_10x (PCI_DEVICE_ID_SIIG_2S_10x_550 & 0xfff8)
+
+static int __devinit
+pci_siig10x_fn(struct pci_dev *dev, struct pci_board *board, int enable)
+{
+       u16 data, *p;
+
+       if (!enable) return 0;
+
+       p = ioremap(pci_resource_start(dev, 0), 0x80);
+
+       switch (dev->device & 0xfff8) {
+               case PCI_DEVICE_ID_SIIG_1S_10x:         /* 1S */
+                       data = 0xffdf;
+                       break;
+               case PCI_DEVICE_ID_SIIG_2S_10x:         /* 2S, 2S1P */
+                       data = 0xf7ff;
+                       break;
+               default:                                /* 1S1P, 4S */
+                       data = 0xfffb;
+                       break;
+       }
+
+       writew(readw((unsigned long) p + 0x28) & data, (unsigned long) p + 0x28);
+       iounmap(p);
+       return 0;
+}
+
+#define PCI_DEVICE_ID_SIIG_2S_20x (PCI_DEVICE_ID_SIIG_2S_20x_550 & 0xfffc)
+#define PCI_DEVICE_ID_SIIG_2S1P_20x (PCI_DEVICE_ID_SIIG_2S1P_20x_550 & 0xfffc)
+
+static int __devinit
+pci_siig20x_fn(struct pci_dev *dev, struct pci_board_no_ids *board, int enable)
+{
+       u8 data;
+
+       if (!enable) return 0;
+
+       /* Change clock frequency for the first UART. */
+       pci_read_config_byte(dev, 0x6f, &data);
+       pci_write_config_byte(dev, 0x6f, data & 0xef);
+
+       /* If this card has 2 UART, we have to do the same with second UART. */
+       if (((dev->device & 0xfffc) == PCI_DEVICE_ID_SIIG_2S_20x) ||
+           ((dev->device & 0xfffc) == PCI_DEVICE_ID_SIIG_2S1P_20x)) {
+               pci_read_config_byte(dev, 0x73, &data);
+               pci_write_config_byte(dev, 0x73, data & 0xef);
+       }
+       return 0;
+}
+
+
 static struct pci_board_no_ids pci_boards[] __devinitdata = {
 	/*
 	 * PCI Flags, Number of Ports, Base (Maximum) Baud Rate,
@@ -130,6 +223,11 @@
 /* avlab_2s1p (n/t) */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
 /* avlab_2s1p_650 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
 /* avlab_2s1p_850 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
+/* siig_1s1p_10x */	{ SPCI_FL_BASE2, 1, 460800, 0, 0, pci_siig10x_fn },
+/* siig_2s1p_10x */	{ SPCI_FL_BASE2, 1, 921600, 0, 0, pci_siig10x_fn },
+/* siig_2p1s_20x */	{ SPCI_FL_BASE0, 1, 921600, 0, 0, pci_siig20x_fn },
+/* siig_1s1p_20x */	{ SPCI_FL_BASE0, 1, 921600, 0, 0, pci_siig20x_fn },
+/* siig_2s1p_20x */	{ SPCI_FL_BASE0, 1, 921600, 0, 0, pci_siig20x_fn },
 };
 
 struct parport_serial_private {

--J/dobhs11T7y2rNN--

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7aT86Bm4rlNOo3YgRApkRAJ93Og13LecWeYCx7Ck0mwmDQ/kRrACdEz4K
/Bfx5AJ6uRRLYlb4ao8fvTg=
=ijTv
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
