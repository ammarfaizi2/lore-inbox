Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264495AbTFVXqa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 19:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbTFVXqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 19:46:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12306 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264495AbTFVXq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 19:46:29 -0400
Date: Mon, 23 Jun 2003 01:00:31 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@cambridge.redhat.com>
Subject: [PATCH] Fix mtdblock / mtdpart / mtdconcat
Message-ID: <20030623010031.E16537@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	David Woodhouse <dwmw2@cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dirtily disable ECC support; it doesn't work when mtdpart is layered
on top of mtdconcat on top of CFI flash.

There is probably a better fix, but that's for someone else to find.

--- orig/drivers/mtd/mtdpart.c	Sat Jun 14 22:33:58 2003
+++ linux/drivers/mtd/mtdpart.c	Mon Jun 23 00:55:04 2003
@@ -55,12 +55,12 @@
 		len = 0;
 	else if (from + len > mtd->size)
 		len = mtd->size - from;
-	if (part->master->read_ecc == NULL)	
+//	if (part->master->read_ecc == NULL)	
 		return part->master->read (part->master, from + part->offset, 
 					len, retlen, buf);
-	else
-		return part->master->read_ecc (part->master, from + part->offset, 
-					len, retlen, buf, NULL, &mtd->oobinfo);
+//	else
+//		return part->master->read_ecc (part->master, from + part->offset, 
+//					len, retlen, buf, NULL, &mtd->oobinfo);
 }
 
 static int part_point (struct mtd_info *mtd, loff_t from, size_t len, 
@@ -134,12 +134,12 @@
 		len = 0;
 	else if (to + len > mtd->size)
 		len = mtd->size - to;
-	if (part->master->write_ecc == NULL)	
+//	if (part->master->write_ecc == NULL)	
 		return part->master->write (part->master, to + part->offset, 
 					len, retlen, buf);
-	else
-		return part->master->write_ecc (part->master, to + part->offset, 
-					len, retlen, buf, NULL, &mtd->oobinfo);
+//	else
+//		return part->master->write_ecc (part->master, to + part->offset, 
+//					len, retlen, buf, NULL, &mtd->oobinfo);
 							
 }
 

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

