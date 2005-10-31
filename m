Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbVJaDrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbVJaDrr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 22:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbVJaDrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 22:47:24 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:35846 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751322AbVJaDqx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 22:46:53 -0500
Message-Id: <200510310439.j9V4ddAO000861@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Gennady.V.Sharapov@intel.com
Subject: [PATCH 6/10] UML - Separate libc-dependent helper code
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 30 Oct 2005 23:39:39 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The serial UML OS-abstraction layer patch (um/kernel dir).

This moves all systemcalls from helper.c file under os-Linux dir

Signed-off-by: Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.14/arch/um/drivers/chan_user.c
===================================================================
--- linux-2.6.14.orig/arch/um/drivers/chan_user.c	2005-10-30 19:22:17.000000000 -0500
+++ linux-2.6.14/arch/um/drivers/chan_user.c	2005-10-30 19:27:49.000000000 -0500
@@ -16,7 +16,6 @@
 #include "user_util.h"
 #include "chan_user.h"
 #include "user.h"
-#include "helper.h"
 #include "os.h"
 #include "choose-mode.h"
 #include "mode.h"
Index: linux-2.6.14/arch/um/drivers/harddog_kern.c
===================================================================
--- linux-2.6.14.orig/arch/um/drivers/harddog_kern.c	2005-10-30 19:22:17.000000000 -0500
+++ linux-2.6.14/arch/um/drivers/harddog_kern.c	2005-10-30 19:27:49.000000000 -0500
@@ -46,7 +46,6 @@
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <asm/uaccess.h>
-#include "helper.h"
 #include "mconsole.h"
 
 MODULE_LICENSE("GPL");
Index: linux-2.6.14/arch/um/drivers/harddog_user.c
===================================================================
--- linux-2.6.14.orig/arch/um/drivers/harddog_user.c	2005-10-30 19:22:17.000000000 -0500
+++ linux-2.6.14/arch/um/drivers/harddog_user.c	2005-10-30 19:27:49.000000000 -0500
@@ -8,7 +8,6 @@
 #include <errno.h>
 #include "user_util.h"
 #include "user.h"
-#include "helper.h"
 #include "mconsole.h"
 #include "os.h"
 #include "choose-mode.h"
Index: linux-2.6.14/arch/um/drivers/net_user.c
===================================================================
--- linux-2.6.14.orig/arch/um/drivers/net_user.c	2005-10-30 19:22:17.000000000 -0500
+++ linux-2.6.14/arch/um/drivers/net_user.c	2005-10-30 19:27:49.000000000 -0500
@@ -16,7 +16,6 @@
 #include "user_util.h"
 #include "kern_util.h"
 #include "net_user.h"
-#include "helper.h"
 #include "os.h"
 
 int tap_open_common(void *dev, char *gate_addr)
Index: linux-2.6.14/arch/um/drivers/port_user.c
===================================================================
--- linux-2.6.14.orig/arch/um/drivers/port_user.c	2005-10-30 19:22:17.000000000 -0500
+++ linux-2.6.14/arch/um/drivers/port_user.c	2005-10-30 19:27:49.000000000 -0500
@@ -18,7 +18,6 @@
 #include "user.h"
 #include "chan_user.h"
 #include "port.h"
