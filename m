Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTIFTzd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 15:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbTIFTzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 15:55:33 -0400
Received: from mail.gmx.de ([213.165.64.20]:54971 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261757AbTIFTz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 15:55:29 -0400
Message-ID: <3F5A3C50.8010702@gmx.at>
Date: Sat, 06 Sep 2003 21:58:08 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>, Alan Cox <alan@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] hptraid v0.03: minor fix
Content-Type: multipart/mixed;
 boundary="------------060008050703020709090501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060008050703020709090501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I have some cosmetic updates for the hptraid driver.

Changelog since 0.02:
=====================
* register the raid volume only if all disks are available
* print a warning that raid-(0+)1 failover is not supported

the patch applies against kernel 2.4.22 and later

Greetings,
Wilfried

--------------060008050703020709090501
Content-Type: text/plain;
 name="hptraid_0_03.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="hptraid_0_03.patch"

Index: linux/drivers/ide/raid/hptraid.c
diff -u linux/drivers/ide/raid/hptraid.c:1.1.2.1.6.11 linux/drivers/ide/raid/hptraid.c:1.1.2.1.6.13
--- linux/drivers/ide/raid/hptraid.c:1.1.2.1.6.11	Sun Jun 15 20:22:42 2003
+++ linux/drivers/ide/raid/hptraid.c	Tue Aug 19 21:20:32 2003
@@ -18,7 +18,11 @@
    Based on work done by Søren Schmidt for FreeBSD
 
    Changelog:
-   15.06.2003 wweissmann@gmx.at
+   19.08.2003 v0.03 wweissmann@gmx.at
+   	* register the raid volume only if all disks are available
+	* print a warning that raid-(0+)1 failover is not supported
+
+   15.06.2003 v0.02 wweissmann@gmx.at
    	* correct values of raid-1 superbock
 	* re-add check for availability of all disks
 	* fix offset bug in raid-1 (introduced in raid 0+1 implementation)
@@ -814,10 +818,6 @@
 			break;
 	}
 
-	/* Initialize the gendisk structure */
-	
-	ataraid_register_disk(device,raid[device].sectors);
-
 	/* Verify that we have all disks */
 
 	count=count_disks(raid+device);
@@ -844,7 +844,17 @@
 					return -ENODEV;
 				}
 			}
+			printk(KERN_WARNING "ataraid%i: raid-0+1 disk failover is not implemented!\n",
+					device);
 		}
+		else if (type == HPT_T_RAID_1) {
+			printk(KERN_WARNING "ataraid%i: raid-1 disk failover is not implemented!\n",
+					device);
+		}	
+		/* Initialize the gendisk structure */
+	
+		ataraid_register_disk(device,raid[device].sectors);
+
 		return 0;
 	}
 	
@@ -856,7 +866,7 @@
  	int retval=-ENODEV;
 	int device,i,count=0;
   	
-	printk(KERN_INFO "Highpoint HPT370 Softwareraid driver for linux version 0.02\n");
+	printk(KERN_INFO "Highpoint HPT370 Softwareraid driver for linux version 0.03\n");
 
 	for(i=0; oplist[i].op; i++) {
 		do

--------------060008050703020709090501--

