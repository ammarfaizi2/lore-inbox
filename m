Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130558AbQLOMDw>; Fri, 15 Dec 2000 07:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLOMDn>; Fri, 15 Dec 2000 07:03:43 -0500
Received: from ns.tasking.nl ([195.193.207.2]:55303 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S129436AbQLOMDZ>;
	Fri, 15 Dec 2000 07:03:25 -0500
Date: Fri, 15 Dec 2000 12:31:14 +0100
From: Frank van Maarseveen <fvm@tasking.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test12-pre8: solid lockup
Message-ID: <20001215123113.A1044@espoo.tasking.nl>
Reply-To: frank_van_maarseveen@tasking.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i (Linux)
Organization: TASKING, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just had a solid lockup inside X. Just moved the serial mouse, nothing
special going on. No caps lock, no ping.

gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/specs
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)

Kernel is 2.4.0-test12-pre8 + this patch:
--- linux/drivers/char/drm/i810_dma.c.orig	Tue Nov 14 10:08:21 2000
+++ linux/drivers/char/drm/i810_dma.c	Mon Dec 11 11:22:35 2000
@@ -924,7 +924,7 @@
 	dev->dma->next_queue  = NULL;
 	dev->dma->this_buffer = NULL;
 
-	dev->tq.next	      = NULL;
+	INIT_LIST_HEAD(&dev->tq.list);
 	dev->tq.sync	      = 0;
 	dev->tq.routine	      = i810_dma_task_queue;
 	dev->tq.data	      = dev;

-- 
Frank
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
