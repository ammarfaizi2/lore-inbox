Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266664AbUGKXG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266664AbUGKXG1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 19:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266665AbUGKXG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 19:06:26 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:17117 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266664AbUGKXGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 19:06:24 -0400
Date: Mon, 12 Jul 2004 01:06:15 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Oleg Drokin <green@clusterfs.com>, linux-kernel@vger.kernel.org,
       braam@clusterfs.com
Subject: [2.6 patch] #ifndef guard percpu_counter.h and blockgroup_lock.h
Message-ID: <20040711230615.GF4701@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Insert header guards to allow possible multiple inclusion for
include/linux/percpu_counter.h and include/linux/blockgroup_lock.h

This patch is basically
  [6/9] Lustre VFS patches for 2.6
by Oleg Drokin <green@clusterfs.com> with the exception that I put the 
#ifndef's before the initial comments.

Independent of the Lustre discussions this patch seems to be a good 
idea.

diffstat output:
 include/linux/blockgroup_lock.h |    4 +++-
 include/linux/percpu_counter.h  |    4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm7-full/include/linux/percpu_counter.h.old	2004-07-12 00:58:09.000000000 +0200
+++ linux-2.6.7-mm7-full/include/linux/percpu_counter.h	2004-07-12 01:01:11.000000000 +0200
@@ -1,3 +1,5 @@
+#ifndef _LINUX_PERCPU_COUNTER_H
+#define _LINUX_PERCPU_COUNTER_H
 /*
  * A simple "approximate counter" for use in ext2 and ext3 superblocks.
  *
@@ -101,3 +103,5 @@
 {
 	percpu_counter_mod(fbc, -1);
 }
+
+#endif /* _LINUX_PERCPU_COUNTER_H */
--- linux-2.6.7-mm7-full/include/linux/blockgroup_lock.h.old	2004-07-12 00:59:38.000000000 +0200
+++ linux-2.6.7-mm7-full/include/linux/blockgroup_lock.h	2004-07-12 01:01:17.000000000 +0200
@@ -1,3 +1,5 @@
+#ifndef _LINUX_BLOCKGROUP_LOCK_H
+#define _LINUX_BLOCKGROUP_LOCK_H
 /*
  * Per-blockgroup locking for ext2 and ext3.
  *
@@ -55,4 +57,4 @@
 #define sb_bgl_lock(sb, block_group) \
 	(&(sb)->s_blockgroup_lock.locks[(block_group) & (NR_BG_LOCKS-1)].lock)
 
-
+#endif
