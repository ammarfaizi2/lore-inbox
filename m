Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWCXSOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWCXSOh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWCXSOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:14:07 -0500
Received: from [198.99.130.12] ([198.99.130.12]:44438 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751364AbWCXSNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:13:36 -0500
Message-Id: <200603241814.k2OIEr00005545@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 10/16] UML - OS header cleanups
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Mar 2006 13:14:53 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This rearranges the OS declarations by moving some declarations into os.h.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/include/os.h
===================================================================
--- linux-2.6.16.orig/arch/um/include/os.h	2006-03-23 17:35:34.000000000 -0500
+++ linux-2.6.16/arch/um/include/os.h	2006-03-23 17:35:56.000000000 -0500
@@ -122,6 +122,7 @@ static inline struct openflags of_cloexe
 	return(flags); 
 }
   
+/* file.c */
 extern int os_stat_file(const char *file_name, struct uml_stat *buf);
 extern int os_stat_fd(const int fd, struct uml_stat *buf);
 extern int os_access(const char *file, int mode);
@@ -157,6 +158,15 @@ extern int os_connect_socket(char *name)
 extern int os_file_type(char *file);
 extern int os_file_mode(char *file, struct openflags *mode_out);
 extern int os_lock_file(int fd, int excl);
+extern void os_flush_stdout(void);
+extern int os_stat_filesystem(char *path, long *bsize_out,
+			      long long *blocks_out, long long *bfree_out,
+			      long long *bavail_out, long long *files_out,
+			      long long *ffree_out, void *fsid_out,
+			      int fsid_size, long *namelen_out,
+			      long *spare_out);
+extern int os_change_dir(char *dir);
+extern int os_fchange_dir(int fd);
 
 /* start_up.c */
 extern void os_early_checks(void);
@@ -316,4 +326,8 @@ extern void write_sigio_workaround(void)
 extern int add_sigio_fd(int fd, int read);
 extern int ignore_sigio_fd(int fd);
 
+/* skas/trap */
+extern void sig_handler_common_skas(int sig, void *sc_ptr);
+extern void user_signal(int sig, union uml_pt_regs *regs, int pid);
+
 #endif
Index: linux-2.6.16/arch/um/include/skas/mode-skas.h
===================================================================
--- linux-2.6.16.orig/arch/um/include/skas/mode-skas.h	2006-03-23 17:35:34.000000000 -0500
+++ linux-2.6.16/arch/um/include/skas/mode-skas.h	2006-03-23 17:35:49.000000000 -0500
@@ -13,7 +13,6 @@ extern unsigned long exec_fp_regs[];
 extern unsigned long exec_fpx_regs[];
 extern int have_fpx_regs;
 
-extern void sig_handler_common_skas(int sig, void *sc_ptr);
 extern void kill_off_processes_skas(void);
 
 #endif
Index: linux-2.6.16/arch/um/include/skas/skas.h
===================================================================
--- linux-2.6.16.orig/arch/um/include/skas/skas.h	2006-03-23 17:35:34.000000000 -0500
+++ linux-2.6.16/arch/um/include/skas/skas.h	2006-03-23 17:35:49.000000000 -0500
@@ -17,7 +17,6 @@ extern int user_thread(unsigned long sta
 extern void new_thread_proc(void *stack, void (*handler)(int sig));
 extern void new_thread_handler(int sig);
 extern void handle_syscall(union uml_pt_regs *regs);
-extern void user_signal(int sig, union uml_pt_regs *regs, int pid);
 extern int new_mm(unsigned long stack);
 extern void get_skas_faultinfo(int pid, struct faultinfo * fi);
 extern long execute_syscall_skas(void *r);

