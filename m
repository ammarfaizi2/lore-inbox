Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWDLVrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWDLVrc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 17:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWDLVrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 17:47:32 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:60323 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932328AbWDLVrR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 17:47:17 -0400
Subject: [PATCH] tpm: check mem start and len
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 16:48:06 -0500
Message-Id: <1144878487.12054.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The memory start and length values obtained from the ACPI entry need to
be checked and filled in with the default values from the specification
if they don't exist.  This patch fills in the default values and uses
them appropriately.

Signed-off-by: Kylie Hall <kjhall@us.ibm.com>
---
 drivers/char/tpm/tpm_tis.c |    7 +++++++
 1 files changed, 7 insertions(+)

--- linux-2.6.17-rc1-mm2/drivers/char/tpm/tpm_tis.c	2006-04-12 16:39:40.191345000 -0500
+++ linux-2.6.17-rc1/drivers/char/tpm/tpm_tis.c	2006-04-12 14:49:13.033173500 -0500
@@ -52,6 +52,8 @@ enum tis_int_flags {
 };
 
 enum tis_defaults {
+	TIS_MEM_BASE = 0xFED4000,
+	TIS_MEM_LEN = 0x5000,
 	TIS_SHORT_TIMEOUT = 750, /* ms */
 	TIS_LONG_TIMEOUT = 2000, /* 2 sec */
 };
@@ -437,6 +439,11 @@ static int __devinit tpm_tis_pnp_init(st
 	start = pnp_mem_start(pnp_dev, 0);
 	len = pnp_mem_len(pnp_dev, 0);
 
+	if (!start)
+		start = TIS_MEM_BASE; 
+	if (!len)
+		len = TIS_MEM_LEN;
+
 	if (!(chip = tpm_register_hardware(&pnp_dev->dev, &tpm_tis)))
 		return -ENODEV;
 


