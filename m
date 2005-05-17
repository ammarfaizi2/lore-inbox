Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVEQEiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVEQEiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 00:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVEQEiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 00:38:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:18924 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261323AbVEQEho convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 00:37:44 -0400
Cc: gregkh@suse.de
Subject: [PATCH] fix Linux kernel ELF core dump privilege elevation
In-Reply-To: <20050517043700.GA17349@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 16 May 2005 21:37:48 -0700
Message-Id: <11163046682662@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] fix Linux kernel ELF core dump privilege elevation

As reported by Paul Starzetz <ihaquer@isec.pl>

Reference: CAN-2005-1263

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit a84a505956f5c795a9ab3d60d97b6b91a27aa571
tree 440fdf47fcddf8b0d615667b418981a511d16e30
parent d3f0fcec2d50a18a84c4f3dd7683206ed37ca009
author Greg Kroah-Hartman <gregkh@suse.de> Wed, 11 May 2005 00:10:44 -0700
committer Greg KH <gregkh@suse.de> Mon, 16 May 2005 21:07:05 -0700

 fs/binfmt_elf.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: fs/binfmt_elf.c
===================================================================
--- 6e56e97c81b5b8c4d556ffd90349e73a885a20dc/fs/binfmt_elf.c  (mode:100644)
+++ 440fdf47fcddf8b0d615667b418981a511d16e30/fs/binfmt_elf.c  (mode:100644)
@@ -251,7 +251,7 @@
 	}
 
 	/* Populate argv and envp */
-	p = current->mm->arg_start;
+	p = current->mm->arg_end = current->mm->arg_start;
 	while (argc-- > 0) {
 		size_t len;
 		__put_user((elf_addr_t)p, argv++);
@@ -1301,7 +1301,7 @@
 static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 		       struct mm_struct *mm)
 {
-	int i, len;
+	unsigned int i, len;
 	
 	/* first copy the parameters from user space */
 	memset(psinfo, 0, sizeof(struct elf_prpsinfo));

