Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266367AbTABTGs>; Thu, 2 Jan 2003 14:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266368AbTABTGs>; Thu, 2 Jan 2003 14:06:48 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:26244 "HELO atlrel6.hp.com")
	by vger.kernel.org with SMTP id <S266367AbTABTGr>;
	Thu, 2 Jan 2003 14:06:47 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] Fix CPU bitmask truncation (2 of 2)
Date: Thu, 2 Jan 2003 12:15:06 -0700
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301021215.06352.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This does not make a functional difference, so ignore it if you
like.  Two reasons you might want it:

  1) It's in 2.5.x, so you might want it for consistency.
  2) Comments in sched.h refer to cpus_runnable being ~0
     if the process is not running on any CPU.

diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Mon Dec 16 11:58:42 2002
+++ b/include/linux/sched.h	Mon Dec 16 11:58:42 2002
@@ -482,8 +482,8 @@
     policy:		SCHED_OTHER,					\
     mm:			NULL,						\
     active_mm:		&init_mm,					\
-    cpus_runnable:	-1,						\
-    cpus_allowed:	-1,						\
+    cpus_runnable:	~0UL,						\
+    cpus_allowed:	~0UL,						\
     run_list:		LIST_HEAD_INIT(tsk.run_list),			\
     next_task:		&tsk,						\
     prev_task:		&tsk,						\

