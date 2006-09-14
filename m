Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWINLn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWINLn7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 07:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWINLn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 07:43:59 -0400
Received: from mail.telecasystems.de ([217.111.48.251]:10985 "EHLO
	mail.telecasystems.de") by vger.kernel.org with ESMTP
	id S1751226AbWINLn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 07:43:58 -0400
Message-ID: <4509407B.6050201@gmail.com>
Date: Thu, 14 Sep 2006 13:43:55 +0200
From: Metathronius Galabant <m.galabant@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417 Mnenhy/0.7.4.666
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: remove unneeded spaces in cciss output for attached volumes
Content-Type: multipart/mixed;
 boundary="------------080403080401020001010804"
X-OriginalArrivalTime: 14 Sep 2006 11:43:56.0532 (UTC) FILETIME=[0F989340:01C6D7F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080403080401020001010804
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

please see the following patch against the CCISS driver (HP/Compaq
SmartArray Controllers).
It removes the awkward spaces after the "=" when displaying the
geometry of the attached volumes (and saves 5 bytes of kernel ;)

Before:
cciss: using DAC cycles
     blocks= 286734240 block_size= 512
     heads= 255, sectors= 32, cylinders= 35139

After:
cciss: using DAC cycles
     blocks=286734240 block_size=512
     heads=255, sectors=32, cylinders=35139


The following is against 2.6.18-rc6.
Cheers,
M.


--------------080403080401020001010804
Content-Type: text/plain;
 name="cciss-space-patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cciss-space-patch.diff"

Signed-off by: Metathronius Galabant <m.galabant@gmail.com>


diff -ru linux-2.6.18-rc6/drivers/block/cciss.c linux-2.6.18-rc6-f/drivers/block/cciss.c
--- linux-2.6.18-rc6/drivers/block/cciss.c	2006-09-11 15:57:54.000000000 +0200
+++ linux-2.6.18-rc6-f/drivers/block/cciss.c	2006-09-11 16:32:42.000000000 +0200
@@ -1934,7 +1934,7 @@
 	} else {		/* Get geometry failed */
 		printk(KERN_WARNING "cciss: reading geometry failed\n");
 	}
-	printk(KERN_INFO "      heads= %d, sectors= %d, cylinders= %d\n\n",
+	printk(KERN_INFO "      heads=%d, sectors=%d, cylinders=%d\n\n",
 	       drv->heads, drv->sectors, drv->cylinders);
 }
 
@@ -1962,7 +1962,7 @@
 		*total_size = 0;
 		*block_size = BLOCK_SIZE;
 	}
-	printk(KERN_INFO "      blocks= %u block_size= %d\n",
+	printk(KERN_INFO "      blocks=%u block_size=%d\n",
 	       *total_size, *block_size);
 	return;
 }





--------------080403080401020001010804--
