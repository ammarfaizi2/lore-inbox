Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVGCWEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVGCWEw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 18:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVGCWEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 18:04:51 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27373 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261550AbVGCWEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 18:04:42 -0400
Date: Sun, 3 Jul 2005 23:59:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [swsusp] clean up process.c
Message-ID: <20050703215900.GA11344@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

freezeable() already tests for TRACED/STOPPED processes, no need to do
it twice.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit b72eba9d3b4dd4c73c6a545be67fcaffd9b3c845
tree 3f9611f7267d007c8c7960a492e842dff0c4f987
parent 674f73c9711fdc86c9c60adfefd5f88b32691edf
author <pavel@amd.(none)> Sun, 03 Jul 2005 23:58:28 +0200
committer <pavel@amd.(none)> Sun, 03 Jul 2005 23:58:28 +0200

 kernel/power/process.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -59,19 +59,17 @@ int freeze_processes(void)
 	int todo;
 	unsigned long start_time;
 	struct task_struct *g, *p;
-
+	unsigned long flags;
+	
 	printk( "Stopping tasks: " );
 	start_time = jiffies;
 	do {
 		todo = 0;
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
-			unsigned long flags;
 			if (!freezeable(p))
 				continue;
-			if ((frozen(p)) ||
-			    (p->state == TASK_TRACED) ||
-			    (p->state == TASK_STOPPED))
+			if (frozen(p))
 				continue;
 
 			freeze(p);

-- 
teflon -- maybe it is a trademark, but it should not be.
