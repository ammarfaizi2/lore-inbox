Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268301AbUIPXuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268301AbUIPXuc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268333AbUIPXub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:50:31 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:48616 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S268301AbUIPXti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:49:38 -0400
Subject: [PATCH] Suspend2 Merge: Supress various actions/errors while
	suspending [1/5]
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095378660.5897.98.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 17 Sep 2004 09:51:03 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1:

Disable the OOM killer while suspend is running.

Regards,

Nigel

diff -ruN linux-2.6.9-rc1/mm/oom_kill.c software-suspend-linux-2.6.9-rc1-rev3/mm/oom_kill.c
--- linux-2.6.9-rc1/mm/oom_kill.c	2004-09-07 21:59:01.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/mm/oom_kill.c	2004-09-09 19:36:24.000000000 +1000
@@ -20,6 +20,7 @@
 #include <linux/swap.h>
 #include <linux/timex.h>
 #include <linux/jiffies.h>
+#include <linux/suspend.h>
 
 /* #define DEBUG */
 
@@ -230,6 +231,10 @@
 	static unsigned long first, last, count, lastkill;
 	unsigned long now, since;
 
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+	if (software_suspend_state & SOFTWARE_SUSPEND_RUNNING)
+		return;
+#endif
 	spin_lock(&oom_lock);
 	now = jiffies;
 	since = now - last;

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

