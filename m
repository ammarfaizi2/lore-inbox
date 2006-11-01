Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWKAXPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWKAXPR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWKAXPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:15:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2757 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750945AbWKAXPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:15:15 -0500
Date: Wed, 1 Nov 2006 18:15:10 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: More list debugging context.
Message-ID: <20061101231510.GA17479@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Print the other (hopefully) known good pointer when list_head
debugging too, which may yield additional clues.

Also fix for 80-columns to win akpm brownie points.

Signed-off-by: Dave Jones <davej@redhat.com>


diff --git a/lib/list_debug.c b/lib/list_debug.c
index 7ba9d82..4350ba9 100644
--- a/lib/list_debug.c
+++ b/lib/list_debug.c
@@ -21,13 +21,15 @@ void __list_add(struct list_head *new,
 			      struct list_head *next)
 {
 	if (unlikely(next->prev != prev)) {
-		printk(KERN_ERR "list_add corruption. next->prev should be %p, but was %p\n",
-			prev, next->prev);
+		printk(KERN_ERR "list_add corruption. next->prev should be "
+			"prev (%p), but was %p. (next=%p).\n",
+			prev, next->prev, next);
 		BUG();
 	}
 	if (unlikely(prev->next != next)) {
-		printk(KERN_ERR "list_add corruption. prev->next should be %p, but was %p\n",
-			next, prev->next);
+		printk(KERN_ERR "list_add corruption. prev->next should be "
+			"next (%p), but was %p. (prev=%p).\n",
+			next, prev->next, prev);
 		BUG();
 	}
 	next->prev = new;
-- 
http://www.codemonkey.org.uk
