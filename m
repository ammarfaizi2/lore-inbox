Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWDGOdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWDGOdi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWDGOcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:32:32 -0400
Received: from [151.97.230.9] ([151.97.230.9]:36316 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932346AbWDGOcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:32:24 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 04/17] uml: request format warnings to GCC for appropriate functions
Date: Fri, 07 Apr 2006 16:30:57 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060407143056.19201.63947.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Add the format attribute to prototypes so GCC warns about improper usage.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/tt/tt.h     |    3 ++-
 arch/um/include/user.h      |    6 ++++--
 arch/um/include/user_util.h |    3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/um/include/tt/tt.h b/arch/um/include/tt/tt.h
index 8085219..acb8356 100644
--- a/arch/um/include/tt/tt.h
+++ b/arch/um/include/tt/tt.h
@@ -19,7 +19,8 @@ extern int fork_tramp(void *sig_stack);
 extern int do_proc_op(void *t, int proc_id);
 extern int tracer(int (*init_proc)(void *), void *sp);
 extern void attach_process(int pid);
-extern void tracer_panic(char *format, ...);
+extern void tracer_panic(char *format, ...)
+	__attribute__ ((format (printf, 1, 2)));
 extern void set_init_pid(int pid);
 extern int set_user_mode(void *task);
 extern void set_tracing(void *t, int tracing);
diff --git a/arch/um/include/user.h b/arch/um/include/user.h
index 91b0ac4..39f8c88 100644
--- a/arch/um/include/user.h
+++ b/arch/um/include/user.h
@@ -6,8 +6,10 @@
 #ifndef __USER_H__
 #define __USER_H__
 
-extern void panic(const char *fmt, ...);
-extern int printk(const char *fmt, ...);
+extern void panic(const char *fmt, ...)
+	__attribute__ ((format (printf, 1, 2)));
+extern int printk(const char *fmt, ...)
+	__attribute__ ((format (printf, 1, 2)));
 extern void schedule(void);
 extern void *um_kmalloc(int size);
 extern void *um_kmalloc_atomic(int size);
diff --git a/arch/um/include/user_util.h b/arch/um/include/user_util.h
index fe0c29b..802d784 100644
--- a/arch/um/include/user_util.h
+++ b/arch/um/include/user_util.h
@@ -55,7 +55,8 @@ extern int get_pty(void);
 extern void *um_kmalloc(int size);
 extern int switcheroo(int fd, int prot, void *from, void *to, int size);
 extern void do_exec(int old_pid, int new_pid);
-extern void tracer_panic(char *msg, ...);
+extern void tracer_panic(char *msg, ...)
+	__attribute__ ((format (printf, 1, 2)));
 extern int detach(int pid, int sig);
 extern int attach(int pid);
 extern void kill_child_dead(int pid);
