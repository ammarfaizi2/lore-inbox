Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVGRRyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVGRRyn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 13:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVGRRym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 13:54:42 -0400
Received: from Quebec-HSE-ppp231061.qc.sympatico.ca ([69.159.205.163]:12267
	"EHLO cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261465AbVGRRym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 13:54:42 -0400
Subject: Fix missing refrigerator invocation in jffs2.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Andrew Morton <akpm@osdl.org>, jffs-dev@axis.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121660092.13487.83.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 18 Jul 2005 14:14:53 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a patch to fix a missing refrigerator call in jffs2.

Regards,

Nigel

Signed-off by: Nigel Cunningham <nigel@suspend2.net>

 intrep.c |    3 +++
 1 files changed, 3 insertions(+)
diff -ruNp 235-jffs-intrep.patch-old/fs/jffs/intrep.c 235-jffs-intrep.patch-new/fs/jffs/intrep.c
--- 235-jffs-intrep.patch-old/fs/jffs/intrep.c	2005-07-18 06:36:59.000000000 +1000
+++ 235-jffs-intrep.patch-new/fs/jffs/intrep.c	2005-07-18 14:02:27.000000000 +1000
@@ -3397,6 +3397,9 @@ jffs_garbage_collect_thread(void *ptr)
 			siginfo_t info;
 			unsigned long signr = 0;
 
+			if (try_to_freeze())
+				continue;
+
 			spin_lock_irq(&current->sighand->siglock);
 			signr = dequeue_signal(current, &current->blocked, &info);
 			spin_unlock_irq(&current->sighand->siglock);

-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

