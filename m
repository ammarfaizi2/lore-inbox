Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030361AbWGMUZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbWGMUZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWGMUZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:25:28 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:39322 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030361AbWGMUZ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:25:27 -0400
Subject: [PATCH] tpm_tis: use resource_size_t
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>, akpm@osdl.org
Content-Type: text/plain
Date: Thu, 13 Jul 2006 13:25:28 -0700
Message-Id: <1152822328.5347.136.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the start and len variables that should be using the new
resource_size_t.

Signed_off_by: Kylene Hall <kjhall@us.ibm.com>
---
--- linux-2.6.18-rc1/drivers/char/tpm/tpm_tis.c	2006-07-13 14:46:09.865634250 -0500
+++ linux-2.6.18-rc1-tpm/drivers/char/tpm/tpm_tis.c	2006-07-13 14:45:56.932826000 -0500
@@ -431,7 +431,8 @@ static int interrupts = 1;
 module_param(interrupts, bool, 0444);
 MODULE_PARM_DESC(interrupts, "Enable interrupts");
 
-static int tpm_tis_init(struct device *dev, unsigned long start, unsigned long len)
+static int tpm_tis_init(struct device *dev, resource_size_t start,
+			resource_size_t len)
 {
 	u32 vendor, intfcaps, intmask;
 	int rc, i;
@@ -592,7 +593,7 @@ out_err:
 static int __devinit tpm_tis_pnp_init(struct pnp_dev *pnp_dev,
 				      const struct pnp_device_id *pnp_id)
 {
-	unsigned long start, len;
+	resource_size_t start, len;
 	start = pnp_mem_start(pnp_dev, 0);
 	len = pnp_mem_len(pnp_dev, 0);
 


