Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266805AbUHMSzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266805AbUHMSzo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 14:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266777AbUHMSzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 14:55:44 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:65482 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S266805AbUHMSzh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 14:55:37 -0400
Message-ID: <411D0E6E.4050704@ttnet.net.tr>
Date: Fri, 13 Aug 2004 21:54:38 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] ULL-fixes
Content-Type: multipart/mixed;
	boundary="------------070005000405080007060402"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070005000405080007060402
Content-Type: text/plain;
	charset=ISO-8859-9;
	format=flowed
Content-Transfer-Encoding: quoted-printable

Various ULL modifiers. Also cures compiler warnings.
Most, if not all, are from 2.6.

=D6zkan Sezer


--------------070005000405080007060402
Content-Type: text/plain;
	name="ULL-fixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="ULL-fixes.diff"

--- 27rc5~/drivers/char/agp/agpgart_be.c	2004-08-07 21:03:31.000000000 +0300
+++ 27rc5/drivers/char/agp/agpgart_be.c	2004-08-07 21:58:49.000000000 +0300
@@ -3447,9 +3447,9 @@
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
 		tmp = agp_bridge.mask_memory(mem->memory[i], mem->type);
 
-		BUG_ON(tmp & 0xffffff0000000ffc);
-		pte = (tmp & 0x000000ff00000000) >> 28;
-		pte |=(tmp & 0x00000000fffff000);
+		BUG_ON(tmp & 0xffffff0000000ffcULL);
+		pte = (tmp & 0x000000ff00000000ULL) >> 28;
+		pte |=(tmp & 0x00000000fffff000ULL);
 		pte |= 1<<1|1<<0;
 
 		agp_bridge.gatt_table[j] = pte;
--- 27rc5~/drivers/block/cciss.c	2004-08-07 21:03:31.000000000 +0300
+++ 27rc5/drivers/block/cciss.c	2004-08-07 21:18:41.000000000 +0300
@@ -125,7 +125,7 @@
 /* Originally cciss driver only supports 8 major number */
 #define MAX_CTLR_ORIG  COMPAQ_CISS_MAJOR7 - COMPAQ_CISS_MAJOR + 1
 
-#define CCISS_DMA_MASK 0xFFFFFFFFFFFFFFFF /* 64 bit DMA */
+#define CCISS_DMA_MASK 0xFFFFFFFFFFFFFFFFULL /* 64 bit DMA */
 
 #ifdef CONFIG_CISS_MONITOR_THREAD
 static int cciss_monitor(void *ctlr);
