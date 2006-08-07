Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWHGPuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWHGPuM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWHGPuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:50:10 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11535 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932174AbWHGPuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:50:07 -0400
Date: Mon, 7 Aug 2006 17:50:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] drivers/crypto/geode-aes.c: cleanups
Message-ID: <20060807155004.GF3691@stusta.de>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060806030809.2cfb0b1e.akpm@osdl.org>
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
