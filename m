Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285618AbSAAWPQ>; Tue, 1 Jan 2002 17:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285630AbSAAWPG>; Tue, 1 Jan 2002 17:15:06 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:18447 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S285618AbSAAWO4>; Tue, 1 Jan 2002 17:14:56 -0500
Date: Tue, 1 Jan 2002 14:18:24 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: lkml <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] sleep_time task_struct removal ...
Message-ID: <Pine.LNX.4.40.0201011416320.1456-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, this field is unused and waste cache line space.



- Davide




--- sched.h	Tue Jan  1 14:13:25 2002
+++ sched.new.h	Tue Jan  1 14:14:28 2002
@@ -322,7 +322,6 @@
 	 */
 	struct list_head run_list;
 	long time_slice;
-	unsigned long sleep_time;
 	/* recalculation loop checkpoint */
 	unsigned long rcl_last;

@@ -885,7 +884,6 @@
 static inline void del_from_runqueue(struct task_struct * p)
 {
 	nr_running--;
-	p->sleep_time = jiffies;
 	list_del(&p->run_list);
 	p->run_list.next = NULL;
 }


