Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030458AbWHOTCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030458AbWHOTCW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbWHOTCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:02:22 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13327 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030465AbWHOTCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:02:20 -0400
Date: Tue, 15 Aug 2006 21:02:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] drivers/crypto/geode-aes.c: cleanups
Message-ID: <20060815190218.GC7813@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make needlessly global code static
- use C99 struct initializers

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

The {cia,geode_aes}_{setkey,encrypt,decryt} prototype confusion both 
sparse and gcc are giveng warnings about should also be fixed.

This patch was already sent on:
- 7 Aug 2006

 drivers/crypto/geode-aes.c |   12 ++++++------
 drivers/crypto/geode-aes.h |    2 --
 2 files changed, 6 insertions(+), 8 deletions(-)

--- linux-2.6.18-rc3-mm2-full/drivers/crypto/geode-aes.h.old	2006-08-07 16:23:25.000000000 +0200
+++ linux-2.6.18-rc3-mm2-full/drivers/crypto/geode-aes.h	2006-08-07 16:23:51.000000000 +0200
@@ -37,6 +37,4 @@
   u8 iv[AES_IV_LENGTH];
 };
 
-unsigned int geode_aes_crypt(struct geode_aes_op *);
-
 #endif
--- linux-2.6.18-rc3-mm2-full/drivers/crypto/geode-aes.c.old	2006-08-07 16:24:03.000000000 +0200
+++ linux-2.6.18-rc3-mm2-full/drivers/crypto/geode-aes.c	2006-08-07 16:50:41.000000000 +0200
@@ -114,7 +114,7 @@
 	AWRITE((status & 0xFF) | AES_INTRA_PENDING, AES_INTR_REG);
 }
 
-unsigned int
+static unsigned int
 geode_aes_crypt(struct geode_aes_op *op)
 {
 	u32 flags = 0;
@@ -361,7 +361,7 @@
 	return ret;
 }
 
-struct pci_device_id geode_aes_tbl[] = {
+static struct pci_device_id geode_aes_tbl[] = {
 	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LX_AES, PCI_ANY_ID, PCI_ANY_ID} ,
 	{ 0, }
 };
@@ -369,10 +369,10 @@
 MODULE_DEVICE_TABLE(pci, geode_aes_tbl);
 
 static struct pci_driver geode_aes_driver = {
-	name:      "Geode LX AES",
-	id_table:  geode_aes_tbl,
-	probe:     geode_aes_probe,
-	remove:    __devexit_p(geode_aes_remove)
+	.name		= "Geode LX AES",
+	.id_table	= geode_aes_tbl,
+	.probe		= geode_aes_probe,
+	.remove		= __devexit_p(geode_aes_remove)
 };
 
 static int __devinit
