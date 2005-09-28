Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965226AbVI1BO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965226AbVI1BO6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 21:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbVI1BO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 21:14:57 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:44934 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S965226AbVI1BO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 21:14:57 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [RFC PATCH] pci_ids: convert macro built symbols to searchable text
Date: Wed, 28 Sep 2005 11:14:45 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <7mqjj1ljhjgv40imikjoilvq956fk3q6p0@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Appended is a patch to remove macro assembled PCI_DEVICE_ID_* 
symbols which will make further processing far easier.  The patch 
follows on from yesterday's patch removing non-referenced symbols.

Dominik,
Apologies for leaving out the RFC on previous patch, this cleanup 
series will come in behind your's, and others' work.  

Thanks,
Grant.

pci_ids cleanup: convert macro-created symbols to plain symbols

This patch converts PCI_DEVICE_ID_* symbols built by driver macros 
to plain symbols for grep and friends and restores some recently 
removed symbols to pci_ids.h that were referenced by a macro.

Testing: 'make allyesconfig' with CONFIG_SERIAL_JSM=n to get 
compile completion.

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 drivers/video/cirrusfb.c |   24 ++++++++++++------------
 include/linux/pci_ids.h  |   10 ++++++++++
 sound/oss/ymfpci.c       |   17 +++++++++--------
 sound/pci/bt87x.c        |   11 +++++++----
 4 files changed, 38 insertions(+), 24 deletions(-)

diff -X dontdiff -Nrup linux-2.6.14-rc2-mm1a/drivers/video/cirrusfb.c linux-2.6.14-rc2-mm1b/drivers/video/cirrusfb.c
--- linux-2.6.14-rc2-mm1a/drivers/video/cirrusfb.c	2005-08-29 09:41:01.000000000 +1000
+++ linux-2.6.14-rc2-mm1b/drivers/video/cirrusfb.c	2005-09-28 10:00:21.000000000 +1000
@@ -275,20 +275,20 @@ static const struct cirrusfb_board_info_
 
 #ifdef CONFIG_PCI
 #define CHIP(id, btype) \
