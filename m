Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267427AbTBLOlR>; Wed, 12 Feb 2003 09:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267442AbTBLOlQ>; Wed, 12 Feb 2003 09:41:16 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:35555 "EHLO
	kleikamp.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S267427AbTBLOlP>; Wed, 12 Feb 2003 09:41:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Adrian Bunk <bunk@fs.tum.de>,
       James Lamanna <james.lamanna@appliedminds.com>
Subject: [PATCH - 2.5.60] JFS no longer compiles with gcc 2.95
Date: Wed, 12 Feb 2003 08:52:36 -0600
User-Agent: KMail/1.4.3
Cc: "'Linus Torvalds'" <torvalds@transmeta.com>,
       jfs-discussion@www-124.southbury.usf.ibm.com,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
References: <20030210204651.GE17128@fs.tum.de> <022f01c2d14d$71b46550$39140b0a@amthinking.net> <20030211072741.GF17128@fs.tum.de>
In-Reply-To: <20030211072741.GF17128@fs.tum.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302120852.36636.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure what's causing the problem, but Andrew Morton send me this 
patch which gets rid of the problem for him.  The fmt string that 
jfs_err() is invoked with is sufficient to identify the location, so 
__FILE__ and __LINE__ are not really needed anyway.

Linus, please apply.

Thanks,
Shaggy

diff -puN fs/jfs/jfs_debug.h~jfs-build-fix fs/jfs/jfs_debug.h
--- 25/fs/jfs/jfs_debug.h~jfs-build-fix	2003-02-12 02:20:40.000000000 
-0800
+++ 25-akpm/fs/jfs/jfs_debug.h	2003-02-12 02:20:46.000000000 -0800
@@ -89,8 +89,7 @@ extern void dump_mem(char *label, void *
 /* error event message: e.g., i/o error */
 #define jfs_err(fmt, arg...) do {			\
 	if (jfsloglevel >= JFS_LOGLEVEL_ERR)		\
-		printk(KERN_ERR "%s:%d " fmt "\n",	\
-		       __FILE__, __LINE__, ## arg);	\
+		printk(KERN_ERR fmt "\n", ## arg);	\
 } while (0)
 
 /*


-- 
David Kleikamp
IBM Linux Technology Center

