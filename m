Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWJVXiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWJVXiK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 19:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWJVXiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 19:38:09 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:14013 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1750785AbWJVXiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 19:38:07 -0400
Subject: [PATCH] Cleanup whitespace in freezer output.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 09:38:05 +1000
Message-Id: <1161560285.7438.60.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor whitespace and formatting modifications for the freezer.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

diff --git a/kernel/power/process.c b/kernel/power/process.c
index b0edfc6..fedabad 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -86,7 +86,7 @@ int freeze_processes(void)
 	unsigned long start_time;
 	struct task_struct *g, *p;
 
-	printk( "Stopping tasks: " );
+	printk("Stopping tasks... ");
 	start_time = jiffies;
 	user_frozen = 0;
 	do {
@@ -134,21 +134,21 @@ int freeze_processes(void)
 	 * but it cleans up leftover PF_FREEZE requests.
 	 */
 	if (todo) {
-		printk( "\n" );
-		printk(KERN_ERR " stopping tasks timed out "
+		printk("\n");
+		printk(KERN_ERR "Stopping tasks timed out "
 			"after %d seconds (%d tasks remaining):\n",
 			TIMEOUT / HZ, todo);
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
 			if (freezeable(p) && !frozen(p))
-				printk(KERN_ERR "  %s\n", p->comm);
+				printk(KERN_ERR " %s\n", p->comm);
 			cancel_freezing(p);
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
 		return todo;
 	}
 
-	printk( "|\n" );
+	printk("done.\n");
 	BUG_ON(in_atomic());
 	return 0;
 }
@@ -157,18 +157,18 @@ void thaw_processes(void)
 {
 	struct task_struct *g, *p;
 
-	printk( "Restarting tasks..." );
+	printk("Restarting tasks... ");
 	read_lock(&tasklist_lock);
 	do_each_thread(g, p) {
 		if (!freezeable(p))
 			continue;
 		if (!thaw_process(p))
-			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
+			printk(KERN_INFO "Strange, %s not stopped\n", p->comm);
 	} while_each_thread(g, p);
 
 	read_unlock(&tasklist_lock);
 	schedule();
-	printk( " done\n" );
+	printk("done.\n");
 }
 
 EXPORT_SYMBOL(refrigerator);


