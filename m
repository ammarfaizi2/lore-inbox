Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264728AbTGKRwC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 13:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264682AbTGKRvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 13:51:17 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:64643
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264678AbTGKRu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:50:59 -0400
Date: Fri, 11 Jul 2003 19:04:47 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111804.h6BI4lcr017212@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: clean up floppy98 a bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/drivers/block/floppy98.c linux-2.5.75-ac1/drivers/block/floppy98.c
--- linux-2.5.75/drivers/block/floppy98.c	2003-07-10 21:08:10.000000000 +0100
+++ linux-2.5.75-ac1/drivers/block/floppy98.c	2003-07-11 14:33:22.000000000 +0100
@@ -4064,21 +4064,32 @@
 static char *table[] =
 {"",
 #if 0
-"d360", 
+	"d360", 
 #else
-"h1232",
+	"h1232",
 #endif
-"h1200", "u360", "u720", "h360", "h720",
-"u1440", "u2880", "CompaQ", "h1440", "u1680", "h410",
-"u820", "h1476", "u1722", "h420", "u830", "h1494", "u1743",
-"h880", "u1040", "u1120", "h1600", "u1760", "u1920",
-"u3200", "u3520", "u3840", "u1840", "u800", "u1600",
+	"h1200", "u360", "u720", "h360", "h720",
+	"u1440", "u2880", "CompaQ", "h1440", "u1680", "h410",
+	"u820", "h1476", "u1722", "h420", "u830", "h1494", "u1743",
+	"h880", "u1040", "u1120", "h1600", "u1760", "u1920",
+	"u3200", "u3520", "u3840", "u1840", "u800", "u1600",
 NULL
 };
-static int t360[] = {1,0}, t1200[] = {2,5,6,10,12,14,16,18,20,23,0},
-t3in[] = {8,9,26,27,28, 7,11,15,19,24,25,29,31, 3,4,13,17,21,22,30,0};
-static int *table_sup[] = 
-{NULL, t360, t1200, t3in+5+8, t3in+5, t3in, t3in};
+
+static int t360[] = {
+	1,0
+};
+static int t1200[] = {
+	2,5,6,10,12,14,16,18,20,23,0
+};
+static int t3in[] = {
+	 8, 9,26,27,28, 7,11,15,19,24,25,
+	29,31, 3, 4,13,17,21,22,30, 0
+};
+
+static int *table_sup[] = {
+	NULL, t360, t1200, t3in+5+8, t3in+5, t3in, t3in
+};
 
 static void __init register_devfs_entries (int drive)
 {
@@ -4402,7 +4413,7 @@
 	return 0;
 
 out1:
-	del_timer(&fd_timeout);
+	del_timer_sync(&fd_timeout);
 out2:
 	blk_unregister_region(MKDEV(FLOPPY_MAJOR, 0), 256);
 	unregister_blkdev(FLOPPY_MAJOR,"fd");
@@ -4430,11 +4441,9 @@
 		return 0;
 	}
 	spin_unlock_irqrestore(&floppy_usage_lock, flags);
-	MOD_INC_USE_COUNT;
 	if (fd_request_irq()) {
 		DPRINT("Unable to grab IRQ%d for the floppy driver\n",
 			FLOPPY_IRQ);
-		MOD_DEC_USE_COUNT;
 		spin_lock_irqsave(&floppy_usage_lock, flags);
 		usage_count--;
 		spin_unlock_irqrestore(&floppy_usage_lock, flags);
@@ -4444,7 +4453,6 @@
 		DPRINT("Unable to grab DMA%d for the floppy driver\n",
 			FLOPPY_DMA);
 		fd_free_irq();
-		MOD_DEC_USE_COUNT;
 		spin_lock_irqsave(&floppy_usage_lock, flags);
 		usage_count--;
 		spin_unlock_irqrestore(&floppy_usage_lock, flags);
@@ -4521,7 +4529,6 @@
 			release_region(0x04be, 1);
 		}
 	}
-	MOD_DEC_USE_COUNT;
 	spin_lock_irqsave(&floppy_usage_lock, flags);
 	usage_count--;
 	spin_unlock_irqrestore(&floppy_usage_lock, flags);
@@ -4587,7 +4594,6 @@
 			}
 		}
 	fdc = old_fdc;
-	MOD_DEC_USE_COUNT;
 }
 
 
