Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267507AbTACMT0>; Fri, 3 Jan 2003 07:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267508AbTACMT0>; Fri, 3 Jan 2003 07:19:26 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:5575 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267507AbTACMTZ>; Fri, 3 Jan 2003 07:19:25 -0500
Date: Fri, 3 Jan 2003 13:27:44 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix 2.5 compiles w/o tcp/ip
Message-ID: <20030103122744.GB1360@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unix without TCP/IP is almost as gay as beer that comes in plastic bottles.
However, it should still compile.

Patch against 2.5-bkcurrent.

-- 
Tomas Szepe <szepe@pinerecords.com>


diff -urN a/net/core/skbuff.c b/net/core/skbuff.c
--- a/net/core/skbuff.c	2002-10-31 02:34:00.000000000 +0100
+++ b/net/core/skbuff.c	2003-01-03 13:09:54.000000000 +0100
@@ -324,7 +324,9 @@
 	}
 
 	dst_release(skb->dst);
+#ifdef CONFIG_INET
 	secpath_put(skb->sp);
+#endif
 	if(skb->destructor) {
 		if (in_irq())
 			printk(KERN_WARNING "Warning: kfree_skb on "
