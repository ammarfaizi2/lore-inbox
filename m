Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWDOCgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWDOCgb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 22:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbWDOCga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 22:36:30 -0400
Received: from xenotime.net ([66.160.160.81]:26521 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030205AbWDOCga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 22:36:30 -0400
Date: Fri, 14 Apr 2006 19:38:56 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, kjhall@us.ibm.com
Subject: [PATCH] tpm_infineon section fixup
Message-Id: <20060414193856.917a35dc.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Use __devexit_p() for the exit/remove function to protect
against discarding it.

WARNING: drivers/char/tpm/tpm_infineon.o - Section mismatch: reference to .exit.text:tpm_inf_pnp_remove from .data between 'tpm_inf_pnp' (at offset 0x20) and 'tpm_inf'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/char/tpm/tpm_infineon.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2617-rc1g8.orig/drivers/char/tpm/tpm_infineon.c
+++ linux-2617-rc1g8/drivers/char/tpm/tpm_infineon.c
@@ -15,6 +15,7 @@
  * License.
  */
 
+#include <linux/init.h>
 #include <linux/pnp.h>
 #include "tpm.h"
 
@@ -520,7 +521,7 @@ static struct pnp_driver tpm_inf_pnp = {
 	},
 	.id_table = tpm_pnp_tbl,
 	.probe = tpm_inf_pnp_probe,
-	.remove = tpm_inf_pnp_remove,
+	.remove = __devexit_p(tpm_inf_pnp_remove),
 };
 
 static int __init init_inf(void)


---
