Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbVASLTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVASLTw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 06:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVASLTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 06:19:51 -0500
Received: from verein.lst.de ([213.95.11.210]:1492 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261688AbVASLTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 06:19:50 -0500
Date: Wed, 19 Jan 2005 12:19:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix INIT_SIGHAND warning on mips
Message-ID: <20050119111937.GA10548@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sa_handler isn't the first member of struct sigaction on mips.
Use C99 initializers to avoid a compiler warning.  (There don't
seem to be more serious problems as mips worked with that warning
for ages)


--- 1.33/include/linux/init_task.h	2005-01-05 03:48:20 +01:00
+++ edited/include/linux/init_task.h	2005-01-16 11:55:59 +01:00
@@ -54,10 +54,10 @@
 	.rlim		= INIT_RLIMITS,					\
 }
 
-#define INIT_SIGHAND(sighand) {	\
-	.count		= ATOMIC_INIT(1), 		\
-	.action		= { {{NULL,}}, },		\
-	.siglock	= SPIN_LOCK_UNLOCKED, 		\
+#define INIT_SIGHAND(sighand) {						\
+	.count		= ATOMIC_INIT(1), 				\
+	.action		= { { { .sa_handler = NULL, } }, },		\
+	.siglock	= SPIN_LOCK_UNLOCKED, 				\
 }
 
 extern struct group_info init_groups;