-#include "helper.h"
 #include "os.h"
 
 struct port_chan {
Index: linux-2.6.14/arch/um/drivers/slip_user.c
===================================================================
--- linux-2.6.14.orig/arch/um/drivers/slip_user.c	2005-10-30 19:22:17.000000000 -0500
+++ linux-2.6.14/arch/um/drivers/slip_user.c	2005-10-30 19:27:49.000000000 -0500
@@ -14,7 +14,6 @@
 #include "net_user.h"
 #include "slip.h"
 #include "slip_common.h"
-#include "helper.h"
 #include "os.h"
 
 void slip_user_init(void *data, void *dev)
Index: linux-2.6.14/arch/um/drivers/slirp_user.c
===================================================================
--- linux-2.6.14.orig/arch/um/drivers/slirp_user.c	2005-10-30 19:22:17.000000000 -0500
+++ linux-2.6.14/arch/um/drivers/slirp_user.c	2005-10-30 19:27:49.000000000 -0500
@@ -13,7 +13,6 @@
 #include "net_user.h"
 #include "slirp.h"
 #include "slip_common.h"
-#include "helper.h"
 #include "os.h"
 
 void slirp_user_init(void *data, void *dev)
Index: linux-2.6.14/arch/um/drivers/xterm.c
===================================================================
--- linux-2.6.14.orig/arch/um/drivers/xterm.c	2005-10-30 19:22:17.000000000 -0500
+++ linux-2.6.14/arch/um/drivers/xterm.c	2005-10-30 19:27:49.000000000 -0500
@@ -14,7 +14,6 @@
 #include <sys/socket.h>
 #include "kern_util.h"
 #include "chan_user.h"
-#include "helper.h"
 #include "user_util.h"
 #include "user.h"
 #include "os.h"
Index: linux-2.6.14/arch/um/include/helper.h
===================================================================
--- linux-2.6.14.orig/arch/um/include/helper.h	2005-10-30 19:22:17.000000000 -0500
+++ linux-2.6.14/arch/um/include/helper.h	2005-10-28 06:47:18.772411750 -0400
@@ -1,27 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __HELPER_H__
-#define __HELPER_H__
-
-extern int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv,
-		      unsigned long *stack_out);
-extern int run_helper_thread(int (*proc)(void *), void *arg, 
-			     unsigned int flags, unsigned long *stack_out,
-			     int stack_order);
-extern int helper_wait(int pid);
-
-#endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.14/arch/um/include/os.h
===================================================================
--- linux-2.6.14.orig/arch/um/include/os.h	2005-10-30 19:22:17.000000000 -0500
+++ linux-2.6.14/arch/um/include/os.h	2005-10-30 19:27:49.000000000 -0500
@@ -205,6 +205,14 @@ extern unsigned long __do_user_copy(void
 				    void (*op)(void *to, const void *from,
 					       int n), int *faulted_out);
 
