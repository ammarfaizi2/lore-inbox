Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265584AbSJSLU3>; Sat, 19 Oct 2002 07:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265585AbSJSLU3>; Sat, 19 Oct 2002 07:20:29 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:57734 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S265584AbSJSLU2>; Sat, 19 Oct 2002 07:20:28 -0400
Date: Sat, 19 Oct 2002 13:26:30 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: lkml <linux-kernel@vger.kernel.org>
cc: trivial linux patches <trivial@rustcorp.com.au>
Subject: [mini-patch] move _STK_LIM to <linux/resource.h>
Message-ID: <Pine.LNX.4.33.0210191319530.12341-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see any connection between the stack limit and scheduling.
So I think _STK_LIMIT is better defined in <linux/resource.h>
than in <linux/sched.h>.

The only place STK_LIM is used is in <asm/resource.h>, which only gets 
included by <linux/resource.h>, so no change in #includes is necessary.

Tim


--- linux-2.5.44/include/linux/resource.h	Sun Sep 22 06:25:00 2002
+++ linux-2.5.44-rs/include/linux/resource.h	Sat Oct 19 12:59:15 2002
@@ -50,6 +50,12 @@
 #define	PRIO_USER	2
 
 /*
+ * Limit the stack by to some sane default: root can always
+ * increase this limit if needed..  8MB seems reasonable.
+ */
+#define _STK_LIM	(8*1024*1024)
+
+/*
  * Due to binary compatibility, the actual resource numbers
  * may be different for different linux versions..
  */

--- linux-2.5.44/include/linux/sched.h	Sat Oct 19 11:00:17 2002
+++ linux-2.5.44-rs/include/linux/sched.h	Sat Oct 19 12:59:29 2002
@@ -431,12 +431,6 @@
 #define PT_TRACESYSGOOD	0x00000004
 #define PT_PTRACE_CAP	0x00000008	/* ptracer can follow suid-exec */
 
-/*
- * Limit the stack by to some sane default: root can always
- * increase this limit if needed..  8MB seems reasonable.
- */
-#define _STK_LIM	(8*1024*1024)
-
 #if CONFIG_SMP
 extern void set_cpus_allowed(task_t *p, unsigned long new_mask);
 #else

