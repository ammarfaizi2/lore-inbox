Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268365AbUIPX5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268365AbUIPX5h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268281AbUIPXzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:55:00 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:24555 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S268304AbUIPXvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:51:50 -0400
Subject: [PATCH] Suspend2 Merge: Supress various actions/errors while
	suspending [5/5]
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095378666.6537.106.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 17 Sep 2004 09:53:20 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

Patch 5: Disable slab reaping during suspend.

Regards,

Nigel

diff -ruN 505-disable-cache-reaping-during-suspend-old/mm/slab.c 505-disable-cache-reaping-during-suspend-new/mm/slab.c
--- 505-disable-cache-reaping-during-suspend-old/mm/slab.c	2004-09-16 08:34:57.000000000 +1000
+++ 505-disable-cache-reaping-during-suspend-new/mm/slab.c	2004-09-16 09:22:20.000000000 +1000
@@ -92,6 +92,7 @@
 #include	<linux/sysctl.h>
 #include	<linux/module.h>
 #include	<linux/rcupdate.h>
+#include	<linux/suspend.h>
 
 #include	<asm/uaccess.h>
 #include	<asm/cacheflush.h>
@@ -2733,7 +2734,13 @@
 {
 	struct list_head *walk;
 
-	if (down_trylock(&cache_chain_sem)) {
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+	if ((software_suspend_state & SOFTWARE_SUSPEND_RUNNING) ||
+		(down_trylock(&cache_chain_sem))) 
+#else
+	if (down_trylock(&cache_chain_sem))
+#endif
+	{
 		/* Give up. Setup the next iteration. */
 		schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC + smp_processor_id());
 		return;

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

