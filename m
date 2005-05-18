Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVEREhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVEREhB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 00:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVERE25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 00:28:57 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:25869 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262079AbVEREZy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 00:25:54 -0400
Message-Id: <200505180420.j4I4KYFd017349@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH 9/9] UML - Change printf to printk in console driver
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 May 2005 00:20:34 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Al Viro - we have error messages with KERN_ERR in them, so they
should be printk-ed rather than printf-ed.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/drivers/chan_kern.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/chan_kern.c	2005-05-17 18:02:25.000000000 -0400
+++ linux-2.6.12-rc/arch/um/drivers/chan_kern.c	2005-05-17 18:27:15.000000000 -0400
@@ -20,9 +20,17 @@
 #include "os.h"
 
 #ifdef CONFIG_NOCONFIG_CHAN
+
+/* The printk's here are wrong because we are complaining that there is no
+ * output device, but printk is printing to that output device.  The user will 
+ * never see the error.  printf would be better, except it can't run on a 
+ * kernel stack because it will overflow it.  
+ * Use printk for now since that will avoid crashing.
+ */
+
 static void *not_configged_init(char *str, int device, struct chan_opts *opts)
 {
-	printf(KERN_ERR "Using a channel type which is configured out of "
+	printk(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
 	return(NULL);
 }
@@ -30,27 +38,27 @@ static void *not_configged_init(char *st
 static int not_configged_open(int input, int output, int primary, void *data,
 			      char **dev_out)
 {
-	printf(KERN_ERR "Using a channel type which is configured out of "
+	printk(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
 	return(-ENODEV);
 }
 
 static void not_configged_close(int fd, void *data)
 {
-	printf(KERN_ERR "Using a channel type which is configured out of "
+	printk(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
 }
 
 static int not_configged_read(int fd, char *c_out, void *data)
 {
-	printf(KERN_ERR "Using a channel type which is configured out of "
+	printk(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
 	return(-EIO);
 }
 
 static int not_configged_write(int fd, const char *buf, int len, void *data)
 {
-	printf(KERN_ERR "Using a channel type which is configured out of "
+	printk(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
 	return(-EIO);
 }
@@ -58,7 +66,7 @@ static int not_configged_write(int fd, c
 static int not_configged_console_write(int fd, const char *buf, int len,
 				       void *data)
 {
-	printf(KERN_ERR "Using a channel type which is configured out of "
+	printk(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
 	return(-EIO);
 }
@@ -66,7 +74,7 @@ static int not_configged_console_write(i
 static int not_configged_window_size(int fd, void *data, unsigned short *rows,
 				     unsigned short *cols)
 {
-	printf(KERN_ERR "Using a channel type which is configured out of "
+	printk(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
 	return(-ENODEV);
 }

