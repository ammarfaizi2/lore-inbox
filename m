Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266936AbSLKGTc>; Wed, 11 Dec 2002 01:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266964AbSLKGTb>; Wed, 11 Dec 2002 01:19:31 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:38417
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S266936AbSLKGTa>; Wed, 11 Dec 2002 01:19:30 -0500
Subject: [PATCH] epoll: don't printk pointer value
From: Robert Love <rml@tech9.net>
To: davidel@xmailserver.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1039588045.833.3.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 11 Dec 2002 01:27:25 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide,

I really cannot think of a good reason why eventpoll_init() should print
a pointer value to user-space - especially the value of current?

I do not think this is good practice and someone might even consider it
a security hole.  Personally, I would prefer to remove the "successfully
initialized" message altogether, but at the very least can we not print
current's address?

	Robert Love


 fs/eventpoll.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -urN linux-2.5.51/fs/eventpoll.c linux/fs/eventpoll.c
--- linux-2.5.51/fs/eventpoll.c	2002-12-09 21:45:54.000000000 -0500
+++ linux/fs/eventpoll.c	2002-12-11 01:23:07.000000000 -0500
@@ -1573,7 +1573,7 @@
 	if (IS_ERR(eventpoll_mnt))
 		goto eexit_4;
 
-	printk(KERN_INFO "[%p] eventpoll: successfully initialized.\n", current);
+	printk(KERN_INFO "eventpoll: successfully initialized.\n", current);
 
 	return 0;
 



