Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263830AbTCUUYO>; Fri, 21 Mar 2003 15:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264013AbTCUUXB>; Fri, 21 Mar 2003 15:23:01 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:54916
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263830AbTCUT10>; Fri, 21 Mar 2003 14:27:26 -0500
Date: Fri, 21 Mar 2003 20:42:42 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212042.h2LKggcO026455@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: printk, version etc for ide-taskfile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/ide-taskfile.c linux-2.5.65-ac2/drivers/ide/ide-taskfile.c
--- linux-2.5.65/drivers/ide/ide-taskfile.c	2003-03-18 16:46:48.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/ide-taskfile.c	2003-03-20 18:23:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/ide-taskfile.c	Version 0.33	April 11, 2002
+ * linux/drivers/ide/ide-taskfile.c	Version 0.38	March 05, 2003
  *
  *  Copyright (C) 2000-2002	Michael Cornwell <cornwell@acm.org>
  *  Copyright (C) 2000-2002	Andre Hedrick <andre@linux-ide.org>
@@ -27,7 +27,6 @@
  */
 
 #include <linux/config.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/string.h>
@@ -642,7 +641,7 @@
 				 * NOTE: could rewind beyond beginning :-/
 				 */
 			} else {
-				printk("%s: MULTI-READ assume all data " \
+				printk(KERN_ERR "%s: MULTI-READ assume all data " \
 					"transfered is bad status=0x%02x\n",
 					drive->name, stat);
 			}
@@ -810,11 +809,6 @@
 	rq->errors = 0;
 	return ide_started;
 #else /* ! ALTERNATE_STATE_DIAGRAM_MULTI_OUT */
-
-#if 0
-	if (wait_for_ready(drive, 100))
-		IDE_DEBUG(__LINE__);		//BUG();
-#else
 	if (!(drive_is_ready(drive))) {
 		int i;
 		for (i=0; i<100; i++) {
@@ -822,7 +816,7 @@
 				break;
 		}
 	}
-#endif
+
 	/*
 	 * WARNING :: if the drive as not acked good status we may not
 	 * move the DATA-TRANSFER T-Bar as BSY != 0. <andre@linux-ide.org>
@@ -864,7 +858,7 @@
 				 * NOTE: could rewind beyond beginning :-/
 				 */
 			} else {
-				printk("%s: MULTI-WRITE assume all data " \
+				printk(KERN_ERR "%s: MULTI-WRITE assume all data " \
 					"transfered is bad status=0x%02x\n",
 					drive->name, stat);
 			}
@@ -1497,7 +1491,7 @@
 		case TASKFILE_MULTI_OUT:
 			if (!drive->mult_count) {
 				/* (hs): give up if multcount is not set */
-				printk("%s: %s Multimode Write " \
+				printk(KERN_ERR "%s: %s Multimode Write " \
 					"multcount is not set\n",
 					drive->name, __FUNCTION__);
 				err = -EPERM;
@@ -1525,7 +1519,7 @@
 		case TASKFILE_MULTI_IN:
 			if (!drive->mult_count) {
 				/* (hs): give up if multcount is not set */
-				printk("%s: %s Multimode Read failure " \
+				printk(KERN_ERR "%s: %s Multimode Read failure " \
 					"multcount is not set\n",
 					drive->name, __FUNCTION__);
 				err = -EPERM;
