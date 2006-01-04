Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWADVCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWADVCi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWADU77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 15:59:59 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:52382 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751591AbWADU7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:59:55 -0500
Message-Id: <200601042152.k04Lq6ud009257@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 8/9] UML - Fix whitespace in mconsole driver
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Jan 2006 16:52:06 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up some bogus spacing in the mconsole driver.  Also delete the
emacs formatting comment at the end.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/mconsole_kern.c	2006-01-04 14:53:02.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/mconsole_kern.c	2006-01-04 14:55:31.000000000 -0500
@@ -422,7 +422,7 @@ void mconsole_remove(struct mc_request *
 {
 	struct mc_device *dev;
 	char *ptr = req->request.data, *err_msg = "";
-        char error[256];
+	char error[256];
 	int err, start, end, n;
 
 	ptr += strlen("remove");
@@ -433,33 +433,33 @@ void mconsole_remove(struct mc_request *
 		return;
 	}
 
-        ptr = &ptr[strlen(dev->name)];
+	ptr = &ptr[strlen(dev->name)];
 
-        err = 1;
-        n = (*dev->id)(&ptr, &start, &end);
-        if(n < 0){
-                err_msg = "Couldn't parse device number";
-                goto out;
-        }
-        else if((n < start) || (n > end)){
-                sprintf(error, "Invalid device number - must be between "
-                        "%d and %d", start, end);
-                err_msg = error;
-                goto out;
-        }
+	err = 1;
+	n = (*dev->id)(&ptr, &start, &end);
+	if(n < 0){
+		err_msg = "Couldn't parse device number";
+		goto out;
+	}
+	else if((n < start) || (n > end)){
+		sprintf(error, "Invalid device number - must be between "
+			"%d and %d", start, end);
+		err_msg = error;
+		goto out;
+	}
 
 	err = (*dev->remove)(n);
-        switch(err){
-        case -ENODEV:
-                err_msg = "Device doesn't exist";
-                break;
-        case -EBUSY:
-                err_msg = "Device is currently open";
-                break;
-        default:
-                break;
-        }
- out:
+	switch(err){
+	case -ENODEV:
+		err_msg = "Device doesn't exist";
+		break;
+	case -EBUSY:
+		err_msg = "Device is currently open";
+		break;
+	default:
+		break;
+	}
+out:
 	mconsole_reply(req, err_msg, err, 0);
 }
 
@@ -576,34 +576,33 @@ static void stack_proc(void *arg)
  */
 void do_stack(struct mc_request *req)
 {
-        char *ptr = req->request.data;
-        int pid_requested= -1;
+	char *ptr = req->request.data;
+	int pid_requested= -1;
 	struct task_struct *from = NULL;
 	struct task_struct *to = NULL;
 
-        /* Would be nice:
-         * 1) Send showregs output to mconsole.
+	/* Would be nice:
+	 * 1) Send showregs output to mconsole.
 	 * 2) Add a way to stack dump all pids.
 	 */
 
-        ptr += strlen("stack");
-        while(isspace(*ptr)) ptr++;
+	ptr += strlen("stack");
+	while(isspace(*ptr)) ptr++;
 
-        /* Should really check for multiple pids or reject bad args here */
-        /* What do the arguments in mconsole_reply mean? */
-        if(sscanf(ptr, "%d", &pid_requested) == 0){
-                mconsole_reply(req, "Please specify a pid", 1, 0);
-                return;
-        }
+	/* Should really check for multiple pids or reject bad args here */
+	/* What do the arguments in mconsole_reply mean? */
+	if(sscanf(ptr, "%d", &pid_requested) == 0){
+		mconsole_reply(req, "Please specify a pid", 1, 0);
+		return;
+	}
 
 	from = current;
 
 	to = find_task_by_pid(pid_requested);
-        if((to == NULL) || (pid_requested == 0)) {
-                mconsole_reply(req, "Couldn't find that pid", 1, 0);
-                return;
-        }
-
+	if((to == NULL) || (pid_requested == 0)) {
+		mconsole_reply(req, "Couldn't find that pid", 1, 0);
+		return;
+	}
 	with_console(req, stack_proc, to);
 }
 
@@ -772,14 +771,3 @@ char *mconsole_notify_socket(void)
 }
 
 EXPORT_SYMBOL(mconsole_notify_socket);
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

