Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132806AbRDWLDU>; Mon, 23 Apr 2001 07:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132805AbRDWLDK>; Mon, 23 Apr 2001 07:03:10 -0400
Received: from hitpro.hitachi.co.jp ([133.145.224.7]:59379 "EHLO
	hitpro.hitachi.co.jp") by vger.kernel.org with ESMTP
	id <S132801AbRDWLC4>; Mon, 23 Apr 2001 07:02:56 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH]Bug in lib/brlock.c
From: Takanori Kawano <t-kawano@ebina.hitachi.co.jp>
X-Mailer: Mew version 1.94.1 on Emacs 20.4 / Mule 4.1 (AOI)
Reply-To: t-kawano@ebina.hitachi.co.jp
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010423200112B.t-kawano@ebina.hitachi.co.jp>
Date: Mon, 23 Apr 2001 20:01:12 +0900 (JST)
X-Dispatcher: imput version 990905(IM130)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think lib/brlock.c need to be fixed as:

--- lib/brlock.c    Tue Apr 25 05:59:56 2000
+++ lib/brlock.c.fixed      Mon Apr 23 19:56:43 2001
@@ -25,7 +25,7 @@
        int i;

        for (i = 0; i < smp_num_cpus; i++)
-               write_lock(__brlock_array[idx] + cpu_logical_map(i));
+               write_lock(&__brlock_array[cpu_logical_map(i)][idx]);
 }

 void __br_write_unlock (enum brlock_indices idx)
@@ -33,7 +33,7 @@
        int i;

        for (i = 0; i < smp_num_cpus; i++)
-               write_unlock(__brlock_array[idx] + cpu_logical_map(i));
+               write_unlock(&__brlock_array[cpu_logical_map(i)][idx]);
 }

 #else /* ! __BRLOCK_USE_ATOMICS */


For the above, 2.4.1 kernel often panics on our socket onen/close 
stress testing.

regards,

---
Takanori Kawano
Hitachi Ltd,
Internet Systems Platform Division
t-kawano@ebina.hitachi.co.jp










