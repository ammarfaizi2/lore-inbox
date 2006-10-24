Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752008AbWJXEsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbWJXEsG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 00:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbWJXEsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 00:48:06 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:61601 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1752008AbWJXEsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 00:48:04 -0400
Date: Mon, 23 Oct 2006 21:46:08 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: iss_storagedev@hp.com, lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH cciss: fix printk format warning
Message-Id: <20061023214608.f09074e9.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix printk format warnings:
drivers/block/cciss.c:2000: warning: long long int format, long unsigned int arg (arg 2)
drivers/block/cciss.c:2035: warning: long long int format, long unsigned int arg (arg 2)

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---

 drivers/block/cciss.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2619-rc3-pv.orig/drivers/block/cciss.c
+++ linux-2619-rc3-pv/drivers/block/cciss.c
@@ -1992,8 +1992,8 @@ cciss_read_capacity(int ctlr, int logvol
 		*block_size = BLOCK_SIZE;
 	}
 	if (*total_size != (__u32) 0)
-		printk(KERN_INFO "      blocks= %lld block_size= %d\n",
-		*total_size, *block_size);
+		printk(KERN_INFO "      blocks= %llu block_size= %d\n",
+		(unsigned long long)*total_size, *block_size);
 	kfree(buf);
 	return;
 }
@@ -2027,8 +2027,8 @@ cciss_read_capacity_16(int ctlr, int log
 		*total_size = 0;
 		*block_size = BLOCK_SIZE;
 	}
-	printk(KERN_INFO "      blocks= %lld block_size= %d\n",
-	       *total_size, *block_size);
+	printk(KERN_INFO "      blocks= %llu block_size= %d\n",
+	       (unsigned long long)*total_size, *block_size);
 	kfree(buf);
 	return;
 }


---
