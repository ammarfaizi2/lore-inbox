Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318715AbSHAMEP>; Thu, 1 Aug 2002 08:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318718AbSHAMEP>; Thu, 1 Aug 2002 08:04:15 -0400
Received: from tomts16.bellnexxia.net ([209.226.175.4]:47567 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S318715AbSHAMEO>; Thu, 1 Aug 2002 08:04:14 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix UP links - current bk tree
Date: Thu, 1 Aug 2002 08:07:17 -0400
X-Mailer: KMail [version 1.4]
Cc: Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208010807.17716.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

UP links are failing with the current bk tree.  migration_init is only
defined in sched.c when SMP is set so we should not try to call it
from main.c.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.483   -> 1.484  
#	         init/main.c	1.59    -> 1.60   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/01	ed@oscar.et.ca	1.484
# Fix so UP links do not ask for migration_init
# --------------------------------------------
#
diff -Nru a/init/main.c b/init/main.c
--- a/init/main.c	Thu Aug  1 08:02:01 2002
+++ b/init/main.c	Thu Aug  1 08:02:01 2002
@@ -526,10 +526,12 @@
 
 static void do_pre_smp_initcalls(void)
 {
-	extern int migration_init(void);
 	extern int spawn_ksoftirqd(void);
+#ifdef CONFIG_SMP
+	extern int migration_init(void);
 
 	migration_init();
+#endif
 	spawn_ksoftirqd();
 }
 

