Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130359AbQKKJmN>; Sat, 11 Nov 2000 04:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130368AbQKKJmD>; Sat, 11 Nov 2000 04:42:03 -0500
Received: from [62.172.234.2] ([62.172.234.2]:43943 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S130359AbQKKJlz>;
	Sat, 11 Nov 2000 04:41:55 -0500
Date: Sat, 11 Nov 2000 09:42:50 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch-2.4.0-test11-pre2] proc_pid_stat() optimization
Message-ID: <Pine.LNX.4.21.0011110941080.943-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

No task (even init_task) can ever have task->rlim == NULL because that is
statically allocated whenever task_struct is allocated -- hence the check
in fs/proc/array.c:proc_pid_stat() is redundant.

Tested under 2.4.0-test11-pre2

Regards,
Tigran

--- linux/fs/proc/array.c	Mon Oct 30 22:28:06 2000
+++ work/fs/proc/array.c	Sat Nov 11 09:35:17 2000
@@ -372,7 +372,7 @@
 		task->start_time,
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
-		task->rlim ? task->rlim[RLIMIT_RSS].rlim_cur : 0,
+		task->rlim[RLIMIT_RSS].rlim_cur,
 		mm ? mm->start_code : 0,
 		mm ? mm->end_code : 0,
 		mm ? mm->start_stack : 0,

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
