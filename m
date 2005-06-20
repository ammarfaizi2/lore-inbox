Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVFTSSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVFTSSQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 14:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVFTSSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 14:18:16 -0400
Received: from 83-70-41-101.b-ras1.prp.dublin.eircom.net ([83.70.41.101]:5074
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261418AbVFTSSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:18:11 -0400
Date: Mon, 20 Jun 2005 19:18:20 +0100 (IST)
From: Telemaque Ndizihiwe <telendiz@eircom.net>
X-X-Sender: telendiz@localhost.localdomain
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Replaces two GOTO statements with one IF_ELSE statement in
 /fs/open.c
Message-ID: <Pine.LNX.4.62.0506201834460.5008@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This Patch replaces two GOTO statements and their corresponding LABELs
with one IF_ELSE statement in /fs/open.c, 2.6.12 kernel.
The patch keeps the same implementation of sys_open system call, it only 
makes the code smaller and easy to read.

Signed-off-by: Telemaque Ndizihiwe <telendiz@eircom.net>


--- linux-2.6.12/fs/open.c.orig	2005-06-20 15:15:52.000000000 +0100
+++ linux-2.6.12/fs/open.c	2005-06-20 15:38:47.580923552 +0100
@@ -945,19 +945,16 @@ asmlinkage long sys_open(const char __us
  		if (fd >= 0) {
  			struct file *f = filp_open(tmp, flags, mode);
  			error = PTR_ERR(f);
-			if (IS_ERR(f))
-				goto out_error;
-			fd_install(fd, f);
+			if (IS_ERR(f)) {
+				put_unused_fd(fd);
+				fd = error;
+			} else {
+				fd_install(fd, f);
+			}
  		}
-out:
  		putname(tmp);
  	}
  	return fd;
-
-out_error:
-	put_unused_fd(fd);
-	fd = error;
-	goto out;
  }
  EXPORT_SYMBOL_GPL(sys_open);

