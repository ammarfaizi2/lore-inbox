Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268281AbUIPX5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268281AbUIPX5m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268314AbUIPXy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:54:28 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:22251 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S268281AbUIPXvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:51:47 -0400
Subject: [PATCH] Suspend2 Merge: Supress various actions/errors while
	suspending [4/5]
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095378664.6537.104.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 17 Sep 2004 09:53:18 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Patch 4: Disable pdflush while suspending.

Regards,

Nigel

diff -ruN linux-2.6.9-rc1/mm/page-writeback.c software-suspend-linux-2.6.9-rc1-rev3/mm/page-writeback.c
--- linux-2.6.9-rc1/mm/page-writeback.c	2004-09-07 21:59:01.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/mm/page-writeback.c	2004-09-09 19:36:24.000000000 +1000
@@ -29,6 +29,7 @@
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
+#include <linux/suspend.h>
 
 /*
  * The maximum number of pages to writeout in a single bdflush/kupdate
@@ -369,6 +371,13 @@
 		.for_kupdate	= 1,
 	};
 
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+	if (software_suspend_state & SOFTWARE_SUSPEND_RUNNING) {
+		start_jif = jiffies;
+		next_jif = start_jif + (dirty_writeback_centisecs * HZ) / 100;
+		goto out;
+	}
+#endif
 	sync_supers();
 
 	get_writeback_state(&wbs);
@@ -389,6 +398,9 @@
 		}
 		nr_to_write -= MAX_WRITEBACK_PAGES - wbc.nr_to_write;
 	}
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+out:
+#endif
 	if (time_before(next_jif, jiffies + HZ))
 		next_jif = jiffies + HZ;
 	if (dirty_writeback_centisecs)

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