+/* helper.c */
+extern int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv,
+		      unsigned long *stack_out);
+extern int run_helper_thread(int (*proc)(void *), void *arg, 
+			     unsigned int flags, unsigned long *stack_out,
+			     int stack_order);
+extern int helper_wait(int pid);
+
 #endif
 
 /*
Index: linux-2.6.14/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.14.orig/arch/um/kernel/Makefile	2005-10-30 19:27:34.000000000 -0500
+++ linux-2.6.14/arch/um/kernel/Makefile	2005-10-30 19:28:09.000000000 -0500
@@ -7,7 +7,7 @@ extra-y := vmlinux.lds
 clean-files :=
 
 obj-y = config.o exec_kern.o exitcode.o \
-	helper.o init_task.o irq.o irq_user.o ksyms.o mem.o physmem.o \
+	init_task.o irq.o irq_user.o ksyms.o mem.o physmem.o \
 	process_kern.o ptrace.o reboot.o resource.o sigio_user.o sigio_kern.o \
 	signal_kern.o signal_user.o smp.o syscall_kern.o sysrq.o time.o \
 	time_kern.o tlb.o trap_kern.o trap_user.o uaccess.o um_arch.o \
@@ -24,8 +24,7 @@ obj-$(CONFIG_MODE_SKAS) += skas/
 
 user-objs-$(CONFIG_TTY_LOG) += tty_log.o
 
-USER_OBJS := $(user-objs-y) config.o helper.o time.o tty_log.o umid.o \
-	user_util.o
+USER_OBJS := $(user-objs-y) config.o time.o tty_log.o umid.o user_util.o
 
 include arch/um/scripts/Makefile.rules
 
Index: linux-2.6.14/arch/um/kernel/helper.c
===================================================================
--- linux-2.6.14.orig/arch/um/kernel/helper.c	2005-10-30 19:22:17.000000000 -0500
+++ linux-2.6.14/arch/um/kernel/helper.c	2005-10-28 06:47:18.772411750 -0400
@@ -1,165 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <errno.h>
-#include <sched.h>
-#include <sys/signal.h>
-#include <sys/wait.h>
-#include "user.h"
-#include "kern_util.h"
-#include "user_util.h"
-#include "helper.h"
-#include "os.h"
-
-struct helper_data {
-	void (*pre_exec)(void*);
-	void *pre_data;
-	char **argv;
-	int fd;
-};
-
-/* Debugging aid, changed only from gdb */
-int helper_pause = 0;
-
-static void helper_hup(int sig)
-{
-}
-
-static int helper_child(void *arg)
-{
-	struct helper_data *data = arg;
-	char **argv = data->argv;
-	int errval;
-
-	if(helper_pause){
-		signal(SIGHUP, helper_hup);
-		pause();
-	}
-	if(data->pre_exec != NULL)
-		(*data->pre_exec)(data->pre_data);
-	execvp(argv[0], argv);
-	errval = errno;
-	printk("execvp of '%s' failed - errno = %d\n", argv[0], errno);
-	os_write_file(data->fd, &errval, sizeof(errval));
-	os_kill_process(os_getpid(), 0);
-	return(0);
-}
-
-/* Returns either the pid of the child process we run or -E* on failure.
- * XXX The alloc_stack here breaks if this is called in the tracing thread */
-int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv,
-	       unsigned long *stack_out)
-{
-	struct helper_data data;
-	unsigned long stack, sp;
-	int pid, fds[2], ret, n;
-
-	if((stack_out != NULL) && (*stack_out != 0))
-		stack = *stack_out;
-	else stack = alloc_stack(0, um_in_interrupt());
-	if(stack == 0)
-		return(-ENOMEM);
-
-	ret = os_pipe(fds, 1, 0);
-	if(ret < 0){
-		printk("run_helper : pipe failed, ret = %d\n", -ret);
-		goto out_free;
-	}
-
-	ret = os_set_exec_close(fds[1], 1);
-	if(ret < 0){
-		printk("run_helper : setting FD_CLOEXEC failed, ret = %d\n",
-		       -ret);
-		goto out_close;
-	}
-
-	sp = stack + page_size() - sizeof(void *);
-	data.pre_exec = pre_exec;
-	data.pre_data = pre_data;
-	data.argv = argv;
-	data.fd = fds[1];
-	pid = clone(helper_child, (void *) sp, CLONE_VM | SIGCHLD, &data);
-	if(pid < 0){
-		ret = -errno;
-		printk("run_helper : clone failed, errno = %d\n", errno);
-		goto out_close;
-	}
-
-	os_close_file(fds[1]);
-	fds[1] = -1;
-
-	/*Read the errno value from the child.*/
-	n = os_read_file(fds[0], &ret, sizeof(ret));
-	if(n < 0){
-		printk("run_helper : read on pipe failed, ret = %d\n", -n);
-		ret = n;
-		os_kill_process(pid, 1);
-	}
-	else if(n != 0){
-		CATCH_EINTR(n = waitpid(pid, NULL, 0));
-		ret = -errno;
-	} else {
-		ret = pid;
-	}
-
-out_close:
-	if (fds[1] != -1)
-		os_close_file(fds[1]);
-	os_close_file(fds[0]);
-out_free:
-	if(stack_out == NULL)
-		free_stack(stack, 0);
-	else *stack_out = stack;
-	return(ret);
-}
-
-int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags, 
-		      unsigned long *stack_out, int stack_order)
-{
-	unsigned long stack, sp;
-	int pid, status, err;
-
-	stack = alloc_stack(stack_order, um_in_interrupt());
-	if(stack == 0) return(-ENOMEM);
-
-	sp = stack + (page_size() << stack_order) - sizeof(void *);
-	pid = clone(proc, (void *) sp, flags | SIGCHLD, arg);
-	if(pid < 0){
-		err = -errno;
-		printk("run_helper_thread : clone failed, errno = %d\n", 
-		       errno);
-		return err;
-	}
-	if(stack_out == NULL){
-		CATCH_EINTR(pid = waitpid(pid, &status, 0));
-		if(pid < 0){
-			err = -errno;
-			printk("run_helper_thread - wait failed, errno = %d\n",
-			       errno);
-			pid = err;
-		}
-		if(!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
-			printk("run_helper_thread - thread returned status "
-			       "0x%x\n", status);
-		free_stack(stack, stack_order);
-	}
-	else *stack_out = stack;
-	return(pid);
-}
-
-int helper_wait(int pid)
-{
-	int ret;
-
-	CATCH_EINTR(ret = waitpid(pid, NULL, WNOHANG));
-	if(ret < 0){
-		ret = -errno;
-		printk("helper_wait : waitpid failed, errno = %d\n", errno);
-	}
-	return(ret);
-}
Index: linux-2.6.14/arch/um/kernel/ksyms.c
===================================================================
--- linux-2.6.14.orig/arch/um/kernel/ksyms.c	2005-10-30 19:22:17.000000000 -0500
+++ linux-2.6.14/arch/um/kernel/ksyms.c	2005-10-30 19:27:49.000000000 -0500
@@ -20,7 +20,6 @@
 #include "user_util.h"
 #include "mem_user.h"
 #include "os.h"
-#include "helper.h"
 
 EXPORT_SYMBOL(stop);
 EXPORT_SYMBOL(uml_physmem);
Index: linux-2.6.14/arch/um/kernel/sigio_user.c
===================================================================
--- linux-2.6.14.orig/arch/um/kernel/sigio_user.c	2005-10-30 19:22:17.000000000 -0500
+++ linux-2.6.14/arch/um/kernel/sigio_user.c	2005-10-30 19:27:49.000000000 -0500
@@ -18,7 +18,6 @@
 #include "kern_util.h"
 #include "user_util.h"
 #include "sigio.h"
-#include "helper.h"
 #include "os.h"
 
 /* Changed during early boot */
Index: linux-2.6.14/arch/um/kernel/user_util.c
===================================================================
--- linux-2.6.14.orig/arch/um/kernel/user_util.c	2005-10-30 19:22:17.000000000 -0500
+++ linux-2.6.14/arch/um/kernel/user_util.c	2005-10-30 19:27:49.000000000 -0500
@@ -27,7 +27,6 @@
 #include "user.h"
 #include "mem_user.h"
 #include "init.h"
-#include "helper.h"
 #include "ptrace_user.h"
 #include "uml-config.h"
 
Index: linux-2.6.14/arch/um/os-Linux/Makefile
===================================================================
--- linux-2.6.14.orig/arch/um/os-Linux/Makefile	2005-10-30 19:22:17.000000000 -0500
+++ linux-2.6.14/arch/um/os-Linux/Makefile	2005-10-30 19:27:49.000000000 -0500
@@ -3,10 +3,11 @@
 # Licensed under the GPL
 #
 
-obj-y = aio.o elf_aux.o file.o main.o mem.o process.o signal.o start_up.o \
-	time.o tt.o tty.o uaccess.o user_syms.o drivers/ sys-$(SUBARCH)/
+obj-y = aio.o elf_aux.o file.o helper.o main.o mem.o process.o signal.o \
+	start_up.o time.o tt.o tty.o uaccess.o user_syms.o drivers/ \
+	sys-$(SUBARCH)/
 
-USER_OBJS := aio.o elf_aux.o file.o main.o mem.o process.o signal.o \
+USER_OBJS := aio.o elf_aux.o file.o helper.o main.o mem.o process.o signal.o \
 	start_up.o time.o tt.o tty.o uaccess.o
 
 elf_aux.o: $(ARCH_DIR)/kernel-offsets.h
Index: linux-2.6.14/arch/um/os-Linux/aio.c
===================================================================
--- linux-2.6.14.orig/arch/um/os-Linux/aio.c	2005-10-30 19:22:17.000000000 -0500
+++ linux-2.6.14/arch/um/os-Linux/aio.c	2005-10-30 19:27:49.000000000 -0500
@@ -10,7 +10,6 @@
 #include <sched.h>
 #include <sys/syscall.h>
 #include "os.h"
-#include "helper.h"
 #include "aio.h"
 #include "init.h"
 #include "user.h"
Index: linux-2.6.14/arch/um/os-Linux/drivers/ethertap_user.c
===================================================================
--- linux-2.6.14.orig/arch/um/os-Linux/drivers/ethertap_user.c	2005-10-30 19:22:17.000000000 -0500
+++ linux-2.6.14/arch/um/os-Linux/drivers/ethertap_user.c	2005-10-30 19:27:49.000000000 -0500
@@ -19,7 +19,6 @@
 #include "user_util.h"
 #include "net_user.h"
 #include "etap.h"
-#include "helper.h"
 #include "os.h"
 
 #define MAX_PACKET ETH_MAX_PACKET
Index: linux-2.6.14/arch/um/os-Linux/drivers/tuntap_user.c
===================================================================
--- linux-2.6.14.orig/arch/um/os-Linux/drivers/tuntap_user.c	2005-10-30 19:22:17.000000000 -0500
+++ linux-2.6.14/arch/um/os-Linux/drivers/tuntap_user.c	2005-10-30 19:27:49.000000000 -0500
@@ -20,7 +20,6 @@
 #include "kern_util.h"
 #include "user_util.h"
 #include "user.h"
-#include "helper.h"
 #include "os.h"
 
 #define MAX_PACKET ETH_MAX_PACKET
Index: linux-2.6.14/arch/um/os-Linux/helper.c
===================================================================
--- linux-2.6.14.orig/arch/um/os-Linux/helper.c	2005-10-28 06:47:18.772411750 -0400
+++ linux-2.6.14/arch/um/os-Linux/helper.c	2005-10-30 19:27:49.000000000 -0500
@@ -0,0 +1,165 @@
+/* 
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sched.h>
+#include <sys/signal.h>
+#include <sys/wait.h>
+#include "user.h"
+#include "kern_util.h"
+#include "user_util.h"
+#include "os.h"
+
+struct helper_data {
+	void (*pre_exec)(void*);
+	void *pre_data;
+	char **argv;
+	int fd;
+};
+
+/* Debugging aid, changed only from gdb */
+int helper_pause = 0;
+
+static void helper_hup(int sig)
+{
+}
+
+static int helper_child(void *arg)
+{
+	struct helper_data *data = arg;
+	char **argv = data->argv;
+	int errval;
+
+	if(helper_pause){
+		signal(SIGHUP, helper_hup);
+		pause();
+	}
+	if(data->pre_exec != NULL)
+		(*data->pre_exec)(data->pre_data);
+	execvp(argv[0], argv);
+	errval = errno;
+	printk("execvp of '%s' failed - errno = %d\n", argv[0], errno);
+	os_write_file(data->fd, &errval, sizeof(errval));
+	kill(os_getpid(), SIGKILL);
+	return(0);
+}
+
+/* Returns either the pid of the child process we run or -E* on failure.
+ * XXX The alloc_stack here breaks if this is called in the tracing thread */
+int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv,
+	       unsigned long *stack_out)
+{
+	struct helper_data data;
+	unsigned long stack, sp;
+	int pid, fds[2], ret, n;
+
+	if((stack_out != NULL) && (*stack_out != 0))
+		stack = *stack_out;
+	else stack = alloc_stack(0, um_in_interrupt());
+	if(stack == 0)
+		return(-ENOMEM);
+
+	ret = os_pipe(fds, 1, 0);
+	if(ret < 0){
+		printk("run_helper : pipe failed, ret = %d\n", -ret);
+		goto out_free;
+	}
+
+	ret = os_set_exec_close(fds[1], 1);
+	if(ret < 0){
+		printk("run_helper : setting FD_CLOEXEC failed, ret = %d\n",
+		       -ret);
+		goto out_close;
+	}
+
+	sp = stack + page_size() - sizeof(void *);
+	data.pre_exec = pre_exec;
+	data.pre_data = pre_data;
+	data.argv = argv;
+	data.fd = fds[1];
+	pid = clone(helper_child, (void *) sp, CLONE_VM | SIGCHLD, &data);
+	if(pid < 0){
+		ret = -errno;
+		printk("run_helper : clone failed, errno = %d\n", errno);
+		goto out_close;
+	}
+
+	close(fds[1]);
+	fds[1] = -1;
+
+	/*Read the errno value from the child.*/
+	n = os_read_file(fds[0], &ret, sizeof(ret));
+	if(n < 0){
+		printk("run_helper : read on pipe failed, ret = %d\n", -n);
+		ret = n;
+		kill(pid, SIGKILL);
+		CATCH_EINTR(waitpid(pid, NULL, 0));
+	}
+	else if(n != 0){
+		CATCH_EINTR(n = waitpid(pid, NULL, 0));
+		ret = -errno;
+	} else {
+		ret = pid;
+	}
+
+out_close:
+	if (fds[1] != -1)
+		close(fds[1]);
+	close(fds[0]);
+out_free:
+	if(stack_out == NULL)
+		free_stack(stack, 0);
+	else *stack_out = stack;
+	return(ret);
+}
+
+int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags, 
+		      unsigned long *stack_out, int stack_order)
+{
+	unsigned long stack, sp;
+	int pid, status, err;
+
+	stack = alloc_stack(stack_order, um_in_interrupt());
+	if(stack == 0) return(-ENOMEM);
+
+	sp = stack + (page_size() << stack_order) - sizeof(void *);
+	pid = clone(proc, (void *) sp, flags | SIGCHLD, arg);
+	if(pid < 0){
+		err = -errno;
+		printk("run_helper_thread : clone failed, errno = %d\n", 
+		       errno);
+		return err;
+	}
+	if(stack_out == NULL){
+		CATCH_EINTR(pid = waitpid(pid, &status, 0));
+		if(pid < 0){
+			err = -errno;
+			printk("run_helper_thread - wait failed, errno = %d\n",
+			       errno);
+			pid = err;
+		}
+		if(!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
+			printk("run_helper_thread - thread returned status "
+			       "0x%x\n", status);
+		free_stack(stack, stack_order);
+	}
+	else *stack_out = stack;
+	return(pid);
+}
+
+int helper_wait(int pid)
+{
+	int ret;
+
+	CATCH_EINTR(ret = waitpid(pid, NULL, WNOHANG));
+	if(ret < 0){
+		ret = -errno;
+		printk("helper_wait : waitpid failed, errno = %d\n", errno);
+	}
+	return(ret);
+}

