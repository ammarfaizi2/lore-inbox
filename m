Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWEJC4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWEJC4M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWEJC4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:56:12 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:37437 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932382AbWEJC4L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:56:11 -0400
Date: Tue, 9 May 2006 19:56:04 -0700
Message-Id: <200605100256.k4A2u4FO031737@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] mtd redboot (also gcc 4.1 warning fix)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

unsigned long may not always be 32 bits, right ? This patch fixes the 
warning, but not the bug .

Fixes the following warning,

drivers/mtd/redboot.c: In function 'parse_redboot_partitions':
drivers/mtd/redboot.c:103: warning: passing argument 1 of '__swab32s' from incompatible pointer type
drivers/mtd/redboot.c:104: warning: passing argument 1 of '__swab32s' from incompatible pointer type
drivers/mtd/redboot.c:105: warning: passing argument 1 of '__swab32s' from incompatible pointer type
drivers/mtd/redboot.c:106: warning: passing argument 1 of '__swab32s' from incompatible pointer type
drivers/mtd/redboot.c:107: warning: passing argument 1 of '__swab32s' from incompatible pointer type
drivers/mtd/redboot.c:108: warning: passing argument 1 of '__swab32s' from incompatible pointer type
drivers/mtd/redboot.c:109: warning: passing argument 1 of '__swab32s' from incompatible pointer type

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/drivers/mtd/redboot.c
===================================================================
--- linux-2.6.16.orig/drivers/mtd/redboot.c
+++ linux-2.6.16/drivers/mtd/redboot.c
@@ -100,13 +100,13 @@ static int parse_redboot_partitions(stru
 					/* The unsigned long fields were written with the
 					 * wrong byte sex, name and pad have no byte sex.
 					 */
-					swab32s(&buf[j].flash_base);
-					swab32s(&buf[j].mem_base);
-					swab32s(&buf[j].size);
-					swab32s(&buf[j].entry_point);
-					swab32s(&buf[j].data_length);
-					swab32s(&buf[j].desc_cksum);
-					swab32s(&buf[j].file_cksum);
+					swab32s((unsigned int *)&buf[j].flash_base);
+					swab32s((unsigned int *)&buf[j].mem_base);
+					swab32s((unsigned int *)&buf[j].size);
+					swab32s((unsigned int *)&buf[j].entry_point);
+					swab32s((unsigned int *)&buf[j].data_length);
+					swab32s((unsigned int *)&buf[j].desc_cksum);
+					swab32s((unsigned int *)&buf[j].file_cksum);
 				}
 			}
 			break;
