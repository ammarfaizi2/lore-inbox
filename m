Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263051AbVFXU3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263051AbVFXU3V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 16:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbVFXU3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 16:29:21 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:4070 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263264AbVFXU13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 16:27:29 -0400
Subject: PATCH] tpm: Fix pubek parsing
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 24 Jun 2005 15:27:26 -0500
Message-Id: <1119644847.31799.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix parsing of the PUBEK for display which was leading to showing the
wrong modulus length and modulus.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
--- 
Index: drivers/char/tpm/tpm.c
===================================================================
RCS file: /cvsroot/tpmdd/tpmdd/drivers/char/tpm/tpm.c,v
retrieving revision 1.28
diff -u -p -r1.28 tpm.c
--- ./drivers/char/tpm/tpm.c	15 Jun 2005 17:15:18 -0000	1.28
+++ ./drivers/char/tpm/tpm.c	23 Jun 2005 21:44:54 -0000
@@ -257,10 +266,10 @@ ssize_t tpm_show_pubek(struct device *de
 		    data[15], data[16], data[17], data[22], data[23],
 		    data[24], data[25], data[26], data[27], data[28],
 		    data[29], data[30], data[31], data[32], data[33],
-		    be32_to_cpu(*((__be32 *) (data + 32))));
+		    be32_to_cpu(*((__be32 *) (data + 34))));
 
 	for (i = 0; i < 256; i++) {
-		str += sprintf(str, "%02X ", data[i + 39]);
+		str += sprintf(str, "%02X ", data[i + 38]);
 		if ((i + 1) % 16 == 0)
 			str += sprintf(str, "\n");
 	}


