Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314048AbSDVDoJ>; Sun, 21 Apr 2002 23:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314051AbSDVDoI>; Sun, 21 Apr 2002 23:44:08 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:23558 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S314048AbSDVDoI>; Sun, 21 Apr 2002 23:44:08 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] TRIVIAL 2.5.8: clean up fs_exec.c
Date: Mon, 22 Apr 2002 13:47:20 +1000
Message-Id: <E16zUnQ-00016q-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Pool <mbp@samba.org>: trivial kernel patch -- clean up fs_exec.c:

(Included in 2.4)
--- trivial-2.5.8/fs/exec.c.orig	Mon Apr 22 13:42:32 2002
+++ trivial-2.5.8/fs/exec.c	Mon Apr 22 13:42:32 2002
@@ -978,8 +978,7 @@
 	if (current->rlim[RLIMIT_CORE].rlim_cur < binfmt->min_coredump)
 		goto fail;
 
-	memcpy(corename,"core.", 5);
-	corename[4] = '\0';
+	memcpy(corename,"core", 5); /* include trailing \0 */
  	if (core_uses_pid || atomic_read(&current->mm->mm_users) != 1)
  		sprintf(&corename[4], ".%d", current->pid);
 	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW, 0600);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
