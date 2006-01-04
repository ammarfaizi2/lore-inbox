Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbWACXqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbWACXqm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbWACXqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:46:18 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:40597 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S965048AbWACXpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:45:54 -0500
Message-Id: <200601040037.k040bUod012529@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/12] UML - non-void functions should return something
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Jan 2006 19:37:30 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few functions which are declared to return something,
but don't.  These are actually infinite loops which are forced to be
declared as non-void.  This makes them all return 0.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/ubd_kern.c	2005-12-20 00:24:55.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/ubd_kern.c	2005-12-20 00:34:45.000000000 -0500
@@ -1387,15 +1387,6 @@ int io_thread(void *arg)
 			printk("io_thread - write failed, fd = %d, err = %d\n",
 			       kernel_fd, -n);
 	}
-}
 
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
+	return 0;
+}
Index: linux-2.6.15/arch/um/kernel/sigio_user.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/sigio_user.c	2005-12-20 00:24:54.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/sigio_user.c	2005-12-20 00:33:38.000000000 -0500
@@ -216,6 +216,8 @@ static int write_sigio_thread(void *unus
 				       "err = %d\n", -n);
 		}
 	}
+
+	return 0;
 }
 
 static int need_poll(int n)
Index: linux-2.6.15/arch/um/os-Linux/aio.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/aio.c	2005-12-19 21:34:12.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/aio.c	2005-12-20 00:34:25.000000000 -0500
@@ -210,6 +210,8 @@ static int not_aio_thread(void *arg)
                         printk("not_aio_thread - write failed, fd = %d, "
                                "err = %d\n", aio_req_fd_r, -err);
         }
+
+	return 0;
 }
 
 static int aio_pid = -1;

