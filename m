Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbVCBQtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbVCBQtX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 11:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVCBQsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 11:48:51 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:36829 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262353AbVCBQqJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 11:46:09 -0500
Date: Wed, 2 Mar 2005 17:46:09 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 6/9] s390: z90crypt reader task rescheduling.
Message-ID: <20050302164609.GF27829@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 6/9] s390: z90crypt reader task rescheduling.

From: Eric Rossman <edrossma@us.ibm.com>

z90crypt device driver changes:
 - Correct the condition for which the reader task is scheduled to run.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/crypto/z90main.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -urN linux-2.6/drivers/s390/crypto/z90main.c linux-2.6-patched/drivers/s390/crypto/z90main.c
--- linux-2.6/drivers/s390/crypto/z90main.c	2005-03-02 08:37:30.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/z90main.c	2005-03-02 17:00:13.000000000 +0100
@@ -2657,8 +2657,8 @@
 
 	/**
 	 * we use workavail = 2 to ensure 2 passes with nothing dequeued before
-	 * exiting the loop. If pendingq_count == 0 after the loop, there is no
-	 * work remaining on the queues.
+	 * exiting the loop. If (pendingq_count+requestq_count) == 0 after the
+	 * loop, there is no work remaining on the queues.
 	 */
 	resp_addr = 0;
 	workavail = 2;
@@ -2697,7 +2697,7 @@
 		spin_unlock_irq(&queuespinlock);
 	}
 
-	if (pendingq_count)
+	if (pendingq_count + requestq_count)
 		z90crypt_schedule_reader_timer();
 }
 
