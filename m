Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265756AbTF3EIO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 00:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265796AbTF3EGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 00:06:48 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:11268 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265801AbTF3EED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 00:04:03 -0400
Subject: [PATCH] update show_stack() in voyager for new prototype
From: James Bottomley <James.Bottomley@steeleye.com>
To: torvalds@transmeta.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 29 Jun 2003 23:18:19 -0500
Message-Id: <1056946701.10896.411.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When show_stack() was changed to take two arguments, the use in the
voyager code was not converted.  This patch makes the correct
conversion.

James

===== arch/i386/mach-voyager/voyager_basic.c 1.2 vs edited =====
--- 1.2/arch/i386/mach-voyager/voyager_basic.c	Sat Dec 28 11:15:35 2002
+++ edited/arch/i386/mach-voyager/voyager_basic.c	Sun Jun 29 21:18:29 2003
@@ -284,7 +284,6 @@
 {
 	__u8 dumpval __attribute__((unused)) = inb(0xf823);
 	__u8 swnmi __attribute__((unused)) = inb(0xf813);
-	extern void show_stack(unsigned long *);
 
 	/* FIXME: assume dump switch pressed */
 	/* check to see if the dump switch was pressed */
@@ -302,7 +301,7 @@
 		}
 	}
 	printk(KERN_ERR "VOYAGER: Dump switch pressed, printing CPU%d tracebacks\n", smp_processor_id());
-	show_stack(NULL);
+	show_stack(NULL, NULL);
 	show_state();
 }
 


