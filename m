Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272414AbTG1B1V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272325AbTG1ACc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:02:32 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272758AbTG0W7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:59:51 -0400
Date: Sun, 27 Jul 2003 21:12:49 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272012.h6RKCn73029691@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: fix invalid/illegal and printk formatting for scsi drivers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/scsi/53c7xx.c linux-2.6.0-test2-ac1/drivers/scsi/53c7xx.c
--- linux-2.6.0-test2/drivers/scsi/53c7xx.c	2003-07-27 19:56:25.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/scsi/53c7xx.c	2003-07-27 20:24:26.000000000 +0100
@@ -4977,7 +4977,7 @@
 		hostdata->options |= OPTION_NO_PRINT_RACE;
 	    }
 	} else {
-	    printk(KERN_ALERT "scsi%d : illegal instruction\n", host->host_no);
+	    printk(KERN_ALERT "scsi%d : invalid instruction\n", host->host_no);
 	    print_lots (host);
 	    printk(KERN_ALERT "         mail Richard@sleepie.demon.co.uk with ALL\n"
 		              "         boot messages and diagnostic output\n");
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/scsi/aha152x.c linux-2.6.0-test2-ac1/drivers/scsi/aha152x.c
--- linux-2.6.0-test2/drivers/scsi/aha152x.c	2003-07-27 19:56:25.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/scsi/aha152x.c	2003-07-27 20:24:40.000000000 +0100
@@ -3098,7 +3098,7 @@
 		printk("MESSAGE IN");
 		break;
 	default:
-		printk("*illegal*");
+		printk("*invalid*");
 		break;
 	}
 
@@ -3467,7 +3467,7 @@
 		SPRINTF("MESSAGE IN");
 		break;
 	default:
-		SPRINTF("*illegal*");
+		SPRINTF("*invalid*");
 		break;
 	}
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/scsi/aha1542.c linux-2.6.0-test2-ac1/drivers/scsi/aha1542.c
--- linux-2.6.0-test2/drivers/scsi/aha1542.c	2003-07-27 19:56:25.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/scsi/aha1542.c	2003-07-27 20:24:40.000000000 +0100
@@ -67,7 +67,7 @@
 		       int nseg,
 		       int badseg)
 {
-	printk(KERN_CRIT "sgpnt[%d:%d] page %p/0x%x length %ld\n",
+	printk(KERN_CRIT "sgpnt[%d:%d] page %p/0x%x length %u\n",
 	       badseg, nseg,
 	       page_address(sgpnt[badseg].page) + sgpnt[badseg].offset,
 	       SCSI_SG_PA(&sgpnt[badseg]),
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/scsi/aic7xxx/aic7770.c linux-2.6.0-test2-ac1/drivers/scsi/aic7xxx/aic7770.c
--- linux-2.6.0-test2/drivers/scsi/aic7xxx/aic7770.c	2003-07-10 21:15:34.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/scsi/aic7xxx/aic7770.c	2003-07-15 18:01:30.000000000 +0100
@@ -170,7 +170,7 @@
 	case 15:
 		break;
 	default:
-		printf("aic7770_config: illegal irq setting %d\n", intdef);
+		printf("aic7770_config: invalid irq setting %d\n", intdef);
 		return (ENXIO);
 	}
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/scsi/AM53C974.c linux-2.6.0-test2-ac1/drivers/scsi/AM53C974.c
--- linux-2.6.0-test2/drivers/scsi/AM53C974.c	2003-07-27 19:56:25.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/scsi/AM53C974.c	2003-07-27 20:24:26.000000000 +0100
@@ -598,7 +598,7 @@
 			    (ints[1] == ints[2]) ||
 			    (ints[3] < (DEF_CLK / MAX_PERIOD)) || (ints[3] > (DEF_CLK / MIN_PERIOD)) ||
 			    (ints[4] < 0) || (ints[4] > MAX_OFFSET))
-				printk("AM53C974_setup: illegal parameter\n");
+				printk("AM53C974_setup: invalid parameter\n");
 			else {
 				overrides[commandline_current].host_scsi_id = ints[1];
 				overrides[commandline_current].target_scsi_id = ints[2];
