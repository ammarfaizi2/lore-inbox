Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWHCTgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWHCTgq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 15:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWHCTgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 15:36:46 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:15756 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932466AbWHCTgp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 15:36:45 -0400
Date: Thu, 3 Aug 2006 14:36:43 -0500
To: akpm@osdl.org, hollisbl@us.ibm.com
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pSeries  hvsi char driver janitorial cleanup.
Message-ID: <20060803193643.GA10638@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew, 
Please apply.

A set of tty line discipline cleanup patches were introduced 
before the dawn of time, in kernel version 2.4.21. This patch
performs that cleanup for the hvsi driver.

The hvsi driver is used only on IBM pSeries PowerPC boxes.
The driver was originally written by Hollis Blanchard, who 
has delegated maintainership to me. So this my first and
maybe only patch in this official new role, because this 
driver is otherwise bug-free :-)

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/char/hvsi.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: linux-2.6.18-rc3-git1/drivers/char/hvsi.c
===================================================================
--- linux-2.6.18-rc3-git1.orig/drivers/char/hvsi.c	2006-08-01 14:26:38.000000000 -0500
+++ linux-2.6.18-rc3-git1/drivers/char/hvsi.c	2006-08-01 15:03:12.000000000 -0500
@@ -986,10 +986,7 @@ static void hvsi_write_worker(void *arg)
 		start_j = 0;
 #endif /* DEBUG */
 		wake_up_all(&hp->emptyq);
-		if (test_bit(TTY_DO_WRITE_WAKEUP, &hp->tty->flags)
-				&& hp->tty->ldisc.write_wakeup)
-			hp->tty->ldisc.write_wakeup(hp->tty);
-		wake_up_interruptible(&hp->tty->write_wait);
+		tty_wakeup(hp->tty);
 	}
 
 out:
