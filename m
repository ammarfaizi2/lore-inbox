Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263502AbTDHLfd (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 07:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263506AbTDHLfd (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 07:35:33 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:36889 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263502AbTDHLfb (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 07:35:31 -0400
Date: Tue, 8 Apr 2003 07:47:04 -0400
Message-Id: <200304081147.h38Bl4708752@devserv.devel.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, ext2-devel@lists.sourceforge.net
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 1/1] 2.4: Fix for jbd compiler warnings.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes two compiler warnings in jbd, one of which causes compile
failure under gcc-3.3.  (jbd.h fix from akpm.)

--- linux-2.4-ext3push/fs/jbd/revoke.c.=K0000=.orig
+++ linux-2.4-ext3push/fs/jbd/revoke.c
@@ -136,7 +136,7 @@ repeat:
 oom:
 	if (!journal_oom_retry)
 		return -ENOMEM;
-	jbd_debug(1, "ENOMEM in " __FUNCTION__ ", retrying.\n");
+	jbd_debug(1, "ENOMEM in %s, retrying.\n", __FUNCTION__);
 	yield();
 	goto repeat;
 }
--- linux-2.4-ext3push/include/linux/jbd.h.=K0000=.orig
+++ linux-2.4-ext3push/include/linux/jbd.h
@@ -281,7 +281,7 @@ void buffer_assertion_failure(struct buf
 	do {								     \
 		if (!(expr)) {						     \
 			printk(KERN_ERR "EXT3-fs unexpected failure: %s;\n", # expr); \
-			printk(KERN_ERR ## why);			     \
+			printk(KERN_ERR why);				     \
 		}							     \
 	} while (0)
 #define J_EXPECT(expr, why...)		__journal_expect(expr, ## why)
