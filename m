Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVEFXw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVEFXw4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 19:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVEFXYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 19:24:35 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:46854 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261345AbVEFXOd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 19:14:33 -0400
Message-Id: <200505062249.j46Mn112010445@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 3/12] UML - command line handling cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 May 2005 18:49:01 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Command line handling cleanups - a couple of things made static and an 
unused declaration removed from header.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc3-mm/arch/um/include/user_util.h
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/include/user_util.h	2005-05-02 14:47:52.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/include/user_util.h	2005-05-06 14:35:06.000000000 -0400
@@ -67,7 +67,6 @@
 extern int switcheroo(int fd, int prot, void *from, void *to, int size);
 extern void setup_machinename(char *machine_out);
 extern void setup_hostinfo(void);
-extern void add_arg(char *arg);
 extern void init_new_thread_stack(void *sig_stack, void (*usr1_handler)(int));
 extern void init_new_thread_signals(int altstack);
 extern void do_exec(int old_pid, int new_pid);
Index: linux-2.6.12-rc3-mm/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.12-rc3-mm.orig/arch/um/kernel/um_arch.c	2005-05-02 14:47:52.000000000 -0400
+++ linux-2.6.12-rc3-mm/arch/um/kernel/um_arch.c	2005-05-06 14:37:21.000000000 -0400
@@ -23,6 +23,7 @@
 #include "asm/ptrace.h"
 #include "asm/elf.h"
 #include "asm/user.h"
+#include "asm/setup.h"
 #include "ubd_user.h"
 #include "asm/current.h"
 #include "asm/setup.h"
@@ -42,9 +43,9 @@
 #define DEFAULT_COMMAND_LINE "root=98:0"
 
 /* Changed in linux_main and setup_arch, which run before SMP is started */
-char command_line[COMMAND_LINE_SIZE] = { 0 };
+static char command_line[COMMAND_LINE_SIZE] = { 0 };
 
-void add_arg(char *arg)
+static void add_arg(char *arg)
 {
 	if (strlen(command_line) + strlen(arg) + 1 > COMMAND_LINE_SIZE) {
 		printf("add_arg: Too many command line arguments!\n");
@@ -449,7 +450,7 @@
 {
 	notifier_chain_register(&panic_notifier_list, &panic_exit_notifier);
 	paging_init();
- 	strlcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
+        strlcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
  	*cmdline_p = command_line;
 	setup_hostinfo();
 }
Index: linux-2.6.12-rc3-mm/include/asm-um/setup.h
===================================================================
--- linux-2.6.12-rc3-mm.orig/include/asm-um/setup.h	2005-05-02 14:47:52.000000000 -0400
+++ linux-2.6.12-rc3-mm/include/asm-um/setup.h	2005-05-05 12:32:59.000000000 -0400
@@ -2,7 +2,8 @@
 #define SETUP_H_INCLUDED
 
 /* POSIX mandated with _POSIX_ARG_MAX that we can rely on 4096 chars in the
- * command line, so this choice is ok.*/
+ * command line, so this choice is ok.
+ */
 
 #define COMMAND_LINE_SIZE 4096
 

