Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268333AbUIPXxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268333AbUIPXxi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268229AbUIPXvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:51:12 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:64232 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S268314AbUIPXtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:49:43 -0400
Subject: [PATCH] Suspend2 Merge: Supress various actions/errors while
	suspending [3/5]
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095378663.6537.102.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 17 Sep 2004 09:51:08 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Patch 3: Disable page alloc warnings while suspending.

Regards,

Nigel

diff -ruN linux-2.6.9-rc1/mm/page_alloc.c software-suspend-linux-2.6.9-rc1-rev3/mm/page_alloc.c
--- linux-2.6.9-rc1/mm/page_alloc.c	2004-09-07 21:59:01.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/mm/page_alloc.c	2004-09-09 19:36:24.000000000 +1000
@@ -731,6 +763,10 @@
 
 nopage:
 	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit()) {
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+		if (software_suspend_state & SOFTWARE_SUSPEND_RUNNING)
+			return NULL;
+#endif
 		printk(KERN_WARNING "%s: page allocation failure."
 			" order:%d, mode:0x%x\n",
 			p->comm, order, gfp_mask);

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