--- 27rc5~/drivers/scsi/qlogicfc.c	2003-06-13 16:51:36.000000000 +0200
+++ 27rc5/drivers/scsi/qlogicfc.c	2003-08-19 02:00:37.000000000 +0200
@@ -722,7 +722,7 @@ int isp2x00_detect(Scsi_Host_Template * 
 				continue;
 
 			/* Try to configure DMA attributes. */
-			if (pci_set_dma_mask(pdev, (u64) 0xffffffffffffffff) &&
+			if (pci_set_dma_mask(pdev, (u64) 0xffffffffffffffffULL) &&
 			    pci_set_dma_mask(pdev, (u64) 0xffffffff))
 					continue;
 
--- 27rc5~/drivers/net/sungem.c	2004-04-14 16:05:30.000000000 +0300
+++ 27rc5/drivers/net/sungem.c	2004-08-07 21:08:12.000000000 +0300
@@ -2920,7 +2920,7 @@ static int __devinit gem_init_one(struct
 	 */
 	if (pdev->vendor == PCI_VENDOR_ID_SUN &&
 	    pdev->device == PCI_DEVICE_ID_SUN_GEM &&
-	    !pci_set_dma_mask(pdev, (u64) 0xffffffffffffffff)) {
+	    !pci_set_dma_mask(pdev, (u64) 0xffffffffffffffffULL)) {
 		pci_using_dac = 1;
 	} else {
 		err = pci_set_dma_mask(pdev, (u64) 0xffffffff);
--- 27rc5~/drivers/net/sungem.h	2002-08-03 02:39:44.000000000 +0200
+++ 27rc5/drivers/net/sungem.h	2003-08-20 10:30:43.000000000 +0200
@@ -805,14 +805,14 @@ struct gem_txd {
 	u64	buffer;
 };
 
-#define TXDCTRL_BUFSZ	0x0000000000007fff	/* Buffer Size		*/
-#define TXDCTRL_CSTART	0x00000000001f8000	/* CSUM Start Offset	*/
-#define TXDCTRL_COFF	0x000000001fe00000	/* CSUM Stuff Offset	*/
-#define TXDCTRL_CENAB	0x0000000020000000	/* CSUM Enable		*/
-#define TXDCTRL_EOF	0x0000000040000000	/* End of Frame		*/
-#define TXDCTRL_SOF	0x0000000080000000	/* Start of Frame	*/
-#define TXDCTRL_INTME	0x0000000100000000	/* "Interrupt Me"	*/
-#define TXDCTRL_NOCRC	0x0000000200000000	/* No CRC Present	*/
+#define TXDCTRL_BUFSZ	0x0000000000007fffULL	/* Buffer Size		*/
+#define TXDCTRL_CSTART	0x00000000001f8000ULL	/* CSUM Start Offset	*/
+#define TXDCTRL_COFF	0x000000001fe00000ULL	/* CSUM Stuff Offset	*/
+#define TXDCTRL_CENAB	0x0000000020000000ULL	/* CSUM Enable		*/
+#define TXDCTRL_EOF	0x0000000040000000ULL	/* End of Frame		*/
+#define TXDCTRL_SOF	0x0000000080000000ULL	/* Start of Frame	*/
+#define TXDCTRL_INTME	0x0000000100000000ULL	/* "Interrupt Me"	*/
+#define TXDCTRL_NOCRC	0x0000000200000000ULL	/* No CRC Present	*/
 
 /* GEM requires that RX descriptors are provided four at a time,
  * aligned.  Also, the RX ring may not wrap around.  This means that
@@ -840,13 +840,13 @@ struct gem_rxd {
 	u64	buffer;
 };
 
-#define RXDCTRL_TCPCSUM	0x000000000000ffff	/* TCP Pseudo-CSUM	*/
-#define RXDCTRL_BUFSZ	0x000000007fff0000	/* Buffer Size		*/
-#define RXDCTRL_OWN	0x0000000080000000	/* GEM owns this entry	*/
-#define RXDCTRL_HASHVAL	0x0ffff00000000000	/* Hash Value		*/
-#define RXDCTRL_HPASS	0x1000000000000000	/* Passed Hash Filter	*/
-#define RXDCTRL_ALTMAC	0x2000000000000000	/* Matched ALT MAC	*/
-#define RXDCTRL_BAD	0x4000000000000000	/* Frame has bad CRC	*/
+#define RXDCTRL_TCPCSUM	0x000000000000ffffULL	/* TCP Pseudo-CSUM	*/
+#define RXDCTRL_BUFSZ	0x000000007fff0000ULL	/* Buffer Size		*/
+#define RXDCTRL_OWN	0x0000000080000000ULL	/* GEM owns this entry	*/
+#define RXDCTRL_HASHVAL	0x0ffff00000000000ULL	/* Hash Value		*/
+#define RXDCTRL_HPASS	0x1000000000000000ULL	/* Passed Hash Filter	*/
+#define RXDCTRL_ALTMAC	0x2000000000000000ULL	/* Matched ALT MAC	*/
+#define RXDCTRL_BAD	0x4000000000000000ULL	/* Frame has bad CRC	*/
 
 #define RXDCTRL_FRESH(gp)	\
 	((((RX_BUF_ALLOC_SIZE(gp) - RX_OFFSET) << 16) & RXDCTRL_BUFSZ) | \
--- 27rc5~/fs/partitions/ldm.h	2003-08-20 10:57:35.000000000 +0200
+++ 27rc5/fs/partitions/ldm.h	2003-08-20 19:21:47.000000000 +0200
@@ -38,8 +38,8 @@ struct parsed_partitions;
 /* Magic numbers in CPU format. */
 #define MAGIC_VMDB	0x564D4442		/* VMDB */
 #define MAGIC_VBLK	0x56424C4B		/* VBLK */
-#define MAGIC_PRIVHEAD	0x5052495648454144	/* PRIVHEAD */
-#define MAGIC_TOCBLOCK	0x544F43424C4F434B	/* TOCBLOCK */
+#define MAGIC_PRIVHEAD	0x5052495648454144ULL	/* PRIVHEAD */
+#define MAGIC_TOCBLOCK	0x544F43424C4F434BULL	/* TOCBLOCK */
 
 /* The defined vblk types. */
 #define VBLK_VOL5		0x51		/* Volume,     version 5 */
--- 27rc5~/fs/befs/btree.c	2003-06-13 17:51:37.000000000 +0300
+++ 27rc5/fs/befs/btree.c	2004-08-07 14:09:39.000000000 +0300
@@ -85,7 +85,7 @@
 } befs_btree_node;
 
 /* local constants */
-const static befs_off_t befs_bt_inval = 0xffffffffffffffff;
+const static befs_off_t befs_bt_inval = 0xffffffffffffffffULL;
 
 /* local functions */
 static int befs_btree_seekleaf(struct super_block *sb, befs_data_stream * ds,


--------------070005000405080007060402--
