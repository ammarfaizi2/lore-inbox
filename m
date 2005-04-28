Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVD1CoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVD1CoS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 22:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVD1CoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 22:44:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:28644 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261806AbVD1CoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 22:44:11 -0400
Date: Wed, 27 Apr 2005 19:43:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, ian.pratt@cl.cam.ac.uk
Subject: Re: [PATCH 3/6][XEN][x86] Rename usermode macro
Message-Id: <20050427194343.3d3ffe2f.akpm@osdl.org>
In-Reply-To: <20050426112604.GC26614@snarc.org>
References: <20050426103804.85A7B4BE16@darwin.snarc.org>
	<20050426112604.GC26614@snarc.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk> wrote:
>
> The following patch rename user_mode to user_mode_vm and add a user_mode macro
>  similar to the x86-64 one.

Why didn't your testing pick up the x86_64 build error?

arch/x86_64/oprofile/built-in.o(.text+0x1d09): In function `x86_backtrace':
arch/x86_64/oprofile/../../i386/oprofile/backtrace.c:94: undefined reference to `user_mode_vm'


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/asm-x86_64/ptrace.h |    1 +
 1 files changed, 1 insertion(+)

diff -puN include/asm-x86_64/ptrace.h~xen-x86-rename-usermode-macro-fix include/asm-x86_64/ptrace.h
--- 25/include/asm-x86_64/ptrace.h~xen-x86-rename-usermode-macro-fix	2005-04-27 18:22:12.000000000 -0700
+++ 25-akpm/include/asm-x86_64/ptrace.h	2005-04-27 18:22:12.000000000 -0700
@@ -82,6 +82,7 @@ struct pt_regs {
 
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__) 
 #define user_mode(regs) (!!((regs)->cs & 3))
+#define user_mode_vm(regs) user_mode(regs)
 #define instruction_pointer(regs) ((regs)->rip)
 extern unsigned long profile_pc(struct pt_regs *regs);
 void signal_fault(struct pt_regs *regs, void __user *frame, char *where);
_

