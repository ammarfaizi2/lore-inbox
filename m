Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267791AbUHXN1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267791AbUHXN1Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 09:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267795AbUHXN1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 09:27:24 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:7834 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S267791AbUHXNZe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 09:25:34 -0400
Date: Tue, 24 Aug 2004 15:26:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: common i/o layer.
Message-ID: <20040824132601.GB5954@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: common i/o layer.

From: Steffen Thoss <thoss@de.ibm.com>

common i/o layer change:
 - Correct check in qdio_stop_polling to avoid loosing initiative on the
   qdio inbound queue.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/cio/qdio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-s390/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	Sat Aug 14 12:55:34 2004
+++ linux-2.6-s390/drivers/s390/cio/qdio.c	Tue Aug 24 15:12:43 2004
@@ -56,7 +56,7 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-#define VERSION_QDIO_C "$Revision: 1.84 $"
+#define VERSION_QDIO_C "$Revision: 1.86 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -365,7 +365,7 @@
 	 * small window we can miss between resetting it and
 	 * checking for PRIMED state 
 	 */
-	if (q->is_iqdio_q)
+	if (q->is_thinint_q)
 		tiqdio_set_summary_bit((__u32*)q->dev_st_chg_ind);
 	return 0;
 
