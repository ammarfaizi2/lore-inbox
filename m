Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932682AbWHJT73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682AbWHJT73 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932714AbWHJT71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:59:27 -0400
Received: from mail.suse.de ([195.135.220.2]:6545 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932651AbWHJTg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:58 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [99/145] x86_64: Fix sparse warnings in compat aout code
Message-Id: <20060810193657.0A51F13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:57 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/ia32/ia32_aout.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

Index: linux/arch/x86_64/ia32/ia32_aout.c
===================================================================
--- linux.orig/arch/x86_64/ia32/ia32_aout.c
+++ linux/arch/x86_64/ia32/ia32_aout.c
@@ -333,7 +333,8 @@ static int load_aout_binary(struct linux
 			return error;
 		}
 
-		error = bprm->file->f_op->read(bprm->file, (char *)text_addr,
+		error = bprm->file->f_op->read(bprm->file,
+			 (char __user *)text_addr,
 			  ex.a_text+ex.a_data, &pos);
 		if ((signed long)error < 0) {
 			send_sig(SIGKILL, current, 0);
@@ -366,7 +367,8 @@ static int load_aout_binary(struct linux
 			down_write(&current->mm->mmap_sem);
 			do_brk(N_TXTADDR(ex), ex.a_text+ex.a_data);
 			up_write(&current->mm->mmap_sem);
-			bprm->file->f_op->read(bprm->file,(char *)N_TXTADDR(ex),
+			bprm->file->f_op->read(bprm->file,
+					(char __user *)N_TXTADDR(ex),
 					ex.a_text+ex.a_data, &pos);
 			flush_icache_range((unsigned long) N_TXTADDR(ex),
 					   (unsigned long) N_TXTADDR(ex) +
@@ -477,7 +479,7 @@ static int load_aout_library(struct file
 		do_brk(start_addr, ex.a_text + ex.a_data + ex.a_bss);
 		up_write(&current->mm->mmap_sem);
 		
-		file->f_op->read(file, (char *)start_addr,
+		file->f_op->read(file, (char __user *)start_addr,
 			ex.a_text + ex.a_data, &pos);
 		flush_icache_range((unsigned long) start_addr,
 				   (unsigned long) start_addr + ex.a_text + ex.a_data);
