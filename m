Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262720AbVAQITa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbVAQITa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 03:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVAQISz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 03:18:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25357 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262720AbVAQINp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 03:13:45 -0500
Date: Mon, 17 Jan 2005 09:13:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: faith@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/audit.c: make some functions static
Message-ID: <20050117081340.GA4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global functions static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>


---

diffstat output:
 include/linux/audit.h |   12 ------------
 kernel/audit.c        |   17 ++++++++++-------
 2 files changed, 10 insertions(+), 19 deletions(-)

This patch was already sent on:
- 12 Dec 2004

--- linux-2.6.10-rc2-mm4-full/include/linux/audit.h.old	2004-12-12 02:41:04.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/audit.h	2004-12-12 02:42:48.000000000 +0100
@@ -177,16 +177,10 @@
 					     const char *fmt, ...)
 			    __attribute__((format(printf,2,3)));
 extern void		    audit_log_end(struct audit_buffer *ab);
-extern void		    audit_log_end_fast(struct audit_buffer *ab);
-extern void		    audit_log_end_irq(struct audit_buffer *ab);
 extern void		    audit_log_d_path(struct audit_buffer *ab,
 					     const char *prefix,
 					     struct dentry *dentry,
 					     struct vfsmount *vfsmnt);
-extern int		    audit_set_rate_limit(int limit);
-extern int		    audit_set_backlog_limit(int limit);
-extern int		    audit_set_enabled(int state);
-extern int		    audit_set_failure(int state);
 
 				/* Private API (for auditsc.c only) */
 extern void		    audit_send_reply(int pid, int seq, int type,
@@ -199,13 +193,7 @@
 #define audit_log_vformat(b,f,a) do { ; } while (0)
 #define audit_log_format(b,f,...) do { ; } while (0)
 #define audit_log_end(b) do { ; } while (0)
-#define audit_log_end_fast(b) do { ; } while (0)
-#define audit_log_end_irq(b) do { ; } while (0)
 #define audit_log_d_path(b,p,d,v) do { ; } while (0)
-#define audit_set_rate_limit(l) do { ; } while (0)
-#define audit_set_backlog_limit(l) do { ; } while (0)
-#define audit_set_enabled(s) do { ; } while (0)
-#define audit_set_failure(s) do { ; } while (0)
 #endif
 #endif
 #endif
--- linux-2.6.10-rc2-mm4-full/kernel/audit.c.old	2004-12-12 02:40:08.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/kernel/audit.c	2004-12-12 02:42:52.000000000 +0100
@@ -150,6 +150,9 @@
 	struct audit_rule rule;
 };
 
+static void audit_log_end_irq(struct audit_buffer *ab);
+static void audit_log_end_fast(struct audit_buffer *ab);
+
 static void audit_panic(const char *message)
 {
 	switch (audit_failure)
@@ -231,7 +234,7 @@
 
 }
 
-int audit_set_rate_limit(int limit)
+static int audit_set_rate_limit(int limit)
 {
 	int old		 = audit_rate_limit;
 	audit_rate_limit = limit;
@@ -240,7 +243,7 @@
 	return old;
 }
 
-int audit_set_backlog_limit(int limit)
+static int audit_set_backlog_limit(int limit)
 {
 	int old		 = audit_backlog_limit;
 	audit_backlog_limit = limit;
@@ -249,7 +252,7 @@
 	return old;
 }
 
-int audit_set_enabled(int state)
+static int audit_set_enabled(int state)
 {
 	int old		 = audit_enabled;
 	if (state != 0 && state != 1)
@@ -260,7 +263,7 @@
 	return old;
 }
 
-int audit_set_failure(int state)
+static int audit_set_failure(int state)
 {
 	int old		 = audit_failure;
 	if (state != AUDIT_FAIL_SILENT
@@ -523,7 +526,7 @@
 }
 
 /* Initialize audit support at boot time. */
-int __init audit_init(void)
+static int __init audit_init(void)
 {
 	printk(KERN_INFO "audit: initializing netlink socket (%s)\n",
 	       audit_default ? "enabled" : "disabled");
@@ -744,7 +747,7 @@
  * the audit buffer is places on a queue and a tasklet is scheduled to
  * remove them from the queue outside the irq context.  May be called in
  * any context. */
-void audit_log_end_irq(struct audit_buffer *ab)
+static void audit_log_end_irq(struct audit_buffer *ab)
 {
 	unsigned long flags;
 
@@ -759,7 +762,7 @@
 
 /* Send the message in the audit buffer directly to user space.  May not
  * be called in an irq context. */
-void audit_log_end_fast(struct audit_buffer *ab)
+static void audit_log_end_fast(struct audit_buffer *ab)
 {
 	unsigned long flags;
 

