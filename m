Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265708AbUA0TMJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 14:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265742AbUA0TMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 14:12:09 -0500
Received: from mail.ccur.com ([208.248.32.212]:62477 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S265708AbUA0TMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 14:12:06 -0500
Date: Tue, 27 Jan 2004 14:11:55 -0500
From: Joe Korty <joe.korty@ccur.com>
To: dhowells@redhat.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] volatile may be needed in rwsem
Message-ID: <20040127191155.GA12128@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'flags' should be declared volatile as rwsem_down_failed_common() spins
waiting for this to change.  Untested.

Against 2.6.1.


diff -Nua 2.6/lib/rwsem-spinlock.c.0 2.6/lib/rwsem-spinlock.c
--- 2.6/lib/rwsem-spinlock.c.0	2004-01-27 14:03:46.000000000 -0500
+++ 2.6/lib/rwsem-spinlock.c	2004-01-27 14:03:38.000000000 -0500
@@ -12,7 +12,7 @@
 struct rwsem_waiter {
 	struct list_head	list;
 	struct task_struct	*task;
-	unsigned int		flags;
+	volatile unsigned int	flags;
 #define RWSEM_WAITING_FOR_READ	0x00000001
 #define RWSEM_WAITING_FOR_WRITE	0x00000002
 };
diff -Nua 2.6/lib/rwsem.c.0 2.6/lib/rwsem.c
--- 2.6/lib/rwsem.c.0	2004-01-27 14:03:46.000000000 -0500
+++ 2.6/lib/rwsem.c	2004-01-27 14:03:19.000000000 -0500
@@ -10,7 +10,7 @@
 struct rwsem_waiter {
 	struct list_head	list;
 	struct task_struct	*task;
-	unsigned int		flags;
+	volatile unsigned int	flags;
 #define RWSEM_WAITING_FOR_READ	0x00000001
 #define RWSEM_WAITING_FOR_WRITE	0x00000002
 };

