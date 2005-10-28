Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751649AbVJ1OKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbVJ1OKk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbVJ1OKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:10:39 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:898 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751648AbVJ1OKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:10:37 -0400
Date: Fri, 28 Oct 2005 16:10:43 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, braunu@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 12/14] s390: duplicate timeout in qdio.
Message-ID: <20051028141043.GL7300@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ursula Braun-Krahl <braunu@de.ibm.com>

[patch 12/14] s390: duplicate timeout in qdio.

Remove duplicate timeout in qdio_establish().

Signed-off-by: Ursula Braun-Krahl <braunu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2005-10-28 14:04:54.000000000 +0200
@@ -56,7 +56,7 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-#define VERSION_QDIO_C "$Revision: 1.101 $"
+#define VERSION_QDIO_C "$Revision: 1.108 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -2873,10 +2873,10 @@ qdio_establish(struct qdio_initialize *i
 		return result;
 	}
 	
-	wait_event_interruptible_timeout(cdev->private->wait_q,
+	/* Timeout is cared for already by using ccw_device_start_timeout(). */
+	wait_event_interruptible(cdev->private->wait_q,
 		 irq_ptr->state == QDIO_IRQ_STATE_ESTABLISHED ||
-		 irq_ptr->state == QDIO_IRQ_STATE_ERR,
-		 QDIO_ESTABLISH_TIMEOUT);
+		 irq_ptr->state == QDIO_IRQ_STATE_ERR);
 
 	if (irq_ptr->state == QDIO_IRQ_STATE_ESTABLISHED)
 		result = 0;
