Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262550AbVAJXMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbVAJXMA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 18:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbVAJXL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 18:11:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:32436 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262550AbVAJXLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 18:11:03 -0500
Date: Mon, 10 Jan 2005 14:58:37 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: paulkf@microgate.com
Cc: khc@pm.waw.pl, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] n_hdlc: fix module_param data type/warnings
Message-Id: <20050110145837.67521020.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linux 2.6.10-bk13

Fix gcc warning:
drivers/char/n_hdlc.c:979: warning: return from incompatible pointer type

module_param() for ssize_t is not supported.
Change to uint and fix other associated types.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/char/n_hdlc.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff -Naurp ./drivers/char/n_hdlc.c~nhdlc_types ./drivers/char/n_hdlc.c
--- ./drivers/char/n_hdlc.c~nhdlc_types	2005-01-10 12:17:58.318622256 -0800
+++ ./drivers/char/n_hdlc.c	2005-01-10 12:15:45.545806792 -0800
@@ -177,7 +177,7 @@ static struct n_hdlc *n_hdlc_alloc (void
 static int debuglevel;
 
 /* max frame size for memory allocations */
-static ssize_t maxframe = 4096;
+static uint maxframe = 4096;
 
 /* TTY callbacks */
 
@@ -657,7 +657,7 @@ static ssize_t n_hdlc_tty_write(struct t
 	struct n_hdlc_buf *tbuf;
 
 	if (debuglevel >= DEBUG_LEVEL_INFO)	
-		printk("%s(%d)n_hdlc_tty_write() called count=%Zd\n",
+		printk("%s(%d)n_hdlc_tty_write() called count=%zu\n",
 			__FILE__,__LINE__,count);
 		
 	/* Verify pointers */
@@ -672,8 +672,7 @@ static ssize_t n_hdlc_tty_write(struct t
 		if (debuglevel & DEBUG_LEVEL_INFO)
 			printk (KERN_WARNING
 				"n_hdlc_tty_write: truncating user packet "
-				"from %lu to %Zd\n", (unsigned long) count,
-				maxframe );
+				"from %zu to %u\n", count, maxframe );
 		count = maxframe;
 	}
 	
@@ -976,5 +975,5 @@ module_exit(n_hdlc_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul Fulghum paulkf@microgate.com");
 module_param(debuglevel, int, 0);
-module_param(maxframe, int, 0);
+module_param(maxframe, uint, 0);
 MODULE_ALIAS_LDISC(N_HDLC);

---