-	{ PCI_VENDOR_ID_CIRRUS, PCI_DEVICE_ID_##id, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (btype) }
+	{ PCI_VENDOR_ID_CIRRUS, id, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (btype) }
 
 static struct pci_device_id cirrusfb_pci_table[] = {
-	CHIP( CIRRUS_5436,	BT_ALPINE ),
-	CHIP( CIRRUS_5434_8,	BT_ALPINE ),
-	CHIP( CIRRUS_5434_4,	BT_ALPINE ),
-	CHIP( CIRRUS_5430,	BT_ALPINE ), /* GD-5440 has identical id */
-	CHIP( CIRRUS_7543,	BT_ALPINE ),
-	CHIP( CIRRUS_7548,	BT_ALPINE ),
-	CHIP( CIRRUS_5480,	BT_GD5480 ), /* MacPicasso probably */
-	CHIP( CIRRUS_5446,	BT_PICASSO4 ), /* Picasso 4 is a GD5446 */
-	CHIP( CIRRUS_5462,	BT_LAGUNA ), /* CL Laguna */
-	CHIP( CIRRUS_5464,	BT_LAGUNA ), /* CL Laguna 3D */
-	CHIP( CIRRUS_5465,	BT_LAGUNA ), /* CL Laguna 3DA*/
+	CHIP( PCI_DEVICE_ID_CIRRUS_5436, BT_ALPINE ),
+	CHIP( PCI_DEVICE_ID_CIRRUS_5434_8, BT_ALPINE ),
+	CHIP( PCI_DEVICE_ID_CIRRUS_5434_4, BT_ALPINE ),
+	CHIP( PCI_DEVICE_ID_CIRRUS_5430, BT_ALPINE ), /* GD-5440 is same id */
+	CHIP( PCI_DEVICE_ID_CIRRUS_7543, BT_ALPINE ),
+	CHIP( PCI_DEVICE_ID_CIRRUS_7548, BT_ALPINE ),
+	CHIP( PCI_DEVICE_ID_CIRRUS_5480, BT_GD5480 ), /* MacPicasso likely */
+	CHIP( PCI_DEVICE_ID_CIRRUS_5446, BT_PICASSO4 ), /* Picasso 4 is 5446 */
+	CHIP( PCI_DEVICE_ID_CIRRUS_5462, BT_LAGUNA ), /* CL Laguna */
+	CHIP( PCI_DEVICE_ID_CIRRUS_5464, BT_LAGUNA ), /* CL Laguna 3D */
+	CHIP( PCI_DEVICE_ID_CIRRUS_5465, BT_LAGUNA ), /* CL Laguna 3DA*/
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, cirrusfb_pci_table);
diff -X dontdiff -Nrup linux-2.6.14-rc2-mm1a/include/linux/pci_ids.h linux-2.6.14-rc2-mm1b/include/linux/pci_ids.h
--- linux-2.6.14-rc2-mm1a/include/linux/pci_ids.h	2005-09-28 10:31:06.000000000 +1000
+++ linux-2.6.14-rc2-mm1b/include/linux/pci_ids.h	2005-09-28 09:56:36.000000000 +1000
@@ -338,9 +338,19 @@
 #define PCI_DEVICE_ID_COMPAQ_42XX	0x0046
 
 #define PCI_VENDOR_ID_CIRRUS		0x1013
+#define PCI_DEVICE_ID_CIRRUS_7548	0x0038
+#define PCI_DEVICE_ID_CIRRUS_5430	0x00a0
+#define PCI_DEVICE_ID_CIRRUS_5434_4	0x00a4
+#define PCI_DEVICE_ID_CIRRUS_5434_8	0x00a8
+#define PCI_DEVICE_ID_CIRRUS_5436	0x00ac
 #define PCI_DEVICE_ID_CIRRUS_5446	0x00b8
+#define PCI_DEVICE_ID_CIRRUS_5480	0x00bc
+#define PCI_DEVICE_ID_CIRRUS_5462	0x00d0
+#define PCI_DEVICE_ID_CIRRUS_5464	0x00d4
+#define PCI_DEVICE_ID_CIRRUS_5465	0x00d6
 #define PCI_DEVICE_ID_CIRRUS_6729	0x1100
 #define PCI_DEVICE_ID_CIRRUS_6832	0x1110
+#define PCI_DEVICE_ID_CIRRUS_7543	0x1202
 #define PCI_DEVICE_ID_CIRRUS_4610	0x6001
 #define PCI_DEVICE_ID_CIRRUS_4612	0x6003
 #define PCI_DEVICE_ID_CIRRUS_4615	0x6004
diff -X dontdiff -Nrup linux-2.6.14-rc2-mm1a/sound/oss/ymfpci.c linux-2.6.14-rc2-mm1b/sound/oss/ymfpci.c
--- linux-2.6.14-rc2-mm1a/sound/oss/ymfpci.c	2005-08-29 09:41:01.000000000 +1000
+++ linux-2.6.14-rc2-mm1b/sound/oss/ymfpci.c	2005-09-28 10:07:56.000000000 +1000
@@ -107,14 +107,15 @@ static LIST_HEAD(ymf_devs);
  */
 
 static struct pci_device_id ymf_id_tbl[] = {
-#define DEV(v, d, data) \
-  { PCI_VENDOR_ID_##v, PCI_DEVICE_ID_##v##_##d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (unsigned long)data }
-	DEV (YAMAHA, 724,  "YMF724"),
-	DEV (YAMAHA, 724F, "YMF724F"),
-	DEV (YAMAHA, 740,  "YMF740"),
-	DEV (YAMAHA, 740C, "YMF740C"),
-	DEV (YAMAHA, 744,  "YMF744"),
-	DEV (YAMAHA, 754,  "YMF754"),
+#define DEV(dev, data) \
+	{ PCI_VENDOR_ID_YAMAHA, dev, PCI_ANY_ID, PCI_ANY_ID, 0, 0, \
+		(unsigned long)data }
+	DEV (PCI_DEVICE_ID_YAMAHA_724,  "YMF724"),
+	DEV (PCI_DEVICE_ID_YAMAHA_724F, "YMF724F"),
+	DEV (PCI_DEVICE_ID_YAMAHA_740,  "YMF740"),
+	DEV (PCI_DEVICE_ID_YAMAHA_740C, "YMF740C"),
+	DEV (PCI_DEVICE_ID_YAMAHA_744,  "YMF744"),
+	DEV (PCI_DEVICE_ID_YAMAHA_754,  "YMF754"),
 #undef DEV
 	{ }
 };
diff -X dontdiff -Nrup linux-2.6.14-rc2-mm1a/sound/pci/bt87x.c linux-2.6.14-rc2-mm1b/sound/pci/bt87x.c
--- linux-2.6.14-rc2-mm1a/sound/pci/bt87x.c	2005-09-28 05:33:53.000000000 +1000
+++ linux-2.6.14-rc2-mm1b/sound/pci/bt87x.c	2005-09-28 10:19:51.000000000 +1000
@@ -761,15 +761,18 @@ static int __devinit snd_bt87x_create(sn
 
 #define BT_DEVICE(chip, subvend, subdev, rate) \
 	{ .vendor = PCI_VENDOR_ID_BROOKTREE, \
-	  .device = PCI_DEVICE_ID_BROOKTREE_##chip, \
+	  .device = chip, \
 	  .subvendor = subvend, .subdevice = subdev, \
 	  .driver_data = rate }
 
 /* driver_data is the default digital_rate value for that device */
 static struct pci_device_id snd_bt87x_ids[] = {
-	BT_DEVICE(878, 0x0070, 0x13eb, 32000), /* Hauppauge WinTV series */
-	BT_DEVICE(879, 0x0070, 0x13eb, 32000), /* Hauppauge WinTV series */
-	BT_DEVICE(878, 0x0070, 0xff01, 44100), /* Viewcast Osprey 200 */
+	/* Hauppauge WinTV series */
+	BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_878, 0x0070, 0x13eb, 32000),
+	/* Hauppauge WinTV series */
+	BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_879, 0x0070, 0x13eb, 32000),
+	/* Viewcast Osprey 200 */
+	BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_878, 0x0070, 0xff01, 44100),
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, snd_bt87x_ids);
