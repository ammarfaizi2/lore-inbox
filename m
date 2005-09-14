Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbVINWDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbVINWDE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVINWDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:03:04 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:52229 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S965024AbVINWDC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:03:02 -0400
Message-Id: <200509142155.j8ELtxC1012142@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 4/10] UML - Remove an unused file
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 14 Sep 2005 17:55:59 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes a file which is no longer used.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-mm2/arch/um/drivers/ubd_user.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/drivers/ubd_user.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/drivers/ubd_user.c	2005-09-09 12:53:03.802794632 -0400
@@ -1,75 +0,0 @@
-/* 
- * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Copyright (C) 2001 Ridgerun,Inc (glonnon@ridgerun.com)
- * Licensed under the GPL
- */
-
-#include <stddef.h>
-#include <unistd.h>
-#include <errno.h>
-#include <sched.h>
-#include <signal.h>
-#include <string.h>
-#include <netinet/in.h>
-#include <sys/time.h>
-#include <sys/socket.h>
-#include <sys/mman.h>
-#include <sys/param.h>
-#include "asm/types.h"
-#include "user_util.h"
-#include "kern_util.h"
-#include "user.h"
-#include "ubd_user.h"
-#include "os.h"
-#include "cow.h"
-
-#include <endian.h>
-#include <byteswap.h>
-
-void ignore_sigwinch_sig(void)
-{
-	signal(SIGWINCH, SIG_IGN);
-}
-
-int start_io_thread(unsigned long sp, int *fd_out)
-{
-	int pid, fds[2], err;
-
-	err = os_pipe(fds, 1, 1);
-	if(err < 0){
-		printk("start_io_thread - os_pipe failed, err = %d\n", -err);
-		goto out;
-	}
-
-	kernel_fd = fds[0];
-	*fd_out = fds[1];
-
-	pid = clone(io_thread, (void *) sp, CLONE_FILES | CLONE_VM | SIGCHLD,
-		    NULL);
-	if(pid < 0){
-		printk("start_io_thread - clone failed : errno = %d\n", errno);
-		err = -errno;
-		goto out_close;
-	}
-
-	return(pid);
-
- out_close:
-	os_close_file(fds[0]);
-	os_close_file(fds[1]);
-	kernel_fd = -1;
-	*fd_out = -1;
- out:
-	return(err);
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

