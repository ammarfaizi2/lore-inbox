Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbULaCJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbULaCJC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 21:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbULaCJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 21:09:02 -0500
Received: from mail.dif.dk ([193.138.115.101]:30923 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261809AbULaCIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 21:08:54 -0500
Date: Fri, 31 Dec 2004 03:20:04 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] add loglevel to a few printk's in arch/m32r/kernel/ptrace.c
In-Reply-To: <Pine.LNX.4.61.0412310310270.4725@dragon.hygekrogen.localhost>
Message-ID: <Pine.LNX.4.61.0412310317250.4725@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0412310310270.4725@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2004, Jesper Juhl wrote:

> 
> Hi, small patch below to add loglevel to a few printk's in arch/m32r/kernel/ptrace.c .
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> diff -up linux-2.6.10-bk2-orig/arch/m32r/kernel/ptrace.c linux-2.6.10-bk2/arch/m32r/kernel/ptrace.c
> --- linux-2.6.10-bk2-orig/arch/m32r/kernel/ptrace.c	2004-12-24 22:35:28.000000000 +0100
> +++ linux-2.6.10-bk2/arch/m32r/kernel/ptrace.c	2004-12-31 03:09:28.000000000 +0100
> @@ -451,7 +451,7 @@ register_debug_trap(struct task_struct *
>  	unsigned long addr = next_pc & ~3;
>  
>  	if (p->nr_trap != 0) {
> -		printk("kernel BUG at %s %d: p->nr_trap = %d\n",
> +		printk("KERN_ERR kernel BUG at %s %d: p->nr_trap = %d\n",
>  					__FILE__, __LINE__, p->nr_trap);

Arrgh, sorry, minor bug here, that should ofcourse be 
printk(KERN_ERR "kernel BUG at %s %d: p->nr_trap = %d\n",

Fixed patch below.

diff -up linux-2.6.10-bk2-orig/arch/m32r/kernel/ptrace.c linux-2.6.10-bk2/arch/m32r/kernel/ptrace.c
--- linux-2.6.10-bk2-orig/arch/m32r/kernel/ptrace.c	2004-12-24 22:35:28.000000000 +0100
+++ linux-2.6.10-bk2/arch/m32r/kernel/ptrace.c	2004-12-31 03:18:56.000000000 +0100
@@ -451,7 +451,7 @@ register_debug_trap(struct task_struct *
 	unsigned long addr = next_pc & ~3;
 
 	if (p->nr_trap != 0) {
-		printk("kernel BUG at %s %d: p->nr_trap = %d\n",
+		printk(KERN_ERR "kernel BUG at %s %d: p->nr_trap = %d\n",
 					__FILE__, __LINE__, p->nr_trap);
 		return -1;
 	}
@@ -585,18 +585,18 @@ embed_debug_trap_for_signal(struct task_
 	pc = get_stack_long(child, PT_BPC);
 	ret = access_process_vm(child, pc&~3, &insn, sizeof(insn), 0);
 	if (ret != sizeof(insn)) {
-		printk("kernel BUG at %s %d: access_process_vm returns %d\n",
+		printk(KERN_ERR "kernel BUG at %s %d: access_process_vm returns %d\n",
 		       __FILE__, __LINE__, ret);
 		return;
 	}
 	compute_next_pc(insn, pc, &next_pc, child);
 	if (next_pc & 0x80000000) {
-		printk("kernel BUG at %s %d: next_pc = 0x%08x\n",
+		printk(KERN_ERR "kernel BUG at %s %d: next_pc = 0x%08x\n",
 		       __FILE__, __LINE__, (int)next_pc);
 		return;
 	}
 	if (embed_debug_trap(child, next_pc)) {
-		printk("kernel BUG at %s %d: embed_debug_trap error\n",
+		printk(KERN_ERR "kernel BUG at %s %d: embed_debug_trap error\n",
 		       __FILE__, __LINE__);
 		return;
 	}



