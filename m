Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbVLLXqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVLLXqQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVLLXqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:46:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30627 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932236AbVLLXqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:46:14 -0500
Date: Mon, 12 Dec 2005 23:45:49 GMT
Message-Id: <200512122345.jBCNjnuE009057@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 16/19] MUTEX: IPC changes
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch modifies the IPC files to use the new mutex functions.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-ipc-2615rc5.diff
 ipc/compat.c |    2 +-
 ipc/util.c   |    2 +-
 ipc/util.h   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15-rc5/ipc/compat.c linux-2.6.15-rc5-mutex/ipc/compat.c
--- /warthog/kernels/linux-2.6.15-rc5/ipc/compat.c	2005-11-01 13:19:22.000000000 +0000
+++ linux-2.6.15-rc5-mutex/ipc/compat.c	2005-12-12 22:12:50.000000000 +0000
@@ -29,8 +29,8 @@
 #include <linux/shm.h>
 #include <linux/slab.h>
 #include <linux/syscalls.h>
+#include <linux/semaphore.h>
 
-#include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
 #include "util.h"
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/ipc/util.c linux-2.6.15-rc5-mutex/ipc/util.c
--- /warthog/kernels/linux-2.6.15-rc5/ipc/util.c	2005-12-08 16:23:55.000000000 +0000
+++ linux-2.6.15-rc5-mutex/ipc/util.c	2005-12-12 17:40:08.000000000 +0000
@@ -67,7 +67,7 @@ __initcall(ipc_init);
 void __init ipc_init_ids(struct ipc_ids* ids, int size)
 {
 	int i;
-	sema_init(&ids->sem,1);
+	init_MUTEX(&ids->sem);
 
 	if(size > IPCMNI)
 		size = IPCMNI;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/ipc/util.h linux-2.6.15-rc5-mutex/ipc/util.h
--- /warthog/kernels/linux-2.6.15-rc5/ipc/util.h	2005-11-01 13:19:22.000000000 +0000
+++ linux-2.6.15-rc5-mutex/ipc/util.h	2005-12-12 17:39:49.000000000 +0000
@@ -25,7 +25,7 @@ struct ipc_ids {
 	int max_id;
 	unsigned short seq;
 	unsigned short seq_max;
-	struct semaphore sem;	
+	struct mutex sem;	
 	struct ipc_id_ary nullentry;
 	struct ipc_id_ary* entries;
 };
