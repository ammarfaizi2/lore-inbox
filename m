Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWFTFA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWFTFA4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWFTFA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:00:56 -0400
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:29666 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750866AbWFTFAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:00:55 -0400
Date: Tue, 20 Jun 2006 00:55:24 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [-mm patch] binfmt_elf: fix checks for bad address
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200606200059_MC3-1-C2E8-8C45@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix check for bad address; use macro instead of open-coding two checks.

Taken from RHEL4 kernel update.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.17-32.orig/fs/binfmt_elf.c
+++ 2.6.17-32/fs/binfmt_elf.c
@@ -84,7 +84,7 @@ static struct linux_binfmt elf_format = 
 		.min_coredump	= ELF_EXEC_PAGESIZE
 };
 
-#define BAD_ADDR(x) ((unsigned long)(x) > TASK_SIZE)
+#define BAD_ADDR(x) ((unsigned long)(x) >= TASK_SIZE)
 
 static int set_brk(unsigned long start, unsigned long end)
 {
@@ -394,7 +394,7 @@ static unsigned long load_elf_interp(str
 			 * <= p_memsize so it's only necessary to check p_memsz.
 			 */
 			k = load_addr + eppnt->p_vaddr;
-			if (k > TASK_SIZE ||
+			if (BAD_ADDR(k) ||
 			    eppnt->p_filesz > eppnt->p_memsz ||
 			    eppnt->p_memsz > TASK_SIZE ||
 			    TASK_SIZE - eppnt->p_memsz < k) {
@@ -888,7 +888,7 @@ static int load_elf_binary(struct linux_
 		 * allowed task size. Note that p_filesz must always be
 		 * <= p_memsz so it is only necessary to check p_memsz.
 		 */
-		if (k > TASK_SIZE || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
+		if (BAD_ADDR(k) || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
 		    elf_ppnt->p_memsz > TASK_SIZE ||
 		    TASK_SIZE - elf_ppnt->p_memsz < k) {
 			/* set_brk can never work. Avoid overflows. */
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
