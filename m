Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263071AbVHET5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbVHET5o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 15:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbVHET5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 15:57:44 -0400
Received: from mato.luukku.com ([193.209.83.251]:24230 "EHLO mato.luukku.com")
	by vger.kernel.org with ESMTP id S263071AbVHETzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 15:55:36 -0400
Date: Fri, 5 Aug 2005 22:55:21 +0300
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH] Minor fix to kernel/workqueue.c
Message-ID: <20050805195521.GA21058@miku.homelinux.net>
Reply-To: mikukkon@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: mikukkon@miku.homelinux.net (Mika Kukkonen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With "-W -Wno-unused -Wno-sign-compare" I get the following compile warning:

  CC      kernel/workqueue.o
kernel/workqueue.c: In function `workqueue_cpu_callback':
kernel/workqueue.c:504: warning: ordered comparison of pointer with integer zero

On error create_workqueue_thread() returns NULL, not negative pointer
(duh!), so following trivial patch suggests itself.

Signed-off-by: Mika Kukkonen <mikukkon@gmail.com>

--- linux-2.6.orig/kernel/workqueue.c	2005-08-03 22:17:33.296479048 +0300
+++ linux-2.6/kernel/workqueue.c	2005-08-03 22:30:11.960984648 +0300
@@ -501,7 +501,7 @@
 	case CPU_UP_PREPARE:
 		/* Create a new workqueue thread for it. */
 		list_for_each_entry(wq, &workqueues, list) {
-			if (create_workqueue_thread(wq, hotcpu) < 0) {
+			if (!create_workqueue_thread(wq, hotcpu)) {
 				printk("workqueue for %i failed\n", hotcpu);
 				return NOTIFY_BAD;
 			}
