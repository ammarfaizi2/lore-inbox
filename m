Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbUBTSYe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 13:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbUBTSYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 13:24:34 -0500
Received: from [61.95.227.64] ([61.95.227.64]:53634 "EHLO gateway.gsecone.com")
	by vger.kernel.org with ESMTP id S261271AbUBTSWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 13:22:25 -0500
Message-ID: <4036505B.1060002@gsecone.com>
Date: Fri, 20 Feb 2004 18:22:19 +0000
From: Vinay K Nallamothu <nvk@gsecone.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.3][MTD] doc200X warning fixes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fixes the following warnings:
drivers/mtd/devices/doc2000.c:567: warning: assignment from incompatible pointer type
drivers/mtd/devices/doc2000.c:568: warning: assignment from incompatible pointer type


 doc2000.c |    8 ++++----
 doc2001.c |    8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)


diff -urN linux-2.6.2/drivers/mtd/devices/doc2000.c linux-2.6.2-nvk/drivers/mtd/devices/doc2000.c
--- linux-2.6.2/drivers/mtd/devices/doc2000.c	2004-01-09 06:59:02.000000000 +0000
+++ linux-2.6.2-nvk/drivers/mtd/devices/doc2000.c	2004-02-07 22:11:31.000000000 +0000
@@ -53,9 +53,9 @@
 static int doc_write(struct mtd_info *mtd, loff_t to, size_t len,
 		     size_t *retlen, const u_char *buf);
 static int doc_read_ecc(struct mtd_info *mtd, loff_t from, size_t len,
-			size_t *retlen, u_char *buf, u_char *eccbuf, int oobsel);
+			size_t *retlen, u_char *buf, u_char *eccbuf, struct nand_oobinfo *oobsel);
 static int doc_write_ecc(struct mtd_info *mtd, loff_t to, size_t len,
-			 size_t *retlen, const u_char *buf, u_char *eccbuf, int oobsel);
+			 size_t *retlen, const u_char *buf, u_char *eccbuf, struct nand_oobinfo *oobsel);
 static int doc_read_oob(struct mtd_info *mtd, loff_t ofs, size_t len,
 			size_t *retlen, u_char *buf);
 static int doc_write_oob(struct mtd_info *mtd, loff_t ofs, size_t len,
@@ -601,7 +601,7 @@
 }
 
 static int doc_read_ecc(struct mtd_info *mtd, loff_t from, size_t len,
-			size_t * retlen, u_char * buf, u_char * eccbuf, int oobsel)
+			size_t * retlen, u_char * buf, u_char * eccbuf, struct nand_oobinfo *oobsel)
 {
 	struct DiskOnChip *this = (struct DiskOnChip *) mtd->priv;
 	unsigned long docptr;
@@ -750,7 +750,7 @@
 
 static int doc_write_ecc(struct mtd_info *mtd, loff_t to, size_t len,
 			 size_t * retlen, const u_char * buf,
-			 u_char * eccbuf, int oobsel)
+			 u_char * eccbuf, struct nand_oobinfo *oobsel)
 {
 	struct DiskOnChip *this = (struct DiskOnChip *) mtd->priv;
 	int di; /* Yes, DI is a hangover from when I was disassembling the binary driver */
diff -urN linux-2.6.2/drivers/mtd/devices/doc2001.c linux-2.6.2-nvk/drivers/mtd/devices/doc2001.c
--- linux-2.6.2/drivers/mtd/devices/doc2001.c	2004-01-09 06:59:19.000000000 +0000
+++ linux-2.6.2-nvk/drivers/mtd/devices/doc2001.c	2004-02-07 21:59:26.000000000 +0000
@@ -37,9 +37,9 @@
 static int doc_write(struct mtd_info *mtd, loff_t to, size_t len,
 		     size_t *retlen, const u_char *buf);
 static int doc_read_ecc(struct mtd_info *mtd, loff_t from, size_t len,
-			size_t *retlen, u_char *buf, u_char *eccbuf, int oobsel);
+			size_t *retlen, u_char *buf, u_char *eccbuf, struct nand_oobinfo *oobsel);
 static int doc_write_ecc(struct mtd_info *mtd, loff_t to, size_t len,
-			 size_t *retlen, const u_char *buf, u_char *eccbuf, int oobsel);
+			 size_t *retlen, const u_char *buf, u_char *eccbuf, struct nand_oobinfo *oobsel);
 static int doc_read_oob(struct mtd_info *mtd, loff_t ofs, size_t len,
 			size_t *retlen, u_char *buf);
 static int doc_write_oob(struct mtd_info *mtd, loff_t ofs, size_t len,
@@ -407,7 +407,7 @@
 }
 
 static int doc_read_ecc (struct mtd_info *mtd, loff_t from, size_t len,
-			 size_t *retlen, u_char *buf, u_char *eccbuf, int oobsel)
+			 size_t *retlen, u_char *buf, u_char *eccbuf, struct nand_oobinfo *oobsel)
 {
 	int i, ret;
 	volatile char dummy;
@@ -533,7 +533,7 @@
 }
 
 static int doc_write_ecc (struct mtd_info *mtd, loff_t to, size_t len,
-			  size_t *retlen, const u_char *buf, u_char *eccbuf, int oobsel)
+			  size_t *retlen, const u_char *buf, u_char *eccbuf, struct nand_oobinfo *oobsel)
 {
 	int i,ret = 0;
 	volatile char dummy;



