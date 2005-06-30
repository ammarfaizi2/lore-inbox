Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbVF3WpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbVF3WpR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 18:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbVF3WpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 18:45:16 -0400
Received: from mail.dif.dk ([193.138.115.101]:7404 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262972AbVF3WpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 18:45:04 -0400
Date: Fri, 1 Jul 2005 00:51:06 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
Reply-To: Jesper Juhl <jesper.juhl@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Eric Youngdale <ericy@cais.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH][resend] remove redundant NULL pointer checks in binfmt_elf*
Message-ID: <Pine.LNX.4.62.0507010042470.2858@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resend of a patch I send earlier (Wed, 23 Mar 2005 10:42:24 +0000) in a 
mail with subject "[PATCH] remove NULL checks before kfree in 
binfmt_elf_fdpic.c and binfmt_elf.c".

In a reply mail with Message-ID: <26987.1111574544@redhat.com> 
David Howells wrote :
>
> The FDPIC bit looks okay.
> 
> Acked-By: David Howells <dhowells@redhat.com>


Would you mind merging this?


remove redundant NULL checks before kfree() in fs/binfmt_elf_fdpic.c and
fs/binfmt_elf.c

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/binfmt_elf.c       |    3 +--
 fs/binfmt_elf_fdpic.c |   15 +++++----------
 2 files changed, 6 insertions(+), 12 deletions(-)

--- linux-2.6.13-rc1-orig/fs/binfmt_elf_fdpic.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/fs/binfmt_elf_fdpic.c	2005-07-01 00:37:21.000000000 +0200
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
--- linux-2.6.13-rc1-orig/fs/binfmt_elf.c	2005-06-29 21:45:00.000000000 +0200
+++ linux-2.6.13-rc1/fs/binfmt_elf.c	2005-07-01 00:37:21.000000000 +0200
@@ -1007,8 +1007,7 @@ out_free_dentry:
 	if (interpreter)
 		fput(interpreter);
 out_free_interp:
-	if (elf_interpreter)
-		kfree(elf_interpreter);
+	kfree(elf_interpreter);
 out_free_file:
 	sys_close(elf_exec_fileno);
 out_free_fh:



