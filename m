Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262669AbTCIXgh>; Sun, 9 Mar 2003 18:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262670AbTCIXgh>; Sun, 9 Mar 2003 18:36:37 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:42854
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262669AbTCIXgf>; Sun, 9 Mar 2003 18:36:35 -0500
Date: Sun, 9 Mar 2003 18:44:47 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] small fixes in brlock.h
Message-ID: <Pine.LNX.4.50.0303091843250.1464-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.64-unwashed/include/linux/brlock.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/include/linux/brlock.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 brlock.h
--- linux-2.5.64-unwashed/include/linux/brlock.h	5 Mar 2003 05:07:54 -0000	1.1.1.1
+++ linux-2.5.64-unwashed/include/linux/brlock.h	9 Mar 2003 23:42:26 -0000
@@ -85,8 +85,7 @@
 	if (idx >= __BR_END)
 		__br_lock_usage_bug();
 
-	preempt_disable();
-	_raw_read_lock(&__brlock_array[smp_processor_id()][idx]);
+	read_lock(&__brlock_array[smp_processor_id()][idx]);
 }
 
 static inline void br_read_unlock (enum brlock_indices idx)
@@ -202,7 +201,7 @@
 	do { local_bh_disable(); br_write_lock(idx); } while (0)
 
 #define br_read_unlock_irqrestore(idx, flags) \
-	do { br_read_unlock(irx); local_irq_restore(flags); } while (0)
+	do { br_read_unlock(idx); local_irq_restore(flags); } while (0)
 
 #define br_read_unlock_irq(idx) \
 	do { br_read_unlock(idx); local_irq_enable(); } while (0)
@@ -211,7 +210,7 @@
 	do { br_read_unlock(idx); local_bh_enable(); } while (0)
 
 #define br_write_unlock_irqrestore(idx, flags) \
-	do { br_write_unlock(irx); local_irq_restore(flags); } while (0)
+	do { br_write_unlock(idx); local_irq_restore(flags); } while (0)
 
 #define br_write_unlock_irq(idx) \
 	do { br_write_unlock(idx); local_irq_enable(); } while (0)

-- 
function.linuxpower.ca
