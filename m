Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262286AbVCVXC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVCVXC7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 18:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbVCVXC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 18:02:59 -0500
Received: from mail.dif.dk ([193.138.115.101]:43202 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262286AbVCVXCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 18:02:55 -0500
Date: Wed, 23 Mar 2005 00:04:45 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, Eric Youngdale <ericy@cais.com>
Subject: [PATCH] remove NULL checks before kfree in binfmt_elf_fdpic.c and
 binfmt_elf.c
Message-ID: <Pine.LNX.4.62.0503222359450.2683@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


remove redundant NULL checks before kfree() in fs/binfmt_elf_fdpic.c and 
fs/binfmt_elf.c


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm1-orig/fs/binfmt_elf_fdpic.c	2005-03-21 23:15:43.000000000 +0100
+++ linux-2.6.12-rc1-mm1/fs/binfmt_elf_fdpic.c	2005-03-22 23:59:31.000000000 +0100
@@ -418,16 +418,11 @@ error:
 		allow_write_access(interpreter);
 		fput(interpreter);
 	}
-	if (interpreter_name)
-		kfree(interpreter_name);
-	if (exec_params.phdrs)
-		kfree(exec_params.phdrs);
-	if (exec_params.loadmap)
-		kfree(exec_params.loadmap);
-	if (interp_params.phdrs)
-		kfree(interp_params.phdrs);
-	if (interp_params.loadmap)
-		kfree(interp_params.loadmap);
+	kfree(interpreter_name);
+	kfree(exec_params.phdrs);
+	kfree(exec_params.loadmap);
+	kfree(interp_params.phdrs);
+	kfree(interp_params.loadmap);
 	return retval;
 
 	/* unrecoverable error - kill the process */
--- linux-2.6.12-rc1-mm1-orig/fs/binfmt_elf.c	2005-03-21 23:15:43.000000000 +0100
+++ linux-2.6.12-rc1-mm1/fs/binfmt_elf.c	2005-03-23 00:02:11.000000000 +0100
@@ -1006,8 +1006,7 @@ out_free_dentry:
 	if (interpreter)
 		fput(interpreter);
 out_free_interp:
-	if (elf_interpreter)
-		kfree(elf_interpreter);
+	kfree(elf_interpreter);
 out_free_file:
 	sys_close(elf_exec_fileno);
 out_free_fh:



