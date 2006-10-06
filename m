Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161033AbWJFOyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbWJFOyU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 10:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161037AbWJFOyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 10:54:20 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:4147 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161033AbWJFOyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 10:54:19 -0400
Date: Fri, 6 Oct 2006 16:54:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cborntra@de.ibm.com
Subject: [S390] ap bus poll thread priority.
Message-ID: <20061006145420.GA26371@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <cborntra@de.ibm.com>

[S390] ap bus poll thread priority.

The ap bus is supposed to have a low priority. We must use 19 instead
of -20, which is just the opposite.

Signed-off-by: Christian Borntraeger <cborntra@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/ap_bus.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/crypto/ap_bus.c linux-2.6-patched/drivers/s390/crypto/ap_bus.c
--- linux-2.6/drivers/s390/crypto/ap_bus.c	2006-10-06 16:29:35.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/ap_bus.c	2006-10-06 16:29:54.000000000 +0200
@@ -1062,7 +1062,7 @@ static int ap_poll_thread(void *data)
 	unsigned long flags;
 	int requests;
 
-	set_user_nice(current, -20);
+	set_user_nice(current, 19);
 	while (1) {
 		if (need_resched()) {
 			schedule();
