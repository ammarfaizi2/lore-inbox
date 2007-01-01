Return-Path: <linux-kernel-owner+w=401wt.eu-S932791AbXAATw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932791AbXAATw6 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 14:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932785AbXAATw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 14:52:58 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:52694 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705AbXAATwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 14:52:44 -0500
Message-Id: <200701011947.l01Jl82h020751@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/8] UML - watchdog driver formatting
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 Jan 2007 14:47:08 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whitespace and style fixes.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/drivers/harddog_kern.c |   33 +++++++++++----------------------
 arch/um/drivers/harddog_user.c |   23 ++++++-----------------
 2 files changed, 17 insertions(+), 39 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/harddog_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/harddog_kern.c	2006-12-29 21:02:50.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/harddog_kern.c	2006-12-29 21:13:36.000000000 -0500
@@ -9,10 +9,10 @@
  *	modify it under the terms of the GNU General Public License
  *	as published by the Free Software Foundation; either version
  *	2 of the License, or (at your option) any later version.
- *	
- *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide 
- *	warranty for any of this software. This material is provided 
- *	"AS-IS" and at no charge.	
+ *
+ *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide
+ *	warranty for any of this software. This material is provided
+ *	"AS-IS" and at no charge.
  *
  *	(c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
  *
@@ -29,11 +29,11 @@
  *	Made SMP safe for 2.3.x
  *
  *  20011127 Joel Becker (jlbec@evilplan.org>
- *	Added soft_noboot; Allows testing the softdog trigger without 
+ *	Added soft_noboot; Allows testing the softdog trigger without
  *	requiring a recompile.
  *	Added WDIOC_GETTIMEOUT and WDIOC_SETTIMOUT.
  */
- 
+
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -58,7 +58,7 @@ static int harddog_out_fd = -1;
 /*
  *	Allow only one person to hold it open
  */
- 
+
 extern int start_watchdog(int *in_fd_ret, int *out_fd_ret, char *sock);
 
 static int harddog_open(struct inode *inode, struct file *file)
@@ -69,7 +69,7 @@ static int harddog_open(struct inode *in
 	spin_lock(&lock);
 	if(timer_alive)
 		goto err;
-#ifdef CONFIG_HARDDOG_NOWAYOUT	 
+#ifdef CONFIG_HARDDOG_NOWAYOUT
 	__module_get(THIS_MODULE);
 #endif
 
@@ -117,7 +117,7 @@ static ssize_t harddog_write(struct file
 	 *	Refresh the timer.
 	 */
 	if(len)
-		return(ping_watchdog(harddog_out_fd));
+		return ping_watchdog(harddog_out_fd);
 	return 0;
 }
 
@@ -141,7 +141,7 @@ static int harddog_ioctl(struct inode *i
 		case WDIOC_GETBOOTSTATUS:
 			return put_user(0,(int __user *)argp);
 		case WDIOC_KEEPALIVE:
-			return(ping_watchdog(harddog_out_fd));
+			return ping_watchdog(harddog_out_fd);
 	}
 }
 
@@ -172,7 +172,7 @@ static int __init harddog_init(void)
 
 	printk(banner);
 
-	return(0);
+	return 0;
 }
 
 static void __exit harddog_exit(void)
@@ -182,14 +182,3 @@ static void __exit harddog_exit(void)
 
 module_init(harddog_init);
 module_exit(harddog_exit);
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
Index: linux-2.6.18-mm/arch/um/drivers/harddog_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/harddog_user.c	2006-12-29 18:25:36.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/harddog_user.c	2006-12-29 21:12:41.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -38,7 +38,7 @@ int start_watchdog(int *in_fd_ret, int *
 	int in_fds[2], out_fds[2], pid, n, err;
 	char pid_buf[sizeof("nnnnn\0")], c;
 	char *pid_args[] = { "/usr/bin/uml_watchdog", "-pid", pid_buf, NULL };
-	char *mconsole_args[] = { "/usr/bin/uml_watchdog", "-mconsole", NULL, 
+	char *mconsole_args[] = { "/usr/bin/uml_watchdog", "-mconsole", NULL,
 				  NULL };
 	char **args = NULL;
 
@@ -96,7 +96,7 @@ int start_watchdog(int *in_fd_ret, int *
 	}
 	*in_fd_ret = in_fds[0];
 	*out_fd_ret = out_fds[1];
-	return(0);
+	return 0;
 
  out_close_in:
 	os_close_file(in_fds[0]);
@@ -105,7 +105,7 @@ int start_watchdog(int *in_fd_ret, int *
 	os_close_file(out_fds[0]);
 	os_close_file(out_fds[1]);
  out:
-	return(err);
+	return err;
 }
 
 void stop_watchdog(int in_fd, int out_fd)
@@ -123,20 +123,9 @@ int ping_watchdog(int fd)
 	if(n != sizeof(c)){
 		printk("ping_watchdog - write failed, err = %d\n", -n);
 		if(n < 0)
-			return(n);
-		return(-EIO);
+			return n;
+		return -EIO;
 	}
 	return 1;
 
 }
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

