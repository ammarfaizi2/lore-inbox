Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbUCZRd7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 12:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUCZRd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 12:33:59 -0500
Received: from math.ut.ee ([193.40.5.125]:25807 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S263609AbUCZRd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 12:33:57 -0500
Date: Fri, 26 Mar 2004 19:33:55 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] asm-ppc/elf.h warning
Message-ID: <Pine.GSO.4.44.0403261425250.2460-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just got this from current 2.6 BK:

  CC      arch/ppc/boot/simple/misc.o
In file included from include/linux/elf.h:5,
                 from arch/ppc/boot/simple/misc.c:20:
include/asm/elf.h:102: warning: `struct task_struct' declared inside parameter list
include/asm/elf.h:102: warning: its scope is only this definition or declaration, which is probably not what you want

This can be cured by either including linux/sched.h or defining
struct task_struct;
(like this - maybe it should be more close to the headers)

===== include/asm-ppc/elf.h 1.10 vs edited =====
--- 1.10/include/asm-ppc/elf.h	Wed Mar 24 04:49:17 2004
+++ edited/include/asm-ppc/elf.h	Fri Mar 26 18:40:42 2004
@@ -99,6 +99,7 @@
 	((t)->thread.regs?					\
 	 ({ ELF_CORE_COPY_REGS((elfregs), (t)->thread.regs); 1; }): 0)

+struct task_struct;
 extern int dump_task_fpu(struct task_struct *t, elf_fpregset_t *fpu);
 #define ELF_CORE_COPY_FPREGS(t, fpu)	dump_task_fpu((t), (fpu))


-- 
Meelis Roos (mroos@linux.ee)



