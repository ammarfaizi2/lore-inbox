Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267324AbSLNDu6>; Fri, 13 Dec 2002 22:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267361AbSLNDu6>; Fri, 13 Dec 2002 22:50:58 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:44579 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267324AbSLNDu5>; Fri, 13 Dec 2002 22:50:57 -0500
Date: Fri, 13 Dec 2002 22:48:44 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Printout improvements in ide-tape
Message-ID: <20021213224844.B3446@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one changes printouts only. It is not as important as the
one I sent before it, but it was very helpful in debugging.
I think we better have this one too.

-- Pete

--- linux-2.4.20-ac2/drivers/ide/ide-tape.c	Fri Dec 13 16:55:13 2002
+++ linux-2.4.20-ac2-pb/drivers/ide/ide-tape.c	Fri Dec 13 18:12:20 2002
@@ -2165,11 +2163,6 @@
 			status.b.check = 0;
 		if (status.b.check || test_bit(PC_DMA_ERROR, &pc->flags)) {
 			/* Error detected */
-#if IDETAPE_DEBUG_LOG
-			if (tape->debug_level >= 1)
-				printk(KERN_INFO "ide-tape: %s: I/O error\n",
-					tape->name);
-#endif /* IDETAPE_DEBUG_LOG */
 			if (pc->c[0] == IDETAPE_REQUEST_SENSE_CMD) {
 				printk(KERN_ERR "ide-tape: I/O error in "
 					"request sense command\n");
@@ -2270,8 +2263,8 @@
 	pc->current_position += bcount.all;
 #if IDETAPE_DEBUG_LOG
 	if (tape->debug_level >= 2)
-		printk(KERN_INFO "ide-tape: [cmd %x] transferred %d bytes "
-			"on that interrupt\n", pc->c[0], bcount.all);
+		printk(KERN_INFO "ide-tape: [cmd %x] done %d\n"
+			pc->c[0], bcount.all);
 #endif
 	if (HWGROUP(drive)->handler != NULL)
 		BUG();
@@ -2614,8 +2607,11 @@
 	if (status.b.dsc) {
 		if (status.b.check) {
 			/* Error detected */
-			printk(KERN_ERR "ide-tape: %s: I/O error, ",
-					tape->name);
+			printk(KERN_ERR "ide-tape: %s: I/O error: "
+			    "pc = %2x, key = %2x, asc = %2x, ascq = %2x\n",
+			    tape->name, pc->c[0],
+			    tape->sense_key, tape->asc, tape->ascq);
+
 			/* Retry operation */
 			return idetape_retry_pc(drive);
 		}
