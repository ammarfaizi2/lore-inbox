Return-Path: <linux-kernel-owner+w=401wt.eu-S1426144AbWLHTOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426144AbWLHTOV (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 14:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426145AbWLHTOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 14:14:21 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:34017 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1426144AbWLHTOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 14:14:20 -0500
Message-ID: <4579B554.5010701@student.ltu.se>
Date: Fri, 08 Dec 2006 19:56:20 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org, shaggy@austin.ibm.com
Subject: [PATCH] fs/jfs: fix error due to PF_* undeclared
References: <Pine.LNX.4.64.0611291411300.3513@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611291411300.3513@woody.osdl.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC [M]  fs/jfs/jfs_txnmgr.o
In file included from fs/jfs/jfs_txnmgr.c:49:
include/linux/freezer.h: In function ‘frozen’:
include/linux/freezer.h:9: error: dereferencing pointer to incomplete type
include/linux/freezer.h:9: error: ‘PF_FROZEN’ undeclared (first use in this function)
<snip>
fs/jfs/jfs_txnmgr.c: In function ‘freezing’:
include/linux/freezer.h:18: warning: control reaches end of non-void function
make[2]: *** [fs/jfs/jfs_txnmgr.o] Error 1
make[1]: *** [fs/jfs] Error 2
make: *** [fs] Error 2

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

Guess this is the desired fix, since including linux/sched.h in linux/freezer.h
make little sense.


diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index d558e51..2aee0a8 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -46,6 +46,7 @@ #include <linux/fs.h>
 #include <linux/vmalloc.h>
 #include <linux/smp_lock.h>
 #include <linux/completion.h>
+#include <linux/sched.h>
 #include <linux/freezer.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>

