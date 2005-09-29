Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbVI2AlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbVI2AlF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 20:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbVI2AlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 20:41:05 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:35272 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751154AbVI2AlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 20:41:03 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: [PATCHv3 02/04] pci_ids: macros: replace partial with whole symbols
Date: Thu, 29 Sep 2005 10:40:52 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <rudmj15onsnvo1b29ctunhq54qu5a8vo4f@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Grant Coady <gcoady@gmail.com>

pci_ids cleanup: replace symbols built by macros with whole symbols to 
aid grep searches.

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 drivers/video/cirrusfb.c |   24 ++++++++++++------------
 sound/oss/ymfpci.c       |   17 +++++++++--------
 sound/pci/bt87x.c        |   11 +++++++----
 3 files changed, 28 insertions(+), 24 deletions(-)

diff -X dontdiff -Nrup linux-2.6.14-rc2-git7b/drivers/video/cirrusfb.c linux-2.6.14-rc2-git7c/drivers/video/cirrusfb.c
--- linux-2.6.14-rc2-git7b/drivers/video/cirrusfb.c	2005-09-29 08:49:20.000000000 +1000
+++ linux-2.6.14-rc2-git7c/drivers/video/cirrusfb.c	2005-09-29 08:48:41.000000000 +1000
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
diff -X dontdiff -Nrup linux-2.6.14-rc2-git7b/sound/oss/ymfpci.c linux-2.6.14-rc2-git7c/sound/oss/ymfpci.c
--- linux-2.6.14-rc2-git7b/sound/oss/ymfpci.c	2005-09-29 08:49:20.000000000 +1000
+++ linux-2.6.14-rc2-git7c/sound/oss/ymfpci.c	2005-09-29 08:48:41.000000000 +1000
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
diff -X dontdiff -Nrup linux-2.6.14-rc2-git7b/sound/pci/bt87x.c linux-2.6.14-rc2-git7c/sound/pci/bt87x.c
--- linux-2.6.14-rc2-git7b/sound/pci/bt87x.c	2005-09-29 08:49:20.000000000 +1000
+++ linux-2.6.14-rc2-git7c/sound/pci/bt87x.c	2005-09-29 08:48:41.000000000 +1000
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
