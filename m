Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265108AbUGGNCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbUGGNCG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 09:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265106AbUGGNAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 09:00:23 -0400
Received: from linuxhacker.ru ([217.76.32.60]:9687 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265107AbUGGMtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 08:49:45 -0400
Date: Wed, 7 Jul 2004 15:47:33 +0300
From: Oleg Drokin <green@clusterfs.com>
To: linux-kernel@vger.kernel.org, braam@clusterfs.com
Subject: [6/9] Lustre VFS patches for 2.6
Message-ID: <20040707124733.GA25956@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Insert header guards to allow possible multiple inclusion for
include/linux/percpu_counter.h and include/linux/blockgroup_lock.h

%diffstat
 blockgroup_lock.h |    4 +++-
 percpu_counter.h  |    4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

%patch
Index: linux-2.6.6/include/linux/percpu_counter.h
===================================================================
--- linux-2.6.6.orig/include/linux/percpu_counter.h	2004-04-04 11:37:23.000000000 +0800
+++ linux-2.6.6/include/linux/percpu_counter.h	2004-05-22 16:08:16.000000000 +0800
@@ -3,6 +3,8 @@
  *
  * WARNING: these things are HUGE.  4 kbytes per counter on 32-way P4.
  */
+#ifndef _LINUX_PERCPU_COUNTER_H
+#define _LINUX_PERCPU_COUNTER_H
 
 #include <linux/config.h>
 #include <linux/spinlock.h>
@@ -101,3 +103,5 @@ static inline void percpu_counter_dec(st
 {
 	percpu_counter_mod(fbc, -1);
 }
+
+#endif /* _LINUX_PERCPU_COUNTER_H */
Index: linux-2.6.6/include/linux/blockgroup_lock.h
===================================================================
--- linux-2.6.6.orig/include/linux/blockgroup_lock.h	2004-04-04 11:36:26.000000000 +0800
+++ linux-2.6.6/include/linux/blockgroup_lock.h	2004-05-22 16:08:45.000000000 +0800
@@ -3,6 +3,8 @@
  *
  * Simple hashed spinlocking.
  */
+#ifndef _LINUX_BLOCKGROUP_LOCK_H
+#define _LINUX_BLOCKGROUP_LOCK_H
 
 #include <linux/config.h>
 #include <linux/spinlock.h>
@@ -55,4 +57,4 @@ static inline void bgl_lock_init(struct 
 #define sb_bgl_lock(sb, block_group) \
 	(&(sb)->s_blockgroup_lock.locks[(block_group) & (NR_BG_LOCKS-1)].lock)
 
-
+#endif

