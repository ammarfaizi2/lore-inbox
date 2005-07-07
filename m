Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbVGGWlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVGGWlX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 18:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbVGGWlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 18:41:17 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:15517 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262338AbVGGWjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 18:39:13 -0400
Date: Thu, 7 Jul 2005 15:39:06 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: mvw@planets.elm.net, akpm <akpm@osdl.org>
Subject: [PATCH] kernel/acct: add kerneldoc
Message-Id: <20050707153906.698c10b1.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Randy Dunlap <rdunlap@xenotime.net>

for kernel/acct.c:
- fix typos
- add kerneldoc for non-static functions

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

diffstat:=
 kernel/acct.c |   43 +++++++++++++++++++++++++++----------------
 1 files changed, 27 insertions(+), 16 deletions(-)

diff -Naurp linux-2613-rc1-git5/kernel/acct.c~kdoc_kernel_acct linux-2613-rc1-git5/kernel/acct.c
--- linux-2613-rc1-git5/kernel/acct.c~kdoc_kernel_acct	2005-06-17 12:48:29.000000000 -0700
+++ linux-2613-rc1-git5/kernel/acct.c	2005-07-06 12:01:40.000000000 -0700
@@ -165,7 +165,7 @@ out:
 }
 
 /*
- * Close the old accouting file (if currently open) and then replace
+ * Close the old accounting file (if currently open) and then replace
  * it with file (if non-NULL).
  *
  * NOTE: acct_globals.lock MUST be held on entry and exit.
@@ -199,11 +199,16 @@ static void acct_file_reopen(struct file
 	}
 }
 
-/*
- *  sys_acct() is the only system call needed to implement process
- *  accounting. It takes the name of the file where accounting records
- *  should be written. If the filename is NULL, accounting will be
- *  shutdown.
+/**
+ * sys_acct - enable/disable process accounting
+ * @name: file name for accounting records or NULL to shutdown accounting
+ *
+ * Returns 0 for success or negative errno values for failure.
+ *
+ * sys_acct() is the only system call needed to implement process
+ * accounting. It takes the name of the file where accounting records
+ * should be written. If the filename is NULL, accounting will be
+ * shutdown.
  */
 asmlinkage long sys_acct(const char __user *name)
 {
@@ -250,9 +255,12 @@ asmlinkage long sys_acct(const char __us
 	return (0);
 }
 
-/*
- * If the accouting is turned on for a file in the filesystem pointed
- * to by sb, turn accouting off.
+/**
+ * acct_auto_close - turn off a filesystem's accounting if it is on
+ * @sb: super block for the filesystem
+ *
+ * If the accounting is turned on for a file in the filesystem pointed
+ * to by sb, turn accounting off.
  */
 void acct_auto_close(struct super_block *sb)
 {
@@ -503,8 +511,11 @@ static void do_acct_process(long exitcod
 	set_fs(fs);
 }
 
-/*
+/**
  * acct_process - now just a wrapper around do_acct_process
+ * @exitcode: task exit code
+ *
+ * handles process accounting for an exiting task
  */
 void acct_process(long exitcode)
 {
@@ -530,9 +541,9 @@ void acct_process(long exitcode)
 }
 
 
-/*
- * acct_update_integrals
- *    -  update mm integral fields in task_struct
+/**
+ * acct_update_integrals - update mm integral fields in task_struct
+ * @tsk: task_struct for accounting
  */
 void acct_update_integrals(struct task_struct *tsk)
 {
@@ -547,9 +558,9 @@ void acct_update_integrals(struct task_s
 	}
 }
 
-/*
- * acct_clear_integrals
- *    - clear the mm integral fields in task_struct
+/**
+ * acct_clear_integrals - clear the mm integral fields in task_struct
+ * @tsk: task_struct whose accounting fields are cleared
  */
 void acct_clear_integrals(struct task_struct *tsk)
 {

---
