Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030509AbWBHDUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030509AbWBHDUu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbWBHDUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:20:05 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:641 "EHLO ZenIV.linux.org.uk")
	by vger.kernel.org with ESMTP id S1030480AbWBHDT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:19:27 -0500
To: torvalds@osdl.org
Subject: [PATCH 19/29] cmm NULL noise removal, __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1F6frb-0006DS-46@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:19:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138793354 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/s390/mm/cmm.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

aaedd944d4dd25fdfafb10db65544e98eb66857d
diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index 2d5cb13..b075ab4 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -42,8 +42,8 @@ static volatile long cmm_timed_pages_tar
 static long cmm_timeout_pages = 0;
 static long cmm_timeout_seconds = 0;
 
-static struct cmm_page_array *cmm_page_list = 0;
-static struct cmm_page_array *cmm_timed_page_list = 0;
+static struct cmm_page_array *cmm_page_list = NULL;
+static struct cmm_page_array *cmm_timed_page_list = NULL;
 
 static unsigned long cmm_thread_active = 0;
 static struct work_struct cmm_thread_starter;
@@ -259,7 +259,7 @@ static struct ctl_table cmm_table[];
 
 static int
 cmm_pages_handler(ctl_table *ctl, int write, struct file *filp,
-		  void *buffer, size_t *lenp, loff_t *ppos)
+		  void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	char buf[16], *p;
 	long pages;
@@ -300,7 +300,7 @@ cmm_pages_handler(ctl_table *ctl, int wr
 
 static int
 cmm_timeout_handler(ctl_table *ctl, int write, struct file *filp,
-		    void *buffer, size_t *lenp, loff_t *ppos)
+		    void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	char buf[64], *p;
 	long pages, seconds;
@@ -419,7 +419,7 @@ cmm_init (void)
 #ifdef CONFIG_CMM_IUCV
 	smsg_register_callback(SMSG_PREFIX, cmm_smsg_target);
 #endif
-	INIT_WORK(&cmm_thread_starter, (void *) cmm_start_thread, 0);
+	INIT_WORK(&cmm_thread_starter, (void *) cmm_start_thread, NULL);
 	init_waitqueue_head(&cmm_thread_wait);
 	init_timer(&cmm_timer);
 	return 0;
-- 
0.99.9.GIT

