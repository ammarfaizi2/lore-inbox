Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVEZWmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVEZWmW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 18:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbVEZWkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 18:40:33 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:28177 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261845AbVEZWgH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 18:36:07 -0400
Message-Id: <200505262230.j4QMUZDf014704@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 7/7] UML - Remove unused code
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 26 May 2005 18:30:34 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes two now unused files and a couple of unused functions.  The files
were removed by quilt add $file; rm $file; quilt refresh.  If that doesn't
do it, I don't know what to do :-)

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/kernel/initrd_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/initrd_kern.c	2005-05-26 17:15:14.000000000 -0400
+++ linux-2.6.11/arch/um/kernel/initrd_kern.c	2003-09-15 09:40:47.000000000 -0400
@@ -1,59 +0,0 @@
-/*
- * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include "linux/init.h"
-#include "linux/bootmem.h"
-#include "linux/initrd.h"
-#include "asm/types.h"
-#include "user_util.h"
-#include "kern_util.h"
-#include "initrd.h"
-#include "init.h"
-#include "os.h"
-
-/* Changed by uml_initrd_setup, which is a setup */
-static char *initrd __initdata = NULL;
-
-static int __init read_initrd(void)
-{
-	void *area;
-	long long size;
-	int err;
-
-	if(initrd == NULL) return 0;
-	err = os_file_size(initrd, &size);
-	if(err) return 0;
-	area = alloc_bootmem(size);
-	if(area == NULL) return 0;
-	if(load_initrd(initrd, area, size) == -1) return 0;
-	initrd_start = (unsigned long) area;
-	initrd_end = initrd_start + size;
-	return 0;
-}
-
-__uml_postsetup(read_initrd);
-
-static int __init uml_initrd_setup(char *line, int *add)
-{
-	initrd = line;
-	return 0;
-}
-
-__uml_setup("initrd=", uml_initrd_setup, 
-"initrd=<initrd image>\n"
-"    This is used to boot UML from an initrd image.  The argument is the\n"
-"    name of the file containing the image.\n\n"
-);
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
Index: linux-2.6.11/arch/um/kernel/initrd_user.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/initrd_user.c	2005-05-26 17:15:14.000000000 -0400
+++ linux-2.6.11/arch/um/kernel/initrd_user.c	2003-09-15 09:40:47.000000000 -0400
@@ -1,46 +0,0 @@
-/*
- * Copyright (C) 2000, 2001 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <errno.h>
-
-#include "user_util.h"
-#include "kern_util.h"
-#include "user.h"
-#include "initrd.h"
-#include "os.h"
-
-int load_initrd(char *filename, void *buf, int size)
-{
-	int fd, n;
-
-	fd = os_open_file(filename, of_read(OPENFLAGS()), 0);
-	if(fd < 0){
-		printk("Opening '%s' failed - err = %d\n", filename, -fd);
-		return(-1);
-	}
-	n = os_read_file(fd, buf, size);
-	if(n != size){
-		printk("Read of %d bytes from '%s' failed, err = %d\n", size,
-		       filename, -n);
-		return(-1);
-	}
-
-	os_close_file(fd);
-	return(0);
-}
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
Index: linux-2.6.11/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/process_kern.c	2005-05-26 17:25:35.000000000 -0400
+++ linux-2.6.11/arch/um/kernel/process_kern.c	2005-05-26 17:30:15.000000000 -0400
@@ -55,18 +55,6 @@
  */
 struct cpu_task cpu_tasks[NR_CPUS] = { [0 ... NR_CPUS - 1] = { -1, NULL } };
 
-struct task_struct *get_task(int pid, int require)
-{
-        struct task_struct *ret;
-
-        read_lock(&tasklist_lock);
-	ret = find_task_by_pid(pid);
-        read_unlock(&tasklist_lock);
-
-        if(require && (ret == NULL)) panic("get_task couldn't find a task\n");
-        return(ret);
-}
-
 int external_pid(void *t)
 {
 	struct task_struct *task = t ? t : current;
@@ -213,11 +201,6 @@ int page_size(void)
 	return(PAGE_SIZE);
 }
 
-unsigned long page_mask(void)
-{
-	return(PAGE_MASK);
-}
-
 void *um_virt_to_phys(struct task_struct *task, unsigned long addr, 
 		      pte_t *pte_out)
 {
@@ -345,11 +328,6 @@ char *uml_strdup(char *string)
 	return kstrdup(string, GFP_KERNEL);
 }
 
-void *get_init_task(void)
-{
-	return(&init_thread_union.thread_info.task);
-}
-
 int copy_to_user_proc(void __user *to, void *from, int size)
 {
 	return(copy_to_user(to, from, size));
@@ -476,15 +454,3 @@ unsigned long arch_align_stack(unsigned 
 	return sp & ~0xf;
 }
 #endif
-
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

